Return-Path: <linux-pci+bounces-35997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8DB547FD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659515A08E6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991F2797A4;
	Fri, 12 Sep 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2qCgitW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E83C0C;
	Fri, 12 Sep 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669812; cv=fail; b=gLpR2ICCnUO/BLt0E0HY+/TO6X1ycFvk+cLxLxGZ9iOMbfsJ3YAtF4yJPlkiLtIAVq2g49wR5no5fkFAkPTq5OxcqEuy4NbY5DWz00QELS00z/FsAHkjVv22lzrjM7ARCrtOQGW8LSWnBZE5GJobReRid4TJDTUMtiXBcQ+fRb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669812; c=relaxed/simple;
	bh=OzUUrVVnVI2wwuykz//YTZ7vOHNAf5suj1WUAcMFHrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WkkWlH1u0v+XS1xpRzBbJzEVgDSFBA7QtWRsQwFL/kAjLpeXYthIG8aw46zn990TGl/tcXvDrBb07qc2MUL/08tAAqjH3lUs4Ru2gN6VrGTWjLX4qiUhEL+XU1RG2+4RagMBsdYJTxAMNukGuwDSrP7fc+RjNrp9wMNJVoIyAmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2qCgitW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757669811; x=1789205811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OzUUrVVnVI2wwuykz//YTZ7vOHNAf5suj1WUAcMFHrQ=;
  b=m2qCgitW3Z9BEoHn9OGC59IX8Z7FdYUodr7TyCKfjMoD977QjX+7F0Xl
   l0HWrC1IxAucx5IfO2BIo/iEd4wyly7Ur/5hajGE1lw185dOvz0HXP7S7
   fFOrx7xewiPKjToxQNpOtYoqaO9Lk5QNP2hgTnep3a3DgoQNjUTVTCMXj
   0dWD/REnECKT0QlD4ogffMpN41r6miDfAgVYu1nW282DvO5ai1TnJNVZv
   0E1onkzYgOjUQ5R1cTwSLfGZ3ysLvTKsyGt8V6fInBA/2V92veIzLqqJ0
   yTXf5wNR0iuyLiAw/MWMczd6/+u480GmWbx2BL1tbrgVaom9m8xRHLsbx
   A==;
