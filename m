Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030F789633
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjHZLLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjHZLKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 07:10:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936ED2123
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 04:10:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bf3f59905so211615666b.3
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693048243; x=1693653043;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RscCfWDw9c63T+sdZkyQR+p1Wc4siTTiyVhc4ustSlk=;
        b=sqy9GVMYqQSGAXhqcnSDscFEiNLlz0oyJUo+gyA3Rs0Emug8kSVkz8/N2gizi3042x
         c622csD+2FbaxqujaIx3xPjoQaUV7K4ehSMQb6wBydpLOnANuXQtdFw49M9L3fROf9Hc
         o5G5hTasasYs74K8Qwq88+qRGtaG4ixa5eymY2VKliLMVy3rBMaPSy50RBivHVteNZYL
         jb2XZGjYqq9SiuY9IGnDVmivcRCTS/dQcv20Qrp6z/KaOi3wb3FPsHLljfSDd2HFn0l5
         0199+nQr8F1lriLjvv05WjxVsmgoTIhQlb06sZ1L5sPTcs5ZJ/5Nq6jLxtBWVQHi9Eu6
         fXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693048243; x=1693653043;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RscCfWDw9c63T+sdZkyQR+p1Wc4siTTiyVhc4ustSlk=;
        b=SNgsS5bgThSwLtPTXkvkGLkMqifYlDef1o8brqrwOg017yU2bj77HF1p4Z1To/TvZQ
         T18nsMyliwqWvstOZn5R1/88ZSt76wAJWkvbKdpP+ANQxf9NqYZQFlkNFm7p3TDCtTXl
         O+SRlCPhaYoCih4qIlxhEfl3WVw8rtmo2AHgK3MLZZ/qhCMstBwzsFE5UwRljI/5EU1T
         Ix5mkReDDBwtVP9O5ON/fYgIXxElJBJPLIlrvGGfuDcBMt5wVlADx0btghgsHR9c+dWe
         WPmldQ40QMyW9ZXaOcSsSt/Zmzpf/zZwvOvr8N2YLqF/bGOvYqclOJp5k0ObvaB/9U22
         jzlQ==
X-Gm-Message-State: AOJu0YyxVc7kg2ZpSEKov56et2y2Y+3mkS8sPmZJrdDZbpgQSh6HrsYp
        JQI71lx39dwe6mGuBWRlFUcV78K8nas=
X-Google-Smtp-Source: AGHT+IH1OR7cJxJ/CFX4j6gPvV4CWKAd/zyFSlJVem6f+5UIa+u7IG6+bJw5MBnzpAFzcZgZv04AmQ==
X-Received: by 2002:a17:906:10c9:b0:9a1:c669:6e66 with SMTP id v9-20020a17090610c900b009a1c6696e66mr9482672ejv.70.1693048242739;
        Sat, 26 Aug 2023 04:10:42 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a9d:3800:1d42:e85f:c31a:dd4f? (dynamic-2a01-0c22-7a9d-3800-1d42-e85f-c31a-dd4f.c22.pool.telefonica.de. [2a01:c22:7a9d:3800:1d42:e85f:c31a:dd4f])
        by smtp.googlemail.com with ESMTPSA id n4-20020a170906688400b0099cf840527csm2039618ejr.153.2023.08.26.04.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 04:10:42 -0700 (PDT)
Message-ID: <99e1891d-cd15-5e7b-6ac8-8c6dc5d138ec@gmail.com>
Date:   Sat, 26 Aug 2023 13:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: [PATCH] PCI/ASPM: fix unexpected behavior when re-enabling L1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After the referenced commit we may see L1 sub-states being active
unexpectedly. Following scenario as an example:
r8169 disables L1 because of known hardware issues on a number of
systems. Implicitly L1.1 and L1.2 are disabled too.
On my system L1 and L1.1 work fine, but L1.2 causes missed
rx packets. Therefore I write 1 to aspm_l1_1.
This removes ASPM_STATE_L1 from the disabled modes and therefore
unexpectedly enables also L1.2. So return to the old behavior.

A comment in the commit message of the referenced change correctly points
out that this behavior is inconsistent with aspm_attr_store_common().
So change aspm_attr_store_common() accordingly.

Fixes: fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver disables L1")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3dafba0b5..6d3788257 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_disable |= ASPM_STATE_L1;
+		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_disable |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
@@ -1251,6 +1251,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 			link->aspm_disable &= ~ASPM_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
+		if (state & ASPM_STATE_L1)
+			link->aspm_disable |= ASPM_STATE_L1SS;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
-- 
2.42.0

