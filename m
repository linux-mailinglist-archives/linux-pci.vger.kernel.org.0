Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7990A69CEFB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjBTOJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBTOJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:09:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534E1F5F1;
        Mon, 20 Feb 2023 06:09:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsOfSYma/FIGFwZXQPCTBrBFfYVJGpmFzKaETgaTJyIN/0UXiz6frVQuUlIe4k5KsO73rk185AL4FnCU1Zbxdi33Lsdt6WPy2lidShfn1ZLm2OL2kQ4XRU7N/iGm61S+KsvcmVgG2BKNQT71byCNBqzIYvqa15uTrNOm+1haKTu2+WmcT4DexsHUVa5YPgjAMFOMEsmfqikH3nARNpZ0mBkUPvCdxokAihRO47gl05J5Q6n12M/K6k7+tJrZ6peA7BtjjsQFNpVeTYMium5hHvm+nC2mFgohxOsJtdV0CX0QZCBqlazapYUZy+3VJAD55JLIDFtEmwFD0kXw05bHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMEzL3tJ68Pdej4JMJXZJeQTRXoCepcCtYuVF9WhJaY=;
 b=ghHK5tMk9NHsL1l12ljus2VO+MasLd6PyqnOeHgxQfOBs+wTLeXoXptaUWy9PJ81WhLymqmgW5vVfeY5YGRnGwTDRUFXiSg1GlxRbBveKck0wpdtiVmWswhASedWpE62fvtd2KHIn271C2ViIXOl/YCD5pKCWzr3ZTekmhlbGmQf3RtcAK9ocz7d9eud9HzxGY30Dgf4ypbMwibydSNlyNaGRKV9UxmHoukcwmeQb714emIou7alAFkwMQsohJkVBmI3AQ+gEdUC7m5Y3sPWjmCXibaOIe9lEuDdzb8QZ9AkIn21UXWt1hAzYw5+w2Jl3h0KxRyuibYQSJy6HNRexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMEzL3tJ68Pdej4JMJXZJeQTRXoCepcCtYuVF9WhJaY=;
 b=rJHbuxGVfCX1qPOW3IiLtQYhLX5guwzUf9O+mKWeH8extN8Knp7xt+GP16S69TRkN3lC8A74ptPfmnNl+hpn+STCLp+wZiKGb0lEBKpcn6ciXARaVGkFY2p1xW7VOm9LZc3Y6tdrzT4SjtaYH+BElHq+BDJ4I4S6IYDlpqFfIo0eAEU+glYyq1C/GEuPfekRwPu7rqQ8aOvUXgGvnTq8CQo7/hYh2ha1Q2eA08t49SDg51yRUjd4ZT6i+j8np/uysiuBcsFKKZdM+QPHBsgfzMboGwhnlspkS264KUX+7jgYaDaFk7tolKutHV0P1obmN87CWxtZMvAgr1mM7wU+XQ==
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:08:30 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::58) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 14:08:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:08:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:08:16 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:08:10 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set bandwidth
Date:   Mon, 20 Feb 2023 19:35:57 +0530
Message-ID: <20230220140559.28289-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b185c4-55ba-49cf-861a-08db134bf220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xA9aMxaIywBO1W2ZbjlPA9dA39SIDILMJgyc3s44H/R3F8ruNzv/J3jxi3z90kRWZywcNzydtSPPfVGiGXWtxMs6/KcoO2Yw7EGcCMRItYw0FAj0gGAM8hiwUTkD3OctSYOa42vm9IrlgN6jFX1ubEK30Y06s2ppDiaY2PDMiYpQEwQ7ASsAGQ+KHem+Y9hySjFSdAOFjfpZvTiZj978yB+BdLlpUE0e15nUbmnd5r6G6Zg1BOSiOQh62+2jZth97m2+yf/w8FNfImaelYbu3+MXBNXICE+NR3sbZTGRi4fT5lCu8ErThVv0VbPprbs/w8745mI15lfmGGv9M9xUuBTeQ8PgzVbMTr8NJpQUlwDu+cr8VWddtRfWJ+iDG22KXMiV1ocD56ftKPp+rdroaZE6vV6prnY300QpSQ4YbedctrOKY/0KHBj98vGQjNi74WQarn9rdBpwyigLilE65mNQR/Oo89O4+8M3YgRNF/cm/fykqjkeQ9+AsQAr/j+J++jt6cbgThYsR9QB5aJ8vN+20zwCXM+VMQDNdwUNaHCxh/RZIE3xXeR99ii1Cd6F+AlwweCA+tvVowK3l/I0vT+8ietshVz19MsJpUjz59i5xfZrsQ4fk6Fc8QoSdrhr/DxGxx2AlxDHdKj4U5snC5UdJth7c9cXt7AOiqzdxV10YC+yQFjn9WRXrRqoxlyriYSBlnrk//om1T8VhghRUw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(83380400001)(356005)(2906002)(82740400003)(82310400005)(86362001)(336012)(47076005)(41300700001)(426003)(2616005)(8936002)(7416002)(5660300002)(4326008)(8676002)(70206006)(70586007)(36860700001)(478600001)(40460700003)(7636003)(7696005)(107886003)(1076003)(186003)(6666004)(26005)(316002)(54906003)(110136005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:08:30.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b185c4-55ba-49cf-861a-08db134bf220
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to use OPP table from DT in Tegra194 cpufreq driver.
Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
Cross check the OPP's present in DT against the LUT from BPMP-FW
and enable only those DT OPP's which are present in LUT also.

