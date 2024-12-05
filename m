Return-Path: <linux-pci+bounces-17783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3219E58FB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D569166C80
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB221C18A;
	Thu,  5 Dec 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TAftLHFn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BA21C17B;
	Thu,  5 Dec 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410585; cv=fail; b=WTDV6M83RxAKd9EyL1PitL9LhzGmALe41tNs0ALc/IHK5feHhuI2b3Z5n1Qz8qKWReUcUv954DfGYsxkxcy7396DGH7pT3SLBQFsWVAOXJmve1gGl5i766ONTNoguoQ7SJeGEftqQvWJLjQ4S2eBFFqwJ4ELAR/O0a6a5G+F/C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410585; c=relaxed/simple;
	bh=KGyvCT7j8/TZb42Zq/ZsBm8nsqFFeY+3kKTJ+ysaLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnKMp9vC10c5r2SveHjSOdAUPr+LVeqcLrfi4s6f0XnWW0+/EnEv/Cz8mY1/B1pvH2rD+nY5BJqmI97ig46jUgaOaZimegIGe+LaB34NQzZeQAVh4jgGXiqw5RqjVUYPp1Yq+aIkiSn3VXCJC0/OH+7DSm66g6ewGNZBf78itfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TAftLHFn; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a44vjT9uADLc06tiTo7lc0VBQ/Nkvmo2fERK7vRjqr2sH04b0HoQ1cJmJI8xrvwd2SJHxmCg58F7l/AXcd+/4kq37thhpx0SThnAQaJOL9pZCNdBKVpAscnesx3jrQ1M2CuWYrxtG/B3cAw875IaUaJhOwUWFpD/748dXXqL9A4fetugZJSkiMNjmwBwP+yKkXuHFO7i7m+TTuXJi5H/9MGPmp4fo2CMq9/+dn0sXZqW9QRLqRdMbtmlTGjPcRiBPCbus2gM3dfPt8p3VpiP4hj9Q1i222OujHSoL8L4OUMdYZu3Pd8H/i3mWI2ZdIfJUFIBwUK3MOuqUd6UVR+aSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8ObJYMcR3OKldnMUh90N4/yPoctlilZXTYH80GUDjw=;
 b=XDMsutPHsvpas2OlsMjNEHBFSqkOllUyvF131q8MgIkPQqzshJyKvueRv798eWc6e15+8SARGrnFiNvHYVFVT1OpZivGjopyrn/39KoMDlZXgVrHQ+g4ntxOyvARuqEY68I6WIDf7GYUuX0ZPsCobqkD3yZ28djL/MkcsJdsvIaIc/w2fkgi6gUYCKrO2pz3wCT7gn4Gztxcrd2rj/OBEKABB3y869I3IVdF2/OQZB4rwqblHdfC9wGOUNWL491Z2TPe8jb3c5Fw1Yc9TUqYLUS6DZyNvlABpnvYS9DKtITEzASGVgxAFpJ9rTd9EP3Lo8mYWDDuW+aRneUMiFaNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8ObJYMcR3OKldnMUh90N4/yPoctlilZXTYH80GUDjw=;
 b=TAftLHFna8zUrE23MetN+wkq2hC070ZNDnINhMm+Lxqw/oB0TFWVxhZhvHakGmU2Iqm01lhVjmMqcoU1yl3JwfJ4I0II3U5JwCMIOiSd+cLzs3Qmo5Ilrpa6fUbPDHyk1HDdg9EXPdABdRNVXfZTQr2GJUrepS7o07EAIQR0KZ2hILxaQb9Q1fYZmPPJMDASYUdkNiyT37CtOB0YlBbRAlh3lcFqqpbB+AoEOxf2V+dAQxDAWslOgE26ZIDPmL6D+mA4s6EtP309NFdKFk5GHqqgl4E2RYxqFNhyYUq/KfTkBKXujDdOoIRlkDR+q46Fns2KdlyyUWK7cpF0zGP+Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:56:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:56:20 +0000
