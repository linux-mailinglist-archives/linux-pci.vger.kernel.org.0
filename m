Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7095FBA9D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJKSmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJKSmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EF7F099;
        Tue, 11 Oct 2022 11:42:17 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 8so1622376qka.1;
        Tue, 11 Oct 2022 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtG62yJbqIS8I6QUrG+przRY/17aM7QpmVb3R+LpRSg=;
        b=e2UxZkjdHT1/gH9KPu5K9mIPgqAyJ+P/9Q3AnM2oh7crO1Pgm4GlT8rINymylRbreu
         XAfbmh8brx1W5NZfau9uVaqUHOWAUEI8XR1etIHH+h23ZeEnjXXBc0xXhRXqF6AlNsGr
         1+phwmIjU9gG0h/jwO1Y7RKIIoNzlga2sEKX87DdpkJle7dvQUcEqWuflF05fvWEvQot
         eWKVgv8toCT1Tz3qgwmQNj6wByo0Or7aw3jzCLcVqmxudf9D+SffB5XHWx2lOCpQ2ouU
         m1iYsrmOA+LnkkyGZiySuCzsgfGVmbcLYqCZ4gcFVPo14Pw6S+echD7eU9iLGs8ehoSo
         QUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtG62yJbqIS8I6QUrG+przRY/17aM7QpmVb3R+LpRSg=;
        b=PxL+EtDUefZnCDcsYnN/XZC8X0sADDU6rwa97Y8Csquch2x0IBuz3L7MKu6nrEnE59
         giGtClTUX5eEJ8JXLn8xgbXdIjud5zrNNdlt+ntfhoAgoQ4uNJgO2xzmZWF+zqC8c2tN
         SdW6GBPziS9nTERg+pLio6M5GCdTc4EvQ48zjK/HzjrE+sDuwPac0B9j1FoJAe6volfT
         RzExmcOpj5cZ9fGuXIuGvyby9l5GBseoW+sCws42wCog3a6AH4lh1Mw7JmPNO6PrRJct
         WY6taPo/uBPr8BZ73CkweCZ9ueKcySOvUCmqya22c4DqbMSIVA8f6cLehyOPTAUKP2i/
         Z4zw==
X-Gm-Message-State: ACrzQf1LNFvNqLdEVrZV6x+epSWX8WFh8T75Yzn2433jxdcZHWjn9OUY
        j51t22syARvbGdHofbPUp5blSGtG1FM=
X-Google-Smtp-Source: AMsMyM5O7zbQttUz+a7lUjKpe6+4O68+pvNdZSPYmodxGpzocDWp7GUPiIVxzDTOzwDMl5+XVATp0w==
X-Received: by 2002:a05:620a:530a:b0:6df:b743:9671 with SMTP id oo10-20020a05620a530a00b006dfb7439671mr17009906qkn.762.1665513736435;
        Tue, 11 Oct 2022 11:42:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:15 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] PCI: brcmstb: Wait for 100ms following PERST# deassert
Date:   Tue, 11 Oct 2022 14:42:07 -0400
Message-Id: <20221011184211.18128-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Be prudent and give some time for power and clocks to become stable.  As
described in the PCIe CEM specification sections 2.2 and 2.2.1; as well as
PCIe r5.0, 6.6.1.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index a45ce7d61847..39b545713ba0 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1037,8 +1037,15 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	pcie->perst_set(pcie, 0);
 
 	/*
-	 * Give the RC/EP time to wake up, before trying to configure RC.
-	 * Intermittently check status for link-up, up to a total of 100ms.
+	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
+	 * sections 2.2, PCIe r5.0, 6.6.1.
+	 */
+	msleep(100);
+
+	/*
+	 * Give the RC/EP even more time to wake up, before trying to
+	 * configure RC.  Intermittently check status for link-up, up to a
+	 * total of 100ms.
 	 */
 	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
 		msleep(5);
-- 
2.17.1

