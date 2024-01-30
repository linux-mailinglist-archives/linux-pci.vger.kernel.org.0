Return-Path: <linux-pci+bounces-2761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D872841BE2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826EC1F255E7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0582381D9;
	Tue, 30 Jan 2024 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WN6WxwpE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8C38F84;
	Tue, 30 Jan 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595742; cv=fail; b=JtJT2sN5+h71kIKff99o6KVRHX9jf6Bvvf6SEWeEh/w4DROsIQH0YxcuQ9FrBI4l4+JAkTkxkfHfcWuBE3h1rTxjSnOstPx+eg3ne6BAiBNSl3hun7pYsPWHew5z7dra/HY4S94n5Ie7jn7LQ5AtsuYEY8VF2nIyuEj72mo84fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595742; c=relaxed/simple;
	bh=j5SQ3K39oewS5veHyXSdNTT7Uw/e5GIFmUuCLW1c+lY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V3SWcQE0ndH0B0Rro1Sj4Dp9aNLfsg8R4xHsEpZgbTgX+PkozHzoz/WqQjwk6Fkjiwa1akC0109sTjiP96bH77dwsINAZCobY0rjVS2wTxHhiIsZdCkD2Oxn3AP53+7c0UHoRdLVryQifV5oMiszj+SoegrxYWkEBrefnO5md2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WN6WxwpE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706595740; x=1738131740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5SQ3K39oewS5veHyXSdNTT7Uw/e5GIFmUuCLW1c+lY=;
  b=WN6WxwpE0ItD3A/icWcUcOt/IrvZWQ8lE7/2YaWUmIgbgu9tadwRLnHE
   Vi0jsFmV2o74RTRWBKlYP8bEbHAp2dTagNnn5IVysC5zEKn9fcx36N8nQ
   YI+9Cuuhn0H1xar+4E9Ec/c+WRidiZSc0DH1Ylz1oa33Mr77J8sHwM5pu
   Q3/7AytKFHz6h8pLTiLAeYNtl7ivz8MmD3nQ7CGdNZSlyqh+vRH12DpmP
   dSfV4iL5iOyQvuIYKB4l8s6yOezp9zU/pVF/IWobNRQpC6YeSclqqjul9
   +WqOr/l9Nz8qja1EamOeTt9TqbD/UOyg6FDGuWyiRa2cFMKp5dsCbBChv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3018250"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3018250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36392982"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 22:22:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:22:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:22:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 22:22:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 22:22:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh/NNrILsLUX6SDi5xkyT5VFZW8w/Q0NK/lhi+BRkjqP9TAIrQ31eUhOZUY1pivMVHQr4+U4xrcZnohxBOY3q51KEZQO5txQC3S1b7M+1YRYo1PuTI6Xq6HlUl5bJruL5bphQeraaDBR3UBM5FB7SIaKKR/jhJNLriagaS6CTcNftsl/bqE2leDleUwNeXq0A6ADjMmWCGTVXTHay49oovR1Su2TWVxWrIMtEZprO5hnHhpJoRVJNp32OnIbwRRyFFdLZgvf64bv7Za9FiIe/7mnoMKjPiiixOWnsTNZEls3T6JqG9h1giudqXTfOBQUD2LIgA/DCszS+2RNTuoTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5SQ3K39oewS5veHyXSdNTT7Uw/e5GIFmUuCLW1c+lY=;
 b=fvNuC2v3U2y7Uv3LeK14AisUa8MxFhD17S0Bmwgy7xHpc1YWxxgZJ7LIp8XnxcgjpjhtQcy5K4H9aI69KFF1voP0LkI0eibEZ/wx1cB1P2RwmTVCsOcbhxkAEolNOfIeQSbsisGXn3H2pcLMakO4KaTXdvoqKlHH6zXqcIAt1ptIYu245F1IuxLhxJTlhnCL1+bcbe1qzime/KmzAgrVwS9cZ0kEe90edkmH5jNujyTar7OyHn2+cvpecYN9gCJlue5I4rHZi6Pq+fMffW4nEaEYHJvaqHQaZxuOpiyXK9IDm/3/PZyPIi3Uan+hoMkWqc424J96rAC0SzjHIX7Whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 06:22:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:22:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Topic: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Index: AQHaUmY538BcsBx6UEOae7WqjB1D5LDweayAgAAKqQCAAUzCgIAADpYA
