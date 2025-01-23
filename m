Return-Path: <linux-pci+bounces-20289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC384A1A75A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7A37A1FF0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA56F4F1;
	Thu, 23 Jan 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUmocuwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D22288A2
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647671; cv=fail; b=H+Drs2qLjhmpVeoqh6jhze4+2q/c15aTjGd1cul0twEre7/y289rpV2dn6YRIDykVH9tHM4yacBKQc8dbK3nlEUzp8UjU3TTrQKXbrqwtlrwh14gT736n7J0NXXT6rIx+V9f4UBmGINIhmqb5LA9yGMc9wqLJa+OpTWykN13GFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647671; c=relaxed/simple;
	bh=mWM4b5E8iqR5hwZg7soNRIUpO5Dev4vRlriuC5uY0XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iXBQ+GVdydfktodJNPdgW2Pp5YvXamWZEtz+qckcDaSNF0a8drn4C0DBibiZehHt4s/rYFmvm4BkH/uvicWIuYj/xMadOTwSbtcYy4XnLfORYPu3xUutdmp4fxS2D+nkjIs/C5990SgPbX0w2UOHsolh6iozXiwkJMJEChnoh3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUmocuwY; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue/Ynv6ymY6E7svfubt2WoE77rqV70sb2CfyFy6nDPDuKfAn65w4HSfwmWcuFRAHGt/lFOmlcgd3mFjIHwSdZWlWmwWQODnlqXHnPNackgae1M89+PDaZinzWSezZGUJKA0RzaDn3ll1hmrPkSx9KqM89BPvtL0SRF3XdwIb0xSC8oiUwbuNqpMhYtL0fP8xxZZR4JmGAKTNfS612714pX1SZzh6vjmd+TAMyk3+ksO0ITcb2Iz+2h2TXFv0uUcOUYVUvIvwGlnW3RH/621DOFdRMTKXfbbA4kBg1NBHMVjyW9nnb1+ptB7V5tew9j+m9Y3jhS+ZCOVLQAAuCh5Qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef3MJePlOABtfVX9ooPwzmAcz+T2PZ6x4KxKDkCCfBs=;
 b=w88lehgtIe1Qx1t4Fjn6zcycXQy7glmjtK7jNMt4cJol78kr5VaOkkpsZOf1iQ1vs27DLtwhofnapYlznyaTl7hEA9sjYJNbCnul4bHMAEAdmMB2dmJr4ou1M0IhMOCbVO0iKcnkB8VEKedarCdPv2EVYi7Vin/jxoibEMoZYo6Oe0DMX/AjzCPmli6kmj1IL74GrgdjQIlfTOr6Rwneyhp0Inwrk1PCD35ejWkg+uPIgb5A/W4NGFwNmbYo67zPIFlxipXIYL0VnSYQ9hnCt64+NZRcXU0d5u6+Q6W33zgF8p2ab0JhuTuDwhNRmODVZRCYWBxCps9rfcz1C/NBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef3MJePlOABtfVX9ooPwzmAcz+T2PZ6x4KxKDkCCfBs=;
 b=jUmocuwY6cK91C/nw9Q9wLBPJhcG7t7nWiaR1A15OF8Q0qA/TF/tjWo+ECKSf6Ux9/QWj/ROxi6TUfAKdbfQVdoCy265r5uLXdIjOtcJTjPum3Ml+SESAm7TnGf5VYfx+6fIH2ahHSrEtCJm+Ru8Jj9HzwqLJVjYS3/LfO+TlKn5r5n2c0FntR1/Rqr7Sh0qfDJpRIfre1InQ1LyD68BvO8kR8IyUCytIfNVwnzvoF3dAlKOYPVMsKq84VQtj5SIk1n+NSIVLaPfsq4+b/r1siVo4JOQiujDazv5E3IJwgdsvT+ti0LssUUmcVxqD+24zFP7/7O5LBEaZWHdyKjlmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10449.eurprd04.prod.outlook.com (2603:10a6:150:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:54:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:54:26 +0000
Date: Thu, 23 Jan 2025 10:54:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <Z5JmK3tAtNi2K2bO@lizhi-Precision-Tower-5810>
References: <20250123095906.3578241-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123095906.3578241-2-cassel@kernel.org>
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d0407c-812a-4ebd-1490-08dd3bc63679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bciCrLPiFd1L3h8xkALkIf7W6GFmo6heTSRJw4WITKdIeHk0ja/Y+RLXQiEK?=
 =?us-ascii?Q?5DirvkGQ93ZCRvXMVw/qbD2p7CZku4hYZpITzdtjoyES7/v3Kd5IU7eBuBeJ?=
 =?us-ascii?Q?NnMmUXc4QEV4MWwaLMMpycI7ltuQ3pL/2CqC88ocTQqii0evTrV+RdzL7J1r?=
 =?us-ascii?Q?q9s6n34d8Lvc1AYSb9Fspb1y53AS0B7/STQqtamMJ0Y4nYtBdM7tNQ3iUMCi?=
 =?us-ascii?Q?jA3UPcxDmgOa9L/1HJ3Cz9b+X/mfrBjYF+8D5ePa5WV1agR6z03Wib+Aj4xi?=
 =?us-ascii?Q?iWBK3c/5S7riyxq1qePR9NK2ALGicd2GyRRPY8ypwUHDPtnZzGNm61gRbr42?=
 =?us-ascii?Q?PZjyBO8UTiL4EduF1Z2HacEbl0DWilBnFtkYUTigW1J6u1LynZCIMD8uG88n?=
 =?us-ascii?Q?6yo9YVTYk/FaH77m38zMUgoWdeIWlFs7iDjDsvBQ+k+w6i3CldcivJYyeIvJ?=
 =?us-ascii?Q?XfI1oyJhXOrKeqix5J2ALY2wGT+NnG3RjLizMUO8/2R5NRlIGWCOeXXEm4gu?=
 =?us-ascii?Q?DXqeibuYbss+MmzdGZfK77hCL9Jbwz/6ywKyJyHKnDHbOR9i++dVDAsvZVyE?=
 =?us-ascii?Q?CAZhsJFFNgdNYMiKDtVXUkTnCGDePb6UCj4Xqi8IC3E4We2Ec6zfvpmY04Cg?=
 =?us-ascii?Q?tH8llgnB3emIWR6WN+cR9ZksM3ziZeJ8gi/X1OeFSkQ9GO2e56vdMPTNPT7S?=
 =?us-ascii?Q?JQrg7Yu2wvxk4GaCNjwjSwlvvJpUdxJZX8jXFgsA741ApXJMcNDaJuhzkb98?=
 =?us-ascii?Q?bhbLWkQ8kzwLzw9laVc8fo9mHnKu2zEatENoMgEB6C6i42ReQyb4Is4TT6Uy?=
 =?us-ascii?Q?+Lg+m+I1q/4Ftb5cogWqMn1yBQ2rrym/5KG6SrXhDJWvhvvpxAwAsjrMBFY3?=
 =?us-ascii?Q?QFn36rm3JOJpLIEahqVQ2SlSX4Z55KzwXw5kktUR/QxldX8kReJXj2XepY0S?=
 =?us-ascii?Q?+RPE80ilH/iq64Zk5cjCLWGoS/r6ntsKbiTvG+CQE/2eNkqFB9LJNZMNgVkE?=
 =?us-ascii?Q?HyB/sbBRjeUSFa7Q5+RAOlt2Ccfk4wtJsYLQh+CIPhUZ30iDetdnn+GtCQF8?=
 =?us-ascii?Q?rCxj+BtnyHKmNsSptMbufSpPcci0ljDQgu/lcTOZwxj/761Nt94rIAA78/25?=
 =?us-ascii?Q?DcsQghKymBhhlDUDXNkWyFZ7Lg0GcM9MRlJJORDDS3hcnPlzVHodqmHFdK+7?=
 =?us-ascii?Q?Y5bZ8EPzXJUoDyIqUVw/iHDqAW+Mnvr7UjATJ04mKLQPjUpN/5Df2uQHoGXg?=
 =?us-ascii?Q?13gy16QOl9/kZrp+4zhla0/iPbz76h0ecz8IopYITdAyLpoyrAME3fsIEmr+?=
 =?us-ascii?Q?Iduj5VxQi25QkvU6JyURMtqRTwMrbh9wzagrf4AHpFrWW9f62XLYsGlRr8CN?=
 =?us-ascii?Q?fFXpGW+H1jK13D6JRpbQ3H8JDlTVNrvhusI4KBw2//aR5fGqMiRhhiaz8BUT?=
 =?us-ascii?Q?ZlYXDC9fCXSZJEkp9/KYZBuCGMsnni9X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueMGWEY7p5OVIjnuvB3tMjVyqQT71JYjjdKBGmj2/p413lVlAOHpY5qwoXnn?=
 =?us-ascii?Q?PW3XN/tj7AxnFRfyCgCnYDrHIXQoVQH5ZVPIH+ZYLI3uon0NRpPwLPE+5jei?=
 =?us-ascii?Q?aP1TWmpX32LhIlROPTKmmuFxUi00HfbyFN1kukumfjFAMXfiWiOHar+DqvAd?=
 =?us-ascii?Q?SDZKbCRfNv2Wftc8m7PUbXpFjDsjUQsAZMUBZQ7ggX226LRdSdS+E5lcSsEd?=
 =?us-ascii?Q?ZcNHHnqUYag2+ya5ssKcTCGncf4l5HOd42CpHjphQUUrVmo1dJISAar45TqG?=
 =?us-ascii?Q?8luNADtvtvZkmc6Fbaj0DKozl8G/+xboQb1g447Xxjfg1/WVNW6Do2lrf2sx?=
 =?us-ascii?Q?IKanjRPIQn6sgRfAw619Mwv/Kpx6LvPQctoqd9akfYi5l4ceWqgDnBicl/ah?=
 =?us-ascii?Q?8gl/LRL9tKUXrQyHooezAY7DJxjKjVTfntpRtQ6n465FAqaKGtOlkn7Kji+a?=
 =?us-ascii?Q?8JSL+rmdEGY54dqPl3u1zEXyPD2gb9nCsEcuXgn8bFHXeaflp6fHkKfpZ5M8?=
 =?us-ascii?Q?QLxe06Zu0K6pkirE6w7CADer+M2HCTrCg7HKz+dcbOuBbripDhvF6x9R78t5?=
 =?us-ascii?Q?xcRUQJZxeGjsuoiKLW6xGLoPFvlu57CFEEeTbX5GledxrUshlPPZnK7vY4BD?=
 =?us-ascii?Q?XNgkSQ8Gl8pXzuoT1Baz4hmkaX9GMBGKG50BtzLYY5w8hKWKk8PAc3IidkgB?=
 =?us-ascii?Q?tG0BHH63A3SzntuLTAHWYEb4Q2jGWzN0IdPPmNnKO7G5/Bc2qnG/3c2Jq4eq?=
 =?us-ascii?Q?7PvvsKIgpxUcotyQ4JJWR5Xw27Y7L8HVt7VkRMaILUBDGqYQyahfEZo73ULQ?=
 =?us-ascii?Q?I2QK/hHzXaGXzJD4LpuB0PsJNGrDaJPlLTmOX873Q5LwrtW2C7ISDFN2zVEx?=
 =?us-ascii?Q?/PQsLhEHA73EbDkYTkbwRdM1L9Ex5TI0NTSxbrA0rhASadjxkyv03Ce98FOt?=
 =?us-ascii?Q?8yyG++S4RAudOiUoQotgNMHB/cxcP9W19h7TeT4riP4NQnjCTryaCdPG7BQA?=
 =?us-ascii?Q?Ot9U9o3dubIcV2GDUdd++LKbwW9aR52QZoh7dXTUA4qrAJAXBS/VIlhlezOP?=
 =?us-ascii?Q?Hm0ixWLfMlrKk4XNDgHbS/3WIwNaCuW8dGonaX9ntLQjGxEf5SbwRkRrHj37?=
 =?us-ascii?Q?mJGipCj5b6y4JdfxZOaUA5ocfWAci58p/u1WrTeCYAP3wUs0KXLzsV6dN3m9?=
 =?us-ascii?Q?FHiEVdfXPp3prvy++ga0xvs0MNZ3ugcKfozQafYJChiTxMazmqk7nYIxjP+3?=
 =?us-ascii?Q?uxUt6ThbTdgVP0ng7YyUn0SCa1zvG4GGbxmQCwnk33eYD0wjxWoas+rnHbPr?=
 =?us-ascii?Q?h14G6tdPMK6iylG5+6NMskA3r4O87vHCRb6woL4pCVB3NsdZz2KRNn1OQNrd?=
 =?us-ascii?Q?Yg9AeBqZvkvKyPI+Bx1RRYg5SaLpFhTrdntaDxqbDWBp/wjVwOE4gaii4NB6?=
 =?us-ascii?Q?zKgnzfG4npV5lJZceOJeecCDIZhDux2ZvSEhTuc0Hn78QcMorhgFCkXqPNyK?=
 =?us-ascii?Q?rasYDtghExp85JvGHetdM+CNfruXY8Gjj2NOxDoE0RR5/B25McNxfbovS9Ut?=
 =?us-ascii?Q?oyYCbAV8eONBzKNIIJ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d0407c-812a-4ebd-1490-08dd3bc63679
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:54:26.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F83/oaGbWIl/3Y4PNVDCc0PrX6M8ktIJkCmkKUAjpmcQ1Wvxbm21/agOW1QoS2alL/q+XHhRu63I0ASg0Mu3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10449

On Thu, Jan 23, 2025 at 10:59:07AM +0100, Niklas Cassel wrote:
> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> is e.g. 8 GB.
>
> The return value of the pci_resource_len() macro can be larger than that
> of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> the bar_size of the integer type will overflow.
>
> Change bar_size from integer to resource_size_t to prevent integer
> overflow for large BAR sizes with 32-bit compilers.
>
> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Hans submitted a patch for this that was reverted because apparently some
> gcc-7 arm32 compiler doesn't like div_u64(). In order to avoid debugging
> gcc-7 arm32 compiler issues, simply replace the division with addition,
> which arguably makes the code simpler as well.
>
>  drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..8e48a15100f1 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
>  };
>
>  static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> -					enum pci_barno barno, int offset,
> -					void *write_buf, void *read_buf,
> -					int size)
> +					enum pci_barno barno,
> +					resource_size_t offset, void *write_buf,
> +					void *read_buf, int size)
>  {
>  	memset(write_buf, bar_test_pattern[barno], size);
>  	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters;
> +	resource_size_t bar_size, offset = 0;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int buf_size;
>
>  	if (!test->bar[barno])
>  		return -ENOMEM;
> @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return -ENOMEM;
>
> -	iters = bar_size / buf_size;
> -	for (j = 0; j < iters; j++)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> -						 write_buf, read_buf, buf_size))
> +	while (offset < bar_size) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> +						 read_buf, buf_size))
>  			return -EIO;
> +		offset += buf_size;
> +	}

Actually, you change code logic although functionality is the same. I feel
like you should mention at commit message or use origial code by just
change variable type.

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

typedef phys_addr_t resource_size_t;

resource_size_t may 32bit at some configuration. But I don't know what
happen when 8G bar pci device attached to such system.

Frank

>
>  	return 0;
>  }
> --
> 2.48.1
>

