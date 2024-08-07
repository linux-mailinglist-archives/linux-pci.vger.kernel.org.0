Return-Path: <linux-pci+bounces-11419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0E94A2F7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB991C228ED
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7661C9DDE;
	Wed,  7 Aug 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbwXSc2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D01C9DED
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019455; cv=none; b=Zi68yU4Pdj8TVm/qkBQs4FpcD72d589tac/fAPpEmbWbwasFXfdWvsKpvw4vnQDAtmnJnaASsKJwOyyKWw5wFHfn2YCW6r3/VR3TEpPDE/jL2D3rLyjTn5vbnigBtUrnddCQPZ9raYJft/TkkxUB4rZRAtYSXkISbFpCS0f4nu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019455; c=relaxed/simple;
	bh=PwYwdcFZJjXI/1ZBi07VVhiw7uh58Ga2zr6zHKgzONw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1l0tx2noCFuEGh5qjdiZzVssbwMIyFyTDjLgzcque9b6Za3qKuGHfqJ2vs3KHCXsJMHWWpNuZEWMcrkuoRcPDuFtQ5l+g7mueM7Qeqn64nNBSxVXZNVXNcA9ahsO9D9IOjUZ0AXqJSCsM/N3peY22fmpmI1BYPZSFYWXBrhdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbwXSc2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723019453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVbzma6Ld8kQQE1ZL49LKh4hv2SyDx3pxf2xj02v3wI=;
	b=UbwXSc2mVbrkzLcMsltCZHaFo2kA+Pba2aobY4UjZblBLlRxXYY5VXLUJ7C0B4ze5/npAm
	MVxvx1ONNDRO7PhS/sr9XqQxqk9D6sxcw1BtkAtL/XOTfkTGOzZ9X911kyImDekUTu3NTS
	W3+mEziHDITtITlsDCKOMIhKRpQCciE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-7P6pxkM7PKu7efh2H1JSpw-1; Wed, 07 Aug 2024 04:30:51 -0400
X-MC-Unique: 7P6pxkM7PKu7efh2H1JSpw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef185db2b4so3536701fa.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019450; x=1723624250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVbzma6Ld8kQQE1ZL49LKh4hv2SyDx3pxf2xj02v3wI=;
        b=YStFq2Y42XVRj/rdPk1h0Ktn5L0QVT2md0Y3NgDoWJTiqAoC/GRqG0pJrslsjAOV63
         gaM/8H+WKY5Ul4eMtNYntww5R3Xj/uNYD/h9iJ3E8cUUBwpwMRbojKBIYOegd0dP6eoN
         X5optWiQ4y5hV7s2jSzid91QAPx8CvkqQMJ8elgW48oRVXOCPjwXdypE/0Wse5SotyaR
         jfPdX0+g+up+GSSvnO6R7RGMWBclB2PtOlUAbXlmNvjKA22BHfKKLuJCTOkxpyuXPlVu
         Ig2lc3gqq+0Oar75Foy82oedNprpLW7hUyeYQYdbQcrc8GvB9tfzc5gvDDQIkyPbB/um
         GdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxUuzV8n3/o0+oIYhGPWY9R/tsLZ3SNkGxqcW3hXvKNNTZ2zHEB1/rayMhEmSclMfg2CtTdVnicgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHA8XWhnD38eiIsyZLDMiJdAGSbDeb/KqV4mCKLp9jER7+8fJ
	haoQgEudMbYQH5kVhU4Y25hNndWrjTNxBPLnWNjhI7ggQ4d9MqgMViC+gLktKkAZ581uj/2uZSj
	+MjEtBxgYNyK8PXjUj2hJm2Kf4UmAfFa7lnNBQKPC+CtrMefEvjUWNpHZpQ==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr66033651fa.0.1723019450105;
        Wed, 07 Aug 2024 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM3mk64vP4ZIUUqLKFHzIo7xNqsM+xJ9/DLlPYGzmqWK63piOdQggG6zFHh9ocfAw3S9zfvA==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr66033551fa.0.1723019449584;
        Wed, 07 Aug 2024 01:30:49 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580cb80sm18544835e9.45.2024.08.07.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:30:49 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 2/2] drm/ast: Request PCI BAR with devres
Date: Wed,  7 Aug 2024 10:30:20 +0200
Message-ID: <20240807083018.8734-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807083018.8734-2-pstanner@redhat.com>
References: <20240807083018.8734-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ast currently ioremaps two PCI BARs using pcim_iomap(). It does not
perform a request on the regions, however, which would make the driver a
bit more robust.

PCI now offers pcim_iomap_region(), a managed function which both
requests and ioremaps a BAR.

Replace pcim_iomap() with pcim_iomap_region().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/ast/ast_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index aae019e79bda..1fadaadfbe39 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -287,9 +287,9 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	regs = pcim_iomap(pdev, 1, 0);
-	if (!regs)
-		return -EIO;
+	regs = pcim_iomap_region(pdev, 1, "ast");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	if (pdev->revision >= 0x40) {
 		/*
@@ -311,9 +311,9 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		if (len < AST_IO_MM_LENGTH)
 			return -EIO;
-		ioregs = pcim_iomap(pdev, 2, 0);
-		if (!ioregs)
-			return -EIO;
+		ioregs = pcim_iomap_region(pdev, 2, "ast");
+		if (IS_ERR(ioregs))
+			return PTR_ERR(ioregs);
 	} else {
 		/*
 		 * Anything else is best effort.
-- 
2.45.2