Date: Tue, 30 Jan 2024 06:22:12 +0000
Message-ID: <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
In-Reply-To: <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5269:EE_
x-ms-office365-filtering-correlation-id: 5c0f0048-d8b6-40f0-091e-08dc215bcbf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9sbadh+WK3qhV78xqmyquQuseDK7tZFqT0Kbgadrt13vQ64RUbnfAPWUpeSSHxuWW/x6vG/+ki+DYraJd/kc3L9Vpe6a/Pcma8KxlHPSZNhw3XalqAowlT5DCF/IrZFFyMCrut3I6TZi+YfWnrKR8Lfow5th/wymRlCqbvv+vEkGEz5I6QEJiup7GeP/fNwOf481SxdZefdNAi5WxnLnJzYpDiel7m0jgXwra9okl7wVRYjfVgcjdD703euSupfUAi/tMQ3DZfLb+jCScSlSb69YpJIyjWVYcWAH1jx1WklPCh5yNW8TNOmhoA4jlPwP3gwLshQ+e06khkFiK0Tojy1TIDG8o3RHgYmGg6yz95zNE78BEKMPn4j5eGvhYYghsgkqRCADziHmTfHudQ4+8BkphPMxQo1uHyYJgP8oGhAyigudV/7iC0khl5rGaAfVIUiYklXCPHtAlNolgecs2rpte63ZylubNa+TanPjXwyUHWf8qMmolEHFznrc7uAZ+4Xe/5/i7vZdk01pusN2isxG0XCbpTaKRid1UjCSTKfgsx855B3s7mW8HqkPvvJFAuxGtvG3DdIxagT6XKO4Pp6441nyur6eB2yZVBkBFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(9686003)(26005)(83380400001)(55016003)(316002)(66476007)(66556008)(110136005)(54906003)(64756008)(66446008)(478600001)(66946007)(76116006)(7696005)(6506007)(71200400001)(53546011)(4326008)(8936002)(8676002)(52536014)(5660300002)(86362001)(122000001)(38100700002)(82960400001)(7416002)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUVZa0NPUXdrdDJiVGdRbTQ1UjlxVHc0N2ZNbG5MUDNhYjN3VVFhcy9Ta0I3?=
 =?utf-8?B?MFJIeWR6MHBJVG5Ua21WQUplU2VQU0I1dEhkcUpWU0VmNmdsOHZ1Q1lmeW1V?=
 =?utf-8?B?Q29kNmxrMjJ0L1Vxc2hJRlZuM2t5YjZ3c3NRKzJVNTZuSzhSbVMrM0Z1Z0Fq?=
 =?utf-8?B?OHVXR3BOTzNhYjJOemVra1hrdHZKblRYMXpqODFKbkpqeUcydDd3Qm1rL3JC?=
 =?utf-8?B?OWdNNGJNNThrcjcrRU4yZlRjclNiWnZHODVvYjdFU0hIdVc3VkVYc1dMOEVH?=
 =?utf-8?B?L3A1cHczR2ovM2dkMkhFNzJGL2tCOTNzRXFwVm43c2t4SUs1SStseHNDQ3d1?=
 =?utf-8?B?OGloSlptNkZvVUxuemdqekRkOWw1Nm56QzE0c0lnMTU1NCtJRGloRmN2YWFv?=
 =?utf-8?B?d3Bmd21wL3NmbUR1MTFNb0RlTWJTLzZqQU13WDdnbEpFQ2NjUWE3K3lFSmNR?=
 =?utf-8?B?Ymw1aFBSdmpEUGE3czFBMUVZcnVDak1tTXJtMVd5VC8xMG5jaXM0TU8va0RQ?=
 =?utf-8?B?N3MwVGgrVkh1bm0xWXRlUmpncjAxSEpaYWNRaFY4TEt6N2plYzRmUTliQ2ln?=
 =?utf-8?B?N2FsaGNPUXhDYS94VEcveGFJN0ppaE9WNTZiaDIvUUZUT29xWWhZdDNIa2h5?=
 =?utf-8?B?NUFFS2lVODNCUUFZWUplOU9RQWhpZmd3SjdLYXU2d1UxS0hpRFlEbkNmRFVr?=
 =?utf-8?B?TVNFMG4wdXgwVjdkVWhPVGU0MjdCc25pOGNsYlp3dFE2VXk5T1VVQmQ4Rm5N?=
 =?utf-8?B?N01kZTh1b0tFSWppd1plcFlodHk3N0UyMVlUT2Z4Z280MUxqcEFDbDFHbk1m?=
 =?utf-8?B?b3dHcDQ5WUpXb0M3YWZuSkFXcXI3bzY0UzZkNXhjN0NWWFBhdEFjbXphUlBO?=
 =?utf-8?B?VWtvK0daUFRwMWhydWpCMDl6RjR2NFE1ZWxMcTBxbVpTMmdkMGxTeWJocXo4?=
 =?utf-8?B?SGIwSWlITVhuWjYvM2s0MzVqVkI0QnFaQkRCT0dUa0JRcEd4VmpvMklJZm50?=
 =?utf-8?B?cDNyN0hlMUIwV3ByeUxkRTZJcXA2dWMyYm83WTF5YWFDS0gyYjlkWWp1am1t?=
 =?utf-8?B?eGM3ZWkweDZJMTliWUVHWUxHZlVrOWlDUFNkU09TbnFUc0RqVFJrMkxzT0J2?=
 =?utf-8?B?cVJwNXBqenVENHcrV1lScURFNngxZEdaQ0V1MnhRVVFpeUFHOW9xd1BIYUtu?=
 =?utf-8?B?OE53a2ZjRERNTllScE5nWnZMbDZ5YmVvMnVTczhOcFA3U1J2K01TNFk0S29T?=
 =?utf-8?B?NmQyZ2NZL1NyaldCRDU3Vm43NmdFYVc4RjFZcHgrTnlkTjV2S2ViVmtWYjhK?=
 =?utf-8?B?T3BRRmFxNGp3eW42UHdSVlM1Q25HSFlmaFNSK1RXSm1ibEwxQmtzRHVpVStU?=
 =?utf-8?B?U1Nqc0d4b0swekJ1MzM1NFh6RlJmSmVvemxjZmx1VTNqSURxd3FuK3FNcFNo?=
 =?utf-8?B?dlVFTDA2U2JCdDAzaTFXZWlFRTlPcHQ3UjlhUlo3Z0Z4c1ZscFR0VXYrY0pY?=
 =?utf-8?B?VzA0RTcvcm14RWl6dmhXdVY5MGVXVndMRGNWRGFhZnZVVVFOKzkvMzRrK1Va?=
 =?utf-8?B?dnZyRTc1cEJ0cHNGT0FHMGM5K3k1MllhWFBTMkJnQkR6V0w1aU1DV1BMUU1r?=
 =?utf-8?B?UzYxM0Mvb2J0eHhXUnJVM0JpUXVTOGxmZWt1bHcvY2NiS1ZSTnNjQzRvL2hG?=
 =?utf-8?B?Mmg1T2IzbUNHaGsxK29nbmRoSGJIczJ1VnJpVGZyb2NCcWhOK3hRckhIM3l1?=
 =?utf-8?B?VGhpK2FiNGw0R1d0UU1xdEYzSFZGeGV2YUVIV25idkhXQ0J4RHlzT3BnNHl3?=
 =?utf-8?B?VHNBcVdXUEFJcVIweitlbHlJSStMdS82Um9MdmhFUjZwNDNTdmlxWlQwYk9t?=
 =?utf-8?B?Z3M4b2UwenlTT0g1SXVISmlLNlA2MmJCRUsrYjhGVGxmTDlVTkxPL0tqUjRx?=
 =?utf-8?B?MXZqUHpjQldGbGZlZExEZTRTSUZmT1lIOFZaZnFRcWtraUxVT3NsaFk1SThU?=
 =?utf-8?B?Z2tOYlZuUTY3cGk3K3NtazRDSXFlKzNKR21ZZVhxNERHQy91a242V04ySjUw?=
 =?utf-8?B?L1liVzY3bTZPZTVDOHFkbHJZMlVOajlQU056a3gxWlJIdWdhY2xwSm1WMDlp?=
 =?utf-8?Q?vhBclyvNM98B+eSsJdcuN3/gD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0f0048-d8b6-40f0-091e-08dc215bcbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:22:12.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlHFWbM8rLOcJMaMsZt1oC4lW6J5gdJ4O9A01DsYDu1LGyGEdRghSVPaEW4xZ7XCuJVpc/N+yh2nroFhFaC+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDMwLCAyMDI0IDE6MTMgUE0NCj4gDQo+IE9uIDEvMjkvMjAyNCA1
