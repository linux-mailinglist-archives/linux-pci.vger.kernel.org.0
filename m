Return-Path: <linux-pci+bounces-31086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D2AEE1FA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812813B0EA6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4C28D822;
	Mon, 30 Jun 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmMlaD7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012014.outbound.protection.outlook.com [52.101.71.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1ED28DB5D;
	Mon, 30 Jun 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296143; cv=fail; b=NbajS54QZYOfq9YzEd4jphkmdEzv1xAMDIdaS2hYGRMBWouZsGzlbiF4P7K/uBRXne12IvOuYOfzWlDx8/Xz/BxXM8RMSLbKMNLixVQ3nKnlGrRGNX7wg2eLPdVIzHNojnMDfWyzGBEofwZh9kZxRFtGbj5Mq1K8xKPzAE9DI3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296143; c=relaxed/simple;
	bh=67uDl+9X+ALV8xFqansQ2pfOecWITiCs4xWXfTFDSXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n0kOdJk+hmQKSihoNm+psXxYdP7ajBcZTKBO3cAJN0ufAJ/ck2MaHNv+lm681hBBr+xaLzHQ2MpLo75K4PAUEAYn7UX+QgcTY3zjq9wXhveUkFeycFYVPCpqMquS2vpIuWj0SKZP+tT0PaSSfHVUsXMWGxcUT/abgc1DcB+B1a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmMlaD7L; arc=fail smtp.client-ip=52.101.71.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOBcbCajNDwVj4EEUL8huBAQCDGdpP9+BS2AiSU10O3kXFe7oH8IWppgaF/r8rKsP5rT/5R31fFt5dpge4SPihffzcQ6F6Yz7J66WRqOlf4Vqj8cwZFXlkwEp6haQssRbJvBgFaOFssg0Gjm5ll7tyykeebLhXIW0DYZ5kbiKUJrXlDGv65AfaMDks3Azcgu2V2KcFrh/5L2GklBdQKRp2wWSQ2bF1VQXxqGa6RWmdmYjgliFavo+Z+4HKdIOTwo2Xe8Y7zOPoiOSbJczxXiI8AHc1QSMjqd0J9bItXWEoEKtHOivbVrnw6nayeA5Ny3IxKawhzLgdT/f4gjVwUMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrlJzNPkETLfDU4xaBsTzDX7WOoqp0fHbpvwLjjjHPc=;
 b=VvGLxinefQHygcNhys7Kz2uO0ApR9N1Jq55NSSS5Q5s+NhhVonwgge8S+1q9lSwNErZeYHNJRedSTY3EU5rAqOIjScwtKUYkVap/dDzIInA2SGoLuJxFwAQx/rt0SriGl9NCSRXA+jW3Nunb1DARo19UCWVZX1zQT5EQKCpnBOxmzH2hC1uJFUKeo3jBqcNsl7fysGWakZ8cF5umPrj2oA4CRvVtQA0ROeaoqw5BE3npSmp83ylsmmCR86proMp3+QNczCEdaEaoOGiOtRM3yLJdPUVLcfB4dYccyvs8OaIzYXn3Sx31AqXLDDqp6hC8BBDu9s/zUzH3n7/neWeLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrlJzNPkETLfDU4xaBsTzDX7WOoqp0fHbpvwLjjjHPc=;
 b=UmMlaD7LWRy20xE709irnQT7nPsoJxk4Up4A6O09uazYcXRHrwGywIhBc6fP5uhVUc0AUF0fthOrz1Lbrbo2am97kEk5w/0WfTsKZcmn8EyPyPnQG7VbuMtzQZve0ApEetxpfSJGvx/7QtjZ9BReIKrc2RbhS0N+LgHOZmr6oTroSaq70iIHTOSD5bg3G4POkUFbzt6i8NJ2wSI6UmtdT1byV6CpUqcGzA6AfLFVLY5cR9NyxNTgihkdHnI2jgkj85V8aw6Z8x8t14UW+TTVxUPS4RLiKy/hOhADvpl2WBFE2sUZKhs8AkP6E34Kzd2aH/yJmRCF30zc/ZVqftKXoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8392.eurprd04.prod.outlook.com (2603:10a6:102:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 15:08:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:08:57 +0000
Date: Mon, 30 Jun 2025 11:08:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <aGKm41I/FsrWN8jN@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
 <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
 <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>
 <20250628-vigorous-benevolent-crayfish-bcbae5@krzk-bin>
 <aGALNS0yyBR27tz4@lizhi-Precision-Tower-5810>
 <98b00dd1-3b83-4beb-ad06-f3e0442df8c7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b00dd1-3b83-4beb-ad06-f3e0442df8c7@kernel.org>
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f5d9d0-7a9a-4278-d66f-08ddb7e80943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oeb8VrG8GaRKTD+1AJiXivM55+8y7hC+wIRw3hQDDhltjjf9fjzdChCHPjMn?=
 =?us-ascii?Q?S+jTqjYTkb0rsr2OhNFN/D14PK1jgpqEhzXEwQOjEgfuDFgC9V2z0Pat4Pju?=
 =?us-ascii?Q?teLJRlqLvWLGfhip3wJjPOJ8mm4kBCJ2Ej0MEgFJLlXmBr0lHgmbO1UC0GCM?=
 =?us-ascii?Q?Mkl6gEE2Kt5/lHbVq5GEyo2DVn5GXLV12KQD5IwYr4CrvKPyIRjBTEYUC9As?=
 =?us-ascii?Q?7JThxXfB7bMuulC61C/PNVH9/gBRC/YuLzRxN9EuJFXf/EkBik88M1OCKkyG?=
 =?us-ascii?Q?4xcmlkXw+RMaTHQl9sgYSZfEkYSNt9ycrMIVplfDnSbkAS9/wyR5XDjSiwp7?=
 =?us-ascii?Q?AAtQ7ItQyWpVffzEYgK+LbaFb+C98PiF8xM2bvWGRPznBXlmSzb5RkXFFcFT?=
 =?us-ascii?Q?oQE6o5G0gtcJ5Em9qJxR8pqzcZVxETjMZiB2wmhg0FLGP4ghr+PRLd6to0cW?=
 =?us-ascii?Q?psvPpNdV982q6uGnJW0H7NhdxTegiH1dgQ/YTbxM2t1gzOZ9sGMot16W1L3g?=
 =?us-ascii?Q?lb07ebgUddUgRNrRYADsPpYzc5c0i1Ddd5RpOAFekhCw1LeM7tzYEt+RaCVa?=
 =?us-ascii?Q?zc0g0paDNtf07l/c2GCE2ejJN00RRZNFXRRvoP9Hs/Ff6MxApy3PdQCaet7h?=
 =?us-ascii?Q?B6FQmXHcnkW4cUVcSgfWzTNIV28WLGOZXimzEfXeshxsDjj5VDx+Jab+6qPY?=
 =?us-ascii?Q?/iRX/3MQM5Xn8Pf8e6ow6liQGly7iViytWd0QCCfkcq9BNImEEuiwvKiRYvl?=
 =?us-ascii?Q?EPe/O9eAeCSTZ6lCGXk4EC44nL5hLIEqJ6d2y8itdYgIIVkVjkdFIlRSmacN?=
 =?us-ascii?Q?KbXRWX+QWzs6vHPVYCl67/aIiWalP7lkbToC3ekZ6Iu1A2DcE1haGtof8sfJ?=
 =?us-ascii?Q?XCGp0WFGf5gl1eJqDDh/m8VerVsmXOQqKLon3POCOg0UTMDxeEN0qrsvO6nC?=
 =?us-ascii?Q?VXvbU/7CO2lsNMtggE2MptH2ktj9UwIsR/A0C8UZLlKN3lUlLTEboKIeIXcZ?=
 =?us-ascii?Q?X1hQnAwsfLomoqc8NRTEo+x5pquPq9bnb1yBhpNtQvHcP67oN8LDP9PtE9PP?=
 =?us-ascii?Q?rgfqhYtjLRZ12T6PrlH521i7F8BmKGK9/ic65IkfZo9Z+I26+JOY7iGtUGBh?=
 =?us-ascii?Q?nN6j4DzTkEoHEzBPG1mCCIzaYdpc+4uRk+g19/x8uHRrl+j/4ZAQusevF3Jy?=
 =?us-ascii?Q?hlHwulfCBmS2DVXipWYONYUCTZNerCIl3OBcBrGIKZUHZr+pvu9DvZ/jGa3e?=
 =?us-ascii?Q?tksN3oCI19e09XaaQp5HIN/51JYItBiHJbR0OapB2o+MFurt74DN1ocA6Cj9?=
 =?us-ascii?Q?3AAw9uDNlIv2npLMsBNYN/c/rPK3as6NdetdRauynVVU6J0DJ5j/X9Rt1Mpq?=
 =?us-ascii?Q?YCbJuXPG9i9+q+//SbZr2lKs8zBMVf9ksl8sA8IigeW/uTg7uI8pNpJc7n5D?=
 =?us-ascii?Q?L/nmvd/FMr23zKCqn1gDWh9cy9kBOISQB6jkjVhH8xXKhLC+AxM1ivtMKNuM?=
 =?us-ascii?Q?soKi1WY4qQYk2No=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1E7t4Bx47zpBdr02QB3wC1+mDuvldu1ObastdR5ao5szcmuclAoNtGyoMx8?=
 =?us-ascii?Q?+mt6tJbiYPDnSe/x7JU/eSuS11pZw88Ycij9HSC77S7lrY0YSlzs2lJFEb1n?=
 =?us-ascii?Q?8djdI7SCCOMk/0zyupFcgh9UrnAC1qt+ZgAQOnDYCPQRwEFvtku8QOHXxh3A?=
 =?us-ascii?Q?a8rB8FZjdNGoayMXAuMUw4KTS1YgVINf1J9WPI4PdESnk4i2AES7qOCmvibT?=
 =?us-ascii?Q?JNOMrnwnmYHQFk8wmU7VW56o2ORqFdd9xxMCRgVgMKuQTzk9fggq4WI84ahS?=
 =?us-ascii?Q?wK2D+RtVxdwzloQXz+eeKzTR1qypETe2ENlz/utZQUIscgl0TrKkW63ruF35?=
 =?us-ascii?Q?kYu9xu1aSdnIPHJTpag7p9PnVmmpqfDSPx36HB0U7fIABfxGddrurA6cRKZn?=
 =?us-ascii?Q?wpSVj2DNaNy6qaZdPgGW4fCWDRVjdjYjOaZhmRC9GY2cnOtZW6IHZGzA4U+0?=
 =?us-ascii?Q?UUGH1gbaW3mPHgd+9N+/SPr6bLWuyxracagZMg30SBLOFinzk94uC9anUozb?=
 =?us-ascii?Q?zPuQJN5XqSFKvkAO0qBmTW6Ygi1FNRvLuro6zCmS2mt1mp2g5fsZJpMrJNbL?=
 =?us-ascii?Q?qYRyPkYj6/SL8JZWiZF1JMqlAAcqXTBjwaOEnf+c/cAaU1QHFRuOgdaxVFg0?=
 =?us-ascii?Q?7CSFm2AKNGZutS3IvGhk8xquGmCREQudjEXEgqp0r1A6ftGYnAKLEToh7NBu?=
 =?us-ascii?Q?Etwd1pLO5600UpmoP5Wgf4TszE6bzz7OSXHQUCdUiiiVWewfwXygZzkC9ahe?=
 =?us-ascii?Q?BjWmZG8oZbMb4fJ6sFc2eIB6i7wYG9Wg+uS1gfOpItatNRQySXewgLgoI3Ur?=
 =?us-ascii?Q?1OGkqRWih6fLqdAUztmcylqhagrYrCKuMfLzOWT/xUr483g/IKN09qy41w3x?=
 =?us-ascii?Q?wr34PT+oVNvPqspfs/Ad7sPqqSupQ4nAGNROKIB62pDlLjzJGNtw3u61zU/j?=
 =?us-ascii?Q?W6Wv/6/ftzXKdzNbFJDR7/ykNmcTn93teK4v1TP44cc8INDG4t1IH4dCOiSA?=
 =?us-ascii?Q?63j8pwyuTRp1HkQp6oMkOQKuq3PFcAsnHJM4dNaPtyAiSrscZFrUan3OhwsX?=
 =?us-ascii?Q?lLNSwKIg/47997iJzHyqi+6V321oAeO1WGGfScJBs7BgY/ygfeDc0WQ6nBhz?=
 =?us-ascii?Q?qMqK+PEv1vL4FCZSKt9LC2tDoKtjefl03y7ogQhdwOFHYft5HdTYwYpj613j?=
 =?us-ascii?Q?H9YDsOzvu5PLM+gfMQ6wAwLP+a0okscK8x1ewDBG3U7YPtBkwrWNVaJasE51?=
 =?us-ascii?Q?a+r8VaHjU/TNC2Ms3bSGqSSxNLoNUif8ef43JHzsO01UMj68oUl0Rnnq4m0x?=
 =?us-ascii?Q?/jyzD2y0I1ImjSF7ZFP8cV2WV14yv17kx8ejbbRTlftz+J+J99CoI5f/TdBY?=
 =?us-ascii?Q?gvEaqkLa3HPq9xyGCTCOe7Wnu2vAoFJzKq/iqoOJDBjlZqgKeJ6GIw3IiOQe?=
 =?us-ascii?Q?vLoT9LjBo2qDbGQL4zx4z7NiYluY9vXurgKrA8UQ+sexWO4hf7cdjZQd09ly?=
 =?us-ascii?Q?Jzgtcyni6YMHL2Z4opu/g+R/Wo0MX11v9A5sVDC/p6DxIyUMUkyMhcYrlT6Z?=
 =?us-ascii?Q?xFscGkO67U15JIX2FVc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f5d9d0-7a9a-4278-d66f-08ddb7e80943
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:08:57.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs23o7lSiCNu661y/zjGDHa4Y75h5amlKTQkakL3VeawXBRdJoPkRXS0TSlRqVj5/eL0+V+DVBmayHFC4/IRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8392

On Mon, Jun 30, 2025 at 10:25:43AM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2025 17:33, Frank Li wrote:
> > On Sat, Jun 28, 2025 at 02:34:12PM +0200, Krzysztof Kozlowski wrote:
> >> On Fri, Jun 27, 2025 at 04:09:49PM -0400, Frank Li wrote:
> >>> On Fri, Jun 27, 2025 at 08:54:46AM +0200, Krzysztof Kozlowski wrote:
> >>>> On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> >>>>> Add one more reference clock "extref" to be onhalf the reference clock
> >>>>> that comes from external crystal oscillator.
> >>>>>
> >>>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
> >>>>>  1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> >>>>> index 34594972d8db..ee09e0d3bbab 100644
> >>>>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> >>>>> @@ -105,6 +105,12 @@ properties:
> >>>>>              define it with this name (for instance pipe, core and aux can
> >>>>>              be connected to a single source of the periodic signal).
> >>>>>            const: ref
> >>>>> +        - description:
> >>>>> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> >>>>> +            inputs, one from internal PLL, the other from off chip crystal
> >>>>> +            oscillator. Use extref clock name to be onhalf of the reference
> >>>>> +            clock comes form external crystal oscillator.
> >>>>
> >>>> How internal PLL can be represented as 'ref' clock? Internal means it is
> >>>> not outside, so impossible to represent.
> >>>
> >>> Internal means in side SoC, but outside PCIe controller.
> >>
> >> So external... It does not matter for PCIe controller whether clock is
> >> coming from SoC or from some crystal.  It is still input pin. Same input
> >> pin.
> >
> > It is NOT the same pin. It is TWO pins, there are mux inside in PCI
> > controller.
> >
> > There are similar cases in s32 rtc, there are 4 input source[0,1,2,3]
> > https://lore.kernel.org/imx/20241127144322.GA3454134-robh@kernel.org/
> > Only one provide.
> >
> >>
> >>>
> >>>>
> >>>> Where is the DTS so we can look at big picture?
> >>>
> >>> imx94 pci's upstream is still on going, which quite similar with imx95.
> >>> Just board design choose external crystal.
> >>>
> >>> pcie_ref_clk: clock-pcie-ref {
> >>>                 compatible = "gpio-gate-clock";
> >>>                 clocks = <&xtal25m>;
> >>>                 #clock-cells = <0>;
> >>>                 enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
> >>> };
> >>>
> >>> &pcie0 {
> >>>         pinctrl-0 = <&pinctrl_pcie0>;
> >>>         pinctrl-names = "default";
> >>>         clocks = <&scmi_clk IMX94_CLK_HSIO>,
> >>>                  <&scmi_clk IMX94_CLK_HSIOPLL>,
> >>>                  <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> >>>                  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
> >>>                  <&pcie_ref_clk>;
> >>>         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ext-ref";
> >>
> >> So this is totally faked hardware property.
> >>
> >> No, it is the same clock signal, not different. You write bindings from
> >> this device point of view, not for your board.
> >
> > No the same clock signal. There are two sources, "ext-ref" or "ref".
> > PCI controller need know which one provide clocks.
>
> OK, this should be clearly expressed not some vague play of the words
> what is internal and external...

Does bjorn's suggest description is clear enough?

  "Some dwc wrappers (like i.MX95 PCIes) have two reference clock
  inputs, one from an internal PLL, the other from an off-chip crystal
  oscillator. If present, 'extref' refers to a reference clock from
  an external oscillator."

Frank
>
> >
> > There are mux inside PCI controller, DT need provide information which on
> > provide.
> >
> > Maybe my example dts miss-lead you. Altherate descript is
> >   clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref", "ext-ref";
> >
> >   But we thinks if ext-ref provide, "ref" is not neccesary need be turn on.
> >   So remove it from the list.
>
> If the ref clock is actually wired it should be there. You describe here
> hardware, not what is necessary.
>
> Best regards,
> Krzysztof

