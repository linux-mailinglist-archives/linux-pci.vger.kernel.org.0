Return-Path: <linux-pci+bounces-27258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA819AABB0B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CC950192F
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66043296FC0;
	Tue,  6 May 2025 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fcYnrrD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3ZbgFFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48065296D38;
	Tue,  6 May 2025 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510264; cv=none; b=BvLURyKuPYHoqTnZCq9kJoUamoaJ3gwvfG1E1Ez9ALtskg3lndjuynwDPzzh43ghfyJUw1YB7c9xA5kl4aS6znyXYVoSUmQKMNmjLkZlWo8SFY1iPVtMqyEHff+zFbruWLAPIKh3KVFOoZ+d9mlsMMbxujItGSj0DUwZWeXHK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510264; c=relaxed/simple;
	bh=d0I5KRmaORUOIir0Bgzzoebklxsq3c6+LDEGa9FxNWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrIpTzNHBVkJQCP3lekSK+HD3kCZ4FPaWxPAKdKwdXPIEaPtI50tps84OxRJDikZwwv47ex8OSoM/I2dq54eh9j4TGIGnx+ti7W4+1TpF+HZ8/MYmajqILw/G7ElPXEBcYZ4hjypHRcnfRVZV2i6hhhAoi5P8gKXeb3gM6YHJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fcYnrrD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3ZbgFFb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0682325401F1;
	Tue,  6 May 2025 01:44:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 01:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746510260;
	 x=1746596660; bh=Fanrrjrhf5q3I2hQvI1PLFZkTUJuSGR3rIM+6zfely0=; b=
	fcYnrrD5ubrbuF+2bZD23uKUgQJ2nDtLw1dkFfyJSuLBHWH1XaMKSopeF8rYPer7
	CySY1eV019wIVanYBLU+2suRfmsSUe2TDzou3medXPLhxXnC0v0a2ayz/8PSC/f/
	KdzDvN0pocwH2O1Y68O/lYtxm61436Pkf+Zf+3jwel8pZvExjSJOHJEPuFTL/3TA
	z8uTIMAvcwMRBgc4Fj0iz8g+p2EqYyhRHyHZFsE+aQdiPbsp0RYKxeesq8/N/3QN
	0ptirqZ08QofO78/VHHLR7H8ufvH3JNi/Fb3RAoKx7CofJpMt/HcUlD4mFsxLCKJ
	3pqF6PZb3fzoZuYH2a3LMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746510260; x=
	1746596660; bh=Fanrrjrhf5q3I2hQvI1PLFZkTUJuSGR3rIM+6zfely0=; b=i
	3ZbgFFbD6XdT98vB38QErPrjMohDDJVqnpW5VjBmHCalwWGaO14LPwSdyn0bKjdf
	zHEGtEDtIDbkR7u9WwyO/6m/4QN/xzIk5tyohFk5R4JVYe0EmcuFq9+e9ss5eFu+
	IAb0Lxo8mPEY8TFthZrWsARU+1x4DHeFPyTXUH1K0AUXtU1g8hMyYpP9KNpyftjG
	VcL+jIJA+AXy5a2VBdPbyk3WWt0h/AQ1ZtlE9hExIT7eaqLcHvCFoseIznk5I7vt
	6plDsE1QdGPIg54/SdfaymCOTkafztcSGDWfuoxBxurXxAQna1150vW/g22iP4Dn
	LZIiL69VA7EexMiBLuj6Q==
X-ME-Sender: <xms:tKEZaGPIj0jn-rwcgVgO01g6h-MI9vJT8YV0FCtitDQkZLZMHN4LvQ>
    <xme:tKEZaE9ge_AbxJoGzqTnsTF94QcG-7adAg0k444C0oDJoHPQ7Z-n3HXqu8tXbl1dE
    qTf94rcj8VoSz6ixSw>
X-ME-Received: <xmr:tKEZaNRTQ39EgVlWqkZ4r3NFl_PnAW5w1B009-Y1Zto3NYt5pTNKFeja9Kex_xehwyogmk-GIaBD6yp1RuZdYnMMve5R2Zk06oYO2PjMfPw5CROLGTYgjXYdzdefZ8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefthigrnhcuofgrthhthhgvfihsuceorhihrghnmhgrthhthhgvfi
    hssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephffhieeijeevfffg
    veelhefhvedutdelkeeuvdelteefveekleekuedtgeehffejnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrhigrnhhmrghtthhhvgifshesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhhonhhggihinh
    hgrdiihhhusehngihprdgtohhmpdhrtghpthhtoheplhdrshhtrggthhesphgvnhhguhht
    rhhonhhigidruggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigrnhhmrghtthhhvgifshesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghnihhvrg
    hnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:tKEZaGuVThH8Rpd9BZA3ZDKDtWvhN0cAmmgzq-KhUVy-4r6RZ_atRw>
    <xmx:tKEZaOeEm73xzJv61DMfXT96LGODM3pd_hchf34zArLTUGihzDmgYA>
    <xmx:tKEZaK28ecz_vcwttsZ3mxkMMwZNAVck_9ZtXHlZhHL0EjtcFPmMvg>
    <xmx:tKEZaC9Vcte7ZH2lxTnouUNIWzIeEGBIH6BcPezrF3uOOgm7wClMtQ>
    <xmx:tKEZaMPr14w1iMVibW1cq8E6CcBzWUPOCZx-g_m2F0er3DadbS1F1mIn>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:44:20 -0400 (EDT)
From: Ryan Matthews <ryanmatthews@fastmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ryan Matthews <ryanmatthews@fastmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 5.4 1/1] PCI: imx6: Skip controller_id generation logic for i.MX7D
Date: Tue,  6 May 2025 01:44:06 -0400
Message-ID: <20250506054406.4961-2-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250506054406.4961-1-ryanmatthews@fastmail.com>
References: <2025050512-dice-brick-529d@gregkh>
 <20250506054406.4961-1-ryanmatthews@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit f068ffdd034c93f0c768acdc87d4d2d7023c1379 ]

The i.MX7D only has one PCIe controller, so controller_id should always be
0. The previous code is incorrect although yielding the correct result.

Fix by removing "IMX7D" from the switch case branch.

Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
Link: https://lore.kernel.org/r/20241126075702.4099164-5-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[Because this switch case does more than just controller_id
 logic, move the "IMX7D" case label instead of removing it entirely.]
Signed-off-by: Ryan Matthews <ryanmatthews@fastmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 30c259f63239..86cdd27cdd3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1112,11 +1112,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "pcie_aux clock source missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
-		/* fall through */
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-
+		/* fall through */
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-- 
2.47.2


