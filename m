Return-Path: <linux-pci+bounces-31745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63201AFDE43
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A8486551
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79DE1F866A;
	Wed,  9 Jul 2025 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q0PS2as7"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D71F9F47;
	Wed,  9 Jul 2025 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032266; cv=fail; b=fW1F6CFz+KQOZfuqazF+8mGeOh1uURP20PbxT6S1WQNwtiFyrMVfLautyoHXdqCPt2Vg15uHWheeYO5OheL9bUZ+oucXCvr1uo3uu9BECZjwBBYiWGnWMTLryQ0jspRahBgH8m1kzsrEpf/j+e8t1jnS+xNcgpqb9IoZlXdJ/h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032266; c=relaxed/simple;
	bh=OSnBlkOHe6rFSdRAa7+CYn9OqKp9PLiUJsSk0Q6SPW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epyc5HIEj4O2KwDFid/HpTdTcEy6SG64pMIX86zE0Wkhi3OlYJPcXGdSfzlHoseqkxwtv0mqp78pDrt7SQzLDiPmVVU6QahWNwU6owHJ2sXXv+qtq6Qg9M9jHfFxUxEB81VkS/tLluuqvqwqAtOnrbuXbQ9fGPed/Ukvgo43Nf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q0PS2as7; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNkWQIZ+pd25zKo8QtkmgjkWsfY+eIRsUaNehPEGlTvcmiEN0DtkwUjwQcDSEBpi/c6J4AVRLhxI/g+L62NKwpzyx6cOjhPVBIKka9XtuDkEbl4ZPIRM550SM4vkT0a5FXqmQ//Ed3Zvdr80/YmQ8zCC4Fxr4/yfJnHwhtE0MJ7a4GJCEO4napuFBMhYzYTcPbtVMzzomPeFWyhecmWwy1fX0MBY9UiNiGQzI2GR0/oeBQ40yRD9Y5X8Doy+8P2mFVORAj3IKn1QDi+ak15HpvYZz1Owo3X2IBFsdcM2BsgO1+L7udypgCpdTyZ2WvMmSotNHvK641y5+aqVEkp1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSnBlkOHe6rFSdRAa7+CYn9OqKp9PLiUJsSk0Q6SPW8=;
 b=JPXO8SaBrkljbF5lpR1l77JXbwgMUkbsOuisN4PJavUT5iQABeF545aDt3JoovoQduNth4IFopHxVniT5Nzqn1gV8TfA1fxoVxPEMKxbq4avuv7RAGw+JnH4iqzNylO6aB7n5eSFl3PD9dXZZOvZiPmmM4it9QRaU9jfS2lebdXn9SsgveYy4UHzdWxlqhE3kIe+QDftOcGtjfhDSwpPnjvJgvfQyUXG/gO700WFLQMZsq9R4gDQ0bWbQ1ismzzqOFsyRmR2Se4Ve7mzYjNtCXoKm9JrrFG4sawJNsmhX3Q4JlfBpIqEa/iaxMyXpfzKy6WD7J+5AAXJrLgxxSAB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSnBlkOHe6rFSdRAa7+CYn9OqKp9PLiUJsSk0Q6SPW8=;
 b=Q0PS2as7pJL8416KsurOYJrn7UJnefuUUBvmU09VQGOcnfQuD7PCVUWG3TAPzR+puJJ/Vlw3NnU+yylHkh/DI25VXoUj6pxt0vFLYI77CDiyaeD+GHreK9lYxhGyvGE/uQ/fRvX71sJxHUQPDA2v5xD9IsVmTqbZyDfA6DcfXze5/AB5JsR98cei2/5pz590C7D1WMG9r9zig061hq/4RoF8voJQxPJTttJ+UQQUhNjFW0UP30cAFHFJSPn8E9TedJN4t88dVXnMBRM95BniLYD2Tny2mjcho5wPNCEDpeCWHhjKHfoiUOB5Q2HoJMVlFUuBIuiiPrWeQ0OVyNsfBQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 03:37:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 03:37:40 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "mani@kernel.org" <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Thread-Topic: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Thread-Index: AQHb31qUj+ZrPd0xZ0Op7blHS6urXbQnLYmAgADFKtCAAI4AAIAAw4xg
Date: Wed, 9 Jul 2025 03:37:40 +0000
Message-ID:
 <AS8PR04MB86767AD0F69F5046CCB8658C8C49A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8676B8D14A5C54E8C32025BD8C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20250708154810.GA2146917@bhelgaas>
