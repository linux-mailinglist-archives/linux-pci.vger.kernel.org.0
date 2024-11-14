Return-Path: <linux-pci+bounces-16772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095A9C8F5E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4668C287A6A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3814F104;
	Thu, 14 Nov 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS4FG+ZL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD041C65;
	Thu, 14 Nov 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600640; cv=none; b=BV7UBdZVVNLw/GNmBpeOf7fDVPgsiTArBEavVk+9zEeNHaNjsqj0ijzdG3pTGP6k4xeMdXPuZlVYsfaWF5FSr3DVDlDpbBKcVi/0uK8auQ53UTFwxNoxAl1c9dF7LOqVMtektaK1xi1VQx5HFwrGo4HttgGJwN0slVYD9FcraEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600640; c=relaxed/simple;
	bh=6X0ip2xzK2zvQHasehNO1XsdSLaJGiZMfKgw06myvPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eEFsoA9xW+g6sxRvChpQxsJbYcoN3xWeP7P6s+Lz3Hyu8jOBx4AQnw+lEd8jyc4VKG/nwVP6VwOJnlWg5xd26qhHmOQXUPqDE+2sIT/c8qY/KUIRWXcNVWdjuYWENJ5kBLO5AbaOItEKptzdu2MN76N1XXcS4dwi+3SCa9vMI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS4FG+ZL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so874716a12.3;
        Thu, 14 Nov 2024 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731600637; x=1732205437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owfyJZrITTZA6raSYGh4BS1qS3LMcPFoV5APoduhw1E=;
        b=hS4FG+ZL//pz68lK+aNIZGPts9rJsRP9a9XfH4YlsMRbSL4lysCXYDCHhj9BY0NuwD
         l1a6eNf2DlVFbfYcRBfOkTtzGRSCQpUr53xHTbq/et95tLzlZ3Y0DfXSutdEno0LUpXf
         UfI5kxgEQQsxKOI4JzS2PjqeG40wjjivpZnZfMpyd8fQq10WmO95Qrkh7sfakqOKVnbI
         3ewKU8PsbmS7xZerOktKv2hWGVZu1zwiprP1lzPvnVReIrsfki9NDJJw2DDCrwEa9ICm
         J9tC4xzEMowjBav4iY1YURPiqvxXcy66oVYdYN/ZRKke4iw88lYgzC3V3l1OQizmoiNs
         NCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600637; x=1732205437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owfyJZrITTZA6raSYGh4BS1qS3LMcPFoV5APoduhw1E=;
        b=VFjVaMj2NZvkFG+QRY+vkU7TFH2zyahXcQlRE7cbF/GN3mds6vqDN3oJj9vWCEgZMF
         /Bb8OlCCvMm6Mf5U1xls6G2zYbNQR+jAeqMhDueM+6Hxl74UzaBckH87M5+VF6pzVR31
         H41AmVz0Yx/zhuMvibub9KXqfyLQWN06s2FONssMiQzXLQWB5LqxYAhmqAZVhZunkhyD
         49WZOq/+hDe8cIAd0JsCuIoEU7koMo90mLYWqzN8zGXtK+StPPCuH3Z/i9Jvek8/yQ7J
         sRj3Ok+IUeNUJeKpDaMijen+/QuqwaBQVQG3Dqesl6TCSJt3slEi6i4KdEg/zz5U3Q5Z
         KUdg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/6UlV63RhpLrhE3+3TjTlgpuQm24eYeSkohhp3Gy+2935g0HAGDQnCix7nPmiF21y4CWE54rmF+A@vger.kernel.org, AJvYcCWO5fsMLniqu4KDqQ1py3PD3CK/t4vxna7D+Ytes7X6CeJ2ick3tlyVF+Ae1Nv6lQGZk2YiXMV6u36f9Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjBbT0BH2oiZizYvgOlCxYTQCO7n2D4iRQRGZITSWK5x95o5i
	HmNVzSstcPF/Bs+RutB5sRVVUKI122tFoXkAaRXeTWg/TJob5ppK
X-Google-Smtp-Source: AGHT+IEPolZISw2ABRIDoVYQNF9Z2lurl7F2oT0JN8H7zJeUVBu7W0o6L26aMCc+mFV6Q1ZrVblZaA==
X-Received: by 2002:a05:6402:2355:b0:5c9:8a75:a707 with SMTP id 4fb4d7f45d1cf-5cf0a306754mr18384924a12.2.1731600637057;
        Thu, 14 Nov 2024 08:10:37 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9f4e6sm722610a12.29.2024.11.14.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:10:36 -0800 (PST)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix pci_epc_map map_size doc string
Date: Thu, 14 Nov 2024 17:10:32 +0100
Message-Id: <20241114161032.3046202-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because some endpoint controllers have requirements on the alignment of
the controller physical memory address that must be used to map a RC PCI
address region, the map PCI start address is not necessarily the desired
PCI base address to be mapped. This can result in map_pci_addr being
lower than pci_addr as documented. This results in map_size covering the
range map_pci_addr..pci_addr+pci_size.

The old doc string had pci_addr twice instead of map_pci_addr..pci_addr.
Replace the erroneous doc string to reflect the actual range.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 include/linux/pci-epc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index de8cc3658220..e818e3fdcded 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -40,7 +40,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @map_pci_addr: RC PCI address used as the first address mapped (may be lower
  *                than @pci_addr)
  * @map_size: size of the controller memory needed for mapping the RC PCI address
- *            range @pci_addr..@pci_addr+@pci_size
+ *            range @map_pci_addr..@pci_addr+@pci_size
  * @phys_base: base physical address of the allocated EPC memory for mapping the
  *             RC PCI address range
  * @phys_addr: physical address at which @pci_addr is mapped
-- 
2.25.1


