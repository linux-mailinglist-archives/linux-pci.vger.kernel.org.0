Return-Path: <linux-pci+bounces-14120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA142997A7E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E18282473
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124C4207F;
	Thu, 10 Oct 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZF5EnfV5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013008.outbound.protection.outlook.com [52.101.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55327224CF;
	Thu, 10 Oct 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526651; cv=fail; b=jYFQBkEvLEt0he8ZwgLqESI2WNRQi7k+4X+xeXtRA5dC9wmHiMnUcIzlMfJ59ncTmACR5hpOWf+As4dMym7oNn0mCgNsOkuxw9R6ybKYQH/n5+yVq3/NW2CITC6ANgaUBVwVtLEXZd0sBqqxWSRvatG84LXWexoBEus4rIz38ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526651; c=relaxed/simple;
	bh=RAlyyFPQktoAHEk5BBX8hFKk/aqwVnlOwT8JjvlAPzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMdzTSxqDht813t0XH02p5KQYBrDfG6Nhv5GHzxw/8rYR2Z1jwlwgKN595sxiFtLf4syljF5cOZ8bdBXk3ew32FIVEmymboOUib8gt6suIGrTwzpLxVUd2IqeNb+SlrqEPaIAnke+oETCT5N/tFHlrzFEmYg8ukIa7YA9qt6jbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZF5EnfV5; arc=fail smtp.client-ip=52.101.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0/zeAsdN96udZSenX6xlUmJd0IbixfscIwNleHLWrA7/lIRWnL3z1eiXQlvKxYwWfiGE1/kMnwnI4IlSmfnA+Au61eBHt9bLGVTRxu6a+nn+xZ1T0B8pxprK2g4n7YmRD57fuxtwbyMPSMyXGsuQOoverhkSkW+oLtruVv6nv58kF8jQykRBlmiBMORKs09iaYKb2YDfT6z7ddtuEOBcWTfQZoE3+C+BMEiSX20Yuyzx1OSSFxiBYTfDGsmKC08tYFBwpmCGBhFvRSMMTh9M3hKDyMFM9rQG0194umVUSfGiNr+R+Ur3zJcuwThI9HuosoyrR4byx4TJRZ2AhbAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAlyyFPQktoAHEk5BBX8hFKk/aqwVnlOwT8JjvlAPzE=;
 b=e3++v59dNVgvsUyOqqe8YIfeJx6gyY13ygv+te1SgafstXz1H/YFGRCrZ1wyiVe4KBqmLBz+zMGZRfRZ0UOMFolROcXso9X5tndXwp6IaIpiNYB4sHY8hZa59EiJobBUo6h76Nu3bk/+YY+R9rhp4KpWTO4JEtzx6agmhL30cnE/Z/04WfGIknyclNftrIcienZYOMZ7gmC/HD8xzVXmJXelaXS6Hj/dgBdoma9/sc+wtgwVUhJH2NQrtW9kiVGjXKBE/u/wn+9c/Hm3MZWI76uZ49vUagOptKV3vcN1o8LFuGf+PDIvZVxrR7lyNEDQb8Mgsu6e9Kd4XxqactraZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAlyyFPQktoAHEk5BBX8hFKk/aqwVnlOwT8JjvlAPzE=;
 b=ZF5EnfV5B+Jcm4Y45itXrqCr8QfyadDjHp0IET0C9cMpkb01B4s1OnCfk14b94UGKk9RkKE8/aWgBxIUQEJI9RV9YaVxmC7uK+FphV7bZ85KxMwA6rPtpZDNfcPxTDsgHF61AU3fIu0BBshutB2raoiH+j0S3bEbu8eg77MEuXK2IIdgkvw0Jxb6oDZ7F/mzh7QbV2bX72wijXEd2CVfV/QSKOpn/8vbe8Yb7TSGw0/LD8Qug6oM+A2WYFTFxc9TVKwmad0wgkrGi+inv95jb9xENTRC6oFtkB1dafCQfb5MopP2GqhDSE6fpNFkl5dbFD/SRq6lIAue/Z52btWeyw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 02:17:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 02:17:25 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa7VciS0QZKXNjsEqaFNKRvx1ThLJ+3ToAgACxmvA=
Date: Thu, 10 Oct 2024 02:17:25 +0000
Message-ID:
 <AS8PR04MB8676516366FB6EE23F4823C68C782@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <ZwaagtTx1ar1CW4V@ryzen.lan>
In-Reply-To: <ZwaagtTx1ar1CW4V@ryzen.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8193:EE_
x-ms-office365-filtering-correlation-id: 40825d88-dc70-486c-2d72-08dce8d1aecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SUNEcC90dXJaUUljNjE5bnVXdC9iTWZjdFVnOG9tV2kzKzBuV0VnSGp1TWtF?=
 =?gb2312?B?b05FQVZiRXhzRGRCd2QzWXc4cmJ5bVpxditBbnlsMmU2aTRsTVBEU3pMV0pj?=
 =?gb2312?B?MmZ0MThYRUxNYXo1aE94NW92V3JJVDBGallVWU1jcHdKYjhkNUJZUEdndGVp?=
 =?gb2312?B?d0twY1ZPMmVkQS95VTVHTnRNd2EvYWJPVXNSR0pIYURhNjBuZVQrMVZSNmFD?=
 =?gb2312?B?eUI4UDFzemxmcERPRC9tdnVYMVRUdTRBdDNJazZHRUozTHhQUW03dnkyTnRo?=
 =?gb2312?B?bEdjNU85MXQyWmJLOHF5d0R6cTRud2xIekUrQXVBQTg0TVJqRzNsUUloN050?=
 =?gb2312?B?Z050SjJPVzc3NlRCNFhuejlNazRIRW54YTVjU1FWUnFIRm1ka2lFVG5mQm1t?=
 =?gb2312?B?ZGd1UWRKeExjam8wT25kYlBzL1hXdVB5Q3hselZtbEpDeXhydTE3R25KNXNS?=
 =?gb2312?B?RDE1eUtHbmQ2L3NEUU1yTlhsR3RVZGRxSWVUaTlUaXJlZDY4bXMvWkpCbHdh?=
 =?gb2312?B?U01xRm16R1BTaGQ5djl0anRUVHFITGV0Vkx3MGZyOGZFU29xYkxvZHJJdzE2?=
 =?gb2312?B?RnhzMDlSRmJpTHYvK2UydHJDdnZGS01lZmVROFRIOVNyaFRpUWdTMkFOY2s0?=
 =?gb2312?B?NGh1d2c5T0dPVkk2UXd1N3YyTndKQ2NFMkhFbUZsaDhyazJxSUlkWmYrNVFQ?=
 =?gb2312?B?VGFBK0JvMnhacFp3VTRPRzZXUzlRUUpLdFp4ejJxL2ZsTk1UNWl3Y0Q0RHBr?=
 =?gb2312?B?MFlIYnlLVHNCUmVES1RSV0lVU0NpdXB6Y1krdmx1RGlNWkVyU2wrdTl2SElH?=
 =?gb2312?B?QTZ1V1hybnQ0WWVvaEU0ckh0ZmNpYWlYUFAra0loSGtJZmNIKzkwbjBscjNq?=
 =?gb2312?B?YldmcXNucWVDOW9WNW9CSDhzZmlXRFhuNXNsWm1Bak1GRFB6TmYzQkZ2Njll?=
 =?gb2312?B?SHdkdDlUK1FZREUzZmRSTUJrL2lRLzBoL3ppTGJ4WFE2SGo1NFZFMitYQnhx?=
 =?gb2312?B?ekI4dWJ1Z1ZBeWxhOVFSR0pacllDZnFzQ1ZQNnZaNldzUnhTdG4xQTMwTU9R?=
 =?gb2312?B?OGRiM1Q2Zm5Sd1NtdXlUS3d6R0hmWVIyUVAyNEE3bjhhTkQ0OG5ma2sxRXp0?=
 =?gb2312?B?Qk5QdFZBU25kcXV3c3ppcVNML3ZyalV2ZFljNkE1VHZneGxlMVdLMmdIbTh4?=
 =?gb2312?B?SHczbS9rUXFBTUFGWHJYM1Fhb3d5U1VMYlFwZSt1RDBQWTlVRTN3NCtvSWVD?=
 =?gb2312?B?SDJ1SHQvUDJJaGI4Y1FYbzVRQm05d3YyMmpTWmw1VHJOZzRaT2FRTEtIOUlP?=
 =?gb2312?B?WHl4VHB6cUM1S3JsajRhTUc3SmppN1NSU3ovYVFjNUlsKzlXVHJCSlZYaVhQ?=
 =?gb2312?B?Q0FkZmdLSHlyK3FnYU1pTy94L1oxMjhRZXB2Mk82dG1YLzg3N1lUWHhsbUxw?=
 =?gb2312?B?YktNSkVnczJycXVlMlpCek9FNGZwYTZMK0VVYjlYeGJSR0xMdHBYWnVERllu?=
 =?gb2312?B?aFBuRkdJNkc4bFUrLzVabTlKQktURnI1MndzL0pmZmlHQjhQdnFZSHlraU1i?=
 =?gb2312?B?Y0FFRGk1aW5BZDN6eGhIVE81MnlpSVB1SWIweVZsK0NxNlpEcmdvaTR1TWlC?=
 =?gb2312?B?NXVrUFBHTCtHV1cvUTV4NEM0UDRBdTR4bXFQaG9WL1Q1N2U2b1dlTjVqay9w?=
 =?gb2312?B?NVhWb3JISDJHU2tseVdONytmSHE3KzhLTkJVWUNLR1pTa1ZGdmNTZkFsdlJq?=
 =?gb2312?B?UTRGb0IrR1V2L3JoUlZXMW0wSU5lM3R5REpTUDBhRzJndStTUi96U2R4NXVM?=
 =?gb2312?B?bHd3WDFDSkVRMGZValVlQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NlpDTVh0ckJnNUZNSWRPcFZNdks2cEhEL3hkcW00NWFYZllBQjFsNi9MOVZp?=
 =?gb2312?B?M3RyakxWbGxldGpJWU9YcnhQS2t5eXNRNUpSTmE3RUxZbVBsSHJNcHhkVkVP?=
 =?gb2312?B?K3BnY05lRzl3bHptdmJ2VGpUYmcvclRXdjlXWGFxZWhWbXQ3cVRaQVN1MHMv?=
 =?gb2312?B?UHo4V3o2WVlzYkQ2WDhVWk5mdzdjL2o3cHFPTzRxVk1xcG4xYU9YdVZOWDNo?=
 =?gb2312?B?UTZDb013SFUvOVJQVDhROFQxdVV2c29XWi9tMVJyNkk0NXkrSVVzaHNLMHAv?=
 =?gb2312?B?ckd3dWx1QzQyNktKKzkyVnJTRGRma1lnbVNMZ0pZZjVtMy9uMmNVeW84b0tq?=
 =?gb2312?B?NURrTVRyNkdZTGJFa3VQSzlkYWhsUmt6V3dRQ1N0VXNWdVhBR1hsY1dwd1la?=
 =?gb2312?B?SjZVR3JINENmTXNrK2Y3ZHNZd2czRjRreFJpZllRZ1Q3Ty9CQk90OXJhdDJK?=
 =?gb2312?B?WXZORHRJbTVBZWRvbGQ5aDFSaDJ2RWxqQkxBUDdJd28vTVBGNVZ4M21rK3ZQ?=
 =?gb2312?B?MmlYdVR4cUJDNmZTTnFRVlB5OGxSOEdOVmlJS1l5aUVqRnVUclZRU09VTlFp?=
 =?gb2312?B?N0hnMXQ3ZVkrUVpZWDkxdk9uMmdvVmVrVnF2YnR4bitXNjczL3hMY1hCbmh5?=
 =?gb2312?B?VzlrL1hXTDY3UVpqc0FtNGRZdGtUYlA1UEREOC9Ia0toUmZCSCtuSG95ZzhU?=
 =?gb2312?B?UnJGT0RIMFo1QVdJdXFjUHFLZk5OYXFTNENPVWdqTEtNU2MwSXk5SEV6dTEr?=
 =?gb2312?B?dHBVd1A3V1doY3ZIeitDSHU5SURvb2NFQWpqdUgzMW52QWtLQkRUU0dQaW1F?=
 =?gb2312?B?SzlNbUJjdlFPOWFvWkd1aWJ5emwzdVJEYmxsRWVkQko4c1F3Vk5VZzRpdWpn?=
 =?gb2312?B?K1FUYTVGb0dhSHozVVRzYmhCMnQ5ajJTb2tXZnZSZnlSeTlOME5qTSt1OXQy?=
 =?gb2312?B?L0ZBV09NZTJpSjNINWpsK0hNVW5WWEsyV2JBamo5UG1KdnZ1dmd2Ry8zUUJ3?=
 =?gb2312?B?emp5UG9QZXJZRDd1SldFd1lUL0JUdHFGenJWNDZIM3RZNlUrMU11Um8zS3d0?=
 =?gb2312?B?aFZJSjZKcER3dmNqb0QzWEZJSkVEN1R6cG5SandVaVEzQ0NTaU9qb29ja2Jj?=
 =?gb2312?B?RGV3TnQ3VmhJTVRnSE1McnRmWGJzdWFySWVrMjJMaTRQUDRrNUtpQ2xHNlJz?=
 =?gb2312?B?cDNhQXVQNGZMeFU1ZUNGYkdicUhwZkplUzhVN1RsMTlIcFQ0c0dvQ2UvR2F2?=
 =?gb2312?B?ek9CS3ZUNHdITi9hMU1Fc1ZtVitVaTUrRm52SFFBODZaRTRDSHdwelNadkRp?=
 =?gb2312?B?bFQxMHdZQncwRVplajJBakhlYWRVR1RabnBNTWlFS2ZjcFluRytoR1FxWWRr?=
 =?gb2312?B?MGZpWDRobHZTQ2R2VnROLzFiTHpxOGNDQkRDUFRqd2lCTUp1Nmd5RmE4LzBL?=
 =?gb2312?B?ejNjMnF5SlZZa0hsTE01TStoaTVtY3pMUkZ3WmdOV1krTG9nRVF2Q0NscDdK?=
 =?gb2312?B?L0ExMmlVVFJ2Rkp6eGhMYkNaQXY4SWx4MnU5eXh6K3loVmVldFU0N2IzSXBn?=
 =?gb2312?B?L1hvSTZ1aVpEL3ZTQlhZR2pHanpSdUQ5eEpTMjd2azFQcWsxc0thRlFidEJj?=
 =?gb2312?B?ek9SdVF5MFQ4RjgxWVkyMkhjK0RTQmhSeTM4WDF3RlFVb2FpREVUTjA2L3Bv?=
 =?gb2312?B?MCtjMm1yQ1gvWVFXVG5IYS9oV04wd3VXS2tWVWFORFgvS3VwU0JNVVVlVVJU?=
 =?gb2312?B?d0hpNGg5YmVhd3J5S3krVjhJK3c4a0lKRzN3ZHNLOFViOGZ2T1htVndkWlRD?=
 =?gb2312?B?bURtRWdSaExrQ1diSmNOQStzNzZWSk9PVlduQUJPL05XaEFmY085WjFQRzY0?=
 =?gb2312?B?N01DZHE4bUpWZVpmMjlQWXo0ZUhteUJ5Z3lPOFBJcUxTYmV5RG1GWXFkMUFj?=
 =?gb2312?B?SEpiZThLOGtDV0NzN1FHNk56NGlpTTFqc051OW9XWjJFK25taFNDTUZzbnpM?=
 =?gb2312?B?eDJ6K3VSaXNYWmptWmlQTDcydTE1WVhuNDNpUnhLMXNFOTB0azBONHJ0NlpR?=
 =?gb2312?B?aDRHTEFBTWdwb0ZEeFZDcC82a3BMc1RsTStqS01nbTNSM3haS1lYTHZqYmdY?=
 =?gb2312?Q?q1ZHLW2igd6sNZNfY8MtXqtR6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40825d88-dc70-486c-2d72-08dce8d1aecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 02:17:25.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/CGtnssAGnlKXrpevdJTB8d4FTF1OlNpqWqbmAJ+067kaRm2nkAT2TkNeaJd9Nxs12MWmKvNBq5vFEcFE85Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxjYXNz
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqMTDUwjnI1SAyMzowMA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsga3J6
aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAx
LzRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgcmVnLW5hbWUgImRiaTIiIGFuZA0KPiAi
YXR1IiBmb3IgaS5NWDhNIFBDSWUgRW5kcG9pbnQNCj4gDQo+IE9uIFR1ZSwgQXVnIDEzLCAyMDI0
IGF0IDAzOjQyOjIwUE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCByZWctbmFt
ZTogImRiaTIiLCAiYXR1IiBmb3IgaS5NWDhNIFBDSWUgRW5kcG9pbnQuDQo+ID4NCj4gPiBGb3Ig
aS5NWDhNIFBDSWUgRVAsIHRoZSBkYmkyIGFuZCBhdHUgYWRkcmVzc2VzIGFyZSBwcmUtZGVmaW5l
ZCBpbiB0aGUNCj4gPiBkcml2ZXIuIFRoaXMgbWV0aG9kIGlzIG5vdCBnb29kLg0KPiA+DQo+ID4g
SW4gY29tbWl0IGI3ZDY3YzYxMzBlZSAoIlBDSTogaW14NjogQWRkIGlNWDk1IEVuZHBvaW50IChF
UCkgc3VwcG9ydCIpLA0KPiA+IEZyYW5rIHN1Z2dlc3RzIHRvIGZldGNoIHRoZSBkYmkyIGFuZCBh
dHUgZnJvbSBEVCBkaXJlY3RseS4gVGhpcyBjb21taXQNCj4gPiBpcyBwcmVwYXJhdGlvbiB0byBk
byB0aGF0IGZvciBpLk1YOE0gUENJZSBFUC4NCj4gPg0KPiA+IFRoZXNlIGNoYW5nZXMgd291bGRu
J3QgYnJlYWsgZHJpdmVyIGZ1bmN0aW9uLiBXaGVuICJkYmkyIiBhbmQgImF0dSINCj4gPiBwcm9w
ZXJ0aWVzIGFyZSBwcmVzZW50LCBpLk1YIFBDSWUgZHJpdmVyIHdvdWxkIGZldGNoIHRoZSBhY2Nv
cmRpbmcNCj4gPiBiYXNlIGFkZHJlc3NlcyBmcm9tIERUIGRpcmVjdGx5LiBJZiBvbmx5IHR3byBy
ZWcgcHJvcGVydGllcyBhcmUNCj4gPiBwcm92aWRlZCwgaS5NWCBQQ0llIGRyaXZlciB3b3VsZCBm
YWxsIGJhY2sgdG8gdGhlIG9sZCBtZXRob2QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExp
IDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbCAgfCAxMw0KPiA+ICsrKysrKysrKy0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55YW1sDQo+ID4gaW5kZXggYTA2Zjc1ZGY4
NDU4Li44NGNhMTJlOGIyNWIgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55YW1sDQo+
ID4gQEAgLTY1LDEyICs2NSwxNCBAQCBhbGxPZjoNCj4gPiAgICAgIHRoZW46DQo+ID4gICAgICAg
IHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgcmVnOg0KPiA+IC0gICAgICAgICAgbWluSXRlbXM6
IDINCj4gPiAtICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ID4gKyAgICAgICAgICBtaW5JdGVtczog
NA0KPiA+ICsgICAgICAgICAgbWF4SXRlbXM6IDQNCj4gDQo+IE5vdyBpdCBzZWVtcyBsaWtlIHRo
aXMgcGF0Y2ggaGFzIGFscmVhZHkgYmVlbiBwaWNrZWQgdXAsIGJ1dCBob3cgaXMgdGhpcyBub3QN
Cj4gYnJlYWtpbmcgRFQgYmFja3dhcmRzIGNvbXBhdGliaWxpdHk/DQo+IA0KPiBZb3UgYXJlIGhl
cmUgaW5jcmVhc2luZyBtaW5JdGVtcywgd2hpY2ggbWVhbnMgdGhhdCBhbiBvbGRlciBEVCBzaG91
bGQgbm93IGZhaWwNCj4gdG8gdmFsaWRhdGUgdXNpbmcgdGhlIG5ldyBzY2hlbWE/DQo+IA0KPiBJ
IHRob3VnaHQgdGhhdCBpdCB3YXMgb25seSBhY2NlcHRhYmxlIHRvIGFkZCBuZXcgb3B0aW9uYWwg
cHJvcGVydGllcyBhZnRlciB0aGUNCj4gRFQgYmluZGluZyBoYXMgYmVlbiBhY2NlcHRlZC4NCj4g
DQo+IFdoYXQgYW0gSSBtaXNzaW5nPw0KPiANCj4gDQo+IElmIHRoZSBzcGVjaWZpYyBjb21wYXRp
YmxlIGlzbid0IHVzZWQgYnkgYW55IERUUyBpbiBhIHJlbGVhc2VkIGtlcm5lbCwgdGhlbiBJIHRo
aW5rDQo+IHRoYXQgdGhlIGNvbW1pdCBsb2cgc2hvdWxkIGhhdmUgY2xlYXJseSBzdGF0ZWQgc28s
IGFuZCBleHBsYWluZWQgdGhhdCB0aGF0IGlzIHRoZQ0KPiByZWFzb24gd2h5IGl0IGlzIG9rYXkg
dG8gYnJlYWsgRFQgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuDQo+IA0KSGkgTmlrbGFzOg0KVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBjb25jZXJucy4NClVwIHRvIG5vdywgdGhlIHBjaWVf
ZXAgb2YgaS5NWDhNUCBpcyBvbmx5IHByZXNlbnQgaW4gaS5teDhtcC5kdHNpIGZpbGUuDQpBbmQg
aXQgaXNuJ3QgdXNlZCBieSBhbnkgRFRTIGluIHRoZSByZWxlYXNlIGtlcm5lbHMuDQpTbywgdGhp
cyBzZXJpZXMgd291bGRuJ3QgYnJlYWsgRFQgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuDQoNCkJl
c3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gTmlrbGFzDQo+
IA0KPiA+ICAgICAgICAgIHJlZy1uYW1lczoNCj4gPiAgICAgICAgICAgIGl0ZW1zOg0KPiA+ICAg
ICAgICAgICAgICAtIGNvbnN0OiBkYmkNCj4gPiAgICAgICAgICAgICAgLSBjb25zdDogYWRkcl9z
cGFjZQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBkYmkyDQo+ID4gKyAgICAgICAgICAgIC0g
Y29uc3Q6IGF0dQ0KPiA+DQo+ID4gICAgLSBpZjoNCj4gPiAgICAgICAgcHJvcGVydGllczoNCj4g
PiBAQCAtMTI5LDggKzEzMSwxMSBAQCBleGFtcGxlczoNCj4gPg0KPiA+ICAgICAgcGNpZV9lcDog
cGNpZS1lcEAzMzgwMDAwMCB7DQo+ID4gICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1w
Y2llLWVwIjsNCj4gPiAtICAgICAgcmVnID0gPDB4MzM4MDAwMDAgMHgwMDA0MDAwMDA+LCA8MHgx
ODAwMDAwMCAweDA4MDAwMDAwPjsNCj4gPiAtICAgICAgcmVnLW5hbWVzID0gImRiaSIsICJhZGRy
X3NwYWNlIjsNCj4gPiArICAgICAgcmVnID0gPDB4MzM4MDAwMDAgMHgxMDAwMDA+LA0KPiA+ICsg
ICAgICAgICAgICA8MHgxODAwMDAwMCAweDgwMDAwMDA+LA0KPiA+ICsgICAgICAgICAgICA8MHgz
MzkwMDAwMCAweDEwMDAwMD4sDQo+ID4gKyAgICAgICAgICAgIDwweDMzYjAwMDAwIDB4MTAwMDAw
PjsNCj4gPiArICAgICAgcmVnLW5hbWVzID0gImRiaSIsICJhZGRyX3NwYWNlIiwgImRiaTIiLCAi
YXR1IjsNCj4gPiAgICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1QX0NMS19IU0lPX1JPT1Q+LA0K
PiA+ICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TVBfQ0xLX0hTSU9fQVhJPiwNCj4gPiAgICAg
ICAgICAgICAgICAgPCZjbGsgSU1YOE1QX0NMS19QQ0lFX1JPT1Q+Ow0KPiA+IC0tDQo+ID4gMi4z
Ny4xDQo+ID4NCg==

