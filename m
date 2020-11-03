Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8749B2A40BF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgKCJy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 04:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCJy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 04:54:26 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C3F2080C;
        Tue,  3 Nov 2020 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604397266;
        bh=+PMSBSh/qsbOxi/PGx0X2fcaxpuGi6w2e85VksrgH70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y5r7zekSZXihQG1+urqGj/cKRCuJEMUjeTlyba1YH27f4KbxZMsInaR1VZArSennh
         s4+p3GyqFuCLDhCcYBUVK2Pn3at2pBqcf0ReYAzF8BMA/iqfIxvh6o4eA7yti2DJMy
         AbyzLu2L9ZI0/yRbD45cLVXezL+6tqzn34eSfSrw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZt1D-0075JQ-RE; Tue, 03 Nov 2020 09:54:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Nov 2020 09:54:23 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <877dr38kt8.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, frank-w@public-files.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-02 22:18, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 17:16, Thomas Gleixner wrote:
>> On Mon, Nov 02 2020 at 11:30, Marc Zyngier wrote:
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus
>>> *bus)
>>>   		d = pci_host_bridge_msi_domain(b);
>>> 
>>>   	dev_set_msi_domain(&bus->dev, d);
>>> +	if (!d)
>>> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>> 
>> Hrm, that might break legacy setups (no irqdomain support). I'd rather
>> prefer to explicitly tell the pci core at host registration time.
> 
> s/might break/ breaks /     Just validated :)

For my own edification, can you point me to the failing case?

> So we really need some other solution and removing the warning is not 
> an
> option. If MSI is enabled then we want to get a warning when a PCI
> device has no MSI domain associated. Explicitly expressing the PCIE
> brigde misfeature of not supporting MSI is way better than silently
> returning an error code which is swallowed anyway.

I don't disagree here, though the PCI_MSI_ARCH_FALLBACKS mechanism
makes it more difficult to establish.

> Whatever the preferred way is via flags at host probe time or flagging
> it post probe I don't care much as long as it is consistent.

Host probe time is going to require some changes in the core PCI api,
as everything that checks for a MSI domain is based on the pci_bus
structure, which is only allocated much later.

I'll have a think.

         M.
-- 
Jazz is not dead. It just smells funny...
