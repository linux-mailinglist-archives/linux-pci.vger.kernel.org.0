Return-Path: <linux-pci+bounces-12445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD05964805
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BCA2856D6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826481B4C49;
	Thu, 29 Aug 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="das9/IeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374A1B3F01
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941143; cv=none; b=YoR9qi3kbp0Wm1l2bJXtHJWGENg6yze6R4SmZj5tVgSMfUEEbBm17P3K1chkIZHleHM/tfCdq1m2Y1kk/I0wsc92Q3rkn0C3A5spoYrwd1H3MTsEiSbbqWBoLuhgq9Fs+DW6i7pODjGaXMQp1m+Ba8mROKZ7E5wa1y5lN+AHqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941143; c=relaxed/simple;
	bh=JMbg4eMibkjbCBRT/iJAl8N9RNBguY/qcuyAy9Bi6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uctUrs/tloptxVy4+7P82ZM+clDA1yYxmI+HS3wr04aoK+uWMa/djC1mgZR2HlVQGlD/oJtZthmm31jEM7vw8JcULxHfRk0tt0p4GUQlb2z70aDw6eiKk7S7WvDGB8gemkgYXOYYr+5wFhYF0tWIZSmF2buvjhXxEUv9FpE4ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=das9/IeG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
	b=das9/IeGMNnFFBjOeUlfOW2/Z2+KZF9NZx7lKylCVnc9Rqoda70c0djkWZpdWoO/vUY9Zs
	31G6z6SLWjtgV6Xw72tw85qq87pf2sjBIqCjrOeIqHQsiOf/l0txl7PZBzlMKzK6WZ91Ae
	vsiG+v81Du/3CRFwmeCqiuZn6liLwJM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-F9pyiqI0OpCC6Zh-kBktsw-1; Thu, 29 Aug 2024 10:18:59 -0400
X-MC-Unique: F9pyiqI0OpCC6Zh-kBktsw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371a1391265so443367f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 07:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941138; x=1725545938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
        b=RSe6oVKowStRdOw08dQz/4ZwVZTsRHWpaemRHdH+GlccEGHC/oCi8nXpYf1a0hAAnl
         EjSSOVxWdRV8BNsu0To2FgKKgqDOD+5HdnkAPG9Rah+PeRRzBOxkSp60ODeyZTU3VvGk
         BJvqL/LdDWpObedw2hs/lsCz6Vjzbi5avYi2pkcdX9ik7jN013OKU6R3s5BBDer9Et23
         Q8yCbJgSsLGZV5WQUhfDk/iT79Nwazi7GMRngXL2RAbX0dGPhIwaJav6aqvsnZaCwDCS
         53nYrdI6RNTZjTLO8c9vNGccBFmv7HHItKUZwGfZkiAUVLRjdFbRQOOJ61UJ8gjqpUWV
         2pKg==
X-Forwarded-Encrypted: i=1; AJvYcCUs6p/U0p8glTxyLSUrZEb2aR4DrZanOUqpt6VdzIdTvwL05mU0JoodF+ZZIb6KO941Tdpb5vWN5SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRP1ytinQrX4EjDgon1g8ElDN3o6a0/AT75+xFdrFvZMQ3rhp
	dUe4SU2hrr2QF2ZexNoYMw88Nj+5PQkWRGtZcCKMlo3N4/Fr2oW7H9duAHqafBCLRgPR1dVtP1c
	xtERusycYaXuCHJB9bckEBv40gOYZC7EKR0XJF5s2qBaq2ofLKfC5hzfMbA==
X-Received: by 2002:a5d:6588:0:b0:367:8418:fde4 with SMTP id ffacd0b85a97d-3749fe45f69mr1407075f8f.7.1724941137993;
        Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf/Cvj3uFdDafG6t/JWOmnytGzmW7NR6oQDE7fLIyJIivUhu4hLbo/UyEzITWoKFSXYk+WIQ==
X-Received: by 2002:a5d:6588:0:b0:367:8418:fde4 with SMTP id ffacd0b85a97d-3749fe45f69mr1407017f8f.7.1724941137555;
        Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Date: Thu, 29 Aug 2024 16:16:25 +0200
Message-ID: <20240829141844.39064-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.46.0


