Return-Path: <linux-pci+bounces-14629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28E39A05F7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0355DB227D4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128DF20696B;
	Wed, 16 Oct 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGFHXAoJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F61206074
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072166; cv=none; b=A0tDlwslggs9XOLgPjK0Ls7kbhDXHkVp8eY+oAH+q+QrLWye6hCoB69aFfNwgsZPmiy9KbXVaM6/RteHkNl7pP6rG9UkEMpYOMnIRFK6GM+kEYAJGhDjUp9AOFQYrtv9UIwnq67ETY97BinxBHK16RpbMba8IXMBUJljfYJ2LNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072166; c=relaxed/simple;
	bh=tJu5U2oC9OD6rR3Vcl19luaP+UNIfavq6ySX6Ao35wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTy757RepaIG3xl3U5cE6Vsa6rhzD5gXzRJ943xqdiGNtBl+nua6i1bVW7E2l5Ux4X4D+gVFEOs80IEmgXrpJzOYX3d3o+B8xqSSomP5WTW0SMlvflxKgKcGEPfA5AMuBG3kAbVTJYs8m7cvR0OfriljnfhtWu/jPmATcZCngOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGFHXAoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnMvQjSP3jZBMFekrBQlY/hq8+zQym4SrGgl7pIccig=;
	b=TGFHXAoJsR2TsOQQQWjwAIPIZRb7S8R5vIBhCxCLw/YvNbNqc4bIWrtj6zGlQ5LtMVdHyw
	kreU/yxw+Gn0HESIDtyUN5TBh9WXWj2jmxE9FqcTAC3r/AyeLPng0jm0/V9UilJMHr8Ok0
	YOFqcJw8CAq25+Is3mttrAOgAPR+aSk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-ZhDvZlK9Mu-ul6yd1EjbtQ-1; Wed, 16 Oct 2024 05:49:20 -0400
X-MC-Unique: ZhDvZlK9Mu-ul6yd1EjbtQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so2147935e9.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072159; x=1729676959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnMvQjSP3jZBMFekrBQlY/hq8+zQym4SrGgl7pIccig=;
        b=eRjZzLmeQJcWZlzj7pYUwAhcjrIHQBsvOvY3HQgBYT8Qmf1UTbhhIbkATw7L9U1djD
         eKwGOcXtR4fiiSE39uVuUkyDPPQ2wdFZYiI7hrG16gCzuGEj6zbB2fXLi5gcBVwgOyxL
         Q1MlAO+FNvkhmTTG/VxOyejLWFXwR2HSaED+PTNHcZf6g5lQYPm1632ND8GcxGja9Sqg
         PVN9FMj2tZmNcZlvzKswEFbRlvrsoyvMj3uO4DVVTgKipC1MeqhfviTkYIDgUZCnwJ6q
         3NwEqd0o3oVouDtAma3a3e/BOieDTqdNV9nenxdj81u2pdYte8ENhO+wiHk7e9FPFm9v
         mrqg==
X-Forwarded-Encrypted: i=1; AJvYcCVgOjIu0uu1WhKecKszHg5RBbddgufY1umfMXOOoDSQLbc55LUraqb4D3wVpsMJKatOji9w9IEfaNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7Xv3WiLAHcgK8LmIYX4vWsVmn4IMnLWWduoFgNQTFb5HQEEX
	NB1ifD1fhdt0Wqf+k7ksIbrHWtaPBk+Za3WDQ2gvXq+/zhkL4E7JUv+sH9gE+kpSGh4wNE2HxLF
	JE/X/XcKd04fJzsbGKk9bha+Q6Qb4SOHF81GJLgcWiBYlENuJwTPd2GZoPg==
X-Received: by 2002:a05:600c:54cc:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-43152daa0ecmr7721095e9.1.1729072159444;
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfsAAAGgUBJ0f9Xs7hYUhseqFHC1b9z96yM3vsvYHHD2153BJru4vUCPyjdhRiv6k6fxkIdQ==
X-Received: by 2002:a05:600c:54cc:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-43152daa0ecmr7720745e9.1.1729072159038;
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:18 -0700 (PDT)
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
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 1/6] PCI: Make pcim_iounmap_region() a public function
Date: Wed, 16 Oct 2024 11:49:04 +0200
Message-ID: <20241016094911.24818-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
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

pcim_iounmap_region() does not have that problem. Make it public as the
successor of pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..7b12e2a3469c 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -784,6 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..c4221aca20f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2296,6 +2296,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.47.0


