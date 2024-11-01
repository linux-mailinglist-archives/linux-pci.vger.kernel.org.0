Return-Path: <linux-pci+bounces-15790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326AD9B8F3D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561941C22290
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56318E34A;
	Fri,  1 Nov 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MBqxO6ix"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA315C158;
	Fri,  1 Nov 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457277; cv=fail; b=AxHHB62yyrdxFXeYVkNZ7BmklJ/yOEJ987Q42sSJzCjtkVd26RPW1byC91ecY9cFdSM6GJF7Qv0O/khPu2emMuSM2ceU1c5MAEdCNSWGODbry9SQr8rQx4h9snaW8zj5In15ktLejYLLkOYYV3awxRTYCyadLlRoB0bUDG6BhyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457277; c=relaxed/simple;
	bh=iyADMSZZTYlVRePkQ+QSRDY3yC/IPjZiXHc7uzogTTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyK8UuB8OYc8GYG6PWCo1cSNXm+CVp6UXSp2rQWkkkORiHiKFf2jLfzJNeqAwI18+JiAGGBDOxF8+BGEduwMn9ZQrJflLagw0C1cmhOILOidWAZ1dBrUPaj0tVpX8XqzcTPtGfcdTkUBCVFmNOW6VyGF2zTy99qFNfxZN8WGEJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MBqxO6ix; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INlxVRzoJWxQiiNJfJIwwJc/aQW4ImLR8GOXS3hKqL+a8VdNqsCtE1uRWYgUAjBCJyC6o/WyK3q3jZn5to6QdGXcDwnXzg6HTocWPsqLIhkzmWT9tCNlpMd7Qu5ezUa8ldbJtAUHPJ8p+EOgNmQ69wWh25xEELaeOTAxgTTtSxyl0ArcpyUcliu7RROQLoW6lu0eKIGopKCMeH/XNYlspFxN54Vokv9k/GKjPVKmQs7YXwPsOGvMgbrHkrQfcs09Nidvtv37CoLrKLVVII5nLiv23qyXd+ewjkicaa8TX1GVmK6t6XuM0JpOW2UnUqe/Rw6pfGDxv1YFwHzlXUFtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ9FuSL6V0fqPvpFO6E155kLvgMk569Pg+uIHA8ZHlg=;
 b=OpnFSpmCbpqTh+0sSaqJ9uGn8r+FHVa0cqfAolwLmsVLh0Jq/gO6JfKCx/KwSoVI49qRRjxwbiKov7Ic/9YvR6F41osJgU6MCoWefYjPhwgvxmSTmd3MktsQR5iVoyiYMLbSL0TrFFqDK3ziciUQt9pBCPbG+MWDtprpUolltmx3TjVpXjxIKSNUpo3t0RS1Jior+W9jTaEqLm6J27mDEVWNfSrQ1wRXRTElEVAWcRbRBUgpI77N6Mo2hr4Y+bRF8kDb8/XTkxMJJr6FyNSGuE/U/JL9Il4QjypesZ07PcpvcNXDwfWXQ1qNVkCtqZroyQpnBe1DuX9R38AjjzLIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ9FuSL6V0fqPvpFO6E155kLvgMk569Pg+uIHA8ZHlg=;
 b=MBqxO6ixJ4dWbk+vGNCOStgrpb8MNPGGIUVPwVoIUTfyWq8l6MJiLKJjTtVdgCPhxJBxAHsfKB4CT8kh/trURGonaEpocOpflROGU4dY6xIurLwPwvLjDG3At1GqBY8Nudgmj7S595lc/v9gmy5oMr9FJ8lDkiCv67b8dXV4drtR9BVeAvIowS+qZOM1WfvkmbXPprBHEGcxdG7eYR6bUDPEEAGn/Yn8xCIaJifWgmUkpewMKjlMbpxvC2A0sSKH9vcqAuUZoMLTqz5+31a1pS9YnqhskMFmXmEXouQmRM8oguQ/srDHBr14XGOuZmNBooD8okr0T+XM5681ohrYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:34:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 10:34:31 +0000
