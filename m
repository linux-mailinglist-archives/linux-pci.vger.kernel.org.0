Return-Path: <linux-pci+bounces-14437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A375999C562
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D861C22988
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3C157A5A;
	Mon, 14 Oct 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFKqvVag"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F1156F3F;
	Mon, 14 Oct 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897240; cv=fail; b=VFN9DuuK9JAfErn2nHdz8QIIIi4bLWD9Gm6/utFDMULmNe0iJSxt8ACw09BPKv+jb1Wl819LXZEkeVxl/enZs2/FJU7YSyxy5Ns5mo6fUQJJLz/PMNmsQZB/4DbRvXErRi6VrDOLiIAr3kj6qiT9W9tMf+QP6vIl4WNNlrkcSaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897240; c=relaxed/simple;
	bh=piJ838p7rfE8QNJZxqHQyj9jj0uIINewc9X5nM3ggcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/pvvnkYTP5Fvq4YZRMpW2LbHhA/omlS9Sb13NA/msns30hvFxoJa60NEx3dodBPjeGzLheUmabCPo0BG3xF7f8tP3/XqXRBFVADQ1pW6TjBTZr4Pxk8WQfblybbGqK9o6R0op20y3DQnwNrK+lHkHQMUsWTRRi6OK2ffEpnQF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFKqvVag; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fReRlFowtdoSNudSzxoY+AHFIRmMiFU/1HelTDRagnhSsrgLZDe0FQl4HQ+wlSWODct+XcPepSVtfnXGxkP0zsyMpIUvyZucim5WCeILe/8gOujtUE4Q8SIPA8mGy5oA08F19Ch54T/X1LdQmUYMUx82+zTP3yjNS4g8DNhFBhcm3Fpq2c9GwHcv14FEMf4HU/XDZqPPnzy7kbdlVYxsSPZAV0CzdHv/OHCQMa7DKXJXDSYbTuANqsYDkjzyiKIbZfMNp6Lms6mgZzk5kDDE+IvqXH6viWcp3bB4hB34f5nnpUi/ZkDXJKY8YwWHPMuX8eQdmWglEnIzjnUowCbQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piJ838p7rfE8QNJZxqHQyj9jj0uIINewc9X5nM3ggcI=;
 b=N/Ekc+RB68TWBxv8jW/G6Wz5sXnSkak7qERw9cu2GyEIR5YUmUCqIsR/VfAMRVLpRZ8hpUYbCMIEPFk3fhw9gMj79ilbkl+lfkPjPIJVMlWnhDc0O4+TUmQvBWvdwJmOlHIad7ZdnR1I40hxF+Aq8sybzIjBbKSPl8l7hktBI8FAYqiJDvm2H/m4XZaX/NvDXWbKp00VH2uypg8qANEgnJ1U7Vz5+FxKmFv7HXktVdkdct79SUTmjBEyFZlp3ln5tIXjuXcNUTAVQvwtJ1225XAqIs07W4fwvylO0ek6W4jWBhEb/9PdBxQmjkOIzOX4YQjXDFkt1MbxOcntlyEnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piJ838p7rfE8QNJZxqHQyj9jj0uIINewc9X5nM3ggcI=;
 b=IFKqvVagr1Aa3HZKmBHEAowiDipqiNUe4lZB2EW61LURxG39wkX5V1e9ytPA+r3m3miO8J77WqRcIINAk0Z3ypEuhVQccfHipmeUj9fUaQkT4ZDw6z0Pn2D7gv0nnKYcBxzowYwURr40X8JKOfOLaefhh1CjjlR4K8M4ZD/IhalwaumQUUNSa0n/lkSbZBR7vc5RlBJGKy9SuAGkJ893++J1hReOfIRLHxGQQn7houIYdkTIpWb/RcU4tVsVdWVaUyfvw3PxwqD3jfAjw/fxWVKacyqko69ygg/qPOa5qaWU/mA/ITio9BFcueazXJEyBdBNJohqk1GZoJ4745Yufw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 09:13:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Mon, 14 Oct 2024
 09:13:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Index: AQHbGjMCRp6WYylLaEyKPUuJKhwhaLKF/FoAgAABjsA=
