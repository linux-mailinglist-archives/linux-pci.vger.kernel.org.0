Return-Path: <linux-pci+bounces-36802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C429B975C6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BC72E66A4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AA213E9F;
	Tue, 23 Sep 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mEafU3s+"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA038C2FB;
	Tue, 23 Sep 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656133; cv=fail; b=Jy8RQyPlaWJ68vIUYizpM5BDI86IPsuXL9//4I2mqAwJKpOmAP7dEcOcE9Bh8wVH5Jm5TTdp43scEBqAbypDYFJ7srqzuyC1nDOVf8au0gLW6H2K6wj5hktINbi9Hb48MpgGA7QfcTumcHJa9jQtgVoeXo1gOyexxmz7uBr70Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656133; c=relaxed/simple;
	bh=VfnhY9HOMExcmzN6ibjvK9zl+RMN3rNLYOAflldgDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V+8gRMNoGN7ytzy7TkgsmNcR9azL9v0dJy3FS8dn6IPO+NbumQ0d2J8/YMTw2iLJ37DdUPzk2iNyC7IE8l484j6bSk0HWnLpoUxvqpbtYxOPwizh8FbYH3/3w8t5jYSSdATdj3fOaUh5t+Zmy7oyc8ne6h6KddJIBaBjwLPbhPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mEafU3s+; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMNd0gzVC0pf2MHqpMRUvqosNRzBDqIEKJwnKW9DC6sT8g3qwpx4V0CbzKYN3R1nXgjVE0vFfCUR1NSy0T9B2mcgSFcY3Owb1v9B2lupGR3wFOdjkLyAGlEr4WfgICpds3scnU0iUQttCEB2zLBc4bi8NEnsaXfhFO+EUwKYNlsLhpOitDIC7szZMAj3nFl2gpn0REL0EwYGnuUooO4ERsvQvvATsf8ZDSXu267fVQvh4qD7hdPXYE7qGwYYlpwZ7Br3hf7t1ATalt2Z1gFC/6DCqT5TwS7PTvworc7JHnE2ANGNMOvHpBXTYSbWmQdfViHZkN3l5rDCHakGuJJQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9U5Zw1xv5JgRHot6C1hu5aXHRRuEsxWBc72kGiWjM0=;
 b=Ig8TrW3wQfG4Td8R82uH+XwXwai4rYcqwxLjwGBYMfw1PGQA7ZuCWkuv4oJCXLuex6YxPaa+FDz2B+UM/fieCi+NbV50SMsk3occ3bbcvNtk0Q/0tjWOUhePTL3c3sUb8acVmzmrGeaS9Wd9tKKjlFzZyq1gqNEz+8xocht3onAFyjQX7zCppJbLZE/zf+NMlEli4nXUcIj40OPTgcIt/2mypU4qM9Wv+k6Q2wQLFG9SJkml4pykD1/gXuj1iuyr/Sh0yDcOgAwVlmLsyAQqFHDQ8COgIKoMmBYLVO8Nr5whGoR1mbZHX3Xd2G9kzKU2/Iqa1RvudbGbULSHOxcm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9U5Zw1xv5JgRHot6C1hu5aXHRRuEsxWBc72kGiWjM0=;
 b=mEafU3s+lCn9xaM6WYP3Rd8vyVUH+qw+EeXzSW9ouoCH2Mf3oRCchJPQlashoK1dUU38CJ/+I6Tc/2IjCIwP05TVO1fSgbc4apJWuHJrYJz1hMInlZBV3yT91HJ1ZXyWIVScg+l+K6M8SmLMHyHjzqDFGsQc1XB9KtUW+fz2DhV/0+JMRoaDuYGeJlCmb/MQ/5/fIkfJNE+Fnrh/zlk3bCpESU+A258G5yl0pvpooEQ4uhLmF7tVZa1+f25FiscmKssz1LofrOE65fP1DR2XSrfZ/wAdn8nUbyQlQUP1NRnpnmXQsqyhkwNNOHjOmAF0drK91UsjqY51kfCyerz6PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 23 Sep
 2025 19:35:29 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:35:29 +0000
Date: Tue, 23 Sep 2025 15:35:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: EIC7700: Add Eswin PCIe host
 controller
