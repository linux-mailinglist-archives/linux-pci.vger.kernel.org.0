Return-Path: <linux-pci+bounces-9896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F6929957
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 20:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD931F210F8
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129F55C29;
	Sun,  7 Jul 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="uuAWwvrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A363A8CE;
	Sun,  7 Jul 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377527; cv=none; b=oS+sJFwfOpfuybLmlUXpMMDFmIRE+Rup3YyhR37vkVEXpULvBqypO6E7m4R9kPG4sBBqq4iPVWna88QCNAPdSb7uKqzOOehoI7fc8op2l3uD5/ChMZByXg8U1Nn7T5XALaNrPy7pAytjuW2DODeL1gfVyJ9yBbXlPSNNzsQO6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377527; c=relaxed/simple;
	bh=LVr3tRclo8ZSpQufLCLswBMa+2uinA7dOqT96FAwCNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG8IWMZKWauobkD/Wh80qCmAmYC6EkG7LJ59mGBzUaXRZrI5JcHnGTNAGQtltVVHo3myECHUrzg2hYElIQnRD/FzpIlkUaoL+pa9cM17dlt5q66P90aGDbkyiWIz4uiLAGc4ZvxfRKNb3zk8tkJA3puAG5SJBDaOOkzOmHXgMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=uuAWwvrk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720377511; x=1720982311; i=spasswolf@web.de;
	bh=vY+U/NbiVls8p8YZ5s4QJvHYWjm0ZgxhAbarEss/IXY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uuAWwvrkWw9aghOwwgO0bok/v0Nde2eMu0j/ypMn4IzUFcRSU87shTk6Vzsk6exR
	 kpAacfMEkxS8Nrf2gV+WC9mgUUi+2IH/8vEUEgaFGajvpZsDhlfJQjqgfAo0KAMvR
	 ZixkHneu9LC1DbIojAMOALhNEjjWXahvt79TqhEGKVtvGy7ncd7XnBeqv/axveUCy
	 O/G3O8p1cqhEyYbzPqBaoR8D7pPfBfQHabF4mTIvXGN26PDrtlGuGM8KdooJVjPdn
	 PP9+7rsAVa8Bl/RDLR14p58QVGHi9EAs+/NjeqCqd5DvpAapodBv6vbzGHO6S0piB
	 /LJjeDwjKQ8tsB8Ekg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MG9DE-1sccf53IGi-006R0T; Sun, 07 Jul 2024 20:38:31 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	caleb.connolly@linaro.org,
	bhelgaas@google.com,
	amit.pundir@linaro.org,
	neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
Date: Sun,  7 Jul 2024 20:38:28 +0200
Message-ID: <20240707183829.41519-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: ZoqYz-MWD06GmKPJ@wunner.de
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjcgykCTbZr5RWCfTelcTrxzSuuD/k8Zxh3nM7zerAHPHT1F4at
 hKNyoXSGsb52A1xH2EiyEMPx8VVVtquianUVPESQxwPMkoltp1mNW8lHwkscubA+Z5rxaD9
 Xe4mOUs+FLK6MmghQnfFs3ETichfjgtWluRvGoHdn6PZDwHDjfSy5/pbX3nM84QAyYYruQH
 +1zzxU1yyffKIkdPDZc7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/HGvqpGB1JU=;ZSI24ds3OQwUxZT5uva5Kzz3uZE
 u58uxIY6OhIjlFGqC20rRxlShcoezqmSsIIU+7B5J4E8t0sjejQSyM78n58ySP8SwHdVqZ8c0
 WzJWpJlRGwLgZOMnYuXxpnQTkIO1KoQD2U4dQJebVy41JX/22zMFscdW1XBdukwC87hXP5PaK
 LJwqaKBHOmaIwJDsvMxEGPGRmOAxUQoFyzys8UvY+rVUGtQYBud7e9Lh/CxZUIxI/zcom6xyG
 yW1u7Qh0oR2ehKkEknM74Mtp3TXdxulZupzD/GTKigpxhPXkxsqZ8hzdZgBW7tsBdx0OsjbZ9
 QaTkf4KNpJHy/ujbgsGNG9g8Ws7YOSBAu5RO0KI1uBWRqpnCzWM1ojp/vF3Iw4LF/3rHPGAKd
 oYsyP5TZ9odV9KoMkVNYmma33TEfr5Nsj/U+70wX2mKD0CAKwBQFfoMcLkkj57/ZzbvzGgVL8
 AVABVCCCSJi1qq/YpOdKcAKuyYVY04BpYJYTpz8M1U5Z2NbWJRq14vWmy/1Mirvh1OWM2huW0
 a8Aq5ZYnkmWDJDoGTlwKUW30bW9+hO4xP5cmQgAffZafSvO1kNf9qr79VHh4IXfkPfJksTr3c
 Zmeb5B5PIFwftSpJrJLoEJk/bTFM5pjMjksl+IwWytdr18BxBGrq6upSrlS9A2fWrP1dwUgF7
 s8WE3zATicm94dbxedmjsSNthreqd8zxo6uQUUyT3zCGhDO3YR5UKi0hSv+cBXEA6UBU+J0iO
 njQRoDgfRxkp0npZa2pmPYrnnlmQbSLxcXTWNIaf7/A9VIIU4Yx2Zjiqel9su6pKs+/DAQyI2
 LN0Flmsgl5TasAQLwWWv7Gpb51ROPXOtKdcF9O0dYYSSQ=

If of_platform_populate() is called when CONFIG_OF is not defined this
leads to spurious error messages of the following type:
 pci 0000:00:01.1: failed to populate child OF nodes (-19)
 pci 0000:00:02.1: failed to populate child OF nodes (-19)

Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nod=
es of the port node")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e4735428814d..3bab78cc68f7 100644
=2D-- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)

 	pci_dev_assign_added(dev, true);

-	if (pci_is_bridge(dev)) {
+	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
 		retval =3D of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
 		if (retval)
=2D-
2.45.2

Just in case this is needed.

Bert Karwatzki

