Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65B6F699D
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEDLN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEDLNZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53DA46A1
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso10495614276.0
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198804; x=1685790804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8eu1ExWcZGi2HTEZBe77vdZ0MEOOPTzOKbcruguPAc=;
        b=D+sbYig6Mk04mhuYhK+3MI10DJEiUH2OMA2QN8txeJQAiFrYRxohHh31wutrRJTSQg
         ywX1+iYyjYedTsKjWQWQhDlQaXJYJbGQBJtY3ysm2UQnHPKfsYufAsuHwnh4qt8isKb2
         erwxV5TZs2rFHpD7jtdf31n53kQZA9zf1sSmBlgFD8N4BAxGF5uNNQDNM9srYgOZ/N8L
         I50r+7AQSYxK8nW9dwYCT+sELe/cZfPdnEpuEPciiPgsv49Sfwqzn8SP7YRK5vVaJ5zX
         EAX0x6x7dTkk3uzOlheZv2gTcvFD5pn0r//Ue1KKkcOVLb23o7am3qGeSoMg/tIOXQv8
         lFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198804; x=1685790804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8eu1ExWcZGi2HTEZBe77vdZ0MEOOPTzOKbcruguPAc=;
        b=GVszQPBSNRCX1AXEhGG4NdchyZDF9V1b8ibg8rdW8+4FJUdFMcu9MhpzKBhzamwLHe
         437OTI6xhCV/E/FuRKq2ZPVE1i5yBTa0w6jX3qtMGILYblj15wyVGWIiwLhNTeWpBZa/
         Me67eLfFWW96E9Lz+5TjjzfX/7MoPdz4KTHxT8ZIygMZmc3eu9ujy1KynQuIkFG7ooPs
         IKT+rKqJ041bV8ybRtCsvh3+nTnKgXOTWhaJSYQpmRD5oHs94HnRJnrSddYPYvc41tFg
         B8eo2gB0dhG7Vi9WSTrfvws7+RPcjmCOifcQYbs3wHbG1Fqe++jbXi3eHBF6HbNe3T7r
         uiuA==
X-Gm-Message-State: AC+VfDwYbTV1DdsIHv4z/r5iDmXRwx806nRXgEC48wY58O08QjfXgIlV
        SQmKzrMyfcAt6bwyrVnH6m3sknUn8DNGt7eLuA==
X-Google-Smtp-Source: ACHHUZ699eJaJFCy5BU/26U3oABe5FzU9+FgvTHAtQKoYSbbuEfv56e5wa+zB20urL3PwHlRIG0zrX49a3B64J78FQ==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:9e90:0:b0:b9e:7fbc:15e1 with SMTP
 id p16-20020a259e90000000b00b9e7fbc15e1mr3401201ybq.0.1683198804225; Thu, 04
 May 2023 04:13:24 -0700 (PDT)
Date:   Thu,  4 May 2023 16:42:59 +0530
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230504111301.229358-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-4-ajayagarwal@google.com>
Subject: [PATCH v3 3/5] PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aspm driver does not set ASPM_STATE_L1 bit in
aspm_default when the caller requests L1SS ASPM state. This will
lead to pcie_config_aspm_link() not enabling the requested L1SS
state. Set ASPM_STATE_L1 when driver enables L1ss.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - None

Changelog since v1:
 - Break down the L1 and L1ss handling into separate patches

 drivers/pci/pcie/aspm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4ad0bf5d5838..7c9935f331f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1171,14 +1171,15 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
 		link->aspm_default |= ASPM_STATE_L1;
+	/* L1 PM substates require L1 */
 	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= ASPM_STATE_L1_1;
+		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= ASPM_STATE_L1_2;
+		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.40.1.495.gc816e09b53d-goog

