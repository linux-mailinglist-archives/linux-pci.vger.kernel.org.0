Return-Path: <linux-pci+bounces-24955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831FA74D37
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E03B861E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E219995B;
	Fri, 28 Mar 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbs97Mj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA817332C;
	Fri, 28 Mar 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173762; cv=fail; b=UPOXztOraXVzWoGEsK73s41QxB+0JnrA5pylgvc0thulahdUAt3IKQIpuix7jLBVb3zT4Iei+dNXFrMXKFmeDenSpc969epRq7D8cRHJEAxYR+H+Kb03vytbDjCKs2vfrKlg8WSfX2a39RA53lqhQ0ouBLUAlevuogvbU7O4Ykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173762; c=relaxed/simple;
	bh=rYxhjeZIQoTKcs2w42G+Rl7ALT8hpI0DX/aQH55IKqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NvW8EEQwnAuqisoqCGT+oJSqxWbWWK1ybc/7RE1GOB0hWNAK8knns5O2pA6vH2PbifriPZLuDIjqS4PROhu9liGtNLrYKr7pnuAJCpfRuq6TaMTSFBC8ULSWwhLfAQlN2x06YuSnJBAyTo1BuAkeUpkLreaYQznHakxw5Hr/Eek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbs97Mj7; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+HEIjGm6TrS6T1eVLkdEnvFfCFpRmbFg/Fe6Wcb9NiH9s15bASWD1XwvrERL9ndlG3LeirvTw6FmxER06/qoyS76NHpCFhkKvZS9l6ng1RrTqL8+W7QITem4Yytyuxc5bjX6TbvK325hOvEXWNOVA9Rw4aVSEZpLd6a3Z+QX7sA3TJ5lQyNGyDKF2GnjIPenEH/HjarMV2plJxRtnx89R2yJ8F8eYWgB1iKwV6b8QR/QWEpPkt6jTMPEvWY/OULo97dbys6CEDM8+8mEX0zumRKZpSO3Z+fqh/ON6srPgt4rz5jKxMy46lKBMBxLaShlgFUuvVwOxjKHJcFjDt4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODnzeH7WwsMQGNAptKXaf+yaa01DYTZg1o6foJWjoQY=;
 b=Rz+ns1/PgaWE8u/Rtsqj090yTfhrzNczpNDD7o/0RMhR4tVsnL2XynmP0rCaK4N3xuSUUdE13RaX2NR4ElDYPEQG1WCt01TC5wQMwvWKq790qa1Kyg2RVNCczPiy+i9fg841RCaEAEHeMO58IYwRdcTLIK7v5+xoG24jvbACupgnSkXEXYjPzztvUe33HIOkHmQuSvxesU5D5pRe26ZSI7vMvsd92MA32oGV0DiAL4xXTs8TxAfCzN410Kdq+o/Zhjceo56Wev3v+iDAAeSFimPkrKIEzpoZHsq4O3tpUohB7z3l+hGCW5maa/8qqxe1R1/shUZT2G1BuGiO68Bn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODnzeH7WwsMQGNAptKXaf+yaa01DYTZg1o6foJWjoQY=;
 b=hbs97Mj7+VcT7M0Lhm2DYfEkZOMHM65ZGb5fG66D3+P1FJ7k5YcqJWptODx07f1fIg/i4pYFMHqZ2uymE0LM0dnu2PBsZcJTKUnDk7mlZ0RbONSkFm6qi+9rZhq4lEioU+nYCcPsrvwHbFcBuTAPbE7Jnm2T41P6vuab8w4sVIOCN58ZMd7MfS4Tw4Ib8FzTJmFLohXf1bn/q9MZmQA3kYq7igY3U3V61lI4cY33O2ArXYCLSRncXDmkhVxwaZKxicpOw+pUlzzQA/NDmsKymwl9EjQYW/tiReM0WJ8AYrEIboVf1qEfuCRdJ/e1FlkCtgvpS3gYG0YcQNMCp4xsvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 28 Mar
 2025 14:55:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:55:56 +0000
Date: Fri, 28 Mar 2025 10:55:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
 Receiver Impedance ECN
