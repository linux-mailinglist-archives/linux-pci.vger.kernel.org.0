Return-Path: <linux-pci+bounces-39687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BDC1C47B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FAE582D93
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674DF2848A8;
	Wed, 29 Oct 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3MBE5Sh"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1CC27F18F;
	Wed, 29 Oct 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756555; cv=fail; b=CvS2kxvVu9QtAutCQajIVah71yvg25UjhfJp3EPc4VxVDH5VqB5Q6HNyOkTSRdVmwDYGT9qFbIaZe4L7q4eeY8ms+z0O4a8LzweVV4OjSg5vQn+DHC9+C9TZUInLhMqIqwDZAgpNJ3rUZHS+MfHYFxL612fcR22SZrLBSUa+psU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756555; c=relaxed/simple;
	bh=4qkIJlWqYJACVaTu6MsbnQmpt+WtfQ9P8LZ64rsr+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=poB4te0vIq8b6jiBnPZV4O5o8JugMorG1Y0PXcKZcCwch2IzpRfFKF4UFDmZRZpn4GWGS+Ev4bBCZzyDeDp5joXTdiXvHuzDce9Y3G+0vi5eXYSejSqsiVN8lJEl/71KAxAjNIT9+6HWAVUv45+d+5RAJjAee8+LSBM4QbJnGBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3MBE5Sh; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgipZXSmrzYWIRTzHJV1Et+U2Efep2+FErV66sIRS4XjB9vFiNRG6W1/SjdbiIrfms7mZ95t/pNNNs56eI9Q0DvX1osq862DiLweR2MeYKYzu1N80g+Q6p2FzoW2kmwJCLDTMDHthW6IhURz3umNAZSOQDFkKg/4P5Mfvj7sf+/EcQIKgxalnMZEE6BBPayXCrMrf8qHxKOwu1D3nxIb8VEm9cpxbzOzL/T8Ry72ZeCsYDb60vO9CNhVOclf6M5OTrxo8b4IgdYVxYP0G8wsWAmeByhdxPVijbDSy6ZxTOY4qRzMxsS6fUWNCyil0EnjncZYL7L9w42uIZVsYG5YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjJPTRMPa99tLgUB+5Kvw5OG6b1DVLenPIRDei32jrM=;
 b=CYO0ojQApuLX2zwxKz1GDTvLb8m/fYVLT5Cr12vgpQCqewiO/6xtUaU8lIW3Gbf5GhK8q8I7c6UCDCUXtscUQtg8VkbT/56zwoZuGrnx2zEqwij8aWZ7C6JeC6lfPndbPrmlUskQ1bums548JMDsCiKMxi3tNEkVUyNC+P1WgdkGeJUDMC8rFUr0h+b75XfClAPsicQ3XGsCwLrn+5aF/i63Ha2DZWPGiffStV5rQjZVsXb57Ut46gEjUeUgGLeP5pKWxeaxi0l4M3B3Eh28szQYZQHZEi3iFeFzxY2a/CRYxO/Eol5mKyK/leekVMadxJ7JWseRw1FKydxVkMUEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjJPTRMPa99tLgUB+5Kvw5OG6b1DVLenPIRDei32jrM=;
 b=T3MBE5Shhyjut9S3ZmHDmoIljvGU6fKd7UcXrHF4G0/cGQ4Q1Yc1p4bNVjpqMPMnl34M7CyGkfbVBEX54rwj/kq3Ckc7+dHcqmcLHaWS02HWalaACK4BpjfYIAtCzSiJSladC7bAiEc6uI3f1Gj8UVdP/8xxUapb8yVU5cNMvkgzlcZjVoBCjDT8XaZtZSuD1vMfj3QIqxWYLlnhX8Lij56Kn7ZHGfIkQRDXJ/d5IVE9+tIljzLEln2fToCL0tw/LVxyTsclEcYlceTwbIt0tf/ueiNVeNSo1Nez+UUhIs5eKyrEKe/zdU4xZUyXK4ucoEShO0bKYZgrDqdbkh65Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:49:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:49:09 +0000
Date: Wed, 29 Oct 2025 12:48:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v2 4/6] PCI: endpoint: pci-epf-ntb: Remove duplicate
 resource teardown
