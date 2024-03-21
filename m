Return-Path: <linux-pci+bounces-4977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B88860BE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 19:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23E11C218AD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203BE8613B;
	Thu, 21 Mar 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8ivjZql"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E979C3;
	Thu, 21 Mar 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046938; cv=fail; b=sE6Ku2UtjJKfyrrCTfH/03Iwcu7L6w73zqCTOs97efVO9a/YFOXZYuoEFTtRUVYY78c+rOjv3fahMP2gx2XRYzs5FV8yudgWLEs0zLyX7qRNM802A84kTbRgXkj7kxxH1WVbNjJCOGG/PBUsna9UyonKtXqOgmYmZiBa2Zx1Y/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046938; c=relaxed/simple;
	bh=aq+dNj46TWpUTx2T8vgcD88axT6UQaLQmQm7XDEin3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCTuiGV0neRmDbBGdk4IYqTMPu/2WlLfIFvk66foWURlQtxl+vpHjHagQLl1C66xQNWUl/ZH2IZOZqP1fRP2y36CAo6tSY8ncRKoC/NGKhaRmHwy2r2Tvr0Y8NgyyVCopUsXTTAK5r/zT8qSlqF56Dzy6eO1EgQPrSEyqZCH3L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8ivjZql; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/pTWm3UAjI+8ZeDbIACismQ5hMmb53SCWhVYtCCNVYgv4Se0Ngo29AulfI340OcpGrT724OwxXxNmEiWcHhPre81FQJrxMVzvr5XgHQgIDJQGVpVgCVy5ClBXNVy77KduelsCcinrLsMvrJxRjYTt28qjuizp8uF6Ve8rJcS8AwDsYXMqoA3gHsFd5RzW9CpeMPsl9pZZ05Lq+QA3+PnQTw0NGhRxZvqBqbFyOs8uLoVRy+0FkTJOzxVUhcV0Nu6xI+SbJdzNcNq3fbI0jN7b8JRPp+JGaUgU/RwbBUsPvlt748KNZZ0PPl7NwNswCnc3jZC4SS6i24+gjtE2GNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCnQzIsjtmoBV734qlD4ISf5K8cOkH5UuO/ABpZpHa8=;
 b=nLtB++3hCWunnQ3vOimgYlCQXzUeoNSetVcwTTggotITEs+IPMa1a8JyHd6GMFhr0vbKFSS8iN1T0aZF6kropcqBt5gnTT+8X95pmNdHW4JyxSwqyD5TlYN7fYGggAIamK1BwKi45w9pnTGpwwBQzirEOCygXvL0426nyp+gR2o6KK+sqlzI6XkD9cq9hF5RfeApOeSa15JAQ+MZRY4TL+xUJfKF5pkMHP2hxqIxV/HcEve6KyMvAFOeifIeevjptoc55SJMzsgc3FDgGWYVKHt8IxuALKgmNVjRdAyo2IZXCKOiIf5KvF7duRp60aMsBmZnMMKCtJpZRpK4C1rmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCnQzIsjtmoBV734qlD4ISf5K8cOkH5UuO/ABpZpHa8=;
 b=H8ivjZqlX/1iUUfOceRnwU7BSBDXkGKDjA8FKz8faZ4a5fCX8leWqTpNKPjM3Y0IXLuQdGXD7IzF6dLEPiWTqcFnyPEj5Fy7+Xjo7T/stRpy2A2JJ5aQvT8q+z3k+ANVtdOjU6hfnxexKZZ165/Rwe9c2qe4MP6DM1zknIAn7eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 18:48:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 18:48:53 +0000
