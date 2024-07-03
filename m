Return-Path: <linux-pci+bounces-9702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC82925686
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB171F28728
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F713B5B4;
	Wed,  3 Jul 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tcu9U6xc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5613D52C;
	Wed,  3 Jul 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998469; cv=none; b=ooENJ7JEfQdNZ82QouzjFz+Eja7/6cjt6zz5YMaOylsLCOmQvoy5cOuavh/2xlCEKsHajt/3aeqKadwP4q2YK2i5p1yzKR9IW/3FeMVlW9rj+L8DQzA4/G/S/NKbckoaFC6jcScXC1bglAa7h4/5lY9QYnettnQCneddEheKbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998469; c=relaxed/simple;
	bh=Wyl2SFGLVCY9I76VGiszxJyjpFrEkWUOFvTsPtE6pTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBRranUaUD9QBBWdZqNpkUX2/Jrf+hrawnoGWHMaAK1UYHbQ5ow+/AuGGURD9r2zeSyZaSeS9iyek+DBMbaDDuH1whr29UupLVFXroYNiUO8naPZUOMft0mZF0RuX8n7K5+66BPjLCCJeLDWkrt8g/HxgmnRlDOO8u77WAsM96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tcu9U6xc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719998458; x=1720603258; i=spasswolf@web.de;
	bh=oBQFmETLL7D3z7jRwHkLZHsWnUmcK0p0AK8DnuJD78w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tcu9U6xckseNUP1+vBU5sqBou5tHz81TQZzdvDP2x/jWhFQZbLnRBsAtKPgzrAuS
	 cs7NtYC9LTykXu/PKvI4JfiPScC2vF6wn7m8hPKTOc0hMUMcsnFWzF5rXGIfbXRBR
	 gQqGsAlmpUO3un9spZUP7UKBvp68Wdh7iPf4tGTPbY0hnloKLH+D5OKh/OMyrFzeu
	 ca6wumnhXPCHZA63DVCN9Ysv8KQxE9bTm1JZL0GZAPrU45/exT1VnuG5YIV9p8WLl
	 CUqHzf4BzSAg6T3UA1bPMz5XplVW2BVdBcfrZmzsPu2RdaIccvyTP9QXilR3hvweH
	 cV6VzsnP2qteDGIdnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M7Nmo-1sUQGE218u-00Elao; Wed, 03 Jul 2024 11:15:38 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	caleb.connolly@linaro.org,
	bhelgaas@google.com,
	brgl@bgdev.pl,
	amit.pundir@linaro.org,
	neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF is defined
Date: Wed,  3 Jul 2024 11:15:30 +0200
Message-ID: <20240703091535.3531-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240612082019.19161-4-brgl@bgdev.pl
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyJcyHhsNSpkSUGZqbvy5cz1+qJWvtRYdbilKOrnaRbpkEucYDI
 OO6X9pZ8KS+LAvp0TY5pUBt13c5CZ5zj58Jvj7gRo7OtAEgAi64mW3/H5Q4f5PEAxJRvddj
 19rlO8z708zo5053JsZrJq5n5fJsE/CHsT0KUTpAnn9hFrDqamw8Ed6svdI5bvXDv+wctVC
 B/p0EFClr8h/KIYSsBJZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:20gnE9vcYAw=;5Vn92s0UDnCrY+dgvQFnS2uHqlE
 zJhJX+e4RvaJ0YxUVfTBGS9DpEFmWV17NOxuLmJjHvlA9l0n9M9/bXy8nsSsRtimB32ZA7bAp
 2dZmY9SSnYrQVaOyMoRfP0VDudwq/YJs++W5FIIAM3nDqZ1C5hRhBh03cFR80R8CYj764VBso
 tO4eH7o56SGLLhtgYEGRFUMy7rl5zRQd6B5O497CRvkYecE6ZFh3SVOH5gTFKTwJYm7AYvNy7
 tqDZ/8xBFxkky9HST5qVSfKrVFy7k8oq/zAuT1CxTyyFyCt1hUSPQR4LL9t8rYSORUMntxQXC
 C4TEyB7o6aF4mCKZr6CbKVI/UkUqs98jwJxNYv+vUkAvLf6NAkGDUEtZnMHilS9dIDfTAf0EN
 GWsj/mgStCv7Trsd71WrZIJ55tjpoJfKCNnUczEUYHpF2dXFscNdFAgHkQGDCXVUMwz8hMRkA
 /+pBgsPxay08zCB+qc+Or1hes7b4uCi1khmkHD21t5WeBh4ghmnKYOQ+o1dPuKMV6t2F0c+iI
 GX2XhI0vW4Se6IElsiL32ATSDehuly8Jjw1DPJBVb6HvOpbZLgseHjqMYDx0YkpPg6kAciw92
 3aLMlx9fQNQDrtIk5bTPNRkJdSodIndz8jucpl1FvrkGQSzDu3TcAWT4JzrBt23a4E9owVMg+
 OsEGNORflRBAJv8dK/uggUys80Q/HQrJgCmdQSXYbDBp+NFLkUz+hoHRP0mc48Fc+dOqeFcc8
 Vl9ovVrQxPzdg9nf/UVPnFAGpipd6tv5tLW+EibbfJCqM+6P333ufkZmKv10A1q/yX+5wrJpT
 4tAAA5elsJMFlWsXYwXZWKmIdkdTieKOWI2jWiq1jIL2A=

If of_platform_populate() is called when CONFIG_OF is not defined this
leads to spurious error messages of the following type:
 pci 0000:00:01.1: failed to populate child OF nodes (-19)
 pci 0000:00:02.1: failed to populate child OF nodes (-19)

Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nod=
es of the port node")
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/pci/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e4735428814d..b363010664cd 100644
=2D-- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)

 	pci_dev_assign_added(dev, true);

+#ifdef CONFIG_OF
 	if (pci_is_bridge(dev)) {
 		retval =3D of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
@@ -357,6 +358,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 			pci_err(dev, "failed to populate child OF nodes (%d)\n",
 				retval);
 	}
+#endif
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);

=2D-
2.45.2

The mentioned error message occur on systems without CONFIG_OF, i.e.
x86_64. The call to of_platform_depopulate() in drivers/pci/remove.c
does not need #ifdef CONFIG_OF as the return value is not checked (it
will most likely be optimized away on platforms witout OF where the
of_platform_{de,}populate() functions just return -ENODEV)

Please CC me when replying, I'm not subscribed to the lists.

Bert Karwatzki

