Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBC6F2512
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjD2ObC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Apr 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjD2ObB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2023 10:31:01 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6A171C
        for <linux-pci@vger.kernel.org>; Sat, 29 Apr 2023 07:30:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9E1751019580C;
        Sat, 29 Apr 2023 16:30:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6F3464A165; Sat, 29 Apr 2023 16:30:57 +0200 (CEST)
Date:   Sat, 29 Apr 2023 16:30:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v3] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230429143057.GA18415@wunner.de>
References: <20230421025641.655991-1-clementwei90@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025641.655991-1-clementwei90@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 21, 2023 at 10:56:41AM +0800, Rongguang Wei wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (present <= 0 && link_active <= 0) {
> +		ctrl->state = OFF_STATE;
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}

It has occurred to me that we also need to turn off the Power Indicator,
lest it continues blinking after the 5 second interval.  Sorry for not
spotting this earlier.  And I'm thinking that making the state change
conditional on BLINKINGON_STATE would serve clarity.

So could you please amend the above as follows and verify it fixes the
issue for you?

 	if (present <= 0 && link_active <= 0) {
+		if (ctrl->state == BLINKINGON_STATE) {
+			ctrl->state = OFF_STATE;
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      INDICATOR_NOOP);
+		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}

Thanks!

Lukas
