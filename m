Return-Path: <linux-pci+bounces-42502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79784C9C244
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140E04E6142
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6A298CDC;
	Tue,  2 Dec 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jXUfv4UM"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56227FD7D;
	Tue,  2 Dec 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691759; cv=fail; b=eFBEtT7tNYTw94Be2GlrxVl+B3+9IKyEy852cr4MYZchX2iuzC3bsyM5KAM3P80kUJBphxRvHAVx9lujQa2ev4qeQpHAs2MkOCkG5lQN9hqbD0mFBCY1Qp/TVMSXcTkwvz1YS9NtOhUTcj/8Yep84DlcMOsekcMfv3Ay/HL9IIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691759; c=relaxed/simple;
	bh=rPCcjiGgmBRKD9EM/o8WYzViEn2cJ67NqNZPm1cbQ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUhz4D6Y9JMCww4RGea3DRXodXi9i3bVvQ3aYolMMipdmQZiFuU80lrALwLHlX1Nn/XPNZRfEQodGP0snzuXLhM+YOAgK27mHAMDD0XzsjozO39fRWdM3V1UKDnr/BU1BSdJY+vES4HJYb+C3zrMmo9LZJpD7Tclf1JQCWX80lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jXUfv4UM; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIu3pEHVRcGdMG6AKIkD3Vp1dhrEOhpB1vtiZ4xP8+rPIGwJKd2ACq+CwUbZWNOA5DTodIElIRIZArLUQlpDqPbbcxSxB1QZwSBf9csJOHh8G6l7dpd5LrzkoLoX99WRU+JX58Ba613cpamMtpOQckuN0i8/GSk5yxY7AgP2zPXOUYGrcfnC5BA8ilarROjbj5TBp0fLT4PXakDkRjhL8M6ZaMdHhZ7/8qRNJJ8uTpnDKTD6ZsDUDwrJSa6K/1gnyHI3bncGVmK4J24Zo8Z0FIwFXqHdvwVXSvmaFRWS3SPEsodXZshyVyGY1XyhQajgKT8/BSkUxR/HdS0NfpH1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+FFQgqfC6OY0cfaSDT3JAKFr5rwLHVIhaNTNtGjv3Q=;
 b=F9Wm3TXDOoSVRHnvBd/Am7hnc0uZUWosy4z9+TekcmFHLS1/mT+kl6t5Dnp3LISAFS7KEyter7bJgSb9obuuMWyMUiz8N19gjljKRoySVmtaUir8VyZArqHi1G5Xb8l8CAUogNYX6tF1DSmHI5n6dSDAvRKfF1XaT1cVnx+d+s5/IwBU9aNtF/HGAGYxwa/srrvIeEFS+4Y0jJhidMnehWixTiryChfYFiuKM6uxItf6NGFJ7e3fNgZvUhJXjTfBCtKr0auX4mr4u77Rm5ivtkGLyHGtAYkHe1xa3DkhdQrm+F1J2SqjgxYLZO4fdOQApQd31lTJE7xRnHRy5Vo7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+FFQgqfC6OY0cfaSDT3JAKFr5rwLHVIhaNTNtGjv3Q=;
 b=jXUfv4UMxHHAk2C9d8/00se8ozJTtQESrY8z3LIMY98lJB0eyPX/3s0zu1sPnN2y4YVBXKDPHljnrte0LqKVRzXIX5pWGW0sTjDDrRHS2M+/RP6FYUciAwGq1AY2YgE0qlCEffyV9GLJU51ZAB5Pj/bkONxfqyYtHvGGXMNINXvd5UrAl4V4wvsserkc6XXj2uaj13yfQ/aR6xzlFJnrHu0CM8iYd6aMddeLqfqm1mwlrVmCIUIYgzFGXdDaFiXJAfDjNCAHfh1Lu4ETxGPBwBBs4NIvDfGAu/WbK9EvNMXBq7iBtaYh9nF55iBQP4aCRWvdRIQtH2/EC87wXJz/5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:09:13 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:09:13 +0000
