Return-Path: <linux-pci+bounces-2742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A048415DF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 23:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FB2284551
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 22:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D54F1EC;
	Mon, 29 Jan 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRxJpVJs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7D3DB9B;
	Mon, 29 Jan 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568153; cv=fail; b=p8B+JIOY8zr3UzNP5ok/pyT53V3sPe9saNjt6M+669NxXZxBO3T8QezTvBsOnEsNykvXbiWufYPC/uXPaqn8yO46iYCz3XKybqLSp2lm0C6pZkdpXX8WM1QDDaGBU/UJnOzEfGW1mCpsgg9EGsKr3SbR3r3DEgJ5Smbe5m7Mwyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568153; c=relaxed/simple;
	bh=7191bOoPX3G/atxs6MSxsnL8B1cam9mn9h2kccMJ7KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYASQN2ijb2TJnkA7eRU+LQTm04DfhobIqNctkkbMWlyM5LQMNqX1r6Tyb726Pl3p+vOH23LTYWxxn0/rr7CHAkr0Kx862uLs0dHkX5pBp/KLa6uNtPZDauGLTNDS9ako9FpzSZ85B3rCwcYqUg1hEAOSABvzF9rBwGcauOHmF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HRxJpVJs; arc=fail smtp.client-ip=40.107.8.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3SfMD5h4XrSdtb+ZuDBjUpHI8x9SfEQxwpMNjuG8NIYRkeTkxgC7MiToL17IC9kpbUjcJL6+6+Kvgltyem20ccl8KIxCFU1H3Q+ri41pyWpRbBdtUKOBjZespRuE/Z3MQzl+xceffAM80Rip6AiDIeIED/aN7CdUldB4mVyV3NpQzWb4QeM8pF2KJ1HotfdwN3DizrzVKoJyxBqWw4GVnraO3cVpBPcjoYlLqWMb0+S+wZTRJ3PkFNrB6z6MiLX++S/an7xFC28VCMFdv9Lu8mqDmNjS4del7iA2NbM/VGTYlYDCeUbwO21jXGQcnr+un68Ywij1JeKyf9RPyhmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hsugKivP86F1NCIj3O7hOkuWha4FMY/a2Tc5nPa5M=;
 b=WR1pJL0qb7EpyhhW+yCp6VcH4XBfmdQ39fEi9jxyIDYn2N1u7oQLuun8Eo3FL0EklNhkYyXWiUB56Xy/hSxnYY9FrwwyFMA4LBN+5ndNUAaowxSnj3ujTgaD6isF05y0bZDBzG8BoGIm3m8rjqauMdlEhP6vNIkn5JYGbOfHmBkLwwLK6zOSLGOlbt4giDKkstcAqrQDGzr++w8PDibIwfb2URJGV7FsCxUtRX63ckV4cjizvxoILt+VE7w1OKx7V3XjMK3JCakIqaPtME/lXxZMt7YiIKBZO5ZvLnPHegaP23pY6ec+UD3H5XSzzzR72z88SjwUX/P8oQyoGwoNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hsugKivP86F1NCIj3O7hOkuWha4FMY/a2Tc5nPa5M=;
 b=HRxJpVJsDSGymRWq3+K484WBHf44sMyBg+6aioXYX6CncpGBEnmUJkoKYSuFdZ37CB4trO0MUOX7P2+QYUSttFiLZ9+5gaCh1WjXkqsS0oTtS1vZirTleHHb5HEyZL5QjVst4V1fAcju8nB+zFD4pCtaO3UymVEZA8R2ivDSQDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:42:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:42:27 +0000
