Return-Path: <linux-pci+bounces-45177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B5D3A9B5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACE48301E6AD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78943363C4D;
	Mon, 19 Jan 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZG7BDXiB"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192535B12B;
	Mon, 19 Jan 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827645; cv=fail; b=t92tZQFRmsg/vkjbAsycY89DQ0lbZ+dNh7XzzgzzzcQktl02ugGZ/duwAeaQ/671ZCoDYlMnqmuTD9+/hRgiNNpNIv10VNrxRWMG+KBvLYPjfIA9xluyjGAbjpXSaCADD6OIuLeMhIHVTsRo9+cU0P2jhB+NCxRC76X1aIZe3L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827645; c=relaxed/simple;
	bh=5yvYvcsCMwEnxsODv26PAt7cYXlxR+Zp/NeW7oMuoa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLYsWCGRd0867m7NtjRy6McHSNQL/9pRbaKRNMBZAllo7+RSoQAlq4kuroDpNt0NaeVFG7yEGUXlWp02pTkParqvQP55FSr9wb9XV6Z8wmeYfJlnlINy0fhjDr810sfjCkF6cnAWVGngKnT4HFTsU7Xte4xtXg0FY++P1Mt55Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZG7BDXiB; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSlSz19VyqKYxuFkbe4eY/iRusDhQ7VV5tTUBgLXvd3AIqXYpaqcDTXeYCqPToLz0Cb4syC36S6I1W6F7SPw29Q+gJMXqbcCduyEUUyQu3KM0GpEKcYdsDjM7DyHLpn90LYX8qbBoZR7r3NWvDNLO28X0R4J3vPKkSVJGQ0mrvPeWuyovoRZOsSxQRF/GTNci04fp7Aq6pKXzGvj9kSB6Sw1QRlv8O96/XzjbfrOZ4jADZfEaFrbK2BYsxgaMTD4stJzy5qGRphnynDUMrkc+FDiz8P66iE7BXG6iohp0FX/v8B2H3D4LtJ/JaaVMWgSuziQieeuRAn2XYVzE9AlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqBuenOQPSkzIfRDehZAbxFXsFFS/NxGPwvRCf90uyg=;
 b=n/7US/sX9WF3xT55vxMCzMkCSzyaKVS9jzVMcIhVceuAxAcnuZkWsbpkZBcDwS6KnSbQy1scOpkACSjYqaqLN9VrCqWdpY+XGWhqc0q+xWyc2BV/qPmsl3viUM6eDH7eDKyhPZoLrNTiRuwEUhxm1G3Tx4wphbdKEi6DXEb4ai+MQbQRijQIVvJebQKoAM1fOey6FzMz93jHGKDXyZDUJmlMcqQkmrtB1Plo8f5832+wC7zaHjsa52mvsCRYbF9pOrAFOWTT5W+iZlx7+eVMmoQXQg9DLIrgnHTxn2OmtZNr7rop5iA3VMnnTH8pFEZmFTOMAydVxg5YM/zKcXnGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqBuenOQPSkzIfRDehZAbxFXsFFS/NxGPwvRCf90uyg=;
 b=ZG7BDXiBA3Lfe8rovT773Ngg3RJ+89ldQXYVC3NQFdMPVGL90bHH9TvdasCisQSwwiiTmHLdIOLdTxmsaEJbPNLpJk2uLbbcTCiYTzM0ZgmboriuaRHLQIaWEmt7lZ5mip3xnFp/ABmP0f5hFeCwkHRcQqG/HfcERzLYI338xvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6428.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 13:00:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 13:00:39 +0000
