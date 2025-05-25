Return-Path: <linux-pci+bounces-28381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB7AC3228
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C681792B4
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BBA47;
	Sun, 25 May 2025 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r1ZsXJRa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gr/bk33c"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6122F01;
	Sun, 25 May 2025 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748140614; cv=fail; b=snVSFbSSU+pCf2gvFAM+xpufFHkkfXmH/kgU8CgaC50P82au/oOUnAK6Ar/C4TXSYCLDAHpBmj/1+N6y1ZAPeAnxCZkRrevWSd8I2r1nSmeVFXmDzfkkDxdTbi2xmYZE9ex4mBYzED9kWGZDrsYwjznLm1iHAt9fFV07QoQPsjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748140614; c=relaxed/simple;
	bh=sePM2cnMocVHDEMbUezTSUbo+247YKHK6NvmwLSW28A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ild+LJ5KQXZudGhi7osa+qDCPVMn42UDMvuffGa31K2WimczYlqzIq3orZCfIKnmrPtk52jVFObRG9KqS8eXzKd08ZsV55bNVW3OhwToEizYivU4hq1jyXK3mAFNdNADhdlUQ2Tu2RdaofQWMY4cqFVKEwQV7wZ8MYbPY7bf0Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r1ZsXJRa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gr/bk33c; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748140612; x=1779676612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sePM2cnMocVHDEMbUezTSUbo+247YKHK6NvmwLSW28A=;
  b=r1ZsXJRaglReM/SnUwdN5t28NVKy6B4lEZesiCkHB/7mGT8aQxwf2Ln9
   c0ddBHkWObYTczvaSRiryuErpFfy6RvRyOW+xdsQ/l14gtukZL6IJmb3z
   MEVMcS90EefwMXQZzMqlckNs1ZlbANgOPneKh0gZywjHmElzsWV4t11U8
   WQSE3wrOvIh3eC3wy+ZtcEZhZELcvxKmnQ7ftTqTaHEwgYhr4ZFAwGPd6
   TbUACJzgXuxGW9hADjucga8ZSjHtgtOgq2GwBflYEpAIlE8lDiyEWxBPO
   tLKJqMbvCoTURZbeeb8i5N4SPk4EGQcgf2v2eZNeo4IRVtrw0Gefm8fiV
   Q==;
X-CSE-ConnectionGUID: 1KkuZhqbTjCR4+6au+sVEA==
X-CSE-MsgGUID: 7knE7malRgy9bdHQiKKz+Q==
X-IronPort-AV: E=Sophos;i="6.15,312,1739808000"; 
   d="scan'208";a="88958048"
