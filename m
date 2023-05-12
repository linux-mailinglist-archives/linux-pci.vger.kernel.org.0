Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741266FFFDA
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 07:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjELFUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjELFUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 01:20:16 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3B2D4D
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 22:20:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0E44E3000253C;
        Fri, 12 May 2023 07:20:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 01CC81AAC67; Fri, 12 May 2023 07:20:12 +0200 (CEST)
Date:   Fri, 12 May 2023 07:20:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230512052012.GA7481@wunner.de>
References: <20230512021518.336460-1-clementwei90@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512021518.336460-1-clementwei90@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 10:15:18AM +0800, Rongguang Wei wrote:
> pciehp's behavior is incorrect if the Attention Button is pressed
> on an unoccupied slot.
[...]
> V2: Update to simple code and avoid gratuitous message.
> V3: Add Suggested-by.
> V4: Add state change conditional and message.
> 
> Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
> Link: https://lore.kernel.org/linux-pci/20230403054619.19163-1-clementwei90@163.com/
> Link: https://lore.kernel.org/linux-pci/20230421025641.655991-1-clementwei90@163.com/

The changes from previous versions of the patch as well as the links to
those previous versions are usually placed below the three dashes.
That way they don't become part of the git history as they're generally
not interesting for future readers.  (The exception of that rule is the
gpu subsystem which habitually puts the changelog in the commit message.)

However I don't think you need to respin the patch because of that as
Bjorn can fix up the commit message when applying.  Just so you know
for future submissions.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+

Thanks!

Lukas

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..32baba1b7f13 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (present <= 0 && link_active <= 0) {
> +		if (ctrl->state == BLINKINGON_STATE) {
> +			ctrl->state = OFF_STATE;
> +			cancel_delayed_work(&ctrl->button_work);
> +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +					      INDICATOR_NOOP);
> +			ctrl_info(ctrl, "Slot(%s): Card not present\n",
> +				  slot_name(ctrl));
> +		}
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
> -- 
> 2.25.1
