Return-Path: <linux-pci+bounces-14648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC989A0A6D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D31C270A9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16E212EE3;
	Wed, 16 Oct 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNevUTJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF392101A2
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082523; cv=none; b=FxauFxFdH2UjRFcDLNNR8OVbnLWwTkghkMPrIQ6CwWo4IJ4g1MiRjPleVCM9vewffiX8U4bgZb45Um/r6vKdw/Ib0zsTrH4x4hLhuPEB8qzQtVgDjYXe2BzS0M0a0nf0juPRU9suBITVldA4oF6Vg7Do5KBUKpT3Ejva933RseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082523; c=relaxed/simple;
	bh=RRyy0x2PiBX++bfjCGlA/9AZOm7xwGM5wtpW6IKXyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrVPKuolhnvzHqKoBFHY+StogHsVOFEOjFrlYGgT9OUNWRHMA/Nkjh+zrrKeipe+Qirrfnks1ehvd0Sebaitx/SzKQsqChgaP5FlvF0mxXWolC574XBfS7NVclmmYdCTwg4yJk2N92+CMLnapL3gORpLHjX2RRBsWYVQdEaeBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNevUTJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
	b=cNevUTJUKr8iMqsBFUukQlXA3o/oX6Sk0COTfe51LO54XqsoB0pLirUm9593bngFdS0ZmQ
	INbwfehcCLO/1uCYs9gVJIXqovNbY+HSRyZygZ+aUXHkFBxp/FvOpDPCGvDelWIc4dvzjH
	Ej5+/uIufGwRWHNrXuksKLJPqSjT5OY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-RxNgxDF4MmKnSdKzMOgepw-1; Wed, 16 Oct 2024 08:41:59 -0400
X-MC-Unique: RxNgxDF4MmKnSdKzMOgepw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43056c979c9so41427935e9.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 05:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082518; x=1729687318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
        b=d72vPqkJGTQZCJqq6bUKx3eRZORMsTWds9vQL5L71aJw37XO6b7qXBzOPk5Y4JwO/8
         HNjaZ9/kjoEizUbbCN99OV+tF5V9ekbBXIq6XHVfWehzChdeAoB7D/PeYQoyU+DjW6jy
         Hd+dUKKriEHy2HEs33v2MvuDZvZ2ZoHG6EeDNDTYfAlTF96dU8GsscxJgTdacQJUET8P
         l8XvKqoxSa2DF3l24kb5eJ+keq6dw7N+saDl62v7Y6bE5poqLSH20D0o74q2Njj/Lh6r
         GxiDST29wuVSwRkw2RRQ+rRYPxQP8CdIQVnfhv3yne72eS2CVONG47TKE2vHQJvZaLU9
         Mszg==
X-Forwarded-Encrypted: i=1; AJvYcCVPu9iPeZIhuXk0A9wMavRySIv1U9S0YiOU2gqH9BWnCujRKto4IZTPQt9+vtydzyjoZ1WcNX5qzFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJDIopHUHvwjXZhNXL2MT+0YJcXWPJjJ9apKFipT8E4GBeOLJ
	AD6lZ0Dxv68pnJjOPnLT6SI/1kIkHPu28BfMVD9v7nlyc4lUcdQng0clC3CKtKK9wyy8RfQP6Cd
	4Pl91ReaUdJpKwvl8eDoEmQbnWzk+8+0DXYp87dZsqBfb/VTN5vs5RVtKPw==
X-Received: by 2002:a05:600c:3b99:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4314a3abe93mr36586605e9.30.1729082517782;
        Wed, 16 Oct 2024 05:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw2sV/ClbQfdvwspcTkrZNz/VyaEPQ2ipBhPy5Ayv8A5HEwXPUtYjfukoE6IW5o2vvgmQFRg==
X-Received: by 2002:a05:600c:3b99:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4314a3abe93mr36586155e9.30.1729082517278;
        Wed, 16 Oct 2024 05:41:57 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:56 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v4 08/10] serial: rp2: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:30 +0200
Message-ID: <20241016124136.41540-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016124136.41540-1-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 8bab2aedc499..6d99a02dd439 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.47.0


