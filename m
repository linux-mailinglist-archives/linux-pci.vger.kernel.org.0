Return-Path: <linux-pci+bounces-12839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF22C96DDE6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7FA1F213F8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71915533F;
	Thu,  5 Sep 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEd84bm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2E126F1E;
	Thu,  5 Sep 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549598; cv=fail; b=NQCLDezSc9tJz+TLO7K3F4uQOJ+ILsusV6KwRHNC6Rtl6H2BHzG7gM1kvF+c88I+Y5BqpUl0ZRlMVk/wOCyzssrRidBuw/qk1/058GtJ6Y5IkVYn3I2Cp9bEsxlliWpAZyHqUyLjIHZ5gCq9jldUXiLVLvJZOPYu/Kc//XT4Csg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549598; c=relaxed/simple;
	bh=hzsXiXQUht4hh496Z0MHKRUOGa8nrkLIp+cStIFtHQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hjst9vBNS/Xel8ly/VFPAQcJCRrb3UmMTdvU7vWBplx+yHXfKGpsRdkfooHHVkI7vAf+QPNXIfpSuCVH0mrB6UR742V/ZD+9/Fsm2KqQBe2nZnOmG00vQBlvEU2fGO5F3sCR2bHzbZ2lqTo/CPFJkVTrXER4wva0bLR1zwu5tpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEd84bm+; arc=fail smtp.client-ip=40.107.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raCZ9PaN8CD95iQfb00/XVY6FImMuk2b3tWaBtSrEkxVbvCnAW0BZFlmIT2PHh1lyn876xTouxNWMGjOz+7M1lHPfaa+i4qdVp301JQqHMZQn7FyvuCsMTDRzN/yn4ajfMy9mfa8DzC+jrO75eyrPJStBfAiKGrWnlyz/e5tgNFNB9eicFLMaF03SvgClF4cg40+ecJ6xgotIXQdTQT/aEXjW80QsAoqzGkJBZ401O5O9cppduS5IpZL95vLnvX4i/93VgE45+W69b2CZY8AMiI9K58nCH7AmMMDuEF/55xR2U2wqDnRzAB0QriEorOchTAbaLs8GZjMpxgzZuuA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6o7ACeJ6h6NI1xy/GODdfuEVXey7GskK/LCS2+IU5A=;
 b=X+AktuB7yE1vOHPmm1AHPZU6FoAgetpLjiRUVCz7KbCh5zA11679RRU9OgPQRHv0eDvZAqmOg7q4ZV6qfbDLiq/ADu4J3zojIHBKCxcGhILqiVkveKfV2gYW1hzFzpzvjpCGL3ycOnvfIG5RRs2pYsJYpzD+Ig7WQJX72AGBYKi0BVOkG6cldSGRtFvOnM2OrHeKVp+/bNm0H/0md1+Vt6kBIrqadJ5mAM2pysLpDG1nrlAWLBCrvxMmWlfK5w7EvDxs/hkWXD0wCMtcLtOVSnixH56Vbx5M5r3NGuaEzKwrN5PR8UtYRkFXWXsHkpdYrb8Yk63444DqwF5+ehCYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6o7ACeJ6h6NI1xy/GODdfuEVXey7GskK/LCS2+IU5A=;
 b=iEd84bm+AAg+Qz6xxr1UNbttAoHo3FdSzyl4EZDZyW4tMBgH5wmUBD1uGONSIcHUGTbrQyXzlUErbMQfCU24BxmCsOeboTkJvKm0sTXJ8aMkxSLnn2srOBFCbgMokrWv5ljQ2Q5TlBpfXUdOZEhEBvB4Sykq6vd5VXyn3l2vLHMArBVXEzTk54vMdbSSYr3s55R0zoDNdCmfH0F+DvUmiMvd9s1j8mBCRcOE9hxOQye8Gf1J5a92gFvRVC1sQEG5rbHfH3cK9zmxKtwGeguQ3u82D8P/9PKsoudlE8SOjObtKmLY2ciRiS3cnVSaqZjqoeidgcV6XtO+kEHSfvA4Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7276.eurprd04.prod.outlook.com (2603:10a6:102:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:19:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:19:52 +0000
Date: Thu, 5 Sep 2024 11:19:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] PCI: imx6: Add error handling in
 imx_pcie_cpu_addr_fixup()
