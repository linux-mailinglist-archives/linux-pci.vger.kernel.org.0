Return-Path: <linux-pci+bounces-2775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE48841E72
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEADB2CD3E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4256B9E;
	Tue, 30 Jan 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMTcBRHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5957861;
	Tue, 30 Jan 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604250; cv=fail; b=I58u14leRvAbKQRHFNyR3Ys98qayZQfCsGavc8qGO/t7T3CoGJKADq1cO3zEoxDCjOwvXgbjzwNh/QZ6K04ACHnQ3IKbm3Yk9YRriID6aS9ShGSLgIC7jgaGpDqZdGDBnA4HAMJFRpAcV9XIr08rla8vsLnpZVoHgMgGYrFxL5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604250; c=relaxed/simple;
	bh=snl3EjQKpoCo3uaksTs7n+j6TTJt3Bh3wgBqhPeQyJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tY6tEspUUzIcZToNI7kFLtRprrR+JjRH/TZqdjM3NyA1yIA2fRWLgSBXd14GSqq34ndQM7hwZPaNGtueYVCdJwTqzwLvysjGqf/S/AsAs7RywwGQmcbjtBgqajHuibP9A7rWW/ZCTodOCYckQvfbgK3ScFfcMoi8299zcpVZzxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMTcBRHA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706604249; x=1738140249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snl3EjQKpoCo3uaksTs7n+j6TTJt3Bh3wgBqhPeQyJQ=;
  b=DMTcBRHAH7QNPZZz5nhH7F92CfdVRkhla0uSkht5sdu+6e0BK3f6leD/
   cTHuOWMmRDWBN6tGM9aelAQcOn7kCXaEEEoqeDwXPML5avahptdmr0Eoq
   leQBt/2LUXzubgXSYJROp/jGKZVfqJ8Z46QRerGLqwlRtw44xs6QbOkn8
   nazftsyizKySZqpiBfuDhppnQxsDjhyrt9iMjN8ezH0dbzbXn2/Dhh60z
   Y+yotMNew+URJUArHUQX33jeMQl0+1JurrrYRvDh2oqvfyDILzDRslWjZ
   md6rIOSSY9E4JJbLUXdUQ0GbEmWzAJ/AX1MVZ/+KDLkW4T/Or7QwVsjoM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3047301"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3047301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931369659"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931369659"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 00:44:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 00:44:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 00:44:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 00:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpm5gcfjmVWy0HES8ktCHBQojpmPltDSQd4faE/jMsVrWUx/AEQl7hdt8yeQnzHQBhc8Ug5QuuDLLJo4SCN1nRUNRZNg2tF4Sk7HZd4J/RAYaWiS7w8fRuxLWUV2BbQPeYSIa9qr43lYAXcZKuN01zjSSpvaUnf0rftvIEi9VdKo4PikcmEC6pFOADquHfpwzBnaSK2ABWiRK7mEpIXLLMq9EdUwMEpCkf6oPX0gqVhjK7cY+Jd6XDf/r40gWFTRrkAClRid5UlIzZvp/jZjKeW1A7NbDkzFiWuVKiec8BJA14ADrf0x/DdhDscOu2Lh7pnpjxB92HSZQ1Ge8F4Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snl3EjQKpoCo3uaksTs7n+j6TTJt3Bh3wgBqhPeQyJQ=;
 b=nZ/Y046Ij/3v3QZkK5VZ/c3VQ9y99vx4q9fB5boCTuzDAiY2IO8zvNHmBC1rt1rTo7HcWEeduNinB5HlmnD7C9kZE1NqEEBxH32Mm7sRdxdNy9G6uVLZ27EcP10VL8xlaJktt1RpR0eZhNSW4aX9bZvC7TIIjQyVufziwuWvftpB1DaNTESnKB5UhJHS1lFqHD7G65WtRtddsfQs3cHNA5faVRG/NR4hyjiz1E1wwQkgEccEJvIOZebA5IK+4SVakd5RKBUMjMU3pbQuqdJ6+be8pqr4owR7rHl0g4Y6WTTVPfQz7Xx9dlj9MMbj7plA7+lOGpI+5AZvqDohiQ9vmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 08:43:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:43:58 +0000
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
Thread-Index: AQHaUmY538BcsBx6UEOae7WqjB1D5LDweayAgAAKqQCAAUzCgIAADpYAgAAkhICAAAGe8A==
Date: Tue, 30 Jan 2024 08:43:58 +0000
Message-ID: <BN9PR11MB527674172BBA9BDC49A004D08C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
In-Reply-To: <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8475:EE_
x-ms-office365-filtering-correlation-id: c669bbb9-019d-4ed5-402d-08dc216f99a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htZ99Z8C8YDQ4U7dbvhedjtLp/eoEp4e1km3zFoY6TSlDCDi1nsjnSV9oEjHyV/VDXlhz0oD1ALo/WK0RJ2ckCphzElKqSJ1zI54vZ5EaaQo555Z2QsACQpx3gsN10Sq5gkrLwIfnlti21gpZ/OlNXoWnoYT1SAHPWKErTn5c90SvehrQyOjKjMSTbNu7uW2H5fL2C9Dz7GlA41FkbVoYvD2vSSE2nz0SDex63XIiaACadLP5jfJxD9QuxL4RtjJsn6V/WddXdDIDK6vmD/9KT+GH6TMvdqn5W6zjBAppyBpRqqUiObHoUQxwyovoyD4bOfbb3dzXEbwlhYjTnlqYj6N4U3JVngM6c9fAnZB0upk/YAFEWBW48/kSDGm2MdKHvR00kz6pvvPW7cFwNnrpCaleYKbMetd12MZiSINQkaRAvBl8fNPykjifN/q07qJBs+qCYb/F4KS9UNaPJ85Kd1B1kavudfVy8/Ic9crZTA0U1T41hEBwgwyQpnNkNnU3cU0v1wmRntY2KZFMCkX7prItBARbBWS6CJ1nnLiCFgrEW6K7jVPDNYPLpVMPYXWczzv246VEo0Ydc5hjdJqmWFb9alJttzwWI/covMpBQ9RsnkvJnDMcjS6l6lReDZ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(83380400001)(6506007)(26005)(7696005)(55016003)(33656002)(86362001)(38070700009)(82960400001)(5660300002)(8936002)(52536014)(4326008)(71200400001)(41300700001)(8676002)(38100700002)(122000001)(66556008)(54906003)(66446008)(110136005)(64756008)(66476007)(316002)(9686003)(2906002)(478600001)(7416002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzRuV3VKQVcydjlDd2UzNVhMTTdWLzFwdGx6VEpzSWVtVjkwbUV0Q2JsN09p?=
 =?utf-8?B?RWU4WUF5aVltaW5rcnlmRWg4Wm5HV2tmV0NkWmVKMTZrMGZ6TS9NWEFRd1ht?=
 =?utf-8?B?NThnbnppN1Awamw5MjFLeW5CVE5GMVBPMGpvV2VMd0xaUzlteVIxSWRWaFZi?=
 =?utf-8?B?Z2QxWlo4SVljTEZnNlF5QWYvZ25FeUlybDMrdkJrQUFIdXdHcUhoS2pHV0hL?=
 =?utf-8?B?RzhsZ3NkVVlpSFFBY21aWG5zUU5vN0tmaUxDcEpFRDlUQUY5UUVqWEhTSnhu?=
 =?utf-8?B?a1lsMHJMeXBMOUJQRDFXRnFuUE56NGRQc3dncVBPYnIzTmdmNkk3RGE1bXZS?=
 =?utf-8?B?TWV1WlpXSHAyeW95dzlUOHFrUnUxekdFRVN6NXRlejVLeVpxbjc3RkhvZFhN?=
 =?utf-8?B?dGhQVUlqaGYzRURDeWZXY2djSTZRZHIyR2JPNmVBWW1lSzZia0M2Yll5ZHIw?=
 =?utf-8?B?QTZjSnA0VDlHQ21FVzQwUkZVK3VKenk4TkdlUVRFYW01VUR6L1dFNUowZWNX?=
 =?utf-8?B?UEtjLzVJaUYzcVhBK2c5L0U2b1kwellienVSalNzb1BYS3dzT1ZSUEc0YzdG?=
 =?utf-8?B?bktPTnlDc0RoY2pFWlRMSk41YVRYRmgyc1BvT0cvQjNqT0FZbzVRY20vVUZF?=
 =?utf-8?B?QU13M3N3bTJNQ0c0amN0cGdTY3ptbzhYZCtHYjZTcTJiajlNYnVVT2lsbjBF?=
 =?utf-8?B?WlRLZlJvSnFxNU42YktvRmV5RUdQYkQrSjNIWXBPakw3Wi9ua1lIY3JMMkNI?=
 =?utf-8?B?Y3JOLzl3OW1DZXJ6REc3MWVkQnV2RWRkOGtWQ3g5RXZMaUFTWHREZnNZMlBk?=
 =?utf-8?B?Z3RmVnRyOGlWMXp1bnR2L2dqUlNoR2psU096N1FDa0p3QTdZem5BRWJVZmN6?=
 =?utf-8?B?ZkVDZjFLNHdMNU01MWlPVDQrbGVUMlZRUHlzUmZuUFo0Qkh0ZVo4UDE2aU1F?=
 =?utf-8?B?bi9pVnZnVXNjaEZ2WVR5N2lwcVlxUCt5SmZjZ2hCK0tqSnVzT0VtcXppSGsz?=
 =?utf-8?B?eUJpQUlHVW5UNWRnUzRaMkc4cVM5aC84K2hLRkNnNDZyOUNtK3VzUlB1Z2Vs?=
 =?utf-8?B?VUtOT1M5VG5CUTVrOVZIT1hCZUxIMjZ2U1RBMXM5a1I2WTB1eG4yL2M4MitO?=
 =?utf-8?B?WlFXR0tSUGIrbWFRMkVXZEhXOXQ4aElUNkJ5RTM2bk9FUWV4STl0cGduU0Fl?=
 =?utf-8?B?Y090VGNvL291Wm5UZDM3N1E0K1Bobml2TGw2bkpPQ3BjV05XbkY2SXVpdmNZ?=
 =?utf-8?B?ZVRWZGF0NzRjaWdZaXMycFU4VWU4b056TStPczJjQ2tyTFp5WlJ0a1psa3Vr?=
 =?utf-8?B?QXBFMjk1M1BjUmhxc0dLR05yQ1haN1NlZ0RZTzg5bDVQSjBXTW50Zjl0elRk?=
 =?utf-8?B?T2RTY2tRek9mTHFIbmgrckZ2N1ptckZZbktCZGdJQzkzZndwSzlPclFGcG1U?=
 =?utf-8?B?S2h4dG5TRG1XTmNRczltOG9KREdnSDIxTkFOa0Y1akRuY2IrbEZvdGxGL1Jo?=
 =?utf-8?B?Yyt3dWhldmM0bFRXa1lkaWJEY3VmbHBrb2tRWVdFalU2dzNRdWg0V0c2S1NS?=
 =?utf-8?B?SktIdVRSRTVQRm84V21ES0xacTdBcnRyb3Z0WUpSaVFEK2xaK3dhTlNjeEV3?=
 =?utf-8?B?enBqVE5icjdKR0dJeXlJVkxwSWdtM3RTRVRPelF1YzZaSjZQWDZCdXpxeWhU?=
 =?utf-8?B?bEdxZWthblRDOGNSanhvK3RzRVNucVc5Y2ZORkE1MVdmLzdjOGV4YTJiWlZw?=
 =?utf-8?B?VXIwSzFWL0FZU1JGUnh3cXduV0l2TzFNZXhtaVhCSng2V0d0SmZyanEyTzZY?=
 =?utf-8?B?ejdGdkNya2xieXBMU1ZOd0o1M3Z3NXoza3hRZTB1K01SRFJDV3UrOTdjSFpi?=
 =?utf-8?B?RldZdVIrTWczQmdWSUdvc1VVV09vd0tqdEFxL3FYQ01CNHROTUM3VnZEV2g2?=
 =?utf-8?B?SC9MWnBsZnJLOVIwUlFER1NQdENuUFhmWm9TV0w4NWxXTmhrbFdicTRlVlRv?=
 =?utf-8?B?OGhvUHNLUDkrKzM0QjEyVU5tcEljOE5vU0ZHeStSQ3lSNHE5WVVtdERLY0dH?=
 =?utf-8?B?TXVEcUNsb01vSXBiMlpwNEd5SVFMd0xYVGFUMXlXNFM0dUt1ZXlWSUhXSDh2?=
 =?utf-8?Q?KXELzhki/AQaIyKoUFPLh9e2f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c669bbb9-019d-4ed5-402d-08dc216f99a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:43:58.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HyKEybZ+P18VF2TYu8dLcOrybpYyQ4fbDFbGTfIK7Aw3iRcTRwmm9LohsQE0tWeJAHza7P/M9CTExhHTArfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDMwLCAyMDI0IDQ6MTYgUE0NCj4gDQo+IE9uIDEvMzAvMjAyNCAy
OjIyIFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiBIZXJlIHdlIG5lZWQgY29uc2lkZXIgdHdv
IHNpdHVhdGlvbnMuDQo+ID4NCj4gPiBPbmUgaXMgdGhhdCB0aGUgZGV2aWNlIGlzIG5vdCBib3Vu
ZCB0byBhIGRyaXZlciBvciBib3VuZCB0byBhIGRyaXZlcg0KPiA+IHdoaWNoIGRvZXNuJ3QgZG8g
YWN0aXZlIHdvcmsgdG8gdGhlIGRldmljZSB3aGVuIGl0J3MgcmVtb3ZlZC4gSW4NCj4gPiB0aGF0
IGNhc2Ugb25lIG1heSBvYnNlcnZlIHRoZSB0aW1lb3V0IHNpdHVhdGlvbiBvbmx5IGluIHRoZSBy
ZW1vdmFsDQo+ID4gcGF0aCBhcyB0aGUgc3RhY2sgZHVtcCBpbiB5b3VyIHBhdGNoMDIgc2hvd3Mu
DQo+IA0KPiBXaGVuIGlvbW11X2J1c19ub3RpZmllcigpIGdvdCBjYWxsZWQgZm9yIGhvdHBsdWcg
cmVtb3ZhbCBjYXNlcyB0bw0KPiBmbHVzaCBkZXZUTEIgKEFUUyBpbnZhbGlkYXRpb24pLCBkcml2
ZXIgd2FzIGFscmVhZHkgdW5sb2FkZWQuDQo+IHdoYXRldmVyIHNhZmUgcmVtb3ZhbCBvciBzdXJw
cmlzZSByZW1vdmFsLiBzbyBpbiB0aGVvcnkgbm8gYWN0aXZlDQo+IGRyaXZlciB3b3JraW5nIHRo
ZXJlLg0KPiANCj4gcGNpZWhwX2lzdCgpDQo+ICAgcGNpZWhwX2Rpc2FibGVfc2xvdCgpDQo+ICAg
IHJlbW92ZV9ib2FyZCgpDQo+ICAgICBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKCkNCj4gICAg
ICBwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2UoKQ0KPiAgICAgICBwY2lfc3RvcF9idXNf
ZGV2aWNlKCktLS0+aGVyZSB1bmxvYWQgZHJpdmVyDQo+ICAgICAgIHBjaV9yZW1vdmVfYnVzX2Rl
dmljZSgpLT5oZXJlIHFpX2ZsdXNoX2Rldl9pb3RsYigpIGdvdCBjYWxsZWQuDQoNCnllcywgc28g
cGF0Y2gwMiBjYW4gZml4IHRoaXMgY2FzZS4NCg0KPiANCj4gPg0KPiA+IHBhdGNoMDIgY2FuIGZp
eCB0aGF0IGNhc2UgYnkgY2hlY2tpbmcgd2hldGhlciB0aGUgZGV2aWNlIGlzIHByZXNlbnQNCj4g
PiB0byBza2lwIHNlbmRpbmcgdGhlIGludmFsaWRhdGlvbiByZXF1ZXN0cy4gU28gdGhlIGxvZ2lj
IGJlaW5nIGRpc2N1c3NlZA0KPiA+IGhlcmUgZG9lc24ndCBtYXR0ZXIuDQo+ID4NCj4gPiBUaGUg
Mm5kIHNpdHVhdGlvbiBpcyBtb3JlIHRyaWNreS4gVGhlIGRldmljZSBtaWdodCBiZSBib3VuZCB0
bw0KPiA+IGEgZHJpdmVyIHdoaWNoIGlzIGRvaW5nIGFjdGl2ZSB3b3JrIHRvIHRoZSBkZXZpY2Ug
d2l0aCBpbi1mbHkNCj4gPiBBVFMgaW52YWxpZGF0aW9uIHJlcXVlc3RzLiBJbiB0aGlzIGNhc2Ug
aW4tZmx5IHJlcXVlc3RzIG11c3QgYmUgYWJvcnRlZA0KPiA+IGJlZm9yZSB0aGUgZHJpdmVyIGNh
biBiZSBkZXRhY2hlZCBmcm9tIHRoZSByZW1vdmVkIGRldmljZS4gQ29uY2VwdHVhbGx5DQo+ID4g
YSBkZXZpY2UgaXMgcmVtb3ZlZCBmcm9tIHRoZSBidXMgb25seSBhZnRlciBpdHMgZHJpdmVyIGlz
IGRldGFjaGVkLg0KPiANCj4gU29tZSB0cmlja3kgc2l0dWF0aW9uczoNCj4gDQo+IDEuIFRoZSBB
VFMgaW52YWxpZGF0aW9uIHJlcXVlc3QgaXMgaXNzdWVkIGZyb20gZHJpdmVyIGRyaXZlciwgd2hp
bGUgaXQgaXMNCj4gaW4gaGFuZGxpbmcsIGRldmljZSBpcyByZW1vdmVkLiB0aGlzIG1vbW1lbnQs
IHRoZSBkZXZpY2UgaW5zdGFuY2Ugc3RpbGwNCj4gZXhpc3RzIGluIHRoZSBidXMgbGlzdC4geWVz
LCBpZiBzZWFyY2hpbmcgaXQgYnkgQkRGLCBjb3VsZCBnZXQgaXQuDQoNCml0J3Mgc2VhcmNoYWJs
ZSBiZXR3ZWVuIHRoZSBwb2ludCB3aGVyZSB0aGUgZGV2aWNlIGlzIHJlbW92ZWQgYW5kIHRoZQ0K
cG9pbnQgd2hlcmUgdGhlIGRyaXZlciBpcyB1bmxvYWRlZDoNCg0KICAgICAgICBDUFUwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQogIChEcml2ZXIgaXMgYWN0aXZlKSAgICAg
ICAgICAgICAgICAgICAgKHBjaWVocCBoYW5kbGVyKQ0KICBxaV9zdWJtaXRfc3luYygpICAgICAg
ICAgICAgICAgICAgICAgIHBjaWVocF9pc3QoKQ0KICAgIC4uLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLi4uDQogICAgbG9vcCBmb3IgY29tcGxldGlvbigpIHsgICAgICAgICAg
ICAgICBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKCkNCiAgICAgIC4uLiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGNpX2Rldl9zZXRfZGlzY29ubmVjdGVkKCkNCiAgICAgIGlm
IChJVEUpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQogICAgICAgIC8vZmluZCBw
Y2lfZGV2IGZyb20gc2lkICAgICAgICAgICAgIHBjaV9yZW1vdmVfYnVzX2RldmljZSgpDQogICAg
ICAgIGlmIChwY2lfZGV2X2lzX2Nvbm5lY3RlZCgpKSAgICAgICAgICAgZGV2aWNlX2RlbCgpDQog
ICAgICAgICAgYnJlYWs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidXNfcmVtb3Zl
X2RldmljZSgpDQogICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRldmljZV9yZW1vdmVfZHJpdmVyKCkNCiAgICAgIC4uICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvL3dhaXQgZm9yIGRyaXZlciB1bmxvYWQNCiAgICB9ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAuLg0KICAg
IHJldHVybjsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCVVNfTk9USUZZX1JFTU9WRURfREVWSUNFOw0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGxpc3RfZGVsKCZkZXYtPmJ1c19saXN0KTsNCg0KKEkgZGlk
buKAmXQgZHJhdyB0aGUgZnVsbCBjYWxsaW5nIHN0YWNrIG9uIHRoZSByaWdodCBoYW5kIHNpZGUp
DQoNCj4gDQo+IDIuIFRoZSBBVFMgaW52YWxpZGF0aW9uIHJlcXVlc3QgaXMgaXNzdWVkIGZyb20g
aW9tbXVfYnVzX25vdGlmaWVyKCkNCj4gZm9yIHN1cnByaXNlIHJlbW92YWwgcmVhc29uLCBhcyBz
aG93biBpbiBhYm92ZSBjYWxsdHJhY2UsIGRldmljZSB3YXMNCj4gYWxyZWFkeSByZW1vdmVkIGZy
b20gYnVzIGxpc3QuIGlmIHNlYXJjaGluZyBpdCBieSBCREYsIHJldHVybiBOVUxMLg0KPiANCj4g
My4gVGhlIEFUUyBpbnZsaWRhdGlvbiByZXF1ZXN0IGlzIGlzc3VlZCBmcm9tIGlvbW11X2J1c19u
b3RpZmllcigpDQo+IGZvciBzYWZlIHJlbW92YWwsIHdoZW4gaXMgaW4gaGFuZGxpbmcsIGRldmlj
ZSBpcyByZW1vdmVkIG9yIGxpbmsNCj4gaXMgZG93bi4gYWxzbyBhcyAjMiwgZGV2aWNlIHdhcyBh
bHJlYWR5IHJlbW92ZWQgZnJvbSBidXMgbGlzdC4NCj4gaWYgc2VhcmNoaW5nIGl0IGJ5IEJERi4g
Z290IE5VTEwuDQo+IC4uLg0KPiANCj4gc28sIHNlYXJjaGluZyBkZXZpY2UgYnkgQkRGLCBvbmx5
IHdvcmtzIGZvciB0aGUgQVRTIGludmFsaWRhdGlvbg0KPiByZXF1ZXN0IGlzIGZyb20gZGV2aWNl
IGRyaXZlci4NCj4gDQoNCmFueXRoaW5nIHJlbGF0ZWQgdG8gYnVzIG5vdGlmaWVyIGhhcyBiZWVu
IGZpeGVkIGJ5IHBhdGNoMDIuIA0KDQp0aGUgcmVtYWluaW5nIGxvZ2ljIGlzIHJlYWxseSBmb3Ig
Zml4aW5nIHRoZSByYWNlIGludmFsaWRhdGlvbiBmcm9tDQpkZXZpY2UgZHJpdmVyLiANCg==

