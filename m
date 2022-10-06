Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BA5F70E3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiJFWDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiJFWDm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC94014298B;
        Thu,  6 Oct 2022 15:03:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l22so4703424edj.5;
        Thu, 06 Oct 2022 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+F1i8mswqP1sOXLGE0a7iwcDafA7tYx629sD2VumcwM=;
        b=jwBoQvzQ/LxjK8kx7cK6AYwRfB/MWLeaTyoiyxCTogu2djnodPVti9tH75mNWdv8Wl
         RxeehYapXNgU4BocLjtIzM0z237x1gGRdkfNCrmMjTzkru3FAELYmvAddQCdH42XRd0+
         MbFnFjlfPmvrrTi//XXWzKZjN2fdtSzOF6ZHsGwIaW/H7th+rWTqcA2fdvvD7TUfKGRf
         Y3swYaF0YXRTR92WGvEE/B8Lhaq366ram+7yQihSoyRN1W+jbqmWSCpe0xga3cOfpSr9
         Su0JyQLzDK2vDhjFd/R2Thrzz1qRyz9/hZgSjhJmxg2kq6cICkRNaBimVXvlJvpKN2sX
         U5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F1i8mswqP1sOXLGE0a7iwcDafA7tYx629sD2VumcwM=;
        b=QK2rf+7vGGSKcyIV2dp4sgogsgFut76y4DpfRhsHKK2XRafcMsLrqoTvyR+PFXvLf3
         tU9OfphG1oU0kv2enfOFs6C2YPvaEGO5w8FgMtdJLV9NuyDzUne+SYJMCC2bJxy7I67d
         XpWQz/IoPr01FD+Xcq+Vg1m83VihSpc4xeTWGh1oOs5XDu925Tp/6fIb0E71J5CsiDVU
         W+sed7DWMm1J3+7qiwU+YIt1DTBfyrCky69ltDX5LlWxHRjmNQlAUe6AtCkhqPj/ybCJ
         g8o7nknsPFkRFofekWn3F5+EEit6Rkp/9RmrZ7Af+Aex/XBBR7DXwAtvS/y++yMQOo4/
         E8Xw==
X-Gm-Message-State: ACrzQf2lCS+9cgczxbTwfJTfabxN5y1mqbo8ShsgEfcCrqCjym+hmr38
        6/HFvxiQuYFv4aN+8uQdIT9NSrcWK+k=
X-Google-Smtp-Source: AMsMyM45Yyx4Aawv9K44B8BVX+nb7uc1JOiB7C0zFJxGLs97p4qwRQZ60HKSJLscxOirRlc77wpvvQ==
X-Received: by 2002:aa7:db07:0:b0:458:f6e5:ab71 with SMTP id t7-20020aa7db07000000b00458f6e5ab71mr1855183eds.330.1665093815001;
        Thu, 06 Oct 2022 15:03:35 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:34 -0700 (PDT)
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
Subject: [PATCH v1 2/5] PCI: brcmstb: Wait for 100ms following PERST# deassert
Date:   Thu,  6 Oct 2022 18:03:18 -0400
Message-Id: <20221006220322.33000-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006220322.33000-1-jim2101024@gmail.com>
References: <20221006220322.33000-1-jim2101024@gmail.com>
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

