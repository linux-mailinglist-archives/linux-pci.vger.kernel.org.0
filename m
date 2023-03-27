Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03346CAA58
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjC0QRy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjC0QRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:17:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31B59FF;
        Mon, 27 Mar 2023 09:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgKogzMkukzKWSX7l11C1VLjzFtx7jhPF5/bDoSee+l3RFYdYpt3sd4m/yMcuUNJ/RCmwhT+zH0stlQpvoenzEy2DjpFd7jqorLxyOpXNBVi42LffpTHlHwyQzB5X1589aMk/UEbgCjcL9PTYWvWShlFCjWxRQkOy16GJUWE6V9pm4sq/9nwSvnixcONy3CVrlHSwIp9fwJO18Mv72RYKUPscAZGbZA4HJqDjVS/lNPrUrbYHksDVBZgFSoC4LXWXWHvYdhv7NUw815GaGL9CIvn6siynJscqHicUGY6X53NI/ZtYSXCPLWsdfgJdrdL5rn16vXRuRmzwUC2RfM2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSL0tSeKRavrPoWu4zSxlgLh06KAImtspwJWfUPGZSM=;
 b=ibCrg+osVM08jLYyIa0diisgLH7eYRt3ujxREDhugdAW9AxQmmdJy08eniLyTVrTTrAv/U6uAHjQm/z4kQno36XxibZa/Ul59/Z5h6rhooOW1FP72yU0JnIqBUDtITSctAUDVoHcoFOksklK/cpp/aqhIr0m5TsNdNnEd77qYPONv1vUUxMudNmWtf5OObsFQigL/+DYRq8eDrZWoWCONgNxuS0xkGY0lOMFLBnREmRM9nYKsLdkBw4mypayozJJSDmwFqKy/+Awvd51TLNS8ihRUAU/VkIBKU656E8XjpHdd69QGMppc0VmKUFEy5ZkTqQRnRCIBOPn7D8uZLTtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSL0tSeKRavrPoWu4zSxlgLh06KAImtspwJWfUPGZSM=;
 b=GO8vYRmw2n4UHq5zDw1HMlPYFOezmhB2PnFakx5AZzeG/QJZMWQoVzlJntCr9Wa0c3Q9XJabX61qsvh01MIPjmHsn+Z+ySYPEKvKhokbXl7KWHPUYqSjJOz72iCHwS/dO30ZEgwn1jTisvVZ+6zVmVUVwsxqtQsNmt/Kz2/dm7t3DjuX6Agc9tOKUhKi5Nqaa/CPOxTHLdR1FTh5dLHvOUWtX94fWYS/NQNA9FrAFVztV616rHGfINguUOyvglZFZ+FpLWUF35s96RZ+Fxd9/KPt8LlFM3UpFdPcLhFtrutjXPquMwlR5U/gNv6uoV8ZhCHWZ2HA70CB4xb4dTTA5Q==
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 16:16:54 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1e) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 16:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Mon, 27 Mar 2023 16:16:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:16:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:16:47 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:16:42 -0700
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
Subject: [Patch v4 08/10] cpufreq: tegra194: add OPP support and set bandwidth
Date:   Mon, 27 Mar 2023 21:44:24 +0530
Message-ID: <20230327161426.32639-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b7c06c-64a3-4f6a-de95-08db2edeae80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cQB5s1Sxp1nMj1cD9i5XYP+P0ePmuAxq7iLPIs8aoxXpZCLe0mKMXxL/SQXInCncDwpqwlwe4EfNGpysRUyQiBOn1A5SkQZWdQoY9nmR6WAtHHQkoXCCL52uSfZGSEWIh1BgaGrsqaS/iUzk6Ov5uPGDTbtYACfpUQsVUp4b6zaQ6Bs+A2JKwIsdq8HafCXPmYqsqG59+NXFE10vB7dfmP/ZtSwmWuswoAmHHqx9J3HXsWNu0KRUq9T6p6ohx2v5ptejDj9qtBskpoCTTYJTI4cnCSOk3KOp0z22GBNVrm3rKAxWQlWBFwywed1JSKKeKy0Sd6jTomEP3xjsU4eAa9c5Boy7b/kYg+rAIkw2l6KZ66kGQKZXVpxqMiiWJb81spbRorfValn6Q+8ufqwo9DDPtx/3w1PomTVMPzWem6mZE6CjZwbjfJTuVe/UpqtLtJ2HLVXydvtAj1n0jQovceSkLNDkS2zEXAhu7/5yOsoUrpdVPLM07RtMvrGo41LqXFq9ZdND7nQbJkEpKoAoZRelLI6WN/Tflk8JDdzNOEALgCU29G0tTzAO6sgx8RTWKLJGRt/FFO0BkJwSj++mmgh7ruCm/eI8J/Ndbd45igrRkq0B74oEh4/Q4oyeZie5uFEE/Mys0qBXNgbM7R2MinwuXntXnSKkJ0w+/NLXMeuYKq8QxvOs/j60ZzN3QUcqsiH6QKWKMsNnEPR3jBTpWPdJy9jPAOOCrwghyc6PiNIFk6yquN22Wf+5YM16rjJhDIjbsOlxLRfdwdz6a2nXoyoda8/DN8hKtt5JEX3cHo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(34020700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(8936002)(5660300002)(36756003)(82310400005)(86362001)(7416002)(2906002)(4326008)(8676002)(70206006)(70586007)(41300700001)(40480700001)(107886003)(6666004)(186003)(1076003)(26005)(426003)(2616005)(336012)(83380400001)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:16:54.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b7c06c-64a3-4f6a-de95-08db2edeae80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

