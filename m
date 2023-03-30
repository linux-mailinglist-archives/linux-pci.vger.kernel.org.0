Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C86D06FE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjC3NgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjC3NgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:36:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EBAA268;
        Thu, 30 Mar 2023 06:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPwgP+ksHkLDc3UCmu62F6ATCy1pn3xPf1meft8r/wzgQgVfgeHOOfnkBj5eZcmA5/0qD6q/kehbgSZHuVUYNV1ESeMyEjn9SXxxTEF6iCi/O0XhKtL2UxSmZ7gY5Q/a9swPGJRSnEkZx+qdgIiQBgCMRffYSdOXMKrIBB9CR1U8qIyCiJd6GHjS8N4HY9P6CjPvyZg5dPMsISQKjRlA93UWDGamgxCDhaXV5PBGWAZosXogfcxB4nhwaX1ULvWKIjjgVdWCvYjlxrw8L2gbfKDNr027nH9RfXp368yR4PGLQ2FfdIThjKuyc16018ryX3gMCVUZYf6UMrYuIvydGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSL0tSeKRavrPoWu4zSxlgLh06KAImtspwJWfUPGZSM=;
 b=L9xstYWys3cntQMxva2RwB6w4WEzeNUvnR9lBJ9zoRwFnHZrnNSi+fQeb27zfup2aFf23GYG1S5L/8Id2XPY46DJNfB74HAG3SZpSLqgsEvdgVTCjthvlvG8RQzEcogM4OWepZ6jqpoQ+KWiiQ825LAYKDgdk/Q1g8RRnFBozzVTQbG/20tbsAs0WrqMVqj6o2Ep/SEbEVodqYXMGGFChh+F8G+A8KjYnsdAsxV3bXMTOp0ZO1GyXmX7djcrlVCGPYAQSr9K6rAjGZvkW7b+WvJqnBcXK7YdIWGMn51iDR2nMH4vR4NXJ8F9jIrjPuk6QvxBJ+wYO008B+f8NMn7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSL0tSeKRavrPoWu4zSxlgLh06KAImtspwJWfUPGZSM=;
 b=SlaZSjo/Bw5SIhMS+GyxR0ypptih3LpzKruL2Ap5M2f0V8rnrfnjA3oZ+aovqYBA/BuwQTehoW+ut9zViySDkB/dC5apy3Z4dXiZhVlKQmXPRXNMe0SNKMU0Ylz8BN6cwUowVGppKR/23WtBt33LIjyouzCmgpvAXUwKir/wyNbW18hWjE8oGhYhDlz1PmSM0j0qoCS+/1QOieELhDgPhQNQTFt40/hQPwOo4VL3F3KMvgk7E2wYxyjd1RYd4UCgoouRKPHny9XCiNO8bVg4z1qqH1gmhoHCUvKkSOSXBxWxR8AJN9mbiY3siNQkBiF4vHGvM9uhewD6P1zZJ0VGpA==
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 13:35:42 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::b6) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:35:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:35:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:35:23 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:35:17 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v5 6/8] cpufreq: tegra194: add OPP support and set bandwidth
Date:   Thu, 30 Mar 2023 19:03:52 +0530
Message-ID: <20230330133354.714-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 77300a39-b892-45b7-f1e4-08db3123a8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7Z0BkVlsE2ff1R0KmXvkDUU3GETKUKmONr73E6nxsjJSw+nO6o3t/S5fc/d7uXLNzBSaBiLaUWF8lBWn8oX39ow0vl16bjb90SNq4MW0yiYz6hkuUZwYvvWUOlXrtf9HjJvaKosQmPjkeSFlskqK5l9mxuUMfBkWZNj5+I3fTa3BT7+bRmECa95Pxx4BIfWmW75RcCkCE41Mp8Jv7t7sGVJI2ZloNFllPpTK41rdalC+XVxFEjzlYLmeROlqxTt4j1ewkQICiVrTK8v4xqHG/MgQu47bi+cSNkGczd6GnOgYLuXbtEH9uDqtal+8YDxX/FyLE/yMssqHBfUxA6x6QLk9ucx4t1r4LKTOjZnmDQ2yEL51bt8g9CIY1ZjK6lyAbw2Nd5OC01oB2CNXLFRtPmbmIFWaSL7EOXsAxn+D8vWo7KMBkR1SuG4Q8IK1kOsgHICfl3xxiiJHweHys6BoG9exQfpofiolHhpRLI6RMwB72Z3Hd+aeGhmAzx+7wnu3+gDR0RgMeA+ypWiKWIlOyP1CaKnEOE5zTB9Cc6Ka5QBskGPE5XCBeK+UOtfjxJyIMaNKxoQhD7fLJNLQBnvXotL2wlgOvGBqW1PpBsv/bVItNjJk6Hbopa1z3GlytN3Po8NfQAnH1hy5wnMR6bjoBmRZeKqmdYNQclpD4rjSVsclisVjfbspGhu/KqEXRcveZx5AbZ4xHoqzswc/Lq6HrNnXjsK6y94tAMjfJxeNe2xIC0Qua0P2WlKJ4hFdIfi
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(36860700001)(40480700001)(54906003)(110136005)(4326008)(356005)(8676002)(41300700001)(2906002)(7636003)(70586007)(316002)(186003)(70206006)(1076003)(426003)(83380400001)(2616005)(47076005)(336012)(7696005)(107886003)(478600001)(6666004)(26005)(82740400003)(82310400005)(36756003)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:42.7039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77300a39-b892-45b7-f1e4-08db3123a8d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/cpufreq/tegra194-cpufreq.c | 156 ++++++++++++++++++++++++++---
 1 file changed, 143 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 5890e25d7f77..c8d03346068a 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <asm/smp_plat.h>
 
@@ -65,12 +66,36 @@ struct tegra_cpufreq_soc {
 
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
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
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
+	if (ret)
+		data->icc_dram_bw_scaling = false;
+
+	dev_pm_opp_put(opp);
+	return ret;
+}
+
 static void tegra_get_cpu_mpidr(void *mpidr)
 {
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
@@ -354,7 +379,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	 * to the last written ndiv value from freq_table. This is
 	 * done to return consistent value.
 	 */
-	cpufreq_for_each_valid_entry(pos, data->tables[clusterid]) {
+	cpufreq_for_each_valid_entry(pos, data->bpmp_luts[clusterid]) {
 		if (pos->driver_data != ndiv)
 			continue;
 
@@ -369,16 +394,93 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	return rate;
 }
 
+static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
+					    struct cpufreq_frequency_table *bpmp_lut,
+					    struct cpufreq_frequency_table **opp_table)
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
@@ -387,9 +489,22 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
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
 
@@ -406,6 +521,9 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	 */
 	data->soc->ops->set_cpu_ndiv(policy, (u64)tbl->driver_data);
 
+	if (data->icc_dram_bw_scaling)
+		tegra_cpufreq_set_bw(policy, tbl->frequency);
+
 	return 0;
 }
 
@@ -439,8 +557,8 @@ static void tegra194_cpufreq_free_resources(void)
 }
 
 static struct cpufreq_frequency_table *
-init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
-		unsigned int cluster_id)
+tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpmp,
+			    unsigned int cluster_id)
 {
 	struct cpufreq_frequency_table *freq_table;
 	struct mrq_cpu_ndiv_limits_response resp;
@@ -515,6 +633,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	const struct tegra_cpufreq_soc *soc;
 	struct tegra194_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
+	struct device *cpu_dev;
 	int err, i;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -530,9 +649,9 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
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
@@ -556,15 +675,26 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
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