In-Reply-To: <20250708154810.GA2146917@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS1PR04MB9358:EE_
x-ms-office365-filtering-correlation-id: 3fda4b7f-5ef3-4d76-13b4-08ddbe99f50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UW56T2t3QWw3clZtdGV0WW9Eam4vYVNmSmJUYjA2aDhqVEpvL28yV1RJV0lz?=
 =?gb2312?B?ejBHdExUaXRzNzJXeTluZnJwNjZ1TG01cWVvaGNiK1FPcSt6UnIzR0xqMUpE?=
 =?gb2312?B?WjNkcEVsOWJtVUEvc1FaWjhtOGtYOFM2Y2Fwd2lpelhTOUNOK3pPUXlQNm95?=
 =?gb2312?B?enptdlh0ZmQ3d05veGw1UGY4TFhCb0swUit0SmNKZC9GczN3T0tEWGJJKzI1?=
 =?gb2312?B?Q1oxWWVkQU9KdXV4RTNlRkFSZ3VuV0xGUGdyUGNRSmhldEpidWhiSnpxbDNR?=
 =?gb2312?B?U05ZcHI3YzdJaUdndzZmb25wbkhGU0ZITk5xVWFnVFMyV0ErdDBicmZiVFYv?=
 =?gb2312?B?YklzNFhYNytDV2xkM0g0dnRXRmpaNnRFUEJGQ1FMQVZsdU0vTlQxZCtYZ1pk?=
 =?gb2312?B?dngxbUlmeDc1U2JNc3RDTnNnZzU3SUcwUHV0bWc5MmRMOHZLalJRNWxHV3NF?=
 =?gb2312?B?RGViMEVhOWlRajBYVVJJMEprR0xXeWg4dStoVVJES1V3c1dhV05lOGEvQ01W?=
 =?gb2312?B?UXlaczZ3WXhrSjJkdFlvVGZnRG1ldmVCMkZIb09CcmlmVkRjT1c0Y0trQ3I4?=
 =?gb2312?B?RGxvWFZPYUp3WFRWbEdpNFVJV0NBT05NYzdEbmtwaFRVQ2UzMEJJMWZ2ZzhE?=
 =?gb2312?B?Z05SQWxvbHhUd2dwYUF6NURaaFV3ODJCRjE0OTJjRU15ZW40MFhjdEExcm9t?=
 =?gb2312?B?ZWhCNlc3OFF1cEVLeVNDVTA3VUlRMG54bXF1QUZxTStkZkFPTDRXQ3RmM09Q?=
 =?gb2312?B?VC80MmtRa3UxRllxcHBWSUxZc0JPcFp2U29IdGdFb2RvM013T1NhZkdIODFa?=
 =?gb2312?B?cmg0MHdVUUNPbTBsajlzK25DRDhGRSt4bXB0WWJtbElpQ3NSbmhMZnJOaDdS?=
 =?gb2312?B?bTdzWk83MVdZaWFxWDZvdHNvR0orSDI5WUp0akNvWjdlT3N5Tkc5eHYxN3FR?=
 =?gb2312?B?bng4U3NUQk03c3M2amQvMkdSaGNMU2U2OEo5ME84enU2bXdiWXUxeWJkdGpx?=
 =?gb2312?B?YnR3Wjk1MFhxWlVDL3QxZDU3Mk05QnVtdmdsT084MHprRHNKRGJEWmErbVZu?=
 =?gb2312?B?Q08rV2V2dHJ2eVZDVk5Cc3hDcWdTVjFscWlqMjdmNlRGaE9PNno0TUg1QnVK?=
 =?gb2312?B?R2grS3EvRjF5S2EveS9MVGk3REgyTWg2Y2NmWFhLb2NKMXA4WDBJZ21SYTVF?=
 =?gb2312?B?RGhQbytBb1J4aEwxN2MwelVYRkdRYk54UnVleGRqRTRlcGwyMGhGVmJZZ0ZO?=
 =?gb2312?B?UEpTV2t5WXJHbE54LzZFV1R6d21iSjFpbVR4cmhWZnF6QWZ2ZExuWjVHQXlQ?=
 =?gb2312?B?UFBOREl4L1R6YXJLQS94Q2dEWWtXRXl0V1lyYU9STnc0ZFNvWjlwRW0vRkw2?=
 =?gb2312?B?N2pidzd4K2FRemtlMkZYTzZ4WmIrM3ZLT3JvbDRkNjBUTnhaeDFadVJ4QWpu?=
 =?gb2312?B?MktFTkMwaUxUakt2djBSMXU0SzBMKzNOd1EvUE16L3FYTkhxK3o5QkUvRE9r?=
 =?gb2312?B?cmNRbVpqSSswaURlb25LS2hFZzVIUTdBTjdVUWdWcVdyTWZDOS9oKytob25q?=
 =?gb2312?B?SllvSmxvajU5QWpXVzk3bVhiWDdyalhndlFiaE04SjViaEszcThyNlFCK1RL?=
 =?gb2312?B?WjhWNllmVE9ZN2RWamlqN0Q5OTdCZVR0QWtaU1FWbGtXWGlBYWRMQXRrR0Q2?=
 =?gb2312?B?QjYzcG94UHZEZ3ZhR1NSSUpxMyt1SG1OZTgxUTM5L0dITFUwSHoxbk53Kzg2?=
 =?gb2312?B?enVKcjZ0U1NvT0ZVK3hZQWFmR3JXYm5mVjd3aWFQNWUrNWtsTExUSElkd3Vs?=
 =?gb2312?B?VGVqNFlvSlNQd0RjUmNHbWRCNGRlYWZkc3lGTE5EYU4wOFBVV1RFNHZ4cmRh?=
 =?gb2312?B?NFllc3VIeE1TNTNMZHJiMWg2VUVwSjNvRnc2RFZKMWphVENkWU9GS2xYZUc3?=
 =?gb2312?B?dW1oRzM4QTVPWDdMeGtwR2N4ZDlNZGhjeXFuRlJJbXIwSlhsUGpTY3VqOUYr?=
 =?gb2312?B?N2xsRkR4alN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UWQ0WDdCMGJKb1E0ckZTVVEyUjJidkVMZkEzU3dTWU93ckdPTmtWY3F1Mmlo?=
 =?gb2312?B?TXh5cUN0OXVNVy8rK0tqTTR6Vk9UZVVUQXhCTXA0Z1hNVXRpUzBycFU0amx3?=
 =?gb2312?B?c1NMdkFZaGNHVVVjdkdndnNqWktsaFhjRnlyRDZKa3hqRGk4dlJ6Q0pQQnUv?=
 =?gb2312?B?R2lsRlNIS3NocUppUDhjem1NT3ZHaTlqVllyQWZGYkQwZnZpVlRpeW9JNFV6?=
 =?gb2312?B?MmNxdVBTL3FTNGlUaEViVTJYKysxNCtGY0FIdXFRSm85ZGlFeVk2MUxNMFRS?=
 =?gb2312?B?VkQ0YUZVSGprMVZDUklTNVhjYlJoMXdlbVNFb0ZOUWF3MjIvZzVUWmpSZmtJ?=
 =?gb2312?B?SWNLUHdGYlJiWjZ5QytyM25DUmZ1YVAyRDNHVDJyaGNWakpJc2dUQkpuZmF3?=
 =?gb2312?B?Ui9rZmVTTTU1TVVTSTZlSnJMWXA1S2kvemxyM2x4Sm9tU0h2a2dDY2VFc0hl?=
 =?gb2312?B?VWFlTjdqQXJ6U00wM2thd0JobWIreVRvVnpvOTZaNFRiK3FLcWVRdlNIMWJ6?=
 =?gb2312?B?SUVFRHpxWlpsbzBkY2huWC81UjNDSngrYStUSkxMTDRSUTlIdW9NUGpFbjJN?=
 =?gb2312?B?eWcwNHpQQ05kMWQ4RUs0V3ZYWTBUSm1GSGJwYWlZOFVRM1FrOWtaTDgyZ0wz?=
 =?gb2312?B?alhSejdxWVVybHVlWm9aR3BtRFFVYmRqdlNJQ1VMRXZ4UkxTbitXOEovQVpY?=
 =?gb2312?B?L2RHR0hXamQxUlQ0WCtuVVpkbjRpVGpmWmNmYWlNVVc5WWRUY2wraEJHS2hp?=
 =?gb2312?B?bTFCMS9BTE1qT1pwYkNpeHlpUFY3M1FHaWlTNTNwMmVBVllQa09lR1YyT2hl?=
 =?gb2312?B?c0hRR0NYbTVNMWkzV0h1cFVzV0t0a3dndEdPZ2FPTjRvOHd0dkVTd0lHZmcy?=
 =?gb2312?B?NDJIdjc1c0RkSUVleDIzbFNPL0FoSXV2dlJtTDNMdFB0MWFManNITXd2Mmtu?=
 =?gb2312?B?NGRJczJQYWxLWVBCNXRMVGhBMEU1TkY5MktLa1pmMkxDR0Y3UXcwQTBxa2Rr?=
 =?gb2312?B?WW5EZEgrZVpOYWZjNjRGZEFxeTF1NzR4N1UyL2tNUUxUSVowTkpZVE1vQUdy?=
 =?gb2312?B?UUpiOUYweVRCa0J0TDRWUGhQNFJLUEZ1MGhWaWNraHlTNExOV2RPMlZNRlov?=
 =?gb2312?B?VlhSUjg2SVNiTk1mMmFVcGZIVzF5TzNTWktxQzgreEt1MnhNekpZZjRPSWd3?=
 =?gb2312?B?WFpvYkFnV0VROGFBNW9GR0c2bjk0dEhzSitOZjhGaVM0K3A5NjF2bnoveE1N?=
 =?gb2312?B?bWx3R3hUNzIxaWduNkpyRHNHaWFoMTdnekx5YVgrTzA0VkoyTnM5YkpRQUlU?=
 =?gb2312?B?RzZJQnhtbjRjcTBDcy9FZGZEUFN2ODJHaTFTeHZxSUVEY3F4Y2JGUWVaZHRa?=
 =?gb2312?B?RHlPSUtSYmhmM3l6QUMzVElZU0JaVU9BNVhJVEprNkhGdnJqcUJabXRxTVB2?=
 =?gb2312?B?MjlXcG1WeTY2MHpxSkg2dzNiSEIyNVUvSUtyVGNFK29NYk5RT1lvMGp1am54?=
 =?gb2312?B?V3JCWG5NVjdiSFdjdFZ3Y0xRU3ZrVWZjcFUyZGtLNFg5WVFITDhhcTVmMkVE?=
 =?gb2312?B?QlMrTjlyZVpQSHI1OEh3Qm4wVjhkb3FIU0VVM2ZhN2Fla1o1a1ovd01SWTlR?=
 =?gb2312?B?WVFoaWdBUzcrL3U5SGFacUQySnJPOTZZWXN2Y01qMWNsRTNKWjI3L09jTjZx?=
 =?gb2312?B?M2YrVlp0bFBpOUZYOVhDdmhuelJSVFM3SU1vbGZkTXJyK2E1cTR6QytLT3JX?=
 =?gb2312?B?b1VXclVCNmoyVFVKTHlxWXhFRE1WYk5seEZMYnNvVTBXVWhlT1M0MFBLTzJD?=
 =?gb2312?B?cGhjMXgzUUxvcWdOQlJic3VHUnkxL1BMaDZucmVBcG9RYXB1VXQ4QVFnU2NC?=
 =?gb2312?B?czMwcDFWUktuQ1dkWE4xbG1xRG94Y2krUWVWVFZjdWRuTjl3T1Z6RzhyUDdF?=
 =?gb2312?B?Z2VtZkUzTzhidEJpYXM4RWx0N1NWRmwycUU4VCt2a2U4RWZtSEJndUhKTmds?=
 =?gb2312?B?Qy9iTGovblQwK2NSTVRCN25Iek1LNnlCVEpyR3NGMnZGWTE5NzR2ZDFYcVNW?=
 =?gb2312?B?WWE4RXMvVEhRUjVqdnFDUmgvbnhadDB4VWZKK3NnN1BSeUlIa2c3RUFycWVK?=
 =?gb2312?Q?hhFclI6HHtBGyW515woaRb2g5?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fda4b7f-5ef3-4d76-13b4-08ddbe99f50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 03:37:40.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HM4ZxCDZnrLjJ/cqvICM7gngl0WfV/DNRjTRlzFXRkg1pfp7MdCFSdXKKyTv2ODh9eTZa+yG68tCyef44VLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jfUwjjI1SAyMzo0OA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IG1hbmlAa2VybmVsLm9yZzsgRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGll
cmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9y
ZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGlteDY6IENvcnJlY3Qg
dGhlIGVwY19mZWF0dXJlcyBvZiBpLk1YOE0gY2hpcHMNCj4gDQo+IE9uIFR1ZSwgSnVsIDA4LCAy
MDI1IGF0IDA3OjM0OjU3QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+DQo+ID4gLi4uDQo+ID4gPiBPbiBUdWUsIEp1biAxNywgMjAyNSBhdCAwMzoz
NDo0MVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gaS5NWDhNUSBQQ0llcyBo
YXZlIHRocmVlIDY0LWJpdCBCQVIwLzIvNCBjYXBhYmxlIGFuZCBwcm9ncmFtbWFibGUNCj4gPiA+
ID4gQkFScy4gIEJ1dCBpLk1YOE1NIGFuZCBpLk1YOE1QIFBDSWVzIG9ubHkgaGF2ZQ0KPiA+ID4g
PiBCQVIwL0JBUjIgNjRiaXQgcHJvZ3JhbW1hYmxlIEJBUnMsIGFuZCBvbmUgMjU2IGJ5dGVzIHNp
emUgZml4ZWQNCj4gPiA+ID4gQkFSNC4NCj4gPiA+ID4NCj4gPiA+ID4gQ29ycmVjdCB0aGUgZXBj
X2ZlYXR1cmVzIGZvciBpLk1YOE1NIGFuZCBpLk1YOE1QIFBDSWVzIGhlcmUuDQo+ID4gPiA+IGku
TVg4TVEgaXMgdGhlIHNhbWUgYXMgaS5NWDhRWFAsIHNvIHNldCBpLk1YOE1RJ3MgZXBjX2ZlYXR1
cmVzIHRvDQo+ID4gPiA+IGlteDhxX3BjaWVfZXBjX2ZlYXR1cmVzLg0KPiA+ID4gPg0KPiA+ID4g
PiBGaXhlczogNzVjMmYyNmRhMDNmICgiUENJOiBpbXg2OiBBZGQgaS5NWCBQQ0llIEVQIG1vZGUg
c3VwcG9ydCIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAu
Y29tPg0KPiA+ID4NCj4gPiA+ICJDb3JyZWN0IHRoZSBlcGNfZmVhdHVyZXMiIGRvZXNuJ3QgaW5j
bHVkZSBhbnkgc3BlY2lmaWMgaW5mb3JtYXRpb24sDQo+ID4gPiBhbmQgaXQncyBoYXJkIHRvIGV4
dHJhY3QgdGhlIGNoYW5nZXMgZm9yIGEgZGV2aWNlIGZyb20gdGhlIGNvbW1pdA0KPiA+ID4gbG9n
Lg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgcmVhbGx5IHR3byBmaXhlcyB0aGF0IHNob3VsZCBiZSBz
ZXBhcmF0ZWQgc28gdGhlIGNvbW1pdCBsb2dzDQo+ID4gPiBjYW4gYmUgc3BlY2lmaWM6DQo+ID4N
Cj4gPiBZZXMsIGl0J3MgcmlnaHQuDQo+ID4gU2luY2UgaXQncyBqdXN0IG9uZSBsaW5lIGNoYW5n
ZSBmb3IgaS5NWDhNUS4gU28sIEkgY29tYmluZSB0aGUgY2hhbmdlcw0KPiA+IGludG8gdGhpcyBj
b21taXQgZm9yIGkuTVg4TSBjaGlwcy4NCj4gDQo+IEkgd2FudCB0byBzcGxpdCB0aGVtIHRvIG1h
a2UgaXQgZWFzeSBmb3IgdXNlcnMgdG8gdW5kZXJzdGFuZCB3aGljaCBjaGFuZ2VzIGFyZQ0KPiBy
ZWxldmFudCB0byB0aGVtLiAgRS5nLiwgSSBoYXZlIGFuIGkuTVg4TVEgc3lzdGVtOyBkbyBJIG5l
ZWQgdGhpcyBjaGFuZ2UgYW5kDQo+IHdoYXQgZG9lcyBpdCBtZWFuIGZvciBtZT8gIElzIGl0IGdv
aW5nIHRvIGZpeCBhIHByb2JsZW0gSSd2ZSBiZWVuIHNlZWluZz8NClVuZGVyc3Rvb2QuIFRoYW5r
cyBmb3IgeW91ciBjb21tZW50cy4NCkR1ZSB0byB0aGUgYW1iaWd1b3VzIGluZm9ybWF0aW9uLCB0
aGUgcHJldmlvdXMgZXBjX2ZlYXR1cmUgd2FzIHdyb25nbHkNCiBkZWZpbmVkLg0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiA+ID4gICAtIEZvciBJTVg4TVFfRVAsIHVzZSBpbXg4
cV9wY2llX2VwY19mZWF0dXJlcyAoNjQtYml0IEJBUnMgMCwgMiwgNCkNCj4gPiA+ICAgICBpbnN0
ZWFkIG9mIGlteDhtX3BjaWVfZXBjX2ZlYXR1cmVzICg2NC1iaXQgQkFScyAwLCAyKS4NCj4gPiA+
DQo+ID4gPiAgIC0gRm9yIElNWDhNTV9FUCBhbmQgSU1YOE1QX0VQLCBhZGQgZml4ZWQgMjU2LWJ5
dGUgQkFSIDQgaW4NCj4gPiA+ICAgICBpbXg4bV9wY2llX2VwY19mZWF0dXJlcy4NCg==

