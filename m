Return-Path: <linux-pci+bounces-10356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E09321A1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C64B212BF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088A4D8DF;
	Tue, 16 Jul 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwIZIrKy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E9249ED
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117068; cv=none; b=ifRH/bfB6SujARuUMDuSgcPpyILNmRaqH0XTSbz1hrkU41SXhyt5UqhDDbO/g4KZCX6zPcAGh/kRXSOj7sl6W5RU9ZRtGagbd4Ty4MH852dgVMXltJcMiqyvm/t18B60ebj62edHI/HhlruK4CFmvzhPG6SCRgGe8Hr+nbP5BE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117068; c=relaxed/simple;
	bh=jsfF1gN3gUksixf9Bkiwr3QSTwWhwgdrGkomU57PBTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=boeMR/lDCOlXFEYOuZDrXySMXTrZlGyMxB3ehTw4sWevp+KIus/cvGOHgdPUde+0BcKTDbPUZne6MmWFRf+DdQPYcWN7n33Uj6hU6C4sHks/Lc2H3jfM8bQhyDJIDYOzHx4n9OLlRJptuT9+Od8xSn4yOAAEyPS0ytMpa3+Gu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwIZIrKy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af3d9169bso3574311b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721117065; x=1721721865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkM4AK1wLq1RcPgMy7pkSiBJt1X0LEeQgySlCKfgP6s=;
        b=rwIZIrKymIDzcpsxslMcKNCdiIj3EMzvGJEb3RzHUPHwaErKNDy4tWGKu4L9m6XJPY
         SSc1q3WyyU1PIJDttQ0dFSY8+zD8SYX7iGUR9B9tU5DLrkfiyLPOmqq76fTfWWo9uPKT
         Eq6Vkd+kqzg2oMt6dxAvyRSIPtPNQbmGlHiIhNNkoOiC1TT2g7GH5vUyHGBkufSdakU0
         530xMc05c68MEwqqS1ga6CfG5R2voAEiKg+9edQC8xy8O/8KLRTMqfnQIz3oR/wnZb0d
         GG0I8+PkKe5ZUNojARhFVA+FupK9vgQyOnlhQdjitt2wb1l+uqWSTLFcdSXPpEQo94K/
         YDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721117065; x=1721721865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkM4AK1wLq1RcPgMy7pkSiBJt1X0LEeQgySlCKfgP6s=;
        b=SDWvCWcSPe9SEzUeyB9DSFXJwYozom22p0LR2wcpqwTI1MlRo3BlYavVNGfwBo0isz
         LRMwyUwPMmKmByOSyFr1Ml6XCGWiW+yB2swV9GB5pz9gxTZZdNWQ+11ou70vOTVHvQJE
         Ql4JRNOSC8oIvNECc4lNyYdfdeDfutmwsGRRRk0u4TsND2mS7z25F65yApOMjq+BaWr5
         2MGZhxz0LYeE/SJQLwJgwt1cPVG7szN+sWwoe0uZzhGj/MuAEsd50Ch1wVDUgn2u2SHq
         gwO4TjjqcNc9sYTcGiwaILioMuL4qeqkEXG9FhZZ+GMYRV99IxkrDH2NEePFonWbuJ4Z
         5cIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZbXn+hAFmjl96qQpXambSOw++1zpNkunTOHyUn/odJVBc5UHIk4caz8lZ+uoQPprhd5ImrB4y5YdZpXu2LfUjwwrlIQm+s5Gn
X-Gm-Message-State: AOJu0Yx/336sTns+Pgup+NZ3ujKGjsR8y9oW7wNuKCP0APFQXuaawmnH
	O8JipjMBrif3OxYj/L0SMraeQV0O1ZFM2JPB184mFth+cHzIXQDVmMN+wl3DFg==
X-Google-Smtp-Source: AGHT+IH/I4iziZlSdOB99kuzzC+PST98BOa3riW9i/KFN3qAbA9Dk9mqTZn/53P9Ipc+jILvkWBKfA==
X-Received: by 2002:a05:6a00:a1a:b0:70a:f3de:3f2 with SMTP id d2e1a72fcca58-70c1fb71aaemr1798437b3a.3.1721117064611;
        Tue, 16 Jul 2024 01:04:24 -0700 (PDT)
Received: from localhost.localdomain ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc947fsm5701798b3a.195.2024.07.16.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:04:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: Check for the existence of 'dev.of_node' before calling of_platform_populate()
Date: Tue, 16 Jul 2024 13:34:18 +0530
Message-Id: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if
CONFIG_OF is enabled") added the CONFIG_OF guard for the
of_platform_populate() API. But it missed the fact that the CONFIG_OF
platforms can also run on ACPI without devicetree. In those cases,
of_platform_populate() will fail with below error messages as seen on the
Ampere Altra box:

pci 000c:00:01.0: failed to populate child OF nodes (-22)
pci 000c:00:02.0: failed to populate child OF nodes (-22)

Fix this by checking for the existence of 'dev.of_node' before calling the
of_platform_populate() API.

Fixes: 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if CONFIG_OF is enabled")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-arm-msm/CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3bab78cc68f7..12849a164acf 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	pci_dev_assign_added(dev, true);
 
-	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
+	if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
 		if (retval)
-- 
2.25.1


