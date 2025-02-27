Return-Path: <linux-pci+bounces-22569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3EA4823D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5041617DABF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7425D1F4;
	Thu, 27 Feb 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="kxuWw/FV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9D25C71E
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667831; cv=none; b=UWQFRCXGbff24SQoZTs/gQHfsr+Vqhx9WFQOHjpE0jimHrv8b2/2hhFzZ/80BNURZIeoiD/YiTLH6moxEav34LDSeCiqq+9w+u616BGkbVtEb9yle0mVo2RLqakO8ZZGi7ioPivRKp/QSM9n+1nTbFpipw9ZyM32rVMkMeEaKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667831; c=relaxed/simple;
	bh=xKewhvd61D34B7/4mI+vcI04M2ezWfrHW8vP8EGROvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM/ZcDLamcJKVoqAqv5UecHx2Hg6xsUtGkHF4xZd75CeBA442rdh4FrqoFhEy6pE5ws5hHISEm+dpGHUiuTRRc8Tr5IEO4kwT/9imXljuUmhdTV8yZT6tEfWne0y3sgp/KXZ7MoHJLasos1arR70NNFwFmFRoUTK8DDUb42+2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=kxuWw/FV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1486457a12.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740667828; x=1741272628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL7GQVjUzjLg9lk8430dC5QosMySgAdQwlmn75yWWQY=;
        b=kxuWw/FVYEmROqj0tTxz/1a+8VKWaZsPX54cqhdTCArS21r2M2TNTQF9tQRRq88wQh
         GJPMY9ajQ8SnqJwo03yn+pXW3gGkorjfgGKOeX6WMDTs6mlP0FcGuXGm14QdhbSFSxW3
         AvwEnTDcc6mIktKGUGvi4qPH7TbxozgSaVTDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667828; x=1741272628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL7GQVjUzjLg9lk8430dC5QosMySgAdQwlmn75yWWQY=;
        b=c9CYsAkSCI1Czz9O2ySbpMqeIm4xtfIukE8PRCVExdJwmVAxoxO6P5zoMTSeHj2fRg
         IB1fJx5J3zletZrkNbMoGgk1wTg7CI0h4Av8jNVXv2D6PbgwcZudjFp11Jf+1SHqWG5H
         BSfNvbYRGvbo9sF9nu3pTXl7GwCwxddzo57QoFIJSDu9SVARv0bTaEve4UpDt0Epyy5+
         WLWvycPOSO5Xc6R2u42dhGKUm8JvOYQV1UeeDx5O5IAk2jFunChaTH52JZqHYur1L5CG
         De4LTrBTW37FHe3nlh6PiQMdL0a+DhC7sn/1B51YRWT12O/8anQbjcyQevI69RMvh0Jh
         xCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsZwruSAmBpLGyVJCAnBgkk1cepidhWBucSEsyNHwVXV7pKegJmTyhKBimtpqzuIUL1oXuWKr4rzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbyWqFe0qVZpTike4ezFHKju1AFDoczB/KfPn5mgTwdoXFj5Zi
	Rln4hm9AjJpjMuCr1Iwsr/E6k+25e+ondjNEke7M2qU0fxD6FIcDJwK3oNZVHao=
X-Gm-Gg: ASbGncs5et0WYphiElK4OoaAblW+D2zYunRq2K7pDiHXb5Vj0AyuzwGizttbjxK+Be4
	MWd+T6UDwJU69PnszH29+rCWKj36Vrcv61/GIIP9eEKa5Ed5dqF+gSCejviRlHA0qbJG8EH6sYX
	yUsR94VorNa6iWdnUr5KhUXNpT+c4py8iBy6mgrHvib8sV4fthaaLXLAwiKzfavaybAUvxthWf1
	HXBs0c8p+IdxI3UDMeG4nwdbYt+u0ldEROzG4J4artVK0fGuS35U2dhHAbPpFCeYqhvW66gLuJO
	0jV2Mc2YY/r/3TIgXHs6mpOYz1iaC0uGBQl1lvvGqFwgVLgLt3I8hLWlxMg6ZIFkHQ==
X-Google-Smtp-Source: AGHT+IGRvMe2rXEL5ocoy5Zl+QpTBISfmDkxZx112r9QomOkAyIB+XxUpSAYrFRY61XCOHlRKjn34w==
X-Received: by 2002:a05:6402:430f:b0:5e0:4710:5f47 with SMTP id 4fb4d7f45d1cf-5e0b7243e16mr27359409a12.23.1740667827673;
        Thu, 27 Feb 2025 06:50:27 -0800 (PST)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm1169710a12.53.2025.02.27.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:50:26 -0800 (PST)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	"Juergen Gross" <jgross@suse.com>,
	"Stefano Stabellini" <sstabellini@kernel.org>,
	"Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: [PATCH v2] xen: Add support for XenServer 6.1 platform device
Date: Thu, 27 Feb 2025 14:50:15 +0000
Message-ID: <20250227145016.25350-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225140400.23992-1-frediano.ziglio@cloud.com>
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XenServer on Windows machine a platform device with ID 2 instead of
1 is used.

This device is mainly identical to device 1 but due to some Windows
update behaviour it was decided to use a device with a different ID.

This causes compatibility issues with Linux which expects, if Xen
is detected, to find a Xen platform device (5853:0001) otherwise code
will crash due to some missing initialization (specifically grant
tables). Specifically from dmesg

    RIP: 0010:gnttab_expand+0x29/0x210
    Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 fd
          41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 02
          <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
          44 39
    RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
    ...

The device 2 is presented by Xapi adding device specification to
Qemu command line.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 drivers/xen/platform-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 544d3f9010b9..1db82da56db6 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -174,6 +176,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
-- 
2.48.1

