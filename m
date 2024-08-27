Return-Path: <linux-pci+bounces-12302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2F96177D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE321F24DBD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D81D54C7;
	Tue, 27 Aug 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVQRp7Ob"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610C1D4606
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784996; cv=none; b=c2KkPB6O6B3ZjJ6h+cvHjsJim+F6sUzhH+QV+tMPnu6+sg26C28T35fvd6AI0wCiTHBH95SqX4Ngtx030gkzCc2ulEVnQ6bR6VUHz7xqTvXJp1CcoMSrUNg5hujh0eGyg6y2D4tOxX8oHOhEltOy0EB3v7pkcaNaPHcbIkZ9GXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784996; c=relaxed/simple;
	bh=JMbg4eMibkjbCBRT/iJAl8N9RNBguY/qcuyAy9Bi6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkXEGmeIkGzl7GcjvOtONYt9y4pmVIaiTfnBRT/tB3NHvvxkgXAPOgqrbKtz4D24+KqILbrzB8O+2KzX+dvkXhB2NA7d3iimvKw6TcgRypsCEsTroAjxVVkHlUhFBBppNXfJXG9SawcfWMIEYJ+lgAgi9i/fhcyAUQyEaNL+0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVQRp7Ob; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
	b=jVQRp7ObtDJz7kJZFDkwuadXr0Hr8zB1o81O+jrsXxU+l/Afuz5Cjjs7fvQdG7+I8yBnrB
	I1990eAWo6HIBYwADfDRQ4NwaVqzW53352HSAD47z/eQ/Hp3HvTGi+pk+I+hh9yvxPWTZc
	MKqvEEmuMreorkR4yhn4ookvfUIsHpc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-z8zL6ti5OJSil57pYN672A-1; Tue, 27 Aug 2024 14:56:31 -0400
X-MC-Unique: z8zL6ti5OJSil57pYN672A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5beddc4f702so5254204a12.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784990; x=1725389790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
        b=QlxxTJjcuUxDtnsoLz9sTxBPnBVhbjOu65FNJToVQ3mpJWIMFjEl/tQpN6k8HuNgH+
         JKq3DlTvPtVhenEym7lHdZb8Abvexk0jSI7XATebk+VIQC286nPlDDRxo7cn5XyUOQcE
         2GIO35HocZFa7shOwl0QxyzJmP0oo6y5llEeiuB/12gwup1v4Vswdhz3knF8M0gXIXTp
         wOuyfUBywYcEh4XHMVqdZGQeoMoUJYKnEe8whdplUV073mvL2x38uDVFxZUi923rWjAv
         OH+YUIbgM5Ce+cY8XF2YTX5IApnke4uWXjqpg9Re+fR+BRWmf8LbLnwmG4jeqg4o5i+D
         zEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyZBSHufukU4lVJ9m1X7L768uh9N7HihaUxSLLeull1kub0QXH6xM1oVy1JkHth6SBglAAKlyUP9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WVycgRGlJE7XXjToCKk3XeX2vMrZID5aADVbu1WyxQzKmR76
	Xmag7FiqEgq5U+AfHAK3/etUuVtKxAomS3PKqDtRyJnjl109q4nIZN2sf1X0t+7G7IimQu3Wz8B
	vqgXxGHa+zL281P2kCLBlonp/2/pkMcoFMgFUZMKHO9PhxMO9PzWeOmYMXA==
X-Received: by 2002:a17:907:7295:b0:a86:97c0:9bb3 with SMTP id a640c23a62f3a-a86a54b8d24mr1205131766b.51.1724784990411;
        Tue, 27 Aug 2024 11:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3LQz+Ovtpn7UQw3Ih17gexf8/42HNMXwzrnqKpk9+fwQeRpCxA2TD7y7c22AXPuu4p6dfJQ==
X-Received: by 2002:a17:907:7295:b0:a86:97c0:9bb3 with SMTP id a640c23a62f3a-a86a54b8d24mr1205127066b.51.1724784989954;
        Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Keith Busch <kbusch@kernel.org>,
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
Subject: [PATCH v4 6/7] vdpa: solidrun: Fix UB bug with devres
Date: Tue, 27 Aug 2024 20:56:11 +0200
Message-ID: <20240827185616.45094-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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


