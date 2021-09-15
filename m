Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D797F40C213
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhIOI4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOI4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 04:56:55 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4BDC061574;
        Wed, 15 Sep 2021 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XhloAPC2I8/41lQmFoV1eMdpU5YKO5vemGoN7QpTFKE=; b=FC3h6A0aFwKbnrSpdKgYbZ56SU
        YFwQGBOznST8BGnb0HWM5ck45b9iR/2UlttjuJEIM6PgprEBakVTsxbR/wxnfIpzMHPdSDXgU64bV
        g07G3zSthmjg3NJV9UNFx4KMiDyyQqoa2mUtRLhnTympJYsoa+PMf4H6m+/ysKDsHx401QkqgzF4M
        eI7sRmZUHDgMFDE3ZqdJTcmDNi2JrvTOWIqqf3sMtKNyY7khakXORIAiXDQ9Y96BtIiFqwJ1ybRWW
        pDMJErGvSrYCrL4HmlYvUkCaPPcXzcZQ1nl2GI3iXIR4aPrv8xaaya707HevFsThX4rI8n23he8ei
        D2OCzWDA==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1mQQhR-000101-QA; Wed, 15 Sep 2021 11:55:25 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 3/5] memory: tegra186-emc: Handle errors in BPMP response
Date:   Wed, 15 Sep 2021 11:55:15 +0300
Message-Id: <20210915085517.1669675-3-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210915085517.1669675-1-mperttunen@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value from tegra_bpmp_transfer indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.
Add code to do this.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/memory/tegra/tegra186-emc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index d65e7c2a580b..abc0c2eeaab7 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -197,6 +197,10 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to EMC DVFS pairs: %d\n", err);
 		goto put_bpmp;
 	}
+	if (msg.rx.ret < 0) {
+		dev_err(&pdev->dev, "EMC DVFS MRQ failed: %d (BPMP error code)\n", msg.rx.ret);
+		goto put_bpmp;
+	}
 
 	emc->debugfs.min_rate = ULONG_MAX;
 	emc->debugfs.max_rate = 0;
-- 
2.32.0

