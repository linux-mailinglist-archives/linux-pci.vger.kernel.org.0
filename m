Return-Path: <linux-pci+bounces-35009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91AB39DD0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D77C4028
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52C3101A3;
	Thu, 28 Aug 2025 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trUqhWdT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFF31065D;
	Thu, 28 Aug 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385520; cv=fail; b=Je9OCtdk6FkW5i+6BInCOj3E6YW9tcrglOWN/bR1eIFRwkh4TaJxLu2E/JFQ20o9BDiG6AHYM86xsbpHMM/lzNCeApBuJnmJ2pj24+qJJd02shMz9+JVg3f1LF1TOR4NjtZUqhkBwtzLDFPbFU1PgPuN47SpNoUs2hr0iB4UrUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385520; c=relaxed/simple;
	bh=DMJ4Kl0ooCBxizCYvK8E5v//mnvFUeza0TU6bVPmF2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQT3FRbxFeeuV3QrzOI0I4V2eNm7Hu13GvcuAUcZxXxcOsI+j0LWW0cOuGJsU3gb4RarwxWyDpHxSOs1eN9W6J/6hnqaXIotFdzx2QYRDebNJn83N3p7TS5yLOLFqedf2XDuJ19WbGp5R/1owMCuHH/OWrpE3+mXGSZaQgfmlUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trUqhWdT; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP8gSuEFGmfnIU6Xyl+s/3OLKwee/hgM70EC/4042SsHNmy1BV8cr0x9Gav4ucaqMU87jY3imlbW+n/BZ02SBhDOFiNTgYN5IYDl3vYFRLZRffiyxqBn6wNlW9LSGwoXsGxpHN4pshtMwsfdifDTmUz+KbiiscKlvkIN6HWaf4DuCPD6X3MasIUX3OlgwBU85eZTWtpHxcF6MFQOlKbcDzhJXToqVLrKOJANKYa1tvV7Nli+BiVy1EdYQwvW+Jxu1VZQktR4TdN2J9mSYENWs2IuATdFE0TylVfOEyjGu2+ZQ7mwsPXwZ1C3ptBAOK/GjKQZI02QypzK/Yf/U267uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMJ4Kl0ooCBxizCYvK8E5v//mnvFUeza0TU6bVPmF2k=;
 b=Z3+OAGrLmhF+sfse105Ukv8nyOkQPIRBRuittOGEHSGAZhisFWCL/6MXYiES+Ve28vaEBrDgvCYqgu7rohRLjKbfnhcYYKwNuXSphZYnckeBuJX2NcyvQ9jPBnkzlZlrSgsT1VPv2SQfzIUb8kIgX371Eq793ehoXdKRCCILZcMOVrI+xU0h/dnNgHu9FK1gJ0gD2maYOpIWX9vd+xEzrb19m6SZXcBlZTbWN/ZCQr9xciPAT7EnrN2pISfmSrZMXQxeqWPLfHDNwznSRXoVjOfa+9jASMs5g7/SWOdjbIzo7ImN9kqjgV75Qdbtgi2ohalwyvsZmeEqLM3mVKH4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMJ4Kl0ooCBxizCYvK8E5v//mnvFUeza0TU6bVPmF2k=;
 b=trUqhWdTwygKlk8B0QHizFS71/2INpBu3HFcoijn9AERpCaImNn0Q+O3m9nVj1Y2F53oEwLGGMrcbw/9Ee/2rbtQOt8ZMskImlB1yvI8WIiuaVjp+r02Tx6X9aIYcMGZPJDmwNn2IrElwn4EEZgp1UF0SXtvXw66Awdm5Pgr4XiNDkWQCSeuZd20TnS1tvnI8o1vClWbIdLa9ucvfjwieidHXgHRE2fJeMYO+8wryk+V+DtoSbQpNKhP/cKGA7P2k/6Xn7U/oiUP5Lf7PN/+Em5JTY4fEOvAezS2DHgu3MtY3eFJ6hxNDhDe+dCeYZRidlfW4L8u0Ruu//TA6PRWzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 12:51:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 12:51:51 +0000
