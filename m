Return-Path: <linux-pci+bounces-8778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1552908014
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF5E284359
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63B138C;
	Fri, 14 Jun 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsZqBfOG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC479CC;
	Fri, 14 Jun 2024 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324008; cv=none; b=KjTwHSgkLD+vgjG4Krw55irYvqcMPn+i1BVUFu/AM7MsyKmgxwQX+Jzxs0EXA1BNPbFxTpy5E3sJAbXLNy2WQu+2LgBk8cjCJtjYdQNg31OnLzcso3Zi1MVNkhG1WK7QhvdNWHf1L7DW5/miJZx0lcNZ4b8acp5gM9nTLz79j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324008; c=relaxed/simple;
	bh=ZNdxnGPfETJa9uUYOCiuRxUSQF8J7Opi/FFw5TRGvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx0GGGgMEWvLcTJZxvtHDiCjFV7AGnCcKmR932vf/IMVXgEsFghWzOT3rWY/dXj04/bpb0Ug2e4mEyzOBH9xiDFi573u+x7fhOfR6/gYy+XUVpE5T6X4XyAmjKfQ8DP3Pf2DVHUaXVH0UEI8Qt3b9WptST9AB8caQGmrLKmNNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsZqBfOG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4a5344ec7so11713165ad.1;
        Thu, 13 Jun 2024 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718324006; x=1718928806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=CsZqBfOG8GdOFwpR3MOkurfROCV/m0R1g4vCqXJysvj/iKbMIRPCoQMUs+EmNCCW0y
         /7YeRbhOpa3K9Pk3HenY6oTDDslAABxU6Ys36E1D3rLXe6WZP1TgMKDlWJYtSZ4Klgcp
         DiNPO6v+qDrhQXBEcwyANdxmro728vXQT2x5ff/LP960clGe5vFUvVe1bw6TCICOfkRA
         BuAjIx1aEM/zi+aHTQzBOmdGnjWT8eN93mQGlf5pvqkmunRryUf0W0oT8e5AG4rslExn
         PGvMBofaBQafNdTrYF3+7H07yr9lIZDiPjLPbkdai22SJ8tFmlPUX6Xwt323RcTIKHrc
         Aq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718324006; x=1718928806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=hJC5AJSWUoWeKHs4HYryaX1REAMoYa+ZnnnrAzxVnVGo/6G5oV0eYpDyEM/sQLedfX
         0BzLnz//yHzeHkDYW6yAyISCtm+BiLx2mIs903ubb3xfeyQOdDnTHyHBCjt1lzkK3e5O
         wNNnbZVBr3riL0U6DGdPX25V2bgVUOhQG1Q+hDgs0kj6P3BlZX8b60LETaNvK0BwcrvL
         oz1MVeOIJAkFu4Qww0hUUamALm/kWHwDb+dCwfLjIOELjLsc5wgVEMmNrgH2kCIbSDBk
         QGpyNiZNP1yAlg7Suot88L/8NbtadoaLHWdfxDKNrfHiTIO33VJzPgL/+hg7UokFujqr
         J5+w==
X-Forwarded-Encrypted: i=1; AJvYcCXn0RvcWD1NBw1WnGpCqgP2c9ZC567ReH5Sod17n/k0c1F5W+2k1TFwG2F2BLn0X5PsooV17eXfGA7X2BajvYAS1hx2Y+Y050we6+uClpver9c9sd2gztAuX1kO+hAupRWRfbwH7uiI
X-Gm-Message-State: AOJu0YwVhHaE5Mv6JjwEWXHz0YZ0T0QjpEpghn636PPhI/GXcUv78LXg
	5S3dhUPZpgXsHdGly60DH2aGsMI2BYLR7NHVyoC1ZrLg+Rj11AlE
X-Google-Smtp-Source: AGHT+IHV66hdxIk4FdoVf5TEz9N1HpC3FiYcdViyqhtJ9a2ua0TTNtVl8s7Aejf2W/UcVRYRkUWe8w==
X-Received: by 2002:a17:902:cecd:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1f84e2e43f8mr59992335ad.18.1718324006444;
        Thu, 13 Jun 2024 17:13:26 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55decsm20181815ad.40.2024.06.13.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:13:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Fri, 14 Jun 2024 10:12:44 +1000
Message-ID: <20240614001244.925401-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614001244.925401-1-alistair.francis@wdc.com>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..09d3f5c8555c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,7 +122,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.45.2


