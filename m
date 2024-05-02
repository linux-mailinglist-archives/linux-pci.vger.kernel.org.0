Return-Path: <linux-pci+bounces-6985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DF8B9405
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 06:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772661C21382
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 04:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846D22EF0;
	Thu,  2 May 2024 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBMxcgYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09E21A19;
	Thu,  2 May 2024 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625748; cv=fail; b=oJz8Rv+fyYULYTNcbvlf5U+m63tH/94qmBoBlkPU4EebeydUSlOQjWJXiWPCI82N0jz+gteDzqAM/Q1s8qOYE8KCNYzwrHhtv6Uf4we62zd0kYanbjMT6gTgKy3Kew9rCxxGE9D9dlNQdj+tEqaXGYlWlnhOBLDGOeKf3iiONKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625748; c=relaxed/simple;
	bh=thmOD9u3UtVXsoG52VyYwIj0c1yy0aMNNCMD7W/xvXY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5rrYyZ7yS/FeqUnEL0WJM17quoUk90ZFHHtlz7/CB0OVTqfEQ17TjtwnXgpkkZQMF0Yx6wanTm8MuCosHtECwyo6Ozlz6PMYuRNkqJgd3avb2Hq2dCTjG1QTRWfmUBSSsU/sQxsMBAdAyN9RJJd0SNzkhSKqA6sCSnvX208eLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBMxcgYI; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcviUMzlGOKcDSHWPne87yOlHIXEGsC+QHxQqrbk8B119iGTsbaabbDb3JuPRXtlQ6Uc+E/9EVl6Nt6hONql6Ah1152k2g1KsVe45DyEtOQrOBgMa+KgIVfZlJcFKC7K7Tj1I+WXhntzeQ7Xl3prhrV3ueopx40oyQcxLoqdxCqu5fWCX5lvcryzCFSLjo/c7YXB6BEDmtTFDE62cWxLfMQ/3oe3Odecb0OqOL3JRN2v6Enq5KGvZoNnyU4Qg/1t+wzMYohdssh55TUHABLYJYG9VWxctVBDEtxV9B2W6THEeCd+xxMrF96m2D8ZtdbOWgGUuf+AmJwV33GU9qi9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wI8JQLajZsfxj4mfP5l79Le1FGovgWO2UXQQw5nFQI=;
 b=NKT6Wf4MifXEVV7/JFEHUoZ1Tn6nyg/hR1SlypDC8igBznR2wTbf2SNxJOzwP49i2GFRLlP8ZCS36aOppX3dpvZLeaE+Q5oILfmfEmTdltpt5beW8vwAFYk4JuPYHhApMB0Dp4NMRSNIttn9hO2sjYDRKGp+O6nUHrPYbxU4i5Xd5HH/g3ZUs++vvZIIuTig/MAd1B1idvihUzsV2PHvvwU1wGW6DXv66esVsFkbY0kHMR41wUHRVmgCB+f+jqK8DdQsXyAB48XBBpw0t124tCpzcbl9RvSwPPhNQn5wUeX/7A0PR7+D1ckjg7Prx0k/gHa05b5THkVPAe9S2bL2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wI8JQLajZsfxj4mfP5l79Le1FGovgWO2UXQQw5nFQI=;
 b=NBMxcgYIidOyjo65g3ESxe6UiuPTmEQwORn7SQEc1WsPfq0cQNwPKmQfPOG84/zIbxUY7t3/NxNyYyc1hKw8u6eNwn/44CNpeD1l6Zwcr/kZ5pmtzUCInMU9T2YcUXhiikjkZAv/Dkj5wTmbcUwboOzp4lds+tju9d3nXF3HUJKjQS1ZnbHL8mK1byPN/52MXGlXbTAKzmACekLtcKQ9/95/+TeT5BWc8aRx9GXgAV6Yb1SRkXRXjtTt6+Ly7K+g2DfmpauhvZnkYEKxzfBtlG3wV4UkCdlP0rQS7oMhPAl51bTgW8cn0+NzdJ4rV9GTEBBuvdaOaw2r3RP8D8dQUA==
