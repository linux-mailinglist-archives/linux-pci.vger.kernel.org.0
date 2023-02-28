Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF76A524C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 05:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjB1EWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 23:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjB1EWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 23:22:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D926847;
        Mon, 27 Feb 2023 20:21:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K25u0kyDiART4BZYuzP8dB5e6UmBaa9gqVZdlg+QG3hWfV6gvKC0DhTUdNWdaLTN0Wae2KSyJzIRDt2qw2rR6GNWvRkYhJVMDUQi6U6g+QjdjdVGaiA7I7p1KsuOf2gEvSWFgwPWcP2xKg/FiefEyqQ0rsMA883vsXGkeLj8ab2BEWri2cdwHOTLfQQWalxrqOQOahexi6+mAqgh+3fQsCjICRmYeGRw4892EK6OaE4hZUrH8VNM4HMC6pHdAVLN3NCzkgkcJafSiMH/hTYiOACNH7Fu0lIWtYZo6XM5tdWplsaqOfYmzsQvGgXe6RQbOH9WArkRLzvrn+YVfZR4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAt2Jdw+BFCu/M780DOdKTlmXUiMtgpBo93yRj4aDVQ=;
 b=F6Z40zQkhBYvvkGLM6/54Da7ZdbwkHbO5KjEziYth++UJyO6HFqVY/rhRRhsePPjJyjAdYL1ClpsMa+Q732g6OA5R+esZ+SIFs+FO2fAYCA9RG7pm70QgPTb8hljSzvW8D6vVUHMZdA4VWrwMfqAUuyLTRkP7D6Sniw+hYB+edKFy9MlZljESJrnQ4yvF79bL/urTEqVwGfs58lBgMJ9qoqYfIGFi7aqIiEImHeHch+aK9+7imeItIsUDX+lhtWWUBOEHSQW4OZBCFDZ0SeYd6NKW2UlfKrtg2CLGLJ3Crg3aP5pyEW4EmqM1+hrFAIv8/U7jsF3w+KAHEaNOmZVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAt2Jdw+BFCu/M780DOdKTlmXUiMtgpBo93yRj4aDVQ=;
 b=bIJ4aXpa1CYEUHux2GLyheShEA0viOWStNR66RBitab3R4zy7yocq2CjMFG6GQPIpB4iqHPyr9WRUGjbSAp4reAgXWC0sEksfjwVH9O+F/eYM2fitLwgsQbZ+85kpw1JznWjDGAZ1jptxhn10ruz1Gf/m5bALYWoKzYGVQ0OqOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MN2PR01MB5422.prod.exchangelabs.com (2603:10b6:208:112::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Tue, 28 Feb 2023 04:21:55 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 04:21:54 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Configure STU of a PF if ATS is not enabled.
Date:   Mon, 27 Feb 2023 20:21:37 -0800
Message-Id: <20230228042137.1941024-3-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:610:75::24) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MN2PR01MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c0fe17-16a2-4c15-5fc2-08db194352ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBLiy04fbeHDYfkru8NSzeZf8QrFMJHsfLWgyXlh9h5BahmSfdy+AqZjvifzkYd6vT0IucQ4ZHuB470el2oQ+WlZIFVm3jg8wubtLD6Q9uKPsSrL28IzISexj3RfiPRZBc6KLJjOeU4X2pRI4rcgI7H009R0rtjNeXbMvltoKB4p4R6VJAIP905Z3T38lJw+n+Aco6t/AFnVgQ8leniAQuJXNowLbT7T1GB1887Se+fPA1T9gNhGRhJt7n1ANp2qjca8vvXm2Cm6KWKieEk40KFkMTu3YweVLnLfBvjeyOqSJF/j4Acy2JiUqa3QhqO/5QHZnFxFXnAr5JA3vn4IOxutat7dc1A0hiSxMfm7wY6kuB7c3QF5w8QzV6XGjuOrIxYkJoDgnNMGIyx9oTV06l7SXGVk2KRQm1P+89B0z34zvHELSHjhjWG7+i7rvs4FkNu87PifbjnBxxhBHYnW3AXiSXiMQH+8vAW6QosViuI/LbzrlTq9DKnFJ8TMDCMN9JR4jKn6hou6OICrErI9AyzKdqFNAFFSwf4AuPzvuzh6a7SMnfslog8JCb9IjAiBpR0VUBBoP+IiWKZ00EEizP13k7Pwzq+ixT2lVlXxSmCDCcAQ6nkPclHiAe/Nu1JJ0IJvih6bOK9ZuDRpFSBiNUUiAV/Ju8tdb6x2nO6lJGcHp2QGn3uRh8bhBWLvECOSgBscdV2wP5Tp2/Z1n1MDUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(451199018)(6486002)(107886003)(83380400001)(7416002)(2906002)(5660300002)(1076003)(41300700001)(6506007)(478600001)(86362001)(52116002)(6666004)(4326008)(8936002)(38350700002)(38100700002)(66476007)(6512007)(66556008)(316002)(26005)(2616005)(186003)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NHYHiG2t5zoe8fCtwZF/4PY3Rrng3s0OrEd3xiW1vT7Vv35wLR+wDlwDfG4I?=
 =?us-ascii?Q?5LlENUDjxSDYq/m1MXmkYSy2xr9uq5Ie5hMD/3VGoCMe98XbxS1SH+qao1Wr?=
 =?us-ascii?Q?bB5j8V7emUdenCE8HeSVk/KjyCE0o0Ojb+1I57w8gKkeOkNSft5lf1IAO4KY?=
 =?us-ascii?Q?8ifK+M65M1hmB8DH8NC8l0qPzvACWQaG2N0V/+BUNkke3BLWL5C5OVRySAVY?=
 =?us-ascii?Q?AHYdy087y77ADoLaoC8fnv7VH3KX+r0da8UF/8bhldl6m/2X4Cjvp1L6Z9P1?=
 =?us-ascii?Q?z2jZunDxjdZQ+ibbq3cH94i5BoQH5SNYR/7t1XOfkINbvnu2ijVEGcR1ppe9?=
 =?us-ascii?Q?7xjcUR43zOFwuqKMuloht9TZZmxu2so+Zp7Vv4RBzL2g9D/o6JA3aw5lBPDi?=
 =?us-ascii?Q?dZ3anEBMUto5kCVkD1/PGzSyaQO9YgEaZYx9necFuoxicoFPt264ZhuOV0rk?=
 =?us-ascii?Q?UbufR5CBCrbNE1YEDmxrw1vz57JkL8bGCUdKy+7GHBQz13om7Mc5tKSo43Pz?=
 =?us-ascii?Q?CsnLS2L7EeLUUBVUEulBubnQo6QSMP253V9t36BIbkx3TyUYTGlvQyPCrOzi?=
 =?us-ascii?Q?CvK+ODd1QHtNHcO455NK82RaW33gl4HWG+maGfBzm2c9j0YGwHWqPUKAXsuQ?=
 =?us-ascii?Q?3MJNhYGGdYV7iHR1mvszYX0PBkd/srb3kab/JN7d1CNQS2a5jYerNX4rXELS?=
 =?us-ascii?Q?btoDC3RiP7G8PQhLMeV1GNCPvyyer8Du63hlrx0FJEqtxIz8p3C1tsF2HImv?=
 =?us-ascii?Q?qSsz9K9aft8TwtxoDH3WQpAfrdmcDYnW4o/cxUUgNIxkFaIMtEsHK12gx0zU?=
 =?us-ascii?Q?c9qmQqTaNWdInFhDErV9ExXLLbQoOUvIZxBH3fa7EdUdiejwO/clfiIbl/0R?=
 =?us-ascii?Q?VJ0YaEBuP9KmOFFme39dQN4D5XAiPGU6CaHqgXftvcM1ScurS6RkLScJtDyu?=
 =?us-ascii?Q?+3KGLfB7IKBPZ1Kpv8pbk3vNcnqvTZzjFzfKwKFMGQoNHV7uXzMunyjnLAHe?=
 =?us-ascii?Q?1Iv6zW96fYG4Rhc+JlgG36Z2VJ2uC5K7EFJ2q5i7louOXbXMAX2/6UKYGPiz?=
 =?us-ascii?Q?FgGO5ylHsJ8LJFUdoiaB2A7ozGjb+J/G4A+jQPYMwiXtwP2d8VmfenjICG13?=
 =?us-ascii?Q?zsUlFlBpQAtthLxJq9c1Xu33b6bEuwOo5DTpnDl0HoPV1hPKZC2jEMvlsVZP?=
 =?us-ascii?Q?RqqqnyLLDqxUYFHxQypcrtz5fN0S4jvHZroLIFDLJmF8/CCybiFPLaTf0JKO?=
 =?us-ascii?Q?T+deYoXM1Hj2PXc62eobSmxDIx46dHERTFd1RM0zZT8tduMILRiQDf0ITSW5?=
 =?us-ascii?Q?Koc3IGZiw+NzJzLcYuTd3DizNZWa5f1RHi/L9GjGHeJT0Zi5zQBbozqaJNUK?=
 =?us-ascii?Q?KI9rL3k9eSPEl4+KyCVzI2ZWjjcg+AsPr1+oehlPpWWLsunDPKGVrvv/AYE8?=
 =?us-ascii?Q?vTmuz6KELHl4tb0auQjvB8H9hb0Z6Ckuu2FsJKsoAjIubg9jjT/4Vuxz2Sv9?=
 =?us-ascii?Q?pNLmz40fIhHJzVd6/kFfVpJ+hZYAPpu3EnavlJj445fcntSqgK8RbgehOyyj?=
 =?us-ascii?Q?Ap1Dej6lwm0LITjALbOabmESHa9ZS/2kgAfN/OGcyDFa5ctviosjmtzPLN7p?=
 =?us-ascii?Q?aMm4JHhd+O/DcMQgPbQRALA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c0fe17-16a2-4c15-5fc2-08db194352ec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:21:54.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVkl9GROhYaqbxgKC0MP6/sh8896988AxNGtsZLLTTs7HbitWG9rgDxKa3qk/8AlHpkP/rzNxPVGKq9Z+rqSxSTsc3dU9Li/SIPTd1qRpkKaYg2BdnGmg95XV9kIV5Uo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5422
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

