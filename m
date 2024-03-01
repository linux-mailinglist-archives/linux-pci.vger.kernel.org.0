Return-Path: <linux-pci+bounces-4345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953D86E9A9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 20:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F3BB26C2D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 19:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6003B296;
	Fri,  1 Mar 2024 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eib7XlaE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3A7E1;
	Fri,  1 Mar 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321618; cv=fail; b=SjuGjCXqoNdGpEtecJKcjGMw01VNpFM8lljmOAjsp8I+70AfPA5pJyqhS56EOXYrl2hr7N5toEpfpkkWUw0M6oX7yTQjjDi0k4iyNfQffF9G8Obab5/jfXfzk+IiD38vXHEeZlyaSq3T3gx87MQZuStTbhdy17UAqalZcE9dDKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321618; c=relaxed/simple;
	bh=D8vo2vWlX9RLHV2L9TsgJLiE4dcjpnAr3LRFtVSbuC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HFxvOHyJMnxh4NOFZ3m+yDuVTKz2Hf5hd2SoFkqWVGJHw8/vWLRxgKP846PrWlPIMD+cuyJlwvI8frSFsrTX9cqNQDMInK/4x7ZcscPrPlDutloLOXWXLDGpygvCCkIoGfi4+MIF/66gQQ2xfJHP3ziDxLkGPyNrcsV6nmU8LO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eib7XlaE; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrunkwGyoRSyzZuPgwb2jGUp/GsHPreCt7DnThPaNVPxWlZZS/mPMDfFGIbQGRwOI2hVz07o/6t8MDlunQlTcNO1CjxXappw1fCBEpsG3Bo6fwxBZZ537oS5sWpDDAPFdKBuEis1YlC5Xf4DRXWcVA0lhdaRX7OAtxKxRkrRTECpGKibwZ8fVEvzCk/AxwW5jGWhfSlGeZoqIdZhb9NCNPp2KaZ5E4Jwhg7hChKFwoGLVWfuoUwQ+sUTrHKVleAWG53qJrQJKQaQKgrhXJEfWQb4Swbtc3kPoTFdclLf6z45smC+tFhPBFR65+6Lkk4FPb7O//aAsWLdO1Z8qnPXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK15cUfKPntl1gy1dnTuXS9+GNc2TW3CDtuPtLLqkG8=;
 b=n4cHjIR2ipIJCN2Y2A5pc4I/yy5YUc0Ty2UIzp4A7R7ObnB4RFx9SywKnxp+WbDUwPy9S9fxnNoJ7YZzJlJiWWDMYDTEN1Sjwgf+Ms3do0E1fjKkWUl4zhd+eQHBffhCukSiSFX8p1jImOrEsE/MCI1M3LPirqzZ++CaLiX/Ob/uFLgZVYDSbbzqx2L4UQXqkUGlAKFETw3x9oU5cC4QR+33oWIEtCy5Wn+Wco5IPFJBM+NNTwUgoE1MFvQp6GGRynkLeCWkxikWUhwBaXoqsFB0qzZxYixbH2pTFf/Ywr4RuDgBFCSiuWwWIGluj2BVRtiyysgDBOLeolJVdyDVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK15cUfKPntl1gy1dnTuXS9+GNc2TW3CDtuPtLLqkG8=;
 b=eib7XlaE/PxuS956Jb61iy8lgojw0B9OMsDzXXUevat3GOyAfVr8vYd/nhVCfFHaOKyQyf3FpQmpZ++yDaDeoRPvGWxErnJ5+qBbXGQN9+MwxWNDfP1JmJ7RvUJywpQ8FjhVimKjOOKn8TKqfPWck5uHrlDFLDXUkLyeHk+VYPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10213.eurprd04.prod.outlook.com (2603:10a6:102:401::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 19:33:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 19:33:32 +0000
Date: Fri, 1 Mar 2024 14:33:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
Message-ID: <ZeItgeQuv8fZXJNC@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-4-Frank.Li@nxp.com>
 <20240301190931.GA403500@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301190931.GA403500@bhelgaas>
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10213:EE_
X-MS-Office365-Filtering-Correlation-Id: 83341ed4-8c1e-454e-49f0-08dc3a267ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LEmL+GRnxTwJRZNNH4uc5LHYA7Iz40d2H26zjmmB+Y3N0UNxhdKkRhqMtKvskL8x/CJ1kAZmjfD2SIgROWhd4SCmulYRvbcTmqV2a2/v6p6n601JhoCdu12nKwA6w+l8vRjBQOEmlq660RvrED87+CbIdJMUUI2JkLBPHw2wVTHVas7GHQqGtufF5bGkkZSO55wQWDn4TJluPG2gnVLh+SV/b5U5j0SJwowoiuuO/Ad5M1gh9aeKQM/Ap07mpyE7N7LmR1H0GSiWWNT3+yUXiQww3myk0C2f6dM2QCAg3P6US4BjtEVzAppZimbz0oWEUVHkRmIZ2wi4TFDjhYBoZWe3qLpCV1wCUh3+Mfs//FcdnAwmLWA26MN7arSRx4c87BCyyKIL4OB+TbsxmC+faiRshfcNZCIMXKY2xXo7J8hv3lbK0N9APqAuCiv2rxYaGL4EYJx9eqtfUkG9K6zrYveL3vjMeD/Gv9E7o2g1x3gBoWR5agATb1nIxENlRcaDxbehvGQ2Y0CSXz/eoXumXxNZUwEeaQvK+L5WCHwbxGlexqeIw33lFYHRVqlcA90nVmxAsrQqPfAzMWvgowd6HP+Bk8UFchRNcpzobcXlw9kDqqN+yRGWCwchnQ74NvYEUax+/ATuHUEuDMk43CmL0BKvXPAXUxOKLQwxoxkbHwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+UIyjwFWII4ywRNPthbOCKm4ouuyBOstqqF/ZOpHoaTYzFdeQQ2/a4IXCdWm?=
 =?us-ascii?Q?yyjMRZ6eNmfdkjmtNkj5lZzD1XQihgfFJ13jm855kaf907jwztHBDLDUY1Sn?=
 =?us-ascii?Q?AP5Vs5xvFDejavXvbJU53p9GUBMLBVGzrtKkUi1h14Ac6iPC1etm1flTLqEp?=
 =?us-ascii?Q?Cs7XO4kqtNBoNLEj07CRBFjIWu2WsK+rsOaOSGjc1QXC+KSxh43DukFpIJmz?=
 =?us-ascii?Q?03RM97a3c2k8y8VZJPeHj5GcU+JeT3Rk/r35C1dBBFYXI8o48Di+inmhLauf?=
 =?us-ascii?Q?cLhdyMqFa8c/DBARR5kb+SAHSPGiZHlfBQ/ptrirrVgeh4c6wMMES1j4oRW/?=
 =?us-ascii?Q?al80YvbQ43ZGoaFS4jmFUqQNvaovMjD5BHu3XkRnwxNE+N7Le7aH/nMl0p8v?=
 =?us-ascii?Q?z3KYMXhxlWEGfZWlJMFD2yLtVYLAjbRrNGP1q2koadCyW6phuxMKb55Sk9cY?=
 =?us-ascii?Q?qRDzAljxAOx9mav9OQAtvGLXCMXWzl3MtXkEYVNvZcbgUGVPBQ+G9NHXM0uD?=
 =?us-ascii?Q?YuICAqw1KqH8nlObBNRCo7L5S+uZgyqJav4Iy/+zwa8T3wJ/XgpinqGvk4+T?=
 =?us-ascii?Q?jnM9VONF9SnZSFm37WPUSFWFWkrUUYo5zi9gzPLohVNUZ+h6inArkHkDMUPC?=
 =?us-ascii?Q?zHJ5XXlyAyqRuAFlZ4+V7oGJ7roJdU0Hs3ouN5iiCPLMYBc4U7ee+9MD0Oob?=
 =?us-ascii?Q?LLLgnYfY9V8C0cEdv/dy2yB53vSj+RziML0n50F4M/VBEIz6avDcK8F+WaIb?=
 =?us-ascii?Q?nUz1OCco/9qFqPzqSm3/VDWBoJXT1yV/C+zhTwxvEB4pUivk19vwW+F547Rh?=
 =?us-ascii?Q?MsFlSW4KN0FmO8qi8jQccNatHr3IoA6FRUXBDUcpmu31oRex6ePNgkRyqe3F?=
 =?us-ascii?Q?3mskwJTswCT0JcmBNL3H7yW/+p7SuenrOl64HZOAPOJuVZybj2qmUPsVM0tq?=
 =?us-ascii?Q?clrGW+bfDK74LndgENbOaHG3tUcZgjpmOZkcmS+BVm55yT/ii2hl5I/aePRI?=
 =?us-ascii?Q?KLqESWNGXmbtxkM1fFWKFuGyiYbQkfCdSpQH6MXCjht7q7E+lwW5MmRA1W0V?=
 =?us-ascii?Q?yCXNWLMLZV+SbDKFvBZw9SpHe0dQuL1b0Rxl/tkMyp0//g/Xxd/DIicuxetP?=
 =?us-ascii?Q?7HbK9xVolQVYxKViFx2zHO1q62c8a169TM7nbR2pIDXZ2i11EIC3CALXO7Ql?=
 =?us-ascii?Q?p98pLGEeZK5xkQfEKkRmnfumuHjt3pYRPwYo/8BK0Whm3T/tvSpAirsJXguU?=
 =?us-ascii?Q?YtRMf/f2lHtSyuP+itfTdbecsfsD+361AMZKDo2njVTBloGvF5tUQt3+yhI+?=
 =?us-ascii?Q?Tq+8mY5W9C87ybDHcio6f/JzBVsLBLa9WPYxGq2TeTnr6b6nDQM7qikFMLK2?=
 =?us-ascii?Q?NdCm+Gbe1H05U5duIkdKCBEm1d24yMITSWipvJ3Ny5+rFdchYG9vaMxcXi8Y?=
 =?us-ascii?Q?sjua0GnUI9G9noES5ws8iblINS9iJ20+rX7DB8uJb4q+vbqWeurOvssF1Vee?=
 =?us-ascii?Q?Jic7UtfXuMsq2UfWrgxBN6MWdgHrn1XI0iynSVHgajH5GaVMsXaoubwX+QvM?=
 =?us-ascii?Q?VW9c1Jb1Tf3YycrDOVpjLCo8ayQ411154SQsik63?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83341ed4-8c1e-454e-49f0-08dc3a267ac3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 19:33:32.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJeL/i26FFDFrjRqjOYlr5M5kq1R8EMY6kgryt+4YYr0xWNI9mgNfIVpHn07f0HLBr+d/siFge80Qd6o7i30aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10213

On Fri, Mar 01, 2024 at 01:09:31PM -0600, Bjorn Helgaas wrote:
> [+cc Nathan]
> 
> On Mon, Feb 05, 2024 at 12:33:24PM -0500, Frank Li wrote:
> > Refactors the reset handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling reset.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Lorenzo, would you mind squashing in Nathan's fix from
> https://lore.kernel.org/r/20240301-pci-imx6-fix-clang-implicit-fallthrough-v1-1-db78c7cbb384@kernel.org?
> 
> Also, the subject line has a repeated "by using by using".

I think that it is good to squashing it.

Frank Li

> 
> Bjorn

