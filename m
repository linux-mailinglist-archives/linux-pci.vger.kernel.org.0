Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7675F70D32B
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjEWFaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 01:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjEWFaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 01:30:00 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F24110
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 22:29:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CAF5E28007E22;
        Tue, 23 May 2023 07:29:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BEC6128DC1A; Tue, 23 May 2023 07:29:57 +0200 (CEST)
Date:   Tue, 23 May 2023 07:29:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: pciehp: Simplify Attention Button logging
Message-ID: <20230523052957.GB30083@wunner.de>
References: <20230522214051.619337-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522214051.619337-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 04:40:51PM -0500, Bjorn Helgaas wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -164,15 +164,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  	switch (ctrl->state) {
>  	case OFF_STATE:
>  	case ON_STATE:
> -		if (ctrl->state == ON_STATE) {
> +		if (ctrl->state == ON_STATE)
>  			ctrl->state = BLINKINGOFF_STATE;
> -			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
> -				  slot_name(ctrl));
> -		} else {
> +		else
>  			ctrl->state = BLINKINGON_STATE;
> -			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
> -				  slot_name(ctrl));
> -		}
> +		ctrl_info(ctrl, "Slot(%s): Button press: powering %s\n",
> +			  slot_name(ctrl),
> +			  ctrl->state == BLINKINGON_STATE ? "on" : "off");

This results in double checks of ctrl->state (because the ctrl_info()
is pulled out of the if/else statement), so is slightly less
efficient than before.  Not a huge issue, but noting nonetheless.

I think the "powering on" (and "powering off") message is (and
has always been) confusing because it's present participle, yet
the powering on / off occurs in the future, hence "powering on in 5 sec"
or "will power on" or "power on pending" would probably be more
more correct.

Thanks,

Lukas
