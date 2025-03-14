Return-Path: <linux-pci+bounces-23701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB47A60886
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB54119C2893
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF42F3B;
	Fri, 14 Mar 2025 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BEE6BwTb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2092.outbound.protection.outlook.com [40.92.40.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED712E3363;
	Fri, 14 Mar 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931754; cv=fail; b=sVfgG9Vycdxu1ew9jtTVMAThO8vir5Fwszs0QJP32sZtoFjer9tmHKFfT1Eg4mS+ubai/nd86321QG0Y4L4GdEFPTqD5v0SZw9DYDtT4qsOnFvQwJi200AmEhEESZYWhCaNvfi1KAUx467rWatHtVLL7zvzLKdli2HA0azV8quI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931754; c=relaxed/simple;
	bh=S1urqix5O3OvsWUqYYOD2XItTPttAkLlbqMIxafijvU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UeNVtRS8WsyCSTtmHKV0EnMch+F9bWmrS/3lh2Uinov5ZdeeeZrI8ehSua6pkafdTlJObA+bOaKo+V31Tn6W1Ofvx71pfmMlgpZyF5uocChnReOMtSyXK1GfHiJEyK67MVRjgiMQSnYIZXgjtb8ZJF+38NCqbzu2DE9zKeGPJvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BEE6BwTb; arc=fail smtp.client-ip=40.92.40.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSiPwuPihiDv/hgz9yeJBcz2blVe7PG7nXzaUCi0cFgStFknhFYd0ExnkjzyZGWTWERza+U/2GW2Y6vsusB5EdjOEw+pp8WfAJqYypvhtLRlUAOiQG4hUQiKKqyJIYdpuwQdty/URzAw0u26up/j/UN6JB1xb+kbQ25/yLVKXoedhBX8xE+SP8w7R92vP/uFejOO/NlwaCpiLr2aax03lW0xhU8KZ9l75qzJKflQ5FDTUvHwIl76WQkIrhLc2CziCUkYyJCErUXvlYFhg3IigXRbAram+TX/kAN3RihVg6XJ2dwNv/ivP5ZFs9X5WIb6H6/gtOBP9DN4N9XViSxdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=417C73lfXSBlXsOJCfIp3hBipsXa8md+4MQITY+muiI=;
 b=wXH6S5FN9pJyg8BR+8WEThmD9EuIkwRPqeRPvdIIiTNH7SlopUiNZWpU0gqlD1fworsmw3m9n0YtXGgQanVYpvsgIv7MM07/dqhJusOp8rqncUE4cUf93DLDk+sgzRUfyhdgZwMUtGogqG/jTYUvMiafz4eQLEt4meRfJxUKKLAb38jpuLsCnQTKPJ8D6aWqF26h1Mg86hJI60iLyQRzypN/a3s5fgGhwON4d9q5AwIkEnHduAWqMJJjpYPN/l4cHi5H9uMhx9xVmufGyLriJ6TtX8X1KGbKhyD1+ftnkbbfAST1H1z4Et08Xx93pxf9WZgUOVx5XS0YoP+xCMoHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=417C73lfXSBlXsOJCfIp3hBipsXa8md+4MQITY+muiI=;
 b=BEE6BwTb3NJGkKFYdRPUaKvT0+YSLsfcZEKnuKyE+nIXv8yY/9mh2vfU9pu92TZgIhO9+kBNevydUCh5Ole6n9yjUhqgZwzJV6ExsqpC+ZAxcqboOaE33UUYqeiHWlWWykqQl6q2Vfpx7CK6nVKVTa7A5XUpdSiqqqUiY9aMvownjyIr/3rFSeGGXqand+2z0bdVxQyKexRGfHl9y3amC5UYn+hB571TNwczKEXc2ADmrVWE4mQXfuGwjTWYtwxjaSNyqPMa7qn82iPLIFqgjKmVE5Lgjl/KSTNYCOzXNOb5lULu9mIF0PvtcAkCcfttaRYciKOPBL9u3hC+OVrTxQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8671.namprd19.prod.outlook.com (2603:10b6:408:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:55:49 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:55:49 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	lumag@kernel.org,
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
	vkoul@kernel.org,
	george.moussalem@outlook.com
Cc: quic_srichara@quicinc.com
Subject: [PATCH v4 0/6] Enable IPQ5018 PCI support
Date: Fri, 14 Mar 2025 09:55:28 +0400
Message-ID:
 <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055528.32669-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c30393-4af8-481e-3172-08dd62bcded8
X-MS-Exchange-SLBlob-MailProps:
	a+H6FLLcF3pAAaZRMwzHQe6ean9cA8ZgEMtbKFguQgXSORD3qOch4yQxoWUtSsQVWkKD5jA5qfuc5+dIMFkUZOJ0pF0iJ4yXF2+q5EYeAgK84AYxcp6aDgFR9KFhwQ8A46gztIz1xLA1cVJz0mVEOn0u3AeuXPGF7IXpdCMo0z/TkRgNYsXUFqH9juVbKYfZT2l6Si6mvARu9UZtlxf3qhuFtir7aoNhNA2xRkZMVkuZgb3ICdHrnFEVMq48O7yIXHEyhYj/Mq7c2AxnQX0kFDAooTO7jtgaN0ggIrciNh/ZokHvPNVaEgN56agPKVfFazaxIzPhR1RNsEXQQhYo8o9MnunIL3T9Ijaid1U6MYd0TuViAoOFVWRUg95+vDADUMNH3xSHkP9fdB4AB7ds6GDIUgVUAx+tvjBrb5rcVVeeRQP+a8VMhhHLbUb6eYSkJItclPwH8WmYbfvxAOFLLyM6NDQGybHS9vu/So8/E2tfVKGzvw656DxSPnRvsH0qjxqN4hBHkFmhPebyz+mS6aSQ8l2La89VdFctpdhfEWxKJ6bhFpGO6doifZuo56ka9Sc+iaemkUZlVzizo1cpjXjnHdTfajQDeN1IxHi+7zyYEFot25Ax+nZzokw1CKCi4DT3Ak2tT4YpQA1VE1rE0MxHAv8wOI0AD5+RsqRvtzfN23Ue7cl72Js8t6x+5R1d8X5XFpMbKdh4l8aUpVta0z0HG64nF83RsBijPdrqH55uTQ+MpGmEbk32JlLU0txEHEbyMfd5FhinXo2I0Mrla1FwBntUUMD7rqxHoLh3Y6bMM2NTlpAkXvgT4EyKJopC
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|461199028|8060799006|15080799006|19110799003|5072599009|5062599005|440099028|3412199025|10035399004|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GrdeWzGUO12dA3zm7BQF9lcsAha02LvSfuydIxa3VGXEAndmD2n7jnF6bsvr?=
 =?us-ascii?Q?eUbEq4y5M7vIjaYjnbUI1/nwVuKECaNd0Cee+UMymhxyjRGyDZ4fc4mtiukJ?=
 =?us-ascii?Q?tWNc5FANlHePP/9aTLoT/EeNur0Xr9wpP/0mzGHZZukWPNgbYboEojwAAKAV?=
 =?us-ascii?Q?mgLxYizJvk8jG3sYcyXInGlmVLxKwPIFKbrO3w8J+qaCMv2oP8aLqXL85Spd?=
 =?us-ascii?Q?4EsHNEzwsF0lUU5Dzhl5cDt7+lieh1vxZU41j1Mlw4om6GQhANHUGfMjgSgV?=
 =?us-ascii?Q?cxeUPtcmk1I/XGfAhYK0iZr7ERE3fXFUGLZNtgE+jYh3ZLOvaFc93IhLnfCA?=
 =?us-ascii?Q?nc4KEOJyY4YVIeyiXCHRk82Ss5vQeqh52oyMZlD22obcVzH01lEcioKAtN8G?=
 =?us-ascii?Q?7Y+8GMwiOXiizGY66Q6giByEpgG1YQZl+7lukqENzVqi1694sOQFKcJTxpRV?=
 =?us-ascii?Q?s2eMun1r9ogA0HhgTKZOGvEISCDqeWGKFcNwlqm+2A+BKciRj/5rAgI9rvTk?=
 =?us-ascii?Q?vNasGEHlPKbbS4hlTW9KddIwr1aleWBIYClcxCkLxjEWM8I3CEP7F7OPjq6s?=
 =?us-ascii?Q?4ZMvKOLdIznYgOsWLx0XV9ZCosulhGO86OS6hGXKy/PJ+Jerjw/qwKW5oM+B?=
 =?us-ascii?Q?rDxqPDNuk7Q6Of//AiVs1Em9XpZknVUiI8wqUJq1MVNnWqvHE4SrnsNpOJTl?=
 =?us-ascii?Q?wtEpw9EqVRWcaxXAp3mCYdmTOHj78Rlh8UgWhmduo2vtSHpZYr0VyAD5C+Ju?=
 =?us-ascii?Q?cuZ56xGl0rOwrYahTO8sgLLJR05VMmcfWQiXP/1PyI+DFnz08vWXXSnWe7u+?=
 =?us-ascii?Q?tbDW5j4xxir/6NvXOamQBt+8Q/132rL+pl3ABdUvSaRL8DEN7XPP1wC3DxEr?=
 =?us-ascii?Q?Um0UyjpQVVeROxG1/ttNPLFr8PdA1QoKjqkn4piuuAzN/gEVnZzpPClM6nAK?=
 =?us-ascii?Q?qMz8Uhi+S0Pslr+Rf96VMISgwZ2GoHZXhReAfpq/Ih8Eodc//GbijQ/0FrAv?=
 =?us-ascii?Q?0r1H3pi7lxyhQ62A737M0gd06Fm5IV4dopF5aDqGUNsEvFnEej8/fmAfx5QQ?=
 =?us-ascii?Q?hTYGY7gT26Ptwj8O68dQP3LR9BIaVZ1hdPQrptOa0H1jkh4U95FAwPbA1QWI?=
 =?us-ascii?Q?NHPAG8Mr442JzBOvyMBndqVvCs0ujIJlZIOHX0D2sVU1duvlKsc5zc5dKx65?=
 =?us-ascii?Q?xIQFJ9/db8kiMPQ4iczPHnC4jlOWbli/ozZNRIOLGcHlN/8p9Kt04Pto2hug?=
 =?us-ascii?Q?DAij+CErk7H9q8MR+CQA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXJCYufWtD1ln7lhR+ZKuZZ8rHYUr3fxTKelZl1mIPxQrcrz+YpCieMicJIA?=
 =?us-ascii?Q?Z+wNfNfjkJ24NVWdllk1zQHoyT64KgTlR7vEIPlxJ90jY4HAMXY3QS/1Zerw?=
 =?us-ascii?Q?FyHuHcP4PFdyQXALeuPC577tEdCVt6m+EUjeEWG7mgTEqfVMaCcVQKuUAwu4?=
 =?us-ascii?Q?pamN7FEj0WHpUZ6otYRg0lq6XTVrpQLdeBvRUk/w1OsrFSEt4ZHS09BH2XK6?=
 =?us-ascii?Q?edKrSp0sHzZ1liEG3vO+Xo3wmuBdPi88ZkNRCQUz9o5Y0I4BmfL9/B/jhPjR?=
 =?us-ascii?Q?J6vBaHtlGPGtJEnKZ1Xo+Dg79ZNBHC0IIiQ0uG13iEfRmJn+MJkPRXLLSoUC?=
 =?us-ascii?Q?POeKSPbiY9u/owHi8muG75S0u+Jjbq/JbYRxAuTrXkNIwQJybAJ7nfTbhwHK?=
 =?us-ascii?Q?88xq4mFX3ariYJBqscepZveDnKREOYcRq2rwF1J18ufRA+3mfBZ2mDOWwoNQ?=
 =?us-ascii?Q?iNn0F6Xj8GpbSS9mt7G47X1YXrjqZo+spd3G0NAnaURJVw1mS2j0g307dem0?=
 =?us-ascii?Q?O53MRUYDfafLSl9yNsA1+wKQ8lM5R8BaiEEoWnnpfrg4qTbK/AhF9nqD1Pm8?=
 =?us-ascii?Q?iQiuBS8rbZFi53v4Ap6KW+tjgbO8C5BGX2KgMk0ZGVNa9zSOWpLxnqKiISzs?=
 =?us-ascii?Q?PdiX0iqcEl/VyXggLAxOvr5pZNxtl5l6ZkyZ0TBtWPvsHjY7KjCFc/1y+UVB?=
 =?us-ascii?Q?s3l8+EuAe6G208H2LmE/iDzX+KnlOFeocDFjuBQNR3z6XGXIhjtvIC2dJrl0?=
 =?us-ascii?Q?txy9AJyacjwcfBL1rZuePQNvoRRme1edja7V3EoJZrG/AVgvcSwFC+idfODO?=
 =?us-ascii?Q?dNm4btLxZIXXMia23uwppsdhnu3Lgx22KzMmHU7bYOtVeHS2t+6Qpj+iWy5Z?=
 =?us-ascii?Q?Mr/96TM9eBJk6LMLYzoT8B66Ky8fMF6S/7KznSmUOfC0bBX85OPzI8t/8p5l?=
 =?us-ascii?Q?yZPF99zWZ/8nMLZfIpikyj0M35e4o+yLwwJZdOB6Bv5+uX/Y58/Sh5v2BYt4?=
 =?us-ascii?Q?wX2Le8axafosTta0Bh1PEj7kDSpw2QNMirWME6+PtI2iP5Ino4wH1Xc6TwJ9?=
 =?us-ascii?Q?0RJLUg8VInl/eKloCRRHrW6SP4pbjTNFcBg+7aKDxjQp621sV+RMdN3w1lec?=
 =?us-ascii?Q?nA6LC9rl+rQg7sqXD9wglR/f1zhmoiftwmA6KmLn0AQnShUmxORzMTD7OfDp?=
 =?us-ascii?Q?mncvYxIP2sZbLsF2AAN5Pr1HgzGIACIwkgCdaNSvdSRQtcZLfOO5opwTljBN?=
 =?us-ascii?Q?kEtHM5jDxdkszx+76GSk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c30393-4af8-481e-3172-08dd62bcded8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:55:49.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8671

This patch series adds the relevant phy and controller
DT configurations for enabling PCI gen2 support
on IPQ5018. IPQ5018 has two phys and two controllers, 
one dual-lane and one single-lane.

Last patch series (v3) submitted dates back to August 30, 2024.
As I've worked to add IPQ5018 platform support in OpenWrt, I'm
continuing the efforts to add Linux kernel support.

v4:
  *) removed dependency as the following have been applied:
	dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
	phy: qcom: Introduce PCIe UNIPHY 28LP driver
	dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
     Link: https://lore.kernel.org/all/20250313080600.1719505-1-quic_varada@quicinc.com/
  *) added Mani's RB tag to: PCI: qcom: Add support for IPQ5018
  *) Removed power-domains property requirement in dt-bindings for IPQ5018
     and removed Krzysztof's RB tag from:
     dt-bindings: PCI: qcom: Add IPQ5018 SoC
  *) fixed author chain and retained Sricharan Ramabadhran in SoB tags and
     kept Nitheesh Sekar as the original author
  *) Removed comments as per Konrad's comment in:
     arm64: dts: qcom: ipq5018: Add PCIe related nodes
  *) Link to v3 submitted by Sricharan Ramabadhran:
     Link: https://lore.kernel.org/all/20240830081132.4016860-1-quic_srichara@quicinc.com/
  *) Link to v3, incorrectly versioned:
     Link: https://lore.kernel.org/all/DS7PR19MB8883BC190797BECAA78EC50F9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com/

