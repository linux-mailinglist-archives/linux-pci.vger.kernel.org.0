Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBE41969B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhI0Oq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 10:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234799AbhI0Oq4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 10:46:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8580060FC2;
        Mon, 27 Sep 2021 14:45:18 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mUrsZ-00DGOU-2N; Mon, 27 Sep 2021 15:45:16 +0100
Date:   Mon, 27 Sep 2021 15:45:14 +0100
Message-ID: <87r1dat6v9.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/3] PCI: Add support in pci_walk_bus() to invoke callback matching RID
In-Reply-To: <4c6d6b57-d868-eccb-7cfb-66008af530bb@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
        <20210920064133.14115-2-kishon@ti.com>
        <8735pzwrq0.wl-maz@kernel.org>
        <49b2ba0c-c69d-266c-5db6-549fab031ffd@ti.com>
        <87mto7unw1.wl-maz@kernel.org>
        <4c6d6b57-d868-eccb-7cfb-66008af530bb@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kishon@ti.com, tglx@linutronix.de, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com, lokeshvutla@ti.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Sep 2021 02:26:09 +0100,
Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
> >>>> -void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> >>>> -		  void *userdata)
> >>>> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> >>>> +		    void *userdata, u32 rid, u32 mask)
> >>>>  {
> >>>>  	struct pci_dev *dev;
> >>>>  	struct pci_bus *bus;
> >>>> @@ -399,13 +401,16 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> >>>>  		} else
> >>>>  			next = dev->bus_list.next;
> >>>>  
> >>>> +		if (mask != 0xffff && ((pci_dev_id(dev) & mask) != rid))
> >>>
> >>> Why the check for the mask? I also wonder whether the mask should apply
> >>> to the rid as well:
> >>
> >> If the mask is set for all 16bits, then there is not going to be two PCIe
> >> devices which gets the same ITS device ID right? So no need for calculating
> >> total number of vectors?
> > 
> > Are we really arguing about the cost of a compare+branch vs some
> > readability? Or is there an actual correctness issue here?
> 
> It is for correctness. So existing pci_walk_bus() doesn't invoke cb based on
> rid. So when we convert to __pci_walk_bus(), existing callers of pci_walk_bus()
> might not invoke cb for some devices without the check.
> > 
> >>>
> >>> 		if ((pci_dev_id(dev) & mask) != (rid & mask))
> > 
> > Because I think the above expression is a lot more readable (and
> > likely more correct) than what you are suggesting.
> 
> That would result in existing pci_walk_bus() behave differently from what was
> before this patch no?
> 
> I'm having something like this below
> 	+#define pci_walk_bus(top, cb, userdata) \
> 	+	 __pci_walk_bus((top), (cb), (userdata), 0x0, 0xffff)
> 
> So if we add only "if ((pci_dev_id(dev) & mask) != (rid & mask))",
> the callback will not be invoked for any devices (other than one
> with rid = 0)

But that *is* the bug, isn't it? If you want to parse all the devices,
a mask of 0 is what you need. The mask defines the bits that you want
to match against the RID you passed as a parameter. If you don't want
to check any bit, don't pass any!

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
