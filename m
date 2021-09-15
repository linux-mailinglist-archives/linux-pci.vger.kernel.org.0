Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5F40C21E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhIOI45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhIOI4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 04:56:55 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC1C061766;
        Wed, 15 Sep 2021 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Nj98s3EHUx3iqSgi/bRE9TqLMNdwT/CPsJyFopIdi7s=; b=eRhSKVaX/dw5hjme5k8oHXopY6
        46Wy+9J78T8H0iB3hHUiAIHDkfgCWrmfL0Dc5q/OZwwxgczw0y/l9YjFvXcU2az8IvzoUSdJTFC1V
        GWDzz/ShDiWYfr4us5Xs3sDJGGwWnZouUib9D6+EkbbX8xgA/QC+ckOy+oBzDTTbt4FG885Xw22cm
        U6JKNSp0vN9W19lBSFOJoqmqn746GbXPdCu+421UwXQitdyby96ueJzp+I9Esz7VHzvIm3LR78u76
        V2Aw035ozcu6R38Sm8Bqi+eOEEnpH8RjmnzEz0k2cR9F3NSEnBj9CInXt0Sz0Kbm5bhRLa0hQ/Gu8
        AhE+TB8A==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1mQQhR-000101-SY; Wed, 15 Sep 2021 11:55:25 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 4/5] cpufreq: tegra186/tegra194: Handle errors in BPMP response
Date:   Wed, 15 Sep 2021 11:55:16 +0300
Message-Id: <20210915085517.1669675-4-mperttunen@nvidia.com>
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

While at it, explicitly handle missing CPU clusters, which can
occur on floorswept chips. This worked before as well, but
possibly only by accident.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 4 ++++
 drivers/cpufreq/tegra194-cpufreq.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 5d1943e787b0..6c88827f4e62 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -159,6 +159,10 @@ static struct cpufreq_frequency_table *init_vhint_table(
 		table = ERR_PTR(err);
 		goto free;
 	}
+	if (msg.rx.ret) {
+		table = ERR_PTR(-EINVAL);
+		goto free;
+	}
 
 	for (i = data->vfloor; i <= data->vceil; i++) {
 		u16 ndiv = data->ndiv[i];
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index a9620e4489ae..ac381db25dbe 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -242,7 +242,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 
 	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
 
-	if (cl >= data->num_clusters)
+	if (cl >= data->num_clusters || !data->tables[cl])
 		return -EINVAL;
 
 	/* set same policy for all cpus in a cluster */
@@ -310,6 +310,12 @@ init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
 	err = tegra_bpmp_transfer(bpmp, &msg);
 	if (err)
 		return ERR_PTR(err);
+	if (msg.rx.ret == -BPMP_EINVAL) {
+		/* Cluster not available */
+		return NULL;
+	}
+	if (msg.rx.ret)
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Make sure frequency table step is a multiple of mdiv to match
-- 
2.32.0

