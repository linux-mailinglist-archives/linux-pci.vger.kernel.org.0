Return-Path: <linux-pci+bounces-11661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2AE9511AC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24925285DE3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 01:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4E17997;
	Wed, 14 Aug 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AxOUL0Ba"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF510FA;
	Wed, 14 Aug 2024 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600178; cv=fail; b=mvPfAqUcdYXxBbOui3HKu8U+tA0yAkPkEdEgQ0HS9xLV/0U+5qqX6eTMZ8U7nhTvD/Nfbe+jx0TaNoSflq6y2OynpPJ0o/Nd6xxdX7zXpZbRa1yeO7C5livZLNbGUbY3CKx8DKhiOfHshchBJwd6Tk75igxGvpwoP2fyecBlRrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600178; c=relaxed/simple;
	bh=dOJMuXTZMuBC/xuOAzfqgbfVtAtG9HFzGoBcfvwWuAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0V9jQ3c0RQmZHqix7KvnxNHg+bT33xjkY5p2dol9r/tN118x52o23yBkh0dIzwZxBgjARklHJsYMC45OzCWf8LppRIPmHEtCwQhR/fdbBJ4KpFKVWQQNvz5ILWsztn4yIKaosEV+W8beWxJpO75iywZL6NN/VJB+EIbqcjnp8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AxOUL0Ba; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDaNGQeD4SDOS/YXA2yuMdTN9r4gbNVayVPHnrFArVstM9HrDjPlgtRA3OqJPjTLiUgLWjXAVhlmN4PrRSVncZuihX5jY0VLBN978OUy6+Nw8lObWVhZtpTfAo8B2uzbV9S3YazcGIniiQcPhNd7WpA3wWJHQyTtwZlde2YNtiqFvwIKaUVKCC3fwmcEQAy4Hq6bJyDSyt82uJZo+/tZskIRNRHB6UyB4CmB/L58Ba1qKPqw7PisY/UylzF5Ddjs98QKzTnGMoH9wvOlKugIuUcKLHLHDmSaRgk9w0oGcy4b04F8p1xOl430st7kC1SQpknmRQmBrwWvQo2w9qRdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOJMuXTZMuBC/xuOAzfqgbfVtAtG9HFzGoBcfvwWuAA=;
 b=V5Q82aeAk5on+FE3fa5zl55hn8ncPHkWoy1wkGPew9mH0cU+Pg/0pcYf8W3JwsgOnknDi2tfG8Ns+9pLbBwDLPQ4nAaHYgBJsxHWlXHBkdTyQFfvbeS8hKlhKek9u9LxNfBTQrpZHI5aRI/21fg+7E849xSVfcAUE1WOHvmmgnotL+cXVO6zMKjIzZnvYf/7bSW0h2BQDokS53M9SGoI1hgcusMd90N6AZfSpBEEKGyx0ouqSMJd4XaPI+0T71+F4r7n/21kC7leI+fwJRSKtJVN/NY51VIWxE3iy2pQUYDLutSqtOj+BKAcpKGp710Q/ZTBkCjHgT+X38dQbkHs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOJMuXTZMuBC/xuOAzfqgbfVtAtG9HFzGoBcfvwWuAA=;
 b=AxOUL0BarzaSa4WR+OSs16Mp/z0IdWgptTnOKa2k+s97EspTeM7c8l3uAwmrjLVygUbYATKNKYEd4dl6i4gn66shBHMuOFwaOg/DQbSSwzhPVNxc0yb8oJYybTMoPD3VFRyrkqXKmbUgnmE3aTpbo/V7bJQ4QJhS3xsugieixQaEf3IskwVv4VBBnJ6jg+mfurtvlxIL3JcuFrbpPtX++fmqHNJ73Fu+VoZWFHXhkdQNg72ZgRR9FN1RBN2mBYeZ9Ah8F/5gpHONr+r0PYWp9mbEDbb8f/hAB5sVszK3oLjnNjFefBS0sA4inPJv6s+Y6XPmNEt6ik4MdEU77Lhk4A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB9131.eurprd04.prod.outlook.com (2603:10a6:10:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Wed, 14 Aug
 2024 01:49:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 01:49:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa7VciS0QZKXNjsEqaFNKRvx1ThLIlYjKAgACYuLA=
Date: Wed, 14 Aug 2024 01:49:30 +0000
Message-ID:
 <AS8PR04MB86767916B0539B339120C2218C872@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <172356674865.1170023.6976932909595509588.robh@kernel.org>
In-Reply-To: <172356674865.1170023.6976932909595509588.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB9131:EE_
x-ms-office365-filtering-correlation-id: 595a4db9-be45-46ed-44a1-08dcbc0356ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VzNrTzBHaVZEU3M1cnNKTTA1QVhyZk9xblpZaE1XWFdYb1c3czJEK0l1NCtw?=
 =?gb2312?B?NmhUVkc1citwNWlrNVpTUWxrYmh2Z1VjSi9Yb2N0NXVxeWlEaHpuM2RtaGVa?=
 =?gb2312?B?R1Z2ZGZiUzBqMTk2VkNCYW44T29YbXFpdEZXdExwNXRDNGpwcU5ibmZIV2pL?=
 =?gb2312?B?dmUyNGxjMlNCNmhiWVdsakF5RXFPWnc0NDVMaE4xblllUTV3eHM3bE5mQlQy?=
 =?gb2312?B?Ym1hNHZYc3lmNjAxTlRDYlM0dWxVaHAvQm1wR1U2WFIxS200TEdodTlwOUtq?=
 =?gb2312?B?dVNLNU43SWRoeSs2eDhyZHYzNzFOejVMcWhwckhvTlVrdkV1cVZaMmtqL2tn?=
 =?gb2312?B?ZTJpclBjdWgxZW5jcFV2M0F5TmFBZ29CLzlXQkdzWnJneDFmN3pwNmRVYW5z?=
 =?gb2312?B?WFdqUnU2dTQxa213ME9hQjVIVXp0OC9ISHozSTR3T21sZUVFam85a3NkV1ht?=
 =?gb2312?B?cWpwR2JCM1RnNnF3Y2tIMjhXbHBMSzRlbEhZYmp4MERwRFZkNDZKUEl3Q1RP?=
 =?gb2312?B?azNhWW1QRkwyMkJKZHhoaHlPcU1yZkozVWJuVkpBTWg2Rmt0eUJWRWY2ZWdG?=
 =?gb2312?B?MDVsa28zZVFxVHM5dTVVMVNDNC9xVE1hT09CcHRBVFgzTVdEdGdJaHowRHJK?=
 =?gb2312?B?aThLdGV1c0dtZnluUlRodG45enc4aytUUE5rOHd6N1A1eTR4SE5ZNm96SlFz?=
 =?gb2312?B?Y2MxcldCM1VTb0IrMENtVVREZU9NTzkxM1JNMld5WHR3NkEwTXU4L1oxbEFK?=
 =?gb2312?B?S1pqcUhOU3RxU2VaaXZuTjJiWlRKNlhQOU9nZlpHOS90eXNFRVJnZlFlSFhH?=
 =?gb2312?B?dVg4TXVqTWI0RzZsRWNIZkk4SDNpSE5qanpYbmo5NVF4UnpvTlJYWkNmVWJl?=
 =?gb2312?B?eUVZYVJ0UmgxUzI0MFFIWUd6VnU2b1VSbG9LTDlEdUpFUDdjUlo2bmQ2a1Jk?=
 =?gb2312?B?MVBWT0pRNE1TRWRSZXR6VFh6Zk81R1IyWTR3TjU4L2laVUhybi9vSDVWbHc3?=
 =?gb2312?B?VzlRK2twYzlrTzhRWTN4eXpaOGdQcDJJOC8rSHhzWmlTSUg3a3l1SkFFbXhp?=
 =?gb2312?B?RzhvT3gyNFJXNEt4Q25uSlM5UnVjTG5sQjlyWFE0aElsMmNXbXBNVTM2ZHBq?=
 =?gb2312?B?RkMvN01BcnlZeVFHYkxSdlZ2ZzVxbHVOc0Q4WWdSblpES1JzNHdqOG1yMHFQ?=
 =?gb2312?B?eDJLcEpTSkhRczNOeDEvSDRjajZYN3BSWXZuVjZJSDNIWGt6OENOK1pUVXd5?=
 =?gb2312?B?YXhWaWY2RWEzK1YrZ3hWUU1KRGMxb01jSUtDcVNnb3VmVGxSOFhsSTZkaEhH?=
 =?gb2312?B?STdJcGUybHpyUk9Cb0F5djB2ckYyaEZqMXI5eERoVTJPWjBXR1BvSHBOYkYw?=
 =?gb2312?B?d3RtRFZBUVJIVEpLeFpYOUZXTHVoVjA1VUI4OWRpeG5Dd2dkZW43cGdXNS9W?=
 =?gb2312?B?Nys4ZE9UZzFIVXNFS2ozUWhYclZJeWVuaXdJMERVdFRkalZTc3MwOUtOd2RE?=
 =?gb2312?B?bWFOSENYMjNzS1ZldFlkL1NoaFA3cDQrS1hSL0xpak5QOWFZbnZhQWxndGl2?=
 =?gb2312?B?RSt3MmlHL2EvMUlFMXZ2aVF2aFBHMFdRRU1ROGRoM3lRdk9kcmQremM5MUpQ?=
 =?gb2312?B?eGw4bUNvSk40eEdjc3F3ck1uRWJtYTNDMU5XSmhTcU5qOUV0bzBhY1ZpQ1Jz?=
 =?gb2312?B?bklYOE9DaWtJb1hhcHNnNzJKTFRFOFFSVXJGekZ1NnY5SEpUSlZuMUFCblly?=
 =?gb2312?B?NWNBakNhS045QWpqODJuL0NPK3N2a29TMktRQlFNekpTd3Bvb0RvWW5lcXdj?=
 =?gb2312?B?NW5ENzNIMlU5RjJxLzg5ZW5KaVlGbnJDM1hCSzBPcEpIVkxDR0h0bkxqbTJm?=
 =?gb2312?B?dW13R1NpWUhCRWZ1ZVhZZTNPOHpPSlk3eWFXTmY5NTVCSUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dHdpVUJsaUpOUENIYTRQaWZEZ2xsUHdDSjNsbENhd01JQnZ2dVJzR3AzRFRz?=
 =?gb2312?B?cGFLajd1UkxrZitLZ0drQU5YREE5empUMC8xRTBqSnJQTUJmdndXS2hsQVo4?=
 =?gb2312?B?WEhSdWFxWjFWSEJYVHFYN3VacGIyU1JhQkVxWGwwdENDYTJnZUhhVStYV2xo?=
 =?gb2312?B?VXhWeXdIY2h4dm43NDhKVDdKNGlOelYvTVV3VVd3emtlMEpld1NTemlMc3pk?=
 =?gb2312?B?Wm5EaERiR2ZNbUlCLy9ZWUZwNDJMdmowWEhrNFI1TWFqa2Foc3BPV0JoV3My?=
 =?gb2312?B?V29hMnNyaE0yUHFUTXdYRUNTQzdwRitFeUR0VjExYmFaeGdrMmRmdUE1UzY3?=
 =?gb2312?B?emlFOEtsZm5rWllneWVWU25iZHFDY1BjWmJXTmdZT0FGcFJwOVZsRGJJWGlE?=
 =?gb2312?B?TUNwK2llaUZXVUNvWVpoOE5tVmo5aEs2OE5pRkhnc1VOdUo1TFNFQnByNUJU?=
 =?gb2312?B?M2ZZZE9aK0FlWUlRVlhWQ0RaK3FtRDJUQ0FSUU0vNGpzaUlyRUMzVC9XZVJ1?=
 =?gb2312?B?SC9CZCtmZzFCOFVyMDVsYmJNMnh4bnZxLzNpYytHOHVCZ3B0ekhscjY4VUsz?=
 =?gb2312?B?aDBDc0dMRWxGQUFOcU12N1RzL1ZiZllaWllKdWhHd3dSRnFhMytyR0dLRUhi?=
 =?gb2312?B?VVpqdG5ZTGQxUUh1VHcrSzRXSTB1djd1LzBhWTFBSmtuOE9rZVVsT1VmU2Jk?=
 =?gb2312?B?aytlYVBiY0tqWmMreEJ1ZFgzSWtiYm5yRkxEWnErY1cxZXZXWjFiZldyaTNL?=
 =?gb2312?B?SmYxUTdVWk1ubU5xQTNjRTkxdkZ4SXQxUGM2eFZsNnYwczFTSjBNRXJiZHQ2?=
 =?gb2312?B?SnozSk00dVlpUXlaTWNCZUhTT3pmTnJESW42RHNMNENCNmpjYVlDVk0xelM3?=
 =?gb2312?B?UDhCdE5idUxBSXBpN09UYkYxZlpKMWtsRGpmTkgxSDJHTFpYNUFmMThhM0g4?=
 =?gb2312?B?eUNZUTJZRWxKeDNRdlIzYVNhSUdDbUlFUmRmdTY3R1hiUjV6NFVkSWNMa1hs?=
 =?gb2312?B?Wkd5L1hHRVFObGVTckhjYXpoaDhid3F4MytCWE5HN3pMaE9vc0I1eHVpM2ds?=
 =?gb2312?B?V0xHeVl6Y3NRUXY4aHdpeTl0MldOZWYwSEprdndYWHBKQkU3cjlTZ0hnTTUz?=
 =?gb2312?B?STFnb2NRY29nc25vbVR3ZnpHZCtXUnQ4N1ZnUHlRekgvd0ZBWDdaRDRqZCs5?=
 =?gb2312?B?OW5TcndNSHlDOHM5Uk5Lb0lXSzdQR3hNeVJiZDBMV3RnWVVKcnk0NFRUU0dZ?=
 =?gb2312?B?VnBPVytZS0llYVBVRkVBVHVwb3VWdnFCdTllbGkxM2ROTnhsU1l5WmpDcTAr?=
 =?gb2312?B?bFlZdWJPWFRjalVIbXdiczdrN3huNU9yU0E3SFJmRFZ4S21KdFYyVEJ3a1N5?=
 =?gb2312?B?UU51dEhJK1haeE1ZY0lvZGRXUnNNUUlheHNudVh2b1pXRUVFN0RtU1RJUlZR?=
 =?gb2312?B?VzRYeWRwaTI4cEdmaitkRkZIbmdpbkZtVVM5RzNKUEtadW16bkJaRTYvZ1JD?=
 =?gb2312?B?cG96dm9DQXlrSHptZWQrS0cwRlRRR0ZxQUFMaE01dmkwVlVzSlJacDZILzRX?=
 =?gb2312?B?QytuZldYV1RzRTBmLzhJVDF3SmVucVUwNkkyTFo4WXhWdDFYdzl1K21GbnJX?=
 =?gb2312?B?amlJNGMvYU93eTJQZWFCZlljQ2Q0V29pUkQvL0UrMThVQjFyZlVLekFya1N5?=
 =?gb2312?B?ZUFyYWNsckdFVFptQkw5eDdOZ0cvc0o1T0ZXcWVqU2RCbzZ6NEJGbHNjOGpy?=
 =?gb2312?B?VDk3amlDb0V6c2Q2a1lieEtQRFRkWnVmdEZZMjkyVGwvZWVZQ1kwZ1NMK2Js?=
 =?gb2312?B?WmdiNUZLczJicWlrdTBTRTYxb2llRDVlRzhDbEtwZGU0eGNSWFZObG5QYVdk?=
 =?gb2312?B?MmZnTnFlclo0aFRXOS9UNjBmakNXWENnL2tScWNreE9XMnpHallPdk1zTzl6?=
 =?gb2312?B?eDV1aHVtWXRXUUk1cnVIU3o1OUxXdHV4SkNmTDBrTEtaeEZWai9JK1RtZVNK?=
 =?gb2312?B?L3g4eHl4dXRKUkxuSHpvZjNiTHEwcmZ3YSs2WFJVWDZxV3RlSFl4ZU56T0Zq?=
 =?gb2312?B?S0NYWC9qNm1XYmh5aDNmVDNBa0FOK1FhM0pLcC9VdWxzVTRGMHFzQzBndW43?=
 =?gb2312?Q?k5DHsjZQKJJz7mMzpaeB/NANQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 595a4db9-be45-46ed-44a1-08dcbc0356ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 01:49:30.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQZ3jXlrUMkDuflwqI3AgijvXwPrZGqarG8RKYNOfhUJZ9k7+e5ECUtHM4RCv1iqtiIpn8qhLxyRKVg7r9bJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9131

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8
cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOo41MIxNMjVIDA6MzMNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBjb25vcitkdEBrZXJu
ZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGtyemsr
ZHRAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvNF0gZHQtYmluZGluZ3M6
IGlteDZxLXBjaWU6IEFkZCByZWctbmFtZSAiZGJpMiIgYW5kDQo+ICJhdHUiIGZvciBpLk1YOE0g
UENJZSBFbmRwb2ludA0KPiANCj4gDQo+IE9uIFR1ZSwgMTMgQXVnIDIwMjQgMTU6NDI6MjAgKzA4
MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCByZWctbmFtZTogImRiaTIiLCAiYXR1IiBm
b3IgaS5NWDhNIFBDSWUgRW5kcG9pbnQuDQo+ID4NCj4gPiBGb3IgaS5NWDhNIFBDSWUgRVAsIHRo
ZSBkYmkyIGFuZCBhdHUgYWRkcmVzc2VzIGFyZSBwcmUtZGVmaW5lZCBpbiB0aGUNCj4gPiBkcml2
ZXIuIFRoaXMgbWV0aG9kIGlzIG5vdCBnb29kLg0KPiA+DQo+ID4gSW4gY29tbWl0IGI3ZDY3YzYx
MzBlZSAoIlBDSTogaW14NjogQWRkIGlNWDk1IEVuZHBvaW50IChFUCkgc3VwcG9ydCIpLA0KPiA+
IEZyYW5rIHN1Z2dlc3RzIHRvIGZldGNoIHRoZSBkYmkyIGFuZCBhdHUgZnJvbSBEVCBkaXJlY3Rs
eS4gVGhpcyBjb21taXQNCj4gPiBpcyBwcmVwYXJhdGlvbiB0byBkbyB0aGF0IGZvciBpLk1YOE0g
UENJZSBFUC4NCj4gPg0KPiA+IFRoZXNlIGNoYW5nZXMgd291bGRuJ3QgYnJlYWsgZHJpdmVyIGZ1
bmN0aW9uLiBXaGVuICJkYmkyIiBhbmQgImF0dSINCj4gPiBwcm9wZXJ0aWVzIGFyZSBwcmVzZW50
LCBpLk1YIFBDSWUgZHJpdmVyIHdvdWxkIGZldGNoIHRoZSBhY2NvcmRpbmcNCj4gPiBiYXNlIGFk
ZHJlc3NlcyBmcm9tIERUIGRpcmVjdGx5LiBJZiBvbmx5IHR3byByZWcgcHJvcGVydGllcyBhcmUN
Cj4gPiBwcm92aWRlZCwgaS5NWCBQQ0llIGRyaXZlciB3b3VsZCBmYWxsIGJhY2sgdG8gdGhlIG9s
ZCBtZXRob2QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBj
aWUtZXAueWFtbCAgfCAxMw0KPiA+ICsrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gDQo+IFBsZWFzZSBh
ZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3IHZlcnNpb25zLiBI
b3dldmVyLA0KPiB0aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRvIGFk
ZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+IG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZvciBh
Y2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+IA0KPiBJZiBhIHRhZyB3
YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdl
ZC4NCj4gDQo+IE1pc3NpbmcgdGFnczoNCj4gDQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyAo
QXJtKSA8cm9iaEBrZXJuZWwub3JnPg0KSGkgUm9iOg0KT29wcywgSSdtIHJlYWxseSBzb3JyeSBh
Ym91dCB0aGF0IEkgbWlzc2luZyB0aGlzIHJldmlld2VkLWJ5IHRhZyBpbiB2NSBieQ0KIG15IG1p
c3Rha2UuDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIG5vdGljZSBhbmQga2luZGx5IGhl
bHAuDQoNCkhpIFNoYXduOg0KQ2FuIHlvdSBoZWxwIHRvIHBpY2stdXAgUm9iJ3MgcmV2aWV3ZWQt
YnkgdGFnPw0KVGhhbmtzIGluIGFkdmFuY2VkLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1
DQo+IA0KPiANCg0K

