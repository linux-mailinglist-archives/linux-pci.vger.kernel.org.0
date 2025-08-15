Return-Path: <linux-pci+bounces-34102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A3B27CE8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E7B0578C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4542D29C3;
	Fri, 15 Aug 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXSyfmlF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562526657B;
	Fri, 15 Aug 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249275; cv=fail; b=lX+1H2a5kx71M2Ol80L9TfMNo4Z7aFLouJ/dnlcsthA1dxztitWrGO/TkJMGRW94rwVPoXKNOfyUOAn8Xy4kob0SMJvono5ZwUNhnUMb9LfcdEDZhA0v9SGh0WlqkJ5miQiC3PrTdFdd+ssxvfNz6do4O4pIEC4f7Yn7u0GZ3X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249275; c=relaxed/simple;
	bh=EqbAQLSWHx738CzHddmJq2uNlI0VyDR98MeznA9bD/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XehQO0bGcnC2JouvE2SSPvW/Tvw3DzyyrMXxj1qDCotTTaaPMBcaLPQvmJpzYyE69gPCGOsKmXqRoLqw8JJepUy4T+qIpncSLMFm9RAXtkLJ3mg5GW87eFPawMwLytOkRNzfTUOZRh3oX9daLLXG+ODyE3Ua/LctIV+RoUbGL4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXSyfmlF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249274; x=1786785274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EqbAQLSWHx738CzHddmJq2uNlI0VyDR98MeznA9bD/k=;
  b=KXSyfmlFtzaQoBpai7KIiQWxoDNDdlYOiZs2Dcr/HitxVGTDz7kfR8JE
   biLdWS7qnZx2mjHb7HWCKIKnMvZYFdjEQ1DxTaN6ySTCAxVhlWkrvIux5
   D1SxPGVzG9ORpBsPqdPNk4HXAdl7lzNx5X5sEYGMBsdehr2sVkY9EpvTp
   ZSyVdXiZ7ZuVDrQS31SN88qX23ns+3leGi/ruCuWDODEXEcqH2UjG48jh
   c0tMfppv8jROc4VZwieRZuNj9JiT4qFrDa1040hM6Ws1Nwb3ybNeD4Moc
   66sm+Dllt+1u45NBOgAcB83ILUeAS3pUI45XE5OzzaHPqvZywQiLX5SCO
   Q==;
X-CSE-ConnectionGUID: llC4HQzvRR2yZhHnzkGv0Q==
X-CSE-MsgGUID: boJBQi8FRqGIDXaKzXl2mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45147022"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45147022"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:14:33 -0700
X-CSE-ConnectionGUID: 2XxMR7LdSUiIvlW1jOG5EQ==
X-CSE-MsgGUID: rdoORqrQSF2PCQ8IDuO3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166186844"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:14:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:14:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 02:14:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rksNQFhDmLMOPYLozyfJGfjxnXDti0O0qVIrZjnZDK9zUSGRSoSbexw5tVNmmlkC8Wig7DDjXVHzS4DM2gCFAu2IO8vNhfudw47vhI9X1zdn+uxX9sLnajuNbahElYy5VVX/Y3NgrP8EewJUryTt2kavDSJOy0uWqCMwjMQckCmSNtSbDPlsN1ArYqyeLyQzv56vrQ7fba+3SOn0MOZ/ICtA5RvxMdLxiNCCEv1KlJllzXbYyzpdd74PaN12QVMvG3yS60xaBeHlsTyFejMh+PyPPNuSn4bWZFKCNRD5smekto/SwovWRYbJGdGSEchX8Cou++sm+sRAkpN4x9DZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmBwOMENPTozvuBpOaWfNv5BMNhlQXU2qVXNGFBvLp0=;
 b=Yjg2vxpYBQfrD/LJRUt+2QXZYATD3U4dQ2m2+krLbeQm2L/5MVoV7rq8uX6TDaLg52hN/MMrgRecI7kkeDiavl/s6mj0B5zNnpsxhTLhyK4NVyIbFTnhlGJD81vOmvPPKQGSNwmVYZvDT4L37S9PJkJvRSpzk/atIYZ/NLDEAHGzj+ZoC0n1kwjJxVIJI9rNJITZ6NZc5cBmVUS2lwKqQEh6r3OTMBb1B4PLkvdYq+LCzqNGOLWB5Wf5u9fdACJ/dfz0HRW5wGUynw2NEvyjvgKeGZgxD7znm1sUMUDA5XiAxSiWPs8KB9cwpICcFERsEZzPcZECYTWnnnUV2F5M0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:14:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:14:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: RE: [PATCH v3 4/5] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Thread-Topic: [PATCH v3 4/5] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Thread-Index: AQHcCxPQc6Hr8+4hTk6pOmIHX28te7RjcEbg
