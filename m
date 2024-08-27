Return-Path: <linux-pci+bounces-12230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E62C95FF02
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 04:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE0D28303A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2510A1E;
	Tue, 27 Aug 2024 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lkp2pY6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC110A1F;
	Tue, 27 Aug 2024 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725459; cv=fail; b=s1vRKWhRQL7CE8fQjx9al4MiN/CrTqNMCO1o9eMKn4+xq0UnqCdF7QNUm7UsI+YQ9FpX5kU1PynT6v8Vk5JqsrfnAh4Mtxmt/bUTamAWjjna2SUro2suMSdkWfQFIMwphVmBSTtIAQsmeCtb6pFIP86Nc/kmJ+eufudWz7UeeQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725459; c=relaxed/simple;
	bh=tNdaFxnFNvWGNocWJXKXTqxdZifpdiDDMykg5de7dPI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BkvSyT/d8XTFoc4xktMsRLWJHu5HpJWp8SW90kM7PnCtq8BYLip9/9eYFp9x0v47EwnUXZuE7vWmr0f8lm/xHAi7SUvC6vniwvZCkRpT8Iebf9IPzqAZO91tt1+CpFMUESRJ4NHjMDaz/HhXEgm7OGhzQbeJbb59Ymzvq83VN4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lkp2pY6/; arc=fail smtp.client-ip=40.107.215.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efRLa1C7Fd/WWqIsnT4rxBnnxK1W3dGpmnhqascIdpVDANU+CoG/AZ3yua1dhRCNXXSPxTrtvmCCt649vJNt414Zqs4p9Id4RUygihq12nBRuml4cRo3a21pFpbRjhF7saDl3vf70ScjHpL0YPw/RtWHZznG3DmmQEhnAzckIGiwQvWBGp2nenavd9IIbu1wJuS5/S9yatmx2dLr+r6yuMvI5P36adPDA8SGGzBO89fzuX+6ACCTBrJikEneVi8siawN1oRePg/rwuAfc5wl/oDtsfu/t6RBTSBSe83X34PZN8LWnY7lZdy3QCJSWa+7AGlHJ3uN7YF9SKCvFLt2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoYgvq7W1xDKi4aaeUelRLoWcgyRwc8HRgFCfcQvVy0=;
 b=Bo9+JjFttK5n7LgeOVIaqDCY5zeHBbL5NS8TF2g/leqOZk01jUfZyywFVkKuxVg//Qz73sT5G30nk+Ngl0/7SXSIVJSYiJOYSqR5vo+9Igmybxiq53KOXLWmibStTL9lh970fAdDbMDWhXFUU+mjjfkOSJL7bQqi8tu3Y/erDefP2VBuQ7z7nw7oorXiD3L8t+hPq0IZWcwFO1+eLgxmeHXSXcmklA3z7umJK+I+lwmul2DrIsrXFzSL+WnQ5ZpZKJ2iYDBwS6A7PXiUBawn9YTsx02e9MPQITDaYsRdw6fYQjFe7W5pp1X7NXhkMeZ12xtX6GoGMwedWa1gRjapFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoYgvq7W1xDKi4aaeUelRLoWcgyRwc8HRgFCfcQvVy0=;
 b=lkp2pY6/IyQXx/PhL8o6kG14li/6mem48Bh2oYqvU13xjnasuynNgRtpoOkhAKqCkLdBIBf01bOprNecqKIMP1LoE37JkkP/CIK2LN2t7g+rXrx9WHklwbmyjFXP8h6bJQVfT1YAzph4ng4D8NE8rt5bODQ+K7Dt3U4YDDFnd/jdvUYvRdeEx5nNzCi5GDJpfhyqRuz0naM8TnUcM50cDyXQ0SSQPgYHbyyR2rNFRpvOBFCBsfEt1egFjff3+UVZP6i9CGWn1HCQ75RbGVlemKEFHDz8GSLVvlIxXDZPErcB/1RgEFKCXifNrGXAxhNg/cWWc9GfbOFw7wiPQcxW+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB6637.apcprd06.prod.outlook.com (2603:1096:400:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 02:24:11 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 02:24:10 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v3] PCI: armada8k: change to use devm_clk_get_enabled() helper
