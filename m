Return-Path: <linux-pci+bounces-13525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4498652B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C081C24ED7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961F4965C;
	Wed, 25 Sep 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IZY3XL/+"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BD7581F;
	Wed, 25 Sep 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282848; cv=fail; b=U1EcrqCbfL8Jyb96Bh8CurES5STajlWDMv9sNNrcMgwPohVN3YqKlJqQlsoWLfC5t6H4GRenx560+LrF67V48Rduw+9thNmqidS+YKWG8y+9px5x3IJDEtUSJkoKJUBi8lbuEpmyjZCkmZIXoCoP8tduFt1Uj2CB7O5Ju5e7ToQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282848; c=relaxed/simple;
	bh=REi7rBgo2/4CnwrjdnkH/4SikPfMaJgBW1loSqcVrrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWQRV1vntey4L5eWyS2x6oYYFphOYSIzc8XwPwLD4HmdYhMTddwnmdn/WVAWUIx8afwrI2zRjlKSx38k7/KPL6XqotgAqF59ICrb1P7lHINWx5aCGV/W9VA/69RfxjkL4mm9DdbA6a1JUsdE48FKsDTlosSJDpRbdd/qwI+Mzm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IZY3XL/+; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQPbmfMalLAZ2YzFKIfnvRKwOF5vy9ywxcIG6PN9o96Hhf+wJKONWuM+ahZ32ZBiKW66X7G0JOn5W9fpROIsfO6S9ee3wtGjEOHsFCkS8i7MZoO/h5lDTb/+HrOaS57F8tskux3GHB0ew29ukEzXhzDbN1I7GhM2GgpaYBFQZ3+UQgyC3m1devXDexfqeL/D2eUp68jRHgSCz6b2a2m9gPMe2CfxrhqbQhJluwjxzC2EdqIYcQ4hSPXhIrSZfyKl/mkSCSWewxLlQYCmgLne3n9ZcWAiEdGacjqYQO01IJcg7W80/XJ0tWM7nSWqIu2JfQX3Cv1qBR/jnQomh46ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjDawmF7RmjuAeyyQo3/yT/C59hik3M6IPauaVmycio=;
 b=WcwD2hutCBmMtwZQ4b/xQF99E7PocXQa7VEvlBEQVONU6CnUSLk9ENGA0AsH65aIoUXxa4K5hZDjcf1eQTsK6a5cSvnfzH00EwMFJxCR7/PCbHKm5qxy9UQzZu/GNJMeNd8ziDHrTvjkqErZ67JI+Sa6qIYmz0qNTEBNLhCca4q9H9kkBweQwUqivp9q4pu4cerStfWAS2o9NBw15nLDdw4wxypsUT1dEwAROkRSprxAn6JRjE3EqHP3dYiNlYu8giWKkXWp9oc3AJkg26NrxzUJ+rGeasFHTxaKIUOo7Mg47u7pNob+LNd1j58X70eRzXcPgW1rBr1gBjQBkr7szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjDawmF7RmjuAeyyQo3/yT/C59hik3M6IPauaVmycio=;
 b=IZY3XL/+7zzCWKK5V8vvyR+N8IAFSTUGeFkhveeTjGgrFZuAdFn2IhubRaoO9lPNtNkar9fwfLdnq/owjcc+2jTudhElBZia0m564e/XsN2RAxx6s6CRtna/qhYDu+tQy4jHw/Kc/aUlCjyq6fRCcoZOXEIlvEv1u7bsntn6ZfFPkYbyUFlIRzSFdOSx0JZFsHWTBASlqaNm2Sc62muAleXVq2kCAI0FuZ/pdUp+mOWwt/wq9F54X/XD6ChbBmXeXH6rXysBcRZgGIsEUT7GKbVEdYqRRJftbRYo4Z5Y8lOwGzmkLx13hXjV7zdqwSPNHhodNVQoiwbJPzDMZY9psg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 16:47:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:47:20 +0000
Date: Wed, 25 Sep 2024 12:47:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	kwilczynski@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 2/2] PCI: dwc: Do stop link in the
 dw_pcie_suspend_noirq