Date: Fri, 1 Nov 2024 12:34:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <20241101103427.b2a7ir57tigwghcu@skbuf>
References: <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241025130611.4em37ery2iwirsbf@skbuf>
 <PAXPR04MB8510B731B4F27B1A45C1792588482@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241031124500.vxj7ppuhygh6lkpm@skbuf>
 <PAXPR04MB851041AFADEE8FC8790E90FF88562@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB851041AFADEE8FC8790E90FF88562@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851041AFADEE8FC8790E90FF88562@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB851041AFADEE8FC8790E90FF88562@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:803:64::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 038b9147-88a3-45ba-da0a-08dcfa60c4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TH9NBoMaURkNc8vKtmELc1ehBDCFN2JMvX5jCqQAbb7BVyWjMRr65quq3SXR?=
 =?us-ascii?Q?MHQPvy+PlrrUOhH+yQ9XZRlnRV1hiBuei8ks3LfZ9lZLC4PRcniK6XF0x40Z?=
 =?us-ascii?Q?lND6BMYifaqLXoLzqJ9mNW/IN/U1yAcEVnItzmLbn1O4kalHwzzPCge1DX0A?=
 =?us-ascii?Q?qYxbnT78a2KTEjxQJbcM8ADt5mLTrUiaDvOmvJJLJu02nTPZu2yb5pSF+/3y?=
 =?us-ascii?Q?77f431n3KAkJIUHq2fmtkQWlSvPOZlm8ifA/V0F0x5l1bRRlpGeO4+mmpVUe?=
 =?us-ascii?Q?RZw7OMvv/hQ4wySlFmBWgya3nNY9yBzY4S99B+FEFYmcvrEWggUyLNNgC6zW?=
 =?us-ascii?Q?kvhQ0Aw0SO+32/5X+BU5ZVSdtr/eJp7NR6B6vOe1ii8XSsYxOoxDplwAIO9R?=
 =?us-ascii?Q?fWrlFIsB+M6uTVa7HhNPixfNbtSKUhDGNiwZFOvMZq+IOv76WE2vQbcGUwWl?=
 =?us-ascii?Q?+wZ8XCgWdNMZ76AfuyRejswTh7PBfIwhFlSPcCXxrNeZnt0LSqJidMPsNAE8?=
 =?us-ascii?Q?VCWnL9rT+TWXuaKaelnAcVPH66g+qNNfuWquimLnvHmGaogBs5X5ZVyoK0UH?=
 =?us-ascii?Q?DCCFGtCq45pNoYRKznxRm6eXse8EWtTOkVRb183iDMH74PLWFIFmEvvNq3Nu?=
 =?us-ascii?Q?Sf8C82dY58v2Rn9UdsE+mV+SI+m9obsrlzzB96EH3ZCKYXmK2k2fd/NkuzZp?=
 =?us-ascii?Q?x8EZZgn7igyU3ag0APrmwpCH6d8GYDKtwi4XKWpkirqFqFf1NBid5LYqN4e9?=
 =?us-ascii?Q?yArrA/emOGZTrwoIZldR97nNgKY/h7JSyRIerZh0TbWdWPIIbRhWdmfGTRqK?=
 =?us-ascii?Q?a5mMK0XC0DJnGyX+BvS2ePirxsITWcQKKPL104Ot9vdataaHeXZqpJa1p2up?=
 =?us-ascii?Q?9TWmi0GJyT/4jQfZIXVbIZnvlM5tMMktjeiZMmeCfvVTsTdrR3BSFQrJ5hjk?=
 =?us-ascii?Q?r/RZJ24dceCrgi9bVZuwH4CAqSInTD6ct9fHwXarz/vmiUBAmv8yl71dZOCd?=
 =?us-ascii?Q?o2vd7lYQlxEf2X54id7aJ48tu1pXsk7a5dWLE4YcW9ncBcp4kZhqMDeGFf8+?=
 =?us-ascii?Q?abwP44W1UOctz4yIeuLISqLDZk9tznOghVp1YUULTfPUXoIY8ghEcwTFevp9?=
 =?us-ascii?Q?hzXiFdf9c7klWWSEaFETZm6Lckr5CSegy9AyvnNrZbcdtCidAkPWLH1TAYy4?=
 =?us-ascii?Q?1WX+tbdZSwGI0tCt9J/TXvqBotOJVEKApBVfbZ/k8LkVELwYGMI8fnJUj4R7?=
 =?us-ascii?Q?OMFEBE8/7psk98zMlq2Sz0/AbA2pXcxO3KHQd60dCU/tlLKAOWUtLVzJZhP7?=
 =?us-ascii?Q?DMNM2DttT9uQBZo3LGDxXqOg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFg6nGIW9OxMUJSN/1/a6JKXOVAS5JV6py3+pZGjD3uXiBMTgkk8vIVGA1g2?=
 =?us-ascii?Q?0l2indxsOzGDOs7HWRcGKA3tbAND0KxVuLXc93zUROiL7dA5nvjE7OkMoJ9/?=
 =?us-ascii?Q?5Z/gVzaapgAzQD8RMDqIYa7b3yK8+BywcDNJ9fweWWmbO83WEAbAYIjOMise?=
 =?us-ascii?Q?jH5oW8Nt2ZkSGR7h68+dY2nOnhaRXhNdXi07TNVut6xiRbkk/S1eTbjgWHIQ?=
 =?us-ascii?Q?7EvZokhyN/G6fE5DHaa7vc6Fljmwlzg+SjJ+m7nVpVRbMxTUuQBWnKBLgRyb?=
 =?us-ascii?Q?f23gl8nqaAzlum1UOqWa+bKBvY8ZqEwwYjKAw8XE20qC933WqhhKOu8JnLMR?=
 =?us-ascii?Q?WV9zXRuazJVc6XYZRGUISEkkuyN9S4f8dN+Sz5nC8KJiHynXh63esZQbCHS4?=
 =?us-ascii?Q?B0mkK/nBcQIPTtrIbdz/Kjp/T1EZwZ3Igr9aWMbFyJnIhwW98I+khnGV00RO?=
 =?us-ascii?Q?PGd+odD46JTqum4zbPwwMV9jsjAVSCvPUW0PXV0kAZ6ff2+c6rBhdZV4BoMq?=
 =?us-ascii?Q?YfvjmnGffZqVjfKHkDxIgjzg6Q4OHV2RtgIDlZ+FZ8qUzJW7Gun7H8a2h9g+?=
 =?us-ascii?Q?dbr5MKgaKn821h2/BHDwMa/rZjfrJLFACgehPAvBFfEhfGA+9dQKzgZ1nu/j?=
 =?us-ascii?Q?nnqf2ae/4S6W1GI0DkZxWtjA1y2UMX8hKZ+2+BOla2HIJyTxcaK+t6dDJ4pt?=
 =?us-ascii?Q?sSF3wnzdqF5szBgTkafZHCcZdkQLZao1wr5XAVj1eKR3m5w64sKxW4p8TXA3?=
 =?us-ascii?Q?sGMWlQWnDmrFiM22BPo3096YvN1a0Ekw2V7w7hqtjvydd0KUuacSfXpkWdVn?=
 =?us-ascii?Q?8eVaq41enDwI/w33XEet7IpGlJYWa5KJFYT0mKJBtFjIMAUbtLxyjDpWqFbx?=
 =?us-ascii?Q?8p/FbBdEJ0joe+vKGOZkToq4pzi1FnPuGYGXmR8zSiLRPbFFeoAx5DNkJK9l?=
 =?us-ascii?Q?yDwCpYKYlW+CLIpngLaQRI+nVc9zNngqe8LOivzvByFyIJgsbXMlP29CusRe?=
 =?us-ascii?Q?Mtst+TZKP9S/+I4uaIM6nH7cah2K2nbEH/hLF/6wCMd7WDsVjqcWjJeH+pV5?=
 =?us-ascii?Q?7YH9hsj2zFtsmCJ4ic+eCQ+gkkBpL9fXHaT9kqFjaELQ/Cpi2Xg2OFvCWiCB?=
 =?us-ascii?Q?JD5AH8iHp4wAfM0FJ1mAa1F8qtovWG9ILfmiQNXbL4lihMAj1Ysl2+fsX/VN?=
 =?us-ascii?Q?MVk9rHfGaPrXfRXKCI2gA09zuSiQPVkQMu2j5CwOZ+FwhuGeUfSKEnXKJ8Wd?=
 =?us-ascii?Q?X4ufWg5hEiJsFKSL1Azf+m+QL664HowQOTo2r0lOJO9JeXm0MFo+KbrXjC+5?=
 =?us-ascii?Q?mhAEMlTaO7iHRpW6zVRXwBLTYH1P0mzjXfTNI9cwSIzzPzfqNIuQDyAukhyy?=
 =?us-ascii?Q?l5qDK/y2OCtfYivT+K9KtjF3xmXTuMHUbHyR/Gv61ug7w+Hd4hkWJ2Yioczu?=
 =?us-ascii?Q?pGqR8H2f1DUeBPr+xwwfsuupeqokbaOWVqDV9XjFIAoHhQdwzywA/zC1WUVH?=
 =?us-ascii?Q?k5rflgfa8HL/316+CFftWKee+PoiJ20WBHpZ8vp6CIxcL50vxl1RobcuFszC?=
 =?us-ascii?Q?1y1yC2rWN7QPRYaBvHwn9xUdrcly1O078MP6C0eLgKVTzW+bNmRhm/MRmKd9?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038b9147-88a3-45ba-da0a-08dcfa60c4f8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:34:31.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhxwZwyL0jbIOahoFMgXYJWB83+ZbxccUogjLIyK31fx4sfl1luPEWrqFV1oLQuEcALtN3aiZx34Su0Q7d0QVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947