Message-ID: <Z+a4datBLb2N360t@lizhi-Precision-Tower-5810>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328030213.1650990-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH1PEPF000132F8.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ced332f-c4a7-41e7-5f0f-08dd6e08a502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLwlSq/W6GBSmxflhoGCyCg6O/Vk6aEsP7FDg+F0rcaIuPvbFd/Cr5ArnEPZ?=
 =?us-ascii?Q?IRQDcHvKUqh9FkR9N8rt6SRgPHHbjQwpl8KG7cYKlFEvbCOXyiqzRMtfjxhM?=
 =?us-ascii?Q?bsPphH+ykn6DaSVqjUPsmChXrNaYZP0+OaZ1pg80mZN6BR0oTSNwnPruirtJ?=
 =?us-ascii?Q?t0s6sDsLGMpJKWAGVW8yUU3nd0BSIMrZSnTG0BO8/7sCR2lsRMge4xLP+TbA?=
 =?us-ascii?Q?egxyymNIBuZNwXB0cXThvc37G60CrSRsEmJ9qV7WZnXwCk7QUQnF+KCeahpJ?=
 =?us-ascii?Q?zALqhflC2WFl5FGEAU35Nq6/w5ERZpmRifyHXNY8w8sPBSAvBJEsN/XnKQRL?=
 =?us-ascii?Q?Sg4eTGJF9aeijdNjruATaqT4Yr+iztrwVav6NOw+7A6Fx5vqzgAIoNnY6G9o?=
 =?us-ascii?Q?wi9DPta/Wvv6CSxHrcgaqFEMhPiRTAVtYz9mq57LG3KRCCPr9OQ+mf4T2Wci?=
 =?us-ascii?Q?bRc9uO3jI5A4Ey4yefUD8jUVhHVPrq8aIhJVEDytinJQpOyDY+PB23duQFSs?=
 =?us-ascii?Q?JKIRj53Y0iFABw/yPVOwPV023Bv/4pTt5mcPmHY8OdglkkWREwue1Lh+m6Ow?=
 =?us-ascii?Q?bprPOE6+vIm5PxE9dme1NdTCid+XNGNhrnMAUYeSQxgbTnM3zmh81GAh8qQB?=
 =?us-ascii?Q?2oHjfW2P/4egnYZs0fozUwnv14ZV9GrVzh7ORix4+GHpXPJ605pyrhjKgfQI?=
 =?us-ascii?Q?f6YNPiItHZeSvsjo2cK6MNHEbV0cYQvXuE7SFU/lKBzKMcCq2lqKkzTKTF9s?=
 =?us-ascii?Q?GhjF+ZFkPF6VSPujSfZ2cXRKmuYsOrXuzZ5gs1qpApd4X3UU9mWR3b3L+RWE?=
 =?us-ascii?Q?9FEyRYVVUSEanp0BaVofCGxQUWIhYUlV5JMFxYaLOkOiwbSmNnYJcMfV63Qw?=
 =?us-ascii?Q?8sPCMEzu8z/PqFXfT3sVHPlOMUKdCg+WOMRr0KI1ODlAGB3WA6ZGbJ6cAp3U?=
 =?us-ascii?Q?Ya6cxtw6AbBHlLdTScOy5uLj9b/4D0zJI09bXN644KZ6I4ESJULhlqxngDzC?=
 =?us-ascii?Q?fdHjVT5KqlR9jvmh0X+kjtr8mrLLp+C4YtVXhyf5gP4RJxv7PmUvk5ARXdPr?=
 =?us-ascii?Q?ijQCBLx4ZXt3uEX5fvBRNm846rCtVD/jxvjgyEv2SCA/JtUiFPqKx+BcR0F8?=
 =?us-ascii?Q?FKIzow9hHGa13H3sL57IuQxdGV0mylaRvThGbfGYcDOgI/FhyYqpq8ublytE?=
 =?us-ascii?Q?K1E6Y0zq1ElMJik4qnox0vwEJFf/6PjeB1egmFfu/8fgH4pk1HFTrGHYu0Zg?=
 =?us-ascii?Q?fXb1tFFYHitUXAbEcqFwdAykOOF26iru8qs2f0SZoAXfFA+IAvqSfIl+sKZC?=
 =?us-ascii?Q?m6OZVG9MIuWgytSd+vBPA0ZpjiYasUXKD2IsWxbqj8GJjgkf5sYaDAnCd9rb?=
 =?us-ascii?Q?UG7YfM2xZCGfNZqAWPDmIjgHWJSdLSt7salvLZa8U6F68SwiONk3FK9V+w95?=
 =?us-ascii?Q?su1MzJm4MDElkbF+Ame8unjMtt4ql7mS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsb06vog8ThCeIxXvuIY1RouPVMFefuVXRJUlsl+m1h5G27zuBt5RGxZVcAt?=
 =?us-ascii?Q?XOMNJ89WhQeSk0vm3f+vzmwjozqRt6EMtbB5tL+trTV3WtDQyZBGyqOQmJn+?=
 =?us-ascii?Q?W9BW8Y9+LVc7hyw2NPNDSbzRsFAB1SmtKXPyE4/47YoJYQ5JFeAQ5E4cNWWm?=
 =?us-ascii?Q?gJGQQA2QZWr4nDHrIl+sqVNds1e56qI4mhZvCV1ijwZBFYLqBbYUqz6Ba9tu?=
 =?us-ascii?Q?oKV/cGFNVZb0G3YkfDdMi2WHjVSxywf0rlak3uHDMKypNVNIdn4wrSUsKUh7?=
 =?us-ascii?Q?QdbVioY5vGYQZE64huRPadNSMWyBXej4/fNgE1C4mN/2EXm0/t7Kf/OAoKCc?=
 =?us-ascii?Q?OsMBJ8G7Xq0Qzv55tL+qMXX8u/2hyBuASo9BHSgEl1Ebdla+qLV9MIr/5oNd?=
 =?us-ascii?Q?wIX4zkDxvbm7fKFbklyIaTMWuHGTIvFoOrNuO19+0URfyp3jW1d6As5ov7A/?=
 =?us-ascii?Q?YeRx5BJBtCfqMZtsvn7D+Jog+Xeyo3SE63dAGWYZ8kD26jTeA12ilZ+NCScx?=
 =?us-ascii?Q?umhRJIbO8mY065R0Lgu0mv1Vf6ah1zPDN1/nD1TadyLRjbHQI8IySdYETf3E?=
 =?us-ascii?Q?9dUoLMH0fAXHA64uK0UuRxZrdp1I74hHQ2khVMJh4DGjUp2zCmerw88gezzC?=
 =?us-ascii?Q?2xFcx1c0ogw5vpqyQo2SgcHiIZcKYysLQIFpnshS1b+d7n30HTF1N3k1x3H1?=
 =?us-ascii?Q?QpKAx9cZ3G63UAUBNx8RZkWL6HmxRXLyiv/bKmSn14wBdfMtR7yCa+CYzSIj?=
 =?us-ascii?Q?xSuMuorac8FD52+YLbkbJx5yP0WHeQp8Kdx/mbHhRS5YDrplmc5rpRog1MKa?=
 =?us-ascii?Q?LDHpJOhSaPZrlxz36jGP34WSNuckRrXBwRUN1CbxfsGYGSddmHVyiFzOrxwX?=
 =?us-ascii?Q?vNQcmfe3qxtA2Xiq6VTWHgfxuZTT4fSzhoqoolihNVs1V0Dd6QanLAxVxOtI?=
 =?us-ascii?Q?7tWoKujWgIgOHdj5VTHmruW1JBNVwmZlW7zGST8pdwoalWvaXS52Fr6uW6pS?=
 =?us-ascii?Q?70TtpR4QiUsJfkn1mCeSDQp2QEiZbM254ZXGo6+kLKZueYUJZFJ2R4HNwa4x?=
 =?us-ascii?Q?HaI85l+7lt54/2aqzH1wi3ANe0DVbFoCDm94dNQK1rLylBeoO1NMl3RGRzk9?=
 =?us-ascii?Q?3NnyvjULrWHF6SSweeWO8Bp5RopMmAC8milN1I/toCoimnxbaHE/vbcmmbkn?=
 =?us-ascii?Q?8owN9pvvCjrPVeXKkVxU9Wm6fHbFJ80ljClOQxjldAkN0LWui5eqVV4U/pSF?=
 =?us-ascii?Q?8mNqtyEuPx/4DME+ArcIkYQbH6zXtTX5DJ4Drsl4SxoE6z5EJaF8glcZICT4?=
 =?us-ascii?Q?Y98Owkiore+33nah4777VZAGM9NBWX/bAed0860iFGveKTzogWi8Unm6RC6A?=
 =?us-ascii?Q?dTTL8sXKeB9MuUUdeejh/OpgPpvdm/WJHc1DNvYULzN78KLRx2aFN7o7Dj43?=
 =?us-ascii?Q?DWcva3S6haVwP6dEUJoFKqzUMllk858SPrdc1+ggjn3bCVlcofDLQNWI4XK/?=
 =?us-ascii?Q?hXdlYTVWMUTbOQe2b6EyrZFduXJb08VM7OO6r8dDHYMP/szpln/Q5pGw0jLl?=
 =?us-ascii?Q?ayJcO1LNr+m9yS9PrE7tvSSlbL4G8bl8/IKsHuHq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ced332f-c4a7-41e7-5f0f-08dd6e08a502
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:55:56.5291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SXOAUCsQxl8jjFxFBqjl2pkF1Bf2IxvWDlo9FG0Pwy6eRNhiWXWXEqyVrOqtXQhYH3eyH6Ox4M4tZr2WfPDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

