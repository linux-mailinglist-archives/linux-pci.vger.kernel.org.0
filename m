Return-Path: <linux-pci+bounces-1987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B234E82988B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90F31C2596B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249844776E;
	Wed, 10 Jan 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cwML7bh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB074776D
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240110111708epoutp04677397cfa0c3e094527ce668eed4b87e~o_EOXbCe32057220572epoutp04b
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240110111708epoutp04677397cfa0c3e094527ce668eed4b87e~o_EOXbCe32057220572epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704885428;
	bh=VNQFld5uD/GfuHVgTJABTKIG7Jx2ishsDZrK5Wsb3xY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cwML7bh5qYFIN0dgC+jT4h/cPVV6VIV0dzcsxcKmmp0vj3wttvl4fUMloveq2es3F
	 55fj8D+qoJNtJ7ZfF5CTBejdSx7u1W6P7lQYUh31HFFU1pbffjzeYOLq//+psLVouE
	 gA84N+yFnff1fLcCTJR0JXQ1yYM2bRcvKdgArMew=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240110111707epcas5p29a60808bf7c6f7e6af5bd63fd479e48f~o_ENsIrdo0161401614epcas5p22;
	Wed, 10 Jan 2024 11:17:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4T94y92jY7z4x9Pv; Wed, 10 Jan
	2024 11:17:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.3F.19369.1BC7E956; Wed, 10 Jan 2024 20:17:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240110110143epcas5p2692ec3cbabfdaf2c3387b5a98f072943~o92w6AU3Y1257212572epcas5p2B;
	Wed, 10 Jan 2024 11:01:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240110110143epsmtrp2f3a51c10d6599f76e6b9b3f26c2cd4a9~o92wzdbIx2407724077epsmtrp2q;
	Wed, 10 Jan 2024 11:01:43 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-1f-659e7cb148f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.50.18939.6197E956; Wed, 10 Jan 2024 20:01:42 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240110110140epsmtip1235f38c9714739f034de29f3b12ede6c~o92uYBmfZ2758127581epsmtip1d;
	Wed, 10 Jan 2024 11:01:40 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 0/2] Add helper function to get and enable all bulk
 clocks