Message-ID: <ZvQ+kcXxcfRH+wpr@lizhi-Precision-Tower-5810>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727243317-15729-3-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 612e328a-4d75-4ad0-dad9-08dcdd81b8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4SHBzy7VJfyhInUFYHg4i4kRaHELAQunFi935uvtVp7g6pK7jz6qaaPLKY2?=
 =?us-ascii?Q?qJPZHqB9CswILAGCB425YrYTssnpXd+k7b6M7TGaTNCKN4ufZ/hFHqrcIuUv?=
 =?us-ascii?Q?yG+excIJtB3NaaMeetiPP9n75CNKHct6JMVs+G3z/X69NKjM0UyhWqo67hDB?=
 =?us-ascii?Q?VSWy1xFL3ObHqpIJoKOwWOO617hTuWxGXgqnP/uYxgrYcSHsSWd9Cy9RbRVV?=
 =?us-ascii?Q?UEG3i7qPJZR7NPoUoI+dMTKCD1RN4fvLBzWp+kgtlJ4MXLIzJhIhsPuwtdl7?=
 =?us-ascii?Q?jVsRcls1FdmADLEcSfsLdnKbRQr4wKdUAyEawsPeq2xhqNZPJR2pS2ltgSon?=
 =?us-ascii?Q?oN7q/04HW0da7lbKfFVjbh4KUWF8DQPGD+FisezB5LkYMmpz9NCWdhcwYc+d?=
 =?us-ascii?Q?GzLHNSn5dE0T+TWjWEFersrODSwopPrvn2E5ord2r/5U0Gb0bBO3jQFBTusc?=
 =?us-ascii?Q?FxwMSsw62Ypu28fieD4Eqw2dvmPiao1XCHjisLqxsHQtC8fmmAHeRzU37+DO?=
 =?us-ascii?Q?8UDmw2Rb2MeoGOJOOax0N+EAchfUSr78WK1fT5+Qt8VNZX3Gontt1qGPZ8dF?=
 =?us-ascii?Q?HNbfn4EFRLEW7UmkH8uEM5a+ORri+QSS0vrWWb0FXg7z+Noq8yO6slUEIh6U?=
 =?us-ascii?Q?MRvWLySsAWpgXv/ZzFME6ChgK4YV9wtSYlO9l2Md7sS9gg0305vkGlJ5LOnz?=
 =?us-ascii?Q?+FOQVTvNBr1BOeiyc3kic3oboTn87axEKPeZAsK6fh3f8h0TvSNwsvOBgXQE?=
 =?us-ascii?Q?gzKTw580PyIPRNPQK2lwOSeyUtMyVK3g9DALhZjpx4I4h/O3jvgnTm9i3/Is?=
 =?us-ascii?Q?GtfGK8jzwEnVp4osgHilQXtwoaB56hP67dLOQfFLDPzRhGFYdCB/RdtFOF6e?=
 =?us-ascii?Q?CZOP/qaFXF2+TJop9+edHljXFjvatRvUx3vvd0k/hnYH/sPqNJi/ndxEd8nm?=
 =?us-ascii?Q?sYeg4ZYqLKo86m6Jq8qemIU8m9WTi8IXOWhvYtDCoS/fJRH3vMLGK4QnT2uR?=
 =?us-ascii?Q?aAnok2KGaSqhpJlVfSxWgQDUktsC8lg+nF+AJv6Z7EBs7+bTybFeserD6dWE?=
 =?us-ascii?Q?0yPqL5KCEf2qoc6HFO2d5RNbK0TkZ6Ke2y2x5BAYRJWsWYW1AF4+eME0KEFq?=
 =?us-ascii?Q?IVmLFdI6oiSfgUD0VKCehChTYJT6+Y/Olg+50k//gpDOuYzvgSiwwufUfjQY?=
 =?us-ascii?Q?HT7NdKPppoo24uERboT5h5cXubyoxq3JqPblblDwcu74qRnE55yO8/EI+EcA?=
 =?us-ascii?Q?ng5vbYv53R1VXgQjbC8quSKWw5u6XPQBOS/zfTff/OVGQSCMaEoGLeygdtKd?=
 =?us-ascii?Q?8IcBE7p0GwV1Uj/xnVQcSVQQiT4mNBJ4Y5UFH3lGbY7rxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?06Y16GGifRLRrFPJlmZ+9gN4DqhV5ku7Ticf4Zj3tiqh2GQMque9ua/3zmCo?=
 =?us-ascii?Q?DVPGqKGkne+YaQNo5Cu5y55ZnQsRL0Oy53XasW9W40MpMnLVXsjr6jc5SqU/?=
 =?us-ascii?Q?rFNWXzNu3JIs2kJ34pKx4/TPr6EqfnVFoQXYbCM299VLtn45iEspeVtxt/Fv?=
 =?us-ascii?Q?UCJgzzgFtP3sEfbm3NHMViQk0xhD/nGMtH6GwDdWFaq8ROSPAYJLpK9DG9Du?=
 =?us-ascii?Q?PQizDumwhpsqYr6ynUWkYUOmxK+GCV5t1kNDzgFGG3TxZEtP15mMyoJKflNK?=
 =?us-ascii?Q?uthj6g7j65Kx2GCzbSQc1boXy2VRO0X/okf+6hks6aqukn3CoJhvq0iWFBZ+?=
 =?us-ascii?Q?F1LxGEgwP+xd6SfpbetZbKBOwYHTbs+qDzYGhDY/NDniztb5+obg+hn4m50K?=
 =?us-ascii?Q?lPEVT1DNKCLLX7ll+SvzVDAwdYH1mosCkltkSML3d+Tb619RO2K4IXDfnK9E?=
 =?us-ascii?Q?pTLi6f62M8VLFSJA7gToxAjP8tgwdr5IA93XC0MmSQxx89C9ApxPQfGzvkFp?=
 =?us-ascii?Q?Hixb8yMwFp5izR0PtZRbiNU8xfyT7p7wHpTcz3aUaal5XGNx1hQmvFprMuCb?=
 =?us-ascii?Q?dWvz1u+QotYlRxNV2Z8uVH9uZBsAHP67ZWXSSPe16PTprOamk/K9T0jWJ+Uv?=
 =?us-ascii?Q?EXEO/wD+AR3FZH7xS3+qIkIDA3j3fPnh0XLv2JoGQWpdZrIJnYtLBP0ZzfZD?=
 =?us-ascii?Q?cq4sTCj0xe2p3vYJ0OCE2zqQQUPndm2843JAY8NHO3NGGWPzH1/T6u9acw/N?=
 =?us-ascii?Q?eF+rcAGs5z8Nlp7rL8bM0Hed18FgM9cZl31Ud3o4qVIN39Dz+A4ItG6z7edW?=
 =?us-ascii?Q?TWhD8URfDz3IGPttYSpBLWvHjsxWnIqDxFBkj8ap39lkT6SQp6hYbR/u0L2a?=
 =?us-ascii?Q?lj+/b9sWjWebErydiiOWCdtgtCnez5/i8qydfanx0YhBg857hGOBnDazq4Fz?=
 =?us-ascii?Q?qMgE4VvVZ2Dcovlx+yMzUKMUp7lRkIagkgo1uxCmfy60mCFRhb84xqpkOPtE?=
 =?us-ascii?Q?KX2FEwy6gTaOk0jCU4P/kuZK65wyfxrqm6oKATATlmz+MyzbGz0QbNPw29kF?=
 =?us-ascii?Q?gnlbQLEoR2hNN34ze3GrQUoTPGrbbgPgQDJvWNzeBChqja7ZBsNBldqrYUsY?=
 =?us-ascii?Q?2TPEymiaKEoDbvyoMk8uUFDs3+sC/TbUWyhnW0lswYACcJn7NtLy9Xva+HJL?=
 =?us-ascii?Q?aXxER7fRPfVtr5XeoPr2qFneZX/bBO3mLEi2NAmfnADhPL7q0zYU+aw9/ZLp?=
 =?us-ascii?Q?PMYOtLAMs9i1AR+e5IeNJiF3gnk+dxEMi9d5lb/tDChP19EIA0asrMc0U6KU?=
 =?us-ascii?Q?l0PKaeIm+LFHuOOrN8VEBg4byHo1/jQ4h9XCW63otR5FFuoGxEHFIh2jREpe?=
 =?us-ascii?Q?KKwnHZoKb1r+ao9AHoJiPTyrr20VjBzEMCP6kHviloTIuwChukvfVBVfy5E1?=
 =?us-ascii?Q?rgqIw/LLAiblgSnNCsn3zaixlaQO47HcFw2H07lHgI83Bze9zrin6TaMgJI5?=
 =?us-ascii?Q?bBvcs5c1JWz40Er9gArcOYTHLWDgSi9/dDJ8bSx6lPpvZ1lfduELGA5Y5tg0?=
 =?us-ascii?Q?qkIE95iIVsed/TyINCU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612e328a-4d75-4ad0-dad9-08dcdd81b8ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 16:47:20.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzesIfGTXExK4n3N4ZxGPXAXikMQOdicU0tN+PRSwKtcyZk3CqbX0i6auTX+u4J0A0swjtC5k/lJXQ3US0R28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

On Wed, Sep 25, 2024 at 01:48:37PM +0800, Richard Zhu wrote:
> On i.MX8QM, PCIe link can't be re-established again in
> dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> dw_pcie_suspend_noirq().
>
> Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> keep symmetric in suspend/resume function since there is
> dw_pcie_start_link() in dw_pcie_resume_noirq().
>
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cb8c3c2bcc79..9ca33895456f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -952,6 +952,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  		}
>  	}
>
> +	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
>
> --
> 2.37.1
>

