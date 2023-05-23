Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F204A70E0BC
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjEWPko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjEWPko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 11:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939FFA
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 08:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5598D62F06
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 15:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83557C433EF;
        Tue, 23 May 2023 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684856441;
        bh=MoIsRj/PPHRiYTXs/Jc2UkAP54HM0Bq45GfmfuFKGi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i3MbALkACSqfcRGc+1TL36rjbGEFp7toqh2mZJWA/Cigk9v4IzMEWq+6KKpkKu8Jg
         o1gs4Pv/SkuxzMLEEFsyZmacw573nKi2ccHLGQc3NUKPVlTM1Y+YukASkIFI6omBSL
         MpH/i+h8s/DDaBQzdH2eWCC22O5HzRe90UZnQ2fLvFIM+xvZvcxxDVUWjqy651Hu6U
         Q5A0UePSbwOljciu6c3HD7uWT6NXwmhd8fDDIqOZXfI/8vjPiC15U7zFQXxnJFcJde
         83NBxqQwESZZ8jD+G+CgCNjzrtS0LFaPukaUS8v0qhbW5hb6KpAZDckyBAamCoX4dp
         JpQnGBwIXct6A==
Date:   Tue, 23 May 2023 10:40:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Rongguang Wei <clementwei90@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: pciehp: Simplify Attention Button logging
Message-ID: <ZGzedx3zZ0exN6C9@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523052957.GB30083@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 07:29:57AM +0200, Lukas Wunner wrote:
> On Mon, May 22, 2023 at 04:40:51PM -0500, Bjorn Helgaas wrote:
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -164,15 +164,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
> >  	switch (ctrl->state) {
> >  	case OFF_STATE:
> >  	case ON_STATE:
> > -		if (ctrl->state == ON_STATE) {
> > +		if (ctrl->state == ON_STATE)
> >  			ctrl->state = BLINKINGOFF_STATE;
> > -			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
> > -				  slot_name(ctrl));
> > -		} else {
> > +		else
> >  			ctrl->state = BLINKINGON_STATE;
> > -			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
> > -				  slot_name(ctrl));
> > -		}
> > +		ctrl_info(ctrl, "Slot(%s): Button press: powering %s\n",
> > +			  slot_name(ctrl),
> > +			  ctrl->state == BLINKINGON_STATE ? "on" : "off");
> 
> This results in double checks of ctrl->state (because the ctrl_info()
> is pulled out of the if/else statement), so is slightly less
> efficient than before.  Not a huge issue, but noting nonetheless.
> 
> I think the "powering on" (and "powering off") message is (and
> has always been) confusing because it's present participle, yet
> the powering on / off occurs in the future, hence "powering on in 5 sec"
> or "will power on" or "power on pending" would probably be more
> more correct.

Absolutely right on both counts; thank you very much!

I was trying to make it OFF/ON case parallel to the BLINKING case that
only has one ctrl_info(), but I think that makes it a little harder to
read in addition to being less efficient.

And the language is definitely confusing.   How about this?


@@ -166,11 +166,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
 	case ON_STATE:
 		if (ctrl->state == ON_STATE) {
 			ctrl->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
+			ctrl_info(ctrl, "Slot(%s): Button press: will power off in 5 sec\n",
 				  slot_name(ctrl));
 		} else {
 			ctrl->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
+			ctrl_info(ctrl, "Slot(%s): Button press: will power on in 5 sec\n",
 				  slot_name(ctrl));
 		}
 		/* blink power indicator and turn off attention */
@@ -185,22 +185,23 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
 			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
 					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power off\n",
+				  slot_name(ctrl));
 		} else {
 			ctrl->state = OFF_STATE;
 			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power on\n",
+				  slot_name(ctrl));
 		}
-		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
-			  slot_name(ctrl));
 		break;
