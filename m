Return-Path: <linux-pci+bounces-41209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD1C5B692
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 06:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5A114EADC6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 05:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9ABBE49;
	Fri, 14 Nov 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XvXu92qG"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3E946C;
	Fri, 14 Nov 2025 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099231; cv=fail; b=ectn6W3qn/gvKS8MONQ2FPWYZUfU3v9Vb62qLkRD2L1Pm1nYU23Pz17U5l4b0W0B3X2oOQeVqI78F6Xl1uvavaD0JdZQG2pYbnagPYUJ6j3FCm7xHHkM5E391vk2AYV9jJHp7cRvYvT9vJKzzNB/Bn6YDjZ2ZWch5NxGw6ICiWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099231; c=relaxed/simple;
	bh=J0kyIBzHg++Vxhk//pkiYv2bfUFmSR6DSIT3biN/LRE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLqz4v/sBd99s9eTqp+XViGd6A2Qj5kCv+zXZfXzeE0qBvanesQXo+oSCMaYnODFqQRCHCPmfA4Ky1ScER09jsiFmRoSmoqiG26DHPYmU2w5fkYkHyPZcMqgetYVbxUXu/fRIR5txSbejZ++6wtSKji14Q9LsQZ6EYwoTBnJ1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XvXu92qG; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiSeHNquRDZcj6UzuJhcQF2SJDsu5iIHznbxi4C8oORFY28liopN5T2h8zbGrRnY1XOqijVF690waEA6LQYsxw9vunjTDcxOUKr/rZERcdVUsTiNH1cLQ/d5u2H9fZpVR4JjCbQOdlFwhvOkSAGRogIQrjtpC39Jc5qoZunRRjTy3WN7/HzwduzTwB8HIQ1Ax0IbQigG7Lut8VWWXO6kNcTaxdSs25BeHSW3lWPJzIjCteFXY6QKWEBCiDjeJNHj/tYciiEOVMkcBQnkQVfcLaH6TffRYJ9DI2XUXwo9y+4Sjg3ct0Ioz0MYRHHfoUa1hghS9N4OIZQXGjV5nBmtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDY4rzxS1KBXcHGiXlGHOtivYAzXvuPCaPZsrXVdukA=;
 b=nl+WZQGtCRKjrCaaE1zH0I8tsHW+yK3nlHSnmzV3NdADIm0+JX9qrBqx4KLLmsEe2Q4Dn8nKOeQWjVN8OifIBnx0PB1sWQyq1+SspWQqJDq5inO+MIW6FF+Xk6JjURucstuvvcMuNle7AcAqPI+aw/eUAUPF6u2WkSt+rcnSmREVYNnCpXzb8pzipLThdAPMa9FqBHv4yZSGBqrzVxE1wUFus2Hcv/Vub2+MX2Me9qe0LlDq/04SXNGXS2ialuNmUsTGVlLTFoTMkHzJqk/8yFbEBSYItPqfBwnduNsWThSiUhdCQBngTRZivWL3paZR1pFY3gSh+epwU/wMO1gd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDY4rzxS1KBXcHGiXlGHOtivYAzXvuPCaPZsrXVdukA=;
 b=XvXu92qGIwS6qSIh8I4mcW+rEgxe61GwrMf+e+hiQ3erp8LeDuud90yEczwoRpU1nkc0Eb+z4X3aAH1OYpw01aImd3DjIzXP4N/wNMfooxOcTJXy28JDk9e6JVEbuEysiBez52J0oDe8VyPa0OSTFdZ1M2u6Ev+ypDO7+R0Dan4=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by DS0PR10MB6824.namprd10.prod.outlook.com (2603:10b6:8:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 05:47:04 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::5e) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Fri,
 14 Nov 2025 05:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 05:47:02 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 23:46:56 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 23:46:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 23:46:56 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE5kq4n1456754;
	Thu, 13 Nov 2025 23:46:53 -0600
