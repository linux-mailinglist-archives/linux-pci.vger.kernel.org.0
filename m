Return-Path: <linux-pci+bounces-15385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC069B1438
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 04:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3624C1C2127A
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 02:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283913C9DE;
	Sat, 26 Oct 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JB28qzro"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E97083F;
	Sat, 26 Oct 2024 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729910864; cv=fail; b=SWB0GVaTLJXAX1tEySpyhUPrEWqldUqgB2bWXBld61B6O09Ou+aXeL6prfRINQdDvNaLG//uAbW+rxZPu/EwbAccwQ2oVNcZ4p4XCdUhX/Crms/URqewXuTtovmoHqF0avxjIz7+ovA3pZMp6IrMm1ufe13oIWt4nsF6/K1RKAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729910864; c=relaxed/simple;
	bh=ZDqh3UWj5FzWd4c5aZZuY/LqTXt6jg6P54N/RjYs3WU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rD6IPkdo5slE5Nz7+uXDlHSD4mH/N6vMrsbSt3256pf/F+wF6AGVaMF9Th50orUDQyQRz5zCrcjGUuEG61ojK3zZ3tSiZVwT/V3PgZKONrgXQWUAn5fgfxoPTFS1zo8g3886NrQKPRf7aTtNDVT+sRM5sD9Sh/Rcst+MXqWqDVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JB28qzro; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp8O3EVUv3U+Vn3MwmHx7mqvcnZaORj6u9/A9gm2cbChcxBl/S+j/uCFvGoSjL/Zjd+tijoSWW6t4jn9LvYzxXFQm1uqXkdanMgJYODqt270cCB/ZKIbA+9+w9EWrhlk6aUu7mUW+PffRApTxry9vAfHe78jPGiRyK3kfswkfAcBrPlip78AggqBM4wQKbcYveLh5xutfukfXRQy39BZ6N6Eo4nqYmw/VSyshzTUmjrzb6d/v7PtxQFJx+aZR1ydyBZvraYiJPyI05czB0nk6wVOhS1iY6qTMBHGLuhAZoHKsQoQB3EArrjNcqil76qRp/u3TU4rG22z3hAtWqgiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDqh3UWj5FzWd4c5aZZuY/LqTXt6jg6P54N/RjYs3WU=;
 b=y22NegSBXrcrNx/UXPK4gxcWwwpQrNx3ea7MDSBZNLY3zf8N2D+96eq5i/C6i3u0HdpVBC7No8EdFk0h5/1ADj/dLf66gO75tbVZ08Gc6bgZJffeGrBoaUfqKtCcQHr8vYmhfIlgWVYEV5xn9XM4EibcxfyiXQQ4RdQ9xpWuc0oKI7HSi1abKmgrU/0PyKcfHA4qtmBsJdVdxubv+e3FEMyK4krBZbIcAZzckC+hpAxeshH/nlS5rEy17Ul2uFzUpAwJLolyW6gJScaC5WloAIF5ixbzv2P7hoi27XSEVVqMwa41xBgYzk+gF8Ii5NvtXHSHdGvYUCAceUmEk2xGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDqh3UWj5FzWd4c5aZZuY/LqTXt6jg6P54N/RjYs3WU=;
 b=JB28qzrokjky9l+c1lw0Hrpvq8Olcv9xAg1FTrfv1mLFzwPd9JoBcokrI3l/weUD63uMhTQIUZ+utNHvi5j0LQ7du6HWdFUW0hlBKK9HehC6RN/9ZceAuxr7DRs/tFMKUrMf/M0eeTEB4AQMWlm9Yfdw6GC1heOV1+2Fw41hoJgKAeA3bWlXX1m62/BQcDVg+ElVcjeU1cPP/DjoBk5UeQq8eGQzX/TJQVi0ZKvNCXhksnxr8U2C9RQ5A7Yjnb6vSJWe+ONWc2iluJAd1rkH+Kamd04AufI0+ZVappRr6mFhZKKRtQJYBiKndVKaHwQSEs1bTuOznH9mBLDZCKrlDQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sat, 26 Oct
 2024 02:47:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Sat, 26 Oct 2024
 02:47:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Thread-Topic: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Thread-Index: AQHbJeObq9aJ5gD5VUaSDq26CRIwdrKWF14AgACXuTCAALwLAIAA6W2Q
