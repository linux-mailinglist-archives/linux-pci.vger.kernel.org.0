Return-Path: <linux-pci+bounces-22976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090DA500F0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73787A676E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFE24EF9E;
	Wed,  5 Mar 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Luf2ycvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2083.outbound.protection.outlook.com [40.92.40.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474B24C081;
	Wed,  5 Mar 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182235; cv=fail; b=EZRA4M/roDp0uMrpqscxWMOfKuxu0cVFh+D4oELR6tJ/3Ti3SL+YCcVSEoW5AygCaBQefnkgImRt/nKMO9rJmT8hzKdso/nArPOMRHxNMs99IqPiC+7RmRGvTKHiSBz8xTcxxzb15jibuZYG2TpECf9si9Sr6OLy9aKaw5/mgys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182235; c=relaxed/simple;
	bh=hG21iQ+sgU0PE3kWGlTPd3aV00N0xCZ19kwEwihhidg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hb3+97vmqFT/fkh/ZIvjeNFwB+XZ48uYSfhVA1hjvHJ86ikoj7g5v5BKL33XTHK0ds4uMtKiwziWR4o13yDI9KRa7Q3fifqGOuAGeEbvnrtEglZ5ByV4w1cfeSVsZbTG0mcQ2a0lFEknyb3KQZBQHZFgHhgilec+OZwQYyS2aHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Luf2ycvC; arc=fail smtp.client-ip=40.92.40.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwfKIUPrcHxgYulX3bg1bDeWayQiDsYUSauGEKJgKOSQrGUyZ2R3vgdzfTOxnOE/8K5lBBNpyC+2pvzd3SjLmY7Pnv/21HwIkvbsGB927OXsY1KdrRlSxKXgZcgp9RiqavtcmreaZYcprU3D5w7lig4MYgKqjlDaaceIMrwtMyy4RjXbowFbDcLJycmCg+oM5+G9q+OHVtX3wX8fheSgJZRQ1w8+ZSUehsARp4VVyoA9l+I7evhknZ2DfyKopqMh0LROdZ5XaLWuA9a4UApxPGFXwko/3f64kKqkDv3jNgIk5a0+V0ISxu3Z9BAfogiOew6AEL0Iwzxac39lQ2m3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzi17UPH3tzuto4D/PCV1EnL0FPy86wrtEelgv/mZcM=;
 b=nVWKWMp9tZsmXCKPLuFGsRmaauJx3awDhIlxAm7cqGZQIQtI/lDYmGGqZkYJzJDFngZ//lYRveLXGdBxv9Hxcyct6gY45BLXcSDk0jw9r6xPWLW+UIxGuTitVIUL0+Lnu0WT8q135G3lQ8LbPLFDqp3AmHDzfSnBV8MqgTPGkC5ItaS9XdCybf8KxeAcE8L5I4Pf1z4hdCatif429pGSUQ+GxIMzTl2p2r5YeOaWuvuYzNqDkoX74yar7UsKU3kCl2AZHceOgMFJvgzC9XvkkgURoukUoYlRv2er2B5lY0aHoTx2mEtEh2ERe5u9J3qYKTOHABSYczckJLDZ4NIIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzi17UPH3tzuto4D/PCV1EnL0FPy86wrtEelgv/mZcM=;
 b=Luf2ycvClfQE8H91eKHBvbJVzDBV5uk7DB9mFKWFWuF9MMBV+qcwVhPDQB5AtW7o0blhsimRyhZDWS0c1630OjQqh5OiHWYpOkGq5SpbsZ64wfF2jUSW7Q3kH5K/3u7zYhguyo7wkH/DRhjZVwrdzfTiQS0IHpsan3R8Z05FBU0yOAFOZQuZ+WLW9sjhGQ4N0zyyVAsSe3RA6SPkrZkS87TdgCXIVedGYuodKfIaIMDfkoiDAtSQVw/gM/ct+iwUKvSon7FABkOWJstoRIDwwG85uWJcyWF9FHtT1t8sMFW9WXmtjrGR9v6yCaKV9h8VI+T8ExPdCLBUeokBgIQstQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:50 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:50 +0000
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
Subject: [PATCH v3 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Date: Wed,  5 Mar 2025 17:41:31 +0400
Message-ID:
 <DS7PR19MB8883E1552A71914AF1E1B68D9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0060.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-8-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3032b97e-4719-404f-4b0b-08dd5bebc2d7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VpHMemuOlhL5pyw3anY38Jm6/6TXQYdpca+J/bf24G31p4uQ9mfEld2xqYtH?=
 =?us-ascii?Q?H2UwWbrcjY8jFFcineQNYwZQS1EVPOkhy68g0CYhI9PJLrL+Ovjk7evh4M2/?=
 =?us-ascii?Q?PRyAZ3Xi7i/YweexIOB/qeuCO3QcLAxxM12i7AK/Df7AZ//h5EfgqMF17gs0?=
 =?us-ascii?Q?SbhxBaYLplk7gLqo8vvlmDhom8qpbGDWP6bUMYdLAsV7eDvvK+v+hF/OJ8Ux?=
 =?us-ascii?Q?37aURYHwYRVv6yiL/UDUkk/L2WGqg8J0PTN3HGYmIuMWT05HLI165s0vV9Ah?=
 =?us-ascii?Q?grefwf+2/+iMFJRz9gObcgwk6/ID11Eu7SwfmbKHshiSFHCT8Eb+T5pYS2yF?=
 =?us-ascii?Q?eW+Y71T2G40SZMeF8SiS/ULJWRZPgTJEFDhjl7zDR+RBbkKDKSRi2TmQ+Rtb?=
 =?us-ascii?Q?4pkDZgNWnxFF9IHSt47OZlnnXIaIWU3dqU5O2BCbCz19x4+QE615av0iQXBO?=
 =?us-ascii?Q?PDUtp2px8473X77ZVY73ND7gtYuCfb0N1borjof+89yuUwu4xzPOm+A/Oh5h?=
 =?us-ascii?Q?/217hGO5QrCQ078uVuePySGMn6L4vD9DLzYHhqo7j0o9UQR5gvbuatUXN44M?=
 =?us-ascii?Q?8NuZ5IvRAxXjNubwPd+h3R2THlcFyv0z5ob1OzaVash4FcFjTcJ7+2YT9Pap?=
 =?us-ascii?Q?IY0qeUPEXUvgLEnlY08U6dPczMLSs9HHDJY/lSUP5MV+SfmWDpiXoSEcTKt1?=
 =?us-ascii?Q?ryX3KAJeJd0jspYqJ8y68+KOgKek23JHf8Jn9Fn/Og9Hyto7yB+u0EVWmIQD?=
 =?us-ascii?Q?eLnz++u0ntreeo2Y2G/amOnrj04v5EprBQaCO8iRZslxagYkDBeo5iTp35LH?=
 =?us-ascii?Q?MkUQUkfvlr+L8hP53/0tTkh9NYcl3boBxchA8Bzs8TPXAtSnXyeqZBhOzB2w?=
 =?us-ascii?Q?DsIjeUQPmTaUw3hGrHV7drTGAXejM1uPn7VvzAb36OFF9NBY5W1xqsggQ0Ce?=
 =?us-ascii?Q?1VzevG09+GU3WYHE92+/jCIerUJwMrfi+HMLB+QpPxzfiLXiN/scWlBazYuC?=
 =?us-ascii?Q?MzW6HOslnTP1lolSwSUYyp1ixtW3PqdFK1jjFPWacs/CMBTFWJjGRD0cTel1?=
 =?us-ascii?Q?OjgqONCJj3gwNpfRl27SLnqZrGqLWvyLb1hM8GGnqZzeW4GEltY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvPTlovkxcV8yMMLZhZdiTdthjGVO1Ku2TP805zcArk4yMUskaFmOsHF0Cf8?=
 =?us-ascii?Q?2cLaAYI56UzLjmW4gzB9F0+9SNg7ONcXnCitIfvniMiY7nirgVbMdZHk4csN?=
 =?us-ascii?Q?iyYAWWrdCFDn7+EZj+tZ6AcA7f87DVek6qA62YCLEOtp1dJfZQPk5HPn+Yks?=
 =?us-ascii?Q?pIQNh0wNT2dOH35s+IsmSIy2v2t3uA6BIA6AP2sr5QSQyqi6rV+KYt5voYG5?=
 =?us-ascii?Q?RzaRVofXT2miQx7qB5hmUgcLabwWwT1EQ+8Rj2V0kmjWkqW5DaYmJcIwLrbg?=
 =?us-ascii?Q?ZTNq0Vsaw1ck41q3OpxRoEZQx8PPmCHp+/KaZ6YP9HWW4VKeb8+SZWHBtosE?=
 =?us-ascii?Q?2gK4wOgKfNwAmioNsJyF42g3RcvfBlHD7wB+JZlWiJ+RvudTI9znXN9si2NQ?=
 =?us-ascii?Q?JLHqzS9fcJJLLZ/DWTliWOxC6SXXPmAxKjtlckPANHC+mrMvaQi844n6I0lv?=
 =?us-ascii?Q?ogvIzP20RP5hItl1bIU6Igp4jKnqpxLrsGQmBXJHjKR9qYXIpTbIF+H4gsDi?=
 =?us-ascii?Q?TNaJWsr9eO5P/4YPSsVZfhLW/qQ2/Vcy+AYScqYVzEI2CjLj3n+fI2Pp18WK?=
 =?us-ascii?Q?YX6WlKXNplSyPUVmY0zfcc1E31W3LN3kSHtRuAufcdvuXksYhyRwPT5bFlJ4?=
 =?us-ascii?Q?a+Aeit4uRQfR6S0v/tDsbdy98jZiPRXV6zXwP1tQkKvIWkWENwLXlaCZzi4R?=
 =?us-ascii?Q?FlaUkR8JSWkvMTs5/tFGYFTolVjyE0syolTE7XVaMFpJmCL7RrcavJ+T6V1+?=
 =?us-ascii?Q?SBYGq19xs8UHq4W0qraYwApRRAnPv5NKj+hS9qYOrF8VO2ENfr4KPPj1j5gp?=
 =?us-ascii?Q?Yf+oqqdwe8iIKdq8OOAtqaNiRylZxXepZiejK7e/oYDtGwyvBTS7+BNO4iZe?=
 =?us-ascii?Q?xCcPdaY1ZQOztP/Y2DzhQpMBBk1fWNu5Jr62QD3DEcBAlGGHiUYdVE4zXHKx?=
 =?us-ascii?Q?JmxFJdQGFRhbQgkXjqb13ghsd0PkY4w1REAkljGzOJGZFq2ZUt981exQMZHT?=
 =?us-ascii?Q?+jQRr2m5up3yb2Izd4ViBBWOFbiOvrtL6E1Fog6uzap5wrvCpobdkO5iMXwM?=
 =?us-ascii?Q?lITmJb3Mi0c6UINtZjJLb/Kz/90FkTvoQ/39Hiw87iR08e2HyZG0rXvHQntQ?=
 =?us-ascii?Q?d3m+uKPyO76zfiSq5ApR2pkZ64wc/hQT/cYya3g6vmX5k3FbDyKO66NwRlfI?=
 =?us-ascii?Q?lDY42R6NVejV+j5lqQmZaVqloM+g75b157n/TA8Fn2v3Gpw1oKKdg3OH8cNB?=
 =?us-ascii?Q?n1UZf1ajySg0sZCzyN6d?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032b97e-4719-404f-4b0b-08dd5bebc2d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:50.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 432-c2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a..d49ff8e8f758 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -28,6 +28,20 @@ &blsp1_uart1 {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pcie0_default>;
+	pinctrl-names = "default";
+	
+	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 16 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
@@ -43,6 +57,30 @@ &sleep_clk {
 };
 
 &tlmm {
+	pcie0_default: pcie0-default-state {
+		clkreq-n-pins {
+			pins = "gpio14";
+			function = "pcie0_clk";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio15";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio16";
+			function = "pcie0_wake";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio9";
-- 
2.48.1


