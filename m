Return-Path: <linux-pci+bounces-22969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3432A500CC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6734165794
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B71E531;
	Wed,  5 Mar 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nRJ2lW8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2014.outbound.protection.outlook.com [40.92.40.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC1C2ED;
	Wed,  5 Mar 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182181; cv=fail; b=V/+MeRsfQuaVs6TZUjIdtC3/6FDdNqWlwtGK7obadefx9bRnv86oFjtxFS1GNU+PmqkJ07+XddYkhNNquzGsMOAQ3sdnDWwWoXboU56rIKi6cT3ZbVRLN04G7Fe2yb93647dAGasAxgLvDnqKwFe7QKRZ8gIGdpYx6C/X0XOxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182181; c=relaxed/simple;
	bh=1tTBZun0tEJn+W/regELtZV84Bs7DVFwAJXUXNhBMLI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bfS6JlGJF6VT9Os5nHirtADP4yFMLmQXXNrqZs4ljlKnDgPWjXmSkcifbw/Z490UedSNGSIdrpi6F17Oa2P29//3ON1q3ELIVDJ5wH1OlE4DPh3YtpmG2Sv/IhN7ogdoQ+RM0pSt4EE54F05J2qJXjtTHdP+YwDPca8eZmWHKaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nRJ2lW8q; arc=fail smtp.client-ip=40.92.40.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud3+XplZdtV9q54xWnbRAr/xr128Tzb/vG1y1BRFe/WSL4C6P19u6zP4gDZKTzqbdSo0J3exRFEfnLlKHdIrO30mAslsdfAUGV4uU+pae73tN9L3K7Y2LaP1HwGUbBeVycfhWChnhRSZH1RS2qxHIsmd7416+88ZEjfxXeWV6d3iGlcEHKHLQW0u7XkfZDaOoWHY4cteecaEV8YoILC2EgXkjFMo2RKNLDGvUQSGuYfm/qG6r6iyAfBh2k04kkTU0LiqjtPJ25n5fptCd+ZAZvt+VtRMMvlPHlJNs4c8FochrMjGs09hBkayzOXC6AgID1WCdvfl5/nAA3GbwX1Dyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW/QQynphTA6Fcq6XZvrBXh4x/2H4gbrIdKMAzUOo3w=;
 b=xo/fgGKjxgUrA98F6orvhIcK/k/5NHcl8FkKAK71KzI8tZvpGEHRDg/9SYtEdL754RZjkfQAA4OCVw1/48/sKRey3GzMrNYCMeizbDiBS6x6hVLvxRdn8d4k0dhbdgwr7A+PcP5Y/px6392Y8hv4Z9inQBEOeTopdD8Gx+8m8mtF2AOqDlHPXy05bHs+v4uLli2DA/JQkc8XRSf2Cl7x98ui66+l2EGzcWHN34nVZrcAypFrimScm1sJCc8kxI+Py8GQ7piNLNseGEPXW8KwlhGlQY12uhpiLpwGljciARzKtBCirC+V3Gm3Us63IIhzB1LfFLKgUFOW8Gigiv7q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW/QQynphTA6Fcq6XZvrBXh4x/2H4gbrIdKMAzUOo3w=;
 b=nRJ2lW8qN5NNtTOJrObcoxLx/NA70BcX4tPQa3mky0tNsErYsAnpspUzm9TRWGG13pxpWBL3fZ+PnVVe2b9VKMBY5iLD7bVeL6OajxF8TqgrZdldWWhbTnl1C/SrIXlpx3fuoIZVf8yr9seb8CjszwvOwZwVN1SoVVGr2hrJ2Drn96khluhgs4+v6FSmd+Q2NMkqowqI+BCREmfzQZps5bfqXEt90efjXhggjLdPo6cR3nCLrGNo5kNo/SB5hIU4tEcxRRYC6KY5TT3hXvwV+g8ujdTM1TPLhfmIu9fkNv0I6D3uXgDeiBmLIlUVUnUw7jYBNuD+92vByl+R39Ml3g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:42:57 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:42:57 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	kishon@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com,
	robh@kernel.org,
	robimarko@gmail.com,
	vkoul@kernel.org
Cc: quic_srichara@quicinc.com
Subject: [PATCH v3 0/6] Enable IPQ5018 PCI support
Date: Wed,  5 Mar 2025 17:41:24 +0400
Message-ID:
 <DS7PR19MB8883BC190797BECAA78EC50F9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0025.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::19) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4440b0-473c-4c52-1cfe-08dd5beba339
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|4302099013|10035399004|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQUUIu7iQpxbM/lqQZGO/GhsIof87ylS4o+434tV5ipap3rc7xADYAA4f/Jm?=
 =?us-ascii?Q?gNtcfdjFQc+Y1G72Q5F6eoX7d0Jq91mBpkGLGu8zXiIBge6GLPl6b9jMNXvl?=
 =?us-ascii?Q?+s03FtYOpgkU0iZlNT5/mZvjI0ytC2lj62IGPjMsicHacf79c11kcWUs+IIF?=
 =?us-ascii?Q?rH/zX7QQsKd76QRrZ29M0TbNwTvjXhvJ6atk4yEcQG+JAHzRptBo2oxLZNB+?=
 =?us-ascii?Q?5AUqZAqZOcAANjWcQfaZpQAC8FaQKvdTcz509IgLRccq8XJ+snlazfAqGjvr?=
 =?us-ascii?Q?xLXD7Fzb4SJm04MwJz/GpjmLj1b0fIK+kQ3XeuLD4LIlQMJkmQ10yGmSKFS2?=
 =?us-ascii?Q?rvBk/iv4BkuSKPS8eL+wWxfoJBAuaalFmdPwpBCH0WibWq0GHDCf5QhrQ1t2?=
 =?us-ascii?Q?SXHEe3AwXKxxDxbSCtyjQshlAqtXoR2U3/1Yu62PceeAssexhY3BeIDusE52?=
 =?us-ascii?Q?YvT7B/glarTlJ1crkVjRfK4H0r95+a10pJ/qab3ewL1J34MihyD8E99PtLjb?=
 =?us-ascii?Q?jyehSNtufLYTnY7KUNYOTC9pZGA/ErbR3bbDQwMd6Xojcjp9HC1cjRrgKT+r?=
 =?us-ascii?Q?6WM/Kz+pdCDL22bAt6Pguq6kq0algfU2VM1sIH8dxAbfIIUvASDdFOyJ3aG0?=
 =?us-ascii?Q?DIxLjGlbwN04DACIDjYvCYt4gRD/t3D1jAMR3AVG4WfvxUU3rll/R0kXoqyR?=
 =?us-ascii?Q?IzxQZjcMdWHA1qI51lJOQe8Fw1599svNAm/FPJSNCRgofkQH37PYMrM3JlFQ?=
 =?us-ascii?Q?PueQaqVbWEZyjNMelyH3mzW5msPxBeYlPUiFvRp9+YgmtsXC0iLN8FSjhx9h?=
 =?us-ascii?Q?mLWJTIDnIHjTWBHlwsbUJagS6JysxJkkCUWZAjuKuPDK133sprbGsrMpC5vc?=
 =?us-ascii?Q?jPgedOAUPoVYJPuV6xrXxOXU+V80ZZwq9qhg1em8mGToEOFIHjAIrQk+vU+t?=
 =?us-ascii?Q?cFAdpl3QX+tOhrLTVcowJ84HBskVR2YMSpLBM7Xk485E05z24yP+Q6bzpm1m?=
 =?us-ascii?Q?ACT3dTiOH/DuPUqKr8ZhPBLKH1iuh7h9geLVgH6wHJjTdj9PULNt2ejnQfab?=
 =?us-ascii?Q?lD3i4JuykTqA8PjwXsKhE/E2yp48yUfpv91VOFJk5I38VYzQGBjMyL8G0+pt?=
 =?us-ascii?Q?VFfjkG8vAa0muP6rs2OY3HfozRTh0V95gSea9cTEwlMEtAtC1FkNMSVfCj6u?=
 =?us-ascii?Q?Ox5t8+foFGQZAOMbyyRbdMy62lMUeX+A3WiIbFOOBUeePluBvCk3d/SAK8A?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fr4VGScwV5K9WNaTcxbN4kl8zBeNreM08bPENp2CfPSxgk6zMXmCyamkR5nH?=
 =?us-ascii?Q?Mj+kf3zRTJhJXtOwjQ9JDI/qdY6QNe/cicPmBT4FeG43rdphqUdqilSmK8o6?=
 =?us-ascii?Q?xUBTK/aUthD2/fT9DQoBg4+UEh7THT7NVixvGOg23wnHM5C2+Uwv0WUO5acW?=
 =?us-ascii?Q?vuyCHZEXdJ9+mdXOSR1o9QxYXi1LhHysXUB5tWZVIglzEW6qUMKPOyWGChkG?=
 =?us-ascii?Q?f0rv7PrdDp5Nkc623gWMXmey1ioFmaR6JgilXxR1XQjBoystk0XtBt6iAMmp?=
 =?us-ascii?Q?ARSGDah4/bnE0MxfgRYWM57YYhKXzUVQCTYNH3XgCHNg8tbpyqE+Rgnria31?=
 =?us-ascii?Q?OAoPcfowVzwPQZHY+iJv1Q2ALU49dfVVbyMWudlR14/Cf6CLFeVhmz8v/A6G?=
 =?us-ascii?Q?QYEacDq6JMUHBYXlNcxcsqO1gHYUeGroAFP7PsyjJ7be7p4jOmvdtBG2Y/xz?=
 =?us-ascii?Q?Y5WUn58MUcw9O2UL5eimN1WqsEMVAcFHoi/5OQEVpDdBdMvXB8nOoFaQyRhW?=
 =?us-ascii?Q?gdLw4r3xtAgtRvvEzuC8TqJD89lAv5oe4csNwQzjeEETHDpyNdww8A3jYlud?=
 =?us-ascii?Q?KPDQdd0BgBkSl0peUV2pkP7M6EtRnwL9NNLlBW/Ex01PA2DOHEx4zBpnHQPa?=
 =?us-ascii?Q?8LgjPT/hwrPTJd9XXdEGNVGOgFqoARxA6MTZcSswK+i1VfraV8m0crqzGFsE?=
 =?us-ascii?Q?5sg+fW0ueKuYA7UMDfHBXsOdYRBULen5jCq7Jc9SxpY6W7TYodmp+8kRp9k6?=
 =?us-ascii?Q?Odm1HF8kRECQxEHmrLoYefB8GX/E6abwBlvtTdw0ZDDhRdtjrvH1sm+99lgA?=
 =?us-ascii?Q?3WF1tvZ71eaY4qVvxUXbILrO0lx9mWGfs0l/sPttFj2a+Qby4TI7lVQ2nSfZ?=
 =?us-ascii?Q?xw2GBbGejX55gjNcGwLpnhwIZZytR59K1MHvZGuAcFJ4e9bBLIxQW2OkkQdL?=
 =?us-ascii?Q?zRov1CuET0HYb0sw6ToLKpqv12O/N1aAfFbqpZkJ7f1kjNljALJDgjjFkK5D?=
 =?us-ascii?Q?3Or2RXN0YDYIrxrIaonO04GqUXdp7m69Lsl+WpIf5X23MLbdlMvG6okXsKr+?=
 =?us-ascii?Q?6+bxlgAXD9qb3/++bwCE+Pd85Jk7xTzPxnxuufpw8PROROPe2BnMn1HeE34W?=
 =?us-ascii?Q?YFPDnI3AVqYvuAvOpKeQBJMcXAXSGrk5AdSLrWT9CPzt2GOiW+DpKq/UEbOh?=
 =?us-ascii?Q?zXqjbG07jwNaVndz9Wku8h+Xl/dimsyIVzgXsazfQ10cKC3VW+j0m0tmCbPA?=
 =?us-ascii?Q?r0xnbED4zw2cLlVS+Yz0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4440b0-473c-4c52-1cfe-08dd5beba339
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:42:57.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This patch series adds the relevant phy and controller
DT configurations for enabling PCI gen2 support
on IPQ5018. IPQ5018 has two phys and two controllers, 
one dual-lane and one single-lane.