Date: Tue, 2 Dec 2025 11:09:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 7/7] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <aS8PISIwAes7F/bg@lizhi-Precision-Tower-5810>
References: <20251202072348.2752371-1-den@valinux.co.jp>
 <20251202072348.2752371-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202072348.2752371-8-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0043.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca6586c-5572-4d7d-0b6a-08de31bd22ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bh38SF4pBpRxl39wkrOv1X/4f7oDgOi9lXnAshRbZZzccg8tSwSwTmpGHz98?=
 =?us-ascii?Q?xGUiPh1K8JRnoHXcgZWcgl5ivNP2QeVm0eWm1OoxlgC5FVxLVNKw1qQ+SBtp?=
 =?us-ascii?Q?zqktYx8ZmVQexRpzlYL5SXSayTyecSA9k3oDcF8fqkn7fMwEFHYXq4AqhZnd?=
 =?us-ascii?Q?24wwdMf7vDuKf5RopkjwKBSg0k+qP+0lvVQH3cdKyMJmsG+Xt9H6VeKix+rS?=
 =?us-ascii?Q?ciTqbQodhoAOzdACY+OqnmmEOEn1ziUT7cVbYFt8lmZJS7dUYFEaCZddvV0H?=
 =?us-ascii?Q?ycFjU39wv73IfSfTaFkvJo03MUiCDs6k6KiunLoj8SX6yS4oRq6fbqWzrdM7?=
 =?us-ascii?Q?m5P3EbwfrEYlY/TYE2jVpjofEbRNZFhND4AmSDdyUxh+KfrXTbmQTzA/CteQ?=
 =?us-ascii?Q?AKTwYNOFgo9wbpnWEMt4c5FTeFNE6YEA+hvKTTKY+5mt0bLdhAOw+Ft/b19l?=
 =?us-ascii?Q?4gz7/bq2Ma7IJBrx92d9EN6OXp+lrS5GyvI/OubNejwTGWApcsK8t/tLEJEt?=
 =?us-ascii?Q?AFybLS4hX6bWkFxJ6/Nl83lG0nVT7VxsjMNHzSj+KaMa/dqnAUgg/zwGfaXr?=
 =?us-ascii?Q?Fln9D1ucLGTJXCVL2yx1SdnzQgJXaiiwGphpKV5w855duuFlZiHW+LdzzZ1/?=
 =?us-ascii?Q?OE8zNVgxWcCRxxgnuhhgIosgauvD+3AB81xamB6iNajxuAO00YMZzfBxAtHL?=
 =?us-ascii?Q?ea+s7kEyLvZ1nYRKeUnrbFWUeAeiJ+APEDjLyVJoyi/IwJ69v9dY1fPtCgPw?=
 =?us-ascii?Q?E8xQXsrtxN7a61iWpRO99aIyaMCEr7+mJvt+XBMz1iQ4PNApqAM4+SpOn7gB?=
 =?us-ascii?Q?k+iDHbEYn7O76OiFM0mF2wYbwR60klls66k/dk/fb0odB6dsx9rwtXH95IA0?=
 =?us-ascii?Q?Wis4lZ+s4sFYVSSNSDbc/ve66l6Y5kEt2MGuYpSWSV6cG8toC64nsV7Zf/Xu?=
 =?us-ascii?Q?v4gEA23D6AzoNYVi9+tebO3r4k1PVvt5Pjkq3OdLIM6MoSaETyPmYMOrfefq?=
 =?us-ascii?Q?YVIWwiBAqRf1Nca2fH9U6nBuH+14dMnQ6+wD5zO8Rn6aaHEd3RQhkvipj2e3?=
 =?us-ascii?Q?J+B9IECkLGblYiJAm5MjMG9+mQa7bl32K8SHmnraqYw7/73OwBO7CUclwtWB?=
 =?us-ascii?Q?CfbXmgQ1ffQ5Ip6PCyC71Ip45mxyeqUS91/x5czJOBf3QLTf4rw1QjR+morb?=
 =?us-ascii?Q?cpQsjiTXe8G61R4iCyMWkH4lCDs1+jgyj45mQUfU6db+PMYChFouwMrE3HV4?=
 =?us-ascii?Q?Xh86YZ5ossFXcpLGT7pTit8cCiX354YC616jOxql+E/jYNsdehnGHSD4ayfk?=
 =?us-ascii?Q?X0CpOhvlOt/OWQ6WtOPv4dl4UCWvSJFHUBNI2sRAQ3mU/G14mSHox55L+p90?=
 =?us-ascii?Q?tOLGsrzOKQwmtZTStoXRSHDby4991PmBG4iiQRH6DLqv7VH68hyiNDDmR1h7?=
 =?us-ascii?Q?w8RuEn0r32MwI+ErpCzFHaOMK/FbKxp/nSUVhT/NGzppyWZqvCTRtoVoafnd?=
 =?us-ascii?Q?hNTODkhgZ8q4lzJ/Nq8lbpzb/uLu3cFixFi5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/o8nIlZgLNXK2KgcZqsstS6R2SwAgcsUyBFUw2f7wC5VeffGeCjk1kwbt8j?=
 =?us-ascii?Q?HmOagbz7kCpeosp1q+s2qNKfTQPbi/bi1aBLvmd9q9DVzodYAPGR0i2tNSRM?=
 =?us-ascii?Q?osEmnsgj5jbD7iIQh5DgDlIqf8kk3S3cwhGaZ53BBvG5cbgHTF9NsHXF49Y7?=
 =?us-ascii?Q?pY4LMPpUnMaEOY3sNoDJlOPfV+hyz0cBvFEx3hVG84Yn6bjkFpqWLVD7Xzpk?=
 =?us-ascii?Q?0Z7/2YjZjiaHYs4OvXUoWZnQmLz3xkCMkZ94wcbqzm4l4rx9ew9tNI+e+L/Y?=
 =?us-ascii?Q?7rRdAmab/a1VvIPW53RZ22g9TSpCaYixAW+bQDRwm2/aaum9Gnsoi2xil1Iy?=
 =?us-ascii?Q?T/bT+4ZskJ9YDq5Tt+wkwanmdpAIHsw3BZZJ98CXg7JnDPv4UgW5KfFQ6BMl?=
 =?us-ascii?Q?sVPAu/o5izt/MQvBJWTcKxY/Ahyzray5ZlgWlJgLeROAymy0qZG/pnNx5XGJ?=
 =?us-ascii?Q?fH+THfDfl2Pt96x1q/mTah/Wsu9IgXcMwY8bKgFv9KkpX4MdTSOmQqBOZI3b?=
 =?us-ascii?Q?t0NauffNrCQNa0GHdpdKHqLPwsxhFLvEhln16m3r2MWnP2tCzF6MRBfxxlof?=
 =?us-ascii?Q?fCNsxiKwV6L+xEtB3SrHl4jd7UUvt0KbnlUpnY5SqDDaQM+bHDjoBWzegRUu?=
 =?us-ascii?Q?sLuMw7XLY+d7y4kaCEr7ldsFv1Tl2w7ellI+1U/4od7wKU79sJMO0uCyFL3S?=
 =?us-ascii?Q?B7HQ7JCyOY+0LMHPSE1EldhKmbsIHck0pQovhY7DSrnmAw/lDshwG01jRfeK?=
 =?us-ascii?Q?kwX15xQV3pjnpf2D0m/cD+vF9SjSWe4h45AKU7c0ywy2tHmdPB4/TkN8axK0?=
 =?us-ascii?Q?mldu/e1lFp12nPXNROI8xQAA/yDuDs/rf9Gm1Lp9j8VcGmzy8xclRbzHvowT?=
 =?us-ascii?Q?W/7oXXqEn6VhPl64vJLiVLxmzzGRBQMK8rVONrVm8SutvBxG2dYdkHpRcnpk?=
 =?us-ascii?Q?FbXe+6op21QpocgJWEJ2ieU6RK+aDHfMeOqfo9DVjB+883mImaSBt250Xw82?=
 =?us-ascii?Q?kbk538uep+2QW2dG0rjt5zDrp+KdPMKyvTXBV7xRbiBLqlaUWOBOAjKYR2DA?=
 =?us-ascii?Q?RtZCJDbVor2iBqe0EdoRxd/c8yzpaG6csFErEaY9JqOoJpAOVg4rKst9us/R?=
 =?us-ascii?Q?IaSxVOs3fJX0S1hN7yDETKVkfI7pXqr91uGjTYKRm8eq91+IDsIuu+Ps+GC5?=
 =?us-ascii?Q?DkRaa8qc9K234BzcjdxG1XZObAbvpq+7/zZTRgB+/FhNshdMPnxX0LhPuYaL?=
 =?us-ascii?Q?ibgJECPAgyIMl8X8fPIWiXdTtw9Rp8rm7LaSKVz7T5bZy+71q0Z5nYUiBlSN?=
 =?us-ascii?Q?/gNa1gOQKtWhVAV3JhXMTv+wpGNfyOejjAECeyEuKZJ/uL1BALbL9vZ54e4o?=
 =?us-ascii?Q?ruEog3Y8j6PEyPMha1yZ9L33C7ZhStUU/d/ZS5GYWxBACh0hcb7sOTRecdAX?=
 =?us-ascii?Q?Tdru+9wx0e/BxJ3NR/dSUVEza4jieaHhiYqB3LEsKe4G1ErRTRnr2GzvkIM4?=
 =?us-ascii?Q?OcW15k4YL2IECVyvN0amNzu4+ZEancN1junoE3j3ysc9QcTcag4W8b1JA9zw?=
 =?us-ascii?Q?uQxbrfFgesmw21ztzjtOxOjVi72OfZSuZPYNFkPA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca6586c-5572-4d7d-0b6a-08de31bd22ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:09:13.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmJfk1e4If2JLIDDVxIV9vWo+BNm7jrjrs5lLOj6JFTOozj/++gBTFJr/pMidwt2bfFqqNPNHqxgD2ny/U3kYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058

