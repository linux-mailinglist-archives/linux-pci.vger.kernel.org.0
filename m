Return-Path: <linux-pci+bounces-22401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AFA4534A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA6F17D80E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391E21D001;
	Wed, 26 Feb 2025 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nNcX2+9G"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C921CC77;
	Wed, 26 Feb 2025 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537852; cv=fail; b=sK7hnBkJ5EATyDGDb+IrOHdf67bUraG6svJr1fyL3f0a52mu9Fc31m0R9ErNbPds7hepiGYxIN7Dkqkk4HH4wA4xjt03dnr9L2TwCVPtyrS87B/3TO98TWG1/OqsWv+ODqy5CkFQiY5rKpnlH201JCuKj/hWh3Dt6q/F9sfuLrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537852; c=relaxed/simple;
	bh=xJWWXLV4vnpRFcZrQ5uIXJW0L12CstTnph0ze9m985A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSEy2HY9mZiMCsrXFGUuWb85s8tvP4azvr8xvj6uyBUAIzdK9ZOpJovhDqxTbs+B6G8s7BbcBH/FAQC5JCMlFrSn47jhbuuwn5e8mYE811BX84qAsYaumkJ8B3GfQnJhoWxGNKRGVhcm6OsGXF+tPpwqTJ7ohGCr+FqRprURNCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nNcX2+9G; arc=fail smtp.client-ip=40.107.249.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUGFkfui5QiD9BH2RvrpWdrK/x7qRw1/gni6rmYaqSRoTecXOPJ0Z+o93mGWEtYS95ptdfOd9XxS+/UxZiA3EEHjb09H7aXb7FUvF4coCgJJWDAfW60yq84neuGckc+TtyjZT5jDoZHChy+YkYW/KDkQICTWrPexa/mu+PDK8utDy0OXojZYgUI/BznOUvj5aLlLnhEQg5/bFAEYPArr8o5wf7WZKAyQWpd0Zz2wjK0rOxqHm/DxMLalN4voLTCHK0SHXDtiJdPyx64iRruShjx5Dt5ykH7J6/zfy3cXRrIb5Ji04kWBsUGjecp7NyvWA35tiHauIEXAQ8oUdAQFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ//nQQMgOJJEaNHlS2zwxdU7DvF2/8030nWpwexBzI=;
 b=ODsKpQBkR5TmZVbIm3gxbOtnp1PiiAJhtjUfnrveeeZw3KX7RCZumgxkkT2D5HlDO77iC0dD1XhX7aJiVB58isXH7G0kDw9OYQPdOlx+scmy63TfLMvVgpUOeYNdshNJpEtAZ4Vr8Nkn87BzyBo1nHR/nj/yChgbSRrR1+pD5pqH5mpL5DeNoQsS8nYowCuX3PMLiP20ebVaNG9AydJ7Rhzq0jqNfYmwBMmBpqWaUsLWK558uHU19kDQnJwg0idH4nk0qC9Cn6uh5jrLcKglK5WDq1+3vi7LlY1p/G7vXxvLa2eAUJXHxtqcoF6wWkOGbKfVNlDfzo2VqZ88cWEZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ//nQQMgOJJEaNHlS2zwxdU7DvF2/8030nWpwexBzI=;
 b=nNcX2+9GQ+j/4CpOCFgYqwMoGaFDeqpXeEZHJDj096UFIbG/7lRIs/ibBK2/KqTYh18W2SkGuUZ37Oj8+7kxiL1tPWG9qJjXqCMImpTlIOaXz3Sa2GQGO2AoZl29hM5QaRUZ4O7elh9BpYTgUlkB8I+UN39Lu4B43KjpZY5e+rdU8I7nAETcf/EBn42j+DhSqWTmqVoi05GmKHKL0uKxpvDpbdsPNCEhFlZ5TQCTnL8c8drTnJE8O6kFC3bdudSKUbEmqH2ej1QtacFDYffiM+cy+v45sXyt6/iKeqNv89nKA5MMT9gyxYMCYCOZRHQ8pckcMjeRAC3dSZ1sdNrKdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 02:44:07 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:44:06 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/2] arm64: dts: imx8mq: Add linux,pci-domain into pcie-ep node