Date: Mon, 29 Jan 2024 17:42:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
	fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 02/19] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <ZbgpzPjS7Jhe8fq5@lizhi-Precision-Tower-5810>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230825093219.2685912-3-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-3-yoshihiro.shimoda.uh@renesas.com>
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f11f19c-e40d-4313-9c0f-08dc211b91d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K5ZwyVZvEw0nyu9iC16tg4HcA+7a4sKTBvN8GR0hibMDvAGOZYNsyYPu9dYBX/9O7L2QlH02R/htLMW4emrhIHUpGoFsct8UA9gO6F+7tXff8tLKhXp5FtCKfoXrbQSK+uf9/hPmUbHn+OuXg92TXPcJ2Rg70nTUHtAE76Inm7IOCBHcXZaBO3pA6DT6rYDPHU80zWYAGNMZ/yzMYlu4DGhMV+KkgLJs9+RjMbPgKEtooPL8ORcimns5OEOhUUh0tmPDpL+xyUgSegahWPLp1mbadwIjnXvQELhiiUh8hFiTfRNfaupPMiBGQgWwrzdjUnYmWx2vIAgzpKJegTkjtgC0XH5vyNHIK718Qv9Mf6RmRx7w7p3jCUzWg9WrWxGqDj9RXStn61YrGKDfhRAg/rTJVjD2UvVleAdEFw9/CJ8WbmW7H6l+NaIBqwytqMDSYxvJUCXA19dXtWmO589WciUioDGgk8bQoIc0GA3D/yuYlizJ4od6PMVWvGdIozmBLfHwHfX/4wVv09kdKY6nbhpweStmCVDfs53iRljPLL7fGodFw0KeBAjz67Ty9zHbQFAAwPYwxJrjDzRLsdvf/pubJWuxEE7PAdXffEytOEeRmVboDP9Ej1jm+eQUomG5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(33716001)(6512007)(6916009)(9686003)(38100700002)(66556008)(4326008)(2906002)(8676002)(8936002)(5660300002)(7416002)(6486002)(6506007)(478600001)(66476007)(52116002)(30864003)(6666004)(66946007)(41300700001)(316002)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rgpSJHOASE8Sk9uBMs3Fh+o6mlumerFvd4VliNoSmF5Ah9u8L6ev8Sor41F6?=
 =?us-ascii?Q?35p/FEU16FWPnDCDfl82TLGGjTVL4EKFGtttSupWkEaInZzptGf8m+HdrbE/?=
 =?us-ascii?Q?Fzz7HU8ymdD8ARr3tYWbBkPMvEDn/g3UxbdKza0zPBhd7WB4RW6B2j/5r77Z?=
 =?us-ascii?Q?hCRU7w+dWRe5u1b7akoxWHiRhykma7bHThVGFBdcSL+r7DyXGqppyc2FckI7?=
 =?us-ascii?Q?dejtZK+IFwpsn/9WsWzOoMSGK5wzpErw6su7wAn3j94PMhQlptLE6Ig35Q3Z?=
 =?us-ascii?Q?cKfhEQPxyKIsi2FEpKIk+Fqzq4O/iq4kEY02aruiq94O9KOcFEvyfL4QBrn8?=
 =?us-ascii?Q?NCY4qkC/m3zVKX4QqRpgbrkPgTlsGOcG3gVR+7GsYlPGjSkaE/liTo7HOqkL?=
 =?us-ascii?Q?sZGjBMBc+VkUosfaYuCYAIcQIMBJYiPnAHInKMn0OZZk6bjFqfWQNnt+INbx?=
 =?us-ascii?Q?bgrIVVFmpwN1qgpqyZOlyKPO93q1kYn/9b4V+qluwFtHM4alG9AvW8+AqGf1?=
 =?us-ascii?Q?qiUHPfrJ/IGaEtuwrSsRZnggRGoqLvuztF8UCoshaKro37IdphwH5UpgnCt3?=
 =?us-ascii?Q?HH1hVMG3kHt0SkDQxK7a9/deSJdx5Bgal1kGSCCfTQynAlRqdex+ebc3X8W1?=
 =?us-ascii?Q?z9hGQ4mBZScXiVCbKuldXLb/Fniw2JsoA/scMBVTLs3UM98m1Y+e0fNE//Hq?=
 =?us-ascii?Q?aF48Bc1+h6o5qUd/9RRiVmEMS6Bj2Q1Ex22utiIAw/EmOVLJiiWeIyoTXvLj?=
 =?us-ascii?Q?19t/dveGWlHOM/AUlre8Ld3ynUUhs1CXc3BqOmUr0GnltoVeYQdrFzGyZBPE?=
 =?us-ascii?Q?H11G88/q3aiWGYG0iSjWCanW/LtMBYOyuZjsSdlKpRLnWVeNvi81uldcxp8t?=
 =?us-ascii?Q?Q+0XWWOH8UHUtE1bBG2/L0AcqaKopuyejU8PBvMEswfMeNpv2qJLbUzH86g/?=
 =?us-ascii?Q?oPlPOYZI9r71Mu447g36pnhNPyFC5FB+pFYa9NcFhh67lXPOnaUSvZnEbzWv?=
 =?us-ascii?Q?3LSbMKqivdNDIn/g+HDz1C1hlOnSwkxIwVhJXQA+vTtoEg0I0PWXfO+ljVHn?=
 =?us-ascii?Q?WqYZ0hmUwYHQkKSU4S6k21kz5sYEjKBmkl9B+a+1Pl/4FRpYCx7SHkZ378v/?=
 =?us-ascii?Q?ScyxRW387Xq8iB2NQL4ZA8oAOXoUadjPaiiSI5Y3jUCE8qQyOf0BpouXvhrM?=
 =?us-ascii?Q?0KH3xeUv/AOP3D5V4MnmX3/+CYlJscICgxrn46IcaGmHgfn2Ntnf6TK9PsVK?=
 =?us-ascii?Q?o1VbQ7H6nCzjHzVog/dlWwpMvSUWSeKLR6WA8yXlT5SWxhRmUv3dCppByzLQ?=
 =?us-ascii?Q?YnrPGhQJyHJVEQJjxCi9v8IwPYyi17/1y6HoAAzXf1LHpj+CF0ImpDhJoXLc?=
 =?us-ascii?Q?Zo+JhVKQ3ZD3HdLThhLFlu1tgtw0WAG7PK5X1NtKS84QbSTnN32gmJemr9Zh?=
 =?us-ascii?Q?B6ut6AKaSkb9m22EI5UQjD7qtwHU8c/V4xVus4kYEuvFii6tdLQ7U4MZ/ela?=
 =?us-ascii?Q?4AG93bHSS+dTjEmRWM1fzyW15G8mEprGlQVu4whJcPDC4ba8STBuh+bah+zi?=
 =?us-ascii?Q?CUDvwC95LoW8VsVT6Gkbpw6uGBQSljaWeRcBzIB0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f11f19c-e40d-4313-9c0f-08dc211b91d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:42:27.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl/5Jl5oLiHSqufjNbay83UB9CI5Y3sduqYr6QLvkFlFov5N2yRRnT2WjXhXpKztgd2UoJXA1TRp1zQqgPcvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