Date: Thu, 28 Aug 2025 09:51:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ethan Zhao <etzhao1900@gmail.com>, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, will@kernel.org,
	robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <20250828125149.GD7333@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
 <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
 <20250822140821.GE1311579@nvidia.com>
 <aKi8EqEp1DKG+h38@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKi8EqEp1DKG+h38@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0330.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b36ca2-ceba-4050-302f-08dde631a862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2xtB7lc3M2wHestbaJbTkgpH+GnOlGN2Drbiryyhf83Xi3cBzcQqgKh6yiD?=
 =?us-ascii?Q?up2blkNKgWLq2G+vOFIAPVonk3BEjST0WbLcksVHKNbob8ez6LWuMKDMEDp4?=
 =?us-ascii?Q?ZhJkIgG3c8bZ4nZIdJ7H5GJIDCUwKG8jGzjOX7DdmMvjKNUrbFHfOQMfBMBu?=
 =?us-ascii?Q?Cr1HLZ7C+VOIJZg53f11dpjZAZU9Gz0UtkkQAm6cP1W7LvvT1hESY+dGt/0m?=
 =?us-ascii?Q?XKLjSliDtHjSqAzrsailerIM9C220y2NtNGFQ74fxtjpRyfkwz7hH7W9ceEw?=
 =?us-ascii?Q?I6SZP2/ap1/Cc8hYZk7zJv079ksH96hFQewHRyd4WRpJw2aI0rIRvb9BITl0?=
 =?us-ascii?Q?02hJZf+1W6qYT/8+f0xIXnMyuqDh1Ixm2dUTk/0O/aHTBc0EtlMvJl9aQyt6?=
 =?us-ascii?Q?Zc3HnMncc9HLuWHq04WeTrZnU+nenxvjmf9YvlyiySVqPmD5v9PvCxXCYkuU?=
 =?us-ascii?Q?Vamthi7m1YvK55t47ypFq6WsAtLWY6Q1spo3yxB5SwG8xaf+Zjcimt6RjZQk?=
 =?us-ascii?Q?bt1V6674C9PfjWIp6ZF3KsMhhHODKJc2fxYuLLKN2hMh6BX+J8YX59Zt4RNN?=
 =?us-ascii?Q?jf37wE6BD3NfAOpnKrGRe567jMvb+V1nb++rTowXjnpynQbuft7PsX1noILu?=
 =?us-ascii?Q?0CZ/hBbthoTWH31311RaAB5xPGTsRiDnL2OCo1mmsyTlWLr4WNbiKPd4xyam?=
 =?us-ascii?Q?UpA7hl86U9Mhn3Wg7JuofExqksR2UDrDoHPXFVLO2R74VO8QGAbLiR0GABPh?=
 =?us-ascii?Q?goBVlCHszBJKmNEv4eijiubQKf6FZF4RK1rz8IWuh8ojDfvkFlYcu0VGKWPU?=
 =?us-ascii?Q?UoPRp0bbubPMeGdUFzuIuMim9uO2pQTFAU2lSbGATJI74CgaLGW7kbKvN2eM?=
 =?us-ascii?Q?96bdavoc9EWSN5KA5hBHGWzPedTtrl3UXsRgH5E34PwHjY2gkS9si3fTz8Qy?=
 =?us-ascii?Q?RwPWB8OzCi5VKxQwk3Z9tlv1CVPPZPSQbxdr868DqU3pARGIXYn9bAItEbKP?=
 =?us-ascii?Q?03JGj3b4mSYpv4H9+NVGOfZBWMv9iWcTSjdWJK4uyP2YZQqWH+novYg7nZyp?=
 =?us-ascii?Q?Sm+rAUDfYH8OmI2ykcIC1/7OFv3H46vahAQGJgespZvt7Ya2jj4UNt8WgFNU?=
 =?us-ascii?Q?0rfoGXcuVCUM1wDfWseSMk9c9mAQzq4ZDMxYMn3vzNJeGWoO+74v6fx7KflB?=
 =?us-ascii?Q?E71N/H6S929ZVFaifARnJTh0XL2N+UtYEzkCz6InU08frCqGzDWPaoI76+r9?=
 =?us-ascii?Q?x0c0JB6FpL66mrg/pjyYFae4J9ayFT4Hw3nnlkQs6cwn6h/cXJ8XohtClS8w?=
 =?us-ascii?Q?VloGnf87EHkUtcrstHywVwvoy2t5lDkUjpgNNtt8MMszVnPMGudwI1TWCBdR?=
 =?us-ascii?Q?LXNZpM55dA+xLv7AbxIEjMzvGNY8iVmGpzWmFyBg6lJ1Ygbicf2Qrh3ALBbm?=
 =?us-ascii?Q?6DnBnxpS1y4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t82/JyT9hpuFJxoIG9sVTwFZiLbXMY2yC0vvHWdN42eQKfHiMyLf4TY+cr3d?=
 =?us-ascii?Q?hLBdTBptFeRgfqpRc/deYlbDZ9jNTAKF2kp33hgqGYRcvT0jfDpAtovyLQyK?=
 =?us-ascii?Q?NpYw8zK/QqSx7/+J04e+T9FCS8CH0thdbeg0xaU/9BspCEh/fV8IhTKoYSfu?=
 =?us-ascii?Q?dxdDSOjG8aEP3VVyY8QUKzCuxwhEuLISUExT8AZT3uDuWfyGDGTvghj/iMqF?=
 =?us-ascii?Q?bV540vooaTaaoPYQvgDQ/LYyGp7dSyb4csh3AJulTA6OYIf5/fEIcwxSacNj?=
 =?us-ascii?Q?OyooPO8XrQrMbW15iz29x0DFHHlB1PjuPksixOIY7vNVzcQPssgq2LAW4ydk?=
 =?us-ascii?Q?ihYLIzFN1A0oBYk3jBUWUShFPHWcvhwGVIcXYA8W/xekotuheKaxxpZfR02q?=
 =?us-ascii?Q?1Hga4W5tU5Ye4wLrGNG9061HqIXZ40sRztTYir23BL1CaKeIH3iyxYcUTzn2?=
 =?us-ascii?Q?tkjDRMiiqaVESSeftYSJ3Hu82FbqYxoNw18ShfYXwjIofz6TJGZ/aK1uU3Tf?=
 =?us-ascii?Q?8z322jJz1VPW4P1ltiZNFBJaACGMgi7+e+RQEfLf7vP2dMFZORq4+HRg1TbB?=
 =?us-ascii?Q?z54uk/D3zhcXDpTXXx/XMcotFZjjXFj8IfhgJ5IlvyfMuQ/Ta3ozQznbDOMk?=
 =?us-ascii?Q?7xXfroUN9IT5E754OyafxpdXUn+4LB8dCvrKJgdxgEB2VXxcpvVMFVnKIKIy?=
 =?us-ascii?Q?6aPhDYVosciPJU4DdokyTp0Gj3DcZzli9cWA+U/rVyhzg1r+lpJ+ISfgRDwz?=
 =?us-ascii?Q?DcQzpSUAjCoo/JFHopxf84NwYfHrxuQ/j5rBD7CGMcGOrASx+Q3FIVvLnF4i?=
 =?us-ascii?Q?SqYx5Zmc/3YrEizQCpNXe7gMNixdwSbRwpHU8niZW3Jwz6KeY1N5rRnA832B?=
 =?us-ascii?Q?dfqECyimMYcs+EBKqrLToqFztCV2inXqaN0tOSHlN0iXnz1qTQWpeGBw2otn?=
 =?us-ascii?Q?HZaQ5QuoNNqWKlooMcNWjkpS6t+q7vOLc+k4QFQaU8CbmysNfJISq2qTFzBg?=
 =?us-ascii?Q?tnlnH1xoDpcMq7uRt+P7Z2Gdo4gFp6Z2p36OxxxEKQi29j+EiO1Rju6nCBuZ?=
 =?us-ascii?Q?TmDXx3v50AceiZ9yu003E9k6QlwlL6YonjPF9NXJj9bG0Dl3xBYrb5vzU9Wv?=
 =?us-ascii?Q?iIZVGJohjERtcdcD8fNSZA8TYzaiqkZpAwNqSunWm27DRGnS0pkH0EsZ4jqh?=
 =?us-ascii?Q?727kQ1W2SUqjYVWjg33buiIOU1FOOkWgrhPlbzAUGa/vnOXRbB8EKRb7bWXH?=
 =?us-ascii?Q?BiVyvcQO6pAdTUXEMCUV1nt4H8uyZwqrEgXjsIMfubW4Jcvurmr4g1KsTdDN?=
 =?us-ascii?Q?TvCXiuxCsLRvkdzD466BngNXSoBi4X9qprACkq5fqpQXhS1PFEIYLtVjumy8?=
 =?us-ascii?Q?z7Z7mE0kXHTsmnHhHxutyVYN/+dbAJ7zH98nN5Nb/85iuAA+hrHu83jpFrYn?=
 =?us-ascii?Q?PoOFFUjJF7xi8Z9tfkWF5PYJXI4yAAyCO5ZVKu+gAOKI/G+BVr8pN42YlQyu?=
 =?us-ascii?Q?G9uTDXeEJQlByfatLg+bnibEpHXrg4Zur40kJLuwYyizqDZZUuQtuwu7eDgs?=
 =?us-ascii?Q?+VvMiQ6f3K8Tf9iOSZU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b36ca2-ceba-4050-302f-08dde631a862
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:51:51.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSy3j956Gw+6LmJ3rqhkiqdb7nqlD10qDzf41KoloQg4jUxOIqdLNAiag1jrYZ3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

On Fri, Aug 22, 2025 at 11:50:58AM -0700, Nicolin Chen wrote:

> It feels like we need a no-fail re-attach operation, or at least an
> unlikely-to-fail one. I recall years ago we tried a can_attach op
> to test the compatibility but it didn't get merged. Maybe we'd need
> it so that a concurrent attach can test compatibility, allowing the
> re-attach in iommu_dev_reset_done() to more likely succeed.

This is probably the cleanest option to split these things

Jason

