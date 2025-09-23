Return-Path: <linux-pci+bounces-36733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710BB946D5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F4480314
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4912E92B4;
	Tue, 23 Sep 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lepPeKWC"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD032701CE;
	Tue, 23 Sep 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605671; cv=fail; b=XB5UuCC6iEB/WchtgqL+Rjnc5pdu9TkWtsTDgX+So7iOtJpjt8E/NmhIY0p90bEXoN+zqyaZjD7x+PjVBX8HDx++/BK0/f6ZX5bjUSEKx7Nid8yaF/QSCxpVEeRGaWhbfI+evtE/W2g18Wt/bU2uT3brBjxoLidhOWVF9rUhMWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605671; c=relaxed/simple;
	bh=avx5dCzGGZDjsth5bkk03O+FqmcqSiZPBWGfCp1WdGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rDCBfZGeiTk6YazXk2iqIwO1UMRHUG0hwcxsMUlP8PZV4irN0JUI3wlHYfBtFb7dJhorKVNnNiKcl3nc7NwfLJrUvPy81le4yO+N2SN2FJp8cFwJ77l6bCB1EtmjM+o1W6kzLVU8hbty4JpofNJG1vlnmK0zbVZaMRHJ1mOBt+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lepPeKWC; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIlj05ri0UzEzaZtDuTy5eNeF0T96bVKXIqlFpWbv+yJaf0uylGwAoxO0bgiyhlMia8EfO/FBKZKYYOiszxFEDJAO/ekZfHkHZcM/2D5yuCfT+PqUpJ1raEct3OLgtd9gUSl/rX+nBKCOTpNBn/nOkX2ywZEG9uHzTN+rjATnb5VPXntPjy8bLNrFA4PUVPSVwzwQDMKd6ayD6sSiindY9qCesUXhzPsKTs4fE/mqmBj0mdKp7uXQ9IZgRsmg0By/Ig5FgQT2WT6OEHvCJY0vvv7do1fxx252P0A00FeKDy9pQKS/uRQn7KOeqFuBNSbFme0YJOocEeto1GI/sLz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avx5dCzGGZDjsth5bkk03O+FqmcqSiZPBWGfCp1WdGs=;
 b=o+jbAKwqEBJNx1XzgDRyn5ZFChHfNL+RBlD2gUnm3A8FxTsyoFcEM4Lnhl2tp8v9nKdjcUpbUBu/+zhs+c34z8Rs48eC8Eax5QOJJSSUaonehOqtjVdZyZXb+wwuB4GNt0M2VbfJxrkht5EBh09bP0Y3KfqJis6b4SoX3X2XdZQHfpRZ++0Bo7+FGRmb2JwirqyzDIicB6NpHNV/uUzxdAnaAp1n/5w4APN1o9vofEGksZig370PCkjzYGVGIEo1R4qzz/bZeZL8HCQSaUNl1wlp6C8D2mQYgnOv1UHYCyfXN0z0pxZTi32U6HldUFAstm68N3wy7w2I19GeH1j9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avx5dCzGGZDjsth5bkk03O+FqmcqSiZPBWGfCp1WdGs=;
 b=lepPeKWC9SdNe1RwanpL75m/eMu9mQy1gKZNZ/OUCWBNZs8/9mk08gLnD2mtIXSoxvM4//PHpAAVmmMQQYyU/WUsudrCrSvq3S3Vaa1hkoQWFyLRRLDsq7bJ1mTAlcHcoMmvSsNUOTTvZv3bofBLs8HwVIetTotYh2N6d+7okfoETCgFwLfmNtxBjHi6l//+xScpAPKlopeoY1z+s2Qq1AnutYYMNgd8HdquFtq6gnS5+lKbV8O3S80//85qAh5pOdpM1t+zCWSiAcB9XRuQqroXaSSa9kt322PwuGsCw5T4sDDtYLLxN/+kWemsOJbUkLt8dM0O2647cDnXXToP8Q==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 05:34:26 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 05:34:26 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference
 clock mode support