On Fri, Aug 25, 2023 at 06:32:02PM +0900, Yoshihiro Shimoda wrote:
> This is a preparation before adding the Msg-type outbound iATU
> mapping. The respective update will require two more arguments added
> to __dw_pcie_prog_outbound_atu(). That will make the already
> complicated function prototype even more hard to comprehend accepting
> _eight_ arguments. In order to prevent that and keep the code
> more-or-less readable all the outbound iATU-related arguments are
> moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> is supposed to be locally defined and populated with the outbound iATU
> settings implied by the caller context.
> 
> As a result of the denoted change there is no longer need in having
> the two distinctive methods for the Host and End-point outbound iATU
> setups since the corresponding code can directly call the
> dw_pcie_prog_outbound_atu() method with the config-structure
> populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Yoshihiro:

	I want to use this patch to send out PME message when suspend,
which should be similar with raise INTx. Can I include your this patches in
my PME enable patches list if your patch still not merge yet. 

Frank

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
>  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
>  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
>  4 files changed, 77 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index ab87ea3b0986..747d5bc07222 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				   phys_addr_t phys_addr,
> -				   u64 pci_addr, size_t size)
> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> +				   struct dw_pcie_ob_atu_cfg *atu)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	u32 free_win;
> @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -					   phys_addr, pci_addr, size);
> +	atu->index = free_win;
> +	ret = dw_pcie_prog_outbound_atu(pci, atu);
>  	if (ret)
>  		return ret;
>  
>  	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] = phys_addr;
> +	ep->outbound_addr[free_win] = atu->cpu_addr;
>  
>  	return 0;
>  }
> @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -
> -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> +
> +	atu.func_no = func_no;
> +	atu.type = PCIE_ATU_TYPE_MEM;
> +	atu.cpu_addr = addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	ret = dw_pcie_ep_outbound_atu(ep, &atu);
>  	if (ret) {
>  		dev_err(pci->dev, "Failed to enable address\n");
>  		return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5c8cbc3afae4..01eff83c1f6d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -551,6 +551,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int type, ret;
>  	u32 busdev;
>  
> @@ -573,8 +574,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  	else
>  		type = PCIE_ATU_TYPE_CFG1;
>  
> -	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
> -					pp->cfg0_size);
> +	atu.type = type;
> +	atu.cpu_addr = pp->cfg0_base;
> +	atu.pci_addr = busdev;
> +	atu.size = pp->cfg0_size;
> +
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  	if (ret)
>  		return NULL;
>  
> @@ -586,6 +591,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int ret;
>  
>  	ret = pci_generic_config_read(bus, devfn, where, size, val);
> @@ -593,9 +599,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  		return ret;
>  
>  	if (pp->cfg0_io_shared) {
> -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> -						pp->io_base, pp->io_bus_addr,
> -						pp->io_size);
> +		atu.type = PCIE_ATU_TYPE_IO;
> +		atu.cpu_addr = pp->io_base;
> +		atu.pci_addr = pp->io_bus_addr;
> +		atu.size = pp->io_size;
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret)
>  			return PCIBIOS_SET_FAILED;
>  	}
> @@ -608,6 +617,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int ret;
>  
>  	ret = pci_generic_config_write(bus, devfn, where, size, val);
> @@ -615,9 +625,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  		return ret;
>  
>  	if (pp->cfg0_io_shared) {
> -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> -						pp->io_base, pp->io_bus_addr,
> -						pp->io_size);
> +		atu.type = PCIE_ATU_TYPE_IO;
> +		atu.cpu_addr = pp->io_base;
> +		atu.pci_addr = pp->io_bus_addr;
> +		atu.size = pp->io_size;
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret)
>  			return PCIBIOS_SET_FAILED;
>  	}
> @@ -652,6 +665,7 @@ static struct pci_ops dw_pcie_ops = {
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	struct resource_entry *entry;
>  	int i, ret;
>  
> @@ -679,10 +693,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		if (pci->num_ob_windows <= ++i)
>  			break;
>  
> -		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> -						entry->res->start,
> -						entry->res->start - entry->offset,
> -						resource_size(entry->res));
> +		atu.index = i;
> +		atu.type = PCIE_ATU_TYPE_MEM;
> +		atu.cpu_addr = entry->res->start;
> +		atu.pci_addr = entry->res->start - entry->offset;
> +		atu.size = resource_size(entry->res);
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret) {
>  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
>  				entry->res);
> @@ -692,10 +709,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  	if (pp->io_size) {
>  		if (pci->num_ob_windows > ++i) {
> -			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> -							pp->io_base,
> -							pp->io_bus_addr,
> -							pp->io_size);
> +			atu.index = i;
> +			atu.type = PCIE_ATU_TYPE_IO;
> +			atu.cpu_addr = pp->io_base;
> +			atu.pci_addr = pp->io_bus_addr;
> +			atu.size = pp->io_size;
> +
> +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  			if (ret) {
>  				dev_err(pci->dev, "Failed to set IO range %pr\n",
>  					entry->res);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2459f2a61b9b..49b785509576 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
>  	return val | PCIE_ATU_TD;
>  }
>  
> -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> -				       int index, int type, u64 cpu_addr,
> -				       u64 pci_addr, u64 size)
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +			      const struct dw_pcie_ob_atu_cfg *atu)
>  {
> +	u64 cpu_addr = atu->cpu_addr;
>  	u32 retries, val;
>  	u64 limit_addr;
>  
>  	if (pci->ops && pci->ops->cpu_addr_fixup)
>  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
>  
> -	limit_addr = cpu_addr + size - 1;
> +	limit_addr = cpu_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
>  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
>  		return -EINVAL;
>  	}
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
>  			      lower_32_bits(cpu_addr));
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
>  			      upper_32_bits(cpu_addr));
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
>  			      lower_32_bits(limit_addr));
>  	if (dw_pcie_ver_is_ge(pci, 460A))
> -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
>  				      upper_32_bits(limit_addr));
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> -			      lower_32_bits(pci_addr));
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> -			      upper_32_bits(pci_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> +			      lower_32_bits(atu->pci_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> +			      upper_32_bits(atu->pci_addr));
>  
> -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>  	if (dw_pcie_ver_is(pci, 490A))
>  		val = dw_pcie_enable_ecrc(val);
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
>  	 * and I/O accesses.
>  	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> -		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> +		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  	return -ETIMEDOUT;
>  }
>  
> -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			      u64 cpu_addr, u64 pci_addr, u64 size)
> -{
> -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> -					   cpu_addr, pci_addr, size);
> -}
> -
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> -{
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> -}
> -
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
>  {
>  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 755bcb406769..296c5b1ddc91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -298,6 +298,15 @@ enum dw_pcie_ltssm {
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
>  
> +struct dw_pcie_ob_atu_cfg {
> +	int index;
> +	int type;
> +	u8 func_no;
> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;
> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> @@ -429,10 +438,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			      u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +			      const struct dw_pcie_ob_atu_cfg *atu);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 

