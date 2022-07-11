Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13538570E0B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiGKXO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGKXO0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 19:14:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2713F2B;
        Mon, 11 Jul 2022 16:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F5A5B81600;
        Mon, 11 Jul 2022 23:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8584FC3411C;
        Mon, 11 Jul 2022 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657581262;
        bh=mMba7gFzAF0TrMtX204scPIT/uUpco94eMziNYXbX3M=;
        h=From:To:Cc:Subject:Date:From;
        b=E5krMtZBm8Fpy2NU2Q4kb3/MzAszbuZPcWJKLGaBi3bYAOaLktzLKzQebeNe+i7g+
         zh/MWBykuSBt7+XemK4mVdws9YaKRVz+5MCtS6FW3Z3eRZL96obQljdqj6Oa9PCl7o
         qgPN0XUKYZCxoNwTEFmuuPeTAPfggXJR7z0RxZOQiF76PoMYCTVoTb7ytIK+V/ip6+
         3Mtm9Lg57jERWh0uV4ovFXDDruNP6rUpJ1Hn9Mx/YJH+XGVeXQnJX34/JKjqHaSCQr
         aVEbNiG4RuLdYZTldAw2rpKU7P5XhFpepOjDFRcKeHhS950TkHvKijfjvBER3Eg3U2
         jUzEhYM1yzFJQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ASPM: Unexport pcie_aspm_support_enabled()
Date:   Mon, 11 Jul 2022 18:14:19 -0500
Message-Id: <20220711231419.706639-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_aspm_support_enabled() is used only by the acpi/pci_root.c driver,
which cannot be built as a module, so it does not need to be exported.
Unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7f76a5875feb..a8aec190986c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1347,4 +1347,3 @@ bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
 }
-EXPORT_SYMBOL(pcie_aspm_support_enabled);
-- 
2.25.1