Date: Mon, 19 Jan 2026 22:00:38 +0900
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org, bhelgaas@google.com
Cc: kwilczynski@kernel.org, cassel@kernel.org, frank.li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
References: <20260115084928.55701-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115084928.55701-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6ef676-f9b2-4467-3992-08de575abf02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RpcvbBDV6DX+iOCs9PsY48uQMkxI7nixUSqAljWTeJv8AJFp4xY7PJAnCsXO?=
 =?us-ascii?Q?9MR93iEYOYo4hJLIAElVOTI+N/H7Q+bNMqx9clo+ObNg3eo4BuMQ3GI7F9nq?=
 =?us-ascii?Q?NwXe/DXsVs+zYiFAp1uFlsyvGsXtOMNZksMxkYuljqxvKI+h/TtfsavCs+4h?=
 =?us-ascii?Q?XiNTQFH7g+9ZBpjhm0nWxJPwdbo1Yob7iBt/A5+rhpr6SYU325t7G5o0iV38?=
 =?us-ascii?Q?xW61nEGNKnFcpqNE/B+a+2WYo/mbNhRaAThqfYbhHZ34AUtQgEhyFYTmS2I3?=
 =?us-ascii?Q?h4HENBdDkaflYCjYtuPB0LnlO4R9po9RvPnZGb9dqQ/V+syYv0uYYe3BE20q?=
 =?us-ascii?Q?/PbviVtYoEX3y/Xd5g1fBq6ePO7M2BT8bHAj19do+S6wXmCrwiZ3aUjqWnaL?=
 =?us-ascii?Q?5Os74zT5zbwy3yn8xmfjQ3GsOvtb+Nowx2vMmpSwmjmd9SlM0wBO32WLkTMf?=
 =?us-ascii?Q?YsJURfRCnS39J94m1dHUCMUAkDfMMJqnryQkDG1kRWyr3LXxfOY4vuSN6194?=
 =?us-ascii?Q?QSozh7iEPiLDLDCyev2zqYbJZ8SVAYf3vIpBq/AEUPy331jFInBCNQz3QQVl?=
 =?us-ascii?Q?b9E35KtmlfjY44GoXFNB6x6RaPY2zFCEkaELdGymecg3PDIp5pxAY9/fOD1l?=
 =?us-ascii?Q?8k8C8B9MyhZ8WkFoP00r7+maOEytYdBZwqyDZgf4bb7XI0vBlgDrcQxYCYqW?=
 =?us-ascii?Q?V6ce1rFcZ4esloX+I3pkRJ1XNyLoZXj7AQs+FP0faOXP078kUdwgdlzsUB32?=
 =?us-ascii?Q?Ci0WP0zuZlzsx02vUsJtOfBmfmsVvdf1Y5ftrObjtfSFdRksT8TAX8faLWDi?=
 =?us-ascii?Q?1/Aw7DvW00L6aJjQA657RpyAlGVcVIyG+t9rVCASpEvOeo2Lpqco49DoPic1?=
 =?us-ascii?Q?0hdtodbQ6V3V/Vti+5CUG94nFJ2L2nd/MofUW0AW67Ee/xtLCgPDhwVUK1oC?=
 =?us-ascii?Q?jJV61nww9KzX4W0aLaJ6CyTOHazu3oGu0TygfFd719usVzHyRCyqMlsKJYgl?=
 =?us-ascii?Q?MtSSG3NVgETmweYbTyog/6RbqsV0ErZwdr1z0lMAIjGz4ZWs3JP6D6/YUBJJ?=
 =?us-ascii?Q?dlHftFnJHez733CaaHJ0YkzFn0p5C61v94dNWaEHuqFP+PqQlAERQxc8gabT?=
 =?us-ascii?Q?5XHbFlVDbUMTtcmTP+Oe6Z692fqD7Rw5rxuaQugMlhDfqp1LvRet9E0ZlF2s?=
 =?us-ascii?Q?Vi7LoSDuHIzOAno68Wy1YvijJ4KA/nj+ERI4bCWmElwMMZdM34P1mDX3PzPB?=
 =?us-ascii?Q?TWFqmAgPkzX7k5rkfsD0eHwGLTGLoPj3ZrF+ye9F3qIxBtMKyfBF2pInHd56?=
 =?us-ascii?Q?xD9np1Lu7/vuhISgGt82WQSPeeI6p4RazAZsf5M+r3AZSnny+f6ZJstEuccF?=
 =?us-ascii?Q?ZlCpZ/4XSzD63RwddmT19ePYVjJb3XKvKGGSaK4fm+JlKZP+fsfPH0Pkkzfm?=
 =?us-ascii?Q?Xz1it/r8/A3RKx+8TkWTbFzI83nVQMgLVeN6zKf34/CwzQopB/AxXaR1yoGC?=
 =?us-ascii?Q?DpMfJQgxXvCkNFamJqbvu2Ruq1+FMiJWrCNPkhPOz6dp+XhJs6mrhqbuZ0yI?=
 =?us-ascii?Q?H6H8oOzBVMMs/bXpFOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKiFFNJ53O/LZ9n8l9MjAtklH98UFG0RTOPYvNEmL9ZkAxStBh3UV7TIGbCV?=
 =?us-ascii?Q?NnwioPj03j5RteMGlKXoICRGSdFnWyi+cLcYGZZJg7D28wx1lTWk1q06Uioa?=
 =?us-ascii?Q?DTtcL03O5agE+EivUaczZ2WsR2uZZtY5vUqLhQ69r4EaVkfIQQOiFlKjp/I+?=
 =?us-ascii?Q?GizrAvj7hseGrIilDrnKuZFd52hDu02RcXBocXCuoUNdFTUXTfpJGS/qNaTg?=
 =?us-ascii?Q?+Inn12CS2ilaDwahsil9V4se6inboQdEIS6R96w9QJmnJK5CBML4eW/rnOR0?=
 =?us-ascii?Q?G5C7tcbB31IcqTYI0RGYNHwof2yBjo+J1yy4WMxGuqK61/7Y1ok61gpGtPLv?=
 =?us-ascii?Q?SrVLolAnj7d67nuCep7hHUCj8YvKL+Tj7BSr7ldjnvI9j4xGeIj/II+CyMPV?=
 =?us-ascii?Q?LdPXXScp536gOiwwYafVrlxovvVettX8PEMfmbUAL0Yvs6Ps4kSobXVd8DEu?=
 =?us-ascii?Q?OOfsQ5/2zGi4ta7s1Ko1j+LCdtBbAi+HXBxkoGhYrIIFIGWX2GkyzuD2Fgbf?=
 =?us-ascii?Q?kW+UuVitOEvNpHwFWv7/mUl+JPesodFVVfJwls/x71DxhlOhkaScwNopL7em?=
 =?us-ascii?Q?3ZaZ4iCmfaG4SFcJBFIFc9n4zROjclEVE3uUxIfMv8GDvCOFILmjWervDmWc?=
 =?us-ascii?Q?YRYdkYiCojDlWozUvXl+NfJ+ffehVPbullyEr2K4Txvn6OtqaeBPAzGVWVDF?=
 =?us-ascii?Q?e5E+fVCoZnPiu1sNJ8ynenFtbxdU/k8Ylav2V7+FUV5uR+8UR3cQWQqBig5N?=
 =?us-ascii?Q?x8huT5J0Sy1EqUB+Zl2tf/Sr3MGHbE64dPGXzAqQIM+Il2Cnx42oa9p86aRX?=
 =?us-ascii?Q?5Bo05kSCm+/qXKexlnWPiHfJyB6OoMMzqmWV/ipbMAbSxFoArytLE2J5zrNs?=
 =?us-ascii?Q?2+RQEQIDXA1a6ca0lrzKJ1TF5C1HIA+eY2e+oCzZtJuldvaeM4ATCJvPH75M?=
 =?us-ascii?Q?iluX7vsKuh/xqPmEJjIy+CrR+bB167GTx/qMQOxQN3EY9Uf0GVP53UyvLyG4?=
 =?us-ascii?Q?Rl8N/paGWCSlJhNrAjRD3Z2Yfl8gq4++Bv5k5LmMGJYXbyVr7kjhm0EtkX6v?=
 =?us-ascii?Q?RpZXM3G41LmretObKeKgQxkyYW13ufHmzB9AHSMWCNZjQOhqG9Wr2VpSEoh9?=
 =?us-ascii?Q?glJhbAZjIK5i3ZvnkBllCxMQPu0ONzveSTy5SifR6Wiwm6GoL9CKwh4GUEfk?=
 =?us-ascii?Q?3/7gR9wGnNWBiWdXWLC+/xq3eN77VwknZrL2mTMSqIWPznXRK55Wv9yqnSSb?=
 =?us-ascii?Q?Z36DCZEcthuokeHws/Toti8aKC9sxa6qHolqu+eZQXd+m3ilSpTJa5JqDM56?=
 =?us-ascii?Q?Cfpklr89ewv0ORANV4Z1TMEluqNulOFMXkaNc6/m1fHxj6oLm4UyYGduNs5c?=
 =?us-ascii?Q?SQq5vTPLOg9PuMAqle8KujO4wvwof375egrLx2vlLs75Cg7cB6/6LA6JDZz2?=
 =?us-ascii?Q?EOMEwyPrueMV7MuEcf+SfzBtbp3jPy6xMs/wCpBNA86TUyziD/gaekQG/B4e?=
 =?us-ascii?Q?0+juMjZAJKnhpaQG3T27f3lZW3+sNzVoZrdT0OF6WMjNPCOK89j8XeE7Kax9?=
 =?us-ascii?Q?YBoltJsph0eB0/3J7dYec2XFVpCqE2kAytlffPhTbNb9yyR5KJOP6UQa6W66?=
 =?us-ascii?Q?OVUxmWneS+25dWcuQZ/Awzr3+OuFhkg81R6LOznsB4bWh+hYXk79OQpf0ZtV?=
 =?us-ascii?Q?kFxBW2vR2QYLBcf/HwPeXk50qg8pO+CI79IDmSv4MjDyX1JUYta8pxodIcWV?=
 =?us-ascii?Q?t29zWSWzrYfRUAGdt+5rn7x+HEHJM/xm6yUy5p1sSHcJJlXcPGLR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6ef676-f9b2-4467-3992-08de575abf02
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:00:39.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSyfhU6HwEZ0UbUSQ3UV7RlASaKuSMkJpYlW7iUw9B2yEzr5M2+0c6kRotIUTgtEis7P/rP4pBe4w2i3456zww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6428

