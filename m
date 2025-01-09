Return-Path: <linux-pci+bounces-19605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D352A0781D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8613A231C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CDF2185B2;
	Thu,  9 Jan 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aR3zyJC6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B01FFC4E;
	Thu,  9 Jan 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430388; cv=fail; b=bxdFzJMUELbwtCXsAMVlyizkg41TXf04Y3pmGCphs67ZznTYC1VG688tW9vxOah+kCB0PzDJ9/xt3yzcNlw0foObG6BiNXXEjad6CumttITzFcHU8vCJtEgHMVlPP7+wW93VaTW2i5UGcINEzCLi5drJ0kyn6P2fu/UItWaY32c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430388; c=relaxed/simple;
	bh=hq/53HkHZUvXyUXJrHWzWKZIZFnJw8Zis4+9PpEDsF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C8aQiTNBVgbbZWGpS5VjM3bj8Wu4mi35fGvU06GvutLmY94t70BsRmfMMFYEa1Hwp7y9tN6QT8DcUzhgZEmymf2AZ3kXK7OKdQZkKmcoRKFo0TWLf1yLztgWPfIGMwxp+q7p8Aizm3yLdLOfAnTXbw3Z2f7qchqgIPSGaoDFa1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aR3zyJC6; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx/PXcYgt8n2z1DlEukJENBCN27wFi3pNA52ChPUHFcTs3Z4XhNk8hFEdxtan0vjuogDnK6o5mickvAZAL67MAAXF0cfxVg5jp9IWuWvUXLmiNW6D5FrMivtyatH1AUT8AHVMxahoA3WyJRUgvYsE6tEleEBnmKJ6QCPK43A3gLVBCkRpjE8nHRkpsKQiqxI4GmR5kIYjzSSA51m0oLqiuQHsmUqXlyFXyA4wzFeg9Y8Y9pCQttUWknROq0O++SA7SFPvBofe6DC/FbN4gcYtM1a6U3whY6o1A5hR7Yq/0ILrD/xzHitpqc0OmXwxQQ2GoFMXuEuSMBqFeHkF05tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axSigNcod2rzX1HbN54+Vdf3z8Fwiv3s0T4Yc0Wj9PQ=;
 b=YLtcFRLimb4OOu2p/XBVlGgNvBsSlPDQfB0+5K8uIJwU8C8pKN4goCZa/gtfEU/MZMcFfUC0x4g0tm85wpSroifx/RBAuiGZ3UV/9UENTNbZMDuL/6ogdGVt2EpWNnUoCefZ+rptn+1xjgFnEDjyPbw0k68mnhp9THmkVNHj/TqPsuo5znNy9K6ir4f6xGSswFLno/upib7eFjsOe/jU27UJ23Fq9Oo3my/1FlZcb56+/JiQkvaJC9/ftoD86DO3RHIrfn5XNLW8F4zcXu2/oJhk/ap+7CzMAyubwiuzI4NDOo1AAhhRmZEHcqeT1qDjSqDW5+s6U1YHC4VCRRu3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axSigNcod2rzX1HbN54+Vdf3z8Fwiv3s0T4Yc0Wj9PQ=;
 b=aR3zyJC6jxtOyJ3JwWxUjsZkypKT5Vk48IgRWlYvhtn55z0hVHCq9IBEQMkJixpbMcLWy5biactgWRRfKN/3GapPnMZpxXMGx46+eSyv/KWVGjc0iLEhkyUBqpkyyiPNmlo4V+PGsZMlcz1Ctr91H36uUnWWlACgw7yOdSTm7XSnS/xqWH/wVOExNX1QxR4Y98AHRLxlmCOvqn/xIK9xvA9dtTtQbHu6vktQHbszjCvA4t/20CgN0A8jtBi+Mo2hiEOI0nJBuoO1heNMWic4sIEeEViFk/siTCNSLGHOBtCH0qMX5SeZKRfLQOLS1bK8bwOdVGD7QOCSxn4hTgx74Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 13:46:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 13:46:19 +0000
Date: Thu, 9 Jan 2025 09:46:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"robert.moore@intel.com" <robert.moore@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"wei.huang2@amd.com" <wei.huang2@amd.com>,
	Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
	Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
	Rob Herring <Rob.Herring@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