Date: Wed, 26 Feb 2025 10:42:55 +0800
Message-Id: <20250226024256.1678103-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
References: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c56c55-de94-4c12-0aaf-08dd560f6ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9J8bpXIy/VzGH6e1nZ/FGYSWnQelQ/XP5xQo1HdD3xSCnKi/78oAj8K/7Fb4?=
 =?us-ascii?Q?pGU7w1N9lIjV9DCPlqjqLba3BJUGprdk1UZdTtpGfdnDl7S9ay3vfz9yehLf?=
 =?us-ascii?Q?grPgJNkWNFG/wBr3BU67DH3lTebkdUPsQsTy29QaeUr4QmjPxglOfMNnURzI?=
 =?us-ascii?Q?vd8cYdltkp+2SMRhpPYPHQf2ua3+VGDHOtCslsTVcVugiMvEwC8sk9YKY2zT?=
 =?us-ascii?Q?zxIQKirBvfbAOorZ4KlAsX00e+6eMcBngAZQdhwHc3VuQkJ4FlIfDbQpg3fW?=
 =?us-ascii?Q?ksU7Hr/jzuizYHv0XKgzAzVn5amnWEkjZIBMXAXQATjDP2iXxDvK+dqaHX5S?=
 =?us-ascii?Q?S9O5A/2sLWcbiCb0uBHwMb8iWuUCzChHPIKdYxV7V32ii5D98pDFBwEIWOZB?=
 =?us-ascii?Q?3pfnoAsPE/uqKi9GDPUCYlsJjN5pePflRXp0RN+WxFui8GQ4odLBQ42kJkGG?=
 =?us-ascii?Q?YMUwZzaxPCd+G+TJbVARPgSsc3WCj2xuIx/s9wSb7ZlhzqOkiiVeRD4FcZRf?=
 =?us-ascii?Q?aZO3vCTQejjAtfLs4wd4PjztlTgppidnavEhAOEb1wy3z9IFPuDocGEjvfWt?=
 =?us-ascii?Q?YRG6jWgnSz2/nXqunsKK9Lkq2zvlEuPwdCZi1OdXldrBADDHvIGhPX/PO/wh?=
 =?us-ascii?Q?UJInd6cVeOGdjjQpz/g/LiQ/ilZ4i1ofhFEYhiDHr8kI+UizDLs1nCJRi3/8?=
 =?us-ascii?Q?esuE0umV++Wtxo1Mnf1I7JTo2ndOBqDtv/xErlpoE8eJiyreOard7KKPbg1y?=
 =?us-ascii?Q?O4B/2nibsCqyIPGZfb4FyOgS5oz4/c+HQ4OlkkA6vyyQGutaNzXYFG2EIXqg?=
 =?us-ascii?Q?u2WYrVE347YRz/MBn6tdk8vQ8QQHhrqmd8wq6gPYghNUS2bfSsY37y7eq0FA?=
 =?us-ascii?Q?TIgZqWGOMEnrZlKHhBm+aSFSr9xIzrY+ADsDNLsSB+EZXjTMn/Fw5j/qI/cM?=
 =?us-ascii?Q?qQNtGi2FVl5FoPGrMIjSq0aOX0y7izHmGumMmUChNp25J4cfdD3U+ZQVKek6?=
 =?us-ascii?Q?rcbbzDrIxaB0OrXtf2Ap4EYWcNmjdR4H7RpZJsksTnvynZuNgmETcOFoYuzx?=
 =?us-ascii?Q?9q1o7KGBfG6OfukMMgmgE9VGF0dhBYS+dC1oIEtb4KIaf+gocpEvcDrr0YlT?=
 =?us-ascii?Q?JF3SLVW2MKCqUNnRmABrLfasQDHewWCaMxmtErzkJKf2QdYt12ZI/poWTN1P?=
 =?us-ascii?Q?9xJXMUXdYP6Ki0YJIq9aYv8GCoYXtdjOHTjdVWa1W4aZ/5yjy8e4vrEwPLnT?=
 =?us-ascii?Q?R/ImOCJAb/lR/Ip51Ad9i0AMhJ88Zf+mAJs010WyrfBXQn7j9740Ld3h4n1J?=
 =?us-ascii?Q?NtFoRpNQ1HJP6rKYSOmMtI9vKrsJll9xMcWRj+BSqusAZGznE4GLyWDZB9IB?=
 =?us-ascii?Q?41gsCSSzO2xAZvt7GSQSB8ol0OFIxAk+K0u/D1PBEgYjoXsiU/xK1nWwIj4i?=
 =?us-ascii?Q?/C53dN3ZqeJIBq82Fty6jwvjU2s5u5tfUnOGe0L9EFdj9p+88rqd/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKvor61oTXRbnBg3xPEFnAWe/xh4EwP15b6scTD3y6LNXg2TPOAQ2Lwtgy/s?=
 =?us-ascii?Q?tLmVom+WYFK0Xlhhybut2Ra8qUpKXiwUpm+tn18WWmpDwGHx5DypbJI7CKfz?=
 =?us-ascii?Q?GJFM9r/mzh5bw4IsTkyWa2SUQlziZc5odkzDicDXZRUJyK78eh5DgubgL9si?=
 =?us-ascii?Q?3UyVqyJV2NKMbDHvnM3z9VJmKQNmzMeWaw6BYJgXHaxOaWxBYzMGJG7mrtGL?=
 =?us-ascii?Q?6qFWS+y9KUhfvxBeSRrDlOCZuDNEZ6bZtFSZWpBQgZbznZ4kErJ/bJFsVCTx?=
 =?us-ascii?Q?OU+YXS8JlRxOERDb7NTunrQkzm4gjkhKnmQrrB3lUPXCx6p7n7Y8fSJLhQMU?=
 =?us-ascii?Q?+eGAElqHBeIp3zLN+px3EXRVQm4kmt/9b2NJT8YKvlIBKPZyyyPgm5CklZ4q?=
 =?us-ascii?Q?PAGHerbx6BsUJwEsAySgKYv4XYd00pShr6dKbQsiBDFWt/frzdYM9ECbp406?=
 =?us-ascii?Q?rCFjbzGxs3cWcoMDDh+VCnerlid6OFkIcjuUo5CYfWC8LA6nOITMKd4XYdm3?=
 =?us-ascii?Q?aGbeEC5u2GcvPJ8kjWk1hAYuQRgyp6cZa2mrQAkfDnh44CddFJFbLDBb3Efh?=
 =?us-ascii?Q?8U0fGhcyO34Xm1eJS/aSrdfIfIM8jlR0eixL3Me1MYu2dzFKuspydxjE8fsM?=
 =?us-ascii?Q?ncSbxLERdrXSXtH3AY+q2l/E4MwQtoIDVkQMhWgV5IRRJerAeDGfThg+GxYr?=
 =?us-ascii?Q?l7z7sdgCGY1Dk5bjBx8bzT8MbagDAyctcInirZeKtm75XLna7uUWfwb83GxD?=
 =?us-ascii?Q?qjBD6x1cCBeTDQK/PowuYrkY8c/0wNlqhSzrCsdUBGCHaJfjyYuosFC364BQ?=
 =?us-ascii?Q?AoKFXiKUqPsPldlM6ka0afBwB0y/DyHXYZ/qwLXjTLQIHwOp2hVnQJTkOZ8f?=
 =?us-ascii?Q?J4t8OR0cG3XPhbiq75pPb3FM9np9yeYMncZEBJ3E23TJlAxNZI6mu9YRegLt?=
 =?us-ascii?Q?KD/Hdezd+nBdEtOYOI/UI5BrakiVihCus26c+fB8AFrHNd4fS283u/rRzLE5?=
 =?us-ascii?Q?wOrWZU75eLjnNCSqAElZS0kPQMMQne7TPWGCM899eK9GzP+4LTo+1reM3tAQ?=
 =?us-ascii?Q?CWlm69gSAR3omKbrIl7eNQRP8nIo54IRRDu5t2uJrvFzuN20dpMAATzhLV5E?=
 =?us-ascii?Q?V1gQelS+VhwpbGID3lY2WTixijNbNKznsSLaGhFbJAHZ9lW/V7Knsogd3m5o?=
 =?us-ascii?Q?UPb6KYC14WgDYx7580tV7fUKhHGM/dOlaZK1ICDEdjYv6wPUUnwMGcdE8OXj?=
 =?us-ascii?Q?23cgSGSPykkGZxUS9Dv6mfVbDd/0FdLZXCadmfiwOlMjK1Wbv6HumrUaFgkl?=
 =?us-ascii?Q?R7uE1zNsdAGOiKQVBM5D76mwHgHLnnCa6jm/BAPp/V3I2v6X1Nn/dxlQn8NW?=
 =?us-ascii?Q?GSul4aLnTeYk3x/QBiBHEeJJ03bYU2zPK1CIFjvecBj0c/RfnUycOzS43p8N?=
 =?us-ascii?Q?M6RkeeJqEATvAD2lvCve7dm7pfv3Fyi0cKgY6MSs9/A/2ADmvYF9mavdA5S9?=
 =?us-ascii?Q?WVJ1oDqL8qIKruV4fWnYh+GiKChcJPD72rMzYlSPEehRNSkBiHArNpRu2hFT?=
 =?us-ascii?Q?s4HgPkrzfM0H955erOArarC7tMSYDf64rRIfRHKa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c56c55-de94-4c12-0aaf-08dd560f6ffc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:44:06.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+xofuPinD3dDN/1WE3iNZMpPQSApJHt23WCD2JmTajwhX1nTm0D3OvxijGWupXiXVWRa1UPjWa4OlV0U8m4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

Add linux,pci-domain into pcie-ep node of i.MX8MQ.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d51de8d899b2..387b3e227cfc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1828,6 +1828,7 @@ pcie1_ep: pcie-ep@33c00000 {
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
 			fsl,max-link-speed = <2>;
+			linux,pci-domain = <1>;
 			clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 				 <&clk IMX8MQ_CLK_PCIE2_PHY>,
 				 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-- 
2.37.1


