Return-Path: <linux-pci+bounces-38110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97ACBDC40B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0937B18A2FA0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DAF296BA4;
	Wed, 15 Oct 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KO3EcaOt"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBE26E717;
	Wed, 15 Oct 2025 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497512; cv=fail; b=KREcxhNyab4ZJEoXLk5Al0ICmTzjEhvBrj7zVWlEVylQ/hDddOsfcXZ+P2x0qzAREurFHXB9JcZNYso1gLfPzznRrqX9H/Mm5XF2oCBRXCNHK0YdXjSiIOe9+crmEdhh/klLf0nzhcSvZfK69yHdc/4aMamot2BWIE/HAEitSx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497512; c=relaxed/simple;
	bh=0fnZ9ZoQTYFcVrH9aOuAaaYliOLGf7xVd2/YQtVnUMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7kKpEQRjbwdquQKa+hLpeE4ORP3P6Id02qn0B7YD9VcUE9A/m97j9XWBZ5hoWa9yH9xBLJ63WwbVdbKnZy+AAEafmjVJcKa5Dr8g7FovgTpaIja0KVkx4muxpOnEkc+HGM9W+nXec6xH3O/mCCLABdqfJ2uMDpm4/3r7q1UXe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KO3EcaOt; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz3p7vuiw2lKJQChowIEeg9qDtnxUzheS/RLyng/BTzGd4gUXl6GpnJWdf/0uD9MF3Wym8difbJK1zGaiZKsvDYfa7WbU674x+CQr/PxAeIUZ+xLrraUoi8qOfmp9kGrLXNwXeyizz8Wt3f8C4zSHXn/1UQ8CtDi0v5ne5W5/0gFT2LiBm3gyQnPPKfrtKs70MqjM0+22S9TwfiOE9cqaGaaZYDzUSYTdnPV8DyFbfTnJ6XKbc9k0iNwVNzZDeM8lVcjCzUP0tdBhtrnuFHX6V5E7BsPXToGvxUzFut1a3dyeCjgETjSVhgg5kfuYtPY8KKss9D1izg1nhWOfdwekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zD6H2hHb7XqqeyhHdXmvomkzA8vGkQ756sujgMo4xM=;
 b=byu99r1Fr54Sh0sNLoe+asdISytFIMSu5OVjudmJoLIVvVJ8Jy13nWXdq2u3BHMUAY3CN0FvjLLdT8fz8pVcw/Fvb69WBI2gkwe8WqO06zA6mQSUU7jGPOXuHIcOXoYlVzBAgU33PStisX0a/XhT9Q0/uw7TfktzWS2vWxEwcocvo3CqftE9Gqa9q6ryV3hheExTWSaC0YRuw7AFag7y+outMcHWaWwiBlcoYnrn2XIPFMMgparODN2aXWrovtb9FKnc4UqOQM6P0M9TBe8pf0UqpVs+4NukTaOtqQnCcLkrPEoIUMxO8cDrPRyw6xiUpdbJzFavFiWY/f2jVEb13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zD6H2hHb7XqqeyhHdXmvomkzA8vGkQ756sujgMo4xM=;
 b=KO3EcaOt2soyd8PqFs3V1wlqRBzqeJHRkslsYzwn0esPvDWWRWRjE64mjkq6AXXyVyTM3NlGPFAN2bLqIoYayBr389RFndqe1ohqK9NOqp0E91Q5+DXxJhmB7WyaaM4x5b/J4sK+A2Ups1cjSKhS76Isx2q2exl83SPVAdKqjYENFePDzV1KN+x2m8j82gEAtgH82yXJlZ36mr2c8Q8po8GBZNU1IerMSeWOk9AalQ7wKrozsPC22OuMXFaSJKj4tIiQXx9DT2r2s+kepBT26p+zzCaR5hzrYVGFtjRcVB6G7hBZCFbJBJENz5cmPBaj8o4DtyoCJBiGfUCu/3WUaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU2PR04MB9521.eurprd04.prod.outlook.com (2603:10a6:10:2f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 03:05:08 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:08 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:18 +0800
Message-Id: <20251015030428.2980427-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU2PR04MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5a23af-af0c-4753-f592-08de0b97a559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCuFW01l93DLgeAO8jA1TSScX5/cRiw7iln0c+EvMnYWORQBVh6r95TLEsq7?=
 =?us-ascii?Q?ZhOZocXKxJxW7Tca4VBluWEhnroVUQOEhHtAuGvttIrqlwoVRcfV/wBLUX+A?=
 =?us-ascii?Q?Mxmh0JeMT+W8T17VBp0NIe72r07puPFm/pOkOO3tkYVgJWiLB6IBBoTiA8OP?=
 =?us-ascii?Q?Rvng8LlGD5G5gInjYUPETSGcK2x/G+sfdotHIEO+hXP1oy0X4qNt4sfxKDWe?=
 =?us-ascii?Q?tQ5j9lcwIbmeglDIatKjQwc55tycQNE+1ZsiXvUrOG6RwBB9/P/P9R5Zs1GY?=
 =?us-ascii?Q?DvnCFS7Eg0/GMbUSgVX7V+ZqwiqIiP4kkCN3SZVXU9zVPhm82WQjmcQmTcCl?=
 =?us-ascii?Q?ny1Jr2VJCP/KL4s3HiDvKk9HcW9yXrTLRtYAlDTdTBlKwaRW3Vm9N1ZUmszm?=
 =?us-ascii?Q?2b4HOWgyKSpjlmLnQNr9St2axgSRcoT2Mht5uI/BmasJsi4GQvuRZ7watXH6?=
 =?us-ascii?Q?oJyIQ3u+ioVDBNDqE2yGKGDKs1Kq9MVdKbP4ydoLzbPZFZZSivYMUG/h3V+s?=
 =?us-ascii?Q?IrGDHkbtAHXbEQL0abr2+t/x0QZxKuDqM/uAlNayjw043twarpowF7+emhm8?=
 =?us-ascii?Q?5rsXQlc7JW0rmQOdjfk1xeFBqLcAZV21PExN2Zi5+K5CZat1o93tm4qzmFhr?=
 =?us-ascii?Q?ePfWDzgYd8tzQ9ai8W8B3b2CF48EkfjUJ2MBJW4qByfzyAg156rrRcQazfyF?=
 =?us-ascii?Q?bmj5EGrMPA/pvsFFkk9Ri3glOqUQzPsvl0erxefSKr9wnAxznVmg997I27UL?=
 =?us-ascii?Q?vhQElMmI3az2FnkccmqXrr/gH8Zy4hzu149mSF4wwrslxpgVU0pw5QipLKXW?=
 =?us-ascii?Q?ZTF3lvyWZ2xeChMPu/0VZKpLJCZ0m9IbDOul3aqgLkx1yOB4D6GGFKNlf9fd?=
 =?us-ascii?Q?nxgPGppsc32ePnXjZ24Q/Ulp19lQkJ5GyYf2kVFGFxLLFRHorWEjndsJX8ag?=
 =?us-ascii?Q?AAHjy3HEx6PMT6I1RlD3VIs/+yCs5MaB8o34ZKoizwH+KrmYj/22jbApf6U7?=
 =?us-ascii?Q?hMu6k2Ed4E7yMyLVRVa2ftgfziKhfyEdsRLQSuv3h4dZ9sDiusjOF9DXG/r/?=
 =?us-ascii?Q?cW20EXEmRVsbXw64ZOYfiBHGlaB8jOVUi8IY689sclXzBQC/jAvKspZkq1wk?=
 =?us-ascii?Q?0EA63LI/tUj9fk9QZ8aggOas09NEj06uHTmi5AH+tThUm9l1wmplb2NECvMn?=
 =?us-ascii?Q?REenpsR8++d+EEz8Z2yhDrBNy/1bPaw+9Yv6ADRafRRllw4/YLOFUBleWc1s?=
 =?us-ascii?Q?BxyU5evFAbMJw7+YN3FcJ0zTnTlmLOCntu+2luBe/7lor/QFrk8hMFGAHC6E?=
 =?us-ascii?Q?htHjuEnbPRXYNbFuMjaJrSoFnzdiZKoBBIvJGBhj5Xs3pbZvlc6ivcX/CxLn?=
 =?us-ascii?Q?bDm1aozNn1UA3gU3B0/CiAcFqcRKZnFHluq/b8JYJD1kgO/WEby/LKxQQ89H?=
 =?us-ascii?Q?0B2e23tJkFYeF+b3rWQ/bwgcujExrCEI1ULF+i9gaczpofIifiS/1TnAdX4l?=
 =?us-ascii?Q?4cjPh/+r+/X80ozNDrZKS2ZiWslduS5eMcg36/1rPWf0KjjP/rGIWuasXg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gwFEwFUNtpn5nvKRoQmIq/D3wPXoI6HZEYsyxuQ5O8EespccF6V97m/L+T5?=
 =?us-ascii?Q?n5By/M/CGJd4r9/NZE5QqJKwxU9R70PX/KE/KJMkv0aLWOC678yjDMNk+1rZ?=
 =?us-ascii?Q?PQKhiloLBcKkTaKEt/TJeAiWmP7UUN3fqJjYEpuCBJoJ6mzkyd5idPAjTwkM?=
 =?us-ascii?Q?Q/iPkybRllc+OGy5j3yPX2VqYHHSeTxPlnxG7h57l6zo7zUscQVp5BiM+jMO?=
 =?us-ascii?Q?szngcOhsNgq9v0BRYO8jH4Etcd612F2+QuZqDtxJVu+SEJTH3GFNVAjfg3rA?=
 =?us-ascii?Q?6a54hfFrbGpqTSB7BRAEDr/orIBpBPZ4/hJ8GxFerTnOKy+ovu0jJAl6503S?=
 =?us-ascii?Q?2XB7ixaQHIFuM67sbibEkXtVCU1YIt73GYZ1Yx0R+Twp4hmHaUb2vby5qcdS?=
 =?us-ascii?Q?Ypdyt8IcysXNZrSqMswWHsvtLvODEq889leE1KjOqbjSrhk+vc03uQBQkhsd?=
 =?us-ascii?Q?G11lxF304nc+6NiwDkXEZVDZXXcUZlfwhJPfO7jDfg83QromY6e0EqZQJdVQ?=
 =?us-ascii?Q?sRZvU5ZM5giZaqlBnwF/yM8QWV/ol3/D+UxGFl/fscIJ49Mu9T9d7FRkyLgF?=
 =?us-ascii?Q?FYGI3mpjYXv2kBe4jcMD39bEa8c6aW/8sEzSJ7Ql61q0GBNDFz/UH4yS23R4?=
 =?us-ascii?Q?IQH/nSv60/VIlUOEo6bslZKFpkepqmDKiGRYHlhdqYpOQh3U0oJNwankdH3d?=
 =?us-ascii?Q?d2Kl1lFFMukJefOSIThRKKvaDMbTciZ98cOkMChlRKTmDe+WVz1D7LE4pa7H?=
 =?us-ascii?Q?JfAf6v1XwuqFUcAAizwoygb4Qu5xMgD+HJ7sm+7md1wQR+vrNXfXPmHw9Xak?=
 =?us-ascii?Q?bzU246u0GRILyF6Kb/xD/iT87OIFKDaI9kaIV7j9Qd0E9OI2CD9/DHogb52V?=
 =?us-ascii?Q?o0/JSv90WkUGWWDFtKjplNFz1LAJY+1cGTpeu2v4zZCUF+ZOdFGEGoq0bAuq?=
 =?us-ascii?Q?z7sbjFSCgSi+43l72dPC2PzxfoE3j/5dOoSTaO295ODdgPiRKIjh0MVj3kvI?=
 =?us-ascii?Q?RBnxk+YBcO71JG2Wrng+lK2vaYQnnnhjK895wLvM/J5xVoytZxAU84BQ6+fV?=
 =?us-ascii?Q?ydDf/umMN0hfzB5gnYc0yeh/oz4HqzQi9VUFpWOhRaBpfrQmTqRFP4aRswPZ?=
 =?us-ascii?Q?Oenu7eLtc0SbjwrzmtJyjS3i2XE4P8Xe/djZpdTEJRAbvVUQ3nN0bgvVA3RR?=
 =?us-ascii?Q?HJzNDwe2uWpZ1kcLHw6oPg/mELTt6QRk248AJcTgVTd3p/gmfpK/eEblYIaw?=
 =?us-ascii?Q?gxBYmn7YQI8fzG08w0R4rJ+FCPHGI437Lr9TtuotxYjCtSrLnY2AOzmPyRyO?=
 =?us-ascii?Q?sq2/93jzp4lD2ExY/1YdkksiGtAXHBu0eMORljA2528q5F3Z5vxeaKSYzqz/?=
 =?us-ascii?Q?GZfcPqBnoIftVllpzwWpSxLJ05utDIgcYozxR4bQIzhryjnplsQ2jtMcUx3Q?=
 =?us-ascii?Q?oiyfC4nX3de8qWYbHjA1GwwASVag1GV59282hsofH5TLUTVKPqCjB85xb2+A?=
 =?us-ascii?Q?Jwsc5HvPwFiHY3mvHZA2HkRQisnkkXHF0GN/dbm+oMNsjv/YDdaca60VjHJV?=
 =?us-ascii?Q?jncCGgQyC/HSaLmM6jg60NsSmYIyTCHgixDNBhmF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5a23af-af0c-4753-f592-08de0b97a559
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:08.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R29VydmeVEP48QWBFZBRr5EqKUgrbqbBZly1mYoHiNvO3mDMgg64BBi1Vsa4Q/58HwVyaaP5FZ+JODym2srOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9521

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx95-15x15-evk matches this requirement, so add supports-clkreq to
allow PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4a..3ee032c154fa3 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -556,6 +556,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


