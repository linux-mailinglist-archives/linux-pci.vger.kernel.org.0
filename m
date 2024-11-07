Return-Path: <linux-pci+bounces-16192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BA9BFBFF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 02:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F0D283CEB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D98748F;
	Thu,  7 Nov 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HKExdRNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AB23C9;
	Thu,  7 Nov 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944299; cv=fail; b=QRVeYu0WmhGSDI/GuodmZqrvB8k+F9X7YwB9g/o/pYJR2x5YJ3VzW2anH0dIsbTNaPGNmOdbbUPtRsHwXbp8R37OT6i3xgUyD8QZHFTlVlOB87mLVsJceSxguuR0kg6DUjo+Vh2xWRP89DlNS9ZWbxKNbm2Pwk9AibnJxkcakN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944299; c=relaxed/simple;
	bh=069ff7noguS+8Gd7Xx58sggQ0SOJQnRcS7JneDJiY/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzmFQP54YxaeytYuiw8kt9BBxceZH87n1L8UznIv8TF8xUaKkkjFysqw7GiUqrq9wuHeqokMO75RnqtUA6pZ6JRcKvgAk08b+6dyIcBGpmzsiq9j7w2t4tIbnruslXL0/7YoHDTs5hUZpRGSAYlj+1pOX0sosdeWx/17P88KjrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HKExdRNO; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ08oQEu0zORMtAIjaXIcxoXSU8CYKNEAR6XzIMJCZoHCoBNXW88BUxvrDf4QUz2mk++u6GA8ArTX76i8iE+iPO3T0KJYsqWK/qC4hD36+sXtAAd8osxUEC5Z55kkvPFgCR4RLjuyN+sTZllg4Ms2nO2i1vVzvJzAKzfP/rEzoYL/jUq9k0EePREHsfbjVcQ8rUOcn0p9kUCnWzE02WPwI57bJWCWTLP3MnchmpfoK12YKwMsXpyWp2INqX5tHEr0EP8RFQN2sSpeVrdMfsJe/ZplPmWN/0vs/DEjyjag2R2JS7XcFnApUpZF8gXvEUOAaWIitdIfROvFgJuNiIhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=069ff7noguS+8Gd7Xx58sggQ0SOJQnRcS7JneDJiY/8=;
 b=YYC+UTfhgyADF2vbEKlwIKtqhnb4fUX+tLdhPZuj7woUns7OLAdWdT6m3QMf7dbFGrjrOr9COc0bzTXXA3htuzGkb/s/RcXI8TvC/9B5Mv926epJLJxXfQwRFh1rqui9y1GeDWdD7I4pTU38X12OR17/+FRv+Iy8ZXA6JNfPZ8nt7cSwM5nW6UbiaYHan4NyVgjU/5mK9zZLMzs7hkivOUkU+Co9vDuwSbrsqKH8VbiVR4ue7GMfJ/yT7SEuEG3gR4UKi10kNx+xqZZJHyZfUxwjhmLwpk6tlRhZ6GI4EEXONjBkNhDHIRkoFyGlyZ8/h71tStGUWDXmSGzWmokuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=069ff7noguS+8Gd7Xx58sggQ0SOJQnRcS7JneDJiY/8=;
 b=HKExdRNO9nCHOT1zpBj6OW4fdwtFPR1lkfzENL70Ot96Nt0JHf4se7eBQHhTY9LFt7P/vtYkMergvecOyP2Zqt0qxMT/HjiZ+u+nOw5iXPssSoWzcwHCtv8aoXOtZsZyTuTMAOpdwKlcPjoxK1lHjE+lnOnbPKzyp3byBOJHulXdDCHe30iR7xNDQQW6pookXJSkbqa7nc4lf9DVqCccDg/b+B2TCwCsofhDFr9qYsvr+f0Zu8+zr2HbPnPZD9zJVVd58zBWdogGJUNh1x6QzXxYEbqZ1seTSpdNMGHrlJDEpw8d1GCt3wDJsW04i7MW5zlycjIPF0dKqDLbij4YEQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 01:51:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:51:33 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ee+/ve+/vXNraQ==?= <kwilczynski@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index: AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKmrdaAgAPAQkCAAJUGgIAAsxRw