Date: Sat, 26 Oct 2024 02:47:38 +0000
Message-ID:
 <PAXPR04MB8510D46820B360298AAE130E88482@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-5-wei.fang@nxp.com>
 <20241024162710.ia64w7zchbzn3tji@skbuf>
 <PAXPR04MB851014063D11AC2C668C9B2C884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241025124314.5hmsedlguacbyyjc@skbuf>
In-Reply-To: <20241025124314.5hmsedlguacbyyjc@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10977:EE_
x-ms-office365-filtering-correlation-id: a75b10b4-870c-4a4c-5935-08dcf5688dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?K3BWZTNoQU5vYnI1cDVWd1lpUm05NG16eTBzSk9vN21jdnNXWlZaOXlxWkJG?=
 =?gb2312?B?dHBBVjdQVUtSekxWUmsrUmROY0M5ZjRHVFlXcUt3MUszWHJ0SWVFK3dFcUdx?=
 =?gb2312?B?ZVZSUkhzaC9OeGo0MGNHZHJITktWSFZKa01YbW9FQW91L01rMEdWaUorbFc0?=
 =?gb2312?B?MXlGWU9IZXJLZDVRd3hoOWtqNEJuRzhwcHhtTDNaWk85SFh6V1R3eXlGSzV0?=
 =?gb2312?B?clozNDl2bG5YUytTOXJmUFV4Y0dyMjlhTlNpZFJha1dEdzVVU201MkF3cGRI?=
 =?gb2312?B?cTRuOFdHOWdiVEJiblFodHNpQjlnSUQzVmNMdHlhVGpUVEIweUw1SlhrZm9G?=
 =?gb2312?B?d3pzeFBZVkxvZ2oyNnppeUcyR1hWYzFsb0tiRy9lV1hwb1ZkS0d1WHVBZzlw?=
 =?gb2312?B?UGJlSXlDSmVza3BhbXNyckQzSVY3emdVOWFKRCt1VE1vYS8yYjdKakFnaWxo?=
 =?gb2312?B?dFp1MnJEdDdiNzhCVGZrWXZmZ1hrSzFnRzFTOUJuaFhuVy9iSVIrSmt6T3NQ?=
 =?gb2312?B?K1lsSHNKOXhjb0dyZXUzekxMd2pMS0d4N05wZjE2alRhMytqUldTUlZqNGQw?=
 =?gb2312?B?SWc1T0V4OWpCMlh2MllBanJ0S2pqdkc0MFZhUnRpTWZFVkRjTVR4bkZLSW9U?=
 =?gb2312?B?MTVKUnIvc2owTkhrRVA4TldaY3FNWEtTaDZrZVNGczhEY29RSlRQWmZQbjRK?=
 =?gb2312?B?Q2JLc0pQdWhlOHI4TTAvVGxyV3Y4ZU9Zdk85U01ZdlhvdXZPSEJVYXNFcE54?=
 =?gb2312?B?eTRJZkdZdGpqTVRHb0t2bmpJL05kUDF0KzdYbVBKc2p5MWFKUnU3dHhEeFky?=
 =?gb2312?B?OWpITUw3cFdYWVlZZjVtbklHUjNyZ1FuT1ZFbTcvSnc3R0JSWU8xUzRxYzNP?=
 =?gb2312?B?L2toSW0xNHcyaUVNNGlqSDVzbVE0bGVYUDZLa1pYT3V0dlhOMFdVVXNYdW1G?=
 =?gb2312?B?SUZVZUM2Sk5paG4xWE9SU0hiTUlGc0U3bHl4TVM4eGMySm4yYnNlai9zMVZ6?=
 =?gb2312?B?RWkxSk8wbzRLd2xLdGNhUDZBWFhCZ1AzdDRTcHBybTJpRk5mcDRJVXQ2a1Bh?=
 =?gb2312?B?THZQRy8wZ0tMZkRFVkFkdjlDUXkvdHBIcUEweE5lWUNJcURzMW1PK0RPQk11?=
 =?gb2312?B?UklPYnNWWjVtVUFWcDNDeFA3T3ZJT0RPL2FsVFBISGV5NElsZW9tdEsycm9E?=
 =?gb2312?B?YnY0SVF6TS83Uk0yMlhlNW55S1lnRkdHTnZtS3JLYzJmYzdqTmpDN3o2bDBG?=
 =?gb2312?B?SDJxR0djd3lTSUVUdFpId3djRTltbFpWV1F1NUt4SzdLY3dMZjBUSEJ6d0tt?=
 =?gb2312?B?Rmcxb29KcE9Lbjk1Tjdxb0tkYXNEM0l1a3JmTkMwaHFRTjB2ZnN2RzduRTB0?=
 =?gb2312?B?WVhNYW5xYUZPTThnRHU2RGRBUStyK1hJbVpIVk13Tzdwa3ZmK0E5eGcxenlN?=
 =?gb2312?B?Z2c3UTNKOFdUenR5SHArMHNPcExUUEt4SUh2VkZPcXdXT29meDJ2NThCNGtp?=
 =?gb2312?B?ejZ5azZxR01abFlmclg4T1pRTlpRVk5GTG9JdXJJbGNSK2hvd25wR09wQTZE?=
 =?gb2312?B?M3phVTMzTk0xOVJxRDRRajE2enBsSjhxMitHNlVEckpMQ2EvbzhCNUhHcE5S?=
 =?gb2312?B?K3ZWZkgvVEJDMjVGMFJuTEhnOVNHdFd1UVBHODVoTTdNM1hTclgranJMVHJa?=
 =?gb2312?B?Q2IvK0NlNlFUcHVKMDJiLzZqbVhhWnJZV1JJZlRyb2NESktrWktBRk1RR3g1?=
 =?gb2312?B?ZkxPNzZsVHRBUEg3aWE1STNDY0ZTSnY5VlJHZ3MxbXF5SlIrazRueTlSbXFz?=
 =?gb2312?Q?uLVJf7KKMTkL1Q0OBikEQpMNZzbVdpxfw9dEY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M0pPZ1ovcDhMTVI1SEFOU2thN285dTl3TGZCZEdVRkhIUlQ3a3k1K1ZIWlJY?=
 =?gb2312?B?YjJhSEhyVDhBd0MxSzVkekZJTXV5OVJPT215WmRaOWU2cmJwdEJCRVBsQ2Rv?=
 =?gb2312?B?ZzJMeDdnY0JodXBDbkVsOFlQM25mb3ZPZ2Urd2xGYzdMSU1UUFFVR2c4NEhT?=
 =?gb2312?B?bm04d0NOSG9nRWxEV28yNlBFVzU2c29ScDZndFZZYnNxVWRwTXZLKzc4dWRv?=
 =?gb2312?B?NGhXSHljOWdZRGMzYzEvUitvYkwwbzV4dDhoWEh0STJUZGpFQzNSbzZkUk9i?=
 =?gb2312?B?N0ZKaDZIU1I3aGlNYisxTUZjMjlBeGxxTHpkbGpnbkg5SUowdGNvem1MT0hC?=
 =?gb2312?B?QVVCQmwwaDZFY2RkNnRjMndiS21ibG5pMHZDbWxTMEtyNjUzcWxHVHYxU3hY?=
 =?gb2312?B?U2YzTlhJc3M4b214TTBDSjRoMERiRDA4YVZBeXZkNDdWOEhpa20yQ1hJNEg0?=
 =?gb2312?B?MmtDZzJjOUFQb3N2VTBxdXZ5UHVEQXphNGVweE5jeFJ0NnZJQm9VUytOWTQ1?=
 =?gb2312?B?MjhQYnRQdGVHZTNZamlHTFhYVVdxR3JxYzFQVVdRRHlkbXJERWdYV1VJUzAr?=
 =?gb2312?B?TE5XOEg3UTNUVGVkOCtkVTFaanZxcWltQ0tpV2lXMDlzZWNHYmFuQ0x0cHdL?=
 =?gb2312?B?ZFdJSCtMRnJTa2ZNc2hCREZzL2oxbTBLMHNaMVN6N1I3bkdYcDVRUjJOSDFa?=
 =?gb2312?B?eWk0MURGd1VoVnFGM3ZGNkFJZ2k1WEtIcngrV3J0TStaY29UTjViUnl2VFNo?=
 =?gb2312?B?dmYxVCtyeDFLRTBGUUZVZU9lcHN3VnI0MUlkWVNUUmtiYXFJWGlIeUtXQ1VM?=
 =?gb2312?B?U25ZTUh4MkF4Nm9IOGl5dkNUaEQvZ04xZ3pORk91QW1mblVkWTc3OU16WXdx?=
 =?gb2312?B?ZFBybEJsbWFGaXVyc2U1N2ZBMU5oWXVlMVIwNkI0Z2lYQjQvTXM0a1hwYTFK?=
 =?gb2312?B?TDRQU2hXckhVb1h2RXY1aW1uQ3RFeENEeHNrQy9VWU84bUZmaUhUL2VTU0JE?=
 =?gb2312?B?cm80YzN4OXJHN2lBNkZvUzNFMmZnb3d4TE8rMHZ3SCtTeUJ0WEhxWlpoSzFx?=
 =?gb2312?B?bEpYWklHUmVRVFJmZEZteEJ0bTFtbXVQZXdKcFhnRUxOOTNmK3JONUQzRGcv?=
 =?gb2312?B?SmFIZGJLL2RYazhmb3BlbHNaVHYwZkJPdGhnL1p1WUJhU25YbG8vcjV4VVN5?=
 =?gb2312?B?L1YvOWdMWThJV2VhWUZQOGpKWm8zVUpsM3ZYRkhLdzhyamhJMlpvYVRNMmVs?=
 =?gb2312?B?dFZZaEJYUFVXREdCdXBxWTVkOWdQWGZvVnVTOWRGVEFuZ3lHNzVuYUo2ZlJz?=
 =?gb2312?B?Y3YzcUxOcjZQSS9DQzBhR3RTQmpzb1BadE94RHJUdEt1NkRJS3pzWmlHUUdy?=
 =?gb2312?B?dFp3RWttZ2NBRnVpQWVxRFF5b1NVMlh5a0Y4L2IvSnhnczQ3OU1VTkc0bUk2?=
 =?gb2312?B?QXVhempJSU5zZ2d6S3djRVFLZEo3bzlBaHBUVHd3SXhOWE5QVWJ0bExUN2tN?=
 =?gb2312?B?WGVwV1MyaUswZWZWMUxXUFNUNG1yc0lZOHBBU2Z1WnNOcjlwc1M5bG50Sk9r?=
 =?gb2312?B?cjdBWkVHc215RzRWZDVhV1B4S0JYdWRLZ2F3b0hOeFUvSU1HaUVJamkxVFF6?=
 =?gb2312?B?MkMvaytXeUZ0NThvWWVyRmcvbjZ3VzhxTXdaYlZ1ZFZ1T0gzQWdFaFZnRzdx?=
 =?gb2312?B?dkxLczI5ZkNpbmZLWUQ0eks5RlFTeG5YNm9YQjdacHA4aVJpZ01RYjg2c0pK?=
 =?gb2312?B?K1pUQ1JXRG5rcDhnRGRHaVdad0RWM1JTdlp0ZUFrSGhVNHZqTnU1d2lWRjVJ?=
 =?gb2312?B?MHlabCtVNXNrV3V6Nk0zbmlwTWV3VXB2cXZUbHZCTWd6U0lHTWltdW1Jd1JF?=
 =?gb2312?B?d2VFK2ViMTZtd3ZrK25YS1d3RVdvbndXbkFic0tTZ2NpZDVLRk1uTSs5V3pW?=
 =?gb2312?B?QmVjWlR3MkhhTFJqQlRVczZTQ3BvajE2L1hBQjM4blgvQWhWc3FTVERacnZS?=
 =?gb2312?B?dm4wRWNKdFZEVllxN01OMjIyNnhoSTF0K1RVR3l2d3YwNlVSWDJBRm8xeUtr?=
 =?gb2312?B?K1NxVzNtUHlxTGlOam1CS1hkVXc3bzcrTlhQbDZQTXVaQWtORHF2NUFRbVhS?=
 =?gb2312?Q?5aqk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b10b4-870c-4a4c-5935-08dcf5688dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 02:47:38.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpkKlEnEuH4oy5YcSzVxmDPahgzbQV/vE8d3H1Nson4A/+U/HRYkwz8x6NTMCREvbvn+zxRvT2ncuDpP2lNFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMNTCMjXI1SAyMDo0Mw0KPiBU
bzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0
OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQu
Y29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2Vy
bmVsLm9yZzsgQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBDbGFyayBX
YW5nDQo+IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNv
bT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3JnLnVr
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBob3Jtc0BrZXJuZWwub3JnOyBpbXhAbGlzdHMubGlu
dXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IG5ldC1uZXh0IDA0LzEzXSBuZXQ6IGVuZXRjOiBhZGQgaW5pdGlhbCBuZXRjLWJs
ay1jdHJsDQo+IGRyaXZlciBzdXBwb3J0DQo+IA0KPiBPbiBGcmksIE9jdCAyNSwgMjAyNCBhdCAw
NDo0NDo1MEFNICswMzAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IE9uIFRodSwgT2N0IDI0LCAy
MDI0IGF0IDAyOjUzOjE5UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gQ2FuIFUtQm9v
dCBkZWFsIHdpdGggdGhlIElFUkIvUFJCIGNvbmZpZ3VyYXRpb24/DQo+ID4gPg0KPiA+ID4gRm9y
IExTMTAyOEEsIHRoZSBwbGF0Zm9ybSB3aGljaCBpbml0aWF0ZWQgdGhlIElFUkIgZHJpdmVyICJ0
cmVuZCIsIHRoZQ0KPiBzaXR1YXRpb24NCj4gPiA+IHdhcyBhIGJpdCBtb3JlIGNvbXBsaWNhdGVk
LCBhcyB3ZSByZWFsaXplZCB0aGUgcmVzZXQtdGltZSBkZWZhdWx0cyBhcmVuJ3QNCj4gd2hhdA0K
PiA+ID4gd2UgbmVlZCB2ZXJ5IGxhdGUgaW4gdGhlIHByb2R1Y3QgbGlmZSBjeWNsZSwgd2hlbiBj
dXN0b21lciBib2FyZHMgYWxyZWFkeQ0KPiBoYWQNCj4gPiA+IGJvb3Rsb2FkZXJzIGFuZCB3ZSBk
aWRuJ3Qgd2FudCB0byBjb21wbGljYXRlIHRoZWlyIHByb2Nlc3MgdG8gaGF2ZSB0bw0KPiByZWRl
cGxveQ0KPiA+ID4gaW4gb3JkZXIgdG8gZ2V0IGFjY2VzcyB0byBzdWNoIGEgYmFzaWMgZmVhdHVy
ZSBhcyBmbG93IGNvbnRyb2wuIFRob3VnaCBpZiB3ZQ0KPiBrbmV3DQo+ID4gPiBpdCBmcm9tIGRh
eSBvbmUsIHdlIHdvdWxkIGhhdmUgcHV0IHRoZSBJRVJCIGZpeHVwcyBpbiBVLUJvb3QuDQo+ID4N
Cj4gPiBUaGUgc2l0dWF0aW9uIG9mIGkuTVg5NSBpcyBkaWZmZXJlbnQgZnJvbSBMUzEwMjhBLCBp
Lk1YOTUgbmVlZHMgdG8gc3VwcG9ydA0KPiBzeXN0ZW0NCj4gPiBzdXNwZW5kL3Jlc3VtZSBmZWF0
dXJlLiBJZiB0aGUgaS5NWDk1IGVudGVycyBzdXNwZW5kIG1vZGUsIHRoZSBORVRDIG1heQ0KPiA+
IHBvd2VyIG9mZiAoZGVwZW5kcyBvbiB1c2VyIGNhc2UpLCBzbyBJRVJCIGFuZCBQUkIgd2lsbCBi
ZSByZXNldCwgaW4gdGhpcyBjYXNlLA0KPiB3ZSBuZWVkDQo+ID4gdG8gcmVjb25maWd1cmUgdGhl
IElFUkIgJiBQUkIsIGluY2x1ZGluZyBORVRDTUlYLg0KPiA+DQo+ID4gPiBXaGF0IGlzIHdyaXR0
ZW4gaW4gdGhlIElFUkIgZm9yIE1JSS9QQ1MgcHJvdG9jb2xzIGJ5IGRlZmF1bHQ/IEkgc3VwcG9z
ZQ0KPiB0aGVyZSdzDQo+ID4gPiBzb21lIG90aGVyIG1lY2hhbmlzbSB0byBwcmVpbml0aWFsaXpl
IGl0IHdpdGggZ29vZCB2YWx1ZXM/DQo+ID4NCj4gPiBUaGUgTUlJL1BDUyBwcm90b2NvbHMgYXJl
IHNldCBpbiBORVRDTUlYIG5vdCBJRVJCLCBidXQgdGhlIElFUkIgd2lsbCBnZXQNCj4gdGhlc2UN
Cj4gPiBpbmZvIGZyb20gTkVUQ01JWCwgSSBtZWFuIHRoZSBoYXJkd2FyZSwgbm90IHRoZSBzb2Z0
d2FyZS4gVGhlIGRlZmF1bHQNCj4gdmFsdWVzDQo+ID4gYXJlIGFsbCAwLg0KPiANCj4gSSBhbSBz
aG9ja2VkIHRoYXQgdGhlIE5FVENNSVgvSUVSQiBibG9ja3MgZG9lcyBub3QgaGF2ZSBhIHNlcGFy
YXRlIHBvd2VyDQo+IGRvbWFpbiBmcm9tIHRoZSBFTkVUQywgdG8gYXZvaWQgcG93ZXJpbmcgdGhl
bSBvZmYsIHdoaWNoIGxvc2VzIHRoZSBzZXR0aW5ncy4NCj4gUGxlYXNlIHByb3ZpZGUgdGhpcyBl
eHBsYW5hdGlvbiBpbiB0aGUgb3BlbmluZyBjb21tZW50cyBvZiB0aGlzIGRyaXZlciwgaXQNCj4g
aXMgaXRzIGVudGlyZSAicmFpc29uIGQnqLp0cmUiLg0KDQpIbW0sIGl0J3MgYSBnb29kIGlkZWEs
IEkgY2FuIGFkZCB0aGlzIGFubm90YXRpb24gYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZHJpdmVy
Lg0KQnV0IHRoaXMgaW4gbm90IHRoZSBlbnRpcmUgInJhaXNvbiBkJ6i6dHJlIiwgYmVjYXVzZSB3
ZSBhbHNvIGhvcGUgdG8gYmUgYWJsZSB0bw0KZHluYW1pY2FsbHkgY29uZmlndXJlIGJhc2VkIG9u
IERUUywgd2hpY2ggaXMgbW9yZSBmbGV4aWJsZSB0aGFuIHVuZGVyIHVib290Lg0KRm9yIGV4YW1w
bGUsIFRpbWVyIGJpbmRpbmcgZm9yIEVORVRDIGFuZCBzd2l0Y2ggaWYgdGhlcmUgYXJlIG11bHRp
cGxlIFRpbWVyDQppbnN0YW5jZXMsIHBvcnQgc2VsZWN0aW9uIGlmIHR3byBFTkVUQ3Mgb3Igb25l
IEVORVRDIGFuZCBvbmUgc3dpdGNoIHBvcnQgc2hhcmUNCnRoZSBzYW1lIHBoeXNpY2FsIHBvcnQu
DQoNCg==