Last patch series (v2) submitted dates back to August 27, 2024.
As I've worked to add IPQ5018 platform support in OpenWrt, I'm
continuing the efforts to add Linux kernel support.

v3:
  *) Depends on: https://patchwork.kernel.org/project/linux-arm-msm/cover/20250220094251.230936-1-quic_varada@quicinc.com/
  *) Added 8 MSI SPI and 1 global interrupts (Thanks Mani for confirming)
  *) Added hw revision (internal/synopsys) and nr of lanes in patch 4
     commit msg
  *) Sorted reg addresses and moved PCIe nodes accordingly
  *) Moved to GIC based interrupts
  *) Added rootport node in controller nodes
  *) Tested on Linksys devices (MX5500/SPNMX56)
  *) Link to v2: https://lore.kernel.org/all/20240827045757.1101194-1-quic_srichara@quicinc.com/

v2:
  Fixed all review comments from Krzysztof, Robert Marko,
  Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.
  Updated the respective patches for their changes.

v1:
 https://lore.kernel.org/lkml/32389b66-48f3-8ee8-e2f1-1613feed3cc7@gmail.com/T/

Sricharan Ramabadhran (6):
  dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
  phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
  dt-bindings: PCI: qcom: Add IPQ5018 SoC
  PCI: qcom: Add support for IPQ5018
  arm64: dts: qcom: ipq5018: Add PCIe related nodes
  arm64: dts: qcom: ipq5018: Enable PCIe

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  49 ++++
 .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     |   3 +-
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  38 +++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 232 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |  45 ++++
 6 files changed, 365 insertions(+), 3 deletions(-)

-- 
2.48.1



