Return-Path: <linux-pci+bounces-4001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B5867361
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F78F1F28760
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDD2D048;
	Mon, 26 Feb 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C67iil7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCC2CCD5
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947458; cv=fail; b=H5i+bBwZQc3WkK8XHi7xbmlz0mQZf1gpe+q2QAiwVp/aec36L2X1k/ydDT2yWLCn6AmOtdibgOgCeUZC7YTdETQIyA7m33DauqdwICsziv1zVf8kRQFtTPcqajMdxTDi/hsKpA8Pu1lZLZDKtDJlw0JGTFfRucjq1SyNoDUoN/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947458; c=relaxed/simple;
	bh=iX/MryBiZvPKKeWaz7GRmFfPVerYeUfqMgW1NXc9hSI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxeqpcN2LJ45f+U8bvlTCt6zig8K5CtWUFMWLm+yyDrDzj0KpcrjF6uRY1IkkN0Y05x1XdFDBj1Yqp3cruCcIvFb3mp+iTcgkNPPjKPSeTvpuGco83lAHAgYWKBVSD1PLOlbjmJ26qoRyJpK0b9LyL2rJNvhB/eUe0axM6wQc9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C67iil7g; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msDPVH5D+HLVKoypPO6wqrIOO5d3wQUdWtTE44qz64ZMY7d/Tt5/JoWMFKv3XXki/XTmTa0xoC5ppP3t6qbgV0qKME0pDH+hF9nsjBRsJXNTY30fnL1p8PXxBDSYOQi2JlpocQyQ3uuP8Z0E4+anjX3oLRdjc1L7tRaxO39B0otdh/xsoMbDO3wveCAmT6nwpcOfwtiB6DPtihoEL2fyS+5UG/jNpBBnRUUwQEooB/Vao6S6uAJJMt5mt/1d8l+h9utjhpe/ueCAB8qo8dl94eY1+B5Y56gXpTAbcyKJRC7NQp7EWapkeLXV+daqEFHSPZlfCiwRyu/TLrH6+ZNggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJIF+K5PibwYkj0WJ39A0Gv8KkiG91TYA1Xnkp2VmqM=;
 b=Zm3kV2JZslTSjtDTeZenBph7ZpN9GNUeGQV9ScSBGqNWrFUPPDfTFwTX8p2B1AJp60PIoM1KZof+3bDUemn/LFO/DZvrp32UHF1gtcXt5q2ugkl/bvKQ2gc1ADmRjrDsH/fmx2c2pu8GNH/9bf+6eM/0wTMqp6ml3U8U2bOFHBgWKOZTiyOrP8OvPx3UU5onUPrJCHddkaAtRxFFJjWaXjK2wREBL5rKEwpZiyc9MOv7l9H+/yCzS6c/IYurX5qHo277nuZ1+NaUtj5cem4mFXjNQZv989TwKeLZ9M4IInJytP6BicHU6FxjkU/OOvnEaNLrLSX6dl5ZOdLUY4ml6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJIF+K5PibwYkj0WJ39A0Gv8KkiG91TYA1Xnkp2VmqM=;
 b=C67iil7gJEXRp3jBKXubgY0PbY3G/dqHJMQX4RMg8ylNpOSYm7b4JjP4EpU8zlnJ5wj0q3U6J+hucLA6v6Han5/hmGBlJivnY6h2Qj+gT+34IgM9ZPdQDvc9R1p5nf/JzoYNKccNr1cOkXHf4I73938WpEkCbfXoDY7bsgC2XzMN3Y8eOoFqsZbCzlZF2Lno8TUqo1qr1dG2z+u4ihr0PWIwFGDiF2DxAgh5mPAFF+mPATG9uI4e50QFOCr4O7xgkhiisaOHSdKH6LPoAOm+Aa6W5YlTWq1xWASuUzDuE9LGfq5XtIFvEM0oMx6jB+DnL9DaYXx/1qutxrzPsewtYQ==
