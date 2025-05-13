Return-Path: <linux-pci+bounces-27629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B2CAB52BB
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205321B61F75
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC9267AE3;
	Tue, 13 May 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDaix7t5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C3265CB6
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131539; cv=fail; b=o6EmVpOqcDyT7sBDo9hjnlvw18Z30dp/rJTzhgQN93ws54sCt11Z/8Ih3xPL2lixbAPTbn9tz3eKv3LIK3fMOt9SShRzDlDQ0mQK5wmfD/7UGkrt6Ja81uEPfxF5pihQ5znM0U3xOXUHmmy6PGHdo01tosGrYxOtHcRCnxSnQVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131539; c=relaxed/simple;
	bh=54YBzCj2bxV6DExPRFPgTZYkc7UYVWra3CfpNxuSPyE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=layn0fZ7p1bj/h+95UaIkibBap6CUF1EJ2ASi+E8DYX0LHAbTokgLRH1YYu7l27WfcWDqSSSvGiPk5oSyW6Au55awaXuD0y/88W9jMqjUiswd30gvqBQW/8Fz13GCTM+VKuk3Yp73m049h3Cf700H9LZH0YnbBm3pA/50OkK0xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDaix7t5; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw3HQbF5Nh8l4cmkGk2JfA9zP4ZV/hUYmHUhw/YFJAHXV20E/l9BJlGDFtbKfJ4wqqL+A/jz/EHwndf2IVKYa9AcVxxwhU214sty2uN6XHxWxvO8Mt9hTZNnErarU/E+6ryMcAP8S1GFKs4xvOwbGaZvOZCNR5+XKZWmUX8zvfIdTVmR0zAGyNs2BImf7ANd4ajI1PmXad7PX5zAZdmc98O4hh7dnRYUuqw1O1RiTf0ukPjhKWTUyoV5G2O4H+o2U8S855Ff5G7YMVrKOdgVCnNoz6L1bEdKdu0nVCpbI/7TJGPkiDPm1flyLcXuTHgapPcMO5j4YZ9XaSTtf7+H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmXPAPzxIdiycaWQYuV43z4eY+qAAsfKWU8L4VV45Ro=;
 b=tqI4crgiJmcKxk1LBIeQEE7BgjB+rHf1I3NwQxagJGPtdFc8KSToHs9uFvmgJil4qoNGMyBV37Pihd94wYHN12a6asDZiyLbpETBb/Gs8whP6zTOZfuJHv3i8pIau3lfKfqmZh24ntu7boiSf1XTlJZIazwAFYF57z0u4HQrB45UV9qjXWPmoqH1sHg4AnHRqUXI+MT+VV04RZp3J7d4aixkFzPR3g21JViwj+tYxeG/06OVOmbN08yY953wNLeXGd+T+k0wZYLiB6BfZ4uVD4C9WNVHWkN2AmCAhcw9VIZtVCK3mP4dyjskCVScstA++Vw22J09rVBVRtumrXJmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmXPAPzxIdiycaWQYuV43z4eY+qAAsfKWU8L4VV45Ro=;
 b=oDaix7t5keFjOPJCF8oPcPykATOIuO2EcZGFgYbH8oRGud4oSzfzbpD9PNtHiulHOvJDp9joP1WWL0vu1ab3t1daqTSrkkmegYMUQIkGGjThY/1IxIxLxBFNMdULZ7QL9LqIv/ELpXlYclfl1vO15m3uCIyS7JasOvIiSa0keheJOi/FCuORhikAE08c4VJU5mKY/Gib3Je0SMz11uCCxQHQ7Omw9uS74KrNPwsFHhWQjME2gIUBUPjJz+ou325X9eN434Mn6VW6pn/of8DeALpAj8LIu1O0nDzbWirgeKTr7Rf8QyGPABlm4sDXZKAvWbl9ZqUixbygxvJ0ZNrdAQ==
