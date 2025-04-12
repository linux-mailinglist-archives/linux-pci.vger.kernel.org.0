Return-Path: <linux-pci+bounces-25713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17303A86B38
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BD31B85B10
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24B187325;
	Sat, 12 Apr 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUJf6KBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB756A2D;
	Sat, 12 Apr 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744438221; cv=none; b=bWiHGVtYFRX/05pU56MBF9EPNHA+YWWhu142u1uvKCHkGRjJYYM+IelDiWd2BrpuIS9F/Z4zCikMlcqBMn3nqyzHEL94KW0za3giSUlt8fkUSI/Vrpuzw6eQ2+jUESwnOe6xb5uw8tQqQQpXRbfuOkGkL0gAVigeZe3sUAfdJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744438221; c=relaxed/simple;
	bh=+L41gmr9GY2a0j2/3zIF0m6qP0TqES8j7naIIvECLPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUjwjJgsuNTPTm0XOC7pewkO10Cd7t4T2MV8U92E6X30XTgWrHSlGg6rt9DzS1lmeXxWc8pzx/ktBnjVQPLM6T1vJ/nBGOcE8FA0r35cKwgk/BY1BO+Y8Otvu9nI0MAUoMOuylDhyfGdxw8HUqiU8JcBbPqaHlGjJ8wFx66TFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUJf6KBp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so3949018b3a.2;
        Fri, 11 Apr 2025 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744438219; x=1745043019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVNWMzhUv1sB3IFRx/3hnoeslHEIVBXstwaTsoFrumY=;
        b=LUJf6KBpdhemC+8kErztCd5ouZYBAziH9H7XJL4cKC5HwQjlesIyy7fip6XTIzJNij
         ReVmlSvO4okWqvdyZWZUBAI2q9wVQ/Z32MM6B7J/31gBiVC6Qw3OXsK7Nea3tidT6Hku
         maBlNxH2qwOG5uVNxmto2NlzpK/z+pkL+KjFfCYRzQ2eiyZC+98RyZP0+7MijbiHGFCj
         mzYYBVgVTfRP1r/2PN8DInlAoRGB+jVv6DuRahP9ZWeZDhqsMwjEgTfLKqDZ5hWEtdgq
         xZtXkpyAOoprVjNjc/YWhQHXzKIw8ANp8VLbzRYF6v5hnn1oyEQevGlab0jUVMMR+0zV
         KjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744438219; x=1745043019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVNWMzhUv1sB3IFRx/3hnoeslHEIVBXstwaTsoFrumY=;
        b=Mn+P6p2Qiga6BVxZYHcOkXuVN86/5XyVHGpmOaPA7DI7lj4mtAF+5g8WVGSHTBJhO9
         tbqcVu/wVP3c1zanDZpia4/b5+q8E/KtXWtWuWjnM0QsXMha3I1KbkKuyBureZcSWx5n
         CASw85tvhc6ss3O1NoVf1LC9Tmdje9WXnpxe/CF1RuCxjAv189hHGlR7hFXzeyrphgBd
         z6usO47WUCLa8MXdlN+Udjv2Qc5X8JJ+1y78afmC2kLYEHQaQ+IJeA5GCFBZnlNWApOx
         AZMZXhjcLI5Xsbc6XxVU+urC7ozu3/hv/lL56/8Sddo5TzYebROoMss+X0+cVuQL9Tai
         cKLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCarJ2Tp0O+LQ/AsmtPGl5MjMlJQm0VYX/F/2In4/QveG6CRyNQY8ypTrvWtwt/AdP1sucQgxaMAWGcBg=@vger.kernel.org, AJvYcCXuJqplO32DOFA8S0eSmrA9HmtlhSDpQeKe/0BYU6dk5b/BQRMWaCSUs6/RYJ1FdfkNAkhtcxKRC2oD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3gaO1bMYYBa2m97jBW30+j66GOKGujY3uCw6tdbPUSu/zlhe
	59sgvPdVtI5LmX1MFsc4xHOBkZbCxS+I3G9iCRYtmjtgBSUcuHZa
X-Gm-Gg: ASbGncsJCb+wtpy8Dfb61OjpK79H0LXOMI9NU05ihDKwWuo4W+nU6O7hLwObgwGa61d
	rbFTbaQ1Jl2CxtBp6s5RP0k9dJZHN63WJVvOaUCncThtpNJVI1SFRFqfxo7r3Z+5AH1fDF64nCn
	0at0ZKocprxl7ur/E1wSmIDFo/NPzI7lwC1JutTFis8gI1axy8yX+Mst/VXFx79PTdNRNIuhM2X
	meYDXJyQcX4Ufty9Bf1hVChyTEdbrbunCdedJn5Z7kZvO4z1wNQOkLH7jcIdXH7t1X+RXSBaKkt
	pF0RSAYA3JCxve6WagAlG8WDZP76Tnf8Yyx8xcNVcskcIsg=
X-Google-Smtp-Source: AGHT+IHa+43R3N2ccAE/i6roRMPDUETNPoym+O1GXJ+ITgbljmlrpQ+kfO/8ZRwBz24S/E5i4rLF8A==
X-Received: by 2002:a05:6a00:8d4:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73bd12121b5mr6828784b3a.14.1744438218909;
        Fri, 11 Apr 2025 23:10:18 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2335534sm2694240b3a.168.2025.04.11.23.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 23:10:18 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de
Cc: alistair.francis@wdc.com,
	wilfred.mallawa@wdc.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org
Subject: [PATCH] PCI: fix the printed delay amount in info print
Date: Sat, 12 Apr 2025 16:09:35 +1000
Message-ID: <20250412060934.41074-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Print the delay amount that pcie_wait_for_link_delay() is invoked with
instead of the hardcoded 1000ms value in the debug info print.

Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait
time for slow links")

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..8139b70cafa9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		delay);
 	if (!pcie_wait_for_link_delay(dev, true, delay)) {
 		/* Did not train, no need to wait any further */
-		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
 		return -ENOTTY;
 	}
 
-- 
2.49.0