v3 (incorrectly versioned):
  *) Depends on
     Link: https://patchwork.kernel.org/project/linux-arm-msm/cover/20250220094251.230936-1-quic_varada@quicinc.com/
  *) Added 8 MSI SPI and 1 global interrupts (Thanks Mani for confirming)
  *) Added hw revision (internal/synopsys) and nr of lanes in patch 4
     commit msg
  *) Sorted reg addresses and moved PCIe nodes accordingly
  *) Moved to GIC based interrupts
  *) Added rootport node in controller nodes
  *) Tested on Linksys devices (MX5500/SPNMX56)
  *) Link to v2:
     Link: https://lore.kernel.org/all/20240827045757.1101194-1-quic_srichara@quicinc.com/

v3:
  Added Reviewed-by tag for patch#1.
  Fixed dev_err_probe usage in patch#3.
  Added pinctrl/wak pins for pcie1 in patch#6.

v2:
  Fixed all review comments from Krzysztof, Robert Marko,
  Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.
  Updated the respective patches for their changes.

v1:
 Link: https://lore.kernel.org/lkml/32389b66-48f3-8ee8-e2f1-1613feed3cc7@gmail.com/T/

Nitheesh Sekar (6):
  dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
  phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
  dt-bindings: PCI: qcom: Add IPQ5018 SoC
  PCI: qcom: Add support for IPQ5018
  arm64: dts: qcom: ipq5018: Add PCIe related nodes
  arm64: dts: qcom: ipq5018: Enable PCIe

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  58 +++++
 .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     |   3 +-
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  38 +++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 232 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |  45 ++++
 6 files changed, 374 insertions(+), 3 deletions(-)

-- 
2.48.1


