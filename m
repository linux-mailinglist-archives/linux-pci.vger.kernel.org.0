Return-Path: <linux-pci+bounces-24068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E85A684CC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 07:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E7319C3AA3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A91C173F;
	Wed, 19 Mar 2025 06:09:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8F22094;
	Wed, 19 Mar 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364562; cv=fail; b=bK8p22siq+18sxeSxI2PYYF1r9t5N80RYOqOJ6xlpO8F0K5pygtbnn28y+leYAOZt/ajh0MZUafjHAQniAbWYw82Rc0oBN2vTNhxuJ3ClBSKu5qZg0Gs8Ze+8RFjdAvLZCiL5PeIlpfnxph9mQrQjGfn9mvukemEIMr1PNXEKQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364562; c=relaxed/simple;
	bh=ke0mbDg6ZjTs68FSwUpVUdzeNLP9IdOGHw9Zo/QhbGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB6XT8lmXg0SQaUcamObvv1elQDPcXju3eH/o/T/crz6Lqp5IkihG/h12fcPee4VQhJSyz1Bm3qjMj9KekFxxNYLIE6mCZGQ0tYUYy8ScZMSyDwQ44tkRrQ6UYxqXntUKXDPZ9F+304iPMYXgFIEOLYaV4CvUJtZfoZ39stwJmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcMexrjIb+L33UCI0wOgbo2kakDStTKi4vi3TTLjox1RFXbVQZ7hBCL6wCnzoOX7wd9164t990bvyxMf5XutZG7WrS3la0bOL0weC6HyX/cpzmZCCNy+DbtOO+kn/u1N4LOTGfDBtkn2txcc77OS5aglDXNKzK7PhzkoBQ/EijsmlB7N/Bvek/b5woySsoasx92VyWgSLFNA8CCTZP/skgsvg0LCzf+h7UqjTn0DS8BL9d8bNTY3ITCtWK7gHvHyLrOZFOS8izbDy4rjA7lcLT40Qy6ZIPLshrC1eT8StuVedTR8PqzIZ8XOWu5Bqf1GY0EpJRx4jmQq/bORHblTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvXcbkjG//SzS+q2wE17dxsjhVOHNMzibXllrc/bvik=;
 b=AITjXmUJpYqZ2cJpUvdtKUuFCQ+vL2isS33LEzWf6TQhYJdMsBmQJlQbrpz03Xr+SMj3O5OR9Ejvm5vIGwGFKvgJ92yYT6MHBh3s+mFmFhuhffuiqVT28tIegCJPNWjzL+R23aDVkS7NUxv2OeGRniTwbXFy2G3Pf8Na4vh0NoVOpuQ0jarAg2cLzBb788eICfqfCE39k/Aoa4/MUGIx5PbOpobJz99yC4Sw4/CmXTYRFjYWzMTBUjin81t+Z4Wrg98Wni8dnAmjJbW9/t4xlMJij6UohsRasgh7IvUyHlITHiB+MvDiL/89VV+bQhlV8MmzNRainjgRN0XNkCtenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSBPR02CA0014.apcprd02.prod.outlook.com (2603:1096:301::24) by
 SEZPR06MB5296.apcprd06.prod.outlook.com (2603:1096:101:7c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 19 Mar 2025 06:09:12 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::f1) by PSBPR02CA0014.outlook.office365.com
 (2603:1096:301::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 06:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 06:09:11 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A08414160CA0;
	Wed, 19 Mar 2025 14:09:10 +0800 (CST)
Date: Wed, 19 Mar 2025 14:09:03 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
	<cassel@kernel.org>,
	<wojciech.jasko-EXT@continental-corporation.com>,
	<thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
	<linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
Message-ID: <Z9pffxeXHVOsoi4O@nchen-desktop>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307103128.3287497-1-s-vadapalli@ti.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|SEZPR06MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: ff635b0e-b0ba-4d92-4483-08dd66ac9194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zYpyojsX0zvzwAKuaHVj/VUicyrJmSMMJ1UQ2vzMnqJf2BBZgKIuADsBr2eT?=
 =?us-ascii?Q?v+b90cWyLOZs5uIsfCT7+l4bFX5TmOvaIJ32V/Y7vhOy4vj6kJ0jfcoEMcKv?=
 =?us-ascii?Q?mla6nx3T9K979Ya6mx5Tgv5x2P9y8eW2hFzdHIHkSms1zKuCeU8rVRW0DsjK?=
 =?us-ascii?Q?TWFzNQh1fTAal9pvgyjKspaPUHUiYE2RHtcEWZuQ1+TK8MEqW1Hea+rgp16U?=
 =?us-ascii?Q?2H3EYnWZAC3b+HbUJbQkVVO/ObNnMpjbFlJvYHgD4DuQ3Uk3Oe2XykbpPJKB?=
 =?us-ascii?Q?0fAD0b/3MP0P1aHWUlnAvS6eSTxvi1VQfMBUzJOku8/rRO4+wEmwaN1Z8a87?=
 =?us-ascii?Q?RMWXvu5IpRflbIR0eito9dLZEfswAxFPaUgEvHkrhQTkVPxt43KjPMDqwtTj?=
 =?us-ascii?Q?56FQaWif9CemC5IFOBwoahjAs1VuCEoxVoa1pe6hontMs/dR+sbge64E76wy?=
 =?us-ascii?Q?UMeCGy98k1PeYXb3YyVkqljUFuY8dr5qmvFWnYud3AlG9hPqpZQWk/yFdq8d?=
 =?us-ascii?Q?GJemha4E9YM4DbGKILjRbeNcFosKQUxBpyqqXGHud6fCel9sSKAVDUYIHmza?=
 =?us-ascii?Q?N5SEGtpziwY4eWBJrJymf0yZcmTIy0o2mE/CKeR8G3Hr0QTPC0ABjAHFe7UL?=
 =?us-ascii?Q?lUJTRgVJC1A1RcHdTSV1MprWoapy/286y1wcrCTTFtBoJdqkQis9AqiFLJKP?=
 =?us-ascii?Q?KJzVwovfpSIAd5EGWDqZYpUR5aA2agXMKbkhm4qLi7WxolvSUK7XyCgSUZW5?=
 =?us-ascii?Q?xBKm2ejfX/0OmBrIsANNBBHMFCKDbRxY8xVyxzPJ9w8/tiG5prlMtXtwoZVx?=
 =?us-ascii?Q?NcKx4m3Ot2v8YrXNrpv+xpzMvfGUFW0q+sBf24eTkNlKZQayQFnAY81PhplD?=
 =?us-ascii?Q?3ETj6Xz4SV4ycpGe6EMS3dsWxchTkmuPf5SfYigMdkuApyvDPbxl+Tg8lvHX?=
 =?us-ascii?Q?WrPP61gYNrT7X7zjGozaNuphvG0e4f50UWdEmbNdDTyZYZT89W+KYC41VyGl?=
 =?us-ascii?Q?IhX0XN1rPdvcq4zOUYClz1Q/dmMI02X0YJ/sqWGPCumrZ0+WFO1tmT9HXj2l?=
 =?us-ascii?Q?Cw/gzbCsQeiPLsd9wu26J8Y/nTlxK/rmW6TK6/osEJsJS4OxtsbBCPK7QPl3?=
 =?us-ascii?Q?WOo4OSkTog3UtqN5t4MxVh6X4kbAQECpu7F13MnGwRsVP6oNWsZ4CGI5MnlX?=
 =?us-ascii?Q?lhikhjjR5LGGrDVzLrOvwjbZfu8UlPlG1JUHUYWZZuIN3efuThopJdQyZ91a?=
 =?us-ascii?Q?pfcL6+1/siR3Hf9X9DnlU2AjxNXCUl6UDjrmcxo6kRo8Vlcl9LSrrlKJIwGk?=
 =?us-ascii?Q?VF19qDso1w9vngVWAec1nQz508DCxCu31fmJc9hOwkY4tZI+6cZlA+n1RqmW?=
 =?us-ascii?Q?gSIi2/M8LITWKZJQ5QFx2CRSbcW7VOJGuxfAsjxwOUvFsLwF5pqBw5jF9OfV?=
 =?us-ascii?Q?TB0PtE/7JwsSmomaMsV7MGT1nz+FGppmn3q3jDT3nbZtpAzx3ru7lPZ1xF+l?=
 =?us-ascii?Q?2USNuElI2ovefJk=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:09:11.6799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff635b0e-b0ba-4d92-4483-08dd66ac9194
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5296

On 25-03-07 16:01:24, Siddharth Vadapalli wrote:
> EXTERNAL EMAIL
> 
> Hello,
> 
> This series enables support to build the PCIe Cadence Controller drivers
> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
> Modules. The motivation for this series is that PCIe is not a necessity
> for booting the SoC, due to which it doesn't have to be a built-in
> module. Additionally, the defconfig doesn't enable the PCIe Cadence
> Controller drivers and the PCI J721E driver, due to which PCIe is not
> supported by default. Enabling the configs as of now (i.e. without this
> series) will result in built-in drivers i.e. a bloated Linux Image for
> everyone who doesn't have the PCIe Controller.

If the user doesn't enable PCIe controller device through DTS/ACPI,
that's doesn't matter.

> @@ -209,6 +209,12 @@ CONFIG_NFC=m
>  CONFIG_NFC_NCI=m
>  CONFIG_NFC_S3FWRN5_I2C=m
>  CONFIG_PCI=y
> +CONFIG_PCI_J721E=m
> +CONFIG_PCI_J721E_HOST=m
> +CONFIG_PCI_J721E_EP=m
> +CONFIG_PCIE_CADENCE=m
> +CONFIG_PCIE_CADENCE_HOST=m
> +CONFIG_PCIE_CADENCE_EP=m

The common Cadence configuration will be select if the glue layer's
configuration is select according to Kconfig.

Please do not set common configuration as module, some user may need
it as build-in like dw's. Considering the situation, the rootfs is at
NVMe.

Peter

>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCIEAER=y
>  CONFIG_PCI_IOV=y
> 
> Regards,
> Siddharth.
> 
> Kishon Vijay Abraham I (1):
>   PCI: cadence: Add support to build pcie-cadence library as a kernel
>     module
> 
> Siddharth Vadapalli (3):
>   PCI: cadence-host: Introduce cdns_pcie_host_disable helper for cleanup
>   PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
>   PCI: j721e: Add support to build as a loadable module
> 
>  drivers/pci/controller/cadence/Kconfig        |  12 +-
>  drivers/pci/controller/cadence/pci-j721e.c    |  37 +++++-
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  16 +++
>  .../controller/cadence/pcie-cadence-host.c    | 113 ++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.c |  12 ++
>  drivers/pci/controller/cadence/pcie-cadence.h |  14 ++-
>  6 files changed, 194 insertions(+), 10 deletions(-)
> 
> --
> 2.34.1
> 
> 

-- 

Best regards,
Peter