On Tue, Dec 02, 2025 at 04:23:48PM +0900, Koichiro Den wrote:
> Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> or stopping controller and linking or unlinking functions as you want.
> In fact, re-linking and re-starting is not possible with the embedded
> design and leads to oopses.
>
> Allocate ntb_dev with devm and add a .remove callback to the pci driver
> that calls ntb_unregister_device(). This allows a fresh device to be
> created on the next .bind call.
>
> With these changes, the controller can now be stopped, a function
> unlinked, configfs settings updated, and the controller re-linked and
> restarted without rebooting the endpoint, as long as the underlying
> pci_epc_ops .stop() operation is non-destructive, and .start() can
> restore normal operations.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 51 ++++++++++++++-----
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 23f0afbfeb09..3059ed85a955 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>
> @@ -144,10 +144,16 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>
>  	struct delayed_work cmd_handler;
> +
> +	struct pci_bus *vpci_bus;
>  };
>
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> +{
> +	return (struct epf_ntb *)ntb->pdev->sysdata;
> +}
>
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>
> @@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	for (i = 1; i < ntb->db_count; i++) {
>  		if (ntb->epf_db[i]) {
>  			ntb->db |= 1 << (i - 1);
> -			ntb_db_event(&ntb->ntb, i);
> +			ntb_db_event(ntb->ntb, i);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -1114,6 +1120,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pr_err("create pci bus failed\n");
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>
>  	pci_bus_add_devices(vpci_bus);
>
> @@ -1158,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>
> -	dev = &ntb->ntb.dev;
> +	dev = &ntb->ntb->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1258,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
>  				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
> -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
>
>  	return ret;
>  }
> @@ -1345,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
>
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> +	if (!ndev->ntb)
> +		return -ENOMEM;
> +	ndev->ntb->pdev = pdev;
> +	ndev->ntb->topo = NTB_TOPO_NONE;
> +	ndev->ntb->ops = &vntb_epf_ops;
>
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1355,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
> @@ -1365,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  }
>
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> +
> +	if (!ndev || !ndev->ntb)
> +		return;
> +
> +	ntb_unregister_device(ndev->ntb);
> +	ndev->ntb = NULL;
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1376,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1458,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>  {
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(ntb->vpci_bus);
> +	pci_remove_root_bus(ntb->vpci_bus);
> +	pci_unlock_rescan_remove();
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>
>  // EPF driver probe
> --
> 2.48.1
>

