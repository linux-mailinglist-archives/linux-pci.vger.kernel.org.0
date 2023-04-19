Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44386E7448
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDSHsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDSHsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 03:48:36 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2D97
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 00:48:34 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 16B3B100DA1A4;
        Wed, 19 Apr 2023 09:48:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E7857D39B8; Wed, 19 Apr 2023 09:48:32 +0200 (CEST)
Date:   Wed, 19 Apr 2023 09:48:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230419074832.GA28243@wunner.de>
References: <20230403054619.19163-1-clementwei90@163.com>
 <20230416151826.GA13954@wunner.de>
 <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
 <20230417071125.GA4930@wunner.de>
 <2c288cac-cc3b-09cb-efbb-2e07f3b16fe6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c288cac-cc3b-09cb-efbb-2e07f3b16fe6@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 19, 2023 at 10:58:33AM +0800, Rongguang Wei wrote:
> I test the 1-line change and it make the test failed. The dmesg like this:
> 
> pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
> pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering off due to button press
> pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
> pcieport 0000:00:01.5: pciehp: Slot(0-5): Ignoring invalid state 0x4
[...]
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..462a61fc7313 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -256,7 +256,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (present <= 0 && link_active <= 0) {
> +		ctrl->state = POWEROFF_STATE;
>  		mutex_unlock(&ctrl->state_lock);

My apologies, I made a mistake.  I meant OFF_STATE, not POWEROFF_STATE.
Could you try that, without the addition below:

> +		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>  		return;
>  	}

Sorry again and thanks,

Lukas
