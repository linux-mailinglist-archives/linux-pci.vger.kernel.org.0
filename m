Return-Path: <linux-pci+bounces-44259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD4D01511
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 539C3301D9DB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D42AD37;
	Thu,  8 Jan 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LlM68Vb5"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2021255A;
	Thu,  8 Jan 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855456; cv=fail; b=hX1d7CwvHFbr14jfCXLsu9W5uuvnz5YdJk9pQbFcWlfDIqXprn5s5149gCbeMLnqLtCAbH+kWYofPoQufu4FHF2EedXKsf8YJzAqN9cx8sa0HOgWLdnc2C7EUKS2DiRQFyOl5+88DUaLYiiQ7cCRm4mtp25DRNvMqag+tUsrNxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855456; c=relaxed/simple;
	bh=/jWu3VW2Nn3np4CreF39U02O4bwsKR4z7Nr/EG43mhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpfmqlVSGkFnvV0clYncOQ/DuppPS+CPG6wf4df712QJtmv5rWFbuoaSw4lO0Emx1RJfcEHN9BJaV2S3ueIwKH3A4ObSE/7bxuPc/Ha7tgdW4se7VakOR1luso/RaJ5V0n96uyTu1vkHo4dtCtFT2ZNECI7IVqJSx1fK4QqSQZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LlM68Vb5; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZD1cbizdzx/PpVpv8G84+2Zbvq7NSoB92JGPjdSSI1Vah8wtTEDxXa0AiCxa94Lz2vC1NaZw3ySzTuizx9Ehpiqpt/Bnx/J0Z/EJdNjxBN2gb6rWERKptX4ORrSgFak5lChEseqd91MRHbsjbf3iU17IFLUOi2UYnCFmeRO+7ES+lcPmBufQ1sLeFIQ51DjZukHAHHlmZgSP63x3EdNtrrtvbRnXh97D1q6cD9xx6MASWIMAdQE1OOMIEpGXfVzHydDJ+/KiQsWGPrurONQjt8Et1Nt+2w11xdeWmYGtygWBByOWKxMLCsGEZ5LDys7BCztsezsv3qk2gfguZUwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfzD8UzB5ieSnZ+f78NKozT9uLlyEIRr/3gbehiBERs=;
 b=JNaoDH8wIX9XJfcEynSb8Ht0KQdLMLgVWZmjNni/O5OFDR8cQ4eXC/6iPu1DG+8vBynNDVFEaazUpU/AZExQ8v0e93TKKalnKnRueEgJfuM+CoAPe+LR08NnbA8mMTsl/LwY0X89ZBGmWrTRywP1QpzaYlNmXCbktSCzt2wbxd80aSSuRiUHAZx0ikthdoDgUhqP/sFHvAdTS1ndtU27dhyjiD6gvyb4ZSgYr3No8MAenQ6Xfs50yAX0a5VxOhn9mDBXNiIFqK+eZcuFDC8MselPOhmxXoSlvjKEDzDwjDHZP4htvV056diWal5rTBIIgjtj4TLS+YENiJoiUd5tWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfzD8UzB5ieSnZ+f78NKozT9uLlyEIRr/3gbehiBERs=;
 b=LlM68Vb5/VV/A4Uth0fGhhDt3w7y7J6S16ukCPReKKDmnyXlHQjxlFb9u9KOH9vl0Xyfns8JU+XcXg9+FDPaRGFlL6+gBB/MMW9ZNfaIHZP4jJuWrxQWsxCfzDiGzSBmEgQjg37CWjTOSXnR3/j/aqN377psHDqYwe18nbWhkWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB3995.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 06:57:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 06:57:31 +0000