Message-ID: <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	<bhelgaas@google.com>, Chen Wang <unicorn_wang@outlook.com>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Fri, 14 Nov 2025 11:17:08 +0530
In-Reply-To: <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
	 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c8233b-56fd-43ca-97e8-08de23413ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|32650700017|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkV1bGVyWSs5S2NZbU0wMlhMTGFLcE9RajRNM1YycytDQjZiSXVoUW4xcDYw?=
 =?utf-8?B?YVZYTEhmYnBNUkJkclppbXhUSEN0MXNUeG1NL3l0NE5xdnRNWWl4UGJya1NJ?=
 =?utf-8?B?Nkx4OFFPQ2Q0RTkySy9seU9JY1FtWkFsM1RMK2sxcnhQanpxU2x0Q0UrckhQ?=
 =?utf-8?B?U0hMenhteEVNcDlhTjJybHQ4bld0ci9IWnVOUnN2aGluR3JQcjBKb1lrR2Zy?=
 =?utf-8?B?anBzRmpuOWFuRjJhWWhyWjR4NWQ5RUYvZjBIR0syak05bllYY3B2bWc4MkFV?=
 =?utf-8?B?UXgrcDA0M2ZYSUZnZFA5YXBDekdZUFBvMlREMFl6RkdmSXZKL2d2V0FwRUhM?=
 =?utf-8?B?U292NVpmVW82NFlRNFNQV2lXZXV2VGl4ZloyUFlpSjFYWncvdHV0dHVKUHRH?=
 =?utf-8?B?S2h6ZWF1bjRXckk1dDNqK0Jldzl2WFAwb3dtc2R3ZWhFTktQcmYwUGFtN1hU?=
 =?utf-8?B?QVI4bnJtVmFuQ0Nra3NZelVUSncza2drSnNFaVgrRGR2WlJSenFIMVNqenVN?=
 =?utf-8?B?NHd3dWNYREZlcDBqd2FpUDVCZnlyeGtSdFUydWI4WFUrR1Z3am9KMWRjS3ZW?=
 =?utf-8?B?QTRLU1dGZldQQXpWWmxMSEZoeXJBWTRxQ0VPTlFlNHVwNWM2U3ZlVTVRSkJJ?=
 =?utf-8?B?Ny9nbjRTbHF1VU1ORDJUeStNUkVaYjVMalJyWGtxbHRLMVFjWjRpUFVGK0Q3?=
 =?utf-8?B?K240a3V3bmYyT1BFWEVUVTRxZ0FVSE1NV1V4aTlmL0NqWENhR0VwbnlpdndU?=
 =?utf-8?B?NTRuV25haE00RFBtWGpNL1hXdGphRWRtODFESVBxSTRtOUFuL0tyMmU2SHRS?=
 =?utf-8?B?Qm5LYmNvclNMOHhENGZKbzR0UmxrQ3BjR0hMOWJRMTRZNUJJTk90TVJYamJk?=
 =?utf-8?B?dEVOUXM4S3UzRzVjMktRbjhsNWJLNXB5ZHVGRlBCd3M2UFAzMXRIYVUrZjBQ?=
 =?utf-8?B?Ukk3MEVIcFlIdWdQR1lHdXBvTHF6NVN4bERGbHVVSDk4V0NucHJ5RWR5ZVJF?=
 =?utf-8?B?Vmw1V0RpNENHZ0NJbVBlc3hUSW0vbTl4NVd0eHRzY05xRi8vMFU3R2M4Qkt6?=
 =?utf-8?B?cm5obi9vQVp5T2Vka0JJcUV3NE9oZS9qWm5FUzVHNW52QjRSa21wYy9yQ2J5?=
 =?utf-8?B?ZmUyMnpTWjc3ZFpoeTBCeFZ0TDlsUVkvK2FtRXdIc0piRWEvVitDRzVQQ1ZJ?=
 =?utf-8?B?MDl3OGFIVnR6M2hJaTVXRyt3R3Z1UjBiYXdJcnkycFdYemtzcUUvRTZ0QXd4?=
 =?utf-8?B?dFlCMGVHVkFoR2RGSWdTUkQ1cDE5Vmt3Y2lrazQrYksvVjkzRFAyOGdBcnA1?=
 =?utf-8?B?aURxVWpDNE0yZndkcHVxRk5pMFA0NUs1bmRwVExKRTlZUGZVcjYvM3ZHeUhU?=
 =?utf-8?B?eThmdUh4YjBEVDB3SDQ4cDU3Y0x5Qjl1QTdBaWkxeWxIZnlkRDR0WW1QTTk3?=
 =?utf-8?B?WGhuMGlCMDU4RnlqUlVBcENSRHE1clBURzFSU1QwYmZJZUxFVG1SZ3dhVXBl?=
 =?utf-8?B?czlzdkFyK1V3Yi9wcmNWQWJoTDZFSFV3dlZXRjVTZVEvZ2NyMDM4c3VOaXFQ?=
 =?utf-8?B?dVBKeFQvbjA0WjNPVW1ram1CLytmT2d3SDU0bG50cy91c1d3YjlLWGFVa0Qw?=
 =?utf-8?B?Y0N0bDVnZ1A0RmJxekhkNm9tWkRJbWh5eWl1R3pQK3VHWSsyaFI4SG4xTHVS?=
 =?utf-8?B?R1c2Q0tDZG1PSkJCWm1YU1M4NHBuVjhUOWFuTnYyWXdDSGRkS0pWRXBUKzB3?=
 =?utf-8?B?MEhBM3pRZkVPSCtFMnpjZklPbXF2dTNHM0piTzNuT3RJTWR2UTFqcEVEdVg3?=
 =?utf-8?B?Sk1pSzNRVDAzZlVlY0lPSk1IYXVoOEtRazM5bnFwZldMRlk3TzRMV2IyNjhy?=
 =?utf-8?B?TVJ3RHpZTFU3Y095MWNHNVVzQUtoTG1WR2w4TEVXWVhtUThVdlRWZVNGRzVz?=
 =?utf-8?B?alpIQWZvSUZUdzNtYUFtanJUcGZYSlRaT1o4ODE0RnhicE1Kd21LZEtnRzdX?=
 =?utf-8?B?SHRYdEwzZVAvMUxrL0FBSGZ0R3JyN2w4cWNsQkRrcS81Y0R4Ull4bFVDYzVJ?=
 =?utf-8?B?b3hBc0VDanBpRlZLdSsrMTZwTDVGVDRmY3kwekdiYU9PTlFoZUVrQ2lCMjRS?=
 =?utf-8?Q?OsCw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(32650700017)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 05:47:02.9518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c8233b-56fd-43ca-97e8-08de23413ca1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6824

