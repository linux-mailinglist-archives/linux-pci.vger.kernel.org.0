Return-Path: <linux-pci+bounces-23707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82863A608A6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1824A7AD4A7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77317084F;
	Fri, 14 Mar 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gXnTSy3r"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2063.outbound.protection.outlook.com [40.92.41.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41881779AE;
	Fri, 14 Mar 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931854; cv=fail; b=j/5cpQVg/bCpheV8jFSdQiTFOW/mIxzGxhX8CP4NlgMXxbrjTBMBoqMbuc+KxPXwpikvHWFtlg1/ym9o4TMBFwHknuUTnq8eainp6TjL/d5OAlQySDPGtjs+IF7mlnN8U0e1d3wsyRriBwa/Hm1eEJdJI+7HlpISU95KaZA2KkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931854; c=relaxed/simple;
	bh=OKZtpbDAUx5nwdk5frgoeDi85rcTaszui0IO0NxPZJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1O35BAcUV7zV9XaNFHV4xaWUc6DbML9P4ywXn5h1GU00T5WpJurtPAgSfL5lz6ha/YbDeM00sOqU60xB0FAguhBmtHRn5GLlpnfXZr2tOjZYhbOJDGNbG+MBLhoFD732CtyqW5IjSRgt/y5fcD878EAZ5M70jPamuHp8ZaR70s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gXnTSy3r; arc=fail smtp.client-ip=40.92.41.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rjjx6VZERs0YyUxJeJ1tFG+O9qY+CwEFonomXwglSgVSxXQsp5IXQQf5zDivG7n/aSkiVmgaYcc9uq1T1JrL/0psAsHep7aPMmaWHGJJJkHs5Yg/zFv9zy56y1BnRs3kENQGcbwjVn4GZG+Zx7bf6VozMfjC0/ZPo8i2iqb2MeCKb3hb2njQk1zhcWpSIzk1MzKWUd9hcUcsfPlJJFXZlja3si09N5NiHaSuoiDTM12OrEcRWfARhVUd9hwHF71tpaFmD3+eUIMFhzj4DOPOP08U042qvJDOrqbQO4/DoC2EHgU0NgRwpCQWLF3ToSQZW9DiagXunYSALgBKz6BcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvPtXOMkIC6gnUJ6kvVDXw1M2PwIaR3tfl9e8ublL9w=;
 b=tikFBXpjZ7nS2bDvHEY2YC+1naUtVD1B/0yHE5VOBb04XPn19KyLmBYUPPCMML3K1CMDoHhPB9vqPS+HC1Oz7x7z2WpepvmL9x2mRaJaIMLmcZFEOQIr+iYwYXDs/CklXIllp/aR+h3LIxLe7nFWNKrOO9+2fhnrII9oeVIsyDlF2gcpJPjgkS1uxaA6fHqdTedKuQClY9Cui8xRYEidWYVRnpjKM5mMs6NwblbGerTLo4rGLRSCgO/DXber8jHlna8ftaq6nqKPR5BgLzAGctFcDGUKVDnkTii8vN3DIsnNja4ZKAhbsc+5aFCDbC0duCu57c8cX5V8B6Hgd2H6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvPtXOMkIC6gnUJ6kvVDXw1M2PwIaR3tfl9e8ublL9w=;
 b=gXnTSy3r7qgo4JQv/qeBSTs+7zJoW/ADKeuzMlNISP+x4yspYVD0X1uIqh250WQauXN5+V9+imCOar641NYz1uuGG629bjESFAveyMsl2fRNcI7JD+pZmjC+RBajl4qQNg9wXPPDUilLDfoRhPmUAl2oQ3P0Y4/zsA6CguOupKKhpQkjSsK0N+ku84CsE5hiGf7l6fAZs7HHabLY/RKmQyqf5+DTHYaWozn+0tbTMXoDswDdIlcnNFXUcFDP/mkV+U9rUST/iZuyfrgr+SNKBVmhAb8pSwmE/Hb48EqfxyckjLndu/F4GRi3oLMqjEeSoygiQgT4mafp3jb2nkQnmQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB7795.namprd19.prod.outlook.com (2603:10b6:806:300::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:57:30 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:57:30 +0000
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
Subject: [PATCH v4 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Date: Fri, 14 Mar 2025 09:56:44 +0400
Message-ID:
 <DS7PR19MB8883B7B575808AA095C9C9069DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314055644.32705-1-george.moussalem@outlook.com>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0060.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055644.32705-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 30516091-2cda-45ed-c12c-08dd62bd1aff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|8060799006|19110799003|461199028|7092599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29EkTBlZjNamxhMVYcotNcauxrOqLTlm3MGu6pcTnj6jtsX15BreF+gBJBWQ?=
 =?us-ascii?Q?dbjXIJn7yJKuV30082yjVk1iyO5P+QDZltIhedULrAJ9hHYxb94hnRVUE6WL?=
 =?us-ascii?Q?OQe6pZxZCpDasAw8qxpgg2XYrSzo6ZLYjySodOJACcLt7CbcuKOYb7w4G0ie?=
 =?us-ascii?Q?2NCE8j3HfCU6ReY8YlNqPSd1tdES5UlP104QVtmk6g/qRs9eXBMG8CiMxuKo?=
 =?us-ascii?Q?x1TvcsxlRzdj0VORigfgvB5adEwSuWpcElhfs+2lFJ6jKC1osRYoUQsJr654?=
 =?us-ascii?Q?Na9JVewUM8XHXnQZpekbVotGnRk0otYcgVXPCL6FAbjlw1xfhBkzTCUkpht5?=
 =?us-ascii?Q?JIVuL3+KszQrOFzV7/jHtwQX4Kb/VuEqIumBzclkAIFL3sMyn2uzYS1IPgcz?=
 =?us-ascii?Q?C30f52SPz6Gy1imJDKrfCuL1CcZ2Ybd3ZfPK9v2Hd6uorpZ419MsTran3Hg3?=
 =?us-ascii?Q?tWN7jLYiD2pbz3QTTmpfbWPy3hvPFEQdSYXzzfUFVI3scmcHNceF1BP4U4Ie?=
 =?us-ascii?Q?8IyGbCna1yqtLqV+xgEQPHlUYPKHl/9Kwt7pnDTxOt7ZjN/mW7ruDujJcZWK?=
 =?us-ascii?Q?whwAXbudYgJNKtn822LaJWv8xW/+chpcYpFu3ZsiXULpAD6OugyZdMQ4plJw?=
 =?us-ascii?Q?6CRJOQSbiZhedqUeInQDllKHC394uvujHWZfdamqJ4YbvY8WtiLPKEqzJ2xC?=
 =?us-ascii?Q?U3GFNcW/XHT4pGw59pCgE6Cql92+quyD6W0IhqJ4DGlpQvKtgg6+v0MYzxT4?=
 =?us-ascii?Q?2dITU8rxe9LYwZ1jyq+98P0H/+4QWKwFRZTV231lcWMjT/blLKdZXz+k3t3U?=
 =?us-ascii?Q?ZRARoRJgdRKnyXsN1oqRtAZGF6d42xT8FWrJatXRuA2SI2vFjTIzMOXGqM6O?=
 =?us-ascii?Q?3nDjX9IOwZh0wtFLhCv7mDi4zJhMJobAu4ncwacZ7XVJPmL5I9HYFOaF726a?=
 =?us-ascii?Q?pxvx18J0n9JY+0ufEXlg6VQ7vnAHp2cnX8DhHWG9Wn06yNQtz40M7CIeKPNf?=
 =?us-ascii?Q?g9ik8Lw4lAfqXoUxoIZPyurYVR6n4WA7ju99w6gKr40QhxOsgoBEEsC0uqJq?=
 =?us-ascii?Q?D/Z3mJboo3zqy5pfCsgN9VaJBaC+X9Dx0jWa89GcJWB6YIuORZQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHvPrCEjbMQj2kBk2A8Ys5CuefBleBMYfnSecwEEEHKhLasH7lJBrrGL8FtK?=
 =?us-ascii?Q?zYk7Yp4+M1uDiACHqq3lPexGmAQSfwCz7/C0c+OBjLaoVKr4cfgggvVi6ye7?=
 =?us-ascii?Q?9dgs+6KNfmNWmXkAevBSPo2jzmDO8TLk+IeGuy9kKt6jik+GOuSdRRdAgjXp?=
 =?us-ascii?Q?uEGGkQNmDw1f5d3yFAF/kx0IuDDaPicxk0FOzdyO0CNhARUS5nuRl/XIMpQI?=
 =?us-ascii?Q?omQtFm9ne0xj+x5uNAtoOCsdWAgeSNvSakQzwIgc1qHpmp0Xmz+IZWeQyWat?=
 =?us-ascii?Q?W5JTBN/7s0X3hfzZjteJMmh8lkcVALoqVrg5sGupwTJVJHx9Ec7hiCD69fzM?=
 =?us-ascii?Q?f1v/4f7x3VLjf8lYHeDinnFnFWK9B2XE0DuuSivBVBScTXL9yfLP9F5Xp3Z9?=
 =?us-ascii?Q?aUB0ZKjuvQLojSj2r1QO3h2r1qzT/zyYwHrc1CcE/DXNfgAjf3KuvRj/G7k+?=
 =?us-ascii?Q?jUY3joFpRZUN1RXM5IKhCc5N09LuJ31w02i9SmN9UqHfkkXtWgvYT742fOZs?=
 =?us-ascii?Q?pdZcBAH+GEx2vGDuATJ1MQKDqufbwO0ZHuUJ+LaUp6MV2r3qkCIfrWOXX/et?=
 =?us-ascii?Q?Uk053szlO5vzid+YcJ/oTb8tNSJ6zGUDKl9N2U8z2naq/Dn69EVnHiPWAoL5?=
 =?us-ascii?Q?isrG8C7ck7kb6MnHKYswNZ6bfQCYYHovlaDF799ZTLdcdC2HjHBLpPCunT/z?=
 =?us-ascii?Q?GqqEPWRQol823TL4/7xcLh8e/7TJEwqg046UU25sE94WIPKbZTEhNSiFCbsy?=
 =?us-ascii?Q?G1nA2OZaIj58yakHmWkVoOGyTe9vM2J7WgSTCpqOxf91y0s59QR2UJLMNhi9?=
 =?us-ascii?Q?FJBwtblp1bHzVmVC+/2I/wF7XIwyrqU5cfpjTRPcWj7WT3L1HzvlzFjxqNDH?=
 =?us-ascii?Q?Jk8lo4LbjHh/HLnNiV97/k7VcZlWvNtZSEEZxBrjI8ehbJtTIuEo+WhwvYwR?=
 =?us-ascii?Q?8SRm3xZu1gKcNk3w3pe13gXpgm0dH/RcLQ+8rD9iq6LsUEOaD1++iltLERMZ?=
 =?us-ascii?Q?B8DyXuuCxc2eCQuC+i6VYeJgoxmjClngarDRJ3+++59FcMn+MD6x65vPQJEt?=
 =?us-ascii?Q?OheHOIFjHK2CmnXqyTBRW5OIK1IOl/nadvKyeMjEqyQXjo/5SqkBbnGbKPPs?=
 =?us-ascii?Q?Tzd+zL+IyBDGDD06nmlAACsBzm0t8qlTIOHK80fKjfz0pfRx14WhwJVf1ui6?=
 =?us-ascii?Q?mQ1nIdHbvSflupxWwhhdQkdF7En1jx2OxjN1o9w7UC6BlAs3DRFNQNjreveS?=
 =?us-ascii?Q?6QGnINZ1j/MlEUUghA6t?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30516091-2cda-45ed-c12c-08dd62bd1aff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:57:30.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7795

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 432-c2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a..c5c248435a91 100644
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


