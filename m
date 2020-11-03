Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1CB2A41DE
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgKCK3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 05:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCK3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 05:29:20 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691D3206C0;
        Tue,  3 Nov 2020 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604399359;
        bh=rzmUb4sjt+QRA0E2POcf2NroOr71zccUxg8Mx635fNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w/G6r0Uk6mgYqPET7MBBYYzjknHKzmzytBIILxZ8qHVO8wx/BA6NMqQIFQga+tg8l
         sFev2am4zJyRrrguYfmOkEAKqyIwkywnIPBZ12uFXG4fu/uZHj8FBUXrCOMSgF+h2t
         Ax2/Fe4SRUJnZxebeEhZe+EifH518tuIqCX8scjM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZtYz-00766J-8n; Tue, 03 Nov 2020 10:29:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Nov 2020 10:29:17 +0000
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
In-Reply-To: <87o8ke7njb.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <016e887822baeae42599b910aaa33218@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, frank-w@public-files.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-03 10:16, Thomas Gleixner wrote:
> On Tue, Nov 03 2020 at 09:54, Marc Zyngier wrote:
>> On 2020-11-02 22:18, Thomas Gleixner wrote:
>>> On Mon, Nov 02 2020 at 17:16, Thomas Gleixner wrote:
>>>> On Mon, Nov 02 2020 at 11:30, Marc Zyngier wrote:
>>>>> --- a/drivers/pci/probe.c
>>>>> +++ b/drivers/pci/probe.c
>>>>> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct 
>>>>> pci_bus
>>>>> *bus)
>>>>>   		d = pci_host_bridge_msi_domain(b);
>>>>> 
>>>>>   	dev_set_msi_domain(&bus->dev, d);
>>>>> +	if (!d)
>>>>> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>>>> 
>>>> Hrm, that might break legacy setups (no irqdomain support). I'd 
>>>> rather
>>>> prefer to explicitly tell the pci core at host registration time.
>>> 
>>> s/might break/ breaks /     Just validated :)
>> 
>> For my own edification, can you point me to the failing case?
> 
> Any architecture which selects PCI_MSI_ARCH_FALLBACKS and does not have
> irqdomain support runs into:
> 
> 	if (!d)
> 		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> 
> which in turn makes pci_msi_supported() return 0 and consequently makes
> pci_enable_msi[x]() fail.

I pointer that out in [1], together with a potential fix. Not sure if
anything else breaks though.

Thanks,

         M.

[1] 
https://lore.kernel.org/r/336d6588567949029c52ecfbb87660c1@kernel.org/
-- 
Jazz is not dead. It just smells funny...