Received: from CYZPR05CA0004.namprd05.prod.outlook.com (2603:10b6:930:89::25)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 11:37:32 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::e6) by CYZPR05CA0004.outlook.office365.com
 (2603:10b6:930:89::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25 via Frontend
 Transport; Mon, 26 Feb 2024 11:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 11:37:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 26 Feb
 2024 03:37:16 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 26 Feb
 2024 03:37:12 -0800
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 26 Feb
 2024 03:37:09 -0800
Date: Mon, 26 Feb 2024 13:37:08 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <zhiwang@kernel.org>, <gdhanuskodi@nvidia.com>,
	<cjia@nvidia.com>, <acurrid@nvidia.com>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20240226133708.00005e8e.zhiw@nvidia.com>
In-Reply-To: <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
	<170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8754f152-3eac-45e3-718e-08dc36bf51c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZljTC/FNUC1FmTxtBKDt6bvKrrvGhDh68ZaNmfTnHW+bNUjccvDz38+GiYw8YYKyqeRkaHXAxjhQxj6I5sj1Zqa+nVcPzBZeVlgJYpsfM3KZdbi7/aZPWc//iMorTWUvWxX2nXqogvqhT3cngJSv6bZV/T5nDkt0wbbtFFp38V+/YgQVNQps5anS53YeFT7NOVd5DXQKk4qzTkxe9GkZgdq0WT/TgnMjLggedlH0It7jcEvn3+PWzmBXwT6z6YdzEl8JhVucv2pE+MwNHV3z2ZGBzw5PlJpA1bZlWDQxryMkLICxLDXRa0a1g4rQhCAN7a91QPkRRnPn/TN0QaEZ8JMUgJNTjpep7rLaLB/lEwHrXAS8UDWc+mCmVGDXzhSJkGjSzeBhO3W50rDotph1K3lXExxalWcp9F29h9+ybtLv4Bb4b1eHtLTAPtmmsgsC+BnNzKHPVjvoGXek8K8KfEti1kXSKL+bIjoyyfOi1+XflXJRjlGLemEVoghYAT6MrUV474LgGb6AnqG9vIZfrSV3hCge8vvdcGjwG2t9qN9V5zuowRPGcy7G+Ll6tnpScaeZqVUjnLPaazKHPquvu4kwAnv3r6vMXxo9vt1Gs8XTbjskdb/DyCyqem76GMANBP1oGiaEIfXC4PYHp3GJ0GYnrhQE7G+J4SCeopFvV8T+rXq6mJMQhshZ3/xWPYt66K9prNDLgR3wTBa3EHAwDZc1rH5kQrLHQwRDaRqFtVnSIbA4RYNK/047jnANPFzY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 11:37:31.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8754f152-3eac-45e3-718e-08dc36bf51c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

On Tue, 30 Jan 2024 01:24:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe 6.1 specification, section 11, introduces the Trusted
> Execution Environment (TEE) Device Interface Security Protocol
> (TDISP). This interface definition builds upon CMA, component
> measurement and authentication, and IDE, link integrity and data
> encryption. It adds support for establishing virtual functions within
> a device that can be assigned to a confidential VM such that the
> assigned device is enabled to access guest private memory protected
> by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP
> specification of an agent that mediates between a device security
> manager (DSM) and system software in both a VMM and a VM. From a
> Linux perspective the TSM abstracts many of the details of TDISP,
> IDE, and CMA. Some of those details leak through at times, but for
> the most part TDISP is an internal implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory
> of the PCI device sysfs interface. Unlike CMA that can depend on a
> local to the PCI core implementation, PCI_TSM needs to be prepared
> for late loading of the platform TSM driver. Consider that the TSM
> driver may itself be a PCI driver. Userspace can depend on the common
> TSM device uevent to know when the PCI core has TSM services enabled.
> The PCI device tsm/ subdirectory is supplemented by the TSM device
> pci/ directory for platform global TSM properties + controls.
> 
> All vendor TSM implementations share the property of asking the VMM to
> perform DOE mailbox operations on behalf of the TSM. That common
> capability is centralized in PCI core code that invokes an ->exec()
> operation callback potentially multiple times to service a given
> request (struct pci_tsm_req). Future operations / verbs will be
> handled similarly with the "request + exec" model. For now, only
> "connect" and "disconnect" are implemented which at a minimum is
> expected to establish IDE for the link.
> 
> In addition to requests the low-level TSM implementation is notified
> of device arrival and departure events so that it can filter devices
> that the TSM is not prepared to support, or otherwise setup and
> teardown per-device context.
> 

Hey Dan,

1) What is the expectation of using the device connect and disconnect
in the guest-driven secure I/O enlightenment? In the last device
security meeting, you said the sysfs interface was mostly for higher
level software stacks, like virt-manager. I was wondering what would be
the picture looks like when coping these statement with the
guest-driven model. Are we expecting the device connect triggered by
QEMU when extracting the guest request from the secure channel in
this case?

