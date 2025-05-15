Return-Path: <linux-pci+bounces-27771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBDBAB7E00
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 08:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE383AF491
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD809296D35;
	Thu, 15 May 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1RfYQkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F411CFBC;
	Thu, 15 May 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290602; cv=fail; b=iaESoRmVyt1O4mLCe1uv85ZRJsQySYyzNLW1WRD7o5fW1Df6QSz9YZvtTyGU2jQrFH03PLmMB4ptEmRYgpK+WJNlIISiWHb388/VW8elOlxpJt6yCiTKUKNu8zxUAmYHJmwAIffGdVijl71GBLgn7CIGtV3Zyo6Nbm6lh8o6ZYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290602; c=relaxed/simple;
	bh=Z/X5cyUxO1MbOB46FNDzAoIPiGK1MUCesASLFfXFB/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4wkmEo2jRhoWjVFksUg2tNwbl8o9r7/smA0z5FNosD02dTeuRo/U2QCL06KCPvouyY2qIz3LEuvm/DWUFjxR3wPNVC8vovMabcyIPiuaRMBMgNv16bqYMW4jZyAX9UE1N4CuuyXGfcpVOGSZL6T5ll+N6XbgvmbDyZETu1k/aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1RfYQkM; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+/MmsFcvVXkyhnK62HsOcSmitCzvTxyGZuKl3uyXsPznl4zK4Tv+i8M47ZeXDCVu6x5bfxI58HFpBzkmDosb2P0bar0MzXqtVZtg5uZ3Ir/NshQ2obgvFo6634tdMaHu9XoI/4c4q/tVcEIi4rjI8BxgXv7hIuihiPRIwR9UtcOj+ZG9h3QvkB0BUqkYuwNorHn923gnvFrQwBa+5GT/UNM5OEUmNOkhdAhrm4saVZFQW7+bU5aLTC7PJEQCTjcrS0XViN72Q+cCkoOuXW2LxD3razBqHkazPHJD8OKOhevTaNq8H7/osC0dg1PPSWRoPxOHNlM+n6Om324LNASDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/X5cyUxO1MbOB46FNDzAoIPiGK1MUCesASLFfXFB/4=;
 b=ZKiPBPEx7NU/KViB489Y8RxNa+Bo7scKcXSdEWhYgVzn4/6LTVJhdpHT6GPrg+vn2NmyKFXuDo6QDzQxf3/vje01QTmvLCmqtWODfBd1HrVVxDJqF0FbDU96uSjysbXmnfzhyUdHEANAgCPB6MEaQGJvZjzlha8++oLqc5JJtcLL+l9o8gFonjiWrYNaLSMvpuexvmAMgodFOw+WRtj3jd1PwSwbq6vZijqQSGRPTCx4ER2mD1BwffU1DcRJJF1xBhPiroQwvQAqTyeUwpLqLHmhElNuJJRKioVuNFjsYLPPLjD9o3LA4FsqIR9X3FQXM96z3S5XK7k+HoGv8NwuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/X5cyUxO1MbOB46FNDzAoIPiGK1MUCesASLFfXFB/4=;
 b=M1RfYQkM0gQ5jfB4R76Wm4tXOAvvfPNsIqMpUOXUXkhyyxAxmMSnRzBtTA3YYlStATklHnANrqv494KBOV+0+E6DEp3UU1//vHvW0NsTFTxfZbFkMT/m9t3Bux08Wf8C0F7XHGAFIGetHT2TkuYfwcQziyA8aUVp5KwZqhIc9eIaW+q/vofTM8GzRyN1UjlTldNiHRiQVLp6Yr6l6gaJoyXDhQSJrPqvJyuRSSunhOj9VH4T2ehTrP1feEDhE4x5V8+bLiogsVe7Wp+JkXrAZiSYpP89Ns6RRjaUo1fGxCM6iXAMhEZh9ui0FQvOjtRcJVFa0Lwlkb5/uvbwqQlhCA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI0PR04MB10094.eurprd04.prod.outlook.com (2603:10a6:800:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 06:29:54 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%3]) with mapi id 15.20.8722.018; Thu, 15 May 2025
 06:29:54 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "quic_vbadigan@quicinc.com"
	<quic_vbadigan@quicinc.com>, "quic_mrana@quicinc.com"
	<quic_mrana@quicinc.com>, "cros-qcom-dts-watchers@chromium.org"
	<cros-qcom-dts-watchers@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: RE: [PATCH v2 2/2] PCI: Add support for PCIe wake interrupt