OjIxIFBNLCBZaSBMaXUgd3JvdGU6DQo+ID4gT24gMjAyNC8xLzI5IDE3OjA2LCBUaWFuLCBLZXZp
biB3cm90ZToNCj4gPj4+IEZyb206IEV0aGFuIFpoYW8gPGhhaWZlbmcuemhhb0BsaW51eC5pbnRl
bC5jb20+DQo+ID4+PiBTZW50OiBNb25kYXksIEphbnVhcnkgMjksIDIwMjQgMTE6NDkgQU0NCj4g
Pj4+DQo+ID4+PiBCZWNhdXNlIHN1cnByaXNlIHJlbW92YWwgY291bGQgaGFwcGVuIGFueXRpbWUs
IGUuZy4gdXNlciBjb3VsZA0KPiA+Pj4gcmVxdWVzdCBzYWZlDQo+ID4+PiByZW1vdmFsIHRvIEVQ
KGVuZHBvaW50IGRldmljZSkgdmlhIHN5c2ZzIGFuZCBicmluZ3MgaXRzIGxpbmsgZG93biB0byBk
bw0KPiA+Pj4gc3VycHJpc2UgcmVtb3ZhbCBjb2N1cnJlbnRseS4gc3VjaCBhZ2dyZXNzaXZlIGNh
c2VzIHdvdWxkIGNhdXNlIEFUUw0KPiA+Pj4gaW52YWxpZGF0aW9uIHJlcXVlc3QgaXNzdWVkIHRv
IG5vbi1leGlzdGVuY2UgdGFyZ2V0IGRldmljZSwgdGhlbiBkZWFkbHkNCj4gPj4+IGxvb3AgdG8g
cmV0cnkgdGhhdCByZXF1ZXN0IGFmdGVyIElURSBmYXVsdCB0cmlnZ2VyZWQgaW4gaW50ZXJydXB0
DQo+ID4+PiBjb250ZXh0Lg0KPiA+Pj4gdGhpcyBwYXRjaCBhaW1zIHRvIG9wdGltaXplIHRoZSBJ
VEUgaGFuZGxpbmcgYnkgY2hlY2tpbmcgdGhlIHRhcmdldA0KPiA+Pj4gZGV2aWNlDQo+ID4+PiBw
cmVzZW5jZSBzdGF0ZSB0byBhdm9pZCByZXRyeWluZyB0aGUgdGltZW91dCByZXF1ZXN0IGJsaW5k
bHksIHRodXMNCj4gPj4+IGF2b2lkDQo+ID4+PiBoYXJkIGxvY2t1cCBvciBzeXN0ZW0gaGFuZy4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGlu
dXguaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiDCoCBkcml2ZXJzL2lvbW11L2ludGVsL2Rt
YXIuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
bnRlbC9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiA+Pj4gaW5kZXggODE0
MTM0ZTlhYTVhLi4yZTIxNGI0MzcyNWMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2RtYXIuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4g
Pj4+IEBAIC0xMjcyLDYgKzEyNzIsNyBAQCBzdGF0aWMgaW50IHFpX2NoZWNrX2ZhdWx0KHN0cnVj
dCBpbnRlbF9pb21tdQ0KPiA+Pj4gKmlvbW11LCBpbnQgaW5kZXgsIGludCB3YWl0X2luZGV4LA0K
PiA+Pj4gwqAgew0KPiA+Pj4gwqDCoMKgwqDCoCB1MzIgZmF1bHQ7DQo+ID4+PiDCoMKgwqDCoMKg
IGludCBoZWFkLCB0YWlsOw0KPiA+Pj4gK8KgwqDCoCB1NjQgaXFlX2VyciwgaXRlX3NpZDsNCj4g
Pj4+IMKgwqDCoMKgwqAgc3RydWN0IHFfaW52YWwgKnFpID0gaW9tbXUtPnFpOw0KPiA+Pj4gwqDC
oMKgwqDCoCBpbnQgc2hpZnQgPSBxaV9zaGlmdChpb21tdSk7DQo+ID4+Pg0KPiA+Pj4gQEAgLTEz
MTYsNiArMTMxNywxMyBAQCBzdGF0aWMgaW50IHFpX2NoZWNrX2ZhdWx0KHN0cnVjdCBpbnRlbF9p
b21tdQ0KPiA+Pj4gKmlvbW11LCBpbnQgaW5kZXgsIGludCB3YWl0X2luZGV4LA0KPiA+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHRhaWwgPSByZWFkbChpb21tdS0+cmVnICsgRE1BUl9JUVRfUkVHKTsN
Cj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB0YWlsID0gKCh0YWlsID4+IHNoaWZ0KSAtIDEgKyBR
SV9MRU5HVEgpICUgUUlfTEVOR1RIOw0KPiA+Pj4NCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0K
PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBTSUQgZmllbGQgaXMgdmFsaWQgb25seSB3aGVuIHRo
ZSBJVEUgZmllbGQgaXMgU2V0IGluDQo+ID4+PiBGU1RTX1JFRw0KPiA+Pj4gK8KgwqDCoMKgwqDC
oMKgwqAgKiBzZWUgSW50ZWwgVlQtZCBzcGVjIHI0LjEsIHNlY3Rpb24gMTEuNC45LjkNCj4gPj4+
ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgaXFlX2VyciA9IGRt
YXJfcmVhZHEoaW9tbXUtPnJlZyArIERNQVJfSVFFUl9SRUcpOw0KPiA+Pj4gK8KgwqDCoMKgwqDC
oMKgIGl0ZV9zaWQgPSBETUFSX0lRRVJfUkVHX0lURVNJRChpcWVfZXJyKTsNCj4gPj4+ICsNCj4g
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZWwoRE1BX0ZTVFNfSVRFLCBpb21tdS0+cmVnICsg
RE1BUl9GU1RTX1JFRyk7DQo+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygiSW52YWxp
ZGF0aW9uIFRpbWUtb3V0IEVycm9yIChJVEUpIGNsZWFyZWRcbiIpOw0KPiA+Pj4NCj4gPj4+IEBA
IC0xMzI1LDYgKzEzMzMsMTYgQEAgc3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QgaW50
ZWxfaW9tbXUNCj4gPj4+ICppb21tdSwgaW50IGluZGV4LCBpbnQgd2FpdF9pbmRleCwNCj4gPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhlYWQgPSAoaGVhZCAtIDIgKyBRSV9MRU5HVEgp
ICUgUUlfTEVOR1RIOw0KPiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gd2hpbGUgKGhlYWQgIT0g
dGFpbCk7DQo+ID4+Pg0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ID4+PiArwqDCoMKgwqDC
oMKgwqDCoCAqIElmIGdvdCBJVEUsIHdlIG5lZWQgdG8gY2hlY2sgaWYgdGhlIHNpZCBvZiBJVEUg
aXMgdGhlDQo+ID4+PiBzYW1lIGFzDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGN1cnJlbnQg
QVRTIGludmFsaWRhdGlvbiB0YXJnZXQgZGV2aWNlLCBpZiB5ZXMsIGRvbid0DQo+ID4+PiB0cnkg
dGhpcw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiByZXF1ZXN0IGFueW1vcmUgaWYgdGhlIHRh
cmdldCBkZXZpY2UgaXNuJ3QgcHJlc2VudC4NCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogMCB2
YWx1ZSBvZiBpdGVfc2lkIG1lYW5zIG9sZCBWVC1kIGRldmljZSwgbm8gaXRlX3NpZCB2YWx1ZS4N
Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHBk
ZXYgJiYgaXRlX3NpZCAmJiAhcGNpX2RldmljZV9pc19wcmVzZW50KHBkZXYpICYmDQo+ID4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVfc2lkID09IHBjaV9kZXZfaWQocGNpX3BoeXNmbihw
ZGV2KSkpDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVUSU1FRE9VVDsN
Cj4gPj4+ICsNCj4gPj4NCj4gPj4gc2luY2UgdGhlIGhhcmR3YXJlIGFscmVhZHkgcmVwb3J0cyBz
b3VyY2UgaWQgbGVhZGluZyB0byB0aW1lb3V0LA0KPiA+PiBjYW4ndCB3ZQ0KPiA+PiBqdXN0IGZp
bmQgdGhlIHBjaV9kZXYgYWNjb3JkaW5nIHRvIHJlcG9ydGVkIGl0ZV9zaWQ/IHRoaXMgaXMgYSBz
bG93DQo+ID4+IHBhdGggKGVpdGhlcg0KPiA+PiBkdWUgdG8gZGV2aWNlIGluIGJhZCBzdGF0ZSBv
ciByZW1vdmVkKSBoZW5jZSBpdCdzIG5vdCBuZWNlc3NhcnkgdG8NCj4gPj4gYWRkIG1vcmUNCj4g
Pj4gaW50ZWxsaWdlbmNlIHRvIHBhc3MgdGhlIHBjaV9kZXYgaW4sIGxlYWRpbmcgdG8gb25seSBh
IHBhcnRpYWwgZml4DQo+ID4+IGNhbiBiZSBiYWNrcG9ydGVkLg0KPiA+Pg0KPiA+PiBJdCdzIGFs
c28gbW9yZSBmdXR1cmUtcHJvb2YsIHNheSBpZiBvbmUgZGF5IHRoZSBkcml2ZXIgYWxsb3dzDQo+
ID4+IGJhdGNoaW5nIGludmFsaWRhdGlvbg0KPiA+PiByZXF1ZXN0cyBmb3IgbXVsdGlwbGUgZGV2
aWNlcyB0aGVuIG5vIG5lZWQgdG8gcGFzcyBpbiBhIGxpc3Qgb2YgZGV2aWNlcy4NCj4gPj4NCj4g
Pj4gVGhlbiBpdCdzIGVhc2llciB0byBiYWNrcG9ydCBhIGZ1bGwgZml4Lg0KPiA+DQo+ID4gTWF5
IGNvbnNpZGVyIHBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpIG9yDQo+ID4gcGNpX2ZpbmRf
YnVzKCkvcGNpX2dldF9zbG90KCkuIEJ1dCBJIGRvdWJ0IGlmIHRoZSBwY2lfZGV2IGlzIHN0aWxs
DQo+ID4gdHJhY2tlZA0KPiA+IGluIHRoZSBidXMgb3IgYSBraW5kIG9mIGRldiBsaXN0IGluIHRo
ZSBkZXZpY2UgaG90IHJlbW92YWwgY2FzZS4gU28gRXRoYW4NCj4gPiBtYXkgbmVlZCB0byBjaGVj
ay4NCj4gDQo+IFBlcmhhcHMgaXQgaXMgdG9vIGxhdGUgdG8gY2FsbCBwY2lfZmluZF9idXMoKSBv
cg0KPiBwY2lfZ2V0X2RvbWFpbl9idXNfYW5kX3Nsb3QoKSB0byBnZXQgdGhlDQo+IA0KPiBkZXZp
Y2UgaW5zdGFuY2UgZnJvbSB0aGlzIG5vdGlmaWVyIHJlZ2lzdGVyZWQgYXMNCj4gQlVTX05PVElG
WV9SRU1PVkVEX0RFVklDRQ0KPiANCj4gYWN0aW9uLiBpZiB0aGUgZGV2aWNlIGlzIHN0aWxsIHRo
ZXJlIGluIGJ1cyBsaXN0LCAqbXVzdCogYmUgYSBidWcgb2YNCj4gZGV2aWNlIHN1YnN5c3RlbSBh
cw0KPiANCj4gKnJlbW92ZWQqIGRldmljZS4NCj4gDQoNCkV0aGFuLCBsb29rcyB5b3VyIHJlcGx5
IGlzIG5vdCBmb3JtYXR0ZWQgd2VsbC4gQ2FuIHlvdSBmaXggeW91ciBtYWlsDQpjbGllbnQgbGlr
ZSBob3cgeW91IHdyaXRlIHRoZSBjb21taXQgbXNnPw0KDQpIZXJlIHdlIG5lZWQgY29uc2lkZXIg
dHdvIHNpdHVhdGlvbnMuDQoNCk9uZSBpcyB0aGF0IHRoZSBkZXZpY2UgaXMgbm90IGJvdW5kIHRv
IGEgZHJpdmVyIG9yIGJvdW5kIHRvIGEgZHJpdmVyDQp3aGljaCBkb2Vzbid0IGRvIGFjdGl2ZSB3
b3JrIHRvIHRoZSBkZXZpY2Ugd2hlbiBpdCdzIHJlbW92ZWQuIEluDQp0aGF0IGNhc2Ugb25lIG1h
eSBvYnNlcnZlIHRoZSB0aW1lb3V0IHNpdHVhdGlvbiBvbmx5IGluIHRoZSByZW1vdmFsDQpwYXRo
IGFzIHRoZSBzdGFjayBkdW1wIGluIHlvdXIgcGF0Y2gwMiBzaG93cy4NCg0KcGF0Y2gwMiBjYW4g
Zml4IHRoYXQgY2FzZSBieSBjaGVja2luZyB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgcHJlc2VudA0K
dG8gc2tpcCBzZW5kaW5nIHRoZSBpbnZhbGlkYXRpb24gcmVxdWVzdHMuIFNvIHRoZSBsb2dpYyBi
ZWluZyBkaXNjdXNzZWQNCmhlcmUgZG9lc24ndCBtYXR0ZXIuDQoNClRoZSAybmQgc2l0dWF0aW9u
IGlzIG1vcmUgdHJpY2t5LiBUaGUgZGV2aWNlIG1pZ2h0IGJlIGJvdW5kIHRvDQphIGRyaXZlciB3
aGljaCBpcyBkb2luZyBhY3RpdmUgd29yayB0byB0aGUgZGV2aWNlIHdpdGggaW4tZmx5DQpBVFMg
aW52YWxpZGF0aW9uIHJlcXVlc3RzLiBJbiB0aGlzIGNhc2UgaW4tZmx5IHJlcXVlc3RzIG11c3Qg
YmUgYWJvcnRlZA0KYmVmb3JlIHRoZSBkcml2ZXIgY2FuIGJlIGRldGFjaGVkIGZyb20gdGhlIHJl
bW92ZWQgZGV2aWNlLiBDb25jZXB0dWFsbHkNCmEgZGV2aWNlIGlzIHJlbW92ZWQgZnJvbSB0aGUg
YnVzIG9ubHkgYWZ0ZXIgaXRzIGRyaXZlciBpcyBkZXRhY2hlZC4NCg0KRnJvbSB0aGlzIGFuZ2xl
IHlvdSBjYW4gc3RpbGwgZmluZCB0aGUgcGNpX2RldiBmcm9tIHRoZSBidXMgd2hlbiBoYW5kbGlu
Zw0KdGltZW91dCBlcnJvciBmb3IgaW4tZmx5IGludmFsaWRhdGlvbiByZXF1ZXN0cy4gQnV0IEkn
bSBub3QgYSBQQ0kgcGVyc29uDQpzbyBsZXQncyB3YWl0IGZvciB0aGUgaW5wdXRzIGZyb20gQmpv
cm4gIGFuZCBMdWthcy4NCg0KDQo=