Message-ID: <aQJFd8Btdh1EY0Qz@lizhi-Precision-Tower-5810>
References: <20251029080321.807943-1-den@valinux.co.jp>
 <20251029080321.807943-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029080321.807943-5-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:510:23c::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e91e16-a0e8-4d57-af1d-08de170b14c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5sSopXiqrmsjCy14bb4BYEhmbY5+hvMPBSUyhimDl2l5bAw8sKQLi1fsfIW?=
 =?us-ascii?Q?2FLtAPclJ8ZIH1TpgQYG3pSgOItgCy4X/Bf5RIYSEvXnhXDM25tMkh0p2XLp?=
 =?us-ascii?Q?bUKtDWek3Z/9wo8de3LUS6PxPHob+UsuejHeUgFI/EXVFoEkFeHzUcM7oY3Q?=
 =?us-ascii?Q?o/qR4uLkzAObHoRpNI1ErmqGio0DHjXdqYEhMXWpCdPxRL0YaxYmv/KuuPuk?=
 =?us-ascii?Q?xa44BUt/AroFrmro2R0a+rBtHkrCcMmGuSnTBiYmHl5zuVE8HAbX+dZ5r1Yo?=
 =?us-ascii?Q?OOfZbXpUbhb3+OLLnK9T+g+2tbuZGKcy9SlFhBFi9QIfnQtCYC43CAq6BohK?=
 =?us-ascii?Q?+HE3gg0dH7kqs/EdbvhqEHuiz58HiBVv8bDCItYn45qp+llwgvkOCyPKxVn2?=
 =?us-ascii?Q?UdtuiYQBYPiAIkEJrpJHug8JLUmuDlxZvFrLqkVTwrNQeAuuMZ2n8LAdyrw7?=
 =?us-ascii?Q?S/C/Hs/ecZ1frb/Q3myHETnPuXua3i6MX5w7TuN67ut9eH42qbth5VB0duPr?=
 =?us-ascii?Q?XZFdiGFS3xLSz0978OfHuTcJKAS6neHgfFgTHeu6R93ltCJ1/PBMA+eHCXbN?=
 =?us-ascii?Q?6DowGchD2N7RPzg/sR2wvoVLq7Rb65uMu5+UCQxQ5pCX1IXB93D9N27NdzWM?=
 =?us-ascii?Q?zLX4XpLg6BrObbvR7nnsT2TlRv9QwcL/x/qOktchRZ+BMOFf+AQXraArLu0t?=
 =?us-ascii?Q?2a9/4aat+M0N0LFxqCOqfS9eDtU4lRkqg44HBzdP/wnxbUuYYtu4mZmBwILh?=
 =?us-ascii?Q?S6XzDZ7cvLaZd/v47z4LWyCwy5QGEqLy+BZ0dz0i/97KxjQY8z/sqLuAzwbh?=
 =?us-ascii?Q?I5e7Wh3v8jtTc4DczvyILdTwfo1y69AMyyuxm68+SuTDpGO2r67t8woKHgAP?=
 =?us-ascii?Q?iA86+xBKtK9hPKHWSXAkVzPdDMlniW4EDUPuZooLp2O7pVTXwE8FHf0y/mP1?=
 =?us-ascii?Q?vLvpfLThMrgPumCVhSjZ//lRHaHss2Sr97JqtbDMgY8i0UMKnbN72fZXR5BP?=
 =?us-ascii?Q?FDXTtIo7vvjQxKudgQMM08pQY9ltbOCaOXtykBdHQD0VdLbbtpvqb3nT7Ofr?=
 =?us-ascii?Q?DDRR8jcGERN0RvSQK9S9X5exVdD4R8sbpj98Tu38FvvsRkRdWqAvz+pzksGb?=
 =?us-ascii?Q?1nZEPYZl6wGDZnJg3kIo9KAXmUaLDDjrFdeCx+w8PpEsF3jPCGnosBQzNfR/?=
 =?us-ascii?Q?necb/lJyPPfY7WAb7qX5ZH6pdsO31UHuBHJDmmYGfhKjhtXdTxdkZfr5XaWI?=
 =?us-ascii?Q?/6p9teHSHijaxk8/9AY9Xd2E3DKIxR7qJfPqhG/2bUYSXKAT8Rbr+Pf94JDd?=
 =?us-ascii?Q?psVRNdWrhyLl07fZL2OnFMhF1GmRJaktrzyXbo6UoJByi1MAncdfcTOFNyEn?=
 =?us-ascii?Q?Ng8TtjvSnmXpax3u78XVMvGB/+i03ybfnAKWcMV1c8LH7m2m1LxFClC6r2bE?=
 =?us-ascii?Q?aUC0RRwKKETAdDUXBmLcX6Ilpbbub0U06RuWheJ1NbXQSlzAMA1XZjonZYZl?=
 =?us-ascii?Q?MJbo6lt6c/Oolet7xdxBHUKrJT/JjwfxgAAK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkJw/d5khrjS7/aKIHsz+cLS+lsAUfETbCaOI89MVqgoYkGBcgUTYUKayu9J?=
 =?us-ascii?Q?Ngle1NuVO/ivm5f52o2mO53I5DPjoScTRcZ0TRDFi8F4+DEfYZa9u2Or4APh?=
 =?us-ascii?Q?LTvgNs5ATSnNzqF1LdExJEKtp07CwbEKD4Hai0ABj/SizssfxmXXf/k4Q8Kj?=
 =?us-ascii?Q?Vqmefq/l/Gr2skhSmqwynRQ3zvpeglhIVoAOiB06lFhnIYoMskdWyfpGD2ba?=
 =?us-ascii?Q?VqZNFj1gvYGxQfasx0xINg57CY2eLwkENcb3xgepA6CocbD1/3MIVm0fLjJi?=
 =?us-ascii?Q?is5OuzsosGW+l40zjHfhrnhRPTrkR5fTYxq3HselwQIoGRku0h0giQcbLClF?=
 =?us-ascii?Q?xz7XrhE4vJtShgqwf4QpHIY7e8RSZhnalQYTjkNFBW/FhV6m7VgWMOnUhYcR?=
 =?us-ascii?Q?+i0ZIn689NAAvF3KJUXTCt1npLToYzATVopBPsxVctLidLaZIduFSQQbI4Q4?=
 =?us-ascii?Q?h9JemmahCBPtd3SVdf67OmlRBmKUwaCL1E61BMTQ5Qaa9LMEube3VqfDmSwM?=
 =?us-ascii?Q?KDOUtWxDRp29uAUrdSd1DZP4ABlVbj5dFwJbQxjkruhFbxxB0y/1e7rIBWnE?=
 =?us-ascii?Q?0z1KOPq50O3xfEcMQ++WkTomoU/LzcumI1KSNG10/DgTyqL2GFO8TJguWl+x?=
 =?us-ascii?Q?Lsayei6nNeP9d3vHS10I/0GN/0AWPkuGCDXMpvlFU0Xnl5BbfwlzgIjlUc9d?=
 =?us-ascii?Q?dBdKLKrKBnrs6dAqGWxD4PLwh0sM6PEdwqwwxuIct6CspIvhcjgU6GRG+Xxg?=
 =?us-ascii?Q?wvIl3Z0rDFITeDDOFAeKcttm40HQXpCU68thS8uRnXOSMsgeHytMWBHA98W7?=
 =?us-ascii?Q?VhblravWvKHNa1eEPa78j2IJjImDhzzrZQh1a0BQSdQuUCHWq4CAaNoAPYN3?=
 =?us-ascii?Q?7YUrksW41ICUbJPzwg4zSONWBB2x1alxj1UzedKxZ4s8MVS5jnG5ZNSM53Pe?=
 =?us-ascii?Q?5tu1RAHsLiJYAqOZouN0rexStRvx7kUzMXaendGBAlPCnR8KDyo3ajBHWcYe?=
 =?us-ascii?Q?133cQEaMYGI/B45n7wbMtNbrBnXKiXjkRbpiPI6q8VVaV2573Lz8J/kcZHDM?=
 =?us-ascii?Q?tY3xq3stiIeLpd1+0HxcA8vbSp5VDDzAezFtz1u5CB0AjQfjwJiXG4MCqd9L?=
 =?us-ascii?Q?NOfmPU/J2C5zNCW4jitmTtfsjDBlNcUJyV+lhNtFyFTngVXTLFt+EFXyHRFX?=
 =?us-ascii?Q?otdwiRXzguKE7D7X7wYTXquE5eIbeNmlftDtHkqY2NX0abQLtD1PEQmh6rXt?=
 =?us-ascii?Q?QssHpcGfcWHw/xuZhBN1OXToVaLfEMU8WIfxUX/3921zLw/kda67E+9Ms6o8?=
 =?us-ascii?Q?sqO+5mdmL5qn/cM9f2ZtTZMswdZX07fOYo4oNkxTdhCT6g3mpUIzP5UtC3PQ?=
 =?us-ascii?Q?yprjOctVFPKWCrZ6jBqN15f6GiMqChOwG+DhWQ5OKhmZ0HzFZDU96ui0Og8Q?=
 =?us-ascii?Q?4EZuVJBoweyLK4SJ5CsvB5sOilpnmnRx5lYuYlXIPGA5hvRQCCS7J93S7nFj?=
 =?us-ascii?Q?9XhMiB7SgslIJMSAjY4RBS0ddGbkwevBbarJowAd6v4eRQRzkoLUxadNxciZ?=
 =?us-ascii?Q?4M0TUYSe1SXxxAl6hHtMWfzMVZ9VakzacF4EJYxu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e91e16-a0e8-4d57-af1d-08de170b14c1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:49:09.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HpnkqdkTeblz2MTqL8yz21G9oP7ftbwm9io7io5SP02za70O6f7e12xyM7/IenGsSlXZ9dbFedwGp/y3qgRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

