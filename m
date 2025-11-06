Return-Path: <linux-pci+bounces-40458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42184C39513
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4D4E3CB5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A127A477;
	Thu,  6 Nov 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CXJiICBS"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azhn15011001.outbound.protection.outlook.com [52.102.149.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44D26E143;
	Thu,  6 Nov 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.149.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412473; cv=fail; b=mHXkUHQMut59+I44YKsORRGWVAIDP5Zhdi5/KyfLD50w7biOvMp/WTjpsiRIgoUIgNOGr8cD7ae8+SArk9ZYv4Mb4cfoN8w2PD+XtBeso9B1ih9FULJYuqoABZREXG1w4joP8yK6T4hc/kzneAKVEKZAMDfl1QNsK/MQd1t4fb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412473; c=relaxed/simple;
	bh=DOr4Te7HHzVLcooXjd5rfAs7a5GvRyc65zjB5pKOrwI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxpGXQSAPa9aUrqRXl/88AsFlg6Q9xh6bw8Vrq2iavHxMHJPTQ9SOmcgpbmYI4d4T33ZLomaEd0S751fvI8t8o962ItllMWDmg6JuCRjMGBpId0Jqj7dqsxPd3mpxv+fMZ+x+E4JnkbEPjYz5O0bX9xEVnj8ZPOGJski1XoXl50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CXJiICBS; arc=fail smtp.client-ip=52.102.149.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTQCxEb6H8CMasMFIO7eCp5wfYEqffZqR+ZTYrTBK48SWCi/78xbk++behU71YUKbQ4KThphuoozkICjZRXhiL2sBuJi4YbkdzvdNy9te+6pNCk+64JFT+OJ+BbMndgyD21V2d+ehk4aDR7kArMCEfI6AxXRF54pT+GG6f8uEazB9eL+RmK3Zrydx9zG5OpKD8BWHf1HFXTsP6nf4A4zdfrFNcL7aGurObhwd36tAqPqGdyhNM58Y8mdO/6Cbrz4OOMJqLpH48Hxz3vNT/t0owP02Zs4spgT95qf60TN4gh5n230RggRtvHs7TbHl/Sx3FE/5LlqVTGpGYy0MX+BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Lq+LFeAMurs2Tl7eDUkZp7Sk42LHrVgEvI6mIOlmQ=;
 b=ecW10f+gG/3ItRUzMfJNcP0GtT1++30OYcc7QNLgKi76Zq487tQVNGM0qFqylgfW73VkvYvAtqo/OTyrcf2AowM3XHcq031PCDa4fHET9MA0Y7EsjKQ7v+kYDWB13tsQ68EqWdWFfDwisyxLrRsDmyoYAWeEy1DwK74A5WldsqUYzmYWC/cjEo9JzuMZ7CnMbA6u1Ip+1403Lz8jk5JYisN82zqOHDaOdEOjo4TWLiPeDSAAyikWMWP35NjLRjFuYavwC3dVrxjzVFK4rJ2SyoeKopHj5ZK0oxq+JDwxMmzBC6+rfJMnF0BZH3Q/qV6d7TqQ2Y0uurzLFPEd/PEH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Lq+LFeAMurs2Tl7eDUkZp7Sk42LHrVgEvI6mIOlmQ=;
 b=CXJiICBS9X/QJkqSUtB6vFHcr2XHvS3RQOeDMXzr5JVhgC6ghsIZf1oCOXowH4V9HQD2+52RLQxhR7mowvvHq/iry66eizVf9xsD30lYaBBA0Stt/vMPVjzEWsBD2Tgk2ws1ahelkwz2tVu62A+0Ku04IsW8HDV4c9VZQO42rlU=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by SJ5PPFE654FA166.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 07:01:09 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d7) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 07:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 07:01:07 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 01:01:00 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 01:01:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 01:01:00 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A670scI842574;
	Thu, 6 Nov 2025 01:00:54 -0600
Message-ID: <d65f44cac2d7fb6c4a139065b304cb4ab790acb3.camel@ti.com>
Subject: Re: [PATCH v5 4/4] PCI: keystone: Add support to build as a
 loadable module
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
	<krishna.chundru@oss.qualcomm.com>, <qiang.yu@oss.qualcomm.com>,
	<shradha.t@samsung.com>, <thippeswamy.havalige@amd.com>,
	<inochiama@gmail.com>, <fan.ni@samsung.com>, <cassel@kernel.org>,
	<kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
	<jirislaby@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Thu, 6 Nov 2025 12:31:08 +0530