The OPP table in DT has CPU Frequency to bandwidth mapping where
the bandwidth value is per MC channel. DRAM bandwidth depends on the
number of MC channels which can vary as per the boot configuration.
This per channel bandwidth from OPP table will be later converted by
MC driver to final bandwidth value by multiplying with number of
channels before sending the request to BPMP-FW.

If OPP table is not present in DT, then use the LUT from BPMP-FW
directy as the CPU frequency table and not do the DRAM frequency
scaling which is same as the current behavior.

Now, as the CPU Frequency table is being controlling through OPP
table in DT. Keeping fewer entries in the table will create less
frequency steps and can help to scale fast to high frequencies
when required.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 152 ++++++++++++++++++++++++++---
 1 file changed, 139 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 5890e25d7f77..cda1ab12cdde 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <asm/smp_plat.h>
 
@@ -65,12 +66,32 @@ struct tegra_cpufreq_soc {
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
-	struct cpufreq_frequency_table **tables;
+	struct cpufreq_frequency_table **bpmp_luts;
 	const struct tegra_cpufreq_soc *soc;
+	bool icc_dram_bw_scaling;
 };
 
 static struct workqueue_struct *read_counters_wq;
 
+static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
+{
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+	return ret;
+}
+
 static void tegra_get_cpu_mpidr(void *mpidr)
 {
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
@@ -354,7 +375,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	 * to the last written ndiv value from freq_table. This is
 	 * done to return consistent value.
 	 */
-	cpufreq_for_each_valid_entry(pos, data->tables[clusterid]) {
+	cpufreq_for_each_valid_entry(pos, data->bpmp_luts[clusterid]) {
 		if (pos->driver_data != ndiv)
 			continue;
 
@@ -369,16 +390,93 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	return rate;
 }
 
+int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
+				     struct cpufreq_frequency_table *bpmp_lut,
+				     struct cpufreq_frequency_table **opp_table)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	struct cpufreq_frequency_table *freq_table = NULL;
+	struct cpufreq_frequency_table *pos;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int ret, max_opps;
+	int j = 0;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__, policy->cpu);
+		return -ENODEV;
+	}
+
+	/* Initialize OPP table mentioned in operating-points-v2 property in DT */
+	ret = dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
+	if (!ret) {
+		max_opps = dev_pm_opp_get_opp_count(cpu_dev);
+		if (max_opps <= 0) {
+			dev_err(cpu_dev, "Failed to add OPPs\n");
+			return max_opps;
+		}
+
+		/* Disable all opps and cross-validate against LUT later */
+		for (rate = 0; ; rate++) {
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+			if (IS_ERR(opp))
+				break;
+
+			dev_pm_opp_put(opp);
+			dev_pm_opp_disable(cpu_dev, rate);
+		}
+	} else {
+		dev_err(cpu_dev, "Invalid or empty opp table in device tree\n");
+		data->icc_dram_bw_scaling = false;
+		return ret;
+	}
+
+	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
+	if (!freq_table)
+		return -ENOMEM;
+
+	/*
+	 * Cross check the frequencies from BPMP-FW LUT against the OPP's present in DT.
+	 * Enable only those DT OPP's which are present in LUT also.
+	 */
+	cpufreq_for_each_valid_entry(pos, bpmp_lut) {
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * KHZ, false);
+		if (IS_ERR(opp))
+			continue;
+
+		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
+		if (ret < 0)
+			return ret;
+
+		freq_table[j].driver_data = pos->driver_data;
+		freq_table[j].frequency = pos->frequency;
+		j++;
+	}
+
+	freq_table[j].driver_data = pos->driver_data;
+	freq_table[j].frequency = CPUFREQ_TABLE_END;
+
+	*opp_table = &freq_table[0];
+
+	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+
+	return ret;
+}
+
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	int maxcpus_per_cluster = data->soc->maxcpus_per_cluster;
+	struct cpufreq_frequency_table *freq_table;
+	struct cpufreq_frequency_table *bpmp_lut;
 	u32 start_cpu, cpu;
 	u32 clusterid;
