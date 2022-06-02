Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1055753B1E6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiFBDTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 23:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiFBDTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 23:19:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500923CA1C;
        Wed,  1 Jun 2022 20:19:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 137so3621012pgb.5;
        Wed, 01 Jun 2022 20:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNuRE/GAXdxtn6roiJJAyTqusXsj7xkWB9v744C6KtQ=;
        b=UZ9Bgpv8gRre7NiiTeQPFyN1Xh5L4bYRuTD7qkuhK2pcLtngkQIuN131ACsE8hkG+N
         gqzyCkxQFe/NitIvTDpPshsTcBKmCWJgyy4fzNtA0yt2WNR8W/E0kNJ4RO+VmbIQq+My
         hyA/Y9Yiz4Jowbwqk7TNCWrGtjOdpOALOw191BDjtV7N1jYoTf6Q4hACPFcarK5adoCg
         JYAztQ1J+BOEXtPl0DCPubaInsobQtCX+ODsu0T5LOSf+P9gr0rxGims1Xu9vghZM2bd
         KCfloaQlA7xByUWAcbbRclToW6XprxpUqS+XtHXbbBXIatCPHqelIDTZa+yz4U04fiO1
         Y5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNuRE/GAXdxtn6roiJJAyTqusXsj7xkWB9v744C6KtQ=;
        b=Y+nhrSfgTBUNiQJZTTYOV3ohT8QfZXtvQEPhTLqKiKHhkCZ9Zt+u33ZFGkCgV+rKiL
         isNkz2VvKDVzRnuoQ9OYqHZwxxpRaCSOQ4oLBclaBrPHu/b5fHCmsKQqqQsQwG15FGzr
         tkl/iTaWGOP9/4yjyMUm1RljSkd8wFfWovAJ6nTBjl/DQzLJyHhkImoN/xun6E5UV5wG
         oKlpXK11c4KCQCgCyVgP1dDqx2gjRLOG8k3m/8+PzYdWPNz1t/B1WdygeJP2Z6o1IfNr
         zO9ELDC0XXDY2TGWO0ZyBK67ktbbanwWaFl7zU9chUpIHjB65GYJBUlStBESkQrnDlGO
         aCcw==
X-Gm-Message-State: AOAM5329COnZA+O/gbPw/BWPPHJQzP0b654eeRJ/3pvf84ts8Hk1ZNVp
        6Sy2GA4wzENsG02Lun9myh8=
X-Google-Smtp-Source: ABdhPJwJLMaVLD2u2bJY4KVpXbDijKCzOaTpwPMfdI94WT0FcKKy7drYlOlA9HTHThXN4TtxlUI6Jg==
X-Received: by 2002:a63:42:0:b0:3fa:b4d7:eeb5 with SMTP id 63-20020a630042000000b003fab4d7eeb5mr2229233pga.71.1654139978086;
        Wed, 01 Jun 2022 20:19:38 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id iw10-20020a170903044a00b0016188a4005asm2257477plb.122.2022.06.01.20.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:19:37 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Fan Fei <ffclaire1224@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Fix PM error handling in tegra_pcie_config_ep
Date:   Thu,  2 Jun 2022 07:19:08 +0400
Message-Id: <20220602031910.55859-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pm_runtime_enable() will increase power disable depth.
if dw_pcie_ep_init() fails, we should use pm_runtime_disable()
to balance it pm_runtime_enable().
Add missing pm_runtime_disable() for tegra_pcie_config_ep()

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index cc2678490162..d992371a36e6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1949,6 +1949,7 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
 	if (ret) {
 		dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %d\n",
 			ret);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
-- 
2.25.1