Message-ID: <20250109134617.GW5556@nvidia.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
 <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
 <20250108205030.GU5556@nvidia.com>
 <PAWPR08MB8909F2373F84E4951F74A79C9F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <20250109133815.GV5556@nvidia.com>
 <PAWPR08MB89099DA1BF11CACBA14E21359F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR08MB89099DA1BF11CACBA14E21359F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0927.namprd03.prod.outlook.com
 (2603:10b6:408:107::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b14a2f-e81b-4635-d6eb-08dd30b3fec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/ubM7RAVsa2eH2sbdPFiZFLcUj5p67f8UlS+mOcQa8sVmu2PeCaPnA3gXOC?=
 =?us-ascii?Q?rDlFSy5scZKmD0fBDweCEUzMMkNt1E18UMc8odQ7YKj1DFmPQtH37ydtirUp?=
 =?us-ascii?Q?7VbVD1A/LqoqlKdmoYUyJgl/nXXnmzFRKekAIeTEY4jb+VpUqUCBsndubw9Y?=
 =?us-ascii?Q?p0h6ZQ86dCG5VHKNkyZl/96sWBJ8PpuQFwWlNwJXGNw2+cyeoxeO/DmS/H+E?=
 =?us-ascii?Q?FqoH0PQ7PeBTOdlSF9nM6IMbknUEMu04seIjHlVKRiXPrmzx2Qx6bnrtQ6N7?=
 =?us-ascii?Q?k067XpEMvxduJMZ5CKX2OFgfo2NKJD7hpowg4jkIC5hnumh/iEmR27jW6px4?=
 =?us-ascii?Q?Pz4fGulb6TqGJG9IPm0fHVMBPNeoaSsdNt0SHSZya3cHDn6KOK+B5AUrz7b7?=
 =?us-ascii?Q?2cdmMDI6XqnHAwtCxG/NKCJTHsGD6ShGbAGqA3mD/xDKeYs65E4ZoP1pNyeB?=
 =?us-ascii?Q?yV9KpXGuqn9bWFi+doK60stmcjPgPM8GQbPn1hUliyPBeoKApQKBJKMS8XGj?=
 =?us-ascii?Q?+aMQVbcE6s3TwdbrwLIUl3sCeKDUbE+diVIGO0iKKfUSfqJFfiConOVo7FLb?=
 =?us-ascii?Q?xs+Tx2cSZ36vjqwcLKSes0ijSwwdEl+jBoYBgp3rO03OINkuRL5iM37xyZ4z?=
 =?us-ascii?Q?hkv/Rd4awy9/Cb5L9vR23w0a49FV8XEiJ3Wq2DLUojNP9MXEi7lmjLGDvOM9?=
 =?us-ascii?Q?MsHfL/UrLVHOw/F3GSX+b+5PnqVNyHrhcM5WbDO8s0/1yR3rXo/hkDhUP2U6?=
 =?us-ascii?Q?sQoMtpEx5NIgmNQye3kv3FItfIsiL8QamMr/J4HjTGWwUvVDDpEvP3BMR8Yu?=
 =?us-ascii?Q?16r1bgBr9u1gpkyMhrrWAJo8DFl+vPknGRIhDvcs8ZTvQT9qrJVDD4ab8VAs?=
 =?us-ascii?Q?uiuH+UnUCoVMEm0OvRGrT5GP43X7uiaBzPkEzI6D9SIj0O2J2CZl53x8/Bzm?=
 =?us-ascii?Q?VHEJV77l1cRj3CxJq1ILdlW6tvGnJRpfh/EOlp+j1bKD8rJ5U2cZG036nBDA?=
 =?us-ascii?Q?52cXwO3uafa4LcGK//7EYR4pO0K7fpcLQNpwsvyJMa8fZZmgenOUrOPVZfbE?=
 =?us-ascii?Q?D5F23VxhWgnJWp3v5npfmm36dWJdVK/uHhju1GCIQbVEKVZ3e2fLzFgQk4nz?=
 =?us-ascii?Q?OCQz6h2hGWh+DiXyMar8J26abKKM2Qx9Hv4IRIXTzbbNw0BvUk4/s3SdNU5N?=
 =?us-ascii?Q?uKmP6f8DVXNC7Yn+0gX4YDgaQpyBK5Mya4qVAKexFBBESjMvRlc5tXF2Jr2q?=
 =?us-ascii?Q?CwLdWAZewKjuSu0kiK0GHAtd70JVOGuaq+oqfOzUWkEeqZsOd+BjOgyZyAEJ?=
 =?us-ascii?Q?/PNi4ZYAYu4vtMtZ3fEPZVlX7piRLekf3txuXjV2qvH8IsKaypyovOf0N9oc?=
 =?us-ascii?Q?GOgscIyLUkAtkf04Wa2heTlg0fYZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G3KkbYcyIWqar12OiJ0oYplNZNpB41xc8TZdnSKbCLTMwRnyO4WDKBkB2pJa?=
 =?us-ascii?Q?lmpo6Sz3yeqaxDC1Si+M47AuyIAzWaOIZQfvJTTWhakXHFSdcZAugTFwbD8d?=
 =?us-ascii?Q?3cr0P5w0apEK29IJinhDoiQS9KSLDKextKoqCGFvk4wNrv4nytKSluHQoSAX?=
 =?us-ascii?Q?QdFKghqzp1IDKNSWeR3HDoJndibZElXm6ZPI60ol6IOLk25nXZs2i67Quprq?=
 =?us-ascii?Q?b4Tls0h7z8ZvNX2y+7Tx18eNY1MfhTs9fnqYsS6m/zsoVtsOl5wS087dUIsk?=
 =?us-ascii?Q?hwzP24V933zdVDEA1LL9AGSkvQvR970ZKNiI7Gll9+hZLELTQn0311IE8Why?=
 =?us-ascii?Q?la430qvw3G33MMresjfgqLkETlKwWcV2+3zwQi/C+oSWlPj4r+R9kCxocgmD?=
 =?us-ascii?Q?o+i1cML69OjvrMrnS7jpootSVKku9PZrdtxlO5Skg1e7Lu2tvqGcEfywdPso?=
 =?us-ascii?Q?Mx4gXEXmC77C6n3U/kgg+6wtiRGjWQLteMw8bOXPzr409NVJnGlr3rPFpe85?=
 =?us-ascii?Q?NwWX8Xig19o0fjrkNULnNVrvKjfIpFckn6EldIZrX//8gI9FrPQu5d6y0KTN?=
 =?us-ascii?Q?6sO/d1NfbAr/9cZI/bncsoWuDuQdFk8qTS25UFFtTbXoYUab5+uolkjOclx7?=
 =?us-ascii?Q?cLoCY6ER9o3LQ6UuipnQ6je87w19E0m4hmG3ZqpJprsJLIoCWePUXO3PkRbD?=
 =?us-ascii?Q?HPbhoapEIZVAhAIVMlf6DF/lYe/dBVVCqfr6h31FQuAgDMYGCKR4U7y6zce7?=
 =?us-ascii?Q?epgABjV2qCJr8GO/dhwW0oarkex88FmvFdUO9BqGvcIfxflH5ffPwRolDMfq?=
 =?us-ascii?Q?IfpUxmNanLVjVPM+EhDA1NgKZ3joCYnGUDR/qn9EeAqNVC58Yj45bkJffW2D?=
 =?us-ascii?Q?Eb71qloBnShR0i00ljujLms9bieubW73XIFFYvtFWR5T+abmqbk4zkl+EMSj?=
 =?us-ascii?Q?A8KzmmXIMaIhQkPUA/EJ4V/OZ9gsIcoILXDVrPdnZpMMNwKZsD8PpPwhoV1j?=
 =?us-ascii?Q?CjvJFBGG4zjbRWZs4G42/KCLl1dBrvRyvqMndV4WrBAG4LB6jTcOs7r+h3Rx?=
 =?us-ascii?Q?dAeXL7MUB1y3GZySvkx63pDOofJCqWS261PeBiUGKGKGmtiy/6zFps0fdGH6?=
 =?us-ascii?Q?3nf74Dxqqwi7VujL0kzBMlkLpwLIiahQNHjCz84h1GYpU0CZ/2HG/VZgRE0o?=
 =?us-ascii?Q?larXk60Nh6/7LBpPzfIf3wt1KAjHHKg1VX0eoO48ecakRsWbZFhF1rBTXHJy?=
 =?us-ascii?Q?Nw0jCnFdoQGQxavzuyw5HmqRp2Iz/BfVVG/HjUQ/ejYizpY2wpU4/PlmqpR2?=
 =?us-ascii?Q?28K/pU6OfVnS4H/S8K69dNVeYFphpAjRjLi3G6a3eYuIRMjhCroauRlwFXiZ?=
 =?us-ascii?Q?MDsZiB49cDO2Xgt9+skDjQ96gvAMZM34wFaHfU1p2spZJa5jf/u1+HY+loz8?=
 =?us-ascii?Q?ogyIPvkX+1Nd9zxdKsRLprVmJJ2PtW0tpOPhrvx3Z3zO3iuiskut/mlfifvV?=
 =?us-ascii?Q?OzHO+LuZb0TOHPbOsKxNuCSVj5u9IGAjEH+M8J9xh+USwnTya9IiCiRpVbhv?=
 =?us-ascii?Q?DGFGPDBujQhYYzikFoVzR6EUoKA7VxfXIdER0RU0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b14a2f-e81b-4635-d6eb-08dd30b3fec3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 13:46:18.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD62R3tL39qaQKSN7BIifbABLmIcn9IIEnKWjtfnUoljhbxLRqr6ErYimgYsjrOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785


> > > This RFC is only about acquiring the steering tag from the ACPI _DSM,
> > > which the DPDK user space driver will set in the queue context
> > > of the device it manages.
> > > Setting of the steering tag part happens in the DPDK device driver.
> > > Are you suggesting that I should instead pass a CPU and a cache ID to
> > > VFIO and let VFIO decide what's right for the application?
> > 
> > I think that would be better, yes. Get VFIO to give you the steering tag
> > information, and any related control of the config space you may need, via an
> > IOCTL.
> 
> Sounds good, I like that idea.

Yeah, remember there is a broad complexity here. Some devices want to
setup their steering tag information through the MSI-X table, for
instance. VFIO is the right place to assist DPDK with all of these
cases that need kernel involvement.

Jason

