Return-Path: <linux-pci+bounces-11248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57F94737C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F74B1F21335
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6413C809;
	Mon,  5 Aug 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CgqleApV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23C2BCF7;
	Mon,  5 Aug 2024 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826586; cv=fail; b=fEtMdHX2QeRw1utcflgE4POWUC+1iCXUJaKN5jvxcFkPd/SNs3cnJfoc8RD1GkeL7E7i652rJxjjT/lRNVevDcqyrSGTThhtYQbQKoTkExa9IzpRdIV+RnsrnRxQfpJxrJzwZtqJC0UGpNru7c8CMzZHCChwZ7Sv/kPfzIP22vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826586; c=relaxed/simple;
	bh=KEPxTqFjaxw61syETjsEAVoVnnveW9bKw+dBgpZ2mOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcKCTHP8rfAq4JJHJiEt+L4Gl17ZnIul5jZce4Uor0gyfp/PTYaCh27mWhFCvuOUFKpr0UoNCV/dPLN2EOpTwythbOjLY5MCpeG3kNHfW5tM9i7i5k9tXUgHYPUjkfw2eGdwdoPoI8sg4oLpuMKvPRB1dyiEUCzUoiLFrdrRwro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CgqleApV; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWcwF9PthrJNrbEpOyMQj3z7YSuvEAD/S0iM9YI/iFiWaw+Ad98Df6DCulO9Bl40RUOiaikQ8VNS4T1LnhKuqJhmxC+zkOvvDPuaf/yFOXXnTePAYUC8V1JTFRROBJo3fJrZchnNlrIFp23NrDLPuGX3edZRLMrfaUSchpbX9/THn+NbTK2FhOhMjuv1aMY6NGUki3MHCkhPRibjiQJLB6EinHLpunZSQjd+Y+vEqcxS8TfDeBlN4szfFDH5ptYbzUnrrMaCsgmjrzY1coLY78AjkaneR5EWOeCbS/d6S1rFedqhTIsiPIfD3SMRnjXFbqkee6YSOvOklNhHh4kvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEPxTqFjaxw61syETjsEAVoVnnveW9bKw+dBgpZ2mOA=;
 b=Ayl+hiRHyh3Of958DbGRAY8pSmnst552wlxvW2qXvdmUj90BcRm94gEUhLhzaI9pUFQA196+HxgS/2GnOmjit2cVCKmgS/Nul0X6hT8DowDtBl6Hvo1Pe6zlrgnqyUD5vXyRLm6eW6YUiZnNZwnMyeSIiWlpdoppjgDD2yQNY44oddZyhQGXKAiREFlKEWa5A0fv/Uf/cfr0D4jtqnMb1ojSPX5hGiBB3P7Qwewdjjyhv+6qf1OHr5gAfqCI0sy3O0k7HEctajJT+kc7FR19D8SBl1Gai5KUOYKPw2ZVwj2icQwnxIGtWBGu8gaXJgUFkRytpiEN0KZt44K6SXKxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEPxTqFjaxw61syETjsEAVoVnnveW9bKw+dBgpZ2mOA=;
 b=CgqleApVIYpSkSHCo7uHYiQdDDWI8GJ7srN7XKdjQwI/QzadiBg3g+4U8l6Gz3DCJw6lnssW083uhHNUjSpkl0XDJsOjRYhP3+MQTRRth1bGg5ikeeL3CbnC2Dz6XFUN1+irWc5gYnCCmFrakTWeAPIEHAi1t+EXvxWcQG3mJPjv1So9I882wpHlp2bmxrdxujKWM87uJzAtvM7pHVlxONaNNozhzyMFQ8Q81fVPh1AeJe98XJ8tQ8575aTU0K56APFl8KqDkn6VDM7N5pGqLPf8icH6ThjtVfyl0uhszE3O0e07of9t92iA517VQA1AdUVTR3boZTeu7PmtnWRVjg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB9766.eurprd04.prod.outlook.com (2603:10a6:102:384::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 02:56:21 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 02:56:20 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Topic: [PATCH v5 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Index: AQHa5KqA4eRRzVNSI0eotV9T+2wcObIUcL4AgAOLcVA=
Date: Mon, 5 Aug 2024 02:56:20 +0000
Message-ID:
 <AS8PR04MB8676B6BA37A0CA7CBD4EFAD68CBE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-5-git-send-email-hongxing.zhu@nxp.com>
 <Zq1FoNiGA0x/GlhI@lizhi-Precision-Tower-5810>
In-Reply-To: <Zq1FoNiGA0x/GlhI@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAWPR04MB9766:EE_
x-ms-office365-filtering-correlation-id: 919764e1-1142-4f40-7d85-08dcb4fa2f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eFhyK0Y5c1hObmQ5TFU4ejZEdENlb1BLaTZ0WkZibFBCSVR4cWRLZzhWWDdy?=
 =?gb2312?B?QTJvenRsTm5rMll2N3hiV3ZqRFAzdHl1S1lHSVlBQUpXT2p3bkdOd3ExZGV4?=
 =?gb2312?B?YlBERVJIV0wvR0lrOHVVejUwV0RMQUdMaGJHT0cxSW9vMVhZUkpLN25zeitt?=
 =?gb2312?B?cTh3ZVdiQ05aNGJ2N0tTVTBZbm0zeThsWjF1NTcwY2luMjdEYlJFUWhmeEph?=
 =?gb2312?B?NE9MRTVjMldrM1ZhTzVsUDRsWHRoYWtSQjdOWXc5L3Jsd0lzNGpEbU00UDBU?=
 =?gb2312?B?Mnk3S0VUV0JHZERFY1dIUERsTWJyUlRBUzBCQVZpU3V4Q1BMKytHOVpUNWZ2?=
 =?gb2312?B?Q3BZME5CUnNkNGh3eDBvSE4zeER0NTlPZVNOS2NPYnAzUTh2ZGJUZy9BaVRB?=
 =?gb2312?B?amN6S3dsZHdZWFNQdDNPZ2pRNWw4cVZ1L0xJemhjRnNPV0FIUGFZL0hlSndp?=
 =?gb2312?B?SjVaU2lXQi95U043eXIzaDdDWis3RnI3TzZFT2l4dlNJL2JkU1Jxd24vL1Fo?=
 =?gb2312?B?ZE5tc3hacDlNd1EzU1NjcHpnOTdva091blk2eG5DNE45dmw2YjFzQkc3RzQ0?=
 =?gb2312?B?SVVBWjIwZFpMU2ZRanFvY0lIcCtnR2Zmb2FORngvSkdIZW5SL0t3alBiUVBU?=
 =?gb2312?B?Mk11YnczN20zWktVRS9HUUYyb0pnbGhvYmJ0eFRaZ0ljR21UZFlLTFF2QnJU?=
 =?gb2312?B?U2dFcXR5cWw1cC9PeGJUUkVTNkx0OThWbjdDMGFsd3dySCtyNk1TSERiQlhy?=
 =?gb2312?B?c0xnZFBJWmkxRkdJNHQwWWg5K2tEeHdsVmRtM3RMRGpuQjVTTDZuTkdVUmI2?=
 =?gb2312?B?dGtjeWNFdkNybEViVkNJdmpETml6V0ZnY3FRODAxaEJndGpaUis4YmFBTUxG?=
 =?gb2312?B?TDJ5ZlVIR2dtOXRGK2lQY0h2azJlL3lzM1ExamprdHp0NlJGWHpWK2Y3SkVJ?=
 =?gb2312?B?RzFTN3hWSTQxa2o5NCthLzFRbnBWN3lTOGFrN01yeUNBZnNBM1F4cWorZXdE?=
 =?gb2312?B?NkgzVThmMW9OTkNoN2kvcFYzV2RvaEhLeGZtazVTM1FudTVpVHNqN0NpY1FM?=
 =?gb2312?B?RFdTZDE4WVVYNUZiK2FZL05ITzZKRjN2SGsvdFNHSEx4NXdvS1VHRlpYWUtV?=
 =?gb2312?B?QXJBckU0SEFQWDFadVdYQzQ2T3ltbjE2NHNmcFNLL1hXUG9GcWdHay80T3FX?=
 =?gb2312?B?T29ZUGJFK2R1YkNNVWdpZTNIZkFaN25mNytpUGQrcGJzc0huMUNGN0NWV0tx?=
 =?gb2312?B?Zkk0YmhDb1JuTGZZTW9qUEZvVFZDZFVtdU4vVmw5eGN6S0VTMlVBVnlmajVm?=
 =?gb2312?B?bWl0U29XNnE3VFg0YjRuYTZrZHVSeDFSZ1NSWE1CbVMzL09lZHdqcFhyUEFs?=
 =?gb2312?B?YmlaaXFKU2dscVZDZ09UbG82QVovck5oc2hrWFdTOEhicVgrVDI3Z3NFY082?=
 =?gb2312?B?RjlUZ0FQTUV1MnY5MklnYmk4N29JbHJvYUhoVHk3U204WnIrRXQ1UUVLT0hJ?=
 =?gb2312?B?aGczeWRUbXlBMnUrd1FmUjdSRGI0cEFUMHEzQ2dlRGlkejJFMjBnK3RyMHFN?=
 =?gb2312?B?S3VwUWlJNlBYWHdQcGNXSy9MeDdOMThuQkJadzlORTJvYXQrR056RHdocW90?=
 =?gb2312?B?elNZcWZYd3RFRkNwM25BbTJGYzY0UmZBL2xJUXhwTHplU3lvYUV5ZnFDTHZT?=
 =?gb2312?B?aTJTQkU1MlJqbC9yT0p1c1FUTWhBbUV6VDVHMm9oQTRXVGxlK05zTm1zdi9Z?=
 =?gb2312?B?MGRHci9UdlFzUW9sd01mcStwQnRRdmxFbXVvdGJqaklvTURneHFxL0tvTW9C?=
 =?gb2312?Q?Jv47zW9oiPkbdl7dFzK9XKqGO5YutA1QnsQQU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UkVIaGh2ZGZLQUIxV0pNRTFPcjYwTDZ6SG5rV1Y2RW1aYUcvUGtrRWwxU09R?=
 =?gb2312?B?R3dXbjdBaktVOG9NZjRxUFNnUlVGWThpL2hibFdqaEk1Z0RxQXlqemJpait1?=
 =?gb2312?B?cFR1cDROMjgva3lSMlNiUUpwaWhLNXV2aURSeSszYzB5OW9DQzJXRTRZTTQ2?=
 =?gb2312?B?U0dSSzdaZnRKYkpMRm1XYnk1OVB5Q2FOZ0o2TjBuV3crUFBJMkx1aWFWMmYv?=
 =?gb2312?B?UHpMN0tnWklwNGlaWHdjamhhWHM3MU1kOUo3K2pPWEV3Q1lZc3pOOHVqTmhm?=
 =?gb2312?B?UjJxeXRXbzR4VUVuV2lTTEJyczQvRzhlanZ1Y2ZEbXRROXlrQ0xjdUJBdlNw?=
 =?gb2312?B?UHVXL3VEaW8rQlBzMGpjS3pXeFhDQ2wyc0ZRallVNWFqVFpWNTFTMmh1R3dy?=
 =?gb2312?B?Q0FNb25RT2IrR3drM2d3MDJlNGc0UVlDa056aFZ2d0gxclcvLzBPd1ZqWi8y?=
 =?gb2312?B?QVB1cGcvVmJEYmJwMWdHZ1dhWFRoRzlyT3JWalVhYWhrVmI2UW1aR1BrWUFZ?=
 =?gb2312?B?SWJCdDkrcm8rdFcxdjVubTNFWEd2bnd0NVRyT21iMUdVVE1Vd3BGZVd6dFVz?=
 =?gb2312?B?cUV4VWJNaCs3YkdIc0NLUjkvNXJGNFZvTkpUbWJmR2RXcjJUYkFKeFk4SzZW?=
 =?gb2312?B?S2VhQ0J6Y3pUcjdJbVNXVVNYcW5vQWhYV3plVmR0MUsvd2QrWk5uZW1oVkc0?=
 =?gb2312?B?bG8ycGVTRXhpbEgycE1vOHBIUmdzMVdIa2w0NmZTR3JnbitJZDd0aGlpMXR3?=
 =?gb2312?B?ZUY3eVpmWERZWksvd1d5TFU4Y1BoSGc2K1VkMFNJUVljWHdYbGVLZTdOektz?=
 =?gb2312?B?NzZyckJaYjhRT1dkSVpGTWJFNmZyMXpaRXp1ci93VFpMNU5KbnRNYmJlR1F3?=
 =?gb2312?B?SnZ6U0ZLN25FMVZRVGhsQmtLVjhKTGYraDUzZEZDbDI1WEZiNmk4aitEM0c5?=
 =?gb2312?B?d3hwbHJhUlUvVkdlMEloa2FYR1FyeE9Pazh6MVRzcTlwbzZXOUlNdnBaMG9D?=
 =?gb2312?B?UmRvUlo3N3FndWZPZGxqZmNZbVdQTDZqQ2Zsdk5vOUxvNGJIZ0FsMFVDZUlV?=
 =?gb2312?B?OUw2QzhYa0wrb0pLNGx1UFFObytWbCtRSUtxUW5EcVlYb0tGaDB4bXhCblR3?=
 =?gb2312?B?a0IvTGxBYStBbjV5cUZmbWg3UGxpSFc2c2hZeCt2TElkZ2tmcmJhVHhscXds?=
 =?gb2312?B?Ym9TYlFNMmZZV29nQUtUTWRrbUNZckxRbjRzVmdhRWI0emdXSDVMWVVzM3Zx?=
 =?gb2312?B?dDBxZDkzd1hvK2wvanpjZ2ZyMVpvK1YwY2lDVzE2Z0JnUFBRNDBxbnI3YTd4?=
 =?gb2312?B?bmxIb3ZzZWlVYnlQM00xVUVaSk85eEdtRm9hU002UmJCTWhVVXAwUWhRcnc0?=
 =?gb2312?B?QzQ5dXRQQUFQVi9ETE5XRXRFQmxRVHZaU0grak15K0FheEl0cXI5ejNNakRh?=
 =?gb2312?B?R2VFSm4yUi9FbEpwZWgybThocU9HaUc2dTR4NERNbEw0TXpiTTJUWUtpTlo3?=
 =?gb2312?B?L29zNVExbG0xSkhsZVNMUWdybDRsMmZtTmlQZHpXSTBHa2RjcGY2MEorS3Fo?=
 =?gb2312?B?RjdCckdrNW9wdVpBUlllZkpnKyswSTVrMlRzNGwvemR6b0ZySjFiV3lYejc1?=
 =?gb2312?B?bTAwaHloZjlEemVGOExsRWZtR1k5TXJwTGFIKzJFZ2Y3bG1kalVUVHBQRkpZ?=
 =?gb2312?B?eldKZi9BNlJucjBVTXdGcDZ2MFd4WU9NWC9iSnB2SDF4WDJVNkQyejJOSzhs?=
 =?gb2312?B?WE1pUW5ZdEhMWmlWZlRFUDk5OUZWek44TmFERlZKRzVwZ2doYmpaK2NjV0pK?=
 =?gb2312?B?aEhRczI4cmVPVWZ5U2tvaWo1cU9NK2pKYUtTblMvMWNhWmVOOUk3S3R5TStu?=
 =?gb2312?B?TmQ5OVBBUnVUWXpXSU1tc0gydFBCVnBVS3JZWVEraXhpQVg2Q09WYkh2TVlt?=
 =?gb2312?B?TWVmV1hYdlZITjB3Uzdvcy80bTJNWEdKRnlNTGRCOWlYc1AwakdGMFVQdStm?=
 =?gb2312?B?c1pNa3RWWFVpQVB6WUdnVzlkeDNFUXJoVkg3Z2hyUlRXTlhLdERLZ3dCRG9a?=
 =?gb2312?B?NmFQQW5HRmtKTkxTbGRqYU9oa2FvZ29LVXRWS1BmMkZwRGg1dEIzQmhER25q?=
 =?gb2312?Q?9NjPwD5WzZJr5Ccaj8slomcEz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 919764e1-1142-4f40-7d85-08dcb4fa2f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 02:56:20.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNZHHcHAyqtx4tmH3LAuW/EzAh6afkb/LvpqzYCuqwb6Jp0LEViAi5ufkyKw9Ew5w1RxEUqmE7TSSeKJU5fpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9766

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqONTCM8jVIDQ6NDYNCj4gVG86IEhvbmd4aW5nIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2Vy
bmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNC81XSBhdGE6
IGFoY2lfaW14OiBFbmxhcmdlIFJYIHdhdGVyIG1hcmsgZm9yIGkuTVg4UU0NCj4gU0FUQQ0KPiBJ
bXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBGcmksIEF1ZyAwMiwgMjAyNCBhdCAwMjo0Njo1MlBN
ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBUaGUgUlhXTShSeFdhdGVyTWFyaykgc2V0
cyB0aGUgbWluaW11bSBudW1iZXIgb2YgZnJlZSBsb2NhdGlvbiB3aXRoaW4NCj4gPiB0aGUgUlgg
RklGTyBiZWZvcmUgdGhlIHdhdGVybWFyayBpcyBleGNlZWRlZCB3aGljaCBpbiB0dXJuIHdpbGwg
Y2F1c2UNCj4gPiB0aGUgVHJhbnNwb3J0IExheWVyIHRvIGluc3RydWN0IHRoZSBMaW5rIExheWVy
IHRvIHRyYW5zbWl0IEhPTERTIHRvDQo+ID4gdGhlIHRyYW5zbWl0dGluZyBlbmQuDQo+ID4NCj4g
PiBCYXNlZCBvbiB0aGUgZGVmYXVsdCBSWFdNIHZhbHVlIDB4MjAsIFJYIEZJRk8gb3ZlcmZsb3cg
bWlnaHQgYmUNCj4gPiBvYnNlcnZlZCBvbiBpLk1YOFFNIE1FSyBib2FyZCwgd2hlbiBzb21lIEdl
bjMgU0FUQSBkaXNrcyBhcmUgdXNlZC4NCj4gPg0KPiA+IFRoZSBGSUZPIG92ZXJmbG93IHdpbGwg
cmVzdWx0IGluIENSQyBlcnJvciwgaW50ZXJuYWwgZXJyb3IgYW5kDQo+ID4gcHJvdG9jb2wgZXJy
b3IsIHRoZW4gdGhlIFNBVEEgbGluayBpcyBub3Qgc3RhYmxlIGFueW1vcmUuDQo+ID4NCj4gPiBU
byBmaXggdGhpcyBpc3N1ZSwgZW5sYXJnZSBSWCB3YXRlciBtYXJrIHNldHRpbmcgZnJvbSAweDIw
IHRvIDB4MjkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IA0KPiBUaGlzIGlzIGJ1ZyBmaXguIG5lZWQgZml4IHRhZyBhbmQgY2Mg
c3RhYmxlDQpIaSBGcmFuazoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCk5pa2xhcyBzdWdn
ZXN0ZWQgbm90IGFkZCBjYyBzdGFibGUgYW5kIHNvIG9uLg0KSGVyZSBpcyB0aGUgZGlzY3Vzc2lv
bi4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1hcm0ta2VybmVs
L3BhdGNoLzE3MjEwOTk4OTUtMjYwOTgtNC1naXQtc2VuZC1lbWFpbC1ob25neGluZy56aHVAbnhw
LmNvbS8NClNvLCBJIHJlbW92ZWQgdGhlbSBmcm9tIHY0IHNlcmllcy4NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiANCj4gRnJhbmsNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hdGEvYWhj
aV9pbXguYyB8IDEwICsrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9haGNpX2lteC5jIGIvZHJp
dmVycy9hdGEvYWhjaV9pbXguYyBpbmRleA0KPiA+IDRkZDk4MzY4Zjg1NjIuLjYyN2IzNmNjNGI1
YzEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hdGEvYWhjaV9pbXguYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvYXRhL2FoY2lfaW14LmMNCj4gPiBAQCAtNDUsNiArNDUsMTAgQEAgZW51bSB7DQo+ID4g
IAkvKiBDbG9jayBSZXNldCBSZWdpc3RlciAqLw0KPiA+ICAJSU1YX0NMT0NLX1JFU0VUCQkJCT0g
MHg3ZjNmLA0KPiA+ICAJSU1YX0NMT0NLX1JFU0VUX1JFU0VUCQkJPSAxIDw8IDAsDQo+ID4gKwkv
KiBJTVg4UU0gU0FUQSBzcGVjaWZpYyBjb250cm9sIHJlZ2lzdGVycyAqLw0KPiA+ICsJSU1YOFFN
X1NBVEFfQUhDSV9QVEMJCQk9IDB4YzgsDQo+ID4gKwlJTVg4UU1fU0FUQV9BSENJX1BUQ19SWFdN
X01BU0sJCT0gR0VOTUFTSyg2LCAwKSwNCj4gPiArCUlNWDhRTV9TQVRBX0FIQ0lfUFRDX1JYV00J
CT0gMHgyOSwNCj4gPiAgfTsNCj4gPg0KPiA+ICBlbnVtIGFoY2lfaW14X3R5cGUgew0KPiA+IEBA
IC00NjYsNiArNDcwLDEyIEBAIHN0YXRpYyBpbnQgaW14OF9zYXRhX2VuYWJsZShzdHJ1Y3QgYWhj
aV9ob3N0X3ByaXYNCj4gKmhwcml2KQ0KPiA+ICAJcGh5X3Bvd2VyX29mZihpbXhwcml2LT5jYWxp
X3BoeTApOw0KPiA+ICAJcGh5X2V4aXQoaW14cHJpdi0+Y2FsaV9waHkwKTsNCj4gPg0KPiA+ICsJ
LyogUnhXYXRlck1hcmsgc2V0dGluZyAqLw0KPiA+ICsJdmFsID0gcmVhZGwoaHByaXYtPm1taW8g
KyBJTVg4UU1fU0FUQV9BSENJX1BUQyk7DQo+ID4gKwl2YWwgJj0gfklNWDhRTV9TQVRBX0FIQ0lf
UFRDX1JYV01fTUFTSzsNCj4gPiArCXZhbCB8PSBJTVg4UU1fU0FUQV9BSENJX1BUQ19SWFdNOw0K
PiA+ICsJd3JpdGVsKHZhbCwgaHByaXYtPm1taW8gKyBJTVg4UU1fU0FUQV9BSENJX1BUQyk7DQo+
ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZXJyX3NhdGFfcGh5X2V4aXQ6DQo+ID4g
LS0NCj4gPiAyLjM3LjENCj4gPg0K