Message-ID: <ZtnMERH+/3HiqNtg@lizhi-Precision-Tower-5810>
References: <20240905054255.126676-1-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905054255.126676-1-riyandhiman14@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e193e9b2-5716-4f0a-0e80-08dccdbe30b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X58eUPUnIUfnigBuBXze/Vc9bqv1UJXQovCxDsU0/6HqciLGTAY03usIep98?=
 =?us-ascii?Q?DqI5w5cV6tWTg+kL4Uvy8eOBmDjUy28PQuyRMYgG5So0CKQGy3ksT+M7N50Y?=
 =?us-ascii?Q?vi6Yak9cTNxY2l/0O1T8o0ktCqlCTnpasQOncV3plnahEk7ikWEf6fe2/UbQ?=
 =?us-ascii?Q?RLPykFaQKUUAu9mtrlvIJ6DcPRML6a7GR9j+t9YvhrIRfh0Hfo8GRCGNU751?=
 =?us-ascii?Q?vlagCzulb+Z2HeyLEni/hC1u6dM08Bq3c/1vIpWoLubgKfmN0d7Fu1zbOOYM?=
 =?us-ascii?Q?Iw+HGSCD57Lzir05Fuul6GHcdTSsUi53BAsGEvabXMh4/ZQQok3vdEmqlmmr?=
 =?us-ascii?Q?PainDQJeu/N2m7z1OLM+LMafHrQRY5TNC23ZxPRPkrLggIeCOdeVs4l23b78?=
 =?us-ascii?Q?EEBZbis8W9d4magkHWclaGjDjxR0A/hxucTd2z5bm8l/7BdbVADT1GJ2PMsS?=
 =?us-ascii?Q?aBTZYSoXUCmrVizq840XABRqf2nxmuJY6+HH0eOyNzNNiFv3f2yoBIBTPAEn?=
 =?us-ascii?Q?zhysH65cuSI++jfHxP8ndCUWVY7QrxBgpnOgUJvRNdRaWYe/a3YTByc1JW3A?=
 =?us-ascii?Q?4psfb2fM6+0SwP+IcTzdY+3QDcSplMYD0+5qmGnEVU7z58Foi2Fb7cukdyvi?=
 =?us-ascii?Q?pkMVkMw+Rb2sOvsVrR5UXuEmhiRxOXO9jIjZSghe5BQtE5wwWBr+yMVpTKwa?=
 =?us-ascii?Q?C74lWEU05oS8zHhipcEmSVuVj3KdQCfWRv5BN9KgVQUs+vvURkj7Smo09Dj3?=
 =?us-ascii?Q?lBSszKt91NEEBrWPg/8E5WImmhOgO1RH36FpZ518psQQzYf5YB8dLAsgYLDy?=
 =?us-ascii?Q?ZEatj4Y+VNWrVr0m7k8KziNveddNsZvLQqK6dCrlaOAkQ2nx9NdH+8TqxaC3?=
 =?us-ascii?Q?YxZlObakuvUwSywRysxwAdBeSK4veZ5SzBJYf7cma8H0WYUNL2cDAY1jbltK?=
 =?us-ascii?Q?PanpyO7x4uuvlPS0HHqtEBEtEkGiJt1JbnLU7d5D2jxL52SDCH4hu0bFoXvG?=
 =?us-ascii?Q?OA+ttEWXiXcPFTQRlVduqz9FgbQn7ETgz5zGJux8wo0z9+F1+L8nJ3yNmUT8?=
 =?us-ascii?Q?5w4G10yrP7p5m6fld6pdeNj6x8udF6c1RiSxqYpRsHsVn5tILVZ0oz9dNLkc?=
 =?us-ascii?Q?jvQesxkZGEk+7+Nu9MoUIny6HuAX7mgLiSHpvrBuTroOmIDk4+gu/QTsrGw9?=
 =?us-ascii?Q?Fa3iXRg5+zito+Zn8XygxEN8S7rhbpsPvQ1Uu5VLFRjnYejlZO1SULn6DIpu?=
 =?us-ascii?Q?q+YLWMDduQuTZtUw/L/uvifpOc2N+O6gjTPSLQfC/effFcMJpxQNizH3g0eB?=
 =?us-ascii?Q?RY1lfwc+WbYEYe9txAEYtFXPkTeTUfhKpq5F8kpEHatvigUb2h12p9GEIEf1?=
 =?us-ascii?Q?sLsry8V0Q63R/2Iuxr0JdDWHacvnOeelZjIa14/DiJ1HaRyegQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vsgg2HhX6RHPV/O2Q6NyUPYVz6Z1qEC7AHBzXdTYOl4al2EYAbAIN0NKtDS?=
 =?us-ascii?Q?IvzH3oHhci4ceBkfyovnZF/E6ldkEq/teXEo3OwlQD9qvhL9fpxzoFl9xx8b?=
 =?us-ascii?Q?td6ThmDlEp4LMC/GdDlT308WR5pD5lYncTrWgWhwUbcIpTZL+l3DHdh0JLJm?=
 =?us-ascii?Q?w+DwKnuPtiDN9Z4tVMyNGYn4adx+HafKBwnzL49dZ1F7Fo63psetHyt3s2B7?=
 =?us-ascii?Q?mSSaP6pNjvX97SMBvvbd1KXFpbQVOMZ/jNmPhs682LR8a1slUoMuigH0m81X?=
 =?us-ascii?Q?afsP7qLn2mZpv2YuCHgRKCF2ZTJL0+44CAdjZAjfNbZN4Ol1rHGRazjKhX15?=
 =?us-ascii?Q?dIUv9s2iUXL3P4UG9gSeTsRzaimY/wofRKnVK2ghkNO0FhLk/0+lhDQBXjVb?=
 =?us-ascii?Q?UhiAijqrwClge9q9SI58DjFXPhfHGYR5k0RQoCBqwZlhbHZu5+i11ICkzHQ7?=
 =?us-ascii?Q?7LUm3XugVsZ99Xw2AiE3pWEegBM3YlKTqfHO+bgtD9LCCl8oofDpCWkSuBep?=
 =?us-ascii?Q?14iZdxrtuez/+/IohdfATkU8ngqhuU8joiB8T1JYq4Xjhm9kL5XtJGs5LyJP?=
 =?us-ascii?Q?lnofuBUD6EI4vC3wJZblSZZSD0luOA2vQ8vpP4CQHgEq+rUSHlxRjJppHohs?=
 =?us-ascii?Q?MwpOZ+0g+zIihzmN6OwcBOFQaC/TUMjNCIEMlAfkKu49vQlLt0fOl29sOylr?=
 =?us-ascii?Q?XpX7Eve0I2tRnimfGNElv4x00xnhTjKavfWDgwe9MJ4rd2pkZnWddTfi6j7F?=
 =?us-ascii?Q?stz+q/hhlHJvsq5UveKwxgySx6s3GiOM268jREJr74EbWNO6zb8mWBEQAcw3?=
 =?us-ascii?Q?697xMadG3PtCe1rd2TYuiNpDxuJbDtsvX3xOZOUql0i7Ih7pt0op6ZfJGtfX?=
 =?us-ascii?Q?vCQqfcQ2OO+9WEh6X9UemSQHnogP+YXDH8VVSQ2Q1M6Vi7WTTY4WJ2o7YHk8?=
 =?us-ascii?Q?9zEBo6TsbG741ovME/ityM0CMzAtRzDVxaVHEdF9B8yfozLEZzcD2np7bKSv?=
 =?us-ascii?Q?cCj2z8eog5IyFx6BIbBzdIF8hlmKCNacuVS0Lge1/05ImJy5XQpgC815hHVq?=
 =?us-ascii?Q?S3PKJZqvi/tjNy0FEIHhHHHSr0X6OomvuVs2GTydYBs4QdB+pEfnxqNys9XF?=
 =?us-ascii?Q?ZZgLbemi8jla8cglWDoccnZ7NqVDrWwlsllRf33AICDVqtL4w892Hjz0aBuI?=
 =?us-ascii?Q?mn4fotQTeoQGEZsBQa3j2K8wkB19vZflr7rQNCZTuHhbXCLvT8JY7SiuqURF?=
 =?us-ascii?Q?T2446msg+riBaiGE2ezhRuAJoXwILkcyXJ39fSUFTZmgxddDlJiqiWSmmQGz?=
 =?us-ascii?Q?sG0B9R0e8Tzn/9ntQMY3QpssnouYJSx6W3kIbGQqvMO2gH4Cso4ndPY0CL43?=
 =?us-ascii?Q?6QUPEY5qYLb92cHjvGRjVK+ykgLlEhb+ioJhLEVC3UBEFz5M6fnLC5X2f7Rm?=
 =?us-ascii?Q?GQ4aUHkjmte6mcZ6EV1Fgqd9vIXe1fEixd2J94kuH8Dl6V/Q61vvOkIixdhp?=
 =?us-ascii?Q?aTR9lzdgCootftL0EVnJecvEBwcHqJdM61RkuTE8Fotj+oTlyBaG9uCg4lZ9?=
 =?us-ascii?Q?6zZ4Ek07kfjFiQ1Jwzv73ML9pizya0Y99mMuQCrH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e193e9b2-5716-4f0a-0e80-08dccdbe30b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:19:52.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t01dSEE0M1jgnkE7zGxDjyrIg/Xi0ZpdiWHKz+8qSPhDKQxtqxncGJaC4O3EJsQqhUTc/f4iM4ycvvOacDXNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7276

