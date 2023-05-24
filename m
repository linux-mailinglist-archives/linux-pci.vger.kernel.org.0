Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEAA70F3BD
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 12:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEXKI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEXKI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 06:08:26 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C37C0
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 03:08:24 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1EA4E2800081C;
        Wed, 24 May 2023 12:08:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 13C58313759; Wed, 24 May 2023 12:08:23 +0200 (CEST)
Date:   Wed, 24 May 2023 12:08:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: pciehp: Simplify Attention Button logging
Message-ID: <20230524100823.GA23020@wunner.de>
References: <20230523052957.GB30083@wunner.de>
 <ZGzedx3zZ0exN6C9@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzedx3zZ0exN6C9@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 10:40:39AM -0500, Bjorn Helgaas wrote:
> I was trying to make it OFF/ON case parallel to the BLINKING case that
> only has one ctrl_info(), but I think that makes it a little harder to
> read in addition to being less efficient.
> 
> And the language is definitely confusing.   How about this?

Perfect, feel free to add my

Reviewed-by: Lukas Wunner <lukas@wunner.de>

to commit 6d433b9ddfda on pci/hotplug.

Thanks a lot!

Lukas

> @@ -166,11 +166,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  	case ON_STATE:
>  		if (ctrl->state == ON_STATE) {
>  			ctrl->state = BLINKINGOFF_STATE;
> -			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
> +			ctrl_info(ctrl, "Slot(%s): Button press: will power off in 5 sec\n",
>  				  slot_name(ctrl));
>  		} else {
>  			ctrl->state = BLINKINGON_STATE;
> -			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
> +			ctrl_info(ctrl, "Slot(%s): Button press: will power on in 5 sec\n",
>  				  slot_name(ctrl));
>  		}
>  		/* blink power indicator and turn off attention */
> @@ -185,22 +185,23 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  		 * press the attention again before the 5 sec. limit
>  		 * expires to cancel hot-add or hot-remove
>  		 */
> -		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
>  		cancel_delayed_work(&ctrl->button_work);
>  		if (ctrl->state == BLINKINGOFF_STATE) {
>  			ctrl->state = ON_STATE;
>  			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
>  					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
> +			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power off\n",
> +				  slot_name(ctrl));
>  		} else {
>  			ctrl->state = OFF_STATE;
>  			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
>  					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
> +			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power on\n",
> +				  slot_name(ctrl));
>  		}
> -		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
> -			  slot_name(ctrl));
>  		break;