Date: Thu, 8 Jan 2026 15:57:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <aqxjlfdqincb4yszn3ngjzvyiuybeoo2pyno4t2iz6ant337n4@bz37hl5nofzy>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB3995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4685acd9-f8a7-471f-c183-08de4e833176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC8bjjOV/DVAos5OV9KKwV0C21fEXA/Lhx+YNcXCN94UYI5MMmuttnetsem6?=
 =?us-ascii?Q?26+PeFl2/QGDhcP0nNSvfiEeHHP8k7uEPfpVOaELbjl0iHN60YTlXohFwTJB?=
 =?us-ascii?Q?fiRQ1pSb9Uwfi/Ymb0pN2PdKiU/f+2q4EKpyy+xDCYpO/m9jCsdmXqPgLoRj?=
 =?us-ascii?Q?/+XJZd6WZvA4nXEQpvXYf+PCdo9VXRIPcvx7uQvIVsLrAukkVzuvD4G9evpL?=
 =?us-ascii?Q?Q6FGIuFbp0xdS7xovPwrNDHxAYaBVU6inHQD1uWfGGsA11DrQxxX+pXiBe0J?=
 =?us-ascii?Q?wn6LlrT/dZa5u6f1s16/PdBM2XJQwoxaOWsWxS7yxXHc5R+e9qGZzOhMNvLS?=
 =?us-ascii?Q?PeQMeGVUjTwoc1ldsIRdO/iC3OhZeT5YlT6wniAWgc+4TkMINtVos1pTW4/S?=
 =?us-ascii?Q?ngXdcebcuHOR/Msn7Jo5ItlcRhhsJGFmirkiHba7UP/DgGCg8QHZURm9eI/b?=
 =?us-ascii?Q?39SxLEB/4kwhZChD33BkvlG5QLUntHSFtSSlV8pCzM5dd1RzXPQN1TWAFdjL?=
 =?us-ascii?Q?77JV5q9POFTsP13ckC3HsVwGNQbpOgYKMLAWEvFK8eWIStb/D+Zzxtjnlb8i?=
 =?us-ascii?Q?CBvYov5AR7hfIC1LSH944IF3GGbsFu0eC4/dbpT0kHhqdabrtTUzv6KTDUai?=
 =?us-ascii?Q?ZpxpKVTZlKqH3FuEOuD7WsDoFszWy0hy2EjvuIcojwBTrFO6dCq2LTtKsNbJ?=
 =?us-ascii?Q?OEBFZ3bQdB+vxrOB7TmGVLBUa/up5stkIZpbV5cUAJXwDvVY97ttBcroxVol?=
 =?us-ascii?Q?oLRlfhlRe+Cb48jw++Njp5CZ/Jlq38Jm/OY+di0+3Xyv8GkuoVbWOFQ5WVat?=
 =?us-ascii?Q?ySrmHdObJdIuTmVrhV7FSM/bpRVyKnI2QZZylp0ZSTn9CMLOXKRZgOhDRFZe?=
 =?us-ascii?Q?Lf9/CZZjcobX1dGOcWsKMN4HeAP+a6LRaBZ1wdie/p4rvUlkPsGlstBJDItC?=
 =?us-ascii?Q?EX3yUKSy1TTyyjQPShkZOEquwnS2wyLlkUCDlQlRbYg8dp55Lisop5l0YhVC?=
 =?us-ascii?Q?HY07jXCrX3cSI43qkX7mva6m9QuwAApXNAUZ7zY/Xbgpq0g6ZNO/Mshuvycr?=
 =?us-ascii?Q?inA1VOiHEPhzaXeWhYiwDVV3RegUFBpSqCrTdIkRpRZMLOi0RCrx7iDk/qr5?=
 =?us-ascii?Q?ZkE6of+Htjm4NZmIB4/TOUFfi1C0Ju13VF/y3bzvUxBdk9MOvG+ovSmApgzH?=
 =?us-ascii?Q?sTgjU34AELfHhpGwHDfFab16o8yL+aC1lwcusfDtkz5NNMVWrqos24k0XmA0?=
 =?us-ascii?Q?03ShTg6pQH1sjL93E3ZNd18+5++cN9ArfYdtTgGjw9FbyvmIS2MmdQqNVRid?=
 =?us-ascii?Q?sgtr9HI5HhM5rSElsJYHrNTiXS6G87GAwWlNJFPQngJUXXl8dW11mYF712eQ?=
 =?us-ascii?Q?/yDhv82M7MmJBw1pkerOODuuAQtLhnug5p5oRXGaMv+dLItB6Ta+3rNnSpGu?=
 =?us-ascii?Q?Y3pujvJ8riFMpx4w1MSAyDM1c0iocLmamYfVGxwp6p58LfXMH5VSJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJl5OGrcG9SMCD68MzPCJjuz8m9ZsOLooBn5bj4EmZCncZUVcUnTF9+Sfllb?=
 =?us-ascii?Q?+lQUOeB/wupytQBt+M6FsBSsMjjLa3nL+iOTzxzr/1qck3JNvtCqL1FlSTfR?=
 =?us-ascii?Q?V0u1pWh6X8e4TfEqeLFe+KdzkSixBsfY+OaMw3HlPRXnepWJiqivWtisxfWK?=
 =?us-ascii?Q?loabocT3+5n0uiFH4121/r3Ge1CjBSdOpggpbUyx5e8rSjhFfMhc462ruRql?=
 =?us-ascii?Q?oD/XpC5jWEcoR8g9WHp20uPDSik3Yg1V+Wbfrs2HvCP39d216JBQevPNjDsO?=
 =?us-ascii?Q?/ugYnaRzn0xQFKoPOqEJF6EBfsKcOOxHMuEW9A3aa/IjC/ERww4DtfrBJdzQ?=
 =?us-ascii?Q?2UdDen+vgBfY3KWwGG4HoDhBhjvs/Fd9oL2WsoxMWC+dnZmFPVo2JvH7CG/M?=
 =?us-ascii?Q?er1mS8CLwMdtLGBR7pKYugYvMDI2uzXeOpVyXH+0BGR7RqrUErLCDhISzMUH?=
 =?us-ascii?Q?J91crvmdCGEimJUURrOf5DWlCeulJBfIR+QEg1sHzu5P7+8YXj2EZLWvjdnh?=
 =?us-ascii?Q?VPSyFkfAuYgumYcHQHd/f61Z79VgomU4LhCtVk3kD/RZHLeL3McFvws4YTQQ?=
 =?us-ascii?Q?fLJMAvFtNCzUDI6pxL1CQv6Fiepzn3tqkXX0BKPOXza16Pjid4XIXdz3a9LT?=
 =?us-ascii?Q?AcBBwNemooGdon8OfhB56eL6VjQ9Kvl8ukLEPfV+x0cdVJDhSAzP2TwgZvWs?=
 =?us-ascii?Q?XhqhT20xTOJkK9NUBmWf/FA62urxB6dkBcepLwH5+DGT++7hwlFfVI7dWZrl?=
 =?us-ascii?Q?1fzaB+TKwTJlMY8jzP/65TinyXh8lUibDWUIC4z1ElWg8OhCpfMbbRIkzgZN?=
 =?us-ascii?Q?GcFUzDhZxeGwBGkAiHto4yEp9syfzRnYYnLjNUDtOqdCxSvJm5kMOcJdc5FN?=
 =?us-ascii?Q?1Xjkp1vZLllmlBFDmPZJZKBUfczvQ5c/yrFYOyIHU4hehM/PepjVF+wfXV6F?=
 =?us-ascii?Q?J7rRyfiSm31vfAVeQafwcKGvGikusWWzLRNcWWRznjByiK9MjjrIu0LiP59T?=
 =?us-ascii?Q?1wUn/Emsl62WvPNhT0t7yB9brMGjIteUdJpwybDdcJHPpTJhac2naQzegUNU?=
 =?us-ascii?Q?gGOmtExyYwQ9L9Dbp8I7vYVabMIEVzZtjBJLXSfGgfKWIYKwN1VNafsnU18g?=
 =?us-ascii?Q?ceDvIKJbHf/701dZWkaCHuJ+LTX2wjafT8bSio3N5QuIyxH6aX9RQ4F/pM4E?=
 =?us-ascii?Q?EE/ZVNAzN396bGMi6WqClPvqqss0zezURqAFD/oF82/7G+lScf7+1oMbkiSw?=
 =?us-ascii?Q?/jzbZuVJBnASs43riYV1+6RpAX6KCOhRGb9hKPAszb4soGAHyOFTTNE+MNZZ?=
 =?us-ascii?Q?jQEx24kGmOJ6bSExabkWFg5NWGZhwrXcSMWw9Ke29MYdLJW3JhO0REqsZA1R?=
 =?us-ascii?Q?7CSE7zSuWh/ZbZjp7T0n7k1Q2T7pnwfdCkEi01SbdQkH3KhSl85xLRI93hEb?=
 =?us-ascii?Q?tsOpH+FYnt62df4FuJDwUrwly5+cX9DCa8J4JX1FZbJNik7F4BLZvWsuea9A?=
 =?us-ascii?Q?bIsJOkSeENjbzusqquuNZWClvsOmhkEK/0ziXPdi6VZVeeIIISyyaPjYAPCb?=
 =?us-ascii?Q?yzRfDHBlsRLFo6zerJEPYtZtAExIEzkOcNXuBjkOXi5lX7CB+MpDqHek4IU0?=
 =?us-ascii?Q?hgXjQ5baaPCuxKnd0a9SINrJ6s6WtIdd6EpLxRbYCIz299AausE/3Ia1NLqb?=
 =?us-ascii?Q?7N/Yl2PVKyIF8mFLnn8KwqL4YxAfRaG1U/LrLFruG/Yj2DbvX2gRWDzkGRyH?=
 =?us-ascii?Q?o+lL/Qp0pSDAYL4xXNe/oSCryZT/tKlNWtiToc3sEL+gNLkkkKWa?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4685acd9-f8a7-471f-c183-08de4e833176
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:57:31.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30SfUPCqWivv4W9aENtKZuMX0Mi9xLDLXFHThQanzlNz88SCxg6dkut/8WRTtxNY+G4fHwXH2fMBS2k66Jz3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB3995

