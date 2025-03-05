Return-Path: <linux-pci+bounces-22970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A0A500D5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867183ABAE6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D524A04D;
	Wed,  5 Mar 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HqsbuGpe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2087.outbound.protection.outlook.com [40.92.40.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E923372D;
	Wed,  5 Mar 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182190; cv=fail; b=MhjbnpPx7gN2/UqyojOIHM3XORtRjatkOvokhaWyBjrDVhnlbjh7wSHckMwSKJyD3ZKjd2B/BZSLzoGNsWyujkplrXjHtkma3MdyCPJeAeYTdkER1GY6OGOPPcftAyN/xnHAYAuCw2eXQg5jUh5UzAfNZkI5ohVTveEfvGkeeoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182190; c=relaxed/simple;
	bh=1tTBZun0tEJn+W/regELtZV84Bs7DVFwAJXUXNhBMLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duY2OeMTSqPSnk4gc9oNXYvZYOjdR3++HqbjdTt3n6MG5tCYW1f/hvUtP3D4UReE8QT/U6LuLId3XE3Jn6ISTldO6pcpoRV1mmO8Z9JDhXt/O8s6aIkdaTzKxWhoaoPawdKDOJZqXdgeggXiLtg2VJpu3+MjP3S3K52yWB+yilg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HqsbuGpe; arc=fail smtp.client-ip=40.92.40.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urYu7ZibyhpjjT+Ngwd0D4fIfxzJjuejilGZG7Hjq/NDCnS1tHfAlr10EwdAbLIMLE9eM3TE2uAn3I5WM+3pF5dAE/lQYL8+fX0Qd7/c6uEmGVM86kNrItzegLMXPF7F0py/3EqBgDMvoaIW6ZMwyTp6+Kj8i9QNYdw96oRESypNSvM1GEuXlDWHlpfyQ/pbPFGXdVbbDESvtJV+S/x4zcef6QaoelfQsRbz7IQsSXndHeT9wIal0ggBzWx+bBLYFu6iZFvLpyNO9jeAriMfoF4zao3ueZlEJ7dJZqbaDYrKIPR3w9wDB5gOprg90JypVgkcztAQizfELGDSo0dKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW/QQynphTA6Fcq6XZvrBXh4x/2H4gbrIdKMAzUOo3w=;
 b=enkdSHOvW6cxrYPudrO/S/+Vwj9+WgpgCZtLV6NVE7B7UG//0HaNCJojBG5qLbFeQl/Bcflvk3c0Qr+aovs70BRt8iPftgypEA2qbXIkut7GUpGGjyC9/ZNUytq448vEzFCu65U8BwRdFVAxyZIa7AAkmxL1rkGXuERYUyXvZWo//GYWklyA9rkmv7c0ktauHqkOuGOOsiyX01/ynlWjKuhg4vF92lky2RjLPxDlzci8AJpZJpb8wYlm8677yO7zP58ADnNW+dItJg9H3Ow1kvnUyfTWmnvht6zyhsWtzelB4R5ChPslCSDX2EX0/PA/g5OqurUoc3IXP+jND5PQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW/QQynphTA6Fcq6XZvrBXh4x/2H4gbrIdKMAzUOo3w=;
 b=HqsbuGpe9v/xxWJlTXO3WzEzR4Ooz50fK+VVlkHhGXb/dGmw8l94cwnn/J6hcek9CpOhHq1qXngEomRqJk8AB8QxVWaYv0iZftl8fCF8AOHxP9uO+qQrQPEp9J+RC9hDy0eIjZ/woHhRmPyzO7gxIyXadkJ1hlX6YvF+UoSwjKuBCIIsXHdtcblHGuyRGO9zKDqiYbb6ZOZUCrznRQEnTogtIiR6h1whqPox6Cdqnq7LFYcS503pYq1iMooiSAqKO1cxwc975ZBH3D8dOLc3HMG64g23lZ6GN4f6V6XOV4w2BHik7YB+egX5Dpnb/+q428ZA/Yu93PwDcGbAlt73FA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:06 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:05 +0000
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
Cc: quic_srichara@quicinc.com,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v3 0/6] Enable IPQ5018 PCI support
Date: Wed,  5 Mar 2025 17:41:25 +0400
Message-ID:
 <DS7PR19MB8883B5F3CC99C0F943BEE9DE9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0105.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::16) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: c0656996-19d7-4c13-c72f-08dd5beba7fb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|4302099013|10035399004|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtAjtD34Nqbrpri/lEDshFo/eFBt7vaZlMod/FS1ZrwZxmYuzhlhnwIhzZRe?=
 =?us-ascii?Q?BqZNcizQ5vTZEW3bZkfCWlxpyROozUAix8hfUGueS7I7QHBs8UcCxv6DS9b6?=
 =?us-ascii?Q?iptYlyhyb5Zaz1aoGV/rUABeCudgYxxIMSHmys4sBETjbfjkE8HJvu5I+UAs?=
 =?us-ascii?Q?NeTrZXO63819WAvjQA+1YzJpVYojZHaObTTJzvCQkCuj4UtFlVP2znlvUiMe?=
 =?us-ascii?Q?vE+wLWNRm0RwC+I50m69+cmYTAK4isQjaHPty2Pjl+0xxCNpNMJiHHZnV2IU?=
 =?us-ascii?Q?e+je+uIqtWNjWa20N+T88X7lp8vGmK9351RoQQXYF2H72JU0Z/X+yS91fZpH?=
 =?us-ascii?Q?xRCVvMIuBvlTGzJbepxUt7U5ZRykOBSan9fvDpMTgDcMAHSd345dUJYhDWo0?=
 =?us-ascii?Q?T3Ai6DM4dq7V2mml5zJ4J9XDqEw0fIDPQ7mK9ltUlowdVuC+1uWN8/Enlaf/?=
 =?us-ascii?Q?3HpqTVIxU4w1ik4StNpZEyIFeYT4pdfGRPT6JKM0+ugaQotm3T8e/+DQZUG5?=
 =?us-ascii?Q?bULGl7hG5c8bNFELx/kisDIz4XFjOSuLS7+XpP4PSxTmJtqRIV/nkVl6/4S3?=
 =?us-ascii?Q?VZoErP9DTZmaasYNf1nXT4oNCFDbNZRqEC9YqYN/4fbnEQNivpMgvwJ4CPCQ?=
 =?us-ascii?Q?mw8u7CgbFQblP7FGVc5U98RbnpfgapbobNmUHnRV/hbtxOkgIpPo+rrRKyqG?=
 =?us-ascii?Q?oMMA7qODWB1WVZg7yUG81Oe5eN74h+dZXskCBPbNA/LIeRyTuxTQG82WsI/R?=
 =?us-ascii?Q?NY1uIH9/qbilCWbNQYRJNS9lRRZiHO+yhCZxMm34mzN5BxzDtkB74N/WNt5u?=
 =?us-ascii?Q?t16he/+99jlei+of1vIQbkHcxlc/gOAEgucF8Lm8ocxZDB5fc3I+LsJVQ27+?=
 =?us-ascii?Q?PPeDWIIs/ze3PDle9/7ss4rV1S0PLthCULkxCNXya3Hmr3TcB6l6XmXFGkBz?=
 =?us-ascii?Q?rA1ltx5dinc+yq1SmlUHjZHnZhP5UOaVleAQRFtjgNXyRZfwXtH+w2mjoWxO?=
 =?us-ascii?Q?RGXZXkJzJrGSaqcwhm1QnIBUlFqr2/GTNJe1jKLGH4JJxjAYZMjq4WnWBwBj?=
 =?us-ascii?Q?oWDVO0J4X9NqivFnYJ5jO6BGswrDPue2RIH/lzaO8gzVmSsxhyC49vZuyHaS?=
 =?us-ascii?Q?upxbYEmY78wPE+5py3W+oSp8DlNJsAAWa7tzZ7+8Kt+IL83YNoTb3FQVmOtC?=
 =?us-ascii?Q?O8A/0gCkqSOyJISgNAoFtkzfb6chsQkUWJ9UwsIS8fkCIolZNL3ZqrJmwng?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7O96jgGMG7PyrAS3udI7e7R/t+NCyD3b44d4ceeWbLQ4bXYTkx/rReOWlbC?=
 =?us-ascii?Q?4SSfnGcVd29l5FPKxA/OC5TLjsx0ru82Nmy+kXBr06Qc7B3/6+y/PQwZGbog?=
 =?us-ascii?Q?TJ8Z7lRTVHqVdMqQkGz7iRWSzWSZjbUZ0vmuV+jao4e/rm5EnsqR7XRRueWv?=
 =?us-ascii?Q?Xo8ArytzXcmJvQ2yT0TuCv2OSJunf3h74rjn689ypM8r+IScRg2YRg23SBhW?=
 =?us-ascii?Q?Ylh0EQbRxKR1ScErqzfuAj3ljpsg9JeVgVIbe2+m6cEXiv7UxWn48lS+cOQM?=
 =?us-ascii?Q?5nt7l62JYFqlsEIriLqGocEm8zi4S4q8HuuUoxxFAHQVq4+MOOnuwA9WrjuD?=
 =?us-ascii?Q?q5sZsgFipDo30RGL8Ny8sxW8x1Yg3P2dRoyJ9MRBGNYi9SJuCjzHTkgqKqqC?=
 =?us-ascii?Q?U5iOXJ/BeIv0TeNisZMoMR3Xl4dXNaBhdtLOnVAtGMR2BA6nDMFk3UWa176F?=
 =?us-ascii?Q?tnlIDD72fQ8BzQGnfqjz1FFPRB5im0QA5i58m1sxv2RmQ4w9rlav7FaiUns5?=
 =?us-ascii?Q?0ky5TGYKUVerXK3Zdpyhw2NrAgGM1BnkwfblHvH/MdJLQWsHBk5JcBANO/ff?=
 =?us-ascii?Q?ijUXJAyU+bBeixbec4IKs4SL6qs6scWGlQT5c2or8TVanGVymnWDVH9tg0c9?=
 =?us-ascii?Q?ozaJDBeprAUo4UvrC2Y/0yyF/1iC1FKPQMrdibbx7/f/GTrCalQg1Pglp8vP?=
 =?us-ascii?Q?oEDauKzkI1jw+Wt/kBnX/2vuH4R5HOayka3QPRk3RPYgi0jtC0yAXqW2IzTR?=
 =?us-ascii?Q?AUdQuQ9cDy3sRF2/N2aZmI5kS/zvI4PIj2i0XO1aYodEzDy2CLDRLueUvmLe?=
 =?us-ascii?Q?cKhnaeIeTE7ZC4DlNsYISb7A8skCjMOxfD6DgqXyv7c6ozYjQTLPqtCKvSsB?=
 =?us-ascii?Q?xPskMlXGWlRJoxvPUuRqHe4yqgfsZoe9xZLBLu4s3iYnJfI5rBmZMvOlnUov?=
 =?us-ascii?Q?EWiiMOmUTBPlRQ/weKAo3bQaiKQKeiq6D4R6zmZEqqcztn3t9pBdoIzeggl/?=
 =?us-ascii?Q?/gtyJ2wB5obzld8Tx4KqDcMwdMLE9f9ujYNc4nrNC0A5O54KoFGVHGFqNk1s?=
 =?us-ascii?Q?2fdGqX5O53l7nB3jcLNC8O63XQdUpf29VElgLoSZUHb0K/zHrMdMpYRv03Q+?=
 =?us-ascii?Q?j+Td3j/u0jS2+tzRhKPfmXuJ8rGi5o04TcXuM4UFlyrOLI3wGyo9J1HLRlEN?=
 =?us-ascii?Q?dnO4n41IoEAFQOEfzHlj1kRt4GPIenT01dk8kLBXmVfReSokQV8oHgVri7ub?=
 =?us-ascii?Q?OlXw+VL58D765NOnBtRv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0656996-19d7-4c13-c72f-08dd5beba7fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:05.5453
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