X-CSE-ConnectionGUID: BK+KGuxMR1Gp1lJMjLusSQ==
X-CSE-MsgGUID: uFV6Xd4VQhml9DbluRd2bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59710281"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59710281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:36:49 -0700
X-CSE-ConnectionGUID: 6xito9gsRgiBZUx+9UsHhA==
X-CSE-MsgGUID: kBMmlOZzSiOYmWQPItBzcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="197613536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:36:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:36:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 02:36:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK1XXfREKVRjj2kySQv9Ut6mDiPJB9cKWC9tIOJQMHermct0poSvNp2CTZJKIx0FFThh/vhErfzOGVAKogF5TJA8FPXdkyD8DxsPDryaJTzhxefHCIHT9bWYtua30wd1oxfDNOmh2gmFMCCe1i9VF3blPn9H8KskMqybG5oUTEtSnuc9g2EWrKEL7vv6KX+CzGIZklSS5JEaKTZxlIhM0xApjWWkslIMcAW8tRtuJHb2HDsh7NfTSJ/Ruvo9w27iTKY2SxlbPxy1/eRxAI3ALpNGenkE4ysaYKGXgfCvQkB+5jFjIiOYJGtMfMKafaF+VpKUDoXXbEr/6V54DSbhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZy1IHYAdu+FmVhdudoXiTPeBNv0WBeUMfVNzCuDguQ=;
 b=EQ/toM6uRP0cCjGaM9T/qsyphxqdvRPVjh3JElEWKYVglmbhI1qV1jB3XnDZ7we5IMuxTDMX0KXSoH/D0+cpIoEAQX6Hq9mOy3LPVH73aokm7W9sXRpGHtrYRwv/yHGVrP7jH134Hppbba+FWOyuLeh84VQEBhIAYEv7k/N6oQ2TZHQs7cXxilTybyhvCPe78afI4Ck9BhxVRE89c/qcp9irXZ3eLil7uDoRRktzyIF2eP1ERdFCCMIRbkLJZN4II9NDr4eVRLEDRZsNEjb5I6M0qMkUCNrbN/Htm/k+qAsWHS4A0Si4dKSzhu0Y0rqLWsh6BP7sT+UM6jGEgiD5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA1PR11MB8860.namprd11.prod.outlook.com (2603:10b6:806:468::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:36:39 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:36:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "sven@kernel.org" <sven@kernel.org>, "j@jannau.net"
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"neal@gompa.dev" <neal@gompa.dev>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "tjeznach@rivosinc.com"
	<tjeznach@rivosinc.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>, "quic_pbrahma@quicinc.com"
	<quic_pbrahma@quicinc.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "etzhao1900@gmail.com"
	<etzhao1900@gmail.com>
Subject: RE: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Topic: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Index: AQHcGs+jou022dxyx0qjk/1p/Y1JgrSPW5gQ
Date: Fri, 12 Sep 2025 09:36:38 +0000
Message-ID: <BL1PR11MB527129A9BBF84BAC106B327E8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
In-Reply-To: <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA1PR11MB8860:EE_
x-ms-office365-filtering-correlation-id: 66555117-9603-4ee8-d441-08ddf1dfdf48
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?YVGrc2tk4ZwUoWy+svDzsTsDDM1HNMH4ZP0uVYjPgvLPPHkB5Oh1VIjJOXfO?=
 =?us-ascii?Q?UMf0X9bcVsuFhOcE7AYSiJJze7+juz0Z8CuGgJZ7ft1vC/PdWSzCUGptpaFu?=
 =?us-ascii?Q?tvL5oXf2Ij+cAjSvioD1R+PUrCfMWuhSC80zAEPPRn8U1NbWGYPnncrZLKlj?=
 =?us-ascii?Q?8C7ZBmvRHkO6c7vg829z5oca+rV66Nchfas3C3/kDUDpzDIOEIl3hh0VbX3M?=
 =?us-ascii?Q?sAOrO+qXykIMR5cdBlUs4mUzw7FNrlrr0SEkybuAgHvq4LDp662R3iM8CJ2K?=
 =?us-ascii?Q?Ot156E0FzXKXiaLdV3J8GUNFlXMDMR52ySif3GAmIfjUFPN7m3QPxh7miXzU?=
 =?us-ascii?Q?V/b9ktrDDWExGhXADn21OGSMmw7oQ+EMRxdQDNuLOYzlttnATNmTlsDZ+rY+?=
 =?us-ascii?Q?VeFPy3qXI9qx5W6YkiW4gRPya7ImxGRyuZyI9CcmpQaHUXkmo0j/w1FanaLP?=
 =?us-ascii?Q?UmzX2yB3LpdapxPkkb/1QJiOoTIzMX07l8vkiW7LnA3p0agb8p4DkrGMu9M+?=
 =?us-ascii?Q?5z6ry67q0N1EAQ6m9a3VEuTfUw4io8OVfSX+sT2VsuAoPzsEy6SqZn8FA9ma?=
 =?us-ascii?Q?8lOq6aqoqU4VFtUEbhGyO3YBGvkRccDTx2exAOFS6ergpyaJtdEWRgdrZxWP?=
 =?us-ascii?Q?TSutXs7UmtpdjpaQQ78ulzaTbXKQohZ00CnMhxlRAsZt9czQEZZP7mFY5Q1V?=
 =?us-ascii?Q?GKMkiM0YfUXs8Kg0Cr+xV6e85JPAkYDOqD50NEvwIgETG9n91Cy2SjkP3IDn?=
 =?us-ascii?Q?ZaTSMIdkDjHQ/TIlmTH74h7YOaoApPT0pIVQr6+ipAOu9uJCDpQNUtdASzNa?=
 =?us-ascii?Q?k4Gkykz1z8FOdJr5TGgXs+jFpoi6BDfYeVYAAObGUp3novwNoTmJcuNiPrpx?=
 =?us-ascii?Q?4nn7mxjyBtSORGsr+XJR7s5fvjl564BL3VbzaS+B3em0BOojhywVK+Nm9VlE?=
 =?us-ascii?Q?vgd5YX5L8tub3VTi2hSnQARTl2pJNUKMK8FNsF+MdJmhCIDr8Ruuf8hQH+q5?=
 =?us-ascii?Q?l6k3mpP0TeEViHdo7GsBP2l4w5yKsH133PwVDyW7tQNsJEy48RIj5D3EZVgP?=
 =?us-ascii?Q?6dLh3dxwLkSPPBh610zXPk/eb0P2R4CoWWSStQV+eXjBnnt60WVs6QjiLJcQ?=
 =?us-ascii?Q?9MZFbfvH31n3SLPKGv15YoOkXl3OeGsKHvOueb4jbZUdiCbbbFdsOJ3Nn6pe?=
 =?us-ascii?Q?y0xlGltsEf5dIdGFOwm+EOofoKPS7u2pyQq98tJheq/cwLogbJ7e2JjwxrHY?=
 =?us-ascii?Q?lW7A9orMyq8lsdBIu5dXBZXFaO90nLV7lgEKQE+kfsXnhzgjS1/IS3BzTz6e?=
 =?us-ascii?Q?SQGU0jhawDYriIhPSiS7cKgeGVk0mqBI6Lx6NNGdyIeLb4p7xWgtqBT9V09b?=
 =?us-ascii?Q?rp3q6K0R/bGYJNbbhmDgXs6Y9C5kq6Aci6JXVbzwJwKYtR2J2tZ0drNYL+Is?=
 =?us-ascii?Q?EfvGt1Me1DKZd4ltZreqUI3p3hRLNXmnTs399/ZWK2QSRbRAHSoA4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S+PLaoIVxiHGnQNTa1Oo5XYl9feCOqoY/YA/hNm3/MuZCYHxOiuJ6atNU7Um?=
 =?us-ascii?Q?XocfjBbR5wkPLBPtsmgUywkp8TFoxY9il/IHbSbSDJ5CsD5oBYErNlcz2Jw3?=
 =?us-ascii?Q?fCLiMlVdLqAu2fTjCvtbEbXJZSvfX4SGg0xmD+Sty3IIagNxfTbBZqJNQWHt?=
 =?us-ascii?Q?7qcJzOrhB6E0Nug2WtRAaXoi01Mde89PCos2U2ED+vZnTk0Tef6RtsaRz0hH?=
 =?us-ascii?Q?VTdd3q8/15w6EsvBe0+BmhwCHzuYbVpdlHw23PU+cJR6hjFqJHuYkMz6ObRA?=
 =?us-ascii?Q?Svy33PGQBOWn1V3FTP7PdGcmA+lImEMg0EiRXf5MKSACocMHv7CKVmJe+nGe?=
 =?us-ascii?Q?+l0TzwOoeOSv+ryGfhgGiq4IjGmqat6SYTsXE5nfo7/EiEJPn27tWCFj0Gb+?=
 =?us-ascii?Q?HMG3FsISk2hNJbpSDfdO3nmZwalthdwbktHgLbvZBW8ZgO7xGFpIp7wmwuSW?=
 =?us-ascii?Q?DGzpjRKvnM0aXdmP4mvHtcztbz7LCilWwKz4oo85CJvWfxymyGKtnxyjZDvu?=
 =?us-ascii?Q?DchF2ofmfiITybesmfFpp7iGoqGVmNpoOm6opVGDEuJvqa+3qEcZTN2/yRGS?=
 =?us-ascii?Q?0OeVeAy+AlwiKSOMBgir8o2nFkrsHX7V9PXfKl4eDUp0OX0vYM7NzAbbrtGt?=
 =?us-ascii?Q?lpzHkoMXOGmU0RlqgOiErACnn6OtvTURtA4Pn7ajHBBJOrrmf3rGesHN9PQK?=
 =?us-ascii?Q?OdxlyeVWTk7InnjXomXt6RhICX7xTOVRc2reC+GKa2D1QUGmUqHhTblDX87k?=
 =?us-ascii?Q?x7FGN+wyhXyekBx4WRuN1mXVSuF4rjW8S8/SwE8NKiwJ/hE31GkYbmSp9GwT?=
 =?us-ascii?Q?F6kQixmN074/DfVqQ2sLhpyXtx+x/QRycB8nVTby3PmOAdOk5T7dwwFsoad6?=
 =?us-ascii?Q?mHlcZ6HA7/bXFLToOrwwXnSDNr8DtPoTScBlWVg0h4d/D8ZDXBzLv6mQbFDb?=
 =?us-ascii?Q?IjTspMVuZEe+0y2rz4m1+TlEkgEtoNIqi0wrLQiXd+Tr8VliJi5UTMoy5Sp5?=
 =?us-ascii?Q?QaLJSvujeHbOGofGQUrK59Ip/Frf0CbMMnRx4B0zh5TODhc+jz3Gsykh1fWw?=
 =?us-ascii?Q?/MqQ45bLHNfr+vPjK5SZswn6WYoIb4c92BoWiTnTeimbki5C9tPDVTtCjpnK?=
 =?us-ascii?Q?ARx3HDCoEx9lJkfuT7i53sQvzowvrkIcZPxHEKjZ/Jy4/e6yrO4WioB+PC0P?=
 =?us-ascii?Q?tzmuVdsLGq/h0+QSGFl6Scg3CXsVi095qHV2hEL4FmvmZ3y/bx1LMMkzNu/k?=
 =?us-ascii?Q?FXkvSOoPv/OXOnNJuyBrvT/6smwS4fyJ4wduWqfRef6IxjWUKWJSEm3sG/Rd?=
 =?us-ascii?Q?iR8h8Eouvhy4qXmLz81H8zFPpzQsgIiwcMs1IrYPCA3jf8/3oJpB1Shy6stg?=
 =?us-ascii?Q?WVfCtGdM+Sc3S3MWsqI8Vsoan4ekL9qO1GcvBc1BW6QdqZ9GS3KSXu7BQCqi?=
 =?us-ascii?Q?qzXleCTfy5QOKRibuJj5S545SHEF63mSZoaasLRFGu6u8mxMDA2MBiLFg5Wm?=
 =?us-ascii?Q?V5SgFNksoHnR4ygyp2slhNWIZNvYAk1c79JHesG1EgXCRuvZhjdtoqpJbvi5?=
 =?us-ascii?Q?jM9j/TO2DapHu8LWTYew9pAp8NHdtmHeXbiQP3Rj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66555117-9603-4ee8-d441-08ddf1dfdf48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:36:38.2192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez2/BCGcoid4zZj5PcKqFFa0WW80FupjaYRoLfMI/1g67T8/zslWatcy8TiRFqgWC3+mcjvEiDyg/f7bR/NViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8860
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, September 1, 2025 7:32 AM
>=20
>=20
> +/* Caller must be a general/external function that isn't an IOMMU callba=
ck
> */
>  struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>  {

'general function' is not easy to get its meaning. just keep 'external'?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

