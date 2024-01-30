Return-Path: <linux-pci+bounces-2836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31757842D39
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B2D1C23970
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFF1E539;
	Tue, 30 Jan 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbN6YSDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824987B3FD
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643950; cv=fail; b=sDYiiAfOzB7Y065fUKYX1FPIRaxGrmWFnfxh0z/z1wAxtteZYzVdK4KwA/lSOeSkJ2Qvb6+B4aqFi3RjrG0+G1QDrKgq31VG/eb8m/IeRthIgfn7yzn1k/xN274L8xYRO/O6p+r2UafPXfUFUTimCdYbV/JOib8SKZP9ttHLSIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643950; c=relaxed/simple;
	bh=eUmpv7B7zRxQfaADmRgTZuA9/chxdPmEpa6sFaiY8Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INnPNwbDGWiHlWe/E9LUKa17T3sR+W7t5Ko7PsBLPq5+pqZaMrruoKFBeijwZbIfsdRbC5pbU9+uHq7jywkW+3bkZ3t1OvbN1OA21w/OE5qC53ZsGgyo5iEWHNV1smIirIPKbYVXQIzZNWgotlMlF8cxVuXSDU2uCCNLulgrXPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbN6YSDB; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUtwrL7D9elawAGspArAjjmEwey/onScLg4JBHTAFZd6SFx/3VKMPvd8jB4WyRZZ3Aojxj0hZ+3VrdEn1ERaDV+F6EXrNywyEeoiV5k5A4sX3XtCHO7XiclQr8eMOuCT+jKLCWnkID4RBRDXHmgE8kX8CBxJ8TrAZl5TCqc+kWxiIq0FPmn8H22Kp5n/+HD3ARySSa2TUQrjwBBuStPR0V158F40q/wlr30SkAFDNoFWNo8pWPLGxTpHr7uGwf498j3srYS4P5Hin7gyDR6a057w+YAnQ6fXpCyDkc8AqoVQbyuziJ1K6xGCGYa3do0YwxKuZ//54AnqvWylzKEQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLcySYb9PnKqZLPYQz+bQvp/P1t5UxPh1nQyL3O83WI=;
 b=Qs9yQGb3iPtaPnFXq+D3B3IxHa/uWbv526sNcufz7ciJKzCiFi24M/hhzq6IKtMiLdqUoomImkdpzcVXOI3L4V6NRKAA0oRlWtq5loUrh1gxeDGusw7t73dLJI1OKYtVdlvOPxH9XmK0fKWeqJhlLyXsrdWUYOjLNcf9ZKS0Hg/GuLzsYMI2MD/CGBF9yXO+KczkQ0lClpweftsmBknVEvkfYjDghk4/txTngJTPWvNG2S8sapW1CvmIpACbVWpeEWeH208GhWgqNMmMsRdpcTaohUCcNAi26VyXMxK1Cc4JkuGEJP/YnGAIdhl49C2i4JNPeJ/cW2cktgTrd3MGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLcySYb9PnKqZLPYQz+bQvp/P1t5UxPh1nQyL3O83WI=;
 b=cbN6YSDBi8ziVtosC+5H9d/pqoAxXy8RHE3xzGck5FG8Sns2MpmkNlJVckb0QcBef1q+/1S3d+aEV9Vfb4yoa6VGorYOGB1Zbzf4cz1OFNexlPsyOmV5AgJAePA85hMp95Fi6fog0oDJp/xpN7oZfOoIK7+M789M7z0X2+HWsfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:45:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:45:44 +0000
