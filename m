Return-Path: <linux-pci+bounces-21086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E4A2EDBF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 14:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30077164985
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1F22ACD7;
	Mon, 10 Feb 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW/b1BF/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD5226556;
	Mon, 10 Feb 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194079; cv=none; b=Vw1Bh2wq/4lUJUGQRzBPBuLFs/icJHSllPdRIH6euxUWXuEvp5zYcgqDo7k3LwUkxRTBIQagDvpRCTF2Dw+z7oSfLvVoFC2WLbJpgyLZYQOnWsmkBYy9EnLK+Hk6pROdc6ezYF5owfIRiZdmg1CWrzpHKhUrYIoK0IMu4CBYhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194079; c=relaxed/simple;
	bh=CiR+HgbiS0K621jeSeHl/IyevROTAvae66fUMHGnnhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILDS19nuvE4aukzKIrzvh/PGkR3OdjPabdHxkB3yyAw/fTlt2JPsFqP71y2Dk/aJBrO3SK0k2k9wJE1UMS82gzof6sA24esAUJ0v1gKOOLuYR2PqwmW39KuUqnIpGohTByJhAnmFSudyeZma8U65hk4RbTu+bLCala0SqnOYNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW/b1BF/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f7f03d7c0so28728435ad.3;
        Mon, 10 Feb 2025 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194075; x=1739798875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubRSzCk6q5c2M0vwji2U808p06F7c3BS9spIJHc3OK8=;
        b=iW/b1BF/GcA/IZ8tHTsp63GTwplqLBH/EyGdrY6EjxWjvL3DzpS/e6l82sGtr8ah1K
         OnLr82SV/lZdRCbok6mFEjv0AeUvRuTx3qIkA4k8Qa4qbY+BvC9+WpYEycr88TOVcBa5
         cNfemqn+1wcuVbMilCF+IHQ18e6wRDdfo6epGobCofs10s9B4EJRKS1jlGpLCUB0Al2E
         qfvAB8AFGwANKHm3/Z0B4oQSj8+Z6P8u/xjjC0qPcGX4a4yFSygw4rGTaLYXstyfGLZg
         mk0Xik9gwbmaV/O4myzpVcxW23EWdwskLjlOtQQe5w9em2vjwjIWPu6By9Dirq9MWwri
         RzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194075; x=1739798875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubRSzCk6q5c2M0vwji2U808p06F7c3BS9spIJHc3OK8=;
        b=V4UuhW8sTekZ6qxTf70lfcIZNikNhJlVUr1TLJM/cwyCa+Xu1K/HvA816OD7EvvQBt
         b4TXIPv+1b8R5sALl9NjmorkhxBvH47jbKND8aclY1IZi0zhtuD6ZfVuLQ26FXTvVD+Z
         qeeNVZxPzmL+113CHZsQM1rqiqsdo8zvpT8EdiHUzqqNw6BV82oj+2O7Xr9yJjw9TlU0
         2rmbrH106FJKNTNGR+XyLWay16TdRvyxlNL88oNn7E5PFl+FPsjGbgV4AHBf0tH8EK7C
         5qlZXFVF49Uh/sGtN6iw7XjsTiprzt+a/0KfB3oTrbD38vRPTZoUodBAcbdjXCrZ9/Oe
         RVKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnuT3r3Bdahuo8+tt65uwjRc30oiGgCaapGnCWiYPR5JrwMe9YciyBWGG0KNndsmudBWpxs5aLHEbSvJA=@vger.kernel.org, AJvYcCWdIB8qPShi0egPQ1jnjU2ljJAyOCmLNRWmvYcjLqukPrNgMUZChfFPdJp7ra8kBamSa37XsxaUNwZ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+b76tuyqs/Qdl6sU1x06whBi4ytsP6TyRdETwsJigb14wuoOX
	gY6/gzD6TSysmgkiGlqNbEJTtvkVvpIqTB/5C0zUAUDgjFCtw64t
X-Gm-Gg: ASbGncvzcxfRkQppjhrX7p8YKzmXwh/JIw3yGCbd9roFv27NH5mFtZnDxMcXuaDYqKa
	MSNwWBLxMlSrtKQmuBER5lKAQBP+qZMTHC2LHtdjBbBjdCb9ttThUV+7lKAX6o8BuWvFZh7rGTF
	5FkArLJLm6SYZxs/pwRjtHihw3ViDbdLPCCSloNaVPbmD4YpVWz/bvixi2RKhaGvLZgUUpLg6o2
	A8Fafftu+HqaKD5BlyR/Kjd5j43sLVf+v8N1mUTgxOluxcAYFRSQDpsg1Pb8NDVebh1CyL+Lj+W
	yLl+bfi4gH7TXrjVHwQ7ePVDM3xkw7Hl5V0LBiN75Ib9Ck2jHA==
X-Google-Smtp-Source: AGHT+IF1ysCGiVZVUpmixEaoArsHTpIbBaQycUT/Gl5GL01im2JavjfdGsazKjD0vFa1im/Htum5zw==
X-Received: by 2002:a17:902:f787:b0:216:644f:bc0e with SMTP id d9443c01a7336-21f4e6c899dmr261317015ad.24.1739194074584;
        Mon, 10 Feb 2025 05:27:54 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:101c:99b7:922e:40e8:90eb:e462])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d718sm77534305ad.154.2025.02.10.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:27:54 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: bhelgaas@google.com
Cc: skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] drivers: pci: Fix flexible array usage
Date: Mon, 10 Feb 2025 18:57:40 +0530
Message-Id: <20250210132740.20068-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning detected by smatch tool:
Array of flexible structure occurs in 'pci_saved_state' struct

The warning occurs because struct pci_saved_state contains struct
pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
Arrays of structures with flexible members are not allowed, leading to this
warning.

Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
instead of embedding an invalid array of flexible structures.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a7..648a080ef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
 
 struct pci_saved_state {
 	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
+	struct pci_cap_saved_data *cap;
 };
 
 /**
-- 
2.34.1


