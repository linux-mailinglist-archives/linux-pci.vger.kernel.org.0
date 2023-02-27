Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1E6A428A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjB0NWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjB0NWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 08:22:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E81CAFA;
        Mon, 27 Feb 2023 05:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkzHNWvVIKWidWRT6zqWBC2gKfqU6ib1IQgCAV/iJa23NGhmwbW2d9hNZd7j3fih6DeZ7vJ6D2q2JY82JYsfIRTH95QTy3IctKXjtXexx9g5Cbr60EUp4KKE85/w7KUN4D3Y9bF9myTqzFKcS5Z2Qi3+wWpJxQWrhQR0kmyleZZac4A8/g5Js55I3KGQyWUnZ5CWFYA9vp8WoeUI/pSizzUJgLdJzvy7Svt0Zg0k7ITml91UTaqAgBgHfs0gIrTGIRoXskUIq42AWZ5O8eWKBGDIkOAQ/LgA17UJoY2nfnpBbFq2Q01nbDyLrsU9fIRIxEpSNmovwCEAoGMGcvyc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAt2Jdw+BFCu/M780DOdKTlmXUiMtgpBo93yRj4aDVQ=;
 b=j7LrawkJ7Y5ZJ9rPSfGEqozqu9pyptvKzCJAjjEMrMmZ0hr12c/l2DoBiwaSCGOsEBDXrkrH/HEsQqTzSriz2DZA3Itm7clTj1JU4RN6hX/HyU7YTI8sliRDGJVWyUhs9IPmGXArjRMEML3AdRQI6MV+BaSDR66xrT4SPudmEcPdL5TyVi7ard7Ocw6G4kQ4jW22qEulBxnl0+Stz1kH69ySWz00nOTVjH/qjoK1DZ3ggGzzlsRyqLhlZ6BbzuS5+xxpbST9R2MFD6ho0iWdi14KtdyaP3UL6SNQmYqzCQnskl1/mSYU5mMo7+0Em/gL3UXqcU8LfDflV9ya7Elqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAt2Jdw+BFCu/M780DOdKTlmXUiMtgpBo93yRj4aDVQ=;
 b=sXTCyn2pDy2Q99AHP7Ygs/IizZ9ysvafFQLoVIhu0USCgfyT2Ood2TAbSGej40BM/qSMYR3odI4GzsFfwuLGscX2KABi2fbos9amiaCboDusHYC5k2oNpSqQDp7W3YGrhssqwxDK3PHXXGQRSiemYs09SeD+DDCHm90thAUoIP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MWHPR01MB2719.prod.exchangelabs.com (2603:10b6:300:f8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 13:22:11 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:22:11 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Configure STU of a PF if ATS is not enabled.
Date:   Mon, 27 Feb 2023 05:21:51 -0800
Message-Id: <20230227132151.1907480-3-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26)
 To DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MWHPR01MB2719:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed7eea0-01be-4e14-a65f-08db18c5a23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDACYXgauCXvO23IAFtRUDFhFGf3AkqLAD1Xsuq5wNxRy3uq83IsXmoX/5kQ2Qt06gp9QBf6qgWyYnvO/mU3fZ9aaSLt++y0ULdl2w59ALvv2Z+8cBsAdrSc8TvQI92Be3gTdcRM7aC8O/+3PMP9BWYQWe7quFNvykgBODJDu3olXcy4WVIa4SnJepU+SzO3RHMh3e3CZ/ZP38X5vu3I0O3WMd0Xmx7rDL00ZMZsOReLLzwo9JyThCEO6UrHEY8i4sirclgCeDTp1MKXq7XxBnsKYxyKr8rswmkdMI8vhn64CxDwNs/7EPfsE0jUnc/5yEcU68Z3Sxs4pVd2Xm3tSqO1rR1l2LGOqEhWsFbIkPncKZ2X6NpW3cec5Q6I1rYmWWNw92Br6omsuUbtCIwK6jlNVDFMfs2roET4GzNDLySpQC+vZj0DWwdNsXRklZ5dqiVHlz/CzgQXMKzt+k+URCiB9hbFQXzLLMDHb9vR87PWSbPiFoL614jTj6st+EQj2rlS5fEX8Q/WySGkhiUAlMJNuP575l9hhg9tAez/pgpxtPfL1F+wOrRTeCt+i+0icfL9YlKbS5HiQeYVz6XTBhj4wFwa/LF/XrtL7qIlHkfzHCy+8N73pU/r4+PB4k9JfMK6sUR6CJgzlBAvi37ZVbJ6sQsYl5IkqM5sluknS72Cd1mvsMqE5Q5YKrf4J58Vtltv5Y4Dcq0YL1PC+0JWYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(376002)(366004)(346002)(136003)(396003)(451199018)(8936002)(2906002)(5660300002)(41300700001)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(478600001)(6486002)(52116002)(6666004)(107886003)(26005)(6512007)(186003)(1076003)(6506007)(2616005)(86362001)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROLTypb+l8NKAvLLGiOvozbTfjxtCEEFsZCEhE1iewhz5QTaGDfuX/pvLxYD?=
 =?us-ascii?Q?y5QNhMm0X7BGS7vaw7LMa3fSJlbix8fViJWZhA+G7qYsWfNUmYSM3KIEpu5Q?=
 =?us-ascii?Q?vpX35qybCvLXBMQonVRAESoGthtR/NkbD3wKaWYzzRqyckzWxGpG9RKsmuzV?=
 =?us-ascii?Q?Hit2Sha+Chbj5gviSqqpz+RmVGsfhFkI3PV6TEoyzRULMYaQMX7xUk56kXFU?=
 =?us-ascii?Q?9TElezVQfHnH/g0O1jf+KPPi4r12r3dBdUJd6IvAxOpwXKyF1bpIxkrSs6QE?=
 =?us-ascii?Q?MQuHFecx0YDjaksn5jR0o+pulK4yiatQ1UDPcMaOmirLdSakHbh+WNDPjnoU?=
 =?us-ascii?Q?S2+6K725YsgxaCoXIO65RvbrFjEH8HC/vFzDOhKVGhg/MCxB4+5EgueRz8rE?=
 =?us-ascii?Q?mlcB6j6S+GVVzCTCV4abtyiBPWDPmFYnxMGwyzERkh+v46erw9txlXejSpIU?=
 =?us-ascii?Q?sze1tvbd6LJhN/OCYJ4Geo74QyxbxybS4GXsinyfuhvOUAO+KAIvle/fZ+7v?=
 =?us-ascii?Q?FmtiEidGLIsmFY/mTvGRGM8dXqkBhKqozYxwZJ6Phk90NN6z4dU1OHFNGcFQ?=
 =?us-ascii?Q?1XzdDuj1biPkQJSkNwWmep0ulSX0pVtn0tS1j/OVwsGgTtnfpxtb/tQ3HLzX?=
 =?us-ascii?Q?+JbOG2a7lArBTk69ziHnNHnzJdfIXKOAbnvspUaw2AjgqYhs3PVvxAIc36QV?=
 =?us-ascii?Q?TKhM5kdHSj/7er3QgFazfoJZ3PhnNN/IATCudKZlMjpneqHBdv4ahjhte90I?=
 =?us-ascii?Q?m++t1tOI1DPQJ1Q9pYY4gfmmzI32f4G7xnkWlN/QXNNuXjiqYx8WiRabblAu?=
 =?us-ascii?Q?q7AIYGVZwu92uBfLV9CzA6FtPgGpPdOU70Wb75BKYfsU+eLs1cXpnokl2AJo?=
 =?us-ascii?Q?9PbOSOGun9+qd68SPd3vmMrM3uMhdkYjTQvPth/R+YoRtseyvBp7k+x7Buaf?=
 =?us-ascii?Q?uDMYfYGgMJFvfq659Dpdd4iH155CnzvPkqmOnA/2UnmbmgE5vjUSQeH8I5Kf?=
 =?us-ascii?Q?+kY32LWu0cTh79xqdyXU9khqlILaAR6AU1q7qCJKd9lpBLeoxjsDxTMN0yrH?=
 =?us-ascii?Q?xv810MvAYyzi2D4nhNjX8dxgDhpZOO1Eufm6nEm/2H+nsEb5fMjivPRs1Dfc?=
 =?us-ascii?Q?amAWWnnwuzpB10QZhbZWh6DcRvitD5kEQLEHxMWnak+2e05+M14+ZQjIImqz?=
 =?us-ascii?Q?OvWju4TunA7p8SvGUMAL+xjJK3mfhTiSil5Kfz2htQXbExpm7oOLBU7LNjVh?=
 =?us-ascii?Q?VWYLTlK/LQtp14Vv11bfvGd4yvGiaXYEi++m9+KTJln9bfBHU/3Ut6VMb0XS?=
 =?us-ascii?Q?Gt356GIZ0iISDPneZOWCxfvFeazg2ukEA6AN596dUib9fZz/S8ABvCs5F6EE?=
 =?us-ascii?Q?KL9IlCQ6UeTBfDbKSrQrKStLYhZ2z3TiTZq1fbg/veJm4x5UupbpHQUTY0Mo?=
 =?us-ascii?Q?EZ4Ptm7k2/jNxjG+jn2fDL5Dr7MZ7v3moTXnU5qUY7hZ8b6nhy2PnzzVj5f+?=
 =?us-ascii?Q?Afo3chC/QpXQ8GF0MRq3sEsdKayvVhsfY2gyI+XoA//gcQ5/p0VNhovHUv/x?=
 =?us-ascii?Q?T/E93skZ9xcte5zqD96f4rSHb4ZwqpIEaxONsXLKThKYOxnC9Slft5D+ZKhV?=
 =?us-ascii?Q?shpQjAKuYmQsoFHRghZk6i4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed7eea0-01be-4e14-a65f-08db18c5a23c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:22:11.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6mlNueOaw4Z6XRfsR/bpERinI/5xJ7LNgu9lyfvMretx1cTyyaFX87zFnJU1KATKpIcAYTnQcaQLsF0dRPJsf23i6Ra4IRM7o5sTHQZ/48i3vNNA0cCdyaXOCdJnCuu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2719
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the host kernel is booted with iommu passthrough mode, PF and VFs
are enumerated with iommu/smmu domain set to bypass mode.
In bypass mode, ATS is not enabled on all VFs and associated PF.
When VFs are attached to a VM, the corresponding iommu domain is set to
SMMU translation mode and smmu-v3 driver try to enable the ATS and fails
due to invalid STU of a PF.

Adding a fix to configure STU of a PF while enumerating in passthrough
mode.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..b218ef0bf001 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2292,6 +2292,23 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
+static void arm_smmu_ats_stu_init(struct arm_smmu_master *master)
+{
+	size_t stu;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
+
+	if (master->ats_enabled)
+		return;
+
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+	pdev = to_pci_dev(master->dev);
+
+	if (pci_ats_stu_configure(pdev, stu))
+		dev_err(master->dev, "Failed to configure ATS STU (%zu)\n", stu);
+}
+
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
 	size_t stu;
@@ -2404,6 +2421,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
+	bool ats_supported;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2446,9 +2464,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	master->domain = smmu_domain;
+	ats_supported = arm_smmu_ats_supported(master);
 
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
-		master->ats_enabled = arm_smmu_ats_supported(master);
+		master->ats_enabled = ats_supported;
 
 	arm_smmu_install_ste_for_dev(master);
 
@@ -2458,6 +2477,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_enable_ats(master);
 
+	/* Configure ATS STU of a PF in passthrough */
+	if (!master->ats_enabled && ats_supported)
+		arm_smmu_ats_stu_init(master);
+
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
-- 
2.38.1