On Fri, Mar 28, 2025 at 11:02:11AM +0800, Richard Zhu wrote:
> ERR051586: Compliance with 8GT/s Receiver Impedance ECN.
>
> The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
> makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
> operating at 8 GT/s or higher. It causes unnecessary timeout in L1.
>
> Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 82402e52eff2..35194b543551 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -110,6 +110,7 @@ enum imx_pcie_variants {
>   */
>  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
> +#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -1263,6 +1264,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>
> +static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +	u32 val;
> +
> +	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
> +		/*
> +		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
> +		 *
> +		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * is 1 which makes receiver non-compliant with the ZRX-DC
> +		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
> +		 * It causes unnecessary timeout in L1.
> +		 *
> +		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * to 0.
> +		 */
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> @@ -1304,6 +1331,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.post_init = imx_pcie_host_post_init,
>  };
>
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1403,6 +1431,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct device *dev = pci->dev;
>
>  	imx_pcie_host_init(pp);
> +	imx_pcie_host_post_init(pp);
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>
> @@ -1812,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX95,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
>  			 IMX_PCIE_FLAG_HAS_LUT |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> @@ -1865,6 +1895,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX95_EP] = {
>  		.variant = IMX95_EP,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORT_64BIT,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> --
> 2.37.1
>