Received: from mail-eastus2azon11011022.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.22])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2025 10:36:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojNgzVgKJ5yiUT8P+zhAp7e0NDvqMQ2iE+xxAUZ1b4Lbw3yG29ni0Gl051sntLfw57vkAFht+ClYku2kBUq+GBibT1VAPiWhN8UkmA4vLb1Jf3MPhRjQyfQSTKPetfx22/i9tTg0F2Z7RFlBIWcQ0g6JCZTpsy30a2voVAyIG+vIrZpJ/YlykFdQJPFl+7yRp28R46YJ8lTS46qTHU9snSvnVsAJpbnyqX0kf3j+xQ/+meImqaNPvCAHgZICmi6gQpVKOj6K0US1RMHwOc65uqa1YaskMAHk34dBSBQI5qavLflGduU6/X7gYfogi2ki4M8zK9WHQsx7rd/05Di61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sePM2cnMocVHDEMbUezTSUbo+247YKHK6NvmwLSW28A=;
 b=tvqlJe3hruh7Mi3FuplJIq4X6tX0vb5gc/JFTmRsKERbNk7F+mLiZ5TeeXmA4oqglFinJ+YOtDEfJPBDbgby2a9kx3jaU6FPdJhqHBlSks1QOm13kxhVLKo4Lefh/ZdPmVRxLTEnnC7XybsNC9Rkj9spCIr1t3wYafjNkW+YwTQsUAhQtuhv+pQoB6OFOGLNqdglFuVY2svH20PP4er+75xVVSzhgDJIcoOD9kS4rb7FUAn0L5TSon23HuCAb0OeaPpkcxUbrNZOo0spySR9Z8aiWLO8g5llAp7pcxMcTASp1svORzBSJEH71ZBF0KjvoZjNll8E0v99NK7qUiLR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sePM2cnMocVHDEMbUezTSUbo+247YKHK6NvmwLSW28A=;
 b=gr/bk33cR4UM49WDYI7deF2miBwdFSCC96wVU3YPFyqlskGAwRkzRKxyD3d5e3X86MqgfyVA3zcC/oYLkyv/xXtNN0G31JAaLOVIJJNpR0TFyHlKZixureOsFhk1NW6GHmAo/O7IwLcRTl28g/bFfls+Ww/Ocfg7lW0BHiiB3uc=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by LV8PR04MB9241.namprd04.prod.outlook.com (2603:10b6:408:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Sun, 25 May
 2025 02:36:43 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8769.021; Sun, 25 May 2025
 02:36:43 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Thread-Topic: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Thread-Index: AQHbzN0gIVy+Q6aIgEmANz/eANmVv7PiofgA
Date: Sun, 25 May 2025 02:36:42 +0000
Message-ID: <cfec2252044b208efef6ffd14a50f334528ceec3.camel@wdc.com>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
	 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|LV8PR04MB9241:EE_
x-ms-office365-filtering-correlation-id: bdcc3def-3e70-4003-8275-08dd9b34fc46
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjM1WFlTbk9hUEhPaDRwbDY0azRaUlBZT3BuMm1VNjdTZnBmYVd2YVlMM01y?=
 =?utf-8?B?OXQ5OFI3Zit2M3RFTFBQVFF0NzZCOFlVMHlyK0VaYk82eEU2RzBibENwZkhI?=
 =?utf-8?B?Qy9CN2MyVjVtQUR3aExDb2JkeWgxRjh2ZWhwcEttVnVsNnVHUmZPMk0xUFRD?=
 =?utf-8?B?dFB0aXkyL3VIUGhUY3RKTitaaFNoUVZBT3QxVmc4Y290NHk0YkFsaWhESEh6?=
 =?utf-8?B?UkkxSTl6V3VacFplL08xTWNNdzIwT0c5b3hjU1gvQnJ0UGlVV25RMFFPeWNO?=
 =?utf-8?B?WUIvZC9MRjhiSzJLNG44RGFFNC9rN0xkZ1pGc29lVllNYUxXZlhkOHJNbXZu?=
 =?utf-8?B?M3YyR0d2NDgvZ01YaTVVWU1vdzl6QlBkM1dzS1FBcDJiLy92ZVAxMFRwWEF4?=
 =?utf-8?B?VENBS2M3Z0dYb3prSE9zQVI2QWNpMU1UZUJHV2dkdjdsMExqcm9kR0ZIMTFv?=
 =?utf-8?B?alI2ajdzdzRVaTloL3dWSkFJRFQzN0I4cGxPL08zQXRKT2dTczBDRElOYk1O?=
 =?utf-8?B?MkNyUjZHYzZyeXk3RGoyM2puUGwwYXNoYll3SzNDNDN3ejZTcVhEVzJZdTNs?=
 =?utf-8?B?dXhJb3pvRjBBeWJVdlg4TmRRbkxiS0VkYmRkOW9UYWd4c0NNT0JzbTVaaE9w?=
 =?utf-8?B?dVk0SEs1c0RvUUN4UlZ3UksyV0JwSUdIemR5L0VReWU3ODBERjRQbC90OGhS?=
 =?utf-8?B?blFHcnB5bkRKcmtuNkxEU0I2V1hZeDRrWWJ0SFMrU2tybHhsSDRNY1l5Qlky?=
 =?utf-8?B?L0k4TkJwMVFEQnpUTXdYMkxzVnh5R2RqMlpyR1ptM0wzN0RkMDhxUGU3N3NC?=
 =?utf-8?B?Q1REUk5lZmR0UVFBTG51L090cGpwMWgzcG94c3VYYkRWN1VoSWFsZkkyTksy?=
 =?utf-8?B?b0ZULzNuaW1yaDNQdDRBR1NTQklBNUlqcSsxRWZ6N3lISWROZlp0NFZxSTVP?=
 =?utf-8?B?aGt0NXc1d1c2OWhwTERlajZMd05hMmVrdTF4cklkT2VEdExmb2JMNXJXSDZp?=
 =?utf-8?B?VzFWVVg4czNJMnVWSmtGeGlnYkhDbHpsZkc3TktRM2NRYXk4N2twcTIwV3Fo?=
 =?utf-8?B?UXQ3L3psR2VxbnRIQ2JhUGlkVzVoYk0vcXczOUxzWC82OGRqd3lDWS91Y1pl?=
 =?utf-8?B?Vm5tOEtFcWVrdDFXaFNvNGxJSGowa0IweWRQdFlVS0VzeGZYemxNci9seTdF?=
 =?utf-8?B?b2Z5c2d5TU1BZnprYXZNaEJhajN2K21MdkswRGFZNHZtc0FJMUpLMkt0SFpE?=
 =?utf-8?B?c1dWYzNhcitOUGx2blBia1o5VlNPa0k5L0xmK1JqbFliVXBqbHNlN0RXRzl2?=
 =?utf-8?B?VWFwSlRxUnBCamthUEdnN2xvalgrSTY2QmdYRGV3WFVFYjdoY3ZDdWxoSDhj?=
 =?utf-8?B?YTZ5Q001QlhOWE1UN1crM3dES0FxWjlQQ3NuZzFXaXRzVHkrZDhXRWlmL0J6?=
 =?utf-8?B?SnE3VTlKak1IeGZYZllwMmlDOVBuWCsweEU5bERsd0x1WHdOUmlSNjRuekZ5?=
 =?utf-8?B?RnBEN1BjSmpaOHNzK1IyRWV0NHl1dTNBV1ZEaEdZZFhKOTBINW1oLzN4anRB?=
 =?utf-8?B?QkVsbUN3QjJnM0RLNW5YTEQvMk4xY2xmTTVIS2hPV0lQZkdlL3E0RzhKVEFs?=
 =?utf-8?B?eHJDVTU3UUJXRUk5cUIxa3ByOWp4RkRSSTI0cVREZU14ZU1QRXN6ZkxvWWkz?=
 =?utf-8?B?K2ROVVZJZnA0T0g4WHl0OU9qZHB1aGJwOXd1NFU3QVdnSDd6aWRNYWJRT3Q2?=
 =?utf-8?B?TDVOYVhSRmU5UHowenBacFh3UVp4VmJ1WWVDblZsWm1qS3hoNTVKZjNRV05F?=
 =?utf-8?B?Q0dod0dTL2Q0OXBVbXBoZVFWZnlXTGdQbHdOYVpQYjdKOG90SFkxWGJvcU1u?=
 =?utf-8?B?ejNqTU1ETWdsT3d0b0F3Tk5zaWVPa2xzbk0wV0xlSUJzcmZVVlhqd0ttR2d0?=
 =?utf-8?B?c0xlWlpVeit4QmRFaHV3TEV6SkZ4NjJQYkdNUEgyVUYvTVVpYW1xQjcyZEJh?=
 =?utf-8?Q?FbarnpUKOrSZlgTF2L8QGyevt+6JbU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVFIQ3loTko5UjY0eWZwTU94dGp6Sko1VG9CeVVwRTd3cFZ6NlV5U3ZScXlq?=
 =?utf-8?B?dW9UTk1zcVp6ZHV3RnZDbmRiOUtleGVYV1RDR0dhNUppaUpreXBjOWlZeWdi?=
 =?utf-8?B?L3o4QytENmFQWVEvUmlZaDdVZ21qVWN4M3l6Um5IRzRWOWlGS3RlYllDS2N1?=
 =?utf-8?B?d3lHNUtGYWYxU1BoUHhiV0s0dWhQYzVvV1lEUy9hajVJN0pmSmxkNUg5cElW?=
 =?utf-8?B?dXAvTjJpN3BKUXhDOWx5aG5lMWR3eEEzMW5GTnIwbmhFWmdXUDFWOW9RS2xi?=
 =?utf-8?B?TER1MmNkZUZvMG5ZVGlYRjJuVjFtNi9aejkydkQvTlI4RHFTUUQxVFM2R3J0?=
 =?utf-8?B?bEtQVmpGMVQ2SVFPL2hqTGxOVHJYYXEvYWIydUdONVZhZCt0MmhxTjgvelo1?=
 =?utf-8?B?MXBZTVJMMGxnUllkWmZVRHZoVlZXNFZYdjhPZzlYMUJLVndudDZWS2JDa09Q?=
 =?utf-8?B?K25TQXJVbEZZNXg5L3JXa3J2dnB3aElMTEZqK0M4SnQxNlFkWXpIZHovUkh5?=
 =?utf-8?B?VXI5QlZzRWd3bTFWbnNmY1F4ZFZtemY3NEFhU0ZTVU5sL3Z0UVVTVkZGV2xT?=
 =?utf-8?B?Mk1mYXQvL2dhN1FiMHVrRzQ0SGxYNXZFa05tZlQzN01jb0N2VkRuNUdiWm1G?=
 =?utf-8?B?aGUvUnZoU3hUQmltbXJCb1lqVWNqOVFCWlNQeUE2VTlLUkt2UWR4K0w3eTFT?=
 =?utf-8?B?dU9QRlRrbVArT1Z2cnAyc0N5bDNycHBmaWgwYVNFTC9Ndm5ieWdTazhFL0dJ?=
 =?utf-8?B?SndQaG5jYTBoRVd6WlZZVW9lZEorVXNLdTN4eG01TDNPd3J3WVo3Qmt2cSsr?=
 =?utf-8?B?RFVSOTMzYllGUE1HR0FBcGVycFhDbElQdklhaHRTbHRHdmFZc1RPNmdKdXd3?=
 =?utf-8?B?OHk1dnJVVXZIbEFOVk1pcWVrWlRzcTNBTzNhY3Z3a2piWlUyaDJKS1BCd0Fl?=
 =?utf-8?B?d1E5YzZyV0hmYVJHb1RFdkUvci9oOHh5OXovUXYzWnBmeVErYnFxbkJTNUhZ?=
 =?utf-8?B?dFdkTWlTQzVYRDk3NVZFZlNBYmNLcHBuNkpGbk9iQjJweFRxWVZiSDIzN21S?=
 =?utf-8?B?Q3Ayd3VxWXZIckR3d3cvUzZ4MU1TY3FwVDVjdWlpQk5Wa2RrRksrWExjZldt?=
 =?utf-8?B?ZDZTTWRMaDcxbW54NDR1bnE1QXpYZzdRaklLb2xmVjVNWXFxUnhJQjMzVzNT?=
 =?utf-8?B?c3NJYVNsUlhRc2xYRzVsS2w2NXpoRnJLTDZXSmU0cmEwQ1FHVFlTdE0xbzZU?=
 =?utf-8?B?YW0wb0QwcFY2bDI1T3ZuRklBTFUxRGJJL212LzhTZlJYb0lnWXl0bTV4TVhG?=
 =?utf-8?B?KzdMY1UyVGVhT3pGWVhVUC9RanhaWFVnVFF4cWUzMlNsc3AxK1NNVUd0SzhK?=
 =?utf-8?B?cWNMSUNjY1JoQWlCUTFjM1RSbHdqZlJkMlpBVWF5S21rNExZL2lRelpHV2pH?=
 =?utf-8?B?aS95TTM1amQ4QlJKMmdkcHFhZmxoT0FHUEtHbmFiMXdNcGQwc3pMQk1VYVdt?=
 =?utf-8?B?REhzc3Q4QXllYTJ0U1AxbUFEZ2UyWStndnZuNE9MOHhXcWNCS2ZSL0VQSXBI?=
 =?utf-8?B?c2NzRDlkRUMySHJPemdjTmdYNDdzdGRJbW9nMXlWNFBJMGRZV1ZrSGhwaWxx?=
 =?utf-8?B?UEg1b3hFb2cxQStIY0pPYlViT3ZTUllFdXRkc3JZbzBrVCs3cnhzYXVoNVpC?=
 =?utf-8?B?akNzV3plMTUxbUtFbEo1K2hxYXpZOGJCZ1F4V2pnZFNONTI0NTBRSFNSdnJR?=
 =?utf-8?B?RVJyeUl3WkIxNUJQTFV6TVNOb0M0dER4dURUck83NlBBQnpVdUlpUFhTODFZ?=
 =?utf-8?B?ZkV4RTd6M04zamREUzdsYStKM0w3MCtQQ1hFSDVoaTlHNSs2ZjBHbXdLd0t3?=
 =?utf-8?B?d1ltdEQwMVpZMGNabWZPb1NxazF6aVZQcExvWTZZZlBVYUFvVk1MdXgvaU85?=
 =?utf-8?B?MUpFYzBIQlFYWXJES0E4RklGV25JMG5NaFZuVjVqMkYvNU9kcDF6eUNlSUR4?=
 =?utf-8?B?bCtVMTVkZXNxcXFVS3dETjFNcnFlcjBBdkQvMHdxTnJNODBEbWZKUmN5aERh?=
 =?utf-8?B?bGlIOW1pN0hndnFBQnBhcy85eXJINmZ5ZDcrL3o1bnJXRmh3dHNiNjJhMWtO?=
 =?utf-8?B?SklUZFdGL3hEZUFCMFRCTmFzTnA0Sno3Mzk4aFAzOXlyeVFiS0gxVkZxL0JV?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96F239EF400A344B8F64E2B4341FD255@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HGlQqpe/P5Jzqj+Mi/kjIDJVgX//YQpD/heRlUi8STs+/QuOPF8dIcO0u5xeoPHdlCxpzFhKI1cW1w/n6gEWDx279dPlCOG+awZDQ2UjNqxdj0+sHeeIz1qWce3cxAEsghv6nMkH609OVXEOiOk1co0evPjc9MNV2t8O6/hNaqYTBS/0s27Mn6b1XzJ+5NOU+lSqE/5IzaTLETlHqjkaokWDb+GOe1Ikg1dCvKMzalIzqAKStyv1RbCKiAhU2fV2mW8t8sL2wVuQ+yY8SyknSZnW6VrnStVwqauoQG3s5mpUOCTfC1NgZCfwvJolS8+yd+yM1NHQdJZ0mJ4ZU3N9lbIpgoMp+7DafAMq0xlqDSis/DW/njbMajQbPpQzf/ucNW+ko+ignO4sCGxTdno4bO8bZQ30YZ0exQKJEX5xYIxuat8iVUTLNnXP0aneS9NixJ6GRcW0105W9cJbF//8qZLVKx8Ld2nzkhKKpY9zhtDi8Y/dBDKm7P1XsP/p8SliaYKgp1MbwpASabtOWAFVPWipdSiGkcPX4SUFCPMrWyPtzCjD1yZTwQoKZuYgXeHL0rHt82D5nJ0fT2NVfwQzAZ4rdf0OSVB3b+sxOHbr2zUxNMLd++gUoma0L3CT6FHY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcc3def-3e70-4003-8275-08dd9b34fc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 02:36:42.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEgTEQet6/qdVno3t+ye9jp2kDK8xOV6fvnAoNYVSQ0Z7OVapvoDGiNscZgkx6DU//1NPc9msoKHCJ1xAcKKrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9241

T24gU3VuLCAyMDI1LTA1LTI1IGF0IDAwOjIzICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IGhvc3RfYnJpZGdlOjpyZXNldF9zbG90KCkgaXMgc3VwcG9zZWQgdG8gcmVzZXQg
dGhlIFBDSSByb290DQo+IHBvcnQvc2xvdC4gT25jZQ0KPiB0aGF0IGhhcHBlbnMsIHRoZSBjb25m
aWcgc3BhY2UgY29udGVudCB3b3VsZCBiZSBsb3N0LiBUaGlzIHdhcw0KPiByZXBvcnRlZCBieQ0K
PiBOaWtsYXMgb24gdGhlIGR3LXJvY2tjaGlwIGJhc2VkIHBsYXRmb3JtIHdoZXJlIHRoZSBNUFMg
c2V0dGluZyBvZiB0aGUNCj4gcm9vdA0KPiBwb3J0IHdhcyBsb3N0IGFmdGVyIHRoZSBob3N0X2Jy
aWRnZTo6cmVzZXRfc2xvdCgpIGNhbGxiYWNrLiBIZW5jZSwNCj4gc2F2ZSB0aGUNCj4gY29uZmln
IHNwYWNlIGJlZm9yZSBjYWxsaW5nIHRoZSBob3N0X2JyaWRnZTo6cmVzZXRfc2xvdCgpIGNhbGxi
YWNrDQo+IGFuZA0KPiByZXN0b3JlIGl0IGFmdGVyd2FyZHMuDQo+IA0KPiBXaGlsZSBhdCBpdCwg
bWFrZSBzdXJlIHRoYXQgdGhlIGNhbGxiYWNrIGlzIG9ubHkgY2FsbGVkIGZvciByb290DQo+IHBv
cnRzIGJ5DQo+IGNoZWNraW5nIGlmIHRoZSBicmlkZ2UgaXMgYmVoaW5kIHRoZSByb290IGJ1cy4N
Cj4gDQo+IEZpeGVzOiBkNWMxZTFjMjViMzcgKCJQQ0kvRVJSOiBBZGQgc3VwcG9ydCBmb3IgcmVz
ZXR0aW5nIHRoZSBzbG90cyBpbg0KPiBhIHBsYXRmb3JtIHNwZWNpZmljIHdheSIpDQo+IFJlcG9y
dGVkLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxjYXNzZWxAa2VybmVsLm9yZz4NCj4gQ2xvc2VzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvYUM5T3JQQWZwekJfQTRLMkByeXplbg0KPiBT
dWdnZXN0ZWQtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPiBTaWduZWQtb2Zm
LWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9wY2kuYyB8IDExICsrKysrKysrKystDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+IGlu
ZGV4IDRkMzk2YmJhYjRhOC4uNmQ2ZTljZTJiYmNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bj
aS9wY2kuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiBAQCAtNDk4NSwxMCArNDk4NSwx
OSBAQCB2b2lkIF9fd2Vhaw0KPiBwY2liaW9zX3Jlc2V0X3NlY29uZGFyeV9idXMoc3RydWN0IHBj
aV9kZXYgKmRldikNCj4gwqAJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqaG9zdCA9IHBjaV9maW5k
X2hvc3RfYnJpZGdlKGRldi0NCj4gPmJ1cyk7DQo+IMKgCWludCByZXQ7DQo+IMKgDQo+IC0JaWYg
KGhvc3QtPnJlc2V0X3Nsb3QpIHsNCj4gKwlpZiAocGNpX2lzX3Jvb3RfYnVzKGRldi0+YnVzKSAm
JiBob3N0LT5yZXNldF9zbG90KSB7DQo+ICsJCS8qDQo+ICsJCSAqIFNhdmUgdGhlIGNvbmZpZyBz
cGFjZSBvZiB0aGUgcm9vdCBwb3J0IGJlZm9yZQ0KPiBkb2luZyB0aGUNCj4gKwkJICogcmVzZXQs
IHNpbmNlIHRoZSBzdGF0ZSBjb3VsZCBiZSBsb3N0LiBUaGUgZGV2aWNlDQo+IHN0YXRlDQo+ICsJ
CSAqIHNob3VsZCd2ZSBiZWVuIHNhdmVkIGJ5IHRoZSBjYWxsZXIuDQo+ICsJCSAqLw0KPiArCQlw
Y2lfc2F2ZV9zdGF0ZShkZXYpOw0KPiDCoAkJcmV0ID0gaG9zdC0+cmVzZXRfc2xvdChob3N0LCBk
ZXYpOw0KPiDCoAkJaWYgKHJldCkNCj4gwqAJCQlwY2lfZXJyKGRldiwgImZhaWxlZCB0byByZXNl
dCBzbG90OiAlZFxuIiwNCj4gcmV0KTsNCj4gKwkJZWxzZQ0KPiArCQkJLyogTm93IHJlc3RvcmUg
aXQgb24gc3VjY2VzcyAqLw0KPiArCQkJcGNpX3Jlc3RvcmVfc3RhdGUoZGV2KTsNCj4gwqANCj4g
wqAJCXJldHVybjsNCj4gwqAJfQ0KUmV2aWV3ZWQtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJl
ZC5tYWxsYXdhQHdkYy5jb20+DQo=

