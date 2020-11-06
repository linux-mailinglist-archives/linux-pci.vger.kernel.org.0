Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6B2A9305
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKFJoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 04:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgKFJoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 04:44:02 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37082208FE;
        Fri,  6 Nov 2020 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604655841;
        bh=Fq5vr3me39TgPqEdPyi7J1Ht4zHrZr1k7irqRaq3p58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JWmwLNgx7xdjdSAA7Zt5fqF+ovmzxs/0PPUI0spUYDgAL+k9Xum41VvWegs8iucsj
         SVPRgrKI+O+pbnCRnpWDGb4386+yawxrTdtdOQwLN3YfjC5dydIbh7WVK2neuchzrS
         OHL8bJVRg2hvo00wckvyy8dTwS95VLRRdShu7h5s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kayHm-0088fx-75; Fri, 06 Nov 2020 09:43:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 09:43:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <87blgbl887.fsf@nanos.tec.linutronix.de>
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
 <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
 <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
 <074d057910c3e834f4bd58821e8583b1@kernel.org>
 <87blgbl887.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, frank-w@public-files.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-05 23:00, Thomas Gleixner wrote:
> On Thu, Nov 05 2020 at 09:20, Marc Zyngier wrote:
>> On 2020-11-04 23:14, Thomas Gleixner wrote:
>>>  	/* Resource alignment requirements */
>>>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>> 
>> If that's the direction of travel, we also need something like this
>> for configuration where the host bridge relies on an external MSI 
>> block
>> that uses MSI domains (boot-tested in a GICv3 guest).
> 
> Some more context would be helpful. Brain fails to decode the logic
> here.

OK, let me try again.

The MSI controller, which is the thing that deals with MSIs in the 
system
(GICv2m, GICv3-ITS, and a number of others), is optional, is not part of 
the
host bridge (it has nothing to do with PCI at all), and the bridge 
driver has
absolutely no idea  whether:

- there is something that provides MSI or not
- that something has successfully been initialised or not (which 
translates
   into an MSI domain being present or not)

This is the case for most ARM systems, and all KVM/arm guests. Booting a 
VM
without MSIs is absolutely trivial, and actually makes sense for some of 
the
smaller guests.

In these conditions, your no_msi attribute doesn't work as is: we can't 
decide
on its value at probe time without extracting all of the OF/ACPI logic 
that
deals with MSI domains from the core code, and making it available to 
the host
bridge drivers for systems that follow that model.

Using the flow you insist on requires parsing the topology twice:

- once to find out whether there is actually a MSI provider registered
   for the host bridge in order to set the no_msi flag

- once to actually be able to store the domain into the pci_bus 
structure,
   as it isn't available at probe time.

My last suggestion is to indicate to the core code that there is a 
*possible*
MSI controller available in the form of a MSI domain. This is still 
suboptimal
compared to checking the presence an MSI domain in core code (my initial
suggestion), but the fallback stuff gets in the way (though I still 
think it
can be made to work).

Anyway, this was my last attempt at addressing the problem. Most people
won't see it. The couple of drivers that require the fallback hack are
usually selected in distro kernels, and do a good job hiding the error.

         M.
-- 
Jazz is not dead. It just smells funny...