On Thu, Sep 05, 2024 at 11:12:55AM +0530, Riyan Dhiman wrote:
> Added error handling to the imx_pcie_cpu_addr_fixup function for cases
> where the memory window retrieval fails. The initial implementation did
> not have error handling, and the function simply returned cpu_addr without
> checking for failure conditions.
>
> I have added -0ULL as a error return code but what should be the ideal return
> code for error handling in this function, given the u64 return type? Common
> approaches include returning ~0ULL or another invalid address value, but
> clarification on best practices would be appreciated.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---

It is not necessary, because pp->bridge->windows should be always success.
If it is wrong, whole PCI will not work.

Even it is wrong, return 0 also wrong. dwc use it do out-bound ATU setting.
Map address 0 to outbound range have unexpected behaviors.

If it is scanned by static tool, it should be false alarm. If you really
met the issue, let me know. It is too late check it here.

Frank

> Compile tested only. I am new to the PCI subsystem and not sure how to test these
> modules. Do I need dedicated hardware, or is there another way to test these changes?
>
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0dbc333adcff..6af39852d2c2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1023,6 +1023,10 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  		return cpu_addr;
>
>  	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if(!entry) {
> +		dev_err(pcie->dev, "Unable to get memory window.");
> +		return -0ULL;
> +	}
>  	offset = entry->offset;
>
>  	return (cpu_addr - offset);
> --
> 2.46.0
>