Date: Tue, 30 Jan 2024 14:45:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: refactor pci_epf_alloc_space()
Message-ID: <ZblR4XkWNb4zYRcA@lizhi-Precision-Tower-5810>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130193214.713739-2-cassel@kernel.org>
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: ce565dac-d967-482e-f07e-08dc21cc0c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RnrEEKkNb4gVqZ1xDkvDyjUEaryiZf+kYDBcJ2PODeX1KFdLAaRLUm//1T5SYteXyglzll7rGPeku562+o5/XamrFd1HZbbnysdDB/DJtQULp6L0Pg9DLlEPMBLoqFJV3ExbCuHKg2g4WPr88MzhwE3NCUudHe7C4aA03Yugrytjxhz6R8tFm00X00NL4uZVcQ7yya7eCQsmUu/qeqxyL6OSHaukN73fRozbEHabuHzG14LRsTndW35BSR68ST2uakrxG7yvD6yhZiHVnBqtGuJAm4OkELRB5LblKbc6/TI81Ysw4OVpXgd+JMiQcQd5SsTjoPu6lA5jHYTi9h+PmVAMWXADFhL3H0dbF454VgVMYOCCauN4S1HPWAVNlxoLqJq43pE/ryAWtm81JwSzAGmp5FHn/kQB9gJBXvqCQNQ1lDSIAoLegWFLs8t8ZoD2hDHEeOS531Uaa2KwPelNXC9LymMudwbkIriE9H0cFamYcBj1eoWt8/RWZf3/mMeOgDWlJhm6kIvDBTrrK4vZ35lsL5tjqdBmhfzJ13pIGt18Xtq+WjCJ7kkiMei0eTOVk/CRsoMM66pubH+NKdO9KcERYVr2o0AJvP+Vit4YTePULhBU5ie9XhsKm8WKFt4b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(6916009)(66946007)(54906003)(66476007)(316002)(6486002)(478600001)(41300700001)(5660300002)(86362001)(38350700005)(2906002)(7416002)(33716001)(8936002)(8676002)(4326008)(38100700002)(26005)(9686003)(6512007)(83380400001)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mue+Y7szvyrHJ8RtpDBgynBr1ov5noPW8buDxybc1a25LO8hPhpkvQOYTV7d?=
 =?us-ascii?Q?B/hGuCIHmggeURTowmSyOvA/w4Pumbl57hM2+QFjGj89I4U8itCXyvsec6WN?=
 =?us-ascii?Q?rrV7zqPJFTSpmpYfn50ZR6Oacm4CJ7D1K60bv+4+zLI24DU72U8QInZ/nnVR?=
 =?us-ascii?Q?O/X55mo1yRt3Fe430KMp6BLgkkO3vO1m+0rA2h1z7iASZCtvHhcU6Nocux8+?=
 =?us-ascii?Q?7TpvU1bPQnxxuARgDaaqejtZmB2b2KwhI/wf5Nr9SclJ4DV9Y/ft13xpz9Is?=
 =?us-ascii?Q?dWaKW4FS+eaN6zulRRnZDOENlO5SEI4yAhUun9KP/bRmIdoH5SoJ5X+UMkWO?=
 =?us-ascii?Q?3pg17wwQIShtU0ueqY4MG0ygoU73qmRLiRXYmDUEfFd4vR0jsz2vP2s2/7D3?=
 =?us-ascii?Q?dXC6ZlxB1kWlpPdMH74NBzBe7tvTkKEIe/DSye/rCkx+s3yclmjf7JFgHQ7p?=
 =?us-ascii?Q?aWyb+BFQgJ8D/Xn77pI/cUoePH9C79bPk4jU3BBbKcsVklaz52A8ArH3DWj1?=
 =?us-ascii?Q?VwlLNPUjARHrFdIXpZWh3WBQA7tdFpiVNDW92gU4i1Muw6zuba/xkpv9TBuM?=
 =?us-ascii?Q?dlEJ0rITePGELIAAO7hwKXle3/CP0g7s2ZUymUiqoSUbXaxKWXGhdaZZzXo8?=
 =?us-ascii?Q?gjH1oumu7WTpgFfzb/1bpOSm7HrlY3Og05iwWqmeYNMHaaRzRORpVhjNXiiG?=
 =?us-ascii?Q?yANtGpQGq6h3UWRZDE7HXcztFd+priC0A17fZTdVN5mRZto3abIh3Fv8fYTX?=
 =?us-ascii?Q?nUAhaWhv4RRZxMUIsS4wXqHHAO+JOAD+LWRNp65Dhp0Ny3k3d62cDgnT/hRE?=
 =?us-ascii?Q?OQScS4XJvHu37hJs+gOYRzfM3KgjdHz0IKi++mr7aMapirW1GnZj5HPMll2G?=
 =?us-ascii?Q?5Cxd1yDxqkSxgX2P2H3jGgvRZwZf2YZGhcafm9c2sbf9wO7oYz3SspVYilpS?=
 =?us-ascii?Q?5k4gTTilqF4yjbGYwpmcSzqs1bRrkF+kC/f5J21+1BC+QQCTLMRJT52a9i8v?=
 =?us-ascii?Q?/SrAogdxEZFu2DIx191fVuhb+CKdbT2zX+7wDrcZF3r6fPAzVrvo6paej/2B?=
 =?us-ascii?Q?IGiuHRUVAfqFg5e8EhXZ6ihtHkzODyNVdQOnecMu5bBwXmRABMwY6ijpN7JU?=
 =?us-ascii?Q?0kL/BxkPh0vLW27Zn1JsCtT4+u40bXT/sFBY+raXdDJqc+nLWvVR0pBugFOG?=
 =?us-ascii?Q?V0go+dQeK1mRJKdUBwMxXnK2d12+lcKKMhaKO9K9/lf16+knSQChFxfILs39?=
 =?us-ascii?Q?Te+8yBvEfx814FJgEbQVE7H1zU+Dgali1FYMkYgMW0TDjYnCnDiikgusuKPE?=
 =?us-ascii?Q?y0pWrOmYJ4p1I3rnm2iKeYguL0VH7BlC5gK+tMajLPGup8lIhjlKcNsRjusU?=
 =?us-ascii?Q?Wv2apO+/JrVt6qwH1bUDm41Yo6j0qFFJHQGYYKNzyD7b+e0Njm7PZe2T7IoH?=
 =?us-ascii?Q?1J3aUUUsn2gt7cHSmSwQQicPEHB6T7qgv+FGB12fpC7Ori0jbop9YfOe9+Ax?=
 =?us-ascii?Q?vR8wNvCXohQBd9bf8H5PW+duwiPJRmC38UMkTXiuhk39NIO6AaqfqN3KptZD?=
 =?us-ascii?Q?nhkSZaL8pDd5UiBd7bWInVrlHeLQpxl0SONpYLFW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce565dac-d967-482e-f07e-08dc21cc0c81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:45:44.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyQOf5RxBmWGKRel5JWL0jetuetZ0pQs71znk9vl8DhhoL8Hq4vyJl5foveAHZ09tYOihkX+sIJkZZn5SYFzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