On Thu, Jan 15, 2026 at 05:49:23PM +0900, Koichiro Den wrote:
> This series proposes support for mapping subranges within a PCIe endpoint
> BAR and enables controllers to program inbound address translation for
> those subranges.
> 
> - Patch 1/5 introduces dynamic_inbound_mapping feature bit. This can be
>   used as a safeguard to check whether a BAR can really be reconfigured
>   without clearing/resetting it.
> 
> - Patch 2/5 introduces generic BAR subrange mapping support in the PCI
>   endpoint core.
> 
> - Patch 3/5 advertises dynamic inbound mapping support via
>   DWC_EPC_COMMON_FEATURES for all DWC-based glue drivers.
> 
> - Patch 4/5 adds an implementation for the DesignWare PCIe endpoint
>   controller using Address Match Mode IB iATU. It also advertises
>   subrange_mapping support via DWC_EPC_COMMON_FEATURES.
> 
> - Patch 5/5 updates a documentation for pci_epc_set_bar().
> 
--(snip)--
> Koichiro Den (5):
>   PCI: endpoint: Add dynamic_inbound_mapping EPC feature
>   PCI: endpoint: Add BAR subrange mapping support
>   PCI: dwc: Advertise dynamic inbound mapping support
>   PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
>     Mode iATU
>   Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst   |  24 +++
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   1 +
>  drivers/pci/controller/dwc/pci-imx6.c         |   3 +
>  drivers/pci/controller/dwc/pci-keystone.c     |   1 +
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   1 +
>  .../pci/controller/dwc/pcie-designware-ep.c   | 203 +++++++++++++++++-
>  .../pci/controller/dwc/pcie-designware-plat.c |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   8 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +
>  drivers/pci/controller/dwc/pcie-keembay.c     |   1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   1 +
>  drivers/pci/controller/dwc/pcie-stm32-ep.c    |   1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +
>  drivers/pci/endpoint/pci-epc-core.c           |   8 +
>  include/linux/pci-epc.h                       |   9 +
>  include/linux/pci-epf.h                       |  27 +++
>  18 files changed, 285 insertions(+), 10 deletions(-)

Hi Mani, Bjorn,

Based on the feedback so far (thanks to Niklas and Frank), the design seems
to be converging. At this point, I would appreciate confirmation on the
following points before proceeding further.

1) Does the current (v8) approach for BAR subrange inbound mapping at the
   EPC/core level look reasonable?

2) From a process perspective, does it make sense to continue this as a PCI
   endpoint subsystem-led series, with the dwc-specific changes layered on
   top, or would you prefer a different split or ownership?

Thanks,
Koichiro

> 
> -- 
> 2.51.0
> 

