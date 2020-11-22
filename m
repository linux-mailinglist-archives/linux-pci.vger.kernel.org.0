Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22E2BC2FD
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKVBbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 20:31:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:1807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgKVBbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Nov 2020 20:31:36 -0500
IronPort-SDR: ljH3ejHLzpP8rVfL/Xm6KAmkKdas+2YrsM7UJgj1R76ISGTHJGuPZEV20m1Ix2be9C6nsCwbkR
 kE0tTp4bQuSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="158664600"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="158664600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 17:31:35 -0800
IronPort-SDR: qyGWI5X6geDxp1ZRkpQOjhl4RdZlIwmS8/MqBHu146PR30+d+qahky4MosNxDl+qVYovoUcPrb
 7DDCmMdepb0g==
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="331778054"
Received: from araj-mobl1.jf.intel.com ([10.252.131.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 17:31:35 -0800
Date:   Sat, 21 Nov 2020 17:31:33 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201122013133.GA22190@araj-mobl1.jf.intel.com>
References: <20200925230138.29011-1-ashok.raj@intel.com>
 <20201119075120.GA542@wunner.de>
 <20201119220807.GB102444@otc-nc-03>
 <20201121111050.GA6854@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121111050.GA6854@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 21, 2020 at 12:10:50PM +0100, Lukas Wunner wrote:
> 
> > > > +	/*
> > > > +	 * If ATTN is present and MRL is triggered
> > > > +	 * ignore the Presence Change Event.
> > > > +	 */
> > > > +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> > > > +		events &= ~PCI_EXP_SLTSTA_PDC;
> > > 
> > > An Attention Button press results in a synthesized PDC event after
> > > 5 seconds, which may get lost due to the above if-statement.
> > 
> > When its synthesized you don't get the MRLSC? So we won't nuke the PDC then
> > correct?
> 
> I just meant to say, pciehp_queue_pushbutton_work() will synthesize
> a PDC event after 5 seconds and with the above code snippet, if an
> MRL event happens simultaneously, that synthesized PDC event would
> be lost.  So I'd just drop the above code snippet.  I think you
> just need to subscribe to MRL events and propagate them to
> pciehp_handle_presence_or_link_change().  There, you'd bring down
> the slot if an MRL event has occurred (same as DLLSC or PDC).
> Then, check whether MRL is closed.  If so, and if presence or link
> is up, try to bring up the slot.
> 
> If the MRL is open when slot or presence has gone up, the slot is not
> brought up.  But once MRL is closed, there'll be another MRL event and
> *then* the slot is brought up.
> 

Sounds good.. I'll send the update patch.