Date: Mon, 26 Aug 2024 20:39:14 -0600
Message-Id: <20240827023914.2255103-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: bad9f83f-8976-4b06-b3a2-08dcc63f55cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?he+OpbQxiZCStnGCjTLvsNfbhHR64n0iKrPnDHTw4NK+L58/J9fTxkVTH5Z9?=
 =?us-ascii?Q?K9QZ8I5NsfFuO4LQQIAoaJvJe/NK2ryBsvPNq6x+/vL8llPkHmmTqe60sMTQ?=
 =?us-ascii?Q?hqf/UaLE6WQxHsmp/QecYQ4wP26Hy3iUedP2Qn9PUn3+lip6DNZGyg84yN7A?=
 =?us-ascii?Q?Nn35EUecMAycoFkNOc+mVU3gmfZbZiNZrmePTatTQW2FbdUX/B1etHuALGZ2?=
 =?us-ascii?Q?EjiAxH/F3JqsL/QJ57+kacC1eLeebMQ6NaCsp6tXz8RGFHsiE0uFFF5n+KNF?=
 =?us-ascii?Q?5nAd6DxT4mSlljfLOVLpZ5HTPx9ufVJyUef59eVuZOhj78xguv0upstSNWju?=
 =?us-ascii?Q?O+B55KVruxDkJymWKkHB2zfRSNW1Rfbxsr8JYRJclzKK3zwJccMOX1cHqOQQ?=
 =?us-ascii?Q?dzSlZdCO4wi3A6td55dTKOw98TEAkW4YDiLpicBJuLUrBkvMRV6QYlWg0AIw?=
 =?us-ascii?Q?1TZMGX6CwY4lde+3bhMH9M1VCYVcEyyLlcTkfEIoheU5wXWR9vGXWVfC8hYJ?=
 =?us-ascii?Q?d/hmslFVGaluNpROPE3aNuxaGXp3kQIAE5xpdrepScNP+pYfXZqmwckmJcRk?=
 =?us-ascii?Q?tnfcycOPfuABaaX3DHhbOA2bM6hWi8mkWxjlBTW6NTKECI5jP+9krNIzkRlV?=
 =?us-ascii?Q?7+5tAVU2D+3c2SENsyv4Vz3mgopC5U4RsAxXNZBJrwRZMISP53/k73dPsrlO?=
 =?us-ascii?Q?lNZE1xaECV0xMo6iddFzOI/LbZIrhKr397TnI4+qP3bpFneRcG91R/StIC/8?=
 =?us-ascii?Q?e2keEZG0jbRL8epLPVXJAsUmNPkjhmrqDGxqcWJfEpukHPoFQbc/0Mn1md9Q?=
 =?us-ascii?Q?K2CkU9lvl3IKrD/PPUsmZqHAuGH6yI8KMfjkSurihYJ96imavh/qVPePZNs5?=
 =?us-ascii?Q?TwOvYaoIoVScwnspAodArOie61/IVLjAgLtJldaYYI5yF75lj0StFmReH2rb?=
 =?us-ascii?Q?CDMUfmbMah5CyGnoWQg1wViNVFypkWGVboRygds28L54kDXyIUK4qyWDnwUd?=
 =?us-ascii?Q?b2ExTwXGqrOd6yiq2TpxerErDtuwdxkMSLRvgFi8e8jdjz1SjS1XScNMNnwf?=
 =?us-ascii?Q?uB6EhZeCcTQ5G2uBSqcWtIOcpko1fCVIauY33YEaNHGtp2Ti+sHluci4cJkB?=
 =?us-ascii?Q?u1ofnLkjyc9wqMuatZBSRbJhzZj3NwM2KS2zODmZcy1j5W7Nwgzt0Qn/H8JW?=
 =?us-ascii?Q?LM6P5vMtZicbwVT0oePJHSZ9FzeFLTKsxc6FiIHowbAnvmWcLn/qNGLmqx69?=
 =?us-ascii?Q?4K0ZHZbwNFjREuo50CEMnEpInwcvHgqcR0ofT5HJsdwCxSOD2daV00Wl2lbO?=
 =?us-ascii?Q?XO+zZmcZIylj9iwD7QgrU7E5VCTw92Oa4nJa81jCPx+ER+wS/cpCSQe2TOKP?=
 =?us-ascii?Q?6z/V7hCoexZoKt2q+6i9/ctcTyV4wVjrYG77RAeoI3dT7RTqpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2NfbPcpIDd45t/lteW3RYVfnI5G9p6CYBEV3FpmS/9fW7qZGEYauK0wssgX?=
 =?us-ascii?Q?U9a+fgdzLfH4kZOUrqgjMsgKlp99Upci0XpEst3KSDlrrrGAp2z9Pu2w4lwz?=
 =?us-ascii?Q?JI0bW7UUKgYSliN1rBwwBN4x6PJeIDjcL25JnV5YGkLNTQxEikvWF/Q1wNdZ?=
 =?us-ascii?Q?/XbwEKT0/zgYibJBXVOZBRtBG8Z0NwUJEb88WjpK30nVIV0eEfy5+8hMoFcU?=
 =?us-ascii?Q?xAXdXbze5eKilWJvCCnS/nYsPnar+5IOfG+7/9gJCCpoLBfKjE2IHLmEeNC0?=
 =?us-ascii?Q?ywwAAeM88BkKgifOMNuq5BBfYPea3g0O5mygReXhFm5EnIQrzfpdjeexasPk?=
 =?us-ascii?Q?7NqSbFSRoUsVACbIS3gn+cNtIytD5s3jjHB0us0OjDtCdQFaUj3d2Z4W5I/8?=
 =?us-ascii?Q?J8y001QH7nPLkwwttToEppE5VZnBtL1jClkSVVOW9b7Kh7U95C2/lVrc/8aI?=
 =?us-ascii?Q?sOyW7tu+lcYKU/eWqIGEYq5mBJPY/Ut1VQ4wnFdctM1pV0pZHiWHBFiNtFs7?=
 =?us-ascii?Q?zmUV4eY115seDif/AZQx6j2k52JHz0SIF0w2pVLLAP530RyhX8wa0caIjkAe?=
 =?us-ascii?Q?FiXgJ41XnnWxN4GCoAnsnBwz8tNNur4E7KXDlMzz7hTH03AW3CzrhJh24OAF?=
 =?us-ascii?Q?lhi4Dp0+YrUF6Oy1X/8BqIwxhr8LKWt10d/GCmdHtgOFf6Oj/tXxNjr+pw5g?=
 =?us-ascii?Q?Q8ehjcQmIRtNtgOyaFdqiEVzHdt44BISPUl2IPL9hrJEAwYReNbPIEHJnF+3?=
 =?us-ascii?Q?Kv3dV+S/4Mxsv7FhjPbzBBd0iAy41o0h2WY6ceav0NZ85H/GwOuja4vNXGM4?=
 =?us-ascii?Q?TTJQijw1VAMMTLjU0/HWlGqyBoApHLtloN6qm38F0rQCeRx3xujRYJ1jluNY?=
 =?us-ascii?Q?5kEleBUQaDiRZ1cNE0fIGfpd1Ha4TQENkbDSZRBHpfCcn07iKcLau6X5L3kt?=
 =?us-ascii?Q?HRaBLdMRH3Tuo8dxTx1JUaLdUnSC2EueWTiMvlDiGiau6cCVNu4lLxk/D2vW?=
 =?us-ascii?Q?WXm7qQMPd/BGmIZGf1bevbrrVXOjMVpBPHk7APFz19sGOAfPdfgaDgKRcf0M?=
 =?us-ascii?Q?oE2QzsRNiXy2HbIfEpQxN9ugiyNNu6JtY9YnhQrmi+berxAlrRak0Uk4hdpk?=
 =?us-ascii?Q?496f1VOiY400fD8m6L0MFPmBtjzCWtXrBdNpfhVmP7rk1ABFr9UmGyek7LY2?=
 =?us-ascii?Q?cpHGTLIeqXBrQR51weO2LakvGB/oWerWjp1d14y7u3MYDHf0fZyiQO9snTNM?=
 =?us-ascii?Q?e//C9/vHMOchciuHIkqVzqXP76MlVDi0IaEPfmNRNYNG4fKNPKRikwYbMbhw?=
 =?us-ascii?Q?tbt2MNPAO4P8XxU7K+zN2G+px48E6KSzgnJ42L5+Sqi/JuBf7WbaF5OYGZWG?=
 =?us-ascii?Q?EK6iPxImVHGOoAnwdARw+KfRhJR7k+y5m4UbL972ckE/99jsL9vnMM38aMvF?=
 =?us-ascii?Q?Gfl3GwEfZfeq4Fl3/nEJK3wTp9cT8KGRZ1K6Vy4R5xa8dhyi+5yfF+6cWqrp?=
 =?us-ascii?Q?h2DmM5ZYaiJWaEHkU6+O3/tT+5JnS8mnXoPKacVz1VDgqvl30HnCxJJwigEG?=
 =?us-ascii?Q?rjbS+6lQnjfh2BeTr9wNAsfAS/zkjvUEQr698HUt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9f83f-8976-4b06-b3a2-08dcc63f55cb
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:24:10.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYK5bsMCS/eXfB0tHv+LBgWDAIq3wPcL2V0NkMFo3jJkI7wl76iz54qqSLhCG8dmTIuG78QQjNu8KBnFRwh/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6637

Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
cleaner and avoid calling clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++--------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..e7ef6c2641b8 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->clk = devm_clk_get(dev, NULL);
+	pcie->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pcie->clk))
-		return PTR_ERR(pcie->clk);
-
-	ret = clk_prepare_enable(pcie->clk);
-	if (ret)
-		return ret;
-
-	pcie->clk_reg = devm_clk_get(dev, "reg");
-	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
-		ret = -EPROBE_DEFER;
-		goto fail;
-	}
-	if (!IS_ERR(pcie->clk_reg)) {
-		ret = clk_prepare_enable(pcie->clk_reg);
-		if (ret)
-			goto fail_clkreg;
+		return dev_err_probe(dev, PTR_ERR(pcie->clk),
+				"could not enable clk\n");
+
+	pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
+	if (IS_ERR(pcie->clk_reg)) {
+		ret = dev_err_probe(dev, PTR_ERR(pcie->clk_reg),
+				"could not enable reg clk\n");
+		if (ret == -EPROBE_DEFER)
+			goto out;
 	}
 
 	/* Get the dw-pcie unit configuration/control registers base. */
@@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		ret = PTR_ERR(pci->dbi_base);
-		goto fail_clkreg;
+		goto out;
 	}
 
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
-		goto fail_clkreg;
+		goto out;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 disable_phy:
 	armada8k_pcie_disable_phys(pcie);
-fail_clkreg:
-	clk_disable_unprepare(pcie->clk_reg);
-fail:
-	clk_disable_unprepare(pcie->clk);
-
+out:
 	return ret;
 }
 
-- 
2.25.1