+	int ret;
 
 	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
-
-	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
+	if (clusterid >= data->soc->num_clusters || !data->bpmp_luts[clusterid])
 		return -EINVAL;
 
 	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
@@ -387,9 +485,22 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 		if (cpu_possible(cpu))
 			cpumask_set_cpu(cpu, policy->cpus);
 	}
-	policy->freq_table = data->tables[clusterid];
 	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
 
+	bpmp_lut = data->bpmp_luts[clusterid];
+
+	if (data->icc_dram_bw_scaling) {
+		ret = tegra_cpufreq_init_cpufreq_table(policy, bpmp_lut, &freq_table);
+		if (!ret) {
+			policy->freq_table = freq_table;
+			return 0;
+		}
+	}
+
+	data->icc_dram_bw_scaling = false;
+	policy->freq_table = bpmp_lut;
+	pr_info("OPP tables missing from DT, EMC frequency scaling disabled\n");
+
 	return 0;
 }
 
@@ -406,6 +517,9 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	 */
 	data->soc->ops->set_cpu_ndiv(policy, (u64)tbl->driver_data);
 
+	if (data->icc_dram_bw_scaling)
+		tegra_cpufreq_set_bw(policy, tbl->frequency);
+
 	return 0;
 }
 
@@ -439,8 +553,8 @@ static void tegra194_cpufreq_free_resources(void)
 }
 
 static struct cpufreq_frequency_table *
-init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
-		unsigned int cluster_id)
+tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpmp,
+			    unsigned int cluster_id)
 {
 	struct cpufreq_frequency_table *freq_table;
 	struct mrq_cpu_ndiv_limits_response resp;
@@ -515,6 +629,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	const struct tegra_cpufreq_soc *soc;
 	struct tegra194_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
+	struct device *cpu_dev;
 	int err, i;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -530,9 +645,9 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
-				    sizeof(*data->tables), GFP_KERNEL);
-	if (!data->tables)
+	data->bpmp_luts = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
+				       sizeof(*data->bpmp_luts), GFP_KERNEL);
+	if (!data->bpmp_luts)
 		return -ENOMEM;
 
 	if (soc->actmon_cntr_base) {
@@ -556,15 +671,26 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < data->soc->num_clusters; i++) {
-		data->tables[i] = init_freq_table(pdev, bpmp, i);
-		if (IS_ERR(data->tables[i])) {
-			err = PTR_ERR(data->tables[i]);
+		data->bpmp_luts[i] = tegra_cpufreq_bpmp_read_lut(pdev, bpmp, i);
+		if (IS_ERR(data->bpmp_luts[i])) {
+			err = PTR_ERR(data->bpmp_luts[i]);
 			goto err_free_res;
 		}
 	}
 
 	tegra194_cpufreq_driver.driver_data = data;
 
+	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
+		err = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
+		if (!err)
+			data->icc_dram_bw_scaling = true;
+	}
+
 	err = cpufreq_register_driver(&tegra194_cpufreq_driver);
 	if (!err)
 		goto put_bpmp;
-- 
2.17.1