Thread-Topic: [PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference
 clock mode support
Thread-Index: AQHcJfRsZEN0Q7UD1ESPyOrVz8KqMLSfZXIAgADig6A=
Date: Tue, 23 Sep 2025 05:34:26 +0000
Message-ID:
 <AS8PR04MB8833EB195D4A06DD7611DA468C1DA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
 <20250915035348.3252353-3-hongxing.zhu@nxp.com>
 <20250922155054.GA38670-robh@kernel.org>
In-Reply-To: <20250922155054.GA38670-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB8740:EE_
x-ms-office365-filtering-correlation-id: 147b7c9e-b379-4df0-2cc1-08ddfa62dc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?M3VGZUFlTEZMdkdRWW9SNTVqWnl6S1dhV1YvL0RVL0RFREFnaWtYdzloRTUr?=
 =?gb2312?B?eTVjN2U4Yit1cWtFQkJpL01NZTcwbWxoc2VCdUEwalJ5MWpJd0RWMVFUOTZV?=
 =?gb2312?B?SUFSSEdneWJnV0tWajQ2cmhhY1pUdDVpN1U4R2RRMlZ3WENNSVozZFNDNE9X?=
 =?gb2312?B?bUJUT0NhaFpheWM5STlLL1EvdVVCcXhELzcwUmdRSWt1L2ZyMWJCRVg2eGZY?=
 =?gb2312?B?VVd3aU5jczl2SzlacHBPQ0xlSWxDTlI5YjVoa1VYck1vZTRWWHovamxVZEZU?=
 =?gb2312?B?U1ZDc2RXRzhIdHJkS1dGQ2srZWN4MURaZldHZE82MTU4bG5Wak9CdG5DaXFK?=
 =?gb2312?B?eWlJUG5JSmQ1MHQ0dzRmWk43ekg5eVB2OG9vdGxvYTk1WUtpT2NsRTB3NzVz?=
 =?gb2312?B?OEJsVjJBT0U5bWU0WVpSQjcwOUxXaDR6OXU3ZVcwNmV2WVc4eVVMN0lZMkd6?=
 =?gb2312?B?dTFraUR1N3dhNjNMS1hoTG1zeUhad3Vpa1dVUUdMOVVkeVFPMko2d1NDTUlJ?=
 =?gb2312?B?M2o0azYrcEJOVmI4MzN5Y2dQdWVDTnR6NFlZR3BTOEtsZ1hEelJkY1ZkOE4z?=
 =?gb2312?B?UUFkSXBUQmViU0Y3MDVld00yUkMxM1FzMFJab1FsdzdvWlY4Q3NKdWU1WWhY?=
 =?gb2312?B?L0Jyb3V6REhKNUdJR1VnMlN3Nnp6RmRMdkdyZEhVQUtRb0JUb1lXUC9OY0k2?=
 =?gb2312?B?c3lsRHMrRnhINTkzZS9QMGlBZzROc0ZsOGZSN1RFU3RleWVzdzliaGxBU1Fa?=
 =?gb2312?B?RXJzMmVJV3dpeWtBOCt6RVVpdzRKWkJIbVJTVWI2VGpSeTVFZDI1UlVWVTdH?=
 =?gb2312?B?Q2k0ZURrWUxGUFJiSDZ2R0RCLzlPbjVqU2NuL3BaRHh4ODhSdVFhY2VwaFlL?=
 =?gb2312?B?YzRMYmVxS25CbVZJS0dQZ0V4eW9TcS9XMFB6eEJ0Q0xDc29kVFE5TytmT3pZ?=
 =?gb2312?B?bEd4VlVzM1BqN080YkVqcmQ5ek1VN1V4OFRsQm9selROMEVhRlVCWS83VGtm?=
 =?gb2312?B?TlVaMzlNbHBuRFNWcG9JM1E1VmVXLzFCVFZRTStnOVFJMlA1VjNkZXpjM1Fi?=
 =?gb2312?B?YStmQ1FyMENkb0V2WXNoRGdPQTV3aGZjUkV5bmVvNXYySHRQK2w3NkpLUWtS?=
 =?gb2312?B?RHBVclBZNWNqeHV3R2t4endFUW0wWWphNGRtcENxNC9mTUdpcDlzdTUrVVNw?=
 =?gb2312?B?WTBBUi9VVitXNnRNTWloRm9adWN6NmZXT1Fsek1wUDdzUDJWRitxcEtPbkJ1?=
 =?gb2312?B?Ympjc0dsMjg0aWxlUWh0YUQxUWFhWlFBRjZoaHFmU3BPTXBBZm92V2lPZlp5?=
 =?gb2312?B?bm13QnB6S0h4VTd1Nmk0dDVER3dpcnlwbi9jZHJvY1hKNTFHdDkrbnlGeUNO?=
 =?gb2312?B?cU56UFFCNnN1NGJ0ZkdpbEFjenlSOU1RZVI1YVNCTWtjUmZNYUhJaFdpRzcw?=
 =?gb2312?B?WkcxYjg0eElscGF2TXpia05xQUJxODdzdGZnc2psOHNaRjRkbGhCUWxnL0Nl?=
 =?gb2312?B?MHVubVJoL0hoY2dCVlR1Y1o3SnRqTGlsQkwxMS9QQXBYclJvMEFyQVRGNHNr?=
 =?gb2312?B?M3kwMkFUSmtWdmRVNTVPUWlhVFFXcW1wYWQwancvdUorai9BaFBtU3p3Zk9z?=
 =?gb2312?B?dStoZU9WZlRaTE9jbVpHaVJkcDRHcWpBcXNBWkdjUW1ZZExLdHJBOXVBMTlq?=
 =?gb2312?B?SlVrVWlGZTgxRWxKUWRYUXFicjVPMHlGbkp6cnAvMGI1Y0EyM0wvQVA2OWVR?=
 =?gb2312?B?VWNiNUZkN1l6MThFR0c4djRZaUZnZ3JGRm0xMlNCelkwVVhhRWx2Q2NWckVO?=
 =?gb2312?B?MGtDeHdFV200bTBRRjhoMWpVTG5Mb1BzR0hVVFRlR0tuWitQM2tiSjJOSGtP?=
 =?gb2312?B?MGZuY1pya1JQNGcySThhRmZvb2VpOHRFSHdlU2VXcDFXbnV0QTROL05UTy9z?=
 =?gb2312?Q?r+ss3iCq/+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bGQvaG5qeHV4TTA5a0xJNWRTTGprMkZTK21FZlU0K0RaVUplQXFzZDFYV1dL?=
 =?gb2312?B?aDJXSXE3VmEvN3doSkZWRnBKbUYzMUtOeGdMK21aOVN6NzU0R2xPdVg4b2hO?=
 =?gb2312?B?Q2ZwTTJPZDlPRnZmNU9ObjQyVXRCL2U3OXB6bUZDOW4vNks1a0lYTyt0TU9E?=
 =?gb2312?B?dmNyemZ5clR0aTVDSU1vbWE2K0RJTmVBOEJjM3VFeGxJeW5yMDVIbmd1NlFF?=
 =?gb2312?B?TkVFbFRSVGpGdE9ldERtb3k5UEtkWDlLZ3dMZ0FLaGFrRDRkS0NoNkd4a2M0?=
 =?gb2312?B?TFVyMlBpN0dub2ZKZnpDTmpZRWMvSmRTM0x5S3dCK0pjWXFFWi8xQ0cvenht?=
 =?gb2312?B?cHBvUFpPWUt6RkxBS053M2FsMTJOT1pyZElLbnNjcTFkK1pvQ3lybjZlZVVo?=
 =?gb2312?B?ZXRTWG1KZks3aXkxdHRmVCtMK0dLYXRrajc2QzZOeEo3MXp5Ym45TUNSS3hi?=
 =?gb2312?B?SjkzMTFmS3pxQk9VdFhVczUrUlNhOGZUTGdOSllYZ1J6anQrTUpOQzEvOXh3?=
 =?gb2312?B?L0FPUDBQbCtGOUpMMWR3RHZjTTFCQnlEa3lCNU1LdWh1djVuSlBWUE1zbVFv?=
 =?gb2312?B?bTFwS0haY3JmM3JLUUROaGd5Tnl2aVlPT3RpZXcwU0dmS0dWc2tHVmozRUla?=
 =?gb2312?B?RUVBemlodytjajNzeWY2STk0c2crYUNnUVg3K1IwMUh0RWwzVmRUeUtmZmVY?=
 =?gb2312?B?c2dKbGM0LzZVcHZ5U1dRRGJEOVVxMm1KaWhCWCtqVWFrMzZJTUp4L1o5M1JK?=
 =?gb2312?B?UUtVQ1BpcExkak1hVlJ4a25jNysvaGR1UEVpTjdMY3N2VHBkSzRVSVA3dCs3?=
 =?gb2312?B?cXYxTEd4ZE9yMlIrR2QvZGxQQTlnQzluWTlvVFd5dTZNNWpQOTMzQ2k5MGM1?=
 =?gb2312?B?cVNlL0hXTHBZRXBRS3g2QzkycXlFZDlFSEgwOFEzUUJxNzJyV3VlMUlUYTFx?=
 =?gb2312?B?TlYrMjQxSEgyRC9RT1I0SHdjczA2bm9zNkJFTDJwZkNuMTlLbXNKVUJ3NGEv?=
 =?gb2312?B?L3cyRm5wSjRneUtyb0t1VjBmTFNTa212WkxoM0JUUTZ2QXY3cXRPN3JLcXo0?=
 =?gb2312?B?LzlGRUlUTmloWkhpMUFrSkhWK2ZQdlRFMXlCUFdSOHRRNVZPWTh4NlpKc3BB?=
 =?gb2312?B?YXJJZ2kwT3MzVW9QU2NHK3Y2NkhGOFZ0L1hsMXNuY1RqeUNVejA2aEhKU09x?=
 =?gb2312?B?REJyQkh2eitBSGRlZ3U3TC9GY2l6YzNoZEQydDFBck5VeHpqMkZHcml2Qmt0?=
 =?gb2312?B?VjhndUxud284eHhxUHRVNit4Y0JZZWNOVndIb01qVERkSm1zTWIxQW0vMUx4?=
 =?gb2312?B?RHg5b2JiT1RRb1ZVT1I4R3d3c0tWZC82bHpmUzZLc2F3Vk9GYVFid1RzRi9x?=
 =?gb2312?B?NjRiL2l0WitKS0pyR1Q0eFAwRm4xMWFZL2hPY2Z4VEIwRzF4NDNxVVcvSlRs?=
 =?gb2312?B?QUlQeXNRQVE5RzIxWmxhbGF2WW9NcFp3UnVpS0E1bnNVTDBBQUJmQjdGRUxL?=
 =?gb2312?B?UTY3YzZ1bGRqakE0NmhvbXVnSGlTZXBpcFMrRDhGWXpua3dybkFSaVJzZVIw?=
 =?gb2312?B?eDE3N3Z5R0daRVlDRmxYaGtTVXpGTGVzbWlkVFE5WWluckFRd0hmNlcyd0lB?=
 =?gb2312?B?M1hCS2dVYkhXdUNtZmpCL1MxQ3kyZGlBY1NiOS9aVFl3aWxpcHllYkVNaEFx?=
 =?gb2312?B?c3NtdDdvWXgzT2g1RUpEWm14ZTA4VjNsNzN4cFl4Z09MblNXR0tiRndXVEZy?=
 =?gb2312?B?TjdBMmU5TkYraFc0TGYrVFlDTmNmM05yL0VhY2E2MERxOUg1Z3pVM1p3WVJq?=
 =?gb2312?B?YnNOYjhXaTFBZE5ndEgyYXNuWVg5WXBFc3NKRFNpZVRYZU0yMC82S1FMemNn?=
 =?gb2312?B?a1d1WDRoUDdtWm9pZkhCbk4xaFdrS3lQQm8yNUZCeGkyWFM4VzRBWlptTEZl?=
 =?gb2312?B?NlhIQ21nekt1Vjg2MlpsenJuYndNZ0NjK3VDWmVmYlRJb1VpaTR0WGtnMUZ3?=
 =?gb2312?B?dGZnc3Uzb1NyUVZ0ZG1NSk43YTVuZWtsUmsrOTN4QTZvblFhRU83T2MrTUxn?=
 =?gb2312?B?b0Z5a0JXSG9OcnBnMkoxUSt0cDRzaTAraW05dHN1RVR1LzZjT3dOZDFIOEh4?=
 =?gb2312?Q?4HDo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147b7c9e-b379-4df0-2cc1-08ddfa62dc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 05:34:26.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouyBeOzel2o6J/jGS06dl7j+USaTUOJ+dkmH8QGMrbc7q3snQYV4PzUi6xTg+vCSGAJxp4ystMr00x8Ze+q9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI1xOo51MIyMsjVIDIzOjUxDQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5j
b20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3
aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3Jn
Ow0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvM10gZHQtYmluZGluZ3M6IHBjaS1pbXg2OiBB
ZGQgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2NrDQo+IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gTW9u
LCBTZXAgMTUsIDIwMjUgYXQgMTE6NTM6NDdBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+
ID4gT24gaS5NWCwgUENJZSBoYXMgdHdvIHJlZmVyZW5jZSBjbG9jayBpbnB1dHM6IG9uZSBmcm9t
IHRoZSBpbnRlcm5hbA0KPiA+IFBMTCBhbmQgb25lIGZyb20gYW4gZXh0ZXJuYWwgY2xvY2sgc291
cmNlLiBPbmx5IG9uZSBuZWVkcyB0byBiZSB1c2VkLA0KPiA+IGRlcGVuZGluZyBvbiB0aGUgYm9h
cmQgZGVzaWduLiBBZGQgdGhlIGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBzb3VyY2UNCj4gPiBm
b3IgcmVmZXJlbmNlIGNsb2NrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsu
TGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlh
bWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbA0KPiA+IGluZGV4IGNhNWYyOTcwZjIxNy4uNmJlNDVhYmU2ZTUyIDEwMDY0NA0K
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+IEBAIC0yMTksNyArMjE5LDEyIEBAIGFsbE9mOg0K
PiA+ICAgICAgICAgICAgICAtIGNvbnN0OiBwY2llX2J1cw0KPiA+ICAgICAgICAgICAgICAtIGNv
bnN0OiBwY2llX3BoeQ0KPiA+ICAgICAgICAgICAgICAtIGNvbnN0OiBwY2llX2F1eA0KPiA+IC0g
ICAgICAgICAgICAtIGNvbnN0OiByZWYNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjog
UENJZSByZWZlcmVuY2UgY2xvY2suDQo+ID4gKyAgICAgICAgICAgICAgb25lT2Y6DQo+ID4gKyAg
ICAgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBUaGUgY29udHJvbGxlciBoYXMgdHdvIHJlZmVy
ZW5jZSBjbG9jaw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGlucHV0cywgaW50ZXJuYWwgc3lz
dGVtIFBMTCBhbmQgZXh0ZXJuYWwgY2xvY2sNCj4gPiArICAgICAgICAgICAgICAgICAgICBzb3Vy
Y2UuIE9ubHkgb25lIG5lZWRzIHRvIGJlIHVzZWQuDQo+ID4gKyAgICAgICAgICAgICAgICAgIGVu
dW06IFtyZWYsIGV4dHJlZl0NCj4gDQo+IFRoaXMgc2VlbXMgd3JvbmcgdG8gbWUuIFRoZXJlJ3Mg
c3RpbGwgb25seSAxIHJlZiBpbnB1dCB0byB0aGUgUENJZSBibG9jay4gSWYgeW91DQo+IGhhZCAx
MCBwb3NzaWJsZSBjaG9pY2VzIGZvciB0aGUgcmVmIGNsb2NrIHNvdXJjZSwgd291bGQgeW91IGFk
ZCAxMCBjbG9jayBuYW1lcw0KPiBoZXJlPyBObyENCj4gDQo+IENhbid0IHlvdSBkZXRlY3Qgd2hh
dCB0aGUgcGFyZW50IGNsb2NrIGlzIGZvciB0aGUgJ3JlZicgY2xvY2s/IGFuZCBjb25maWd1cmUg
dGhlDQo+IEdQUiByZWdpc3RlciBhcHByb3ByaWF0ZWx5LiBPciB0aGF0IG11eCBzaG91bGQgYmUg
bW9kZWxlZCBhcyBhIGNsb2NrIHByb3ZpZGVyLg0KSGkgUm9iOg0KVGhhbmtzIGZvciB5b3VyIGNv
bmNlcm5zLg0KUGVyIHRvIHRoZSBkaXNjdXNzaW9uIGFib3V0IGNsb2NrIHNvdXJjZS4NCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2lteC9hR0ttNDFJJTJGRnNyV044ak5AbGl6aGktUHJlY2lzaW9u
LVRvd2VyLTU4MTAvDQpUaGVyZSBhcmUgdHdvIGNsb2NrIHNvdXJjZXMgb24gaS5NWDk1IFBDSWUu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IFJvYg0K