On Tue, Jan 30, 2024 at 08:32:09PM +0100, Niklas Cassel wrote:
> Refactor pci_epf_alloc_space() to take epc_features as a parameter.
> This is a preparation patch needed for further cleanups.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 ++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  drivers/pci/endpoint/pci-epf-core.c           | 6 ++++--
>  include/linux/pci-epf.h                       | 4 +++-
>  5 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 0553946005c4..43cd309ce22f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1067,7 +1067,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
>  	else if (size < ctrl_size + spad_size)
>  		return -EINVAL;
>  
> -	base = pci_epf_alloc_space(epf, size, barno, align, type);
> +	base = pci_epf_alloc_space(epf, size, barno, epc_features, type);
>  	if (!base) {
>  		dev_err(dev, "%s intf: Config/Status/SPAD alloc region fail\n",
>  			pci_epc_interface_string(type));
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 18c80002d3bd..15bfa7d83489 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -848,7 +848,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  
>  	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
> -				   epc_features->align, PRIMARY_INTERFACE);
> +				   epc_features, PRIMARY_INTERFACE);
>  	if (!base) {
>  		dev_err(dev, "Failed to allocated register space\n");
>  		return -ENOMEM;
> @@ -866,8 +866,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  			continue;
>  
>  		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> -					   epc_features->align,
> -					   PRIMARY_INTERFACE);
> +					   epc_features, PRIMARY_INTERFACE);
>  		if (!base)
>  			dev_err(dev, "Failed to allocate space for BAR%d\n",
>  				bar);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index e75a2af77328..ba509d67188b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -446,7 +446,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	else if (size < ctrl_size + spad_size)
>  		return -EINVAL;
>  
> -	base = pci_epf_alloc_space(epf, size, barno, align, 0);
> +	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
>  	if (!base) {
>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
>  		return -ENOMEM;
> @@ -550,7 +550,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
> -	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> +	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
>  	if (!mw_addr) {
>  		dev_err(dev, "Failed to allocate OB address\n");
>  		return -ENOMEM;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2c32de667937..e44f4078fe8b 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -251,14 +251,16 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
>   * @epf: the EPF device to whom allocate the memory
>   * @size: the size of the memory that has to be allocated
>   * @bar: the BAR number corresponding to the allocated register space
> - * @align: alignment size for the allocation region
> + * @epc: the features provided by the EPC specific to this endpoint function
>   * @type: Identifies if the allocation is for primary EPC or secondary EPC
>   *
>   * Invoke to allocate memory for the PCI EPF register space.
>   */
>  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> -			  size_t align, enum pci_epc_interface_type type)
> +			  const struct pci_epc_features *epc_features,
> +			  enum pci_epc_interface_type type)
>  {
> +	size_t align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
>  	struct pci_epc *epc;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 77b146e0f672..adee6a1b35db 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -15,6 +15,7 @@
>  #include <linux/pci.h>
>  
>  struct pci_epf;
> +struct pci_epc_features;
>  enum pci_epc_interface_type;
>  
>  enum pci_barno {
> @@ -216,7 +217,8 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
>  			      struct module *owner);
>  void pci_epf_unregister_driver(struct pci_epf_driver *driver);
>  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> -			  size_t align, enum pci_epc_interface_type type);
> +			  const struct pci_epc_features *epc_features,
> +			  enum pci_epc_interface_type type);
>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
>  int pci_epf_bind(struct pci_epf *epf);
> -- 
> 2.43.0
> 

