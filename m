Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1172A137E05
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAKKEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 05:04:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27741 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728939AbgAKKEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2020 05:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578737048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+A7qVqL+kOfiotLJYXOYSH7AWSTgiw9QTUBY34scgx4=;
        b=bzENziGGN3yRq7wElvS4CJ/m0uBtlsXdhjMDomQV2+YoJbr3W+MvjnoK1C7ArewTYIdKN6
        P4c2yiMScalJVeJW9Nx1+ZcfuWHwcn99RBN3W3fvnGj+7ew1XjESTvbFaEpNWNpUsPoQwh
        +qsJU0LcVlh77h5gRr7HmSqtx6sWc4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-RDdW0EfqOTaHm80AVpxXOg-1; Sat, 11 Jan 2020 05:04:07 -0500
X-MC-Unique: RDdW0EfqOTaHm80AVpxXOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF24800D41;
        Sat, 11 Jan 2020 10:04:05 +0000 (UTC)
Received: from localhost (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E3A8062A;
        Sat, 11 Jan 2020 10:04:04 +0000 (UTC)
Date:   Sat, 11 Jan 2020 18:04:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     Jerry.Hoemann@hpe.com, Bjorn Helgaas <helgaas@kernel.org>,
        Kairui Song <kasong@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200111100401.GE19291@MiWiFi-R3L-srv>
References: <20200110214217.GA88274@google.com>
 <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net>
 <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv>
 <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/10/20 at 08:45pm, Khalid Aziz wrote:
> >>>>>> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> >>>>>> +	if ((kexec_in_progress || is_kdump_kernel()) &&
> >>>>>> +			pci_dev->current_state <= PCI_D3hot)
> >>>>>>  		pci_clear_master(pci_dev);
> >>>>>
> >>>>> I'm clearly missing something because this will turn off bus mastering
> >>>>> in cases where we previously left it enabled.
> >>>>>
> >>>>> I was assuming the crash was related to a device doing DMA when the
> >>>>> Root Port had bus mastering disabled.  But that must be wrong.
> >>>>>
> >>>>> I'd like to understand the crash/hang better because the quirk
> >>>>> especially is hard to connect to anything.  If the crash is because of
> >>>>> an AER or other PCIe error, maybe another possibility is that we could
> >>>>> handle it better or disable signaling of it or something.
> >>>>>
> >>>>
> >>>> I am not understanding this failure mode either. That code in
> >>>> pci_device_shutdown() was added originally to address this very issue.
> >>>> The patch 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec reboot")
> >>>> shut down any errant DMAs from PCI devices as we kexec a new kernel. In
> >>>> this new patch, this is the same code path that will be taken again when
> >>>> kdump kernel is shutting down. If the errant DMA problem was not fixed
> >>>> by clearing Bus Master bit in this path when kdump kernel was being
> >>>> kexec'd, why does the same code path work the second time around when
> >>>> kdump kernel is shutting down? Is there more going on that we don't
> >>>> understand?
> >>>>
> >>>
> >>>   Khalid,
> >>>
> >>>   I don't believe we execute that code path in the crash case.
> >>>
> >>>   The variable kexec_in_progress is set true in kernel_kexec() before calling
> >>>   machine_kexec().  This is the fast reboot case.
> >>>
> >>>   I don't see kexec_in_progress set true elsewhere.
> >>>
> >>>
> >>>   The code path for crash is different.
> >>>
> >>>   For instance, panic() will call
> >>> 	-> __crash_kexec()  which calls
> >>> 		-> machine_kexec().
> >>>
> >>>  So the setting of kexec_in_progress is bypassed.
> >>>
> >>
> >> True, but what that means is if it is an errant DMA causing the issue
> >> you are seeing, that errant DMA can happen any time between when we
> > 
> > Here, there could be misunderstanding. It's not an errant DMA, it's an
> > device which may be in DMA transporting state in normal kernel, but in
> > kdump kernel it's not manipulated by its driver because we don't use it
> > to dump, so exlucde its driver from kdump initramfs for saving space. 
> > 
> 
> Errant DMA as in currently running kernel did not enable the device to
> do DMA and is not ready for it. If a device can issue DMA request in
> this state, it could do it well before kdump kernel starts shutting
> down. Don't we need to fix this before we start shutting down kdump in
> preparation for reboot? I can see the need for this fix, but I am not
> sure if this patch places the fix in right place.

Ah, I could get your point now, but not very sure. Do you mean the HPSA
is in errant DMA state, because it doesn't have driver to re-initilize
to correct state? 

We have been doing like this for kdump kernel always, to only
include needed devices' driver to kdump initrd so that the driver will
initialize and opearte the device. For other unneeded devices by kdump
kernel, we just leave it as is. This error is only seen on this HPE
owned system. Wondering if HPE can do something to check their
firmware/hardware setting.

This patch is using a quirk to adjust all those devices if its
pci_dev->current_state is beyond PCI_D3hot during bootup. Then clear the
master bit of device firstly, next clear its parent bridge's master bit,
to make reboot proceed further. This need you PCI experts to offer help
to evaluate.

Thanks
Baoquan