Thread-Topic: [PATCH v2 2/2] PCI: Add support for PCIe wake interrupt
Thread-Index: AQHbwLhjP/g2+AIT2k6Gwpi8K34d87PTOJHQ
Date: Thu, 15 May 2025 06:29:54 +0000
Message-ID:
 <DB9PR04MB8429A141EB4E88CF53355D879290A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
 <20250419-wake_irq_support-v2-2-06baed9a87a1@oss.qualcomm.com>
 <a8e58612-c6f5-8b61-af35-2c2897ad7827@oss.qualcomm.com>
In-Reply-To: <a8e58612-c6f5-8b61-af35-2c2897ad7827@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI0PR04MB10094:EE_
x-ms-office365-filtering-correlation-id: a229498d-92cf-4785-a22c-08dd9379e7bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXpNQTkxTjZORGVGbmZtbC9pY0JjSDF6SkdKMnp3YUZQVXZTQ1FhRGxWN0pB?=
 =?utf-8?B?MDlpTCtaVjk1anR1b3BJbEFwWStldWNYZEEwck9qTFkyVnYwMUVjcmh6eCs0?=
 =?utf-8?B?Y0krVUtHd3Awc3g5U0lNMERqcWY3UTRiamRaNy9sL2JUaUcySFBPSXBhQTdy?=
 =?utf-8?B?UTllSWhpY2NXVzVkN09BMFVuVUZIUDlrR1FZT0JYeGMwREdhUFBmVUZ3VlNT?=
 =?utf-8?B?QVNqcmc0R0hpMy8yS2s3S3RYSVNjVGRtbFJDazNEd0Q1OUJNeHZNMG1YakVo?=
 =?utf-8?B?bVZScWZ5V1Q3ZEVoc3pUT0NxaUovTWlFa1ZrSGszM3hQUllUbUJWMlJTV0V5?=
 =?utf-8?B?SVNoT2owakF1R1p0NWtyTEZ1aHorTkRWVk92ZlVOanQyczFjRjF0ZzNwR1dV?=
 =?utf-8?B?RVBNK3JuMVdHTkJVbVI2QW9sWWVCYWhra080M0VpT3Qzb2NianpqNUZYczEy?=
 =?utf-8?B?MW9vTkZieEc1UG56MkIvLytGUUUxYlZEQkJqdXdWZi9qS0FMSEo5a1dZeDRR?=
 =?utf-8?B?eEQwRm9pWWYxRWlSWmI5ekl4eHRKVGM5Rk1qOXlHWHhiM1JseURNMllLK0VI?=
 =?utf-8?B?TmNibmNNZ0lIaVFpZ2p3eW1WNlBsRGlDUTJSYUl0bCs2RXhsM3djdlhSV2Rx?=
 =?utf-8?B?UkJtK3lqTlVrV3FQWUFDb2p3bFg4WUhYN2dINWZsZFl2NDZOVmgwQ0VtcFFl?=
 =?utf-8?B?bnVuekhvMFg3eDJveEdydC9qV0VndzhXd0hpSE1XcmF6dFhXNWhjZzEzYzlE?=
 =?utf-8?B?KytaSi9iTkxadC9EVGdSeERxNnlUVHorVDJMeHRPRnB3UmM1TzZ6YXdlaXJs?=
 =?utf-8?B?ZGlSRGpqdmRxQTYwL3YvcnU2N1hTOTI4MWR2RUxPQVJHU2twTGRqYVh1ZnA1?=
 =?utf-8?B?S2Nzb0xSMVNGelRFaFBBcXhWVHBwam1qOEZZM3dBK1VQQXhJd2NhLy9JR2dx?=
 =?utf-8?B?QmswVUhRRkxwNW5yM04yeVFKNDZFZUZhWGYxejFKN3R0ZDNOU1VCeXQzaWNC?=
 =?utf-8?B?K1RDZXhpMjFoZTluQVViUlZHSUhVa3p5K3ZtSzBjTCtRQjFEUk5acTUxbVJJ?=
 =?utf-8?B?U3RyQmhEeEJLNTRZTG50NHFxbDlZMS9MQmpJZm9QUTExQm1DS2pxNFFjOThJ?=
 =?utf-8?B?YlIxeG5hSU1aZ1NLUDdod1V2QTd3V2l2akVRdlpEWFBlNmE5VlFldCtubDF1?=
 =?utf-8?B?L1BsZWNueEtGZTBnbzV2Vkp5NUdiZGxTemYrVUw2cmpCaWFkcTdWMHZoUFEr?=
 =?utf-8?B?N3VlazBZRVJhbTB3Q013b1lUeHJrT0t4SlltTU5tckVVOXVGMWFKaUZPMUlI?=
 =?utf-8?B?dUhzeGdyQ1l6WmFTbVkvZHhDTEc2eVU4MHBJbHQwS1kwbDRKR2tSWlI1QW5P?=
 =?utf-8?B?dVJ1UTJLTGNoL2Y3b0RSek82SEdYdThzUXVwODljS21aZTd2aU1sVmN4KzVJ?=
 =?utf-8?B?ekwxS3FYRDBROWJqcVNiSkwvZU9rQ3BOc3U5STJqb2hvWnJTWUp1cnNicmda?=
 =?utf-8?B?cStmSDdlVCt5Rms0SWdaVXEyd1pEazhEZGdDU0VWcmxhYnM4QzlQZ2Z0Mmhu?=
 =?utf-8?B?YUNOVHBpeHU4WmJMVkN0NzFJUlQzdjF1eU1QcnJuMGg0d0ZNbFFiZnExZmpG?=
 =?utf-8?B?Tk5kc2YrTWVxNHIvOEt6ZjM5UVUxT3BtQ2p2UUNVNHJhcEV6UU1WMktES3Fo?=
 =?utf-8?B?dFdFUHZVNXBmRkIrMzlkajdYek5XSm9nZjVXQjRSdThEOWxJS0JvQldyU1hn?=
 =?utf-8?B?NDVPMTZzR28wbmpabkdRdnU3VmlpTEVPS0gxUFo2TGRld3JzSWNrUHpTeU5q?=
 =?utf-8?B?cDd6cHlIcWpVNHBrTEx5UmJLMzA1cGQ5MXNiNkRGZERKdVNEcUhuV3FaemRD?=
 =?utf-8?B?S0IrZ0l5ZmdCN0Rnd0ZEeDlLVlpjK1d5YmVUM3ExV1BBakljbjZSZU9lakI4?=
 =?utf-8?B?YXJWdSsraFc2SDNIQm04S0VHcW4yOGZKT1FqOXRvODAvNjFPK1g1eU04WWNn?=
 =?utf-8?Q?9+FrrbLl3vGCGCLCjf3ptLncM0uYno=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?citkV0FoQS9STHNSUmlqck53b2k4emQ4TFlBN240b29ESlVpNXZHT1RGNXFv?=
 =?utf-8?B?cUdSTUtVeTYzKzE2dUxkM2FTbVB5V2VHeUtheElscEFSRm9YaUprZS96TGhV?=
 =?utf-8?B?MWNiLy9tY1U3eUJHQTAvWXo4WEg3bVR6RUY4QjB4WFBXSHZYVlFKbkpDSVVC?=
 =?utf-8?B?dTNlaDRkM2QzeG15a0F5WnIxeDgzanNjUHRjbUVLbkszVkR0U0Jwb2pIMVpE?=
 =?utf-8?B?RTM1Q3loSW1TaUZqa1VnbHMrNCtjb00wQ2JIWDhMR21pYXh3eHRjZXhXVWJO?=
 =?utf-8?B?UHR3R0M2MnFKaXVmTmh1RVpFQzFpeml0V1E5UU84YmswdldRMERYb05OcTVD?=
 =?utf-8?B?RGl0QTFYRmhlMkkwcTFxZ0EzMXFjNDR5aGFOYlB4cEVwOHo0b1ZiRzhqb2xn?=
 =?utf-8?B?UTdiZktyVlNyaTE2cVlVbm5sVkNsRnpBWnVMbGZjSkNGYXhSUHNYajlnbnJS?=
 =?utf-8?B?b3J1MmhEUUF6KzZKWlpBLzNMKysrK2pTNWJQV0JEL0tGd3BiWVhzS2hjOVFi?=
 =?utf-8?B?c3REdW5zMFc3enVNMTFiQnlGYW9YL1V0VngyVUJVR3ZMVnJvem1rTm9GNWM3?=
 =?utf-8?B?TXplcThrYlNxL1c3RU5ONmZjclNuR1BCd2JGWVR2MzdZeXdacDMwSUgyK1ZV?=
 =?utf-8?B?OFRRRG00VkY4M3YyWTVaMTBPZjRpTHppUk1kZ3VuOE5wbjVUM0phUGcybDVF?=
 =?utf-8?B?RE1pemRHRTNXL3Rxbm5tWWF3di9ETEpFN2Q5UkU1dDlqZGpzUG9oTllMSlh3?=
 =?utf-8?B?UDBrSjc5ZzFQNStMSGpiaUtrNVlQYkpETEJJUmIwUi9tREQ5SkpGdUVDVEFB?=
 =?utf-8?B?TlorR1p5Zk1IeGtmZXBXOWgrZENtclV5TVoyWTVyQ3dkTFhlbFVFV3U2MFZn?=
 =?utf-8?B?Ri9KeG9kWUIwYlBUck5zUjhNNzZvWGVRT0FRK1Y4cEVXRlB4MVdhSGZrNnBu?=
 =?utf-8?B?bmU2V2dnSlNkQWxKRFJsUWhrWGx4ckhybjdjdXhwNVl1OHdjS0NYK2ZoZE9D?=
 =?utf-8?B?eDB5MENkSzNQa1UyNXNjRFBLcHI1eUdXdEVqdmcyVjRFOHMvL2xIdUlJSlc1?=
 =?utf-8?B?UDMxYm84QmtBOWllY1pXaE95bFd2eGV3T0RXWGhKSzdwM2FZdXE3ZG1jWE94?=
 =?utf-8?B?WU1nWGN6Sll5SG9RWG5aSjFhM0w4TlZYRVdaUGp1cEpjUGRRMmxHeDR1WFIw?=
 =?utf-8?B?QndITVhFdCt2MmJPWmUrcXZocytHQ1pDOU9ieFBQVm42Q2VEM0lQWGZrWjh4?=
 =?utf-8?B?a2ZkdFliMWpvUHgvamFoQVNhaWNIOWJhMkV2US9LY1dzdUlXOGpiU3pQTFBm?=
 =?utf-8?B?Wk02bGk4Wm1MWXJWUVlGZFhqb3ptQS9JRk55UENEdWQ3LytqMDhjeEpoTmw2?=
 =?utf-8?B?bi9xL0IzMjFHalNhZlJKWSt2Rmx4aEU1QUhLT0o5THFyZUhtVzNnYVh3dVlv?=
 =?utf-8?B?c0k2U25LMDVYM0NocjA5U0tSblQ2cGZJMWRkeGZ3alRqekJ1Q0dlNkdJR0Yr?=
 =?utf-8?B?c3JDRy9QWm9aOXYrS05mbDdPTHBEQlBmQktZWWtjcWRmUEdOU0dGVkI5TW0v?=
 =?utf-8?B?RnVnNDdGVVgxaHdPdWlwUCtkbDFWTlcvS1RkcEpBalFHUG94MnR1T0pMdHMr?=
 =?utf-8?B?dlFiTkZpckxCdDhPZVhLMDgwbWZ2cHIvNzBCVGJTdTgzcnFuVHU1Z0sxci8v?=
 =?utf-8?B?bFdGbUVHck9jMURyekhZbFl0YmUyemJsUWxBakxQakhTeWRCTExsTlNVRHJo?=
 =?utf-8?B?R1NPWEM3U0hHeDB5U1ltWlg2cE5OSnVqTDQ2SjliYzVYT0piSm91bm9rZnZo?=
 =?utf-8?B?RFNjbGwzdUxDREdIYnlpeVVYQlB3YjZaVVlYcGNVMjcwNmZQOGUrd21DWEhP?=
 =?utf-8?B?OWt0Q1pDR2F5VFY2YTV0RE9TMWFqSlRwT0dkazFwcy9yaW1uMlEyUVlwN0tw?=
 =?utf-8?B?anRSMFRaUkN0TDNkVFVTYWV3NDZjcWJWM08xZ3JSS3JCRTJtMmpoS0x2dyt0?=
 =?utf-8?B?aHEraG8rYkJnbWdTMllObkl3SXg4YWhBZnVBNldVTTVnaHdLNWpJY1lmMktV?=
 =?utf-8?B?M2RkR3lYQ1JzblVjUE1VMXA5M0hmYVJsS3RnejRhQXNvSXlKeitjcnErQXVP?=
 =?utf-8?Q?NIHk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a229498d-92cf-4785-a22c-08dd9379e7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 06:29:54.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2906M2bFsHtBasiMksrm7bd52yq2D6+yc6q7MhwohC5IbfPS+weLZ9OphIdgjC6omKNHj+YwSTzqP1dj2LxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3Jpc2huYSBDaGFpdGFu