Date: Thu, 5 Dec 2024 09:56:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Message-ID: <Z1G/CwFvO/aBLBe8@lizhi-Precision-Tower-5810>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
 <20241204-ep-msi-v10-3-87c378dbcd6d@nxp.com>
 <87ttbiqnq8.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttbiqnq8.ffs@tglx>
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e13a82-8faa-4e0b-8ad4-08dd153cfabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VSHD3y2UoS0pvR7RTvYGKfNhAblnuPxZ9q86GjVHgo9/ZJ48I3MdY4liVb+u?=
 =?us-ascii?Q?P3NEazdL8W30Kev2suL/gYnceYnaq28FlT7GIAQosXFic6s3K9p5Ocvyd5KR?=
 =?us-ascii?Q?R0b2fYlmscfJfxw2vkne3tRADxUQRJyAbr8/dnqfvuFzNOs+N4mYuoERidBQ?=
 =?us-ascii?Q?HOdRuHrA7zfoX7Wrm+xPcE3/kz8zW62/L4BUAkUJExwtkTWRmkxIy4+IsBK/?=
 =?us-ascii?Q?hebt3L27gk/JEAydquRqkd/oZ8WeiI7I4IXhBMX7DtoP6a/7aAkT63iEAQAy?=
 =?us-ascii?Q?gSW7N7yLbfs9vlvDP/ZsbaMkJ79zVd2QIxJHOFxU/RPHXenk4cpVFbwU2zi1?=
 =?us-ascii?Q?Cm9eAxH5r6vMPnW2b5NWPaYG+q6lnZurD0BDd4btyZGr3K8n3t1FUx10wgRl?=
 =?us-ascii?Q?jAQQdOwvjpfUkj6nt6PM0c85VXnIImMpf5tT1IkwKonF6QlgFJO4SzImouFP?=
 =?us-ascii?Q?w/DU/DeCjOQ2UwZ2rebkJjXeYoz1YN54YMd6NClf7Gna5Q5OaE6mFbuZW0pM?=
 =?us-ascii?Q?ygTkWCtSlV1ZCAnL86il167OV9sag6eX0ihl8dOMdF13MCf+/5YCi7uXe9J5?=
 =?us-ascii?Q?ag31P7Pe9JBrorA0tXeTnwL4FyXY3mxcJ5sVCvzsdUZgFRMRTmJEUae5X6D+?=
 =?us-ascii?Q?VuJeREUfZbH2R138Nkj4rF3YJU7ElqMaNNS2+G1EpIOGvhfZg5uP5BT299hk?=
 =?us-ascii?Q?QVWVrgeEUf1G0DYSQf9VvIIjivHHuchzpyt1+YPcoGzrzo3D6/n6LWYpwb8O?=
 =?us-ascii?Q?s0LA2W5bESmJtkUm6NPr2ijNRd0qsSG4RgNpYN9ah90sj1slXgjzHDic1+hH?=
 =?us-ascii?Q?hwrS2fIOrxi++E6u86ZvMQZ3FwdBQ9ETpQq8AuPJckwYdbVwMBqqVpjSf0Bc?=
 =?us-ascii?Q?4jO3t73l+aOQGEDfmm+Hu7nzQnKNCbFkkX8G6suMhnTbGtBPg/3Rzuor8Ute?=
 =?us-ascii?Q?qA6GrNvG2uMAW0Vb6tfbFjLZSQERs3brQAGw5VVViXKCfMzM+uVq5Tm6uXVp?=
 =?us-ascii?Q?UkJllSuQvfxRcT9GSHUv7PJfRtPQARKaGSzrd1tfjMgQOIGndWoQuVet0XZG?=
 =?us-ascii?Q?MQzfgzxUTLo2vRJUM2QMvroXLf0YI3NHUFg27DrTrKLCrcjcBbhJLKW0m88V?=
 =?us-ascii?Q?MJ1/ks88awDCkQz5jH+x1pkWdsO7lJEglaHPIg7ppknnBt37MGTevW/sTM0k?=
 =?us-ascii?Q?N7XtOeNsrbAEZcKXvRvrg4yy8HOG1zBcJO42L23e9qBRcmHICwJA+RsTWpPL?=
 =?us-ascii?Q?UBRp1cFMQaw8nZHF2hCdGimVaop/orbVwIq6OySXzXVpECUmr/l08oljf3Ir?=
 =?us-ascii?Q?nspUp2FR8WbqORZhn5wSfWk1372cdrFPVh3o4pDh0/vXRr0LX1knONyzc2LT?=
 =?us-ascii?Q?oXlQsdomBfm4AYOWaaaTjP2W2SASY/o2q+sKjJysdKtMcqyl+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsTA5hxNR9JXs1EptUeJcU48AFgDgMQVkehiDUJuevEEk1A4IXlvrZf6vb6W?=
 =?us-ascii?Q?zX1ozri+XzZOOVxOQwg4H63ihSbQOMsxQOabktyTuCbvj8DHN/burKXFup5o?=
 =?us-ascii?Q?2PaU0EIHV7L2TiT6PnekokU/Bl/dReMOvpImNnGmu68oSDvHJDHqkV4i15Ud?=
 =?us-ascii?Q?eFGTGzwCwGXTvLbuY7R7TAPwHCKYE/f0cs3TrdQM6KpG/4Rg9FvBS+JmajXc?=
 =?us-ascii?Q?WaoG3UusmKXgSYemz+fgLTSm8ZYzgZGQNS0ZkD7IgF5Oz2JEovcqjO4Y0s/f?=
 =?us-ascii?Q?8tBaNNe+Yf9//3VnUTbOp+T1Ug/zhTnBAzCfv5vWCTD8Seax9WwxTfQJfyfr?=
 =?us-ascii?Q?JNqZ28Y6HUdNwdMnVh7jwzmSGtuHhP655FO7rzP2JSq9mqObigY9F9cRuXYD?=
 =?us-ascii?Q?h2NWX2liOIykeQ1tyH8o3PxjwNAEFZZxoypi2aqFWeDkKQP/VrEL4y5RG79Y?=
 =?us-ascii?Q?BneQmLJWaGF5ODvRHx7LeJZ5ue+akiK+giapBHHbKDr35iq56UrxD/SWmkNn?=
 =?us-ascii?Q?Wwfo2jcPHrChekUdCjHCV5K5QxMXHu92g6o1YVCSH2h/fwfVybrVpEcz4nQY?=
 =?us-ascii?Q?1kIt89Sec36JSF7o9GVbRcAjPs5x9lc4Y4nEt5rqifxXw+cb9xdM910/tFMz?=
 =?us-ascii?Q?dDV0YMbQGCNnNJA6lUWuitXGeRsiSu3gbfqqIori4jOCF7yYTSYCClNvtAEC?=
 =?us-ascii?Q?/DzYJJv22dxod0PLNOnQ0MEdHnvOZlBtEOTykaxX4bpSx3GMLr3FIEwSL1Yk?=
 =?us-ascii?Q?Z1j43lulYC+qqZ5oAf3gKAn4BbXHh7d2UaCmmtUxCUeyY24saQj01YCCXGyv?=
 =?us-ascii?Q?GMns2Hx8ewUzaZ2vFH4LvWhmUzR/UYeugr3scuT3lZtqGsw3jYoWg3RalAa5?=
 =?us-ascii?Q?VKA4W5tljnAiZv1hXnTDW+lzbOIpcSxSTzeFtyk1/T0IfzuRWn9pc3R2k4f8?=
 =?us-ascii?Q?F9rEHx4/nt0HmDmsiUYtxh0CO3ya/FWRFAgGrhrqe9nkTX4ITPSbmabk5RXd?=
 =?us-ascii?Q?9eBhzl22p9S74FHohJLertNm3v3Jfx7G5XHMKKgQSIzxvNloK+8Txt1t9YZT?=
 =?us-ascii?Q?gJ4pDDj9N2yOn41HXsDV3+bKvdJWjqa5+MOLctP6LLwul0woVcBoRB4RVxsI?=
 =?us-ascii?Q?46ndrjgULmWISFQ3R1hFj2h5sZDy7oTpmBVGQBS73tmk+cFWuSo7BIrUgdM+?=
 =?us-ascii?Q?bW/j5zxS6ib3u+SZtkHIp2XUpf3i17U+V7NunmXuj1gZjRmzLlkEbgIYhdwH?=
 =?us-ascii?Q?ind8wUfO3RTBY1U7oWRcfwUqpbAjJgd5z6h569tt9ym+4h2hV+7+KOXJZQvq?=
 =?us-ascii?Q?XFWvCgzblk92C+37gYYWlMzobfWFiumPn5u062jP7qgLKFgvx3g+yYz2DbZV?=
 =?us-ascii?Q?iteiVIEM9fJ8zPf6bnm2LafGoE8AKp+eix9/Tr9QE/ixTwL13M2v3+Jh5s87?=
 =?us-ascii?Q?04Adwqra+mTNtLkL4lklCFZcCyXxpB6wLebBHP1epJLEwGudAcjlRxx5ygnB?=
 =?us-ascii?Q?PpeuLkv+9Ybj7a3rGP3gu5J8AMRjQLgSyXl8NkRJh/ZhmmCtsQJRg+4hOeHV?=
 =?us-ascii?Q?w+IXvelxU0L1RWy7Vko=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e13a82-8faa-4e0b-8ad4-08dd153cfabb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:56:20.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAcKVqeOB4acyQ7tJSGx/oQW45UJJgP1MxRbUVFZewsGV3DuXgcAMDYNnOfxIeir0IuwVKQcioMmYkXbkNyYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812

On Thu, Dec 05, 2024 at 02:10:55PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 04 2024 at 18:25, Frank Li wrote:
> > Some MSI controller change address/data pair when irq_set_affinity().
> > Current PCI endpoint can't support this type MSI controller. So add flag
> > MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
> > doorbell.
>
> Q: Who is going to annotate the affected domains with that flag?
>
> A: Nobody.
>
> Q: What's the value of the flag?
>
> A: Zero, as as it prevents exactly nothing.
>
> You want a MSI_FLAG_MSG_IMMUTABLE and set that on the domains which
> provide it. That way you ensure that someone looked at the domain to
> validate it.

Okay, at beginning I think most MSI controller is immutable. So I use
MSI_FLAG_MSG_MUTABLE.

It is fine change to MSI_FLAG_MSG_IMMUTABLE.

Frank

>
> Thanks,
>
>         tglx