Message-ID: <aNL2dnv6doUGenHh@lizhi-Precision-Tower-5810>
References: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
 <20250923121200.1235-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923121200.1235-1-zhangsenchuan@eswincomputing.com>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM7PR04MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: f720ad2c-21fb-442c-234f-08ddfad85a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzJulTmIp8s0rcIJFp8xi30rD/Tdn4ri7WvTG0byy30uhmuDAZqut89i52Zv?=
 =?us-ascii?Q?2nijeACuAqSXVhIJ8VXWmwTBDJv1JuKxbvzVzE4STU0q45VpGbrf78QbtVCJ?=
 =?us-ascii?Q?VrNSZkvQRK6360VcpZIPJGNZP5Td/2mmiB8az4onjMCCVaZHHKWsiKnAVoF6?=
 =?us-ascii?Q?5aLW3NLGQsBaY5heqbprEQ2xr+snbw1fEajyiu20NzuKM9/aHPKwRmNeQUNn?=
 =?us-ascii?Q?30pKaeorRfwyLDXOALmfcM1dhawm1bsipLcaN4IW4zdM8KpfcmeVpjvgWvB8?=
 =?us-ascii?Q?fRvLDm1IPw3kDViwUuyr7UmIq3op6xIP38r3u0sCwntaeHbDar/EqyOPc2OK?=
 =?us-ascii?Q?dH7wozepdFkDflhYRzXvlA2F82MCuzF03MBMIt4IDVtEGuNJkxMTEp8RNAYc?=
 =?us-ascii?Q?FS+lbvNY5IaotIXdxETTfHwFc5Dk0083Zw2Xrg6E/nMhlVFsjTAhM3/OcWi0?=
 =?us-ascii?Q?tEFTVJ8Zk3Wyiw5iMv2pUOfR08Qj6FHvUoXnzvVLLFmvCCIeAs3nrxxQprP+?=
 =?us-ascii?Q?qQUobaq0VWGC1m+Xoc6z1/tY/aHXm8Q2aPj7y59/EJlreC5noRDDYHZcQ+HG?=
 =?us-ascii?Q?zHIJMuPZBx0bXFtoy/wjyr7QO+ji4s9eAuj423PSIxA9HAKcQ/k740Ijmsc/?=
 =?us-ascii?Q?ZAxqC6Pl4pLnpQfVlFP7HIfU2yRwKEOFTOfFQ/HzPK2iwbf/qQpga/DJydvE?=
 =?us-ascii?Q?q5Slx5+uuBew3FuUsFGaKvJMt2k0UzEY6uOr9r1H6MNvslCZ7dpSpLinD/Ce?=
 =?us-ascii?Q?CSf5ugSOYYY99G7Q6mvObEl9eCtycxgU78SgdrE+RzJoMs/IjibhO8EH8z44?=
 =?us-ascii?Q?Czr9UpwZzHBY7SYDhyjdg2scR12h8FhdrRRQ4/jZ/NitXMHMnnLUeQM03+fL?=
 =?us-ascii?Q?Npdf/iQYKtoMfrZC19vLcOeaaECidb6bh9Lpvh/Mb/rP0oZviO0d0GHTJX3t?=
 =?us-ascii?Q?sAGBuM6Xhtf7ZSzeShwJY2s0NBuZ8fJWjpk/FbdCV7jyuU5pd7s6mq4HjY1e?=
 =?us-ascii?Q?IRDokg+EqoI174Afxoub34IUsaEfwvUOBNZ/VcIx+18CeExmON2VedBOxdVg?=
 =?us-ascii?Q?n7eDGAAAIcMCRw+43DOaA/HbVXdwVUwDwS9ijDoN4LJW01Stti0QttXrVCxg?=
 =?us-ascii?Q?azfu8D5OL6cPW6uabfKawnUbULylNC5hWS/v1RkFiiMFblFdk1VNKFBMtvLA?=
 =?us-ascii?Q?PwXNCCh+QAs718q2WRBtxcL/76MbfcaAlxkkbHIxVRZaMdezwl8D+sO2lu5o?=
 =?us-ascii?Q?cvkLrpDglaFIrD2AB8dYebDJICXxYfbGQ0l4vOy8j9ifDS+7TJtvBB0csqfE?=
 =?us-ascii?Q?EYxz+r9BjST2y1axMjOJ5SCKisdlINLGSDejc+FWxeriLyR/fen3de+cCjfN?=
 =?us-ascii?Q?y6FidUaunxt+Ayj4/ekzw0O/FgHTiu7+hYjZH5NKUN91kIvS252pq5No6K3F?=
 =?us-ascii?Q?jK+TCFunPps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nSCRMdgof8eBLUsvgXFTA3jewwtWewgfRy/b/Lbilixis4L7ccA6Rav6Csio?=
 =?us-ascii?Q?ZitOGXNVSgUxv5VPTNRjvVqD40rAbt9lF66RIecoc7zIytx3XqHMIgSuB3LS?=
 =?us-ascii?Q?k8p4uogoK359sJsJSETCzB45O1Fr5G+qqcFUr3TSEQHrfiWB+CYYVfbYWHqY?=
 =?us-ascii?Q?Gh4R5iSMWJdWqusD4+9DxKYLCMzgjxtt10gixwAHFcXcYS8bJCkXNWXYUt9z?=
 =?us-ascii?Q?KSfUykbD4iu5nQstAWCE/9c/RrX0Oqj/GlmQ+2SpP2jKXkp/qO0QuIrbYpyI?=
 =?us-ascii?Q?mNwAgjXMyYvNT2oZjCNCLbiJZPcR8C/IZ3fPGkqT6znR3jjuv5aVSV9VJ9T+?=
 =?us-ascii?Q?lmr8G7Qb8V0BqXxVCwWS+RAFTsNDGgVDCpUZcdcbOhur+fjTvp4jqydAyWgc?=
 =?us-ascii?Q?EdBdhwmUJDwh0tpjBpe9CI6Dk4H+V3ScKup2mi5uMT9I2dYbZlkpJswQ27U0?=
 =?us-ascii?Q?tGES48XR/6i4JqMR/GUAZe7xATK3Lg77IUl+m9SFwXxlprv2lKCJ6HWC2Et4?=
 =?us-ascii?Q?cIiNnujiTz/haJS9LsH83gfGbIayrK2B2p389sg0erZCSsJWee4QhUkPxyZP?=
 =?us-ascii?Q?caj3wxbBIBbnFewlPMze5WSaHPWTyI4IiCImA7jh1WfJcFQZ2p6G4oVXuxRK?=
 =?us-ascii?Q?XkyjnPD181aekvpZdrKevEYKT3npLT8Jr+pkVQ+LCIPq5OuJ9hc7QmBy5fb4?=
 =?us-ascii?Q?mgWbFr2v6NZ8+a7wF9Fbt4nozNkLQAjihvgZVHw5xSohmp1zS9G86yTCuW2M?=
 =?us-ascii?Q?CPpUKjXy+WPZcl5dDlJwo3HjSdqbIIOlGHQ9k9kz+O3JTsTEtRpkYXb+/8pL?=
 =?us-ascii?Q?FbTu5pdaiDBIlxBDOEzQ/uZ5UiV1HFE9Bt5CuqMD/9DoLpG/lbHKlF7Eb6AU?=
 =?us-ascii?Q?uozEnCW89+hAOFZSVmSGLuti1JV0YTWtA1q7NXEUXG7zsPEzu4TILtSshWOc?=
 =?us-ascii?Q?XmdmP+h8lJUe5Vqdrz2fYqKH37+KNtEWDXUcs4FyiSJHUtNkpMZn9cc2QChy?=
 =?us-ascii?Q?/STtv6N+hds+4I0HwH+1J+BDxVlDGl1NZ/1W6kcZfHLTMTafF0a+uo8EREcG?=
 =?us-ascii?Q?ohTEjKHn/q7/aqPo91wWYVvQfQSa8BwCfmK3/LZp/HW51KjPMaVco87s73Gd?=
 =?us-ascii?Q?B6b+l0FA/V5+mo3F5+Rr74odjf5xQYC4udDafkZoYeXGr+Dy1xO9GtRIpTBp?=
 =?us-ascii?Q?bdYcA4ZoJPlV8jHwX/GdZwdd+xOTCWKrMjHXTX7vKdrGC+aLjbX8W3n2BDIR?=
 =?us-ascii?Q?9rQgd4t4VrS+2icfTwxi5geIZNSuXA50PFiwqtxN4lwnX8o4cI2ylwP8HpHR?=
 =?us-ascii?Q?QlT9AmEc+BZVdhxJF6Fx+zRKiQ3gacaaeKZpE3h9Rimtw7P9J32rjlFpryU0?=
 =?us-ascii?Q?c7dRRSqtCS7RxWjh189IKxESQzHVck41+Lt3McdzQxpE4iXtTo2BfHroXhN1?=
 =?us-ascii?Q?eJ6jvQXxkUgkAcDUy+PICGenssZzqyR9BRsNkZ1Kcc29XXczHXgRZRT3vLGA?=
 =?us-ascii?Q?kXhokaofOP8Xb9Mk/Z8qlAIXpBFbjiXYjVl9qMrLdbxm3Jjeh7QWAgD3tlBB?=
 =?us-ascii?Q?EhotGwfSb+8egHLvZqlvGD9e3el/cZYDRW1+bLdU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f720ad2c-21fb-442c-234f-08ddfad85a20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:35:28.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSha3OZ5wCXYzMPQS+teVzAuy9WWURpf44ygbebwxP2bLnN7JR7orDjUPDg5tv4GhQ/kft09t73L7USwqEECcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823

