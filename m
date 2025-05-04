Return-Path: <linux-pci+bounces-27123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8EAA8921
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 21:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04902188F417
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE514885B;
	Sun,  4 May 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="r9X+Ypzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGt3+kSI"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C280137E;
	Sun,  4 May 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386143; cv=none; b=lvk9LNiTTOTwJq+KxUvV2gCshibwGp9qPoR5S9i1W1upwPBaKD6WGE+tLEXU86YtiURfwNaji6rohH+fYAuDgL9viSQGBRK8QS/0i5TwMAbtO5dLYilY8qWDaittY3KT6WkLibFMc+88E2hOlSHWv4bRxnOsBwjdb/Ll6Unl9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386143; c=relaxed/simple;
	bh=wCekXqbY0Akt7yHdTHgLX1PhHKMtiY418Hrw89g0ZRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyC0cddsMgXkNhVidzD73b+V6DXUGKRcxhrvDyTcb0xtxh1Ll0IsZXQoDmkMOT+BF7Fmp0vv/FIHEObgpuex5WE+mdWF+7fmTQWTmuKxyQjAPgz6SNYs0268IePYD4HXQwiVH61QhNqSaD2ErwOShZ64t5Q4t+5e4Df+yuBAfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=r9X+Ypzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGt3+kSI; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C43011401BD;
	Sun,  4 May 2025 15:15:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 04 May 2025 15:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746386139;
	 x=1746472539; bh=V8ewhzHFrNA1fM3QI109IbJqu79a9n0Vi02n10hE2c4=; b=
	r9X+Ypztjm7tEy8GKYo4yuE0XlQnD+foU5eK2u1Tk7L4Fro8BLW8GT3bbKtOF/pv
	cdhmFCbdQtKSgmxAc/IV5PskKuXo8cH6GtkKW7queXEZPlfRIk4Uc1wNG/LN/iZd
	X/sMb8MSSehF3NHxBCfWtNFCvXK7JxPCkKlU8YFS1x9yhYOo9aJ1Jtd/GpFr4WJ2
	xao3X0GE+pzfzGVtrjhBnAnmUfI5mV7RqLpfEvJH6l2Hcom1PcyJcxXLX/co9u/I
	D69CyrnqW0VGNNkW9DhZphvFPgP3KNM2nNiQ8MQf0/lVrnxAKcNp52Ud8CG6Gn50
	aFyFrQ0HBRPRr+SgYw0ApA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746386139; x=
	1746472539; bh=V8ewhzHFrNA1fM3QI109IbJqu79a9n0Vi02n10hE2c4=; b=s
	Gt3+kSIhDrLCI9Aj9/6Op0uC914CcIHiFOLtuRE/xZgSIG6yTtg/fQT2SqU55Zuq
	1foncjd9jEZuWoHlFbXz7tk7zxm/rTLnbRkJL/DHDf8kVo3lKrmc7opF5l7Y7PMR
	5WtiS003towd/5sxi0NFQcE3g07nKxYix0k5RAzsnW+oV0kMkskJRIBpPii9NBAU
	dC30Nm884tIoNV9RCONCscRYNn0+r2ZrmyBFIjeYogsmLnAF7VxUmgbpEq2hrhD5
	BoIScTf8ExcYsCRI7ScHs38F4QpMjR3bUcroCkvTV9viEbLVaA7R9yeQFEKo/8i2
	kZvgoLBVD6MA0SEdA092Q==
X-ME-Sender: <xms:2rwXaDW-mbCeV2hMJBpW5v0NsdASEtajSjz8s9ijSsoI2HvCDVua1A>
    <xme:2rwXaLm2K-kFLj_vFHbC1Wnc2gSn1dBeNZ7h3dhp_ixpJ6TYv7gXc2tXUNIAH1UVU
    iRhMt2NZ1DKwCOY3I8>
X-ME-Received: <xmr:2rwXaPZas2Usrue8B2cKBT-O2n19MUYETMUARUSIOx6qJsbEL1jEO0COPD8U4_i4tLhEWke2O1G5abopD28xO_Je5s4DBY6iMmV4Uqhk-AGhCF6w3PeZw0WqC1hbdhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefthigrnhcuofgrthhthhgvfihsuceorhihrghnmhgrthhthhgvfi
    hssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephffhieeijeevfffg
    veelhefhvedutdelkeeuvdelteefveekleekuedtgeehffejnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
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
X-ME-Proxy: <xmx:2rwXaOUqwuQVWdlnDepOUr5v7KLdDh6UfmRLDCcTBQ-qw3xh3Ztu_w>
    <xmx:2rwXaNnFlTaeb7D5JdzfXEYNtvrVbjFG2Uy5crM9ZgO8fKWwZDlfVw>
    <xmx:2rwXaLfPeODiQzUATEddGurQbnzx8oR0TehSD65yI0Hqh0TfddSSGg>
    <xmx:2rwXaHFsYL9xb0iBy6H301hx00sKPsCuaZ7pAonwFo7dvBgTrivXdw>
    <xmx:27wXaOUPqkjeol6aw8z__65kyDqIzku16k83wzU5x2CJS_GuAxE8EQM6>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:15:38 -0400 (EDT)
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
Subject: [PATCH 6.6 2/2] PCI: imx6: Skip controller_id generation logic for i.MX7D
Date: Sun,  4 May 2025 15:13:56 -0400
Message-ID: <20250504191356.17732-3-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250504191356.17732-1-ryanmatthews@fastmail.com>
References: <20250504191356.17732-1-ryanmatthews@fastmail.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 20c8f2cba453..cedfbd425863 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1281,10 +1281,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-
+		fallthrough;
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-- 
2.47.2


