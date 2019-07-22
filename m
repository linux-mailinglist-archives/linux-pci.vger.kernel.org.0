Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0D701C0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2019 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfGVNxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jul 2019 09:53:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2019 09:53:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so39541217wrm.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2019 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A+1IXOg0AUN44xOjU2IRxHAI7jKAe/Dsm+NufqoDwo=;
        b=h5xyyPGSNmBklwByUO/gVRTUPrqta7oP6slCL4V466Dk09LzZfaKpE38pxS8G5slhy
         kCEcqJytkJuTpeJ0ZkCmKFqCNrbEfC0lUXLQOENIXbxc4dFY4fY6/OIOFSzG/uq8Fa4v
         cVik26Hf7EfFjIME2gwYiHyFu/Ime6pzaPmIvGIuziJy56HmOJs6GrwoylHcUJ0SJiP+
         N4Zfu55ZuSuimc7A33dUu6HxUibxWLmeA1uTeG0hn89lx1ChoDQ/jvmIItGHJVSZKik4
         N3+eMf1E31OR4eP4wCFFWfiNFLlHmEP5mrxCgkR2Zr+NUHrxM7UvU9ht1gVrcWcerZak
         4A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A+1IXOg0AUN44xOjU2IRxHAI7jKAe/Dsm+NufqoDwo=;
        b=h9O3SkmW/L+mId6tuRYOcHT0lGLq0C10KLZeJIYVzISqJLl6e/TGqSAISOuL7qpFyI
         CnLl2G/hqxvTe90Ey9hpAyFK0+g6NDeaMX2NATsBpnMoy5MvqM6x8atwPdPHu4ScP4Un
         1RGUJW9Vc9oEhr7eL/IPGiFykC+o6On+cnlbrGFZxO0zYL8GCtW4Vxwh4AIrdTq2xIjH
         69mXVa/ALXPqA67TY5LnjmdGUXsKa3zojX5frM4nDNi9RpqgE5/iLiXZDZBEOvuVkUqs
         FMxEZ5HUmE3uxp7NAGMHAb5Quh/GyUD2/KXPxuE0pWmSCj4/SmVjvzEPO/7IDYFA/jFB
         oSeg==
X-Gm-Message-State: APjAAAV59vI5np31ebcwz1Yq5EJsaFg+b6PQYxL14I24kr5FWpCRIZGS
        UsJBZO4uFGHjl/cPNrnbXD0dIw==
X-Google-Smtp-Source: APXvYqywPiYMC6nufG0pkn9341YSKK0eKjFT1pvuf89bXzyjMLOex2BVhSg8UoynoCTGmuXI4lFN6w==
X-Received: by 2002:a5d:6650:: with SMTP id f16mr77388789wrw.89.1563803597410;
        Mon, 22 Jul 2019 06:53:17 -0700 (PDT)
Received: from lophozonia.localdomain (cpc92304-cmbg19-2-0-cust820.5-4.cable.virginm.net. [82.24.199.53])
        by smtp.gmail.com with ESMTPSA id s10sm29821771wrt.49.2019.07.22.06.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:53:16 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, mst@redhat.com, joro@8bytes.org,
        will@kernel.org, maz@kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, virtio-dev@lists.oasis-open.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date:   Mon, 22 Jul 2019 14:44:40 +0100
Message-Id: <20190722134438.31003-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update MAINTAINERS and .mailmap with my @linaro.org address, since I
don't have access to my @arm.com address anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0fef932de3db..8ce554b9c9f1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -98,6 +98,7 @@ Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Jean Tourrilhes <jt@hpl.hp.com>
+<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..bded78c84701 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17123,7 +17123,7 @@ F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
-M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
+M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
-- 
2.22.0

