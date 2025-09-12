Return-Path: <linux-pci+bounces-35992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B573B547D8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56291C82BEB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1928507E;
	Fri, 12 Sep 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1nyCg6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9826B756;
	Fri, 12 Sep 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669594; cv=fail; b=BcOYmMh5NCgYYz2JVl2VIrsumQ/jiZMn7c+26U64RYQ6MqBsMXl2S49x9jKYTYdDNRs4FomY0Fn6sS1WaUYB8ZYhvYsc18KAoTfW+Z1BBu1zzxUDHUpS0c+nJb/mgalIGF7+antjXK0NeQbIuf4t9sLvRr5il7reRF/FCnoPNWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669594; c=relaxed/simple;
	bh=tvccAFyVsuAynBeNRHb5ZF44mRcpUetTfnlQ1LvsGCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tR8elvdZlHF1Y4Em+aLkuQMSW6Y8Hd3Fx1ukwFIhP6rq2KPGo+32zPhEd5dNRGtslIRJroFCTACY+Mmti7Zsd4fUDmY79IG/V4kS65WayK4SJQsuVoZsP0SqShkeMWrBwuQrieIYwpLWfor9zi0up4aWTv5wa13TNS3ZmhOvFLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1nyCg6S; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757669593; x=1789205593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tvccAFyVsuAynBeNRHb5ZF44mRcpUetTfnlQ1LvsGCQ=;
  b=N1nyCg6SoC0Jc35LACHgrP6KcxkSmBTs2m3ZuBiJNJVSzpRq0C0XkMQO
   384v8DGOfvHRaxYH8I9LiKzoKEENgotlytwEZzlSX3yw2nPTh+Gl18Rmw
   5gge2EYIIaDp0Szb17r9w39py6sKonwnchieyEco4gck56IBzz3Rc6gYC
   tG9u6RVam4KUX80H2bIKaQinMmjH+or3O5MJCFRbp5pcr22K1F61lLgmv
   7NeAIsl90Z6uoP25OY6+40S/o4ZmF5Md7dWcXIDNFIMfng1CqW90euS4g
   xJFTsJlvmaWHYAPYfPUOOYg8hQF8+gtfOGxmVlk61oDVnxALWK3P1t7dy
   w==;
