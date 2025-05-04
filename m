Return-Path: <linux-pci+bounces-27122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E445DAA891F
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421A43AC090
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3625760;
	Sun,  4 May 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="k7OaS/2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcQD4TKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9D14885B;
	Sun,  4 May 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386125; cv=none; b=b8J0j4EOqGz6jN1h8xlomqDEZCF3Ev/Gx8mLRQMKdtSzFs3NEWo6eyl5+rgt4QgmOd9qBRvCK3MsJd4GqknG82uCCfHsgSp/yyjEOy46EdsgZCz+1n8B4uXVpraH+fqo6vLk9UHvryaxquIvNLei+F7RcJG8iaiDa1AqKXX43Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386125; c=relaxed/simple;
	bh=/C5bJUymKx813MtjkWgl3uiNYlLR2C4f11J8PGhl+VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYAFT6rjtrgyUjqqbnhfnx9uyBTVU5ETK8KVGLslFwVTGz2ZHxzUM+joyKbiR57Gp+TkowJ/OF9CjAeyDUUaau4a01pLzjHlWEKnxJt1hgI/offjpsyxLMQQm0/C397RyjD7eMEArplctR0dOgWh1dHt2yjnU0yrK59hm3542Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=k7OaS/2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcQD4TKa; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD8C525401E5;
	Sun,  4 May 2025 15:15:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 15:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746386121; x=
	1746472521; bh=cJ7KTcTvYGV7WGgAKqJMyoj82lC9hAxixmEHAzO8t2c=; b=k
	7OaS/2H7KUXnBXt8HkOXh93Vxc3/rLioErDI6mTamzml4sHJeon9X9LJMXdcmURn
	Bw9Y7XbFaOxuh3GfUx+STFlmTY6bY+FNF4+82zWtY+A4d1Ztm/OGdbh44+kE4un+
	NDgnaevr5iz86UJmkEZiIhSOrROPqr3XrlwTyZgWLVO7h31kKPSgDRRPxXOMj7PU
	lXrUIEffbmGtwQhYve7u1UTmK/2xQaReySuwWp8CdVuNZRlg4J7Sjygkfr/50aQg
	Fjz+ZtxLKFqymHub/2AVwhsr7wDDNHfDBJT9v7WVClpvQ34YAACWz81C/XTZ5Gy+
	cGvGdP8Kxyyx7J5n7Wn1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746386121; x=1746472521; bh=c
	J7KTcTvYGV7WGgAKqJMyoj82lC9hAxixmEHAzO8t2c=; b=HcQD4TKaptnwb0B8t
	prTI6ExpPaHJNWHcBjBraBqPNHYZzOvbuSyO7F5JtiLGLUDXYP/RfqyKnbtfxSpk
	AeDMl62x2IX7VV8o0QUNkgAPHL9CcBkJHrCCsR1Q0c61IzVkFUacZf5vFLpPzoNn
	pJ9r8fHCCKpg4mMcS/Dy+v1r8+PF8xsnpHi+WgoeLXmI7MG1dHKiA8rvkL8VdZRr
	ciFJ4bqzjgyFCjOSImdBgEfKy8dCpJlAv3fA5Wni15lM+RHVmdY5zFsbPjYV5125
	b/uy9dzZBK8iU1aIXWAgNJBrDzxllK5KVaM7XfPSx7UBEfOi6RNZw0ToBEQR9tud
	ryMjQ==
X-ME-Sender: <xms:ybwXaDqyTL_RlQgE07skQ1FmDWk-dhiYZdOY9K-JpJBM6bLnfC0GbQ>
    <xme:ybwXaNoaNj1ctL-vsGZP-StEj07SIKu-O-t0bftw2NY0Wcyw6Ak8TUgwHOq7-_FvP
    -cbzsmJ0aJn7wRDwZ8>
X-ME-Received: <xmr:ybwXaAOjgXDKx-LoPERRD6_XJJbUFTXLPmIVGniaiC_ho-nVr5PeMCsfD-r8tbAfpQpGZd1El_ME5pG2XAHVFKiSxvaaevbWaKycUxS5GIQcpVeoY2YTMBlPNJiNnHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheptfihrghnucforghtthhhvgifshcuoehrhigrnhhmrghtthhhvgifsh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhuedugfehfeefjedu
    geeuveelvefggffgffeugeefvdfhjefhleeiueekjedtueenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrhigrnhhmrghtthhhvgifshesfhgr
    shhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopehhohhnghigihhnghdriihhuhesnhigphdrtghomhdprhgtphhtthhope
    hlrdhsthgrtghhsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehsthgrsghl
    vgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrghnmhgrthhthhgvfihs
    sehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:ybwXaG6GToXBcd_E0BEcC7v8z8Z6ZTR5kclMka_DvlJM9z4VDY0NFA>
    <xmx:ybwXaC7V4dzsnCRts21wHBVts_pku9PmbMYdsGjdzzO2vCQcQYFibw>
    <xmx:ybwXaOi0_dwIcmcKZxzc0ixDtodPsGoEdGl1Mfob_6ZS9mDoxzV4zQ>
    <xmx:ybwXaE4IDHEUML7z7P800o01SyeOMA2MKicwzbQds9loDYt_BvCPRw>
    <xmx:ybwXaPpnxGG4DXy0lhRLS2mmYzMA9ia6MRnF64IDWgu6vIQgmTJSdLCP>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:15:21 -0400 (EDT)
From: Ryan Matthews <ryanmatthews@fastmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ryan Matthews <ryanmatthews@fastmail.com>
Subject: [PATCH 6.6 1/2] Revert "PCI: imx6: Skip controller_id generation logic for i.MX7D"
Date: Sun,  4 May 2025 15:13:55 -0400
Message-ID: <20250504191356.17732-2-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250504191356.17732-1-ryanmatthews@fastmail.com>
References: <20250504191356.17732-1-ryanmatthews@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2a12efc567a270a155e3b886258297abd79cdea0 which is
commit f068ffdd034c93f0c768acdc87d4d2d7023c1379 upstream.

This is a backport mistake.

Deleting "IMX7D" here skips more than just controller_id logic. It skips
reset assignments too, which causes:

 imx6q-pcie 33800000.pcie: PCIe PLL lock timeout

In my case, in addition to broken PCIe, kernel boot hangs entirely.

This isn't a problem upstream because before this, they moved the rest of
the code out of the switch case.

Signed-off-by: Ryan Matthews <ryanmatthews@fastmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 822a750b064b..20c8f2cba453 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1281,6 +1281,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
+	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
 
-- 
2.47.2


