Return-Path: <linux-pci+bounces-33303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E3B18586
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92168188A1EA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F428C844;
	Fri,  1 Aug 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RV1BLiYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4B2701D1;
	Fri,  1 Aug 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064715; cv=fail; b=nTbzBF3ZWGWv40tC9bs55h2SxXFjH1qVNYnO3TzkEjn1jL4GF3CnXHBtsx5HHkyZAOrbJSv1ahCrOaq38Y6dM5oDR/+HBKFHm4AtyfQlqa0y7TIC/SrJbdHYL1IhvGuZWepVXxALqEoZSYI/W5wGpOBY20OXu+yB0Jo6cszSQRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064715; c=relaxed/simple;
	bh=gdXyQl8lQ82X8B9fTKSLDgf4rfIdOHOmEFO4psHW9oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6yEpBU28m1PumIz4Vxa1v+tvrR8a/wLbM6ME4ivHaeVSWZSXcxrfX+XHRZdQcHSdGKZViIQcFEnmXkyngFv9CLTtAzGQRt9/FtQVzhdU2Dagq073YHar/DrZwJG26XZrJj5yTOPZSaJ+MIt4+ua3EjzvNlq/B4xlAnxqYYnzww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RV1BLiYN; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFq+/yL569nETJkXHzY6RFYUlnb1mdtwb2Xod7L0CEwqP1xi6sbFrAS+fAmdnQkkbnGKArIezVqg1NEYI14AK8EXEFgtNxyicJGWfhlRI2WKrLaRPxqS+55qOWNZl/bm9u+8jeY3mRtdMgWQMYGItnPFnFP3JB/+GgkGMCrlJ9qkmldjHxQWkdjmGcpGdDbRZqzrv8AhTZmjGmWflk65eHiA42uoPW4uiWdFgB4WG7DXirzIB5vqSs6HX2Xc2pFc5yotjK0C5vtUwa9XcuV5IVr0dcqZ4nant4OaLP305UuqfKHo9G4Gl42B5i9sPk93B85B2gJNCWHYjpK0QpvgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3imuZbR8+418sQ1/dFIsH+OLG+ZaPDADieKbFFXuic=;
 b=PGRFZpz0ARqFvR/ZJtj1+kmy6pp8qygp4haC7fGncrOyjgeZfwfGytSFV91FfdmBRwN++MfctrIqFbPStoNnC2zXnBRZsPJWQ7ccY184ZsTLmtt9H7vz/d9nblHhmaXdyod3NsCVIQEqroyGMW8/vX7WoY96ha8F+ybH7O16OXSI3ltC9UEQ3bfcLyc1Bwp6kyDFHlsyTXvAGfUt28n3Xu9xbsgvLC5diW2ie7eFNVTk4makKRDCIu+oWv4Y138b7WeiSpDLmmt21vCWlXIyeSkiFshC8/qz5v8N1GYlqjFyuA5jHvsBNM3ummwMMREsVR+NxaG7CpoT9fFPeEX1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3imuZbR8+418sQ1/dFIsH+OLG+ZaPDADieKbFFXuic=;
 b=RV1BLiYNZBj0uPBxpLw/nDqG5b/wvoSMRMYSGQGi9hLbFX4HbUKchTEypmIfWtHQu6FWX80Ly60fonroa+g9AC1CkA82NgWn9xIqBFlMkRwlFlhR+S6nI6uRxqTUQyWFt6Q9Mb2J5HCaJOkvXip7x2vm8E6iIrs1FHwmBDT5eAVTuZ06LId5kMHb7NyjPQAAeY/3U1Rr/qsgdMceLD9phMvE4ZjE1xMSzuaGrs10nz6Tr0XKiRcXGMLIMqtVE67ysFjIq1XS2FT6NXSO3p5EisBR94GJvrpVg4U5tHZrJWydoqaP6XGe9ehmW6wZCU18MDC/JEJGB76UCh3lD65XiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 16:11:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 16:11:50 +0000
Date: Fri, 1 Aug 2025 12:11:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] misc: pci_endpoint_test: Fix array underflow in
 pci_endpoint_test_ioctl()
