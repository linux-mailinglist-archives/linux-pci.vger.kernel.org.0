Return-Path: <linux-pci+bounces-27256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADAAABB0E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE201C26C36
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06CE277023;
	Tue,  6 May 2025 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sJ/D7Bjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lEJBireB"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DD27F72B;
	Tue,  6 May 2025 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510217; cv=none; b=L8+K5bhh2bx274FR7Fd/guleJ9jwceGZ+psv+UwJQohV6OTUOnCYpbI7Fpfvu8epEiAFWt0M8gU1pFyaq8siIZM6V/3GFftAI95C4coVDBEf3JJuXZnCW7lTCs+Dsb9OSbJw7pDtORwS8HFSei9ksFI7aiGSRx88AeYK4WlHnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510217; c=relaxed/simple;
	bh=p1gG8rHPrN+/mU98af/3Pg0YbEFbvPqAkQM0hWL0xdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIx4MgLkt71VMIcRuncZyJa5XTVhqUsgiZ2Ag0uLhMKqZLZYwQOPObk2wZQolPEutfoQCtbKN4xXSb1HjJSyZCGZZj4Y5pDrHZN6KgQVvmBP9MCyyF7WJ6tPv6qQlVLGyP2fkiToh2sArDyV/sX9GWO9dtt70wC2lJk1XlfOS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sJ/D7Bjt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lEJBireB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B4C11140205;
	Tue,  6 May 2025 01:43:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 01:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746510213;
	 x=1746596613; bh=Dv0q1x2W2lfSNWhecXTaGmoIYHt4riJVwOv/fSj1v1c=; b=
	sJ/D7BjtDHG3wXd6Ccp51rjecVwTfPshRx+Krz1vNlHHV0R7YEuwOHJk9nmDhE1r
	xsQYrSbkBqXUntJv8BlY8ZeaIWOljmdNGVybqa61ywbhhSyieQevgLWattfCDPCT
	xz3NbXgmptPGpHKFKAHZA3j5XBpkvGLG24vHCdyoyrjjk3wm4o1qb5n+8ItvOscT
	4wibMryPhnUDXvtM+K5NmUM5YKbR46ABIkwC4ahCsv3jl7Cj35+juCPbSwlGXR3r
	Wlqmup9OtTxbatjoEggxIVqpmH0dMY5sB3ecanPIuKjU/TCGvKX7d93JEfeqyAln
	csLMgyCiXWJUMdRrx/NHJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746510213; x=
	1746596613; bh=Dv0q1x2W2lfSNWhecXTaGmoIYHt4riJVwOv/fSj1v1c=; b=l
	EJBireBU2RGepdG+zyrRUtJ9riurJ37SdSmhX/o74g6U0nA3tKWAvAK+nddoNzkI
	lUbtskVN5c7KSKv7wpdGGnz9CWs9Q5uT3U+NvcQiF7DNJ0xJSh5ViP/A5QloC64s
	d61tTvDKjzRPbn4Y3AXgCaw0BYCSC99Bi9Kdznl0DvjP4mEA5mQGHu9JDLvAvOq9
	CqqNaRQIjYc96B9RhNCXY/KqWP9qQmS/+MKUoWMObpq31IhOhw4x+ekwXyvqarQs
	XsJhZtEdDv4/u70sGx0E0oF+zEb7wrbnkg32CvmqqMZKm4RkMd8BXGSaP9LL4ZHv
	to25UCHcdlm8AMhFaynew==
X-ME-Sender: <xms:haEZaCOLgFwfotuSc8T3SoJIamXAbzXBA7CiGTEcWtvOctin8xMQfg>
    <xme:haEZaA_M9sVSbXS-vxhaeRx1n-9dI_5IgsOPI5aReGZ70PkdOVLFQsNK3IVNHsE9f
    jxOI_-lcp7r5wRYKi8>
X-ME-Received: <xmr:haEZaJS0nhxI2P2v8sDi7X22npv36vgT2UShpEDgedowqs3gFIVV4JYLZmzZcLVogCIcbxB91STr3b3YzOXPfD0dLnYwdSjvbQ6UFUfTLURi_fHYweeOjae1oHKEGJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefudejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:haEZaCtHI9t-Bew3dn3KahEWOoLYtpBWXmH-2ilOw8IMnshjF7jRMg>
    <xmx:haEZaKez3SEBkGUvUoMyz3tmJ3B0sWIr4cHnQTVUIL3ashYHx1hMIQ>
    <xmx:haEZaG0kqIu_hZ3chh3fFCfE2jl5MDjXywdCuciUaHaB0Ml-0MWdTw>
    <xmx:haEZaO8BaxSH-tmSFOW8_qugsCLw7fjkDN3LRiC-U8WXQ9LxMHmHuQ>
    <xmx:haEZaIMsEElW35BEJZhE-NnhtJjooA5e8LZ8QgJXmFo-rhaLrwj2bH5g>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:43:33 -0400 (EDT)
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
Subject: [PATCH 6.1 1/1] PCI: imx6: Skip controller_id generation logic for i.MX7D
Date: Tue,  6 May 2025 01:42:56 -0400
Message-ID: <20250506054256.4933-2-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250506054256.4933-1-ryanmatthews@fastmail.com>
References: <2025050512-dice-brick-529d@gregkh>
 <20250506054256.4933-1-ryanmatthews@fastmail.com>
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
index a3acf144a40d..4f20094faee5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1172,11 +1172,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
 					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
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