On Tue, Sep 23, 2025 at 08:12:00PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>
> Add Device Tree binding documentation for the Eswin EIC7700 PCIe
> controller module, the PCIe controller enables the core to correctly
> initialize and manage the PCIe bus and connected devices.
>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> new file mode 100644
> index 000000000000..2f105d09e38e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 PCIe host controller
> +
> +maintainers:
> +  - Yu Ning <ningyu@eswincomputing.com>
> +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> +  - Yanghui Ou <ouyanghui@eswincomputing.com>
> +
> +description:
> +  The PCIe controller on EIC7700 SoC.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#

suggest move it after required, incase add if-else in future.

Frank

> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-pcie
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt
> +
> +  ranges:
> +    maxItems: 3
> +
> +  num-lanes:
> +    maximum: 4
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 9
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta # Assert_INTA
> +      - const: intb # Assert_INTB
> +      - const: intc # Assert_INTC
> +      - const: intd # Assert_INTD
> +      - const: inte # Desassert_INTA
> +      - const: intf # Desassert_INTB
> +      - const: intg # Desassert_INTC
> +      - const: inth # Desassert_INTD
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: mstr
> +      - const: dbi
> +      - const: pclk
> +      - const: aux
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: cfg
> +      - const: powerup
> +
> +patternProperties:
> +  "^pcie@":
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +      reset-names:
> +        items:
> +          - const: perst
> +
> +    required:
> +      - reg
> +      - ranges
> +      - resets
> +      - reset-names
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@54000000 {
> +            compatible = "eswin,eic7700-pcie";
> +            reg = <0x0 0x54000000 0x0 0x4000000>,
> +                  <0x0 0x40000000 0x0 0x800000>,
> +                  <0x0 0x50000000 0x0 0x100000>;
> +            reg-names = "dbi", "config", "mgmt";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                     <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x00 0xff>;
> +            clocks = <&clock 203>,
> +                     <&clock 204>,
> +                     <&clock 205>,
> +                     <&clock 206>;
> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 97>,
> +                     <&reset 98>;
> +            reset-names = "cfg", "powerup";
> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
> +                              "inte", "intf", "intg", "inth";
> +            interrupt-parent = <&plic>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                            <0x0 0x0 0x0 0x2 &plic 180>,
> +                            <0x0 0x0 0x0 0x3 &plic 181>,
> +                            <0x0 0x0 0x0 0x4 &plic 182>;
> +            device_type = "pci";
> +            pcie@0 {
> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                device_type = "pci";
> +                num-lanes = <4>;
> +                resets = <&reset 99>;
> +                reset-names = "perst";
> +            };
> +        };
> +    };
> --
> 2.25.1
>