Date: Fri, 15 Aug 2025 09:14:28 +0000
Message-ID: <BN9PR11MB52766E1F39D3C239F046CEA28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <5ba556fc54777853c499186f494f3411d7a4a5a9.1754952762.git.nicolinc@nvidia.com>
In-Reply-To: <5ba556fc54777853c499186f494f3411d7a4a5a9.1754952762.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: 6a610d39-7239-4dab-a3db-08dddbdc234e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DPROQSg+d03Bq0OSOo9VEc/lWI7JhhSrsAEKld5VeR3ybkSNexqedLD7nIAX?=
 =?us-ascii?Q?ot56+75sbxysLVzz6avuZVl6OSfr3ddytP5qvfryrw3VYt/wAPA/COSj65Lv?=
 =?us-ascii?Q?NgFqijhC1Zm9llBipmHW+LJLE1v5ZtuLbcKk4v0LjLC3Mu6fIPfQDJHNbt1c?=
 =?us-ascii?Q?poa0292mPw6xm9Nf0RQzKNcHF2FOxMEE/SX3DdY+9bPt72UntuQ/Wz6cVQ7C?=
 =?us-ascii?Q?J9v3CNaCl9h1KpB7oMYDIsya4Y5pKccjuXnVGXlZqDF5rCvchXn1qCJkT0JV?=
 =?us-ascii?Q?r1U6osVPpkiQRo3vuF3dureRs7JHEPB6GdN95p+R8WADAHbeetjvwIl8nmDi?=
 =?us-ascii?Q?SkV9yIG8YZdjug9l38/G2Q8zlx3YUK++OPWi428R+GGRAYe1RnAmcXicpYTz?=
 =?us-ascii?Q?+Lhy2jVtITi6wvvCyJstREq+cNjeVPugWcgVTy/b525LM7rD4+zYjxQrN18t?=
 =?us-ascii?Q?7Wu9T8y/IoNwdp2P95wbelc3itUNJw9P46S2zaNYGsXUOvrHvIXRW0kHY8M+?=
 =?us-ascii?Q?W0zVloKhENWtX1HxztEJVWblfyhZLDQJ0fGEcSg0pESxPl0Fq8ppDP04jJxB?=
 =?us-ascii?Q?TKhciMfoffaeYe1VtCjsiufpqtcmZiJatFk7wdx+elTj10kAVJYzU4Qwxpfj?=
 =?us-ascii?Q?TQ158POwdnAGa3nmfQdGL4CUSddqIu8x8jccJVi2bBz7oLpy4eTZr1FoxYYF?=
 =?us-ascii?Q?/3mPk3R/2+fUKAEPAxbxUn20kZNFdJRhbyfbS+lceHsroWwjxws5fK9fDAcU?=
 =?us-ascii?Q?HwaFSnCwd0fMrbNDUWP43Qr3ICjZvW9ONgGD1LzkyN57somTQF3obE7Mc4er?=
 =?us-ascii?Q?zQIKhwFolO1stcWIhpA8O0t5vPoUkLuTYT+w3W/BkSQov6OTYcwCZY6ZmmN3?=
 =?us-ascii?Q?cRfkRqd5dnh6Un4UjvQQPnNM/O4HSfpSxScDPyD1fHiA/mSemBpk6FB703pl?=
 =?us-ascii?Q?TXsDeakUXzQHG26U/mQ7xCuBl6Ze6BqqauHgahm2nOEzg56rRXji9WlbrEOx?=
 =?us-ascii?Q?Hm4qycte13r3fqtM/6rvno1/mZI0o14ZMMgpXU5cfy7JSirXhNDNpy5oqY+C?=
 =?us-ascii?Q?pPOMcWCi7+f3X24nIjpmYSia6ONFkeah9+c8VZrd4a5y7t/kyNNDhqpSe5UA?=
 =?us-ascii?Q?ctLShC4YDggVk2KFd/iD/PnxkW0Yx+AGCe/XWB8pA52dy7bjCXG19/nFddLE?=
 =?us-ascii?Q?O4EBQCl9yYi+U8+wjHmGVc8KPlFurEExOE00LcnSdjyXDyipwf3xP9FyfCzO?=
 =?us-ascii?Q?TPnIySjVXQeFTLLLMS+FvqLRirkxAY1CW0WF9UlG3NVJMulQc6iMhZNIpbXQ?=
 =?us-ascii?Q?bWESeKxTCW4IPDo6OIuoGjnn6kG4LmHdUETOQwCIROGtB9UiWmNiMVNP2kKJ?=
 =?us-ascii?Q?PwWsa+b7ri72V7VfK/Rml+R+Z0SD7lzJlqscz+rKSlypNZZnUz0tt1UtGpp2?=
 =?us-ascii?Q?YbDB7tu5PocUOynLqB+jGt+YMx6+204FJ2nsyKRejta23XAwulTP6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HYASH59L1xAOLSbrLAtRp21wBTupmFFt9We5CkAkE8aQ/DF+yiGM/zBUaPgT?=
 =?us-ascii?Q?dfEnVxYM3sANTrT1mUeZNwAeEkg41zMd5+RkYqHBQSXoE3UGbSj+qbmpHOnd?=
 =?us-ascii?Q?zFctK20qF6bQhrSU9US/gfZRshF75l0ubcQYLuHdbDMnDDfO4miRGLcpEEZx?=
 =?us-ascii?Q?WG8RGuMpducUvGyFEG6cfPoHlf2yIUM7S3JDADQmO9QmAI59qMqBXTv+Q3Ov?=
 =?us-ascii?Q?wJxFOr7ezGs5PZna+o9I4XPp+KDzMZtFJn5IxQAMHY0BECITXt+T6CrAtnVi?=
 =?us-ascii?Q?ipO+6WpXwi7Ufe4FSR5WvLz2NY4DOYKBCM6MuZV0Fg+ktqc5ZkUdqFc45/ms?=
 =?us-ascii?Q?sVOQOdp16awzWQTQidIIq1Cu/0M4PQwCNC0LNnqWya8mSCvkWByUlM94BN8B?=
 =?us-ascii?Q?gGjcwgdJ2cE08V34zNamPQTAS5HR/B7VgAB/VAklorrJoNK7j4CEsw9Ai87w?=
 =?us-ascii?Q?U48dtdiv2JN76wi9599pvFq2VmgVb68PqufGoLBaOIFZBvm2LOeC7wgip0Ck?=
 =?us-ascii?Q?njM+etSiw7heEjepxa9hPb9OFc86OBGqjeTAOjm1vqCgB3KFJU3ANPwUj2kb?=
 =?us-ascii?Q?o+5EdN3ZwJk/gjagOY2P1d2MVhSbUT5gbVAK2SdWdN2uLypCTCxBLRr+Yg0y?=
 =?us-ascii?Q?gEVdyB7W7maLLtEAoStmqCBrwRR9+fm+OlBOnY1YlPv15ttOASU3CKWDp3H3?=
 =?us-ascii?Q?NFVm0NTAORcAf8cYOl93dG+dT1hkk72R8YCGOyFHnmKcyN/b0qL9BB8O8lVx?=
 =?us-ascii?Q?rvK8mJ00j2EKbNGwEanZ9ZPhXbxJABlIhAWyZzhtQyv78dPiAdWvF++1CMiN?=
 =?us-ascii?Q?xrlh+FwSOIBfWmgbtrcmurJw47jxypS6IZUn1K1EukM2wM12Fqwbv/IIvuOO?=
 =?us-ascii?Q?fnjRiW13MzCXRG0IE7SIFpLS5fYGRrdfIBpC5x342xJrmqLPFyQF4oFlNT61?=
 =?us-ascii?Q?CR20zV3CtLmi/PCwB+Up84b6GQkYydmkQGG8moq393On+flr6pH4C/zmdGjo?=
 =?us-ascii?Q?9/Im/qefwDCIpDZ2ANFT847msx+oBuD2zjoOGPVstW+l3VbzRhzKFkKyy4j0?=
 =?us-ascii?Q?nowJvkZFCx8A5tdk7n4dvbtARhbkDkwnzk3nc6QqSEcKLzrbd1SnUH1zpHh1?=
 =?us-ascii?Q?Ka/Eqc2fogSK/eRSTsx2rhtvk9bNiht5NZym/1UdxWl0JVbIUkA65RJcUM+R?=
 =?us-ascii?Q?e9uL7HkD7iCGg8DuvNjiWctchMBZBeVtRrzQ9EMeV/w6+vGvb0bX/1ol67Tt?=
 =?us-ascii?Q?GStUbxQCtqqvwXUSd/ZkQRj++p/0SwTbePCfsIcbUj+5KNz+WVt8h9i21Xu3?=
 =?us-ascii?Q?Vgl1UMvMVxyXPTzf2FbY0N4epExJ/pZXEMTL1dzD4qjoeFpVneHwebNeg5Rt?=
 =?us-ascii?Q?r3HVDsCZtvtTbFsk57HvMQJa8GWScLnHnhSXF5seDywYkcWXPCYalrCzo3Iw?=
 =?us-ascii?Q?wQHBxukCMTGP+J5fJl4RbGUQ/qRwyetwhiLtm8iBwX8v2Y+o3I2ge8J+yLls?=
 =?us-ascii?Q?E0WNvbIkHTe9fBpwjMDinZI9jthQysron01NxKbDGQ/uEpe6QhUjLyFWzXSz?=
 =?us-ascii?Q?Uk3EOliCRh+RYDG4nq5PRDlhCD4QoJDavnxL02JX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a610d39-7239-4dab-a3db-08dddbdc234e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 09:14:28.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9ThCYjsIqmltwDo5lgscjdQ9w+8yOOtpM/c6gwR3sLBwn04BSleoEtfzOqn/Uu73CEY+gTbca29aBe+1vyfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 12, 2025 6:59 AM
>=20
[...]
> However, if there is a domain attachment/replacement happening during an
> ongoing reset, ATS routines may be re-activated between the two function
> calls. So, introduce a new pending_reset flag in group_device to defer an
> attachment during a reset, allowing iommu core to cache target domains in
> the SW level while bypassing the driver. The iommu_dev_reset_done() will
> re-attach these soft-attached domains, once the device reset is finished.

attach could fail e.g. when device and domain are incompatible. This
deferred attach (until reset done) makes compatibility check impossible in
the resetting window, given the driver attach_dev callback is not called=20
in the normal attach path.

Worse..

> +	/* Shift RID domain back to group->domain */
> +	if (group->domain !=3D group->blocking_domain)
> +		WARN_ON(__iommu_attach_device(group->domain, dev));

..means that an user could trigger WARN_ON() easily if he knows an attach
would fail.

IMHO we may just fail attach request in the resetting window then
WARN_ON above makes sense as it's shifting back to a domain which was=20
originally attached to the resetting device.

Not sure any valid case where one would want to attach/replace domain
for a resetting device...

