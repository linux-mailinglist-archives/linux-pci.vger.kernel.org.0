Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86E840C215
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhIOI44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhIOI4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 04:56:55 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A2C061575;
        Wed, 15 Sep 2021 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GZgd60WrESx2DuwtYGPss1Uw9DuvU+yvrhVYe2f9cRA=; b=sHTDJrIXSoC3UvfuM27ubT+8Hb
        IeW1e9Fb709cL2+CVWNOaIOrEZasdcRv4a9cBKO062xihPNhCqOiYRAz7lP0zPPkU6SsL4VtiB4hY
        ZtId0LmB15NOi8h3uOR5dj7MSq2NwMA2NuU5nJTBgSCCPU7qkdmkkXwIqzJeyiD4oZFfzK2a0LF07
        2rDCtpJE5RsA+kD2jyVDb5fNiARWqlhdZZhB3/AH3rlqcSbcpJYbWjIvJW6J8YDHweJUCkXpHjc20
        UvXGvnDZV8uI59cAiw+Grw82o4Q+GVJodpTs3cgRzwfUMZ8fth3GKBzN8P/waO1hEh0fe7TvpPvKj
        zR/ipvOQ==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1mQQhR-000101-KT; Wed, 15 Sep 2021 11:55:25 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 1/5] thermal: tegra-bpmp: Handle errors in BPMP response
Date:   Wed, 15 Sep 2021 11:55:13 +0300
Message-Id: <20210915085517.1669675-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
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
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 94f1da1dcd69..5affc3d196be 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -52,6 +52,8 @@ static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
 	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
 	if (err)
 		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
 
 	*out_temp = reply.get_temp.temp;
 
@@ -63,6 +65,7 @@ static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
 	struct tegra_bpmp_thermal_zone *zone = data;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	req.type = CMD_THERMAL_SET_TRIP;
@@ -76,7 +79,13 @@ static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
 	msg.tx.data = &req;
 	msg.tx.size = sizeof(req);
 
-	return tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
+	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tz_device_update_work_fn(struct work_struct *work)
@@ -140,6 +149,8 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	err = tegra_bpmp_transfer(bpmp, &msg);
 	if (err)
 		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
 
 	*num_zones = reply.get_num_zones.num;
 
-- 
2.32.0