On Thu, 2025-11-13 at 11:13 +0100, Arnd Bergmann wrote:

Hello Arnd,

> On Thu, Nov 13, 2025, at 10:27, Siddharth Vadapalli wrote:
> > The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
> > PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve a=
s a
> > library of helpers. Since the vendor drivers could individually be buil=
t
> > as built-in or as loadable modules, it is possible to select a build
> > configuration wherein a vendor driver is built-in while the library is
> > built as a loadable module. This will result in a build error as report=
ed
> > in the 'Closes' link below.
> >=20
> > Address the build error by changing the library configs to be 'bool'
> > instead of 'tristate'.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:=20
> > https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.c=
om/
> > Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>=20
> I really think there has to be a better solution here, this is not
> an unusual problem.
>=20
> > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> >  	depends on PCI
> >=20
> >  config PCIE_CADENCE
> > -	tristate
> > +	bool
> >=20
> >  config PCIE_CADENCE_HOST
> > -	tristate
> > +	bool
> >  	depends on OF
> >  	select IRQ_DOMAIN
> >  	select PCIE_CADENCE
> >=20
> >  config PCIE_CADENCE_EP
> > -	tristate
> > +	bool
> >  	depends on OF
> >  	depends on PCI_ENDPOINT
> >  	select PCIE_CADENCE
>=20
> I think the easiest way would be to leave PCIE_CADENCE as
> a 'tristate' symbol but make the other two 'bool', and then
> adjust the Makefile logic to use CONFIG_PCIE_CADENCE as
> the thing that controls how the individual drivers are built.
>=20
> That way, if any platform specific driver is built-in, both
> the EP and HOST support are built-in or disabled but never
> loadable modules. As long as all platform drivers are
> loadable modules, so would be the base support.

Thank you for the suggestion. I think that the following Makefile changes
will be sufficient and Kconfig doesn't need to be modified:

diff --git a/drivers/pci/controller/cadence/Makefile
b/drivers/pci/controller/cadence/Makefile
index 5e23f8539ecc..1a97c9b249b8 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,4 +4,6 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) +=3D pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) +=3D pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) +=3D pci-j721e.o
+pci_j721e-y :=3D pci-j721e.o pcie-cadence.o
 obj-$(CONFIG_PCIE_SG2042_HOST) +=3D pcie-sg2042.o
+pci_sg2042_host-y :=3D pci-sg2042.o pcie-cadence.o

If either of PCI_J721E or SG2042_HOST is selected as a built-in module,
then pcie-cadence-host.c, pcie-cadence-ep.c and pcie-cadence.c drivers will
be built-in. If both PCI_J721E and SG2042_HOST are selected as loadable
modules, only then the library drivers will be enabled as loadable modules.

Please let me know what you think.

Regards,
Siddharth.