Received: from DM6PR02CA0148.namprd02.prod.outlook.com (2603:10b6:5:332::15)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 10:18:53 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::e0) by DM6PR02CA0148.outlook.office365.com
 (2603:10b6:5:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 13 May 2025 10:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 10:18:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 13 May
 2025 03:18:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 13 May
 2025 03:18:36 -0700
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 13 May 2025 03:18:34 -0700
Date: Tue, 13 May 2025 13:18:33 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] samples/devsec: Introduce a PCI
 device-security bus + endpoint sample
Message-ID: <20250513131833.522596cd.zhiw@nvidia.com>
In-Reply-To: <174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
	<174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fa81a4-ceb0-4614-c31d-08dd92078fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftjxTgQ/w+24AAkkL9Meg1kMVPxFPcbSOAfRhAoUZdaEvpuP15QQy250gR/4?=
 =?us-ascii?Q?LqS6xzYSNuCnwBCQP9GzfbFz6+g7XbpSAZW+gxguwhKTO1OEAUPTbgZ1PR9G?=
 =?us-ascii?Q?5rNdA2TIm8CvtL8nsnfz46jcvswbBa17vcR9aMvMLnd7BLujviS2gp4wt/+N?=
 =?us-ascii?Q?orm+WZDpyiubsTuenj8wZ2pJH55caGTdMeXbVY7qBqF3MtskW2itgV5pJz1f?=
 =?us-ascii?Q?YF/Q31X5J3yBskvJXa3L3TeGfkae63lhyrq5s9bgJslc9+lL8TIM5RxWIZOf?=
 =?us-ascii?Q?ysu9B5xKyqv5quWRT65M7A/jVyaj65Fcj0sq4NwpPTITGEhcektq19jS1J8C?=
 =?us-ascii?Q?mQkN9kr2ieTbIonTNt4Pazw/3V23KWvPESE6K85a8D1pmdVEnPHkabN05JDu?=
 =?us-ascii?Q?JCfD6TrSed6DeVqrHWDQdI53x9qaEo6SVSO4y5snM0a0rJjv8zKdtPHH85Je?=
 =?us-ascii?Q?Rne3L8HyS6l93wduBlDFY3nG3QPJK0x8L5M56eIFZnQCwyiFEC37aoZYJHxH?=
 =?us-ascii?Q?BK9/ztshAtPCe3MM00NTBvSEJWG2xVWodu45Dm5mK9YJ+QijbcVWIlDktGvR?=
 =?us-ascii?Q?RrOk6YyjCBeXewfNvQEm9LMy6qUju76vlroaNk4QI/T4zH5USQ72Kkk4Knyt?=
 =?us-ascii?Q?VnZ+2P7PRua3Fvv76jmtaiaYDJMw5vNmB0XO0QuKiZyVGxe2kWOwNrlk9kfH?=
 =?us-ascii?Q?zRq/qQ6v8NwxorRf8ydCCvSFXw92r5H0sxn5xRnaszThLSasOTBT2DdqlQ2C?=
 =?us-ascii?Q?czlNxNReS8NDq6/GjW8JjxfBuFHPloM8drt9cQYsX3L2+joJxec9gZ4RKXvi?=
 =?us-ascii?Q?LqD6oo8jbcIxI4lYRVrJBt+r3aWwg0/+Mq8bRo5sXdqGRYjZR8cc82Sx/bei?=
 =?us-ascii?Q?5cbLGY1pHc5pX7VJKX6TCahi+2bU0oD1XmnROtZCrg3xN8smzT5kLaEtReJ2?=
 =?us-ascii?Q?6UOXOEaardqqAnLsIBleV/f2NJ2qIFbliMQZEX4n9+nMnkdFM/e2rcOn7Yot?=
 =?us-ascii?Q?f3DZHXsJiWf7vZ1JWGOCrIg2hmPvE6PgT067i8ynhLkr7HVubHQIySWhAJMj?=
 =?us-ascii?Q?U+AQ3vbAmzR9rvPFCO0j2Upzqkk3B4PjJQVfDdPJl6IbqAX+dHfhImGgEtWI?=
 =?us-ascii?Q?IHfimR/MN06HHZZeYsu3UA6f+sMDqlC9JXZ0bzTRJ/rNbenyjwPZFijGpWX1?=
 =?us-ascii?Q?Tu47lGtzUWBodfVHj9geuUMn2IUs7ttrxA1DMU1hUNMhkuIH8h4bTSLS52P5?=
 =?us-ascii?Q?rr2+/fd+fHMK/NtsY2UM2AnDTU79qzq/F29Yj+6cjiQfpvV74CVKc15oy6BK?=
 =?us-ascii?Q?h0pH46jZEUj6aZiDVdxDBpHz4+pdgBRvg9Xvafx7qdIBS2jp6ZENBlryE2OX?=
 =?us-ascii?Q?8SF7VfsMiiSZOU91KRUPDgZDb6HkoYt3nrb5W/wE5mAyEAt2NmhVdSkh+kvd?=
 =?us-ascii?Q?H0bsVoYAOhPKb5PZplXPx7Om4B6t2vGZrd8W9YO4H6eMYrszWllUpvGYi78w?=
 =?us-ascii?Q?ta5VdnAFRXm3B0CpoPlbGL+ZafrPQD/oM1Ea?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:18:53.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fa81a4-ceb0-4614-c31d-08dd92078fcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

