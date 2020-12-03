Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19D2CE21B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 23:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgLCWwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 17:52:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:14072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLCWwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 17:52:07 -0500
IronPort-SDR: 3MverBu/rPI8S7DO4A+62ZYkMTxXstXe+0xuSyI8WDDKQGz2fXVSFUln4xvlVEVwuDNH0kiZLv
 TH01vWPBIrhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173385212"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="173385212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 14:51:26 -0800
IronPort-SDR: TM4RDT/k+PK8w41GMpuYNI8lUPwcXvCvGaSToq5ONb0PldAMpyVysGIpNYkEgv/MW21t6KJqzC
 xLoRUG3/OVQw==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="550697867"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 14:51:26 -0800
Date:   Thu, 3 Dec 2020 14:51:24 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v2 1/1] PCI: pciehp: Add support for handling MRL events
Message-ID: <20201203225124.GA72369@otc-nc-03>
References: <20201122014203.4706-1-ashok.raj@intel.com>
 <20201122090852.GA29616@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122090852.GA29616@wunner.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas and Bjorn


On Sun, Nov 22, 2020 at 10:08:52AM +0100, Lukas Wunner wrote:
> > @@ -275,6 +302,13 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  		if (link_active)
> >  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> >  				  slot_name(ctrl));
> > +		/*
> > +		 * If slot is closed && ATTN button exists
> > +		 * don't continue, let the ATTN button
> > +		 * drive the hot-plug
> > +		 */
> > +		if (((events & PCI_EXP_SLTSTA_MRLSC) && ATTN_BUTTN(ctrl)))
> > +			return;
> >  		ctrl->request_result = pciehp_enable_slot(ctrl);
> >  		break;
> 
> Hm, if the Attention Button is pressed with MRL still open, the slot is
> not brought up.  If the MRL is subsequently closed, it is still not
> brought up.  I guess the slot keeps blinking and one has to push the
> button to abort the operation, then press it once more to attempt
> another slot bringup.  The spec doesn't seem to say how such a situation
> should be handled. Oh well.
> 
> I'm wondering if this is the right place to bail out:  Immediately
> before the above hunk, the button_work is canceled, so it can't later
> trigger bringup of the slot.  Shouldn't the above check be in the
> code block with the "Turn the slot on if it's occupied or link is up"
> comment?
> 

I have a fix tested on the platform, but I'm wondering if that's exactly
what you had in mind. 

Currently we don't subscribe for PDC events when ATTN exists. So the
behavior is almost similar to this MRL case after ATTN, but the slot is not
ready for hot-add.

- Press ATTN, 
- Slot is empty
- After 5 seconds synthetic PDC arrives.
  but since no presence and no link active, we leave slot in 
  BLINKINGON_STATE, and led keeps blinking

if someone were to add a card after the 5 seconds, no hot-add is processed
since we don't get notifications for PDC events when ATTN exists.

Can we automatically cancel the blinking and return slot back to OFF_STATE?

This way we don't need another button press to first cancel, and restart
add via another button press? 

According to section 6.7.1.5 Attention Button.
Once the power indicator begins blinking, a 5 second abort interval exists 
during which a second depression of the attention button cancels the operation.

If the operation initiated by the attention button fails for any reason, it
is recommended that system software present an error message explaining
failure via a software user interface, or add the error message to system
log.

Seems like we can cancel the blinking and return back to power off state.
Since the attention button press wasn't successful to add anything.?

Alternately we can also choose to subscribe to PDC, but ignore if slot is
in OFF_STATE. So we let ATTN drive the add. But if PDC happens and we are
in BLINKINGON_STATE, then we can process the hot-add? Spec says a software
recommendation, but i think the cancel after 5 seconds seems better?

Cheers,
Ashok