Received: from SA9PR13CA0068.namprd13.prod.outlook.com (2603:10b6:806:23::13)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 04:55:44 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::e4) by SA9PR13CA0068.outlook.office365.com
 (2603:10b6:806:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 04:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 04:55:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 21:55:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 21:55:33 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 21:55:32 -0700
Date: Wed, 1 May 2024 21:55:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <liviu.dudau@arm.com>, <sudeep.holla@arm.com>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <ketanp@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] iommu/of: Support ats-supported device-tree property
Message-ID: <ZjMcw1AF418GljkR@Asurada-Nvidia>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-4-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429113938.192706-4-jean-philippe@linaro.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc9b31e-535f-4b05-a92c-08dc6a641fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmHXAZVqIvNIqbRVIIB5i7kRNctoM5L6i+f/RXpPXhtRDze86XMxPsqrUoPu?=
 =?us-ascii?Q?ZxkPM57ONgQ+EpiJf7U1g6OQmpy8F7x2RPZgrAEcu5cNdUSmuDw5Jp4ExnL8?=
 =?us-ascii?Q?i8yTPzacUWvfqIznVOTZIPbk6MuVmyaNBxUJxxOUUEXqbRpYV/j/KJB0gebz?=
 =?us-ascii?Q?l2fMLiL/dl6tKvzuMlWn9tEzb6bWCUNYyNTw4FJ1cStEywtCzEy3MbsIp3gG?=
 =?us-ascii?Q?axHfb57HSAn/Op4XvIZrN+u4iGAClIe2pYb1YU+7D9Gvy4l6tPhUlHn9XIhV?=
 =?us-ascii?Q?h5aDbvPpfmKTZvQV6cvIDrSn0fzAWBLniFG9V9gUnyKOEOIWnxtDMipjqlB+?=
 =?us-ascii?Q?odVspxxTvnkgMSovoHZ3thQpLsSUJuDH74SEgz5NVrioE7kl9O7pnqfyatLA?=
 =?us-ascii?Q?pDgboAhRt4RdAmd0os4SJ0KlcsLLHnbR6rs4cTQsXU5IRMti3LSM883jRxGv?=
 =?us-ascii?Q?3M5HFHo48E/eMeMrUNbDR4QcsrwKb+ADrrvLUR1UG7iINhtm/iSnDgYVZyru?=
 =?us-ascii?Q?ZnPl8vgW73Xo88plMBqWE6WLf8DI2IiiepG4gN8uSoR2LIZ1C/EjW+v7LzBS?=
 =?us-ascii?Q?/FaKsM7mLbDDRf3xc13SoduZirEFBMb6rIMHegLblJM4rvNEgz/H9xUrG297?=
 =?us-ascii?Q?R6EhTmR2EwjESXtqJ/10jqxIMzsOf5yIk30du4MPfI0YZq3td+/JmFjdxiS2?=
 =?us-ascii?Q?nymf+rOFvJhyawlw9AQsMuY/0aby5HkDu9WoTzY0ICv64C3D04BF5JfPZUYe?=
 =?us-ascii?Q?mqtFeKxHjFZtTfATzHHu3IwEUYvCw0SwdXRRoS1nP+3uWPlyZFGanrE7IyLr?=
 =?us-ascii?Q?ntiwzBiVbYdWNmRcQjuV65wng20zXQguStlRIMDCxVDYEr0TSd+M1VWAZLFr?=
 =?us-ascii?Q?Z8QbqentA/nCOYuZXOjP/i/YfUQPi4VxU5iKtyoG+g2MTdQEc/R8VTP8Ssqm?=
 =?us-ascii?Q?s2UxwCUmvEtcn6pJ+dotiVtschBRtprYMARIorgf2NLhWMBTgfQzVVM5/cLe?=
 =?us-ascii?Q?5Vrsg56+9qo8yWKBWGTHCl9qWd9z22mvDLwSE5QSnWmrj78I1zDX3n0PXhkN?=
 =?us-ascii?Q?iU4C92GQoMgfHHETmr76kANUP81xXfXxJSV5BlZQ30nRpca4vflf6686pXOa?=
 =?us-ascii?Q?A7T9FX1aS8LB7+m9ekXTC4p+m87+qlsSmGWbfbARss9xSCUCgh2hlttJFn4g?=
 =?us-ascii?Q?65YQNvKM4vZ2m8eOIyd6M56bqXaAFlrmIaVuvI+Y1EglbSXSZ9WnW65XNgmI?=
 =?us-ascii?Q?8j4tS1YHStWZ1ac0QGuthHgKq3mGfSRuopg0lULoPALanjnu3ewTP+rUkQ+U?=
 =?us-ascii?Q?/G+gtkh8AK4bwTUvmo+5p8jyrT9p57EWLTRxl5pkBuwqlUvKJ/wKu0GQPFtx?=
 =?us-ascii?Q?W1UqW3h8XIGBuGJM28sT5gxUIRuq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 04:55:43.9528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc9b31e-535f-4b05-a92c-08dc6a641fb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

On Mon, Apr 29, 2024 at 12:39:38PM +0100, Jean-Philippe Brucker wrote:
> Device-tree declares whether a PCI root-complex supports ATS by setting
> the "ats-supported" property. Copy this flag into device fwspec to let
> IOMMU drivers quickly check if they can enable ATS for a device.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Ketan Patil <ketanp@nvidia.com>

Thank you for sending this!

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

