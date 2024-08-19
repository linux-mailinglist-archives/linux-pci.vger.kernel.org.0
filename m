Return-Path: <linux-pci+bounces-11817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51B957103
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8EA1C22FC1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4196188CD9;
	Mon, 19 Aug 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cppGCuDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635D188CC1
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086365; cv=none; b=oqSs7veAXkbo/Yv2dgneIsH1KwIS4uDygy7E2ebQ1dIBLgvxoLNbhqk1+1VbqlSae5mAajBYoQhNjFcMG30Abg2w2RjhV7hcs5xClHb1oIb6HCazd6bR3rhn93+ZxbYumnr4aGJNNBEXG6XmD48cchBGaTQzQDt12ILa4VeRCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086365; c=relaxed/simple;
	bh=Hf2mWMH7KZvv8gLE1T3MLfUSP0vtA13S6Exz9YAmEAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bezsh3DMkzEvPZRw69LQP4uxMe6puFlJtzxLVMRnS+z2qnbrAeMWkRUs2qoFO3d8Ow8Skp1SJjakkYQ8JcXJs6iz/DWr9h/WF0FXLqycoBrhsB+i4QTefKuEc9BILXPawA3yAuEtKdl1gZf/+J9aUC6i7S5xhHMnnHuJixJC1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cppGCuDz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1gq3j2cCLpN/PPS7zpa0q0nk2Py/Mwk9dwym7YeAH0=;
	b=cppGCuDzXkTQ7mOI+QNyizESRAY9hO1DSuXJfwcS7Z4qUNRkaXDCvINeQXNNKVkrAKMAXn
	ONXiqCN1n28fUkfmW+WRHKnzb9IMP5/rfFApnOgF95FuSujFBm1Zy2QLQiDdkeMlVrwkM2
	tE8uEd4+QmiRWlreZOrNnfMneQfg9JI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-tgX7HuL_PlCSepDBWNHvAQ-1; Mon, 19 Aug 2024 12:52:41 -0400
X-MC-Unique: tgX7HuL_PlCSepDBWNHvAQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d6c57f9fso9251385a.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 09:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086361; x=1724691161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1gq3j2cCLpN/PPS7zpa0q0nk2Py/Mwk9dwym7YeAH0=;
        b=TL6N6/ADiSRhiSGFjjGZnj5In4YvZm3Z8Rt78n+IzXPN2OAsCVQGzfn9EJ4A3P+dBi
         O+uVKb2pjKRxc1GqTwCjWcN/ylh7zFKpecNV3j1c4FEZh6hyXdujXqpJ6zQmjnbPPjc6
         zcdCxT0bXw+uIpFIwIcRaTY4uX93eJiE2i6wf9QyX/kBmOU62VbPzs0z9cDQD/vKVpVf
         IXHm0IGnBVpr/kelsUkM8PKI+Kz1ZKqH57ew8smHngd4dnPLKgKh5diTyI70U6Vt/1cm
         FzFzlk9INofnclDIzj0EmY3YDHb+IWn2gkulWOTrFxddyUAwJ77kgpuLpxFEJPNSIOQE
         cT1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHJwcWl4SEo6qqXdLwWY+fvUoa/u8ZCoqfa+u8VgcE4cOG3seRE0xH0QIIZNvtQheu2FsKfb2wPYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXj6waKe9NPJ+zsbr6ydf0oVO3RgY7A5DkOMks1C0zpSV3+jNu
	c+prMXUvkYYEEG5XwfhmnVPjy8GeTYuc53gUblF/S5clX8ARjcghaUBu6Y2OL2YW5/1rOaJYotF
	A6UCb8QYfO7A6LMV664MnvqTSw6fSqfnNLzI/sC/4OmqXyAanLZofa0pYRw==
X-Received: by 2002:a05:620a:401:b0:7a5:8f8:8b06 with SMTP id af79cd13be357-7a508f891afmr698687485a.1.1724086360753;
        Mon, 19 Aug 2024 09:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGDQD7k05CAjlfTOWOVMO5sw6hxjyjU2n/8i8XcW8KeWV0cEA9UCT2L0/OAyhNTDQ76PX01Q==
X-Received: by 2002:a05:620a:401:b0:7a5:8f8:8b06 with SMTP id af79cd13be357-7a508f891afmr698682785a.1.1724086360215;
        Mon, 19 Aug 2024 09:52:40 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:40 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 2/9] PCI: Make pcim_iounmap_region() a public function
Date: Mon, 19 Aug 2024 18:51:42 +0200
Message-ID: <20240819165148.58201-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 608f13ef2a4b..30c813766e8b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dfa9af3a9c22..7de75900854a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2298,6 +2298,7 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0