Date: Wed, 10 Jan 2024 16:31:13 +0530
Message-Id: <20240110110115.56270-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmpu7GmnmpBlPmClo8mLeNzWJJU4bF
	ii8z2S32vt7KbtHQ85vVYtPja6wWH3vusVpc3jWHzeLsvONsFjPO72OyODR1L6NFy58WFou1
	R+6yW9xt6WS1uHjK1eL/nh3sFv+ubWSx6D1c6yDkcfnaRWaP9zda2T12zrrL7rFgU6nHplWd
	bB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
	ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
	ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PWxNOsBXPZKmZtes/awPiXpYuRk0NCwERi
	8ZanQDYXh5DAHkaJX6feMEM4nxglLt1pZ4Jz3h9pZINpeXT5DStEYiejxJF/+6GqWpkkLrx/
	yQpSxSagJdH4tQtslojAYkaJWzs2g7UwC5xgkjh6dhsjSJWwgL/E/V3X2EFsFgFVicbLfWBx
	XgEriV0zX7FC7JOXWL3hANgkCYGZHBJbN02But1F4uehHcwQtrDEq+Nb2CFsKYnP7/ZCHZsu
	sXLzDKiaHIlvm5cwQdj2EgeuzAGawwF0kabE+l36EGFZiamn1oGVMAvwSfT+fgJVziuxYx6M
	rSzx5e8eqBMkJeYduwx1p4dEx4+ZYDVCArESrV9OME1glJ2FsGEBI+MqRqnUguLc9NRk0wJD
	3bzUcnhkJefnbmIEJ1atgB2Mqzf81TvEyMTBeIhRgoNZSYRX4fOcVCHelMTKqtSi/Pii0pzU
	4kOMpsBAm8gsJZqcD0zteSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFx
	cEo1MDH3uHcttV6t/ior5ce/jUvZpp3QrFWL2/dhp/K5RW+9Qp9vTFNtS77Zb3VT20MxtaP8
	7qnT2cnx8g92656Q8vzO1mW1f/lM8bppKtWX7DU+sq+2WrO246ehQj47k9s0ibZn8hkGAVMO
	921gttisHKKv+2ZB8KnPF9axpM+7vepN8+9wvweLFSZopt09bH11Q/Z2VRbWDRssP/QsPaHr
	mq6d0WXhbL/qgc6+CWeMfa5ZBt5/f/r/VoGleR2NHB6nlmyd3bAu5ImVG/86i3Pf41Oivpjw
	7lMt/NN8wnLO+38fmi/peSSWFi9QWBDrMmmBMPdjJ5sy+39rFzJ/n9LVlWy16OLqxlWBdnun
	ZDjyhSixFGckGmoxFxUnAgCgilTbNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnK5Y5bxUg793LS0ezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlavF/zw52i3/XNrJY9B6udRDyuHztIrPH+xut7B47Z91l91iwqdRj06pO
	No871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgiuKySUnNySxLLdK3S+DKuDXxNGvBXLaKWZve
	szYw/mXpYuTkkBAwkXh0+Q1rFyMXh5DAdkaJpefvsEIkJCU+X1zHBGELS6z895wdoqiZSeLu
	wy5GkASbgJZE49cuZpCEiMByRomfJ58ygTjMAjeYJBob57KDVAkL+ErMPDMfbB+LgKpE4+U+
	sG5eASuJXTNfQa2Tl1i94QDzBEaeBYwMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCA1sr
	aAfjsvV/9Q4xMnEwHmKU4GBWEuFV+DwnVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivck5nipBA
	emJJanZqakFqEUyWiYNTqoFp0/lnfH/u+HPwK3vdbeyZOmnL3n+vI4r5XO6+u8r4wdNCb+WB
	v327nmx5sLnmXWnSE3vxk5s6ZSNea1denz5zvZzn03/rHR5/nRDZfvBZ7pzd1zrs1k/LXp9z
	oozr7638Vs0ryulu5ZvUFD6qTPmlb8/jqNn5TDBlXaZb9NqvHNOEltnxq/7dHWaVdn/rPqHJ
	U9dlndyp2FWeO0un/uifD5Vbsy8u+F7v/ODRxNtKkV2dsvxt07OLXmTa84lfZY6ctyHl5sul
	Ts785zs07JxnTdSsYuswq+w+/9s597hj/Hmhhk0r6iOmCG4qK7DPlf7xqyfIRC0n/t3sY2dS
	1id3OEz85Pw5rJ4vKY1dXldPiaU4I9FQi7moOBEA7z/GrtsCAAA=
X-CMS-MailID: 20240110110143epcas5p2692ec3cbabfdaf2c3387b5a98f072943
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110110143epcas5p2692ec3cbabfdaf2c3387b5a98f072943
References: <CGME20240110110143epcas5p2692ec3cbabfdaf2c3387b5a98f072943@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Create a managed API wrapper to get all the bulk clocks and enable them
as it is a very common practice in many drivers. The second patch uses
this API to adapt to clk_bulk_* APIs.
v1:
 - https://lore.kernel.org/lkml/20231009062216.6729-1-shradha.t@samsung.com/
v2:
 - https://lore.kernel.org/lkml/20231115065621.27014-1-shradha.t@samsung.com/
 - Addressed Manivannan's comments to improve patch

Shradha Todi (2):
  clk: Provide managed helper to get and enable bulk clocks
  PCI: exynos: Adapt to clk_bulk_* APIs

 drivers/clk/clk-devres.c                | 41 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-exynos.c | 55 +++----------------------
 include/linux/clk.h                     | 25 +++++++++++
 3 files changed, 71 insertions(+), 50 deletions(-)

-- 
2.17.1