2) How does the device-specific logic fit into the new TSM
services? E.g. when the TDISP connect is triggered by userspace, a
device needs to perform quirks before/after/inside the verbs, or a
device needs an interface to tell TSM service when it is able to
response to some verbs. Do you think we needs to have a set of
callbacks from the device side for the PCI TSM service to call?

Thanks,
Zhi.

> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci   |   43 +++-
>  Documentation/ABI/testing/sysfs-class-tsm |   23 ++
>  drivers/pci/Kconfig                       |   15 +
>  drivers/pci/Makefile                      |    2 
>  drivers/pci/cma.c                         |    5 
>  drivers/pci/pci-sysfs.c                   |    3 
>  drivers/pci/pci.h                         |   14 +
>  drivers/pci/probe.c                       |    1 
>  drivers/pci/remove.c                      |    1 
>  drivers/pci/tsm.c                         |  346
> +++++++++++++++++++++++++++++ drivers/virt/coco/tsm/Makefile
>   |    1 drivers/virt/coco/tsm/class.c             |   22 +-
>  drivers/virt/coco/tsm/pci.c               |   83 +++++++
>  drivers/virt/coco/tsm/tsm.h               |   28 ++
>  include/linux/pci.h                       |    3 
>  include/linux/tsm.h                       |   77 ++++++
>  include/uapi/linux/pci_regs.h             |    3 
>  17 files changed, 662 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/pci/tsm.c
>  create mode 100644 drivers/virt/coco/tsm/pci.c
>  create mode 100644 drivers/virt/coco/tsm/tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> b/Documentation/ABI/testing/sysfs-bus-pci index
> 35b0e11fd0e6..0eef2128cf09 100644 ---
> a/Documentation/ABI/testing/sysfs-bus-pci +++
> b/Documentation/ABI/testing/sysfs-bus-pci @@ -508,11 +508,16 @@
> Description: This file contains "native" if the device authenticated
>  		successfully with CMA-SPDM (PCIe r6.1 sec 6.31). It
> contains "none" if the device failed authentication (and may thus be
> -		malicious).
> +		malicious). It transitions from "native" to "tsm"
> after
> +		successful connection to a tsm, see the "connect"
> attribute
> +		below.
>  
>  		Writing "native" to this file causes
> reauthentication with kernel-selected keys and the kernel's
> certificate chain.  That
> -		may be opportune after updating the .cma keyring.
> +		may be opportune after updating the .cma keyring.
> Note
> +		that once connected to a tsm this returns -EBUSY to
> attempts to
> +		write "native", i.e. first disconnect from the tsm
> to retrigger
> +		native authentication.
>  
>  		The file is not visible if authentication is
> unsupported by the device.
> @@ -529,3 +534,37 @@ Description:
>  		The reason why authentication support could not be
> determined is apparent from "dmesg".  To probe for authentication
> support again, exercise the "remove" and "rescan" attributes.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a device supports CMA
> and IDE,
> +		and only after a TSM driver has loaded and accepted
> / setup this
> +		PCI device. Similar to the 'authenticated'
> attribute, trigger
> +		"remove" and "rescan" to retry the initialization.
> See
> +		Documentation/ABI/testing/sysfs-class-tsm for
> enumerating the
> +		platform's TSM capabilities.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the TSM to
> establish a
> +		secure connection with the device. This typically
> includes an
> +		SPDM (DMTF Security Protocols and Data Models)
> session over PCIe
> +		DOE (Data Object Exchange) and PCIe IDE (Integrity
> and Data
> +		Encryption) establishment. For TSMs and devices that
> support
> +		both modes of IDE ("link" and "selective") the
> "connect_mode"
> +		attribute selects the mode.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect_mode
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) Returns the available connection modes
> optionally with
> +		brackets around the currently active mode if the
> device is
> +		connected. For example it may show "link selective"
> for a
> +		disconnected device, "link [selective]" for a
> selective
> +		connected device, and it may hide a mode that is not
> supported
> +		by the device or TSM.
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm
> b/Documentation/ABI/testing/sysfs-class-tsm index
> 304b50b53e65..77957882738a 100644 ---
> a/Documentation/ABI/testing/sysfs-class-tsm +++
> b/Documentation/ABI/testing/sysfs-class-tsm @@ -10,3 +10,26 @@
> Description: For software TSMs instantiated by a software module,
> @host is a directory with attributes for that TSM, and those
> attributes are documented below.
> +
> +
> +What:		/sys/class/tsm/tsm0/pci/link_capable
> +Date:		January, 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) When present this returns "1\n" to indicate
> that the TSM
> +		supports establishing Link IDE with a given
> root-port attached
> +		device. See "tsm/connect_mode" in
> +		Documentation/ABI/testing/sysfs-bus-pci
> +
> +
> +What:		/sys/class/tsm/tsm0/pci/selective_streams
> +Date:		January, 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) When present this returns the number of
> currently available
> +		selective IDE streams available to the TSM. When a
> stream id is
> +		allocated this number is decremented and a link to
> the PCI
> +		device(s) consuming the stream(s) appears alonside
> this
> +		attribute in the /sys/class/tsm/tsm0/pci/ directory.
> See
> +		"tsm/connect" and "tsm/connect_mode" in
> +		Documentation/ABI/testing/sysfs-bus-pci.
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a5c3cadddd6f..11d788038d19 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -129,6 +129,21 @@ config PCI_CMA
>  	  A PCI DOE mailbox is used as transport for DMTF SPDM based
>  	  authentication, measurement and secure channel
> establishment. 
> +config PCI_TSM
> +	bool "TEE Security Manager for Device Security"
> +	depends on PCI_CMA
> +	depends on TSM
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform
> agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device
> functions
> +	  (virtual or physical) to confidential computing VMs that
> can
> +	  access (DMA) guest private memory.
> +
> +	  Say Y to enable the PCI subsystem to enable the IDE and
> +	  TDISP capabilities of devices via TSM semantics.
> +
>  config PCI_DOE
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b5d1d15b9..c4117d67ea83 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -38,6 +38,8 @@ obj-$(CONFIG_PCI_CMA)		+= cma.o
> cma.asn1.o $(obj)/cma.o:			$(obj)/cma.asn1.h
>  $(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
>  
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
> +
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> index be7d2bb21b4c..5a69e9919589 100644
> --- a/drivers/pci/cma.c
> +++ b/drivers/pci/cma.c
> @@ -39,6 +39,9 @@ static ssize_t authenticated_store(struct device
> *dev, if (!sysfs_streq(buf, "native"))
>  		return -EINVAL;
>  
> +	if (pci_tsm_authenticated(pdev))
> +		return -EBUSY;
> +
>  	rc = pci_cma_reauthenticate(pdev);
>  	if (rc)
>  		return rc;
> @@ -55,6 +58,8 @@ static ssize_t authenticated_show(struct device
> *dev, (pdev->cma_init_failed || pdev->doe_init_failed))
>  		return -ENOTTY;
>  
> +	if (pci_tsm_authenticated(pdev))
> +		return sysfs_emit(buf, "tsm\n");
>  	if (spdm_authenticated(pdev->spdm_state))
>  		return sysfs_emit(buf, "native\n");
>  	return sysfs_emit(buf, "none\n");
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 368c4f71cc55..4327f8c2e6b5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1654,6 +1654,9 @@ const struct attribute_group
> *pci_dev_attr_groups[] = { #endif
>  #ifdef CONFIG_PCI_CMA
>  	&pci_cma_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_attr_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2b7d8d0b2e21..daa20866bc90 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -350,6 +350,20 @@ static inline int pci_cma_reauthenticate(struct
> pci_dev *pdev) }
>  #endif
>  
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +bool pci_tsm_authenticated(struct pci_dev *pdev);
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +static inline bool pci_tsm_authenticated(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6b09c962c0b8..f60d6c3c8c48 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2542,6 +2542,7 @@ static void pci_init_capabilities(struct
> pci_dev *dev) pci_rcec_init(dev);		/* Root Complex
> Event Collector */ pci_doe_init(dev);		/* Data Object
> Exchange */ pci_cma_init(dev);		/* Component
> Measurement & Auth */
> +	pci_tsm_init(dev);		/* TEE Security Manager
> connection */ 
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index f009ac578997..228fa6ccf911 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	pci_tsm_destroy(dev);
>  	pci_cma_destroy(dev);
>  	pci_doe_destroy(dev);
>  	pcie_aspm_exit_link_state(dev);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..f74de0ee49a0
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security
> Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include <linux/sysfs.h>
> +#include <linux/xarray.h>
> +#include "pci.h"
> +
> +/* collect tsm capable devices to rendezvous with the tsm driver */
> +static DEFINE_XARRAY(pci_tsm_devs);
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct tsm_pci_ops *tsm_ops;
> +
> +void generic_pci_tsm_req_free(struct pci_tsm_req *req)
> +{
> +	kfree(req);
> +}
> +EXPORT_SYMBOL_GPL(generic_pci_tsm_req_free);
> +
> +struct pci_tsm_req *generic_pci_tsm_req_alloc(struct pci_dev *pdev,
> enum pci_tsm_op op) +{
> +	struct pci_tsm_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
> +
> +	if (!req)
> +		return NULL;
> +	req->op = op;
> +	return req;
> +}
> +EXPORT_SYMBOL_GPL(generic_pci_tsm_req_alloc);
> +
> +DEFINE_FREE(req_free, struct pci_tsm_req *, if (_T)
> tsm_ops->req_free(_T)) +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_req *req __free(req_free) = NULL;
> +
> +	/* opportunistic state checks to skip allocating a request */
> +	if (pdev->tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +
> +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_DISCONNECT);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
> +		enum pci_tsm_op_status status;
> +
> +		/* revalidate state */
> +		if (pdev->tsm->state < PCI_TSM_CONNECT)
> +			return 0;
> +		if (pdev->tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		do {
> +			status = tsm_ops->exec(pdev, req);
> +			req->seq++;
> +			/* TODO: marshal SPDM request */
> +		} while (status == PCI_TSM_SPDM_REQ);
> +
> +		if (status == PCI_TSM_FAIL)
> +			return -EIO;
> +		pdev->tsm->state = PCI_TSM_INIT;
> +	}
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_req *req __free(req_free) = NULL;
> +
> +	/* opportunistic state checks to skip allocating a request */
> +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +
> +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_CONNECT);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
> +		enum pci_tsm_op_status status;
> +
> +		/* revalidate state */
> +		if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +			return 0;
> +		if (pdev->tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		do {
> +			status = tsm_ops->exec(pdev, req);
> +			req->seq++;
> +		} while (status == PCI_TSM_SPDM_REQ);
> +
> +		if (status == PCI_TSM_FAIL)
> +			return -EIO;
> +		pdev->tsm->state = PCI_TSM_CONNECT;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct
> device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	bool connect;
> +	int rc = kstrtobool(buf, &connect);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (rc)
> +		return rc;
> +
> +	if (connect) {
> +		if (!spdm_authenticated(pdev->spdm_state)) {
> +			pci_dbg(pdev, "SPDM authentication
> pre-requisite not met.\n");
> +			return -ENXIO;
> +		}
> +		rc = pci_tsm_connect(pdev);
> +		if (rc)
> +			return rc;
> +		return len;
> +	}
> +
> +	rc = pci_tsm_disconnect(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct
> device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sysfs_emit(buf, "%d\n", pdev->tsm->state >=
> PCI_TSM_CONNECT); +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static const char *const pci_tsm_modes[] = {
> +	[PCI_TSM_MODE_LINK] = "link",
> +	[PCI_TSM_MODE_SELECTIVE] = "selective",
> +};
> +
> +static ssize_t connect_mode_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int i;
> +
> +	guard(mutex)(tsm_ops->lock);
> +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +		return -EBUSY;
> +	for (i = 0; i < ARRAY_SIZE(pci_tsm_modes); i++)
> +		if (sysfs_streq(buf, pci_tsm_modes[i]))
> +			break;
> +	if (i == PCI_TSM_MODE_LINK) {
> +		if (pdev->tsm->link_capable)
> +			pdev->tsm->mode = PCI_TSM_MODE_LINK;
> +		return -EOPNOTSUPP;
> +	} else if (i == PCI_TSM_MODE_SELECTIVE) {
> +		if (pdev->tsm->selective_capable)
> +			pdev->tsm->mode = PCI_TSM_MODE_SELECTIVE;
> +		return -EOPNOTSUPP;
> +	} else
> +		return -EINVAL;
> +	return len;
> +}
> +
> +static ssize_t connect_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char
> *buf) +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t count = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pci_tsm_modes); i++) {
> +		if (i == PCI_TSM_MODE_LINK) {
> +			if (!pdev->tsm->link_capable)
> +				continue;
> +		} else if (i == PCI_TSM_MODE_SELECTIVE) {
> +			if (!pdev->tsm->selective_capable)
> +				continue;
> +		}
> +
> +		if (i == pdev->tsm->mode)
> +			count += sysfs_emit_at(buf, count, "[%s] ",
> +					       pci_tsm_modes[i]);
> +		else
> +			count += sysfs_emit_at(buf, count, "%s ",
> +					       pci_tsm_modes[i]);
> +	}
> +
> +	if (count)
> +		buf[count - 1] = '\n';
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(connect_mode);
> +
> +static umode_t pci_tsm_attr_visible(struct kobject *kobj, struct
> attribute *a, int n) +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (a == &dev_attr_connect_mode.attr) {
> +		if (pdev->tsm->link_capable ||
> pdev->tsm->selective_capable)
> +			return a->mode;
> +		return 0;
> +	}
> +
> +	return a->mode;
> +}
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm && pdev->tsm->state > PCI_TSM_IDLE)
> +		return true;
> +	return false;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	&dev_attr_connect_mode.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static int pci_tsm_add(struct pci_dev *pdev)
> +{
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return 0;
> +	scoped_guard(mutex, tsm_ops->lock) {
> +		if (pdev->tsm->state < PCI_TSM_INIT) {
> +			int rc = tsm_ops->add(pdev);
> +
> +			if (rc)
> +				return rc;
> +		}
> +		pdev->tsm->state = PCI_TSM_INIT;
> +	}
> +	return sysfs_update_group(&pdev->dev.kobj,
> &pci_tsm_attr_group); +}
> +
> +static void pci_tsm_del(struct pci_dev *pdev)
> +{
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	/* shutdown sysfs operations before tsm delete */
> +	pdev->tsm->state = PCI_TSM_IDLE;
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	guard(mutex)(tsm_ops->lock);
> +	tsm_ops->del(pdev);
> +}
> +
> +int pci_tsm_register(const struct tsm_pci_ops *ops)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long index;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (tsm_ops)
> +		return -EBUSY;
> +	tsm_ops = ops;
> +	xa_for_each(&pci_tsm_devs, index, pdev)
> +		pci_tsm_add(pdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);
> +
> +void pci_tsm_unregister(const struct tsm_pci_ops *ops)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long index;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (ops != tsm_ops)
> +		return;
> +	xa_for_each(&pci_tsm_devs, index, pdev)
> +		pci_tsm_del(pdev);
> +	tsm_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unregister);
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	u16 ide_cap;
> +	int rc;
> +
> +	if (!pdev->cma_capable)
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	struct pci_tsm *tsm __free(kfree) = kzalloc(sizeof(*tsm),
> GFP_KERNEL);
> +	if (!tsm)
> +		return;
> +
> +	tsm->ide_cap = ide_cap;
> +
> +	rc = xa_insert(&pci_tsm_devs, (unsigned long)pdev, pdev,
> GFP_KERNEL);
> +	if (rc) {
> +		pci_dbg(pdev, "failed to register tsm capable
> device\n");
> +		return;
> +	}
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pdev->tsm = no_free_ptr(tsm);
> +	pci_tsm_add(pdev);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pci_tsm_del(pdev);
> +	xa_erase(&pci_tsm_devs, (unsigned long)pdev);
> +	kfree(pdev->tsm);
> +	pdev->tsm = NULL;
> +}
> +
> +bool pci_tsm_authenticated(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +	return pdev->tsm && pdev->tsm->state >= PCI_TSM_CONNECT;
> +}
> diff --git a/drivers/virt/coco/tsm/Makefile
> b/drivers/virt/coco/tsm/Makefile index f7561169faed..a4f0d07d7d97
> 100644 --- a/drivers/virt/coco/tsm/Makefile
> +++ b/drivers/virt/coco/tsm/Makefile
> @@ -7,3 +7,4 @@ tsm_reports-y := reports.o
>  
>  obj-$(CONFIG_TSM) += tsm.o
>  tsm-y := class.o
> +tsm-$(CONFIG_PCI_TSM) += pci.o
> diff --git a/drivers/virt/coco/tsm/class.c
> b/drivers/virt/coco/tsm/class.c index a569fa6b09eb..a459e51c0892
> 100644 --- a/drivers/virt/coco/tsm/class.c
> +++ b/drivers/virt/coco/tsm/class.c
> @@ -8,13 +8,11 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/cleanup.h>
> +#include "tsm.h"
>  
>  static DECLARE_RWSEM(tsm_core_rwsem);
> -struct class *tsm_class;
> -struct tsm_subsys {
> -	struct device dev;
> -	const struct tsm_info *info;
> -} *tsm_subsys;
> +static struct class *tsm_class;
> +static struct tsm_subsys *tsm_subsys;
>  
>  int tsm_register(const struct tsm_info *info)
>  {
> @@ -52,6 +50,10 @@ int tsm_register(const struct tsm_info *info)
>  	dev = NULL;
>  	tsm_subsys = subsys;
>  
> +	rc = tsm_pci_init(info);
> +	if (rc)
> +		pr_err("PCI initialization failure: %d\n", rc);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
> @@ -65,6 +67,8 @@ void tsm_unregister(const struct tsm_info *info)
>  		return;
>  	}
>  
> +	tsm_pci_destroy(info);
> +
>  	if (info->host)
>  		sysfs_remove_link(&tsm_subsys->dev.kobj, "host");
>  	device_unregister(&tsm_subsys->dev);
> @@ -79,6 +83,13 @@ static void tsm_release(struct device *dev)
>  	kfree(subsys);
>  }
>  
> +static const struct attribute_group *tsm_attr_groups[] = {
> +#ifdef CONFIG_PCI_TSM
> +	&tsm_pci_attr_group,
> +#endif
> +	NULL,
> +};
> +
>  static int __init tsm_init(void)
>  {
>  	tsm_class = class_create("tsm");
> @@ -86,6 +97,7 @@ static int __init tsm_init(void)
>  		return PTR_ERR(tsm_class);
>  
>  	tsm_class->dev_release = tsm_release;
> +	tsm_class->dev_groups = tsm_attr_groups;
>  	return 0;
>  }
>  module_init(tsm_init)
> diff --git a/drivers/virt/coco/tsm/pci.c b/drivers/virt/coco/tsm/pci.c
> new file mode 100644
> index 000000000000..b3684ad7114f
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/pci.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/device.h>
> +#include "tsm.h"
> +
> +static ssize_t link_capable_show(struct device *dev,
> +				 struct device_attribute *attr, char
> *buf) +{
> +	struct tsm_subsys *subsys = container_of(dev,
> typeof(*subsys), dev); +
> +	return sysfs_emit(buf, "%u\n",
> subsys->info->link_stream_capable); +}
> +static DEVICE_ATTR_RO(link_capable);
> +
> +static ssize_t selective_streams_show(struct device *dev,
> +				      struct device_attribute *attr,
> char *buf) +{
> +	struct tsm_subsys *subsys = container_of(dev,
> typeof(*subsys), dev); +
> +	return sysfs_emit(buf, "%u\n",
> subsys->info->nr_selective_streams); +}
> +static DEVICE_ATTR_RO(selective_streams);
> +
> +static umode_t tsm_pci_attr_visible(struct kobject *kobj, struct
> attribute *a, int n) +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tsm_subsys *subsys = container_of(dev,
> typeof(*subsys), dev);
> +	const struct tsm_info *info = subsys->info;
> +
> +	if (a == &dev_attr_link_capable.attr) {
> +		if (info->link_stream_capable)
> +			return a->mode;
> +		return 0;
> +	}
> +
> +	if (a == &dev_attr_selective_streams.attr) {
> +		if (info->nr_selective_streams)
> +			return a->mode;
> +		return 0;
> +	}
> +
> +	return a->mode;
> +}
> +
> +static bool tsm_pci_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tsm_subsys *subsys = container_of(dev,
> typeof(*subsys), dev); +
> +	if (subsys->info->pci_ops)
> +		return true;
> +	return false;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(tsm_pci);
> +
> +static struct attribute *tsm_pci_attrs[] = {
> +	&dev_attr_link_capable.attr,
> +	&dev_attr_selective_streams.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group tsm_pci_attr_group = {
> +	.name = "pci",
> +	.attrs = tsm_pci_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(tsm_pci),
> +};
> +
> +int tsm_pci_init(const struct tsm_info *info)
> +{
> +	if (!info->pci_ops)
> +		return 0;
> +
> +	return pci_tsm_register(info->pci_ops);
> +}
> +
> +void tsm_pci_destroy(const struct tsm_info *info)
> +{
> +	pci_tsm_unregister(info->pci_ops);
> +}
> diff --git a/drivers/virt/coco/tsm/tsm.h b/drivers/virt/coco/tsm/tsm.h
> new file mode 100644
> index 000000000000..407c388a109b
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/tsm.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TSM_CORE_H
> +#define __TSM_CORE_H
> +
> +#include <linux/device.h>
> +
> +struct tsm_info;
> +struct tsm_subsys {
> +	struct device dev;
> +	const struct tsm_info *info;
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +int tsm_pci_init(const struct tsm_info *info);
> +void tsm_pci_destroy(const struct tsm_info *info);
> +extern const struct attribute_group tsm_pci_attr_group;
> +#else
> +static inline int tsm_pci_init(const struct tsm_info *info)
> +{
> +	return 0;
> +}
> +static inline void tsm_pci_destroy(const struct tsm_info *info)
> +{
> +}
> +#endif
> +
> +#endif /* TSM_CORE_H */
> +
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4a04ce7685e7..132962b21e04 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -522,6 +522,9 @@ struct pci_dev {
>  	struct spdm_state *spdm_state;	/* Security Protocol
> and Data Model */ unsigned int	cma_capable:1;	/*
> Authentication supported */ unsigned int	cma_init_failed:1;
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset
> */ phys_addr_t	rom;		/* Physical address if not
> from BAR */ diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 8cb8a661ba41..f5dbdfa65d8d 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -4,11 +4,15 @@
>  
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> +#include <linux/mutex.h>
>  
>  struct tsm_info {
>  	const char *name;
>  	struct device *host;
>  	const struct attribute_group **groups;
> +	const struct tsm_pci_ops *pci_ops;
> +	unsigned int nr_selective_streams;
> +	unsigned int link_stream_capable:1;
>  };
>  
>  #define TSM_REPORT_INBLOB_MAX 64
> @@ -74,4 +78,77 @@ int tsm_report_register(const struct
> tsm_report_ops *ops, void *priv, int tsm_report_unregister(const
> struct tsm_report_ops *ops); int tsm_register(const struct tsm_info
> *info); void tsm_unregister(const struct tsm_info *info);
> +
> +enum pci_tsm_op_status {
> +	PCI_TSM_FAIL = -1,
> +	PCI_TSM_OK,
> +	PCI_TSM_SPDM_REQ,
> +};
> +
> +enum pci_tsm_op {
> +	PCI_TSM_OP_CONNECT,
> +	PCI_TSM_OP_DISCONNECT,
> +};
> +
> +struct pci_tsm_req {
> +	enum pci_tsm_op op;
> +	unsigned int seq;
> +};
> +
> +struct pci_dev;
> +/**
> + * struct tsm_pci_ops - Low-level TSM-exported interface to the PCI
> core
> + * @add: accept device for tsm operation, locked
> + * @del: teardown tsm context for @pdev, locked
> + * @req_alloc: setup context for given operation, unlocked
> + * @req_free: teardown context for given request, unlocked
> + * @exec: run @req, may be invoked multiple times per @req, locked
> + * @lock: tsm work is one device and one op at a time
> + */
> +struct tsm_pci_ops {
> +	int (*add)(struct pci_dev *pdev);
> +	void (*del)(struct pci_dev *pdev);
> +	struct pci_tsm_req *(*req_alloc)(struct pci_dev *pdev,
> +					 enum pci_tsm_op op);
> +	struct pci_tsm_req *(*req_free)(struct pci_tsm_req *req);
> +	enum pci_tsm_op_status (*exec)(struct pci_dev *pdev,
> +				       struct pci_tsm_req *req);
> +	struct mutex *lock;
> +};
> +
> +enum pci_tsm_state {
> +	PCI_TSM_IDLE,
> +	PCI_TSM_INIT,
> +	PCI_TSM_CONNECT,
> +};
> +
> +enum pci_tsm_mode {
> +	PCI_TSM_MODE_LINK,
> +	PCI_TSM_MODE_SELECTIVE,
> +};
> +
> +struct pci_tsm {
> +	enum pci_tsm_state state;
> +	enum pci_tsm_mode mode;
> +	u16 ide_cap;
> +	unsigned int link_capable:1;
> +	unsigned int selective_capable:1;
> +	void *tsm_data;
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +int pci_tsm_register(const struct tsm_pci_ops *ops);
> +void pci_tsm_unregister(const struct tsm_pci_ops *ops);
> +void generic_pci_tsm_req_free(struct pci_tsm_req *req);
> +struct pci_tsm_req *generic_pci_tsm_req_alloc(struct pci_dev *pdev,
> +					      enum pci_tsm_op op);
> +#else
> +static inline int pci_tsm_register(const struct tsm_pci_ops *ops)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(const struct tsm_pci_ops *ops)
> +{
> +}
> +#endif
>  #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h
> b/include/uapi/linux/pci_regs.h index a39193213ff2..1219d50f8e89
> 100644 --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -742,7 +742,8 @@
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer
> 16.0 GT/s */ #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical
> Layer 32.0 GT/s */ #define PCI_EXT_CAP_ID_DOE	0x2E	/*
> Data Object Exchange */ -#define PCI_EXT_CAP_ID_MAX
> PCI_EXT_CAP_ID_DOE +#define PCI_EXT_CAP_ID_IDE	0x30	/*
> Integrity and Data Encryption */ +#define PCI_EXT_CAP_ID_MAX
> PCI_EXT_CAP_ID_IDE 
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> 
> 