On Wed, Oct 29, 2025 at 05:03:19PM +0900, Koichiro Den wrote:
> epf_ntb_epc_destroy() duplicates the teardown that the caller is
> supposed to do later. This leads to an oops when .allow_link fails or
> when .drop_link is performed. Remove the helper.
>
> Also drop pci_epc_put(). EPC device refcounting is tied to configfs EPC
> group lifetime, and pci_epc_put() in the .drop_link path is sufficient.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c | 56 +-------------------
>  1 file changed, 2 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index e01a98e74d21..7702ebb81d99 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1494,47 +1494,6 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
>  	return ret;
>  }
>
> -/**
> - * epf_ntb_epc_destroy_interface() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> - * @type: PRIMARY interface or SECONDARY interface
> - *
> - * Unbind NTB function device from EPC and relinquish reference to pci_epc
> - * for each of the interface.
> - */
> -static void epf_ntb_epc_destroy_interface(struct epf_ntb *ntb,
> -					  enum pci_epc_interface_type type)
> -{
> -	struct epf_ntb_epc *ntb_epc;
> -	struct pci_epc *epc;
> -	struct pci_epf *epf;
> -
> -	if (type < 0)
> -		return;
> -
> -	epf = ntb->epf;
> -	ntb_epc = ntb->epc[type];
> -	if (!ntb_epc)
> -		return;
> -	epc = ntb_epc->epc;
> -	pci_epc_remove_epf(epc, epf, type);
> -	pci_epc_put(epc);
> -}
> -
> -/**
> - * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> - *
> - * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
> - */
> -static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
> -{
> -	enum pci_epc_interface_type type;
> -
> -	for (type = PRIMARY_INTERFACE; type <= SECONDARY_INTERFACE; type++)
> -		epf_ntb_epc_destroy_interface(ntb, type);
> -}
> -
>  /**
>   * epf_ntb_epc_create_interface() - Create and initialize NTB EPC interface
>   * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> @@ -1614,15 +1573,8 @@ static int epf_ntb_epc_create(struct epf_ntb *ntb)
>
>  	ret = epf_ntb_epc_create_interface(ntb, epf->sec_epc,
>  					   SECONDARY_INTERFACE);
> -	if (ret) {
> +	if (ret)
>  		dev_err(dev, "SECONDARY intf: Fail to create NTB EPC\n");
> -		goto err_epc_create;
> -	}
> -
> -	return 0;
> -
> -err_epc_create:
> -	epf_ntb_epc_destroy_interface(ntb, PRIMARY_INTERFACE);
>
>  	return ret;
>  }
> @@ -1887,7 +1839,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  	ret = epf_ntb_init_epc_bar(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to create NTB EPC\n");
> -		goto err_bar_init;
> +		return ret;
>  	}
>
>  	ret = epf_ntb_config_spad_bar_alloc_interface(ntb);
> @@ -1909,9 +1861,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  err_bar_alloc:
>  	epf_ntb_config_spad_bar_free(ntb);
>
> -err_bar_init:
> -	epf_ntb_epc_destroy(ntb);
> -
>  	return ret;
>  }
>
> @@ -1927,7 +1876,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -	epf_ntb_epc_destroy(ntb);
>  }
>
>  #define EPF_NTB_R(_name)						\
> --
> 2.48.1
>