Date: Mon, 14 Oct 2024 09:13:55 +0000
Message-ID:
 <PAXPR04MB8510F4E7432BA882BA7E623788442@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <20241014090638.GP77519@kernel.org>
In-Reply-To: <20241014090638.GP77519@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7546:EE_
x-ms-office365-filtering-correlation-id: 531e156e-ed09-4500-e3df-08dcec308788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cEVhaHdibGpoNHMxTFpCZFZvK1YvRE1hcytlTk44MW14dXpJdHpZa01zWFNr?=
 =?gb2312?B?QjZaNGpPZUUxaGZuY05ZZllGQ1BuODJVT3RUaVpoTnFSZzdNQm5QUGFQN1Rj?=
 =?gb2312?B?TFBsWnY3NVViRFR4a0JEcDBZTWNoWm1kQW9LRVhSNEpzbU9Mam9JQXdvSFhW?=
 =?gb2312?B?bVhQY3NLR2VKazhod2k0VnUraWJQNlhBMVRhdGFiSzFSMGh0cU5YYk5scG5j?=
 =?gb2312?B?T1BRTjZJQTRlTTlISEhLcnZXTHdjN050SlRVSU1tcG95alB6UDIzOVFMYTU3?=
 =?gb2312?B?RmhVZmltdTcwVXdDTTRTSjZpNVlSamZxYUorRStBUjcza0Z6VS9GanVMQmFU?=
 =?gb2312?B?eFVyRU9FaCtsNTZlL0xnTkR6T2pGeTZHelNxUjA2R25iZTZkMFpVcGNYWEpx?=
 =?gb2312?B?eG5kbnJIUi8xUGVNWmNLL1h3d3QzakdYU3o5MWxMaTd3UGYxMm8ySGh6Y1Y1?=
 =?gb2312?B?cWg2TitkT2RDMUxGMGFFY24zRC9tWWxneGxMV084NXIrVHBSYkRCdllsK285?=
 =?gb2312?B?V1plNTFaVm1oMDR5VnlsZ3BHZG51UG9ZbjBoZ2lnNkNhTkJvOFZtYXNWcmhD?=
 =?gb2312?B?WWJzTTVCSnF1NkZ1ckFXWE40MStmZHBvdmI4UmxCV0ZSaVIvbm05QXhoalQw?=
 =?gb2312?B?QmxVQ0ZpejBKdW52WGdDUDdLWHVJUG9zclBUTkl4ZHdwajRPdDVyRTNBN1RQ?=
 =?gb2312?B?NnNwaUFCRGVIRCs1cHJ6K3VQYW9STHQrWURob21HdmlSclRGUTNEL3FmeHYv?=
 =?gb2312?B?ZTQ2bEd2Z1MxWFFHMU5VMGtmbTRzRjRHVUdVZEhUZXFyWm40Q1p4akhVWXJi?=
 =?gb2312?B?S1krUmRyN3FmVkZNTEFoOGNxZjNzQ01ocER6anJQdFROM0YxemdiMUlCcHNl?=
 =?gb2312?B?ZVNCRzZaL0FneEFzb3ZsV3d3bHpQYnhJbU1uQk5vRFpJMmdQOGxPTUJWV0VS?=
 =?gb2312?B?UUpGYjdQT0gzV0hNaWlXV2swMnZHV3ZOUlpXeGJ5UTJmRHhlWlJRT0FuODlQ?=
 =?gb2312?B?S1ZzNXQxNFFaM2VJZzFKN3hzOTJhcEhhMnpZcGFIQWI4a2dPNCtzWDFPNDNR?=
 =?gb2312?B?MGhDSzNtT0hTZjNDT3ZZUHIydkdZZmVRbDRQdG55M2VrWDl0Tm93eGpzWDQ4?=
 =?gb2312?B?b2wwWWp2TkJyaXA5M0UwYXNFVDYwdUovemlrRkFEUTVrdjV3TmljbVlRb1p4?=
 =?gb2312?B?dzdiZHAvQnFvbVhCY3dMMlNCbG5naTFOTjVMZTFwcVZRR2cvU3pDZkNDdGF2?=
 =?gb2312?B?UGt3ZjliZmxlTVJ4NitTS0xsRjFxaHhhUVEra2hiK1hqeGJUb1dUOFcyZm5n?=
 =?gb2312?B?bWN0NzBlazR3VFFRdVZvZXg1OGM3U1RLeEh5ZnhaUlFYbnhVMG5vZTRhNUFp?=
 =?gb2312?B?OW8yS09KbHZ4aXJYNUJFRFhiNDBQaXFNRXVkcGIybnVhalNIWVpGdXlrUUI4?=
 =?gb2312?B?THZxU2Z6V0l5YzlsRExZV2tuR1QwUGpiRUEyQXBwTTdmbkNhd2cvVjIxR0kr?=
 =?gb2312?B?aHRSMmFJalZHV2FuMTg0aEYrTUFUdWhocEdHcG1vTmc3SXk5QkNOZ3Z4dzhq?=
 =?gb2312?B?RnJDempGdDBXazJGV2hhbGZDUUN3NHFTWitDM0hzTHp0NGJhME5uL2Y0a3py?=
 =?gb2312?B?SDJvblA5eWE5YVp6cFlFTjBaMEdNdCsrQXZXZTRka3orUFpERHM3K1A4ejky?=
 =?gb2312?B?Ryswak85OVh1MkRrbFkwaDBXMTdzYThHSG5wcG5RcVRjbFFySmZPN1F1cnVQ?=
 =?gb2312?B?T3dWbm9KdExkb2VrczltMUdKNzJSTjFqZkNDMGl6WG5JR3VDYlcxNzNPTnB6?=
 =?gb2312?B?TUxEaW9NN0tlcXcvdHB1dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?N3NlNDlPMmIwTk5nWFQ5M1JmMjZiQWZTRXJRSFF5T0FPOWhsMFZoREhjeXFl?=
 =?gb2312?B?MnAzOVdEblpRd3pRRUZSa1RHRXNicXhiK0xkMzdySXBCRUlZTDBIaitYTUQ4?=
 =?gb2312?B?YnNDTi9VMXluK0lEbldFYmNyOFFUS0FnOUZOclc3MVFMV2Q0NWJHQSt0blJH?=
 =?gb2312?B?ZWRocjI1a3dEZlkwK01UZHB3SklydEtuMWlTbEp3a1BJRHlvZ2JUYmliSmd0?=
 =?gb2312?B?T1FZYzIyL2wxMFBnU1dzcXJuelFIYWFZenhHcXdNNkg5VXo2Zm1vc2lHU21C?=
 =?gb2312?B?MXNsYTUzcnJORGx0ZFNWTkRZTllpQjMzNWxKb1BXK1cvakxpbytvV0IvRW9U?=
 =?gb2312?B?TVprbHFGTW44M3V3aS8rMkE2WGw2VXhYZlFIMlg5Q0ZnQjBXTW5yc21sZCtk?=
 =?gb2312?B?QXNLbFFrRVFFdVNzeS9QU2tyYWpIRkxJbnhreTl6MmkvNy9LbWNRa2xsd2pR?=
 =?gb2312?B?OE4ySDNETGxiZXMxaHhlbmwxR0h5eTZRdXF4ek1jSDR2SWVQRmhvbnkyTlY2?=
 =?gb2312?B?R21XL01jZkUyZ0pvemtRenZ1NlppSDR5ckM0VGpBamkzMTJ4Y2ZFOGM0REdV?=
 =?gb2312?B?czNienk2V2piNi9yb0dUOVkreC90TkRBOVl6WlZBTzI4QlMveHl2TFl6NzFh?=
 =?gb2312?B?ZitRbVR2Nk9WaUo2ekc0NWY3akJQSXhCd3dyYTEwMDBhUjhwbmVWeHI3TUUw?=
 =?gb2312?B?QWhTZFc5ZmJhYVYwR0hkOGM2K0FndTFROG9sWnhPbjN0RGtzaHBMcGk4cGVS?=
 =?gb2312?B?aWlJWGVtMmpzaWJsVDNuNXZLR2cwVHpLRmEwZmVEVlZ2ZVJ6QnphK2Y0L2sv?=
 =?gb2312?B?R2pQQkxqY3FzTytmd24yNGZDZzN2VjU4ZTBRQWR0RjhpQXpHUmFaa212ZXBK?=
 =?gb2312?B?L0JPMGl1UWNlY1VIb3M1dUNwcCtxSmVMKysyWTdlVG5PZU9SZFQ0S3dOMk43?=
 =?gb2312?B?dFpxNDVNVC9OV3o5RDVmNUxJVFJ2cnhudnM2TlEvSTdZTi91UkZ5OWdTY2RN?=
 =?gb2312?B?VnpCQXdVeUFjaWpYUENEQnFXSXhUcDhSY3lyeVg2OUxSWEtHVVlUZzFwaElp?=
 =?gb2312?B?bFBxVzZzK0VPZ2M1ckpxM1pCUG9LMEVaajV1cTlBZ2tMNGo1Qng3dlo1QUJo?=
 =?gb2312?B?bmhGU3BXUWo3b2E5UjdKL0ZaVHc5WXFYazVmdW9kN0R0SG1XcGo3SmU2NHdW?=
 =?gb2312?B?ZnhHeEF4NlhXZnNxUkZqWGNCM1ZzWkl5alk4dDNtdlNuSmg2UVFhQnRRMEh5?=
 =?gb2312?B?Q0NvTms5MlhVbzNZUHYrK3YwMWpiczZDbk91S3YyNFZyME5xZ0FhUVo2OVhH?=
 =?gb2312?B?bkZ5UnpUQTc3d3E5Q0dYdm1SSmJBZTRqL0RSd3RsUXh3QlR1eEIzM1huVkND?=
 =?gb2312?B?NHV3SEdyejE3MXNFaHJQUDhNZHhuSWhhNFJNZkxyeGVwK1NxMURSZkRKWXVQ?=
 =?gb2312?B?YUNSYk5Fa3A3VUZVYUZsVGJ0Q0RKVGd1WHRyZmFmWUg1elp5Um54R3hveE1D?=
 =?gb2312?B?ZHdOZEZMMHFMdmlMQSs0QWcvV05iSWpQOGd3aHRNU1Q1Z2xzRDNnNG1EaTNi?=
 =?gb2312?B?L25RTXZ4SnN2bjZNVHF2Vkh5MC9vbHlydmIxUWo2UDQxZjNpMmRuSWJCQ1gr?=
 =?gb2312?B?a1AzQ1JrZmhGYmtVM1E3R2VEQUNkZHRBNjY3N0ZNU2FjNHhhNHBkcGkrSEk1?=
 =?gb2312?B?R21aUTRIQjVmd1BsUFpLZ3Z5WGpBdEZNL3l6UjBLYkdTUWlDdUNQUFJmY1VZ?=
 =?gb2312?B?bmZtZEpSRWs2MjkyZGN3Tk4zeC8rbFZYbzZIb3M3eG1PeVErdllQTUhSc3Zm?=
 =?gb2312?B?L0J1MnUvTFpENThGNGVmRm5mV09Md1lhUEtwLzR5c1U0bWZMNUxnazkxdDVW?=
 =?gb2312?B?eG55UEo0NytJRkI1TVVLUTIzMHh2aWVkL2YvWGdWbmhCczhkL0E4czJLMzNT?=
 =?gb2312?B?eTNxY1I5L250RC9GbGRHOEYvc3NNWDErdEY2L1NzenFMV3d6OEZSQktOemFL?=
 =?gb2312?B?cllTMzdjVUVCUzNGQkh0amJBTGVhWDZRazVZdGNGTUJYaENqQ01GNGhOMkNV?=
 =?gb2312?B?OTE3OE1FU3BkTk50c3BxWXJPTWVvSTdYVUZoK1F5WlpNT0NOMlNrZHRndy92?=
 =?gb2312?Q?+e5E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531e156e-ed09-4500-e3df-08dcec308788
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 09:13:55.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pI+SNR2w8AS0DEISRycqmYXxPGHj6E6/w/5BqawNjieN80L5mwHFkLXCFZ6wJbSHoFSp3E4zD8iWNiB2+QllQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEw1MIxNMjVIDE3OjA3DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IHJvYmhA
a2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBW
bGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhdWRpdQ0KPiBNYW5v
aWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54
cC5jb20+Ow0KPiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGNocmlzdG9waGUubGVyb3lA
Y3Nncm91cC5ldTsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDEw
LzExXSBuZXQ6IGVuZXRjOiBhZGQgcHJlbGltaW5hcnkgc3VwcG9ydCBmb3INCj4gaS5NWDk1IEVO
RVRDIFBGDQo+IA0KPiBPbiBXZWQsIE9jdCAwOSwgMjAyNCBhdCAwNTo1MToxNVBNICswODAwLCBX
ZWkgRmFuZyB3cm90ZToNCj4gPiBUaGUgaS5NWDk1IEVORVRDIGhhcyBiZWVuIHVwZ3JhZGVkIHRv
IHJldmlzaW9uIDQuMSwgd2hpY2ggaXMgdmVyeQ0KPiA+IGRpZmZlcmVudCBmcm9tIHRoZSBMUzEw
MjhBIEVORVRDIChyZXZpc2lvbiAxLjApIGV4Y2VwdCBmb3IgdGhlIFNJDQo+ID4gcGFydC4gVGhl
cmVmb3JlLCB0aGUgZnNsLWVuZXRjIGRyaXZlciBpcyBpbmNvbXBhdGlibGUgd2l0aCBpLk1YOTUN
Cj4gPiBFTkVUQyBQRi4gU28gd2UgZGV2ZWxvcGVkIHRoZSBueHAtZW5ldGM0IGRyaXZlciBmb3Ig
aS5NWDk1IEVORVRDDQo+ID4gUEYsIGFuZCB0aGlzIGRyaXZlciB3aWxsIGJlIHVzZWQgdG8gc3Vw
cG9ydCB0aGUgRU5FVEMgUEYgd2l0aCBtYWpvcg0KPiA+IHJldmlzaW9uIDQgaW4gdGhlIGZ1dHVy
ZS4NCj4gPg0KPiA+IEN1cnJlbnRseSwgdGhlIG54cC1lbmV0YzQgZHJpdmVyIG9ubHkgc3VwcG9y
dHMgYmFzaWMgdHJhbnNtaXNzaW9uDQo+ID4gZmVhdHVyZSBmb3IgaS5NWDk1IEVORVRDIFBGLCB0
aGUgbW9yZSBiYXNpYyBhbmQgYWR2YW5jZWQgZmVhdHVyZXMNCj4gPiB3aWxsIGJlIGFkZGVkIGlu
IHRoZSBzdWJzZXF1ZW50IHBhdGNoZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjNF9wZi5jDQo+IGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjNF9wZi5jDQo+IA0KPiAuLi4NCj4g
DQo+ID4gK3N0YXRpYyB2b2lkIGVuZXRjNF9wZl9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBlbmV0Y19zaSAqc2k7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNf
cGYgKnBmOw0KPiA+ICsNCj4gPiArCXNpID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsJ
cGYgPSBlbmV0Y19zaV9wcml2KHNpKTsNCj4gDQo+IEhpIFdlaSBGYW5nLA0KPiANCj4gcGYgaXMg
c2V0IGJ1dCBvdGhlcndpc2UgdW51c2VkIGluIHRoaXMgZnVuY3Rpb24uICBTbyBJIHRoaW5rIHRo
YXQgaXQsIGFuZA0KPiB0aGUgY2FsbCB0byBlbmV0Y19zaV9wcml2KCkgc2hvdWxkIHByb2JhYmx5
IGJlIHJlbW92ZWQuIFRoZXkgY2FuIGJlIGFkZGVkDQo+IGJhY2sgaWYgYW5kIHdoZW4gdGhleSBh
cmUgbmVlZGVkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4NCg0KVGhhbmtzIHZlcnkgbXVjaCwg
SSBmb3Jnb3QgdG8gcmVtb3ZlIGl0IHdoZW4gSSBjb3BpZWQgZnJvbSBsb2NhbCBicmFuY2guIDoo
DQoNCj4gPiArDQo+ID4gKwllbmV0YzRfcGZfbmV0ZGV2X2Rlc3Ryb3koc2kpOw0KPiA+ICsJZW5l
dGNfcGNpX3JlbW92ZShwZGV2KTsNCj4gPiArfQ0KPiANCj4gLi4uDQo=