On Mon, 03 Mar 2025 23:14:50 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Establish just enough emulated PCI infrastructure to register a sample
> TSM (platform security manager) driver and have it discover an IDE +
> TEE (link encryption + device-interface security protocol (TDISP))
> capable device.
> 
...
> +
> +static int devsec_tsm_connect(struct pci_dev *pdev)
> +{

It might be helpful to put some comments here to describe the expected
common vendor-agnostic sequences from the perspective of TSM driver in
generic style. Guess it would be helpful for vendors to evaluate how to
fit there TSM drivers into these paths.

E.g. create device context, loops of sending SPDM messages of device
connect... The same in devsec_tsm_disconnect().

> +	return -ENXIO;
> +}
> +
> +static void devsec_tsm_disconnect(struct pci_dev *pdev)
> +{
> +}
> +

It would be nice to have TDI bind/unbind verbs included.

> +static const struct pci_tsm_ops devsec_pci_ops = {
> +	.probe = devsec_tsm_pci_probe,
> +	.remove = devsec_tsm_pci_remove,
> +	.connect = devsec_tsm_connect,
> +	.disconnect = devsec_tsm_disconnect,
> +};
> +
> +static void devsec_tsm_remove(void *tsm_core)
> +{
> +	tsm_unregister(tsm_core);
> +}
> +
> +static int devsec_tsm_probe(struct platform_device *pdev)
> +{
> +	struct tsm_core_dev *tsm_core;
> +
> +	tsm_core = tsm_register(&pdev->dev, NULL, &devsec_pci_ops);
> +	if (IS_ERR(tsm_core))
> +		return PTR_ERR(tsm_core);
> +
> +	return devm_add_action_or_reset(&pdev->dev,
> devsec_tsm_remove,
> +					tsm_core);
> +}
> +
> +static struct platform_driver devsec_tsm_driver = {
> +	.driver = {
> +		.name = "devsec_tsm",
> +	},
> +};
> +
> +static struct platform_device *devsec_tsm;
> +
> +static int __init devsec_tsm_init(void)
> +{
> +	struct platform_device_info devsec_tsm_info = {
> +		.name = "devsec_tsm",
> +		.id = -1,
> +	};
> +	int rc;
> +
> +	devsec_tsm = platform_device_register_full(&devsec_tsm_info);
> +	if (IS_ERR(devsec_tsm))
> +		return PTR_ERR(devsec_tsm);
> +
> +	rc = platform_driver_probe(&devsec_tsm_driver,
> devsec_tsm_probe);
> +	if (rc)
> +		platform_device_unregister(devsec_tsm);
> +	return rc;
> +}
> +module_init(devsec_tsm_init);
> +
> +static void __exit devsec_tsm_exit(void)
> +{
> +	platform_driver_unregister(&devsec_tsm_driver);
> +	platform_device_unregister(devsec_tsm);
> +}
> +module_exit(devsec_tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform
> TSM Driver");
> 
> 