Date: Thu, 7 Nov 2024 01:51:33 +0000
Message-ID:
 <AS8PR04MB8676E9B9B4BB1BA63DD761798C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
 <20241103205659.GI237624@rocinante>
 <AS8PR04MB8676B83C73ABBA45A34C58DB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106150715.GC2745640@rocinante>
In-Reply-To: <20241106150715.GC2745640@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS5PR04MB10019:EE_
x-ms-office365-filtering-correlation-id: 711bbc96-32b8-4d0f-acde-08dcfeceb546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1QwdXRjUUlqZVVJT2VSdFVvM05xZ2JYdnZBWGNNaDlQdk50VFkrRW52U29M?=
 =?utf-8?B?M2Z4NllSVVd0bytjeTZzcmxxMExuckNmcUlUS21yUHdHbjJnUkJsODdTTW9D?=
 =?utf-8?B?VDJrL2x0aFU2L0xuS2NudzVWdlBXR0ZpeUtpdlFmMzZoaXBLTEwyMGxzYk12?=
 =?utf-8?B?NmVETHpLWVlhc0p4S3BHUEZhbGs3VFJmVmdPUjNCQkM5UWEvdWJOZSt1MVpK?=
 =?utf-8?B?bjdHZGRvQm85bnlKQ29NSTZ6cFRPZ0E4UDZCakRHQVY1WTVMVGIzdkZFc1JX?=
 =?utf-8?B?bUJqTnhadExpRTdhcWtVOEVrbFpoZC81R3ZhTGcrSC92SVVweXNVd0NnUGhK?=
 =?utf-8?B?NFMwcUk1YlNGaGdhU2ttRWlkTFFZa2paNVAzbUlmU2tkSCtmVEVQNDVISVJi?=
 =?utf-8?B?VTRYcWZpSFROOUFSeXpPNXNxMWplNzJjeUZBaDJUdExiOGg5ZUZxWEZFQjIy?=
 =?utf-8?B?ei90eHhrWmJSZkR5bzJpcktuZk5rbGFSVStEWHB1M0MxUWRPSElvQ1FPMFhz?=
 =?utf-8?B?MTFkYXN3cGhqQktLTEwzQmlvemhRMzlTb254ZUlEU3ZVbUJOYnUxY3dKQzVF?=
 =?utf-8?B?bXNpUkJvRDRmS2ZuaGUySFdoSkJtVHdsUWRpU1ZlWmJlY2VEVXdoK2ZXU1A0?=
 =?utf-8?B?NHlLRjlvTThIek1PQlVVZW1FZWpoRmVTM3JQTWtMdEU5U2YvbHNzNjc3dDMy?=
 =?utf-8?B?d3pvN2RpTFFuZUhJbVU1VlZLUWkvdno3YytNM2JBNXB3LzBDSlpYNjZSNnF5?=
 =?utf-8?B?ZTRncmYzaEI2V2J5c1NEWDlxdy8zSUhIbVNEbmt3Ymhxc29NZnpqVjRxQkYx?=
 =?utf-8?B?Ty9VcGRhckV2WUFsa09mb3JDaURpNlhjOGU3QjhRcHlzSm5RK0hnSFgwdVg5?=
 =?utf-8?B?dFUwYnJIZkV1L0JNVkNUQ0tnQW42QUowWTRxaXVZRE14WVhKOElTek1yTUZq?=
 =?utf-8?B?LzVqQWFHVVlOV1lWQU1LenozZTB0eUhsb3NMOHRSalZHYkZTSEpMdVJRWFFy?=
 =?utf-8?B?cmtTYVF2Z21wRWgyZFdRZEVxQ1pybGoxVnNRRWlScFJsbk53MTZ4d3Z2NTQ2?=
 =?utf-8?B?eE9nbE1VTUVzQjNJK01XRHNzYngwTEtWMzZZM2VhR2dmaEhFOE83QllMd2VC?=
 =?utf-8?B?eGlKa1ZSbXl3cjNlcVVyTGlUSHF1aG5IRm9tVkpURTMyUllhNDlXMUZHbHdk?=
 =?utf-8?B?a3pwRmpzTW9UMk1FRko5TitoUm80RHNUQ3RyMllyQkxoS1BRZ0l0aUpsSWly?=
 =?utf-8?B?S1NoeDRUcmFWZ0F4aXJnSkUyVGhodG9EZU00MjJLa1RrVEwxZFRzRFpTSnRC?=
 =?utf-8?B?TTNkVEtMWDdnVEVLc1ZXbXFmeE5FMWh4TktYZ1ZnNDJaQmhkYmdLUjU1cTNa?=
 =?utf-8?B?YTE4MDY5WWYxblhkc1VZUkh5cHQyODRpZ0d1ZVh0UCswUVNVZ1F2MU9LeDdS?=
 =?utf-8?B?MXplUDl6K0ZySTZZYkR6TE9yanJ6ck9rS2RVR1VBRDBhOHducUdGMkkrTVE1?=
 =?utf-8?B?aXhhbXl1ekYzb1VxZ2FRR3cwSmFYRzRqVVRTS3BzQW9uakR5U05sSlRKdGha?=
 =?utf-8?B?SVliWXByd3lGQ3B0ZE9qaERZTlJVNFJWZENiN1VrOWZON3Z2NTdzNzdlOEFN?=
 =?utf-8?B?VjlrQm9RQU5SdFZtbFBiZlZsbzBFTGhieXRIK1ZxM1ZNRk9FS3RoenBicGcw?=
 =?utf-8?B?QmxUck9NT1FDMjZNQU5MOHBDSFd3WGpJYThjSkFTUHNrT1R6TUNCemRxVmVz?=
 =?utf-8?Q?s9IwHGYWmpwrOkVPs5OAg26wiegDk0jm2FQFDT/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGZGQitXbUNDdEgzb1VHL0ZNSVZwaTl4NWZheXNjQ3VQZWVHSHY4TERzeW9a?=
 =?utf-8?B?OFBVYXhmSGZkQ2tjTGptby9YTlpSWkczdENXcDBtaWlOSElQMTd1MU1ya2Ra?=
 =?utf-8?B?YzRSSDRDRmFKNDhETjFDVzRKaTV4VHVYK1hiWGdNVHZjSi9zdmU0bkVYSitY?=
 =?utf-8?B?UW9mSklQN2w0ZnJSL2pOSzBHN1VWcjRJaEtRUzBGclpyYlhYS0NPZ0ZJdk9D?=
 =?utf-8?B?Yit0SjdiQU1FSjhaQ3B4WjFyOFBsMktyZm1mRnZkZXVOanBnVFdKeGdCTmlv?=
 =?utf-8?B?TnZvRFhLcndSd2xEL3VmU1hUNHJpbVdOaDV2NlBlczlLNFRLNXdkZE9mQkFE?=
 =?utf-8?B?N2tKM0JQVzM5blRqQVhRZ3VkU1JSYUVXcUtzbE95Yjd3WkZZRjB4MkdpTlAz?=
 =?utf-8?B?eVA0MFNVRnFDbzNQYk5vL3NKbm84QWxBdVNUZnh4b3MrWWFNTUt0aFJ5cVB5?=
 =?utf-8?B?aGxiOEN2L0N3MW9KYmV0bFhtTnQraWtzdHkyZ1Nrcys1bWMzVEdVeStyanhK?=
 =?utf-8?B?OXh2UDdVRUpvOWE4MTQ0QkZMZ2dLMFo3M2NTQ054VnVaYWNGS1ExRythUnU0?=
 =?utf-8?B?YWlhODloZ3N5ZXhmOFhleFcyei82NTlxSmlNcnNlLzA1WWJtYlFOMkZMMXph?=
 =?utf-8?B?OXpzMEd1UnpKOHNRWUNrYi9RRlptaDBOWTRleFhEVU1TRERwU25vdnBmL1VM?=
 =?utf-8?B?Q0g4cDFpRS9GVzR2R0RGMmxIbU1JOE42b25WTllYRHVKQ1B1c2lNU1dDeUtm?=
 =?utf-8?B?Yi9hMXFPOVNuT3VESXpJMGNRNW91U2ZlTXZIeTN0OVc3WnpkSmNmUXEvemZq?=
 =?utf-8?B?d1lRK3JCOGFvV0FlN0ZVbXRUVTdkSUtTMXNnQkp5WGNxaFV6ZnZPcHBrV1li?=
 =?utf-8?B?Tm4rTmtzZjgxQnFqTjlGbFpMdEZOSXdIeDVDb1lQNjdsbzl5WHhNdlgwNjYx?=
 =?utf-8?B?ZDdjWXFSdkRkbktsV29uckQzcFBLb3I3VTdxZXU1T0daTDR4ZGtSVlI3ek1R?=
 =?utf-8?B?UzVWSFlOZkUxTDlYSVRpUHFTNnNYOEdFNTJ6VnM4dDRkaDB3SXFseldXb3ZD?=
 =?utf-8?B?elI1NW9TdzhxUmZ4eWNiRnNCR2RXU29hZWF0Qm03WFM0Q0tHRGQrdWs1UHgz?=
 =?utf-8?B?Rkt1YlBSa0YxRXo2YmpvaVVLMmdIaUxkdU5ZNlNyamFsYkF0cGNQdlk3ellt?=
 =?utf-8?B?M1J3UkJtaVQ0S0k2S2VocnN2Nkp6Ri90bWdmWW5EbHRRbGZHZE82NVRjbVZo?=
 =?utf-8?B?YXhTSWpxOWJndFNhSHAzU1Z6a0NJdnoyWUpYWU5WWHFNOXFYdEhDQ250ZnAy?=
 =?utf-8?B?T3VKTzJSVzk4T0pYSlI1RjRRVldiejN6Z0RxTkhkUkp3MTY4YVRxem53SE1x?=
 =?utf-8?B?WkROaTVTQ2dqbm9vTUkvV1pFeG1zQUZwSzY4cndaOHFXV21rZ0ZZOWRRSUxp?=
 =?utf-8?B?QXRzWXUyTzQyUkxiU0R6S3l5TTRPejdYT2plSlhNVkRWd05JT2JIVGJvbDgv?=
 =?utf-8?B?VnhQa2xYY2YrZytFRndpaGpRYVZhdTVseEVwRzhOV2ljcUpkOS9WTUxBMGJ6?=
 =?utf-8?B?NkpjbGpBN0pTRUZOUWNNcWplN2ZtTk5wN2syeGZzUGNuSFVVRm15YlcyY2V5?=
 =?utf-8?B?MVovdDF5WUM3eUl3cmFNMnYvb1N0UG5HQ1NEYk1KVGk0ZVJZamxzMVlQRmpk?=
 =?utf-8?B?UUdsVFNPUHNYSXZVZHlwcWxqd1B0dmdGRmc2L2hZbFNCMnhsWHZCSHNYTWM2?=
 =?utf-8?B?V0x4RCs1eHZWN3BMNkVnb2llS0Z2RUxIaVBHOW5RdmJWWlVmams0QmUybFJL?=
 =?utf-8?B?SmREc0N4SlQxUmFBSEtUdUdZbmJ4VGVKY2VqNzh0MGNwWG9OUXJQclk2MVlk?=
 =?utf-8?B?NnhRVy9nc1ZFUXlqOTVQQVJzcHZVR3NJRGNOb1lXTzlsSnJKSS9UcEF3TVRW?=
 =?utf-8?B?OFNRSUwxK3E3M2ttYnZOc1M3clVBRC9UK01kaC9hZ1dENEFpeHBWNm5vZjFv?=
 =?utf-8?B?cnRkZTdzRWJyckwyM1p5blhwaUNzMW83Y1oxcmM5YlpHNW54VFEwZTBqa3Qv?=
 =?utf-8?B?QzNCdDJuMHVKWElmY05ka1J6SmVEenN5RWdLY0VjSSthMVJWamNORkFVMXE1?=
 =?utf-8?Q?yqLYjulVZkvxetmmXFen2Y+0R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711bbc96-32b8-4d0f-acde-08dcfeceb546
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:51:33.7147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJvNOn1N4jwgcgqQ6KR/KAMSqKStZLByqyX3lLLe55v3o4v2H4ZFK3QsQYO5X/qVydUVaMEwwj/iCKLTw833kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p577+9
77+9c2tpIDxrd2lsY3p5bnNraUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI05bm0MTHmnIg25pel
IDIzOjA3DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzog
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgRnJhbmsgTGkN
Cj4gPGZyYW5rLmxpQG54cC5jb20+OyBtYW5pQGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogZHdjOiBGaXggcmVz
dW1lIGZhaWx1cmUgaWYgbm8gRVAgaXMgY29ubmVjdGVkIGF0DQo+IHNvbWUgcGxhdGZvcm1zDQo+
DQo+IEhlbGxvLA0KPg0KPiA+ID4gQXBwbGllZCB0byBjb250cm9sbGVyL2R3YywgdGhhbmsgeW91
IQ0KPiA+ID4NCj4gPiA+IFswMS8wMV0gUENJOiBkd2M6IEZpeCByZXN1bWUgZmFpbHVyZSBpZiBu
byBFUCBpcyBjb25uZWN0ZWQgYXQgc29tZQ0KPiA+ID4gcGxhdGZvcm1zDQo+ID4NCj4gPiBIaSBL
cnp5c3p0b2Y6DQo+ID4gVGhhbmtzIGZvciB5b3VyIHBpY2sgdXAuDQo+ID4gSSBjb21iaW5lIHRo
aXMgZHdjIGJ1ZyBmaXggd2l0aCB0aGUgb3RoZXIgb25lLg0KPiA+IENhbiB5b3UgaGVscCB0byBy
ZXBsYWNlIHRoaXMgY29tbWl0IGJ5IHRoZSBmb2xsb3dpbmcgc2VyaWVzPw0KPiA+IGh0dHBzOi8v
bGttbC8NCj4gPiAub3JnJTJGbGttbCUyRjIwMjQlMkYxMCUyRjEwJTJGMjQwJmRhdGE9MDUlN0Mw
MiU3Q2hvbmd4aW5nLnpoDQo+IHUlNDBueHAuYw0KPiA+DQo+IG9tJTdDMTcyZmE2NDg0MWEyNDQ2
MDU2YjAwOGRjZmU3NGI1MzIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5DQo+IDljNWMzMDE2DQo+
ID4NCj4gMzUlN0MwJTdDMCU3QzYzODY2NTAyNDQxMjA1NjY2OSU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleQ0KPiBKRmJYQjBlVTFoY0cNCj4gPg0KPiBraU9uUnlkV1VzSWxZaU9pSXdMakF1TURB
d01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJag0KPiBveQ0KPiA+DQo+
IGZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1yR2VLJTJGNzBvMVBJQk1GJTJGdHprUUdzc0FM
a2xHDQo+IEN6OFlEdEs4ZWZxDQo+ID4gUjJFSWMlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBTdXJlIHRo
aW5nLiBTbywgdGhlIGZvbGxvd2luZzoNCj4NCj4gICAtDQo+IGh0dHBzOi8vbG9yZS5rZS8NCj4g
cm5lbC5vcmclMkZsaW51eC1wY2klMkYxNzIxNjI4OTEzLTE0NDktMS1naXQtc2VuZC1lbWFpbC1o
b25neGluZy56aHUlNA0KPiAwbnhwLmNvbSZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBu
eHAuY29tJTdDMTcyZmE2NDg0MWEyNA0KPiA0NjA1NmIwMDhkY2ZlNzRiNTMyJTdDNjg2ZWExZDNi
YzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2Mzg2NjUwMjQ0MTIwOTU0MTkl
N0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoYw0KPiBHa2lPblJ5ZFdVc0lsWWlP
aUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVDQo+IElq
b3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9UUxPN3RsMHpDWUFqa2VqdWglMkZqNjM1ckFF
dnlpeA0KPiB4OEJNa3d1RzZ3ZVc0WSUzRCZyZXNlcnZlZD0wDQo+DQo+IGhhcyBiZWVuIHJlcGxh
Y2VkIHdpdGggdGhlIGZvbGxvd2luZzoNCj4NCj4gICAtDQo+IGh0dHBzOi8vbG9yZS5rZS8NCj4g
cm5lbC5vcmclMkZsaW51eC1wY2klMkYxNzI4NTM5MjY5LTE4NjEtMS1naXQtc2VuZC1lbWFpbC1o
b25neGluZy56aHUlNA0KPiAwbnhwLmNvbSZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBu
eHAuY29tJTdDMTcyZmE2NDg0MWEyNA0KPiA0NjA1NmIwMDhkY2ZlNzRiNTMyJTdDNjg2ZWExZDNi
YzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2Mzg2NjUwMjQ0MTIxMTMwMjMl
N0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoYw0KPiBHa2lPblJ5ZFdVc0lsWWlP
aUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVDQo+IElq
b3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Z3JnbXh5N1VaWm9DNGVQVUV6V1lVeXJaajdH
aA0KPiBFZFB3aEpXZHE1VGpyZzQlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBJIHRvb2sgdGhlIGVudGly
ZSBzZXJpZXMgKGNvbnNpc3RzIG9mIHR3byBwYXRjaGVzKS4gIEJ1dCBsZXQgbWUga25vdyBpZiB5
b3UNCj4gd2FudCBtZSB0byBkcm9wIHRoZSBmb2xsb3dpbmcsIHdoaWNoIGlzIHRoZSBzZWNvbmQg
cGF0Y2g6DQo+DQo+ICAgUENJOiBkd2M6IEFsd2F5cyBzdG9wIGxpbmsgaW4gdGhlIGR3X3BjaWVf
c3VzcGVuZF9ub2lycSgpDQo+DQo+IGh0dHBzOi8vZ2l0Lmtlci8NCj4gbmVsLm9yZyUyRnBjaSUy
RnBjaSUyRmMlMkZmNDBkNTlmMzA5ZGImZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcuemgNCj4gdSU0
MG54cC5jb20lN0MxNzJmYTY0ODQxYTI0NDYwNTZiMDA4ZGNmZTc0YjUzMiU3QzY4NmVhMWQzYmMy
YjQNCj4gYzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4NjY1MDI0NDEyMTI5MTMwJTdD
VW5rbm93biUNCj4gN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJ
d0xqQXVNREF3TUNJc0lsQWlPDQo+IGlKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95
ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWoNCj4gYU1lN1hkRFRETW4lMkJwR2c1NFMlMkJP
cXJ1TCUyRk40eCUyQlZMQWdRYVlzQ3VVcmclM0QmcmVzZQ0KPiBydmVkPTANCj4NCj4gQWxzbywg
aGF2ZSBhIGxvb2sgYXQgdGhlIGNoYW5nZXMgdG8gc2VlIGlmIGV2ZXJ5dGhpbmcgbG9va3MgY29y
cmVjdC4NCkV2ZXJ5dGhpbmcgaXMgZmluZS4NClRoYW5rcyBhIGxvdCBmb3IgeW91ciBraW5kbHkg
aGVscCB0byBwaWNrIHVwIHRoZSBlbnRpcmUgc2VyaWVzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQoNCj4NCj4gVGhhbmsgeW91IQ0KPg0KPiAgICAgICBLcnp5c3p0b2YNCg==

