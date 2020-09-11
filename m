Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EEA265D6B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIKKKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgIKKKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 06:10:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8342C061573
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 03:10:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m5so6292020pgj.9
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hPzTv5PUyGLkSW8UuDMFR+2RpNiuulU2ieyTRUk4mis=;
        b=bn2mA6YmBJrZ6b99UWkrHSDusKUyorix+rxCD6fpOvgkIu7iLxuzAionKqz3grNi76
         YxP5IX83GGeTtlkbruGgkeTG8BihF1LV+Trhgwjww8gkh8w+4yzjVeNk9chp8J2/QZ7m
         Jyd8tQQV1amxqnHrNFTnxuXXS8Pp4Cb2HiKkh91NPOJ4jBjYu751ipQd8T8nsemZM0gu
         oZ5+e/3DC63ypvC9Q8T3fWQZd8/o9GR3zKRtvBBQ4SGWRcRRy4bGP0AZhFTzYQgvrFiB
         JH/ONdkEN7zJsv1tiM+R6aQgUYoH3HhM+z9+9wlQzZCIQMjIUC9gZTwnP8f4VNRMvlch
         9asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hPzTv5PUyGLkSW8UuDMFR+2RpNiuulU2ieyTRUk4mis=;
        b=JPyOKbMjuj8kLJvastutiO/fqbPAq3q8V2bGoaliNsdZMlWialMCY7ntJt/zYNhONX
         xpnQ1SSR2uM5JE9Hzwjx65nFp8X7WHwApTU2cFdqIsDTvacoqkk4cKh9tu8y+jPZoIE5
         gidG/0cLIh391Z3RX0R+TwhNGotW/yHCGWHHqG5mhOZfYpBYzXZaTba/3gF8x+5HE7KE
         i5q+/kf6Mt3ol+FgOQXY9Z7krZ2HjxbNcknwDLN7q6QdhiTEVn7dN81ker4oHRNQGVp4
         gh1GIxVQvrObS+h/j/dGlumbW0VUhRXzeBrDM1aTQ4DtlZa/NbbhEVo4WNemGlSbsbgE
         WENA==
X-Gm-Message-State: AOAM530bIFA5xfI+WJ1W2OKzwiboyatRKbf+08jcD8TUitPh9uSK94bW
        6Q4ZPh6eScDjk0Ifp34IVgU=
X-Google-Smtp-Source: ABdhPJw2oObVlk+gCEpO5YoiX9ZD4bFKHF46cwsectJp6mg/xUg+2D7/qVX6sHF76NglNFO3/36hzQ==
X-Received: by 2002:a63:500e:: with SMTP id e14mr1171432pgb.36.1599819012305;
        Fri, 11 Sep 2020 03:10:12 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
        by smtp.gmail.com with ESMTPSA id t24sm1883387pfq.37.2020.09.11.03.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 03:10:11 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 2/2] PCI/portdrv: Don't disable pci device during shutdown
Date:   Fri, 11 Sep 2020 18:09:37 +0800
Message-Id: <1599818977-25425-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1599818977-25425-1-git-send-email-chenhc@lemote.com>
References: <1599818977-25425-1-git-send-email-chenhc@lemote.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't call pci_disable_device() in pcie_port_device_remove() during the
portdrv's shutdown. This can avoid some poweroff/reboot failures.

The poweroff/reboot failures can easily reproduce on Loongson platforms.
I think this is not a Loongson-specific problem, instead, is a problem
related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

Radeon driver is more difficult than amdgpu due to its confusing symbol
names, and I have maintained an out-of-tree patch for a long time [1].
Recently, we found more and more devices can cause the same problem, and
it is very difficult to modify all problematic drivers as radeon/amdgpu
does. So, I think modify the PCIe port driver is a simple and effective
way.

[1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..1991aca 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
-- 
2.7.0