In-Reply-To: <fkzokskbjklt6atqrpwc46zsjr5ptpuynzhx4kvfurr4h37kae@rwcqljsjvzl6>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
	 <20251029080547.1253757-5-s-vadapalli@ti.com>
	 <fkzokskbjklt6atqrpwc46zsjr5ptpuynzhx4kvfurr4h37kae@rwcqljsjvzl6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SJ5PPFE654FA166:EE_
X-MS-Office365-Filtering-Correlation-Id: 385f01e1-6533-49bc-6863-08de1d0242b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|82310400026|1800799024|7416014|376014|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdvMDJzLzVaODZUV1VVRmphOWlsOU15MmFJVTlVUVZFdFBhcW1iaHNab0lI?=
 =?utf-8?B?anlWUzNzcjRpbk96TDFKa2pFYTV0ZjV5dmU3cSs1am5iMEpMdXc4RitQeWVu?=
 =?utf-8?B?K3NET2psZ1EyZENFdmh4VUFmSUp6c2dxSDZQd2xBWWtKY2xVV25sdXdPTG9F?=
 =?utf-8?B?MVZod3ArWFA1OXV0RHQwTmtrNHZPYWRpd0NpOFJmUGhFT3lUTklBYXYvVE1O?=
 =?utf-8?B?Nm9Nc05WQW9aUU5pUHRHa0d0SUZFQitOaTNQQVBJU3p5QXdQV25qVXF6V1BU?=
 =?utf-8?B?UkhiWUdYNXYyNWd0SWNTb3BKdXhxLy9XLzJTWExDMUxLM0crZDV0RWx0K3ht?=
 =?utf-8?B?TU9Rb2I3SU1pWWtLVXdHbU53VUpBOFFObUd0cUVHb3dyZzVoZ05lUGRkUGtZ?=
 =?utf-8?B?QllxbTNtTUZ5M3lzZ2l6MlZveWEyZ0pnblI2S2U1NlAwcjFrRnJXZktESVdr?=
 =?utf-8?B?emV0U2xrSnVUMjhjdnNVY3paaGhmZ3BteExMb0QzRWJBcXFoZ0pZUEdxMkV4?=
 =?utf-8?B?TTR5T2R3d1VNRnRLYzJYckRaSkowaGFPcm9Ibnh2ZFR5Wm9BZjl2S2hsSXpP?=
 =?utf-8?B?UzZrZTRQNFlFUVp5d3VFaEhmWU16TERZTXVySVhiLzUvLysvUDladVBHcmNl?=
 =?utf-8?B?LzdrY2JwZnpaWlNndWRkbmhwSHoyMGErS0E1NXBLM0VZWUNVQzR4MCs3YUVX?=
 =?utf-8?B?MGxpUCtQd2xiYWhZNWROamFDV2EyUm80WC9GSjRvWE9XOVN5cUl6VXdGUURz?=
 =?utf-8?B?Y1hLU052ckF4Vm9JWXQ4QWJxdzFlUmxWNEtWRk44Tm83TU5Gdy9jVW1La3ZJ?=
 =?utf-8?B?OGhtdmFFWW02bi9HWmtrTVp1Z0hKeGE2elVvbDRaT2ovQURqQi9TZElkU0Ru?=
 =?utf-8?B?eStGT1ZyYTlZTHBreTJHTGFNajFKWXFTM2VLNHhjUHk1T3ZVdnNpS0hiYXFB?=
 =?utf-8?B?OG1ZUGFaeVZrb3I5RFd2Z0MwOU85cEp6L1R0SXZaZEdhbjN0ayt0Lyt3WEFG?=
 =?utf-8?B?YndqcGE1OXoranZxbUIyOXhMMWpGOEtJNzA2bXEvS0k3MnpYMDZWaXdwK0ty?=
 =?utf-8?B?ZGt6Wm9sRSswamlkeXRtM1dLRTF5eFV3R0k5K2FnSXVCODVvMHF5NzdoZXhk?=
 =?utf-8?B?RXp6TU5IWjhuNXJUYkhZN05BcUVUL3pEM1JabHJXVURNTnlubnY0OHdTdHdE?=
 =?utf-8?B?S24rTkFJYktxTm5KeGI5NFVtdFI3S2VHRUE1bURPWG1yTXFGVGlLV3pyd0tV?=
 =?utf-8?B?bzVmVzAzWkZrY0duWmJraERtWXY4NWpTVWJUNlkrMXFxaFV6MWxPUmMrcHVE?=
 =?utf-8?B?cTRHRnJ6SkRuQmF0NzUvMDFmdS9EQThqT2tIaloxZmttUVlBQkFDODNsbG9M?=
 =?utf-8?B?YTFOeW1mL0xiQUc5RnkvVWI2ZEpzR0Mxb2xMUnJQRkEzL2w3UnVJdFgzdjUr?=
 =?utf-8?B?STNPd1VoYTQyT3dqVzdFWmozdHZPbWJkZ1Bvd3BQQTJiNzYyMzhQQUdYZXYx?=
 =?utf-8?B?WUJpdVlRaDk4N2dQSkIxV0RCeGZ0MlNGZ3BENVJZUVhacW1EMWxIeWhEK2FR?=
 =?utf-8?B?bXBaZXNTMHNld0RPbEZhVWdzT09KZzBKZlMydS9UZUhWYnRVN2xiMlorRVFN?=
 =?utf-8?B?T0JYeFJoQ0JCa2dtUEFmVGtsVkw3ZW5xQlBmbnBtNnNOSFl0V3pidDZDa3Vm?=
 =?utf-8?B?QU11dmkwL1p6cjlCQzZiellRYkdVcmRFcUdzN3V6bmVIcVRncHdBS0FQZ1ZF?=
 =?utf-8?B?cVBNdlFoNWVBZGRrL0ovemkzS3EyWW8xMkxuYnVMeDVHNzJObHVCdmxCczhM?=
 =?utf-8?B?UGE5cFQ5bWt2U0g0ekJqODMyOVhYYjlPdVYrUDIzcER5NElnS0pIRWFhdzU5?=
 =?utf-8?B?R2Q3ODluZXBDRURMbDFQcDhmcnMxbWNLUmJCUldmUWZiTS9jaDcyeGc3RjV5?=
 =?utf-8?B?TUVudUtscm9yR0FvQTlQY0tMMkJYZmU4OERJR0pvMWorMU9vVVdnd3U2bTBB?=
 =?utf-8?B?dGtTdDNtYjNtakZjS3Z4RE5MU1JxbmJ4MTk3YzZYUnU5ejFINlkrcy9LZm9Z?=
 =?utf-8?B?cmt1U1VZVHVBTnJLNmlLMWZsSExJcCs3U25iOG5OM3FTdEsyZ2s1NEZ1aThN?=
 =?utf-8?Q?VHCg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(82310400026)(1800799024)(7416014)(376014)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:01:07.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385f01e1-6533-49bc-6863-08de1d0242b0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE654FA166

