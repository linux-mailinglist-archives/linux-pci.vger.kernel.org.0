Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B385B3D1A05
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhGUWR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhGUWRZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 18:17:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41FC061575;
        Wed, 21 Jul 2021 15:58:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626908280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g16iYNOFmg7Ye9koJws7NBD2FmPxRPrC4hMuQtHAewQ=;
        b=J3BzwTlbERMQPjC5YEXnoHGHn6PvME8var9QR0t4ElGchvo7p8FtAXOWRRE2ljD2Zb/iLg
        J1YfgtwBxOL3NkqLxvxCyzNVPhmeySCAMpKfk2+sfdo0MAGBgOCP2AucIrH+ApZ36VhxfV
        pWvnrlz1fNeL+wkJqUT5t2FLsIr/+26sKHpf4RuEXo0XXsPL81hec8Gcq3Hmpewx8pMF0b
        DvC2vT1BuS4vFole0hKcfr6aWr3TnUHRV42wbKf0ZcrfTH4iMnikHi7+OT6BW0OrjnIS/3
        1qqB2BwxgVp0jNQT/lnNFG5dkgSGmVH616e3qnn2ouklPIjbbbdUDRUGc3s+LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626908280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g16iYNOFmg7Ye9koJws7NBD2FmPxRPrC4hMuQtHAewQ=;
        b=hU+PevnrIeWGtGvWlAQ+HzD4OhAa3enHsT7klL1+VbX7A5TARlVSpgvbK74jTUK0+ap3tm
        oz+kLpZ0mnO8DTAw==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 2/8] PCI/MSI: Mask all unused MSI-X entries
In-Reply-To: <20210721222313.GC676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de> <20210721192650.268814107@linutronix.de> <20210721222313.GC676232@otc-nc-03>
Date:   Thu, 22 Jul 2021 00:57:55 +0200
Message-ID: <87zgufnuks.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

On Wed, Jul 21 2021 at 15:23, Ashok Raj wrote:
> On Wed, Jul 21, 2021 at 09:11:28PM +0200, Thomas Gleixner wrote:
>>  
>> +		addr = pci_msix_desc_addr(entry);
>> +		if (addr)
>> +			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>
> Silly question:
> Do we have to read what the HW has to set this entry->masked? Shouldn't
> this be all masked before we start the setup?

msix_mask_all() is invoked before the msi descriptors are
allocated. msi_desc::masked is actually a misnomer because it's not like
the name suggests a boolean representing the masked state. It's caching
the content of the PCI_MSIX_ENTRY_VECTOR_CTRL part of the corresponding
table entry. Right now this is just using bit 0 (the mask bit), but is
that true forever? So we actually should rename that member to
vector_ctrl or such.

>> +static void msix_mask_all(void __iomem *base, int tsize)
>> +{
>> +	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
>> +	int i;
>>  
>> -		msix_mask_irq(entry, 1);
>> -	}
>> +	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
>> +		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>
> shouldn't we initialize entry->masked here?

How so?

>> +	/* Ensure that all table entries are masked. */
>> +	msix_mask_all(base, tsize);
>> +
>>  	ret = msix_setup_entries(dev, base, entries, nvec, affd);

It's invoked before the msi descriptors are set up. We can of course
setup the descriptors first and then do the masking, but notice that
@nvec is not necessarily the same as the table size.

Thanks,

        tglx
