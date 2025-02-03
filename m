Return-Path: <linux-pci+bounces-20649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B2A251DF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 05:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278C23A45EC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 04:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3089288CC;
	Mon,  3 Feb 2025 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s90Dgh6o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35C78F49;
	Mon,  3 Feb 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738557906; cv=fail; b=vAgW1ywFLEek5SoYtxRZDo/ykbxEAPyZWYt5fUcXqXsClzggp5+p591L5srF9sJ3tKqf1xEpWCf3KSSlHX/zNp7g3MGlP0mHfN7wLYKKUJlm3ZUuk4c/HeOGWxMtq5M8bcxC5/bycsu6pBOtxfAY5UgkbpwtLBaYQYXhp3ZnNbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738557906; c=relaxed/simple;
	bh=8uAjuS43zIkIke9jirexEe3nT7xbYizzCdOwiQc7Kiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIMvpOepNsTX1wFEBOyQZDQUFaz6NaQ8uykzhrbgQsI3M9WqtAUAf8Qk/cDysGYMFyoHW51vizu2U+UShqWHoQ3JsIV/B7vqhojr7sWBA9zBIFwWXgd0vXcgYGV3cC6xDEmV93bd/hk0R1sAjcTB9oBHUG/o1eAR6GW0le0ozfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s90Dgh6o; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5133DDpf015581;
	Sun, 2 Feb 2025 20:44:52 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44jnq184e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Feb 2025 20:44:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuVUimsfWavfDNtuuf6RsP4oawxpGAk9e4fhzIj9VCOaEij3H3TfuaHphxCNFhR8T9eMkzl+Es2yBTE9TmEzyDBf4wcXcuMNsz43GXpkuffKhQyUrZDDwZ3Z/Oq3g/22VjEfWd1zW0FeTiZj6yv+QwAnyE0pv0d+R71x60/0vce7qyCV7gOqoioMw1g/FQDvxskG0MqAFV5T4x30dL9U1VCF4PHsJAG8WGo1lsAmGONHl2gGhylRrTmkKbIthw5tVA5gp/bl2bxLLBgZfrGg+56E9wAoJTfBGU48h5rHevq8WZ3LHb5o7TuyXIm0KQsScIoNh3CjrUAdvcj2Wc85Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uAjuS43zIkIke9jirexEe3nT7xbYizzCdOwiQc7Kiw=;
 b=hNyrRAPbSoBcK1gG14ExNEVzEH6w6LthKxDuKHau/MFGo1XzOg9LXy3OQ5+8Y3ApGfcuzPxRe5n2rGNH8GhxVPiwXYfAI8LcemAfhGAH078shzMg6lOgoZjMJ4uTxV5f0R2voZMio77grMNSd2aCIcib2yE6ZwouIRcR5KWjnS5ySTkDF0mXYxWMI7836bc6oGd2q/vs9FwW+5Nv/Pl5m1qGZNIQ21aKSbwaMRKZn954jq7AEBAHWqnnosU6PEB3Wh9W1XokCPrCIGUOl58x7xi9qmS8/LrGU/GcVcyyh7+PHlQgWKuh+RZf1sW9v2sBqBmMkijpNYS1BPmd9lZ/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uAjuS43zIkIke9jirexEe3nT7xbYizzCdOwiQc7Kiw=;
 b=s90Dgh6o0k0Wx76XxmlbFwtqLPNpbH4ML266debEuSj/qwEGK/R9zHXSkRjfeDiszAJ+3mTUzPYhXHKDheEb0rpJAlwnCc0HS5nA5ObCBgxZHTTIlBWRuxVhOmkBCP+xUXWvO1H6BqWU3RWbf0CjLMazPJgml1RS2Qc6dNIM0Rg=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by CH0PR18MB4195.namprd18.prod.outlook.com (2603:10b6:610:be::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 04:44:49 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 04:44:49 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [PATCH 1/1] PCI: armada8k: use reset controller to reset mac
Thread-Topic: [PATCH 1/1] PCI: armada8k: use reset controller to reset mac
Thread-Index: AQHbdfV5/rFMyCnK6UaiXwIcHEgcJrM0/xQQ
Date: Mon, 3 Feb 2025 04:44:49 +0000
Message-ID:
 <BY3PR18MB467365740953603B5B8FAD5BA7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112070745.759678-1-jpatel2@marvell.com>
 <20241112214134.GA1861807@bhelgaas>
 <BY3PR18MB46737F4B51AD6A3891009B91A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB46737F4B51AD6A3891009B91A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|CH0PR18MB4195:EE_
x-ms-office365-filtering-correlation-id: deac0aa8-3422-42de-954e-08dd440d7dc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUh6WTRlNzlxeDhnMUxRWGhJRzlVemR2bzhub29XK2Z1aDV5Q3gvVnJPTXo1?=
 =?utf-8?B?V2RSOFAwY3hDK2IxWFlCNjF1QXVlcm84TWpNK3RjUWJCSm9nV0V5ZUdPclQx?=
 =?utf-8?B?bnlxZ1BDRkErdnpwYTNHM0daYUtUeGVUckxwbTBwSkNneTlkemF3bjBtRXVZ?=
 =?utf-8?B?WEozaitadE9MMHUyeVVNdG5lTGc5RnBRcHR5UkpTUWdrWmdLaS9tN004RWhv?=
 =?utf-8?B?QTVQbXIreExQRXQ1RFJaRzhkd2hwUjRsV2xVcWVPcHZ0K0Z3L1ZoQ0FKaS96?=
 =?utf-8?B?cnV1UnN0VU9JaWxUNnNDZmVWYm51aE9FbVBEZnN2TzZJbzRncGFjZ05Bd2ZC?=
 =?utf-8?B?R3JyYzdzck1TREVHTjNFUS9oRWdnbWpXSWtJSUx4SW93MGRMcWhybFhKLzFt?=
 =?utf-8?B?bmFEZVIyL2ZMUy8vdU9EaE80OWJuVy9YdVRhaEV0aGtUbzRBTC9XSHUrMjl4?=
 =?utf-8?B?Z1dMbGFxdVpNOEZ3RE1IRUpIb01OcFNlcDdhd3puYnp0aEMwZjVYWmtoL1Ns?=
 =?utf-8?B?WXE0S2xxTGxpZ2tITEZWL3NtZlJRMkdHc2k4bDE1clhzSlB1UFl5SFZPWGs5?=
 =?utf-8?B?SUE0b213b3dsV0JHSFFjRGh1M0dpZHd2Z0FxWDRCWmF3Rkc4amdMaFRoWXFU?=
 =?utf-8?B?NDQ3ZHA3V1I1VmpjWnNEbFJLMGdxQzNVN3pDaXBOQjVMZUxEYnRVTUlzVWxL?=
 =?utf-8?B?Y0kveFIxYXZHZWg3TG1GdUdROFdTOUx0ZlFUZ0NWeDYzVlJhbTB5WDVCZHd0?=
 =?utf-8?B?V3MwRitVbmRZMWFVTzd3SEtjZ1FwU3RQemx5QTdoS1YzQ3N1czNac1NldkV5?=
 =?utf-8?B?UGZKbDBwaG9Qa3lHZVZVZXhaaDZsdXkzREdYenZkWVlPQXZwckNqaVF1Sm1l?=
 =?utf-8?B?dmdjNHIxbTJsQWkwYkpUcy85YlB0WnYyZ1dFWEVnZFlqaFBHU2plQURVdUVt?=
 =?utf-8?B?RFhoYTMvT29ZVWVGOTA3cHBaeDV4SnZIRjRKdmJPUkNER1BiMG5oOEE5cDBa?=
 =?utf-8?B?NkVqZjJ3OEFJaDV6S1c5eW9vUlR0VjFnNFA4UG81cTZMS3RMTDFaUG9rRkVy?=
 =?utf-8?B?TFpZQlNXY004dTlKbjN4dWhOMHZRRWZaYUVrSWkwUXkyZ0RZWTEvOW51VlEw?=
 =?utf-8?B?UzE4MG5Ha2h6RTh5S3BVMGw3aUpRQ2xqQ2dldzV5WUFnZmt6T3NhUmlEbGRW?=
 =?utf-8?B?Qm9SbXBBMmQvdktEOVIyc2tYVktoYXYvK3VvL21UYnVtb2JZZjVYeVVUR2JX?=
 =?utf-8?B?cTJHTkdlRDhlaVhMWi9JVExzOEs1VmlEb0EyRzZkZ0NDZ2NkNjRCczdyQ2ZH?=
 =?utf-8?B?K3FBdk5RRWZ5VDdZZEFiR1VTMkh0T1pCMnl4cWEzWEdzU05QdDkwZTZRWW9K?=
 =?utf-8?B?T2hRYmhzSHBkemE2bC96R0lTdlY2NlgvaFZJSTZJL2xxRjFtTkt4YzRMWm1P?=
 =?utf-8?B?Q0VNN1k2c2F1anFBaEFyL3VmMU5XbThwZkUzYm9YLyt0cVFtOFAvbnBLMkUx?=
 =?utf-8?B?U1Q1Z3dmWkFDUk9sS2o0eWswZmM4dFl5WWpycXkvaDUyS2RnWlU4enRTai9D?=
 =?utf-8?B?azlodmJQcWNVM05QUXRQK3VuTUYrOXJKYlI4RzNiSGlBZmVLRUgrK1h6czJZ?=
 =?utf-8?B?alhubjlyYTNOalhEcHNpdm8vTnlWM0xSWlBrckxZYVZpem9XWVdua0R1Uk1h?=
 =?utf-8?B?M0l2WWtFUXo2L2NxQ0VYK1lzTkVSdE8rVmdSVVV1QmsrMEhZWC9wczA1bzJh?=
 =?utf-8?B?Ty9WWFJpQWkvSENEVnJCT0xmTHVhMkxXVk9XOHBmaFhuL3B2TEdyUThzeVhw?=
 =?utf-8?B?cXYwZldTSG9JRWhzdjlBMjg2Z1dSeG1yNndFVCs5cFQybGg0ZGtkc1RkeVdp?=
 =?utf-8?B?SWJyeHIzWkI2SDk4WmxCckpOT0cwY0hlQ2h4MTBWaExhSnpsY0tHcVdvMGlK?=
 =?utf-8?Q?t1sL2IxxphAXgl6K2Hv4doEhiuMn1gVD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0FMa0VMTlJIeUpTbUxMWGxyT3BsSmRXeno2K3IyanJpWnpMamVUNExvQitm?=
 =?utf-8?B?MUgvMTdmUzQ5bzFzM1NSUGt3cFNvdUJNYnBoc3p1MUpHdFZSa1Z2b1JucGhV?=
 =?utf-8?B?VGplYitsWWpGekEwRitNS1AvMURWME5NaURlS0NRQlNFK1FPOTU1NHh4YVF2?=
 =?utf-8?B?N3V6TG5ZVnpobnVSelVab0NOWkxVMCtqVHFyOWYrNll2SEYrS0RVRW9qb1gy?=
 =?utf-8?B?NDE0dVhqSjM1N2xmS2EreUxwaS9pa21DS0NLY0QvVFpONCtWRUw3eWdzR0dm?=
 =?utf-8?B?UTM5YitJYTl2UEl1L1VVaFlmZmpEenBYcDUyTVZUbTVOamh2YTkzZjJMNnNH?=
 =?utf-8?B?SnNKQ0hieXk4aXBSdVBkcndtKzlPTmRYcG45cnFIbS8vZ2FlTDdSWHdxUi9T?=
 =?utf-8?B?dXJrci9zRGFPZUM5TE1PMlZiQ2pwalBRMEpoeTkvYm5zdmJpNzNWV2JzenVV?=
 =?utf-8?B?ZUJJdGRNZWoyYUdMeDBmcmVSMlBtOXVGNXNnNW9YY2VidVk0VEJuaW1tZmVG?=
 =?utf-8?B?TTJ2NEY4Q0tyVG0zOUlLOEczN2pLVHl5RVNvcCtuTUFGem5TYWxMa0o2ZFpW?=
 =?utf-8?B?M2dGYXhRN2tWNjkwZ2pVa01NUVNyalNnVlFZdDNaNE51NjlidTNrb05FMG12?=
 =?utf-8?B?Vkc5dW9UdkhmQmQycjlTb1k5WUsybGphTnI0N0RzR2wvaWN5QkhqV203YmxC?=
 =?utf-8?B?TFQrRTUzOHdxTmZoWS9ZUVVZTnFFRDg1bHdPMVZLb2VLZE1VU3lhT0ZpQVBO?=
 =?utf-8?B?L25ZZ0YwM0JEb3FhTUtyNnYvUWtvY1o4MmkwV2ZrRkpLOGZINFJsZmYyeFVs?=
 =?utf-8?B?bnhrcS9jRVNObi9GSzl1b0x1VDc4OE9NaEwxSWpFeGdGZUM4V2pBUEcxb2NG?=
 =?utf-8?B?RmQxTHBQTndVTUVqUEFVMlpJSXlIWUNrYjFpRk1jYXp6YzA0d251aEoyVFFL?=
 =?utf-8?B?N1lIT2owKzlLRndCeExzc2wyQWw3L0c5U25Ya0ZNRTl4UWdZcWZJdFpPelBD?=
 =?utf-8?B?R1ZFYng4VkErZ2tGVVF1Z08yWWIwQys0eFlGdzJ5Zmw1a0FraEVsVFRIM01y?=
 =?utf-8?B?blJoc0hGdmdKYXZ5SXo3WXR4eEg3bnpnQklSU0Z6MTJVSWEvZHpMaUsrVEhD?=
 =?utf-8?B?SjlvelhnZ1hhS1k0eEo1UWtTaFJNdi9EVHRaNnRvTDJpY0htOTlRc1UwVWFL?=
 =?utf-8?B?UnhEalpQamdUelF0dmVEU1J5RmVHd2xlTlpLN2Y3YUltVGhkYlJ2QU9seTBW?=
 =?utf-8?B?QXphdUtvUG9sNGZWb1RUeVV4NnFpaWFBa3VFYlluTzBQckZKSWVsYlNoa2Yz?=
 =?utf-8?B?NHB5aURDSitwclR5Rmp1b1hqRkJrTEJjL24xeVpPS0JzUDR2enBRcWliRjAx?=
 =?utf-8?B?SmJTaEdjUWcyUHhvVDBGZnB3TUNLTlMzNDRSclc1QnZoTVVHY284OUdrYkxz?=
 =?utf-8?B?ZERKZXZ5MXc2T0tiVlNkQTNvbWJhTjlJcWRCQTJmNkYyRkFCZGpuLzcrdHA1?=
 =?utf-8?B?RjVjM1duMSsxcklsY1BpQzdKTnZrM3hBL1AyVDlpTndSamNCZ1dCM25DSUVT?=
 =?utf-8?B?bXlFWno3SlhEYXZ6M2FyWHJsaUQ1VjJpcytkdWRWZitpbUJlRDNEQnBtdXZh?=
 =?utf-8?B?SHpaSVN3YnE4WGFKV3BtMldvZFozdG83aEZnSkV0Tk11M2E3SVhvTDJmSUtO?=
 =?utf-8?B?MTFSUkFva09GRnV0Ny9rVUtNeTJNY2hDcFRHRmUrSDgvMVlnOW1lZEtFa1Bx?=
 =?utf-8?B?M1ZRcCtLNDZLYjlpditKbXJaMG16SE9xZkUxMjhVN2ZIUytnMHpIcmdoNzE5?=
 =?utf-8?B?VXhlVUpnRGRTVXQxZjhiU2xHVlhrMXBYOHNXdjVFTGdwQVg5OE8zVXc3ZTZZ?=
 =?utf-8?B?am5PbW9wV3Y2SWRlTmtnT1dDdEVqeUNJakJJSllWd21SdFZtVnh4NzdZcDNv?=
 =?utf-8?B?bFU1QVFlQUMydVdZWnA2cFYrdEpoRTNRdEQyMDhvdHBFdVR5QlRqam5QN1lk?=
 =?utf-8?B?M0dpZStUWnpWd1FSNG12WlYwVitGdU9CejJvUnlla1l5ekdYRS9yalJPTnJQ?=
 =?utf-8?B?bHJ4amMzVTVMR0JmeU4wNlZOK2ZOcGxmSjVibEkyeVNidStlM1ZRSDRmOW41?=
 =?utf-8?B?eThXSFM0SUEwMnhXR0VvOVdFb1pwSGZwS2doSkE4anF4ZUlBT1pOUGVnbjB2?=
 =?utf-8?Q?AxwAARKZU1i5j2wrxiwlgitkVT1dm9Y62yVLyDDAM8yW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deac0aa8-3422-42de-954e-08dd440d7dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 04:44:49.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCGzO4Hau9C5oqwnmwAEdXccweNNXXuSCYpIBqi8EMsDhWxEdK3mpjeag5iKjZE8CHXD1NnlBHQwYeDe8DnX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4195
X-Proofpoint-ORIG-GUID: -nAE0obJbBn8PBI0Jo3ADQOywqbiM2ai
X-Proofpoint-GUID: -nAE0obJbBn8PBI0Jo3ADQOywqbiM2ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01

PiBPYnNlcnZlIHN1YmplY3QgbGluZSBjYXBpdGFsaXphdGlvbiBjb252ZW50aW9uLg0KPiANCj4g
T24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMTE6MDc6NDVQTSAtMDgwMCwgSmVuaXNoa3VtYXIgTWFo
ZXNoYmhhaSBQYXRlbA0KPiB3cm90ZToNCj4gPiBjaGFuZ2UgbWFjIHJlc2V0IGFuZCBtYWMgcmVz
ZXQgYml0cyB0byByZXNldCBjb250cm9sbGVyDQo+IA0KPiBDYXBpdGFsaXplIHNlbnRlbmNlLg0K
PiANCj4gcy9tYWMvTUFDLw0KPiANCj4gRXhwbGFpbiB3aHkgd2Ugd2FudCB0aGlzLiAgQXBwYXJl
bnRseSB5b3UncmUgY2hhbmdpbmcgZnJvbSBvbmUgTUFDIHJlc2V0DQo+IG1ldGhvZCB0byBhbm90
aGVyIG1ldGhvZD8NCj4gDQo+IENvbGxlY3QgdGhlc2UgaW50byBhIHNlcmllcyBpbnN0ZWFkIG9m
IHBvc3RpbmcgaW5kaXZpZHVhbCByYW5kb20gcGF0Y2hlcy4NCj4gDQoNClNvcnJ5IGFib3V0IHRo
ZSBtZXNzLiBZZXMsIHRoZXNlIHBhdGNoZXMgc2hvdWxkIGJlIHBvc3QgaW50byBhIHNlcmllcyBp
bnN0ZWFkLg0KQW5kIHRoaXMgb25lIGlzIGFjdHVhbCBhbiBpbXByb3ZlbWVudCB0byB0aGUgY29t
bWl0ICgiUENJOiBhcm1hZGE4azogQWRkDQpsaW5rLWRvd24gaGFuZGxlIikuIEl0IHNpbXBsaWZp
ZWQgdGhlIE1BQyByZXNldCBjb2RlIGJ5IHJlc2V0IGNvbnRyb2xsZXIgQVBJcy4NCkV2ZW50dWFs
bHksIGl0IHNob3VsZCBiZSBzcXVhc2hlZCBpbnRvIHRoZSBwcmV2aW91cyBjb21taXQuDQoNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKZW5pc2hrdW1hciBNYWhlc2hiaGFpIFBhdGVsDQo+ID4gPG1haWx0
bzpqcGF0ZWwyQG1hcnZlbGwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWFybWFkYThrLmMgfCAzMA0KPiA+ICsrKysrKystLS0tLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hcm1h
ZGE4ay5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMN
Cj4gPiBpbmRleCA5YTQ4ZWY2MGJlNTEuLmY5ZDY5MDc5MDBkMSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiBAQCAtMjEsNyArMjEs
NyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9yZXNvdXJjZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+
ID4gLSNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9y
ZXNldC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gICNpbmNsdWRlIDxs
aW51eC9vZl9ncGlvLmg+DQo+ID4NCj4gPiBAQCAtMzUsMTEgKzM1LDEwIEBAIHN0cnVjdCBhcm1h
ZGE4a19wY2llIHsNCj4gPiAgCXN0cnVjdCBjbGsgKmNsa19yZWc7DQo+ID4gIAlzdHJ1Y3QgcGh5
ICpwaHlbQVJNQURBOEtfUENJRV9NQVhfTEFORVNdOw0KPiA+ICAJdW5zaWduZWQgaW50IHBoeV9j
b3VudDsNCj4gPiAtCXN0cnVjdCByZWdtYXAgKnN5c2N0cmxfYmFzZTsNCj4gPiAtCXUzMiBtYWNf
cmVzdF9iaXRtYXNrOw0KPiA+ICAJc3RydWN0IHdvcmtfc3RydWN0IHJlY292ZXJfbGlua193b3Jr
Ow0KPiA+ICAJZW51bSBvZl9ncGlvX2ZsYWdzIGZsYWdzOw0KPiA+ICAJc3RydWN0IGdwaW9fZGVz
YyAqcmVzZXRfZ3BpbzsNCj4gPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyZXNldDsNCj4gPiAg
fTsNCj4gPg0KPiA+ICAjZGVmaW5lIFBDSUVfVkVORE9SX1JFR1NfT0ZGU0VUCQkweDgwMDANCj4g
PiBAQCAtMjU3LDEyICsyNTYsOSBAQCBzdGF0aWMgdm9pZCBhcm1hZGE4a19wY2llX3JlY292ZXJf
bGluayhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndzKQ0KPiA+ICAJbXNsZWVwKDEwMCk7DQo+ID4N
Cj4gPiAgCS8qIFJlc2V0IG1hYyAqLw0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzX2Jhc2UocGNp
ZS0+c3lzY3RybF9iYXNlLA0KPiBVTklUX1NPRlRfUkVTRVRfQ09ORklHX1JFRywNCj4gPiAtCQkJ
CXBjaWUtPm1hY19yZXN0X2JpdG1hc2ssIDAsIE5VTEwsIGZhbHNlLCB0cnVlKTsNCj4gPiArCXJl
c2V0X2NvbnRyb2xfYXNzZXJ0KHBjaWUtPnJlc2V0KTsNCj4gPiAgCXVkZWxheSgxKTsNCj4gPiAt
CXJlZ21hcF91cGRhdGVfYml0c19iYXNlKHBjaWUtPnN5c2N0cmxfYmFzZSwNCj4gVU5JVF9TT0ZU
X1JFU0VUX0NPTkZJR19SRUcsDQo+ID4gLQkJCQlwY2llLT5tYWNfcmVzdF9iaXRtYXNrLCBwY2ll
LQ0KPiA+bWFjX3Jlc3RfYml0bWFzaywNCj4gPiAtCQkJCU5VTEwsIGZhbHNlLCB0cnVlKTsNCj4g
PiArCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocGNpZS0+cmVzZXQpOw0KPiA+ICAJdWRlbGF5KDEp
Ow0KPiA+DQo+ID4gIAlyZXQgPSBkd19wY2llX3NldHVwX3JjKHBwKTsNCj4gPiBAQCAtMzMxLDcg
KzMyNyw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhcm1hZGE4a19wY2llX2lycV9oYW5kbGVyKGlu
dA0KPiBpcnEsIHZvaWQgKmFyZykNCj4gPiAgCQkgKiBpbml0aWF0ZSBhIGxpbmsgcmV0cmFpbi4g
SWYgbGluayByZXRyYWlucyB3ZXJlDQo+ID4gIAkJICogcG9zc2libGUsIHRoYXQgaXMuDQo+ID4g
IAkJICovDQo+ID4gLQkJaWYgKHBjaWUtPnN5c2N0cmxfYmFzZSAmJiBwY2llLT5tYWNfcmVzdF9i
aXRtYXNrKQ0KPiA+ICsJCWlmIChwY2llLT5yZXNldCkNCj4gPiAgCQkJc2NoZWR1bGVfd29yaygm
cGNpZS0+cmVjb3Zlcl9saW5rX3dvcmspOw0KPiA+DQo+ID4gIAkJZGV2X2RiZyhwY2ktPmRldiwg
IiVzOiBsaW5rIHdlbnQgZG93blxuIiwgX19mdW5jX18pOyBAQCAtDQo+IDQ0MCwxOA0KPiA+ICs0
MzYsMTAgQEAgc3RhdGljIGludCBhcm1hZGE4a19wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAlpZiAoZ3Bpb19pc192YWxpZChyZXNldF9ncGlvKSkNCj4gPiAg
CQlwY2llLT5yZXNldF9ncGlvID0gZ3Bpb190b19kZXNjKHJlc2V0X2dwaW8pOw0KPiA+DQo+ID4g
LQlwY2llLT5zeXNjdHJsX2Jhc2UgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKHBk
ZXYtDQo+ID5kZXYub2Zfbm9kZSwNCj4gPiAtCQkJCQkJICAgICAgICJtYXJ2ZWxsLHN5c3RlbS0N
Cj4gY29udHJvbGxlciIpOw0KPiA+IC0JaWYgKElTX0VSUihwY2llLT5zeXNjdHJsX2Jhc2UpKSB7
DQo+ID4gLQkJZGV2X3dhcm4oZGV2LCAiZmFpbGVkIHRvIGZpbmQgbWFydmVsbCxzeXN0ZW0tY29u
dHJvbGxlclxuIik7DQo+ID4gLQkJcGNpZS0+c3lzY3RybF9iYXNlID0gMHgwOw0KPiA+IC0JfQ0K
PiA+IC0NCj4gPiAtCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9ub2Rl
LCAibWFydmVsbCxtYWMtcmVzZXQtDQo+IGJpdC1tYXNrIiwNCj4gPiAtCQkJCSAgICZwY2llLT5t
YWNfcmVzdF9iaXRtYXNrKTsNCj4gPiAtCWlmIChyZXQgPCAwKSB7DQo+ID4gLQkJZGV2X3dhcm4o
ZGV2LCAiY291bGRuJ3QgZmluZCBtYWMgcmVzZXQgYml0IG1hc2s6ICVkXG4iLCByZXQpOw0KPiA+
IC0JCXBjaWUtPm1hY19yZXN0X2JpdG1hc2sgPSAweDA7DQo+ID4gKwlwY2llLT5yZXNldCA9IGRl
dm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKCZwZGV2LT5kZXYsIE5VTEwpOw0KPiA+ICsJ
aWYgKElTX0VSUihwY2llLT5yZXNldCkpIHsNCj4gPiArCQlkZXZfd2FybihkZXYsICJmYWlsZWQg
dG8gZmluZCBtYWMgcmVzZXRcbiIpOw0KPiA+ICsJCXBjaWUtPnJlc2V0ID0gMHgwOw0KPiA+ICAJ
fQ0KPiA+ICAJcmV0ID0gYXJtYWRhOGtfcGNpZV9zZXR1cF9waHlzKHBjaWUpOw0KPiA+ICAJaWYg
KHJldCkNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=