On Wed, 2025-11-05 at 22:53 +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 29, 2025 at 01:34:52PM +0530, Siddharth Vadapalli wrote:
> > The 'pci-keystone.c' driver is the application/glue/wrapper driver for =
the
> > Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> > that the 'pci-keystone.c' driver depends upon have been exported for us=
e,
> > enable support to build the driver as a loadable module.
> >=20
> > Additionally, the functions marked by the '__init' keyword may be invok=
ed:
> > a) After a probe deferral
> > OR
> > b) During a delayed probe - Delay attributed to driver being built as a
> >    loadable module
> >=20
> > In both of the cases mentioned above, the '__init' memory will be freed
> > before the functions are invoked. This results in an exception of the f=
orm:
> >=20
> > 	Unable to handle kernel paging request at virtual address ...
> > 	Mem abort info:
> > 	...
> > 	pc : ks_pcie_host_init+0x0/0x540
> > 	lr : dw_pcie_host_init+0x170/0x498
> > 	...
> > 	ks_pcie_host_init+0x0/0x540 (P)
> > 	ks_pcie_probe+0x728/0x84c
> > 	platform_probe+0x5c/0x98
> > 	really_probe+0xbc/0x29c
> > 	__driver_probe_device+0x78/0x12c
> > 	driver_probe_device+0xd8/0x15c
> > 	...
> >=20
> > To address this, introduce a new function namely 'ks_pcie_init()' to
> > register the 'fault handler' while removing the '__init' keyword from
> > existing functions.
> >=20
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >=20
> > v4:
> > https://lore.kernel.org/r/20251022095724.997218-5-s-vadapalli@ti.com/
> > Changes since v4:
> > - To fix the build error on ARM32 platforms as reported at:
> >   https://lore.kernel.org/r/202510281008.jw19XuyP-lkp@intel.com/
> >   patch 4 in the series has been updated by introducing a new config
> >   named "PCI_KEYSTONE_TRISTATE" which allows building the driver as
> >   a loadable module. Additionally, this newly introduced config can
> >   be enabled only for non-ARM32 platforms. As a result, ARM32 platforms
> >   continue using the existing PCI_KEYSTONE config which is a bool, whil=
e
> >   ARM64 platforms can use PCI_KEYSTONE_TRISTATE which is a tristate, an=
d
> >   can optionally enabled loadable module support being enabled by this
> >   series.
> >=20
> > Regards,
> > Siddharth.
> >=20
> >  drivers/pci/controller/dwc/Kconfig        | 15 +++--
> >  drivers/pci/controller/dwc/Makefile       |  3 +
> >  drivers/pci/controller/dwc/pci-keystone.c | 78 +++++++++++++----------
> >  3 files changed, 59 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 349d4657393c..c5bc2f0b1f39 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -482,15 +482,21 @@ config PCI_DRA7XX_EP
> >  	  to enable device-specific features PCI_DRA7XX_EP must be selected.
> >  	  This uses the DesignWare core.
> > =20
> > +# ARM32 platforms use hook_fault_code() and cannot support loadable mo=
dule.
> >  config PCI_KEYSTONE
> >  	bool
> > =20
> > +# On non-ARM32 platforms, loadable module can be supported.
> > +config PCI_KEYSTONE_TRISTATE
> > +	tristate
> > +
> >  config PCI_KEYSTONE_HOST
> > -	bool "TI Keystone PCIe controller (host mode)"
> > +	tristate "TI Keystone PCIe controller (host mode)"
> >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> >  	depends on PCI_MSI
> >  	select PCIE_DW_HOST
> > -	select PCI_KEYSTONE
> > +	select PCI_KEYSTONE if ARM
> > +	select PCI_KEYSTONE_TRISTATE if !ARM
>=20
> Wouldn't below change work for you?
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 349d4657393c..b1219e7136c9 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -486,8 +486,9 @@ config PCI_KEYSTONE
>         bool
> =20
>  config PCI_KEYSTONE_HOST
> -       bool "TI Keystone PCIe controller (host mode)"
> +       tristate "TI Keystone PCIe controller (host mode)"

This doesn't alter the build of the pci-keystone.c driver. From the
existing Makefile, we have:
 obj-$(CONFIG_PCI_KEYSTONE) +=3D pci-keystone.o
implying that it is only CONFIG_PCI_KEYSTONE that determines whether the
pci-keystone.c driver is built as a loadable module or a built-in module.

>         depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> +       default y if ARCH_KEYSTONE

The default flag only specifies what should be selected by default, but it
doesn't prevent the user from attempting to built it as a loadable module
using menuconfig. Building the pci-keystone.c driver as a loadable module
(CONFIG_PCI_KEYSTONE set to 'm') will cause build errors for ARM32
platforms due to the presence of hook_fault_code() which is __init code.

The Kconfig and Makefile changes made by the patch do the following:
1. Allow building the pci-keystone.c driver as a loadable module for non-
ARM32 platforms by introducing the PCI_KEYSTONE_TRISTATE config which is a
tristate unlike the existing PCI_KEYSTONE config which is a bool.
2. Associate PCI_KEYSTONE with ARM32 platforms and associate
PCI_KEYSTONE_TRISTATE with non-ARM32 platforms to prevent users from
building the pci-keystone.c driver as a loadable module for ARM32
platforms.

Regards,
Siddharth.