eWEgQ2h1bmRydSA8a3Jpc2huYS5jaHVuZHJ1QG9zcy5xdWFsY29tbS5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgTWF5IDksIDIwMjUgMzo1OSBQTQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBLb25yYWQg
RHliY2lvDQo+IDxrb25yYWR5YmNpb0BrZXJuZWwub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiBxdWljX3ZiYWRpZ2FuQHF1aWNpbmMuY29tOyBxdWljX21yYW5hQHF1aWNp
bmMuY29tOyBjcm9zLXFjb20tZHRzLQ0KPiB3YXRjaGVyc0BjaHJvbWl1bS5vcmc7IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5v
cmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBCam9ybg0KPiBB
bmRlcnNzb24gPGFuZGVyc3NvbkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDIvMl0gUENJOiBBZGQgc3VwcG9ydCBmb3IgUENJZSB3YWtlIGludGVycnVwdA0KPiANCj4gQSBH
ZW50bGUgcmVtYWluZGVyLg0KPiANCj4gLSBLcmlzaG5hIENoYWl0YW55YS4NCj4gDQo+IE9uIDQv
MTkvMjAyNSAxMToxMyBBTSwgS3Jpc2huYSBDaGFpdGFueWEgQ2h1bmRydSB3cm90ZToNCj4gPiBQ
Q0llIHdha2UgaW50ZXJydXB0IGlzIG5lZWRlZCBmb3IgYnJpbmdpbmcgYmFjayBQQ0llIGRldmlj
ZSBzdGF0ZSBmcm9tDQo+ID4gRDNjb2xkIHRvIEQwLg0KPiA+DQo+ID4gSW1wbGVtZW50IG5ldyBm
dW5jdGlvbnMsIG9mX3BjaV9zZXR1cF93YWtlX2lycSgpIGFuZA0KPiA+IG9mX3BjaV90ZWFyZG93
bl93YWtlX2lycSgpLCB0byBtYW5hZ2Ugd2FrZSBpbnRlcnJ1cHRzIGZvciBQQ0kgZGV2aWNlcw0K
PiA+IHVzaW5nIHRoZSBEZXZpY2UgVHJlZS4NCj4gPg0KPiA+ICBGcm9tIHRoZSBwb3J0IGJ1cyBk
cml2ZXIgY2FsbCB0aGVzZSBmdW5jdGlvbnMgdG8gZW5hYmxlIHdha2Ugc3VwcG9ydA0KPiA+IGZv
ciBicmlkZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBDaGFpdGFueWEgQ2h1
bmRydQ0KPiA+IDxrcmlzaG5hLmNodW5kcnVAb3NzLnF1YWxjb21tLmNvbT4NCg0KSGkgS3Jpc2hu
YSwNCg0KSSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2ggc2V0IG9uIGkuTVggcGxhdGZvcm1zLCBpdCB3
b3Jrcy4NCnlvdSBjYW4gYWRkIG15IFRlc3RlZC1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBu
eHAuY29tPi4NCg0KQlRXLCBhcyBQRVdBS0UgaXMgYSBzdGFuZGFyZCBmZWF0dXJlIGluIFBDSWUg
YnVzIHNwZWNpZmljYXRpb24sDQpTdXBwb3NlIHlvdSBtYXkgbmVlZCB0byBhZGQgd2FrZS1ncGlv
cyBwcm9wZXJ0eSBpbnRvIHRoZSBjb21tb24NClBDSSByb290IHBvcnQgZHQtc2NoZW1hLg0KDQpC
ZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3BjaS9vZi5jICAg
ICAgICAgICB8IDYwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIGRyaXZlcnMvcGNpL3BjaS5oICAgICAgICAgIHwgIDYgKysrKysNCj4gPiAg
IGRyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jIHwgMTIgKysrKysrKysrLQ0KPiA+ICAgMyBmaWxl
cyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvb2YuYyBiL2RyaXZlcnMvcGNpL29mLmMgaW5kZXgNCj4gPg0K
PiBhYjdhODI1MmJmNDEzN2ExNzk3MWMzZWI4YWI3MGNlNzhjYTcwOTY5Li4xMzYyMzc5N2M4OGEw
M2RmYjlkOTA3OTUNCj4gMThkOA0KPiA+IDdhNWUxZTY4ZGYzOCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3BjaS9vZi5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvb2YuYw0KPiA+IEBAIC03LDYg
KzcsNyBAQA0KPiA+ICAgI2RlZmluZSBwcl9mbXQoZm10KQkiUENJOiBPRjogIiBmbXQNCj4gPg0K
PiA+ICAgI2luY2x1ZGUgPGxpbnV4L2NsZWFudXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2dw
aW8vY29uc3VtZXIuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4NCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4N
Cj4gPiBAQCAtMTUsNiArMTYsNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3Mu
aD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9vZl9wY2kuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3dha2VpcnEuaD4N
Cj4gPiAgICNpbmNsdWRlICJwY2kuaCINCj4gPg0KPiA+ICAgI2lmZGVmIENPTkZJR19QQ0kNCj4g
PiBAQCAtOTY2LDMgKzk2OCw2MSBAQCB1MzIgb2ZfcGNpX2dldF9zbG90X3Bvd2VyX2xpbWl0KHN0
cnVjdA0KPiBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gPiAgIAlyZXR1cm4gc2xvdF9wb3dlcl9saW1p
dF9tdzsNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKG9mX3BjaV9nZXRfc2xvdF9w
b3dlcl9saW1pdCk7DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogb2ZfcGNpX3NldHVwX3dha2Vf
aXJxIC0gU2V0IHVwIHdha2UgaW50ZXJydXB0IGZvciBQQ0kgZGV2aWNlDQo+ID4gKyAqIEBwZGV2
OiBUaGUgUENJIGRldmljZSBzdHJ1Y3R1cmUNCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlv
biBzZXRzIHVwIHRoZSB3YWtlIGludGVycnVwdCBmb3IgYSBQQ0kgZGV2aWNlIGJ5DQo+ID4gK2dl
dHRpbmcgdGhlDQo+ID4gKyAqIGNvcnJlc3BvbmRpbmcgR1BJTyBwaW4gZnJvbSB0aGUgZGV2aWNl
IHRyZWUsIGFuZCBjb25maWd1cmluZyBpdCBhcw0KPiA+ICthDQo+ID4gKyAqIGRlZGljYXRlZCB3
YWtlIGludGVycnVwdC4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGlmIHRoZSB3YWtlIGdw
aW8gaXMgbm90IGF2YWlsYWJsZSBvciBzdWNjZXNzZnVsbHkgcGFyc2VkDQo+ID4gK2Vsc2UNCj4g
PiArICogZXJybm8gb3RoZXJ3aXNlLg0KPiA+ICsgKi8NCj4gPiAraW50IG9mX3BjaV9zZXR1cF93
YWtlX2lycShzdHJ1Y3QgcGNpX2RldiAqcGRldikgew0KPiA+ICsJc3RydWN0IGdwaW9fZGVzYyAq
d2FrZTsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZG47DQo+ID4gKwlpbnQgcmV0LCB3YWtl
X2lycTsNCj4gPiArDQo+ID4gKwlkbiA9IHBjaV9kZXZpY2VfdG9fT0Zfbm9kZShwZGV2KTsNCj4g
PiArCWlmICghZG4pDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJd2FrZSA9IGRldm1f
Zndub2RlX2dwaW9kX2dldCgmcGRldi0+ZGV2LA0KPiBvZl9md25vZGVfaGFuZGxlKGRuKSwNCj4g
PiArCQkJCSAgICAgIndha2UiLCBHUElPRF9JTiwgTlVMTCk7DQo+ID4gKwlpZiAoSVNfRVJSKHdh
a2UpKSB7DQo+ID4gKwkJZGV2X3dhcm4oJnBkZXYtPmRldiwgIkNhbm5vdCBnZXQgd2FrZSBHUElP
XG4iKTsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwl3YWtlX2lycSA9
IGdwaW9kX3RvX2lycSh3YWtlKTsNCj4gPiArCWRldmljZV9pbml0X3dha2V1cCgmcGRldi0+ZGV2
LCB0cnVlKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2ly
cSgmcGRldi0+ZGV2LCB3YWtlX2lycSk7DQo+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+ICsJCWRl
dl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBzZXQgd2FrZSBJUlE6ICVkXG4iLCByZXQpOw0K
PiA+ICsJCWRldmljZV9pbml0X3dha2V1cCgmcGRldi0+ZGV2LCBmYWxzZSk7DQo+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiArCX0NCj4gPiArCWlycV9zZXRfaXJxX3R5cGUod2FrZV9pcnEsIElSUV9U
WVBFX0VER0VfRkFMTElORyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiAr
RVhQT1JUX1NZTUJPTF9HUEwob2ZfcGNpX3NldHVwX3dha2VfaXJxKTsNCj4gPiArDQo+ID4gKy8q
Kg0KPiA+ICsgKiBvZl9wY2lfdGVhcmRvd25fd2FrZV9pcnEgLSBUZWFyZG93biB3YWtlIGludGVy
cnVwdCBzZXR1cCBmb3IgUENJDQo+ID4gK2RldmljZQ0KPiA+ICsgKg0KPiA+ICsgKiBAcGRldjog
VGhlIFBDSSBkZXZpY2Ugc3RydWN0dXJlDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24g
dGVhcnMgZG93biB0aGUgd2FrZSBpbnRlcnJ1cHQgc2V0dXAgZm9yIGEgUENJDQo+ID4gK2Rldmlj
ZSwNCj4gPiArICogY2xlYXJpbmcgdGhlIGRlZGljYXRlZCB3YWtlIGludGVycnVwdCBhbmQgZGlz
YWJsaW5nIGRldmljZSB3YWtlLXVwLg0KPiA+ICsgKi8NCj4gPiArdm9pZCBvZl9wY2lfdGVhcmRv
d25fd2FrZV9pcnEoc3RydWN0IHBjaV9kZXYgKnBkZXYpIHsNCj4gPiArCWRldl9wbV9jbGVhcl93
YWtlX2lycSgmcGRldi0+ZGV2KTsNCj4gPiArCWRldmljZV9pbml0X3dha2V1cCgmcGRldi0+ZGV2
LCBmYWxzZSk7IH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwob2ZfcGNpX3RlYXJkb3duX3dha2Vf
aXJxKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmggYi9kcml2ZXJzL3BjaS9w
Y2kuaCBpbmRleA0KPiA+DQo+IGI4MWU5OWNkNGI2MmEzMDIyYzhiMDdhMDlmMjEyZjY4ODg2NzQ0
ODcuLmIyZjY1Mjg5ZjQxNTZmYTE4NTFjMmQyZjINCj4gMGM0DQo+ID4gY2E5NDhmMzYyNThmIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
cGNpLmgNCj4gPiBAQCAtODg4LDYgKzg4OCw5IEBAIHZvaWQgcGNpX3JlbGVhc2Vfb2Zfbm9kZShz
dHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4gPiAgIHZvaWQgcGNpX3NldF9idXNfb2Zfbm9kZShzdHJ1
Y3QgcGNpX2J1cyAqYnVzKTsNCj4gPiAgIHZvaWQgcGNpX3JlbGVhc2VfYnVzX29mX25vZGUoc3Ry
dWN0IHBjaV9idXMgKmJ1cyk7DQo+ID4NCj4gPiAraW50IG9mX3BjaV9zZXR1cF93YWtlX2lycShz
dHJ1Y3QgcGNpX2RldiAqcGRldik7IHZvaWQNCj4gPiArb2ZfcGNpX3RlYXJkb3duX3dha2VfaXJx
KHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gPiArDQo+ID4gICBpbnQgZGV2bV9vZl9wY2lfYnJp
ZGdlX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlDQo+ICpi
cmlkZ2UpOw0KPiA+ICAgYm9vbCBvZl9wY2lfc3VwcGx5X3ByZXNlbnQoc3RydWN0IGRldmljZV9u
b2RlICpucCk7DQo+ID4NCj4gPiBAQCAtOTMxLDYgKzkzNCw5IEBAIHN0YXRpYyBpbmxpbmUgaW50
IGRldm1fb2ZfcGNpX2JyaWRnZV9pbml0KHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgc3RydWN0IHBj
aV9ob3N0X2JyDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGlu
dCBvZl9wY2lfc2V0dXBfd2FrZV9pcnEoc3RydWN0IHBjaV9kZXYgKnBkZXYpIHsgcmV0dXJuIDA7
IH0NCj4gPiArc3RhdGljIHZvaWQgb2ZfcGNpX3RlYXJkb3duX3dha2VfaXJxKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2KSB7IH0NCj4gPiArDQo+ID4gICBzdGF0aWMgaW5saW5lIGJvb2wgb2ZfcGNpX3N1
cHBseV9wcmVzZW50KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ID4gICB7DQo+ID4gICAJcmV0
dXJuIGZhbHNlOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnYuYyBi
L2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jDQo+ID4gaW5kZXgNCj4gPg0KPiBlODMxOGZkNWY2
ZWQ1MzdhMWIyMzZhM2EwZjA1NDE2MWQ1NzEwYWJkLi4zMzIyMGVjZjgyMWMzNDhkNDk3ODI4NTUN
Cj4gZWI1YQ0KPiA+IGEzZjJmZTVjMzM1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9w
Y2llL3BvcnRkcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jDQo+ID4g
QEAgLTY5NCwxMiArNjk0LDE4IEBAIHN0YXRpYyBpbnQgcGNpZV9wb3J0ZHJ2X3Byb2JlKHN0cnVj
dCBwY2lfZGV2ICpkZXYsDQo+ID4gICAJICAgICAodHlwZSAhPSBQQ0lfRVhQX1RZUEVfUkNfRUMp
KSkNCj4gPiAgIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4NCj4gPiArCXN0YXR1cyA9IG9mX3BjaV9z
ZXR1cF93YWtlX2lycShkZXYpOw0KPiA+ICsJaWYgKHN0YXR1cykNCj4gPiArCQlyZXR1cm4gc3Rh
dHVzOw0KPiA+ICsNCj4gPiAgIAlpZiAodHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRUMpDQo+ID4g
ICAJCXBjaWVfbGlua19yY2VjKGRldik7DQo+ID4NCj4gPiAgIAlzdGF0dXMgPSBwY2llX3BvcnRf
ZGV2aWNlX3JlZ2lzdGVyKGRldik7DQo+ID4gLQlpZiAoc3RhdHVzKQ0KPiA+ICsJaWYgKHN0YXR1
cykgew0KPiA+ICsJCW9mX3BjaV90ZWFyZG93bl93YWtlX2lycShkZXYpOw0KPiA+ICAgCQlyZXR1
cm4gc3RhdHVzOw0KPiA+ICsJfQ0KPiA+DQo+ID4gICAJcGNpX3NhdmVfc3RhdGUoZGV2KTsNCj4g
Pg0KPiA+IEBAIC03MzIsNiArNzM4LDggQEAgc3RhdGljIHZvaWQgcGNpZV9wb3J0ZHJ2X3JlbW92
ZShzdHJ1Y3QgcGNpX2Rldg0KPiA+ICpkZXYpDQo+ID4NCj4gPiAgIAlwY2llX3BvcnRfZGV2aWNl
X3JlbW92ZShkZXYpOw0KPiA+DQo+ID4gKwlvZl9wY2lfdGVhcmRvd25fd2FrZV9pcnEoZGV2KTsN
Cj4gPiArDQo+ID4gICAJcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7DQo+ID4gICB9DQo+ID4NCj4g
PiBAQCAtNzQ0LDYgKzc1Miw4IEBAIHN0YXRpYyB2b2lkIHBjaWVfcG9ydGRydl9zaHV0ZG93bihz
dHJ1Y3QgcGNpX2Rldg0KPiAqZGV2KQ0KPiA+ICAgCX0NCj4gPg0KPiA+ICAgCXBjaWVfcG9ydF9k
ZXZpY2VfcmVtb3ZlKGRldik7DQo+ID4gKw0KPiA+ICsJb2ZfcGNpX3RlYXJkb3duX3dha2VfaXJx
KGRldik7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBwY2lfZXJzX3Jlc3VsdF90IHBjaWVf
cG9ydGRydl9lcnJvcl9kZXRlY3RlZChzdHJ1Y3QgcGNpX2Rldg0KPiA+ICpkZXYsDQo+ID4NCg0K