Message-ID: <aIznPp+sKYJq7vGa@lizhi-Precision-Tower-5810>
References: <aIzCYdH9dOMDag5i@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIzCYdH9dOMDag5i@stanley.mountain>
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 57545d80-9f8b-4533-9ce3-08ddd1161f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFtl4wpWoyUtbQ0yk4P/ahu9VQdHzvDlpRvhMmJZ4IyK39KnRHoqVam23MRy?=
 =?us-ascii?Q?SkOf+UQoqnMzsP+dBOBo4mtTPGRzo7WS4Jgn3Pjz83855iCUocQKXWbuht6F?=
 =?us-ascii?Q?MlweN+OsyMWsy3HdeZOikU0fVOb7P6wHFBiX0r1ErbSi2tpP4hTYUYeAXDfm?=
 =?us-ascii?Q?BXggzCiT5Ooci6G6C9TOPdqifWfW57uvuWLsyquGXqZlNARD9N5xCzj22OIn?=
 =?us-ascii?Q?yFGRcuSHXeu4ZhT1s+XL6bqhT09tA8GemF2roz+dsmgym5d//i25V44ztU12?=
 =?us-ascii?Q?WSiFyBwjUIYZwodaMvPJLrU8Un9QmKZtOvZEi30hpjtMHYEaqPTpARZB7AAi?=
 =?us-ascii?Q?go92xTTgENXBh6+JBYyP/Dy1flUKG8c8/rBxaGE2RVgxaMEbpLlc4X/cm10r?=
 =?us-ascii?Q?UgCA/JGRjzbJkqsj8QgBhUoOYq2mmOwGAepXoYOigM2paL24a2+Roaeduqpc?=
 =?us-ascii?Q?MoSchKfNGIvKbyc4C3Vp7zTvsvNc6l13YAmGtf+P57jjXfahDPs59aWHPaNS?=
 =?us-ascii?Q?YzPeveNBQHCTE28uPAvefhfJHhjL6Kp79xC+9vE467Gh2RKEoiYFAe3t5sFK?=
 =?us-ascii?Q?ZZ8woAH4hPzzlmspZiqxjUzEplBVt1Utw6CyfDlSpIgsE1KxLiAO0f6DDW7H?=
 =?us-ascii?Q?G+cRe8NPdk93XHwa7tsrtnli9KDtgJKX5pilHG2iotvJEZPTSYRKsOx2AaJu?=
 =?us-ascii?Q?V5zs911lm5h0umy1pba4CIaPRZ+Z8loR5DcwHkSX7jHTBCkIc2WSxUiRdgY+?=
 =?us-ascii?Q?dqiiWGCDY9Rcd7yUZOs40Zlq5WgSJVby+mqNfpcOTBr7PxavbYpy0Ik/Xq2H?=
 =?us-ascii?Q?M90vQ3+4ltR8d4kozzdSUAJDvgOrTjCPBR07rLWNAzZMlgEE5Dvw/v2rxnsg?=
 =?us-ascii?Q?EyqYZCMo5yBHM50M1Kggk00hA51tr8t9XkZsBGcEspyyBtA9cmic/NMiYnX2?=
 =?us-ascii?Q?wIPleL49eC1J7UUMPSBvsXCCpDS3I61zcU9PijmJoNYZITw0W7EtGDoYMmUY?=
 =?us-ascii?Q?EURSNS490H+heKQ1t5L7eZqCGt3eXtaGQorLkmzdD66NlsfYf02oDnecYKQw?=
 =?us-ascii?Q?aL3Dt4TqM0HDYvvTtasdaZwf0FRhz8B++RoPVyGV6YRX1d4FUZB9/GVdcNIP?=
 =?us-ascii?Q?S/D+akIupPoLCc19TmLVSi766C5oZG0hbHEsLJ6AGF01rkhyTQPuBmgIQnpB?=
 =?us-ascii?Q?twCYSRxVlwut5/WroDJgNp2qihmKJxgs04FE33AwdpMoBM39bL6Iil2Ncl6f?=
 =?us-ascii?Q?POtgTNZZXP4wJnJiDPdM14CzccA6uggdxWNUNQG40aKlluEnxKzzr8D5grqt?=
 =?us-ascii?Q?zK9BUck8AcVJT2J2IehY1bX0SZSepRa0GA8KCJVCqy0HZ+TpZ2xbUrkIxf6f?=
 =?us-ascii?Q?bAU5GkUbS02VXHlJjFrZtaUSQUnd7wzm0GNzJfSy0yZfOB7sqVYN2RREEshV?=
 =?us-ascii?Q?mDm2vNmAKZYM2KXZNcmZEVfD5a19X1okkS36YWZYutcmgrIZhN2woQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+obxJXPlIqDZTv3kk0tqAuO483ZwzFIAn0bwZLCSpPDkfamIs0PnzJFRltRI?=
 =?us-ascii?Q?ecv9JbaUFa6H3EvY9iWJsk8P50gRF5CHNeAQMNJjMzglOVu+kGlm8jnKUh8Y?=
 =?us-ascii?Q?ZzrlmmoR54R2L8FDmeydJ37dECW4OlPTcRVyqIqssHEoBwHO5QxKilNZ+ZGx?=
 =?us-ascii?Q?FPr0E3q5A3k2oxOpiGiIBrJr1JaHe6RpuTE+7PYZcFeuKYmI3d9eFf19sXRK?=
 =?us-ascii?Q?0sH0GlfIdDoxn/6hzkIG2J8lWmUMLStWXZBKai63saKUUce11OrpGFWEHz6C?=
 =?us-ascii?Q?k/9vy5QoukVye+zHMuF133mqrroQ4F+2DTmMErnwvTWpmjrQ9LsxAhlfdyv6?=
 =?us-ascii?Q?lVkifjU7sPhcwB2FpNFD19B8gA9zbEZaSSUtCxC36Py8Fz1aQiSLSv+eNo9R?=
 =?us-ascii?Q?658kp+UHj0td4/2g3N49IysfTcLauV2YCkdHnmvKX1/pC4yKhC/vnM6kM6LB?=
 =?us-ascii?Q?lhM+izKg7l9PoHJCBCmg3omUGUY/IOBgA7PvPb7XBOo7JvGQEmBBqGkVqz8D?=
 =?us-ascii?Q?6139qum2iDNnuqjNU4Eu2zuTIOCHTjuy396xFXK5+vJSvZVGRtb0HhhtJ3Ni?=
 =?us-ascii?Q?PZzz6jXna0pAgHjG7yorSGdBsyQHWJqoYBPfD+nJ5OjFv9Ry5avJa1zRtGMI?=
 =?us-ascii?Q?Jss1R8am/gWbgZaEotm+RlRSLQtv7DzUdGesnbuwv2gEKPSfKSPEy9xd1OHW?=
 =?us-ascii?Q?aD+A4KGr5QOkabjUV+pRX1NPiIXHX+haHztz3Pzqh4dHF+v5BziryUkcdEaP?=
 =?us-ascii?Q?mK0P+PmmXG0p5auxQKTAUGb4rD3lN/N5Pl1ZDkDgWdsdcnnEtWdbR067ljco?=
 =?us-ascii?Q?XVNMvNmxfqNm01ak6NKth73IfvRrS+QKrlSvyrc3bVhBaNC2MxPCxnsQqMzc?=
 =?us-ascii?Q?bAvtOkmz/oB0q2Zr7dYeyJfBDAtxlm6drDb98vfKxeH3HebOMkbVORCaFSdo?=
 =?us-ascii?Q?ZxmE6oF2xdLcyhTFbJ2HFu3h/2lcrcwC23emQVBnFY6dMBbGXXscMkhMg3Qp?=
 =?us-ascii?Q?wxXu7Ph5t7SsqNsDzVAZuYMxoWAGIJNA0pwqwN+T5zYIyyUaI+iFijWwYhot?=
 =?us-ascii?Q?BttpYqAJGt0zTUn2UkwTNTSo1Mlu352hN6AdKJvupjeq5qzFt09T6OngTuaF?=
 =?us-ascii?Q?cKcc82MNcUEdafTftRT5Hwsbca4rwRje81oozRafYFJEYhVBzoLG4hexBh4e?=
 =?us-ascii?Q?kUlPERpmNh0s8iNG93pKoDO9MUENd/bd7uYIxM7Yee8nbk9mIv6URawTZ1Vx?=
 =?us-ascii?Q?J59n8hqo+SUSuCCJnX6S1WviTxeCXKuW3akf2/AOzj4khTlfzwJUOkR97XZr?=
 =?us-ascii?Q?Jib/BOUWp2kFN5ezs89ixdb7oeZ5CpGP3jcV7ibCjPeMgdrvk5a+VKIopN1/?=
 =?us-ascii?Q?Ob9GRqEzr+Za0vzD/FcJAul4l1lGh1tsg77LVStZP2Yjlysrwbe4SOu9YtOX?=
 =?us-ascii?Q?DpiZSDlkfMd2ucj5EndZXd5iQsB4tSUHVtfoG4wJFrGuQx1fnENNw1KESXSw?=
 =?us-ascii?Q?L5QwotG5ONgS2UVrw4HMiWBVHs8pAoSQHB035+k8q2f8+sPT5Fd/IMsZybys?=
 =?us-ascii?Q?bzHqaJYpV0NQ8xdaJVMtd9w0T05uP9rbnj31SUgP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57545d80-9f8b-4533-9ce3-08ddd1161f67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 16:11:50.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMxPAaR1S8x+/uCe6WVkC2Q1ULYiOLMdQ8ZLYEsU61sC0zZVLVA2myFJLucvYQLpE83//CIzalEBHmldESPb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

On Fri, Aug 01, 2025 at 04:34:25PM +0300, Dan Carpenter wrote:
> We recently added NO_BAR (-1) to the pci_barno enum which, in practical

Since commit ...., add NO_BAR (-1) to the pci_barno enum, ...

Frank

> terms, changes the enum from an unsigned int to a signed int.  If the
> user passes a negative number in pci_endpoint_test_ioctl() then it
> results in an array underflow in pci_endpoint_test_bar().
>
> Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 1c156a3f845e..f935175d8bf5 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -937,7 +937,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case PCITEST_BAR:
>  		bar = arg;
> -		if (bar > BAR_5)
> +		if (bar <= NO_BAR || bar > BAR_5)
>  			goto ret;
>  		if (is_am654_pci_dev(pdev) && bar == BAR_0)
>  			goto ret;
> --
> 2.47.2
>