Date: Thu, 21 Mar 2024 14:48:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	marex@denx.de, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-imx@nxp.com
Subject: Re: [PATCH] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
Message-ID: <ZfyBDBGizGwiQvgs@lizhi-Precision-Tower-5810>
References: <1710906338-4596-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710906338-4596-1-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: a40d7fe8-d48b-4160-cb8d-08dc49d78e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tetQBZrs1+hddQlv6S/9n+7mcTevPcRTEy4GttsMLmDedJh9KIeWVPSOsA9J1WxxTWTjw5gJvYD0ZOzzpWjXsmNyaoJW/PR7e9iLpZQZ91efXUL8TEwF5CKkkc6u6RuBPNJU5AXm5etSUorjM2U2CcYastcxAwY1InXPWOy+SrjpsNPs8bGtbnpXGdroVhLgE4QkOViDYv95xY5MK/uO1RsKnpB76ypRkkxm6MIb27zov2DICBX/mqSlNo6EHR90ZBLkA2aqjeSuoCqpgWdy5a1vTUWwlPTVRbbRgrme5h78pgaDL7zZ8W4sq20DiTxZ2ifI/coCJorDMAGRavziD0JrUxWfmym91DSf1Ho4AJZ07SimSW9pBkM/GzB1PGNMAv9ZSeG9fTMq+ErnVUcsqO8xb8+0KSa5mm5F1L8jsz8Vdg/t7bJcrdNJq9xhJTec1LuUX7WR/1Gf60OxPovy/08xSZqcoHeGPVjF8iFBjxW/UoXaPY4WMIkI5YlIvpwxWf2JFKsWJd7Ut1yumY4dL7BlNXppHjTqglP9QReTu33p5wUxv8Oy4Euky5UCqOklEr+9h3YblrvI+KecbXT3FkEWiYmKgPJ9N+kg6iYMtZdSUJdywr3fRSANXm0fpLHJPDFlUegZMZMGfDqnKktgE5bgyGpNcStL0V+N55rMhN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LcyOxTG5YhSeYLkDw4pIeBUiWuVr8pCvsoud9ASYmboffJZpiSZ8pJQ4ZFhu?=
 =?us-ascii?Q?/zPl6NCzRbEDwbl3JoGIr3xZJBshSWTMg+HJZjBwngDD4SwmIjhG+iJ6Nz8H?=
 =?us-ascii?Q?n6yQuEXkWdRrsLP3LQ8Z7NpTNB/tMMAAQ3TQsFgIWJ7D7++4xXIS1I2DChX5?=
 =?us-ascii?Q?TzbsdlGdbaRILbwWzFAU6fTIsdI8NBZTonfD0MGERAPfjOBEAfBwzwiYnHSh?=
 =?us-ascii?Q?qETogrvg8p0QNtX91aWKHDrZg/xNuOJFx0YI5JH4zcAKeNTMa1cU4er3wRj+?=
 =?us-ascii?Q?SDfDDwUvxD02jOOuBNY3QL+mHakJLHjGDgqfbhBmrr+nntYs0M2nm6S0sc33?=
 =?us-ascii?Q?Dq5MJdMM3hneMv81mNMwmiBfnVQ2KGAGbItUXjTAmw4fG7KbNaNqIXqnyykE?=
 =?us-ascii?Q?+hx20lJynfDzbZZkGQGpIQKLEQjadRkfynCfgKt5sFRobMouFASLMyjIlGJ9?=
 =?us-ascii?Q?NzGgvQUCRRWQ5TC+j18BvIcL+molgRAqY0Qmx4hApmt+Pg8v3yvYvynXva8q?=
 =?us-ascii?Q?et6OfDVFezg1B1s6E/4QL9bT9f+tLmSHSQ3QQnhqnT+Ub5D0EoSdlUM2jRpx?=
 =?us-ascii?Q?+MyRInsQuY3BJx8dI4PpGmfmHiUY9DHozAciOQ6fgR+9cCJthF1usIQdJyw5?=
 =?us-ascii?Q?79+QAYjxoQ1z9IJ/wHvQpThUQ5/ZXAjuVaVjF70hud3kGzKgru/fXKYp7cL/?=
 =?us-ascii?Q?Mdab3jciDJorgJOPCZST1rMBwAOBYIOywfhAp5+MpSzQOKheZu+qAmgmUM74?=
 =?us-ascii?Q?wYQwpf+g6l0KDskio93nlRSjxsD4jIKYT+hLeMNTnIImuxAw0GipMIW24bsE?=
 =?us-ascii?Q?cgomJ0q8YYYid3iR3sqUe7O57qoXWaE1qPl/p8sIlFKjWgB6zyV3BMq00ePH?=
 =?us-ascii?Q?iYdxVBAKVdBf+H+g539vTnmKV6Eh16zY43gET5oNKnybub96yUVmoZgldUkv?=
 =?us-ascii?Q?ffSYKjTAh8cW4AmrNObYnWID7DCGg7JEZbI6RmroJqlkNf8OBedQpcJOsBfu?=
 =?us-ascii?Q?yVWVyEZUtXbtbc5/dOCzLYMXMCVOn5B+q6lJhH3TP0Ag13jcoQCPMEy9UYOM?=
 =?us-ascii?Q?M2YFQJ+l7EcZMj0MdBJBjWr1jSF5JLR3y/bIJ5Rsq6HF5g2WAfp92jiUp5d4?=
 =?us-ascii?Q?ApI5lYn+0FrVBis5A1t3XqLYj2SKKfCYyJIcHrb75KQ2bk72FiNM9NcuxxjT?=
 =?us-ascii?Q?2wazKnZd5KRdJcOYotkOGUL+WA/z1fH9YzFpJJBl0zL8T8RKJgdZinGQIZUI?=
 =?us-ascii?Q?g4MZ1hTBpbsIhQ0EmmKLlcyyB+ziNayDmpDhS/941gd85IB2PAW7J49n/XbS?=
 =?us-ascii?Q?2J1XWds/y19WgEOgdDWJXRjrzZsG2Q14Lcsm9eO3Gtac1nFziw+1i7Zc7Nfv?=
 =?us-ascii?Q?TETj4h5gl3r0tnF0AfPpK3JmAu5fLi65fQbpQ+ElY9ooKncv717R9V16+Khd?=
 =?us-ascii?Q?iTs1qMixf7CrILnbaQ3x4M89jUVbSKe+/Eit35KLl4cbRv+5/mHUCTh+CHeu?=
 =?us-ascii?Q?srZnUVMij0eokMAJFyrDuyak1mUEFveNm8Yi1rj9i5Lbe9JhM7Nk0fDppt5H?=
 =?us-ascii?Q?fBfNZNfBkAyMRb9UShk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40d7fe8-d48b-4160-cb8d-08dc49d78e0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 18:48:53.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kVPKoLCRxxN1OpjoMvx6b/5kE/QIgf1KSqcxDj2VDjLsv+h/hEVHcLqE9bIiipWMv1prpJJ60XccS/vVIBTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065

On Wed, Mar 20, 2024 at 11:45:38AM +0800, Richard Zhu wrote:
> Fix i.MX8MP PCIe EP can't trigger MSI issue.
> There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
> region configuration.
> 
> EP uses Bar0 to set the outboud region to configure the MSI setting.
> Set the page_size to "epc_features->align" to meet the requirement,
> let the MSI can be triggered successfully.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 99a60270b26c..3238b63721bc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1013,9 +1013,14 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	enum pci_barno bar;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	const struct pci_epc_features *epc_features;
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> +	if (ep->ops->get_features) {
> +		epc_features = ep->ops->get_features(ep);
> +		ep->page_size = epc_features->align;
> +	}

I suggest in imx6_add_pcie_ep()

	ep->page_size = imx_pcie->drvdata->epc_features->aglgin;

	it should be set before call dw_pcie_ep_init().

If you like, I can add this fixed to my patch serial to avoid conflict
https://lore.kernel.org/linux-pci/Zfm720fz9NE0fD%2FP@lizhi-Precision-Tower-5810/T/#t

Frank
 
>  }
>  
>  static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -- 
> 2.37.1
> 