X-CSE-ConnectionGUID: li+RFGjOTNuyVYyJrAZoFg==
X-CSE-MsgGUID: qHJdgdzCTeSz0tH1Mi/KRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70697101"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="70697101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:33:12 -0700
X-CSE-ConnectionGUID: p1BpxPzPTGW2g/uaIMn2qA==
X-CSE-MsgGUID: 9qjv4smKRcm5rZaXZROhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="178270371"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:33:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:33:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 02:33:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odTasfKIRwhd5huA1bBPRrDfCG8mFXIO/+HN+AmsrYK3VsF/nezpBVjNjDZTc1W7zrXt1CIAMtvk0VybJYopVo7GZoUloQevZg7SqYj6v/4VBRCr9lQMAEIoWMomhyspYs+l7U5tN8/ToRb0XI2nalSypoDgshYPNg2fSlATFTgEUbMnCgIhQjA8M3We5ooSisV+pTPro/6W4DSHnaMIWGvDjMNS8OeFD3WsJ51GGpg+2KaNLG3YK7d97nNQ9EiMOrbrQCYNi7NWw+CcTSGwmK6PcFtiG7RixfUoNayqVmX0Cf7gcDDGwCRdKkwk/lF1yA6QKxa2Z9TWvFY7v0pvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Kp0DlKe41PjZgpvCd/YgG6yDtgMheJux5+atQlOl5M=;
 b=FFBCTdlCRY/fAYW10n8oMJwBoyYnKnlSucthOMKo3JYlcDPN9B8BnWKHChEBuYbqMj1R0StN68uyRQU03XwghOBpMxY9CMMnIdpOAoPOPWsksxgoDXYfpdJwjJfrnUp1iRVZWeyEK5g5GyZBkQ/wjfYA5rsVlkS2K1dUroKvQ99V08ooAoAODxDLKefAyR8YLKAjwqcrOoN5kTLtlVt5GVWJ9TLI8FEvQ8t+8RMoa/426AgMiljZSB2sJXbSfhvcE2n9T1x3oHo80rkiiVgNKdsROfHHLDrxiw4u+FqTcFI1CxOeMN9vsZ2FZnlN9V5YOcf3r2dQPXcaLLyAol46hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 09:33:06 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:33:06 +0000
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
Subject: RE: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Thread-Topic: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Thread-Index: AQHcGs+WWwbl0CO800WZgPVqrWfuxLSPWkyw
Date: Fri, 12 Sep 2025 09:33:06 +0000
Message-ID: <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
In-Reply-To: <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CH3PR11MB8518:EE_
x-ms-office365-filtering-correlation-id: f391f340-7093-487a-a615-08ddf1df60e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zylPCI3docCp/esV7GV/TL52ZkMgqxekkOxhDeY6LvE/isNJf+XQ7xlXuDer?=
 =?us-ascii?Q?jInBmlKMQ7H9lip99ajxl+wpc13CB71jk2pKF2DrwQibfPMXp3nwiTZtrXpD?=
 =?us-ascii?Q?DVJhnBpMnqB/qQAT4Pf/59XKd7g72ptG92oi4B+ZCBlUUTSH9QaPsH9aRVwm?=
 =?us-ascii?Q?X0CuZHYJXK5/fO0znp1UFfo+UP0xbqw/aNaXI5yQMRoBmvj/HgLoXbb9PcHc?=
 =?us-ascii?Q?zHQoWG0JZE/8/tz9oy3+1z53avG+TxXc7VKYRx/xsFjEH6BMAaRWT5G1tixq?=
 =?us-ascii?Q?UJqiM59KaWjPq1ExgD6efVRajkpAvkh6jIHXe7tSuh637z/MX/GNzN2KOuG6?=
 =?us-ascii?Q?qGKPS4CZWYL+zENLIMBc1EWhrBfxuqj59qHN7Fy5pVoVFWvqaNyoAWHJ+DAF?=
 =?us-ascii?Q?g8ChFw7+OTR9FtI7TvbnCNbSS1yl8SszcZXl4s+ECnUBZoMmu4hiS0N3TwH4?=
 =?us-ascii?Q?BTvFvGvjrvOBuNmbghlXbEVyjKLRg65lFnYRRNof3HWkBVzDjjEm0M+e4zAq?=
 =?us-ascii?Q?8LCioALAZqudzKxPrEFlq1fc8B5kW6rKTO2+09CFgCuxjq4y3Di5LWiCwZp+?=
 =?us-ascii?Q?T5JDWIOLmGkRm/+7V9V5FDMOv6GMRt/ntSKkkq+yB7VI8zMQS0t4BLP9hRFM?=
 =?us-ascii?Q?x9VcPPEY9/w6rI+tyv9VY/oTgiFOtGuZ6BkIx/92oWZdev5H5QTwFEsuEE6y?=
 =?us-ascii?Q?dPVgNjxxvu8l3p2A2oyo5P9pttIKd1IexVujA/nq/g6Ge+6oSTVmvgH7+g3A?=
 =?us-ascii?Q?miqJJa8T+D9/R1cUnw61Jpq8lpZILeRTSXztiJCEyx3gxKpasiKXeJguWb7x?=
 =?us-ascii?Q?2GoNpsDNJvRX+Mzo2guPehXUtWtvIKtrinLPtLK6Pc0JpfTkmPbDCzVFITLF?=
 =?us-ascii?Q?ZsMwHF8ovNuHwkTgPnwijNfKeyfp4ora74LhFVcJ+lLPz4+09Lit/9l0a00X?=
 =?us-ascii?Q?o94iTC3G1pWXkwjK5Or+RjLWsRX57EzCtnlv3qPX3ThBnHnWupGb2JQnGRH1?=
 =?us-ascii?Q?/9qSO7c7md1ZU+ropOVBYzZSmylpi8bY9lLPjnSD5zbKZg/4RCtU6EpS9sBE?=
 =?us-ascii?Q?G7uuNJJQ7xT/D4Ibd1GL+rwyhRKwWoKAS7Xh2ivkmoKJ/O76tDC+qkct/gbA?=
 =?us-ascii?Q?dPzpvefUdg617KqFLJcdydIh+VgFAgtj6dYdksuzhPt9DeHGx4BUd5fs+pER?=
 =?us-ascii?Q?UBnL81eEY9TuuVvizDjBkBDv/n+fmjACaNRb+Rz9aRz3oDgPZYSUZLAQ+eiX?=
 =?us-ascii?Q?ydPbFneHLuN1LiTXkxJMB90oO1908/C3ySaQu0Kq9ZIMhhl9KP/p3gySbV8k?=
 =?us-ascii?Q?JI4xlgyRS4pUEBA0li/MJQ26SbiZZ9ClTzU84LAU680o3jKhxjAIawDIir5y?=
 =?us-ascii?Q?abftI+5BUPytc0yDh1nb3Bhc3ZmrjA+OxIaEIIO9nvrJ3ze0EflFq6nSPY0K?=
 =?us-ascii?Q?x2UbEp3sUSyHV9BHrTEUxQSETt9R8rpTwqXJl5bYC6E6DvCo5SYQ2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y37tmZ84pRK9IR/dC8uvRgdnNDvo+a2VOk2YJAukb52WJQ1zJGH9cZ9NNWVO?=
 =?us-ascii?Q?wpFlUVY8j7pzyojHe258k6PbZYyZ14uMKbDwUQfj6NN6xS1vVl5aJSNNYpD7?=
 =?us-ascii?Q?BgOj3LH6su41pmaQBnhVTN3K9AKyv7fLk1k7GOECXuj1ePi5Dvpe6nrlsqIt?=
 =?us-ascii?Q?BQlKNyQDyHQ1Ic13YzhBaVtNnjjx+gVlDRTjCHI54ZtI23szm56f63ccZxD+?=
 =?us-ascii?Q?ubd4QsJj5FzLIj4KT6leiClJVYRh030TFT/8wEAZGOBzXyxrnyB9hKpoaueE?=
 =?us-ascii?Q?NKypIvwGVuXUOn8dI+/Ki9CweWwLq34XxH8O68hDQtf9Fe6iSa0ZN/2SQtbK?=
 =?us-ascii?Q?Tr81LZ0P8lkjMkDYTWBzAftfjZpQsbg+FsbbNXHWHpHgcyz5qGu3SHTninu5?=
 =?us-ascii?Q?iqaPso1Q+bpUrNNtsV+6MXrzrarNlE15bd4+fGYKqRBw8ZjC0mdJcbMPI9Cw?=
 =?us-ascii?Q?rws4gcE7ApXvNO56+S5VEWU95Iq3OXSLTZuZ2PUOQaFgK81clDeU19SJxFA1?=
 =?us-ascii?Q?rI5fNIkxFzZIk3q5zw0BZ8dTN1M0/uWFSA6pvKcH3pLPU4gIeGpiKX2GXnW8?=
 =?us-ascii?Q?u/cxMOYTp6XwYlRqVIiRoSWl63DsXfHaBZ1RrhWQnOTVONIZleh9f5gaOM5f?=
 =?us-ascii?Q?rct0Fvi9uir/c02knwBz8w+/A02SPWgMkLbG2Jj3u1keO2P8PyYDay/dETM0?=
 =?us-ascii?Q?7CPFGzkzBwfP1VNfVqGNxBTlwqbrc8cedeMgrCzyR4q0Ix4UF+sTJC26QNOy?=
 =?us-ascii?Q?/x7p21kzfsgh1l2UTqoe24SVd9GFtRlQdYnGLzDHw/qfp5P5ze2mReORBC7L?=
 =?us-ascii?Q?22DZKJQN0oWRxhFR17uEOVXofhlJ/EsgEZ3TWQ6Ign/ZCdbQqFzt91BGYtis?=
 =?us-ascii?Q?DXq4SlGGcqy/2OzJSsFtAaOE25rjx2KUC98WcUoLvuxTFseGXkEr8G2JUbGU?=
 =?us-ascii?Q?MATs57Dn04kQEYU663Az8h2w13V4OeOhPFuo72p3bV52WLI7ealwtl0oAXeY?=
 =?us-ascii?Q?fB8gH+BTSdbl4ciWcNlk9di2gk52XuPS4N2BLUZNSKgvArbPIrTO8zTiEmGk?=
 =?us-ascii?Q?Lj9c9uAaTIRuTB9o7PlhHPvjSl8Qp0a8BOUn8VyeZYYUKdCvCJ7FTJlWANAX?=
 =?us-ascii?Q?z//84UT1I1xBcSdqNjggrbLzRPkUQfNgSBOaQSbV11EjnNXbIG40Oq2isry5?=
 =?us-ascii?Q?9z+j7ePlVwGUOtDWezxYuZ0OhUWpOCiCwxMk/9nHCTIIILWi7Orem2DHHMAC?=
 =?us-ascii?Q?7R40GxW11tMPSE1qltrAgmearBZt/DMsP2VQZqJZjzYxXQI4ux6mVgKiE3+p?=
 =?us-ascii?Q?n+oGaS1R3Pfi5l/Q+RQ1hmxKVr5oNSHoX8N934tO1lbfPSmMwbw8m4X0Xgqc?=
 =?us-ascii?Q?uGnbajmut++dhR+WxmjGCuQfpwCAccNKRzR2jkLZCc8JiV78/pSRq6FKNsD9?=
 =?us-ascii?Q?KdOBdmA/Om1LXH9IJ4tpos5MG5omEPcs9qnQcWWcIrXdw4xJGtmib/o1M58X?=
 =?us-ascii?Q?CStE6fv+fvfjrvMJjF8g8iWcQQxw/Tvs6UYaJjjYe6flsJRT7Z0huXiGETsj?=
 =?us-ascii?Q?D/FqoJKxz6XQvFJpsikEQRcSWt837CYi7j6OGpXV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f391f340-7093-487a-a615-08ddf1df60e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:33:06.1893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAvB6b7h5oytED7HI6MYmGKlxESC+7mWfnZQibCTTQLyZygVPV2Gluxy5GrrQRhCnzB2KPS6cSjxkc+7gLfGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, September 1, 2025 7:32 AM
>=20
> +static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +	WARN_ON(master->iopf_refcount);
> +
> +	/* Put the STE back to what arm_smmu_init_strtab() sets */
> +	if (dev->iommu->require_direct)
> +
> 	arm_smmu_attach_dev_identity(&arm_smmu_identity_domain,
> dev);
> +	else
> +
> 	arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain,
> dev);

it's a bit confusing that a BLOCKED domain type could turn to the
identity mode, though this movement doesn't change the original
behavior.

> +
> +	return 0;
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_release_ops =3D {
> +	.attach_dev =3D arm_smmu_attach_dev_release,
> +};
> +
> +static struct iommu_domain arm_smmu_release_domain =3D {
> +	.type =3D IOMMU_DOMAIN_BLOCKED,
> +	.ops =3D &arm_smmu_release_ops,
> +};
> +

