Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF53818D4
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhEOMmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhEOMmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 08:42:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96784C06174A;
        Sat, 15 May 2021 05:41:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so1729597wrt.12;
        Sat, 15 May 2021 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gl0Loi45vxYJXDAYqv7bhXjrZcnq3MqdAuvq3JLbE9E=;
        b=cLwjdzAiJZXo6DcfOhUjRre4kKcmKK3cm7NVcKaIOQoPIBjPn56kNm3XQv4g12FLO0
         WlO6gF1mvd6xAa/LKboqbIcZFeGQEu0LJ/fhebUwUV2ME+im/jOHuENc/5KTEBk2wG75
         XBacoJ+oA3qsJcIDyFb9/+OzFw9lUrK6mI0Ti+js2B3LAAURbc6Fa1vgdMPeOv2UpbWy
         IO6Aaj20ZOPg/Mus+DnR+hH3m1vVcPNSiBj5rdBnTWZRQDa4lZbjMaxiBn5peUqElT8i
         QfAxTYvpkclodRqjto5+jykKe0vgAfvL6dq/0yD+GycNKU49/MjQFshM1rheJXSqi6Gq
         lEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gl0Loi45vxYJXDAYqv7bhXjrZcnq3MqdAuvq3JLbE9E=;
        b=GolaGUMSHkmdc67UhwvcDp7+NpJPc105XXvGbq9FE/j1fABYIW3N59XkoTCcLvCG7J
         pSRUQtjzh8ZHEhZLV9MqgrJbVQVypzRhjRXKHFzHFOyMPazLeKEm+/OcMunxMFaDkHYc
         zGTQEcz5Fe+00riCl4ZDZ3XmyrlItcdFhnNhRzYOCO3XjwKAe8/oI+TEDJB5rD7LTQtp
         biuhuPwlGR3uJR7lpGeYwYqqcjBTv88o2/ctKq0cHJFk/mZ9wrWu+W7h0uxL1xOz7GN1
         AxsCB5BWmD5p7ILjcXWrZLu8C4fHezqNa3kiCYRDhKLcVcqIGOs9g9B2shezJULUZ3Z/
         AfTg==
X-Gm-Message-State: AOAM531uzVYfBzlGMguK1d1d2WAcmz2sbMDUasyXVjALHV6d2fqttA3U
        A5RHcVCODWdvoIl8u0xlbiRIY2R8h6Flqk/H
X-Google-Smtp-Source: ABdhPJx83NTgI2UIBF3sR+lRqH2zho+b7ycTz3fiD63Xfzb496ZnvCT/HGS5hs7668YR4nCdyZI79w==
X-Received: by 2002:adf:ebc4:: with SMTP id v4mr5585940wrn.217.1621082462223;
        Sat, 15 May 2021 05:41:02 -0700 (PDT)
Received: from localhost.localdomain (29.red-83-49-33.dynamicip.rima-tde.net. [83.49.33.29])
        by smtp.gmail.com with ESMTPSA id w7sm9472749wru.51.2021.05.15.05.41.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 May 2021 05:41:01 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, john@phrozen.org, bhelgaas@google.com,
        robh+dt@kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        ilya.lipnitskiy@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
Date:   Sat, 15 May 2021 14:40:55 +0200
Message-Id: <20210515124055.22225-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add myself as maintainer of the PCie Controlller driver for
MT7621 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..312ea2cad79b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11562,6 +11562,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
+MEDIATEK MT7621 PCI CONTROLLER DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
+F:	arch/mips/pci/pci-mt7621.c
+
 MEDIATEK MT7621 PHY PCI DRIVER
 M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
 S:	Maintained
-- 
2.25.1