On Fri, Nov 01, 2024 at 04:18:55AM +0200, Wei Fang wrote:
> > On Sat, Oct 26, 2024 at 06:01:37AM +0300, Wei Fang wrote:
> > > system-controller not only configure the endpoints of the NETC, but also
> > > can configure the ECAM space, such as the vendor ID, device ID, the RID
> > > of endpoint, VF stride and so on. For this perspective, I don't think the
> > > ECAM space should placed at the same hierarchical level with system-controller.
> > >
> > > If they are placed at the same level, then before pci_host_common_probe() is
> > > called, we need to ensure that IERB completes probe(), which means we need
> > > to modify the PCI host common driver, component API or add a callback function
> > > or something else, which I don't think is a good idea.
> > 
> > Ok, that does sound important. If the NETCMIX block were to actually
> > modify the ECAM space, what would be the primary source of information
> > for how the ECAM device descriptions should look like?
> > 
> 
> I think the related info should be provided by DTS, but currently, we do not
> have such requirement that needs Linux to change the ECAM space, this may
> be supported in the future if we have the requirement.
> 
> > I remember a use case being discussed internally a while ago was that
> > where the Cortex-A cores are only guests which only have ownership of
> > some Ethernet ports discovered through the ECAM, but not of the entire
> > NETCMIX block and not of physical Ethernet ports. How would that be
> > described in the device tree? The ECAM node would no longer be placed
> > under system-controller?
> 
> Yes, we indeed have this use case on i.MX95, only the VFs of 10G ENETC
> are owned by Cortex-A, the entire ECAM space and other NETC devices
> are all owned by Cortex-M. In this case, the system-controller is no needed
> in DTS, because Linux have no permission to access these resources.
> 
> > 
> > At what point does it simply just make more sense to have a different
> > PCIe ECAM driver than pcie-host-ecam-generic, which just handles
> > internally the entire NETCMIX?
> 
> Currently, I have not idea in what use case we need a different ECAM driver
> to handle internally the entire system-controller.
> 
> For the use case I mentioned above, we use a different ECAM driver, which
> is implemented by RPMSG, because the entire ECAM space is owned by
> Cortex-M. So we use the ECAM driver to notify the Cortex-M to enable/disable
> VFs or do FLR for VFs and so on. But this ECAM driver does not need to
> configure the system-controller.

Ok, I was actually wondering if it makes sense for the the parent bus of
the NETC PCIe functions to be described through a unified binding that
covers all of the above use cases, so that major device tree modifications
aren't necessary to adapt between the 'Linux as host' and 'Linux as guest'
use cases. But you're saying it doesn't make much sense, because the
device tree in the guest case would contain descriptions of inaccessible
resources (the NETCMIX block). Oh well, this is just another case where
"device tree should describe hardware" actually means "device tree describes
what software wants to know about the hardware".

Anyway, I am now convinced by your design choices at least to the extent
that they appear self-consistent to me (I still don't really have an
independent opinion). If somebody has a different idea on how the PCIe
bus should be described, feel free to chime in.