On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> through configfs (link/unlink functions, start/stop the controller, update
> parameters). In practice, several pitfalls present: double-unmapping when two
> windows share a BAR, wrong parameter order in .drop_link leading to wrong
> object lookups, duplicate EPC teardown that leads to oopses, a work item
> running after resources were torn down, and inability to re-link/restart
> fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> incomplete.
> 
> This series addresses those issues and hardens resource management across NTB
> EPF and PCI EP core:
> 
> - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> - Fix configfs .drop_link parameter order so the correct groups are used during
>   unlink.
> - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
>   avoiding crashes on .allow_link failures and during .drop_link.
> - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
>   vNTB PCI driver. Switch to pci_scan_root_bus().
> 
> With these changes, the controller can now be stopped, a function unlinked,
> configfs settings updated, and the controller re-linked and restarted
> without rebooting the endpoint, as long as the underlying pci_epc_ops
> .stop() is non-destructive and .start() restores normal operation.
> 
> Patches 1-5 carry Fixes tags and are candidates for stable.
> Patch 6 is a preparatory one for Patch 7.
> Patch 7 is a behavioral improvement that completes lifetime management for
> relink/restart scenarios.
> 
> 
> v3->v4 changes:
>   - Added Reviewed-by tag for [PATCH v3 6/6].
>   - Corrected patch split by moving the blank-line cleanup,
>     based on the feedback from Frank.
>   (No code changes overall.)
> v2->v3 changes:
>   - Added Reviewed-by tag for [PATCH v2 4/6].
>   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
>   (No code changes overall.)
> v1->v2 changes:
>   - Incorporated feedback from Frank.
>   - Added Reviewed-by tags (except for patches #4 and #6).
>   - Fixed a typo in patch #5 title.
>   (No code changes overall.)
> 
> v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (7):
>   NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
>     share BAR
>   PCI: endpoint: Fix parameter order for .drop_link
>   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
>   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
>   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
>   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
>     pci_scan_root_bus()
>   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
>     teardown
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
>  drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
>  4 files changed, 62 insertions(+), 91 deletions(-)

Dear NTB and PCI endpoint maintainers,

I suspect this series may have been confusing because it mixed patches
targeting both NTB and PCI endpoint subsystems.

Should I re-submit [PATCH v4 2/7], which touches
drivers/pci/endpoint/pci-ep-cfs.c separately to the linux-pci mailing
list, and re-submit the rest of the patches to the NTB mailing list?

Any guidance would be appreciated.

Thanks,
Koichiro

> 
> -- 
> 2.48.1
> 

