Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636603A167B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhFIOFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 10:05:03 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37853 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhFIOFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 10:05:02 -0400
Received: by mail-wr1-f41.google.com with SMTP id i94so20589360wri.4;
        Wed, 09 Jun 2021 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYWDI6BG8IdRoFPaJz/bP9vC9WkcUEC9Y1+RTob9aXc=;
        b=b5m4IM3yjBet0AWST2O9Jpwxqjd2kDUCn92XMVhC72ujjOfkDoVI4N41Z0NTFy5VpE
         OglH+M9cHy9M3rUqXKcFYPNr3qBW51d5WebmAHdVIjFkUcfVn3F3Y8Q6Rxt5HpJl2DK7
         PFdUjeD0uO+NFVCQJHsP2sUMqtC5aA3tbVEKs9gJNFHh3c4rkVAe7k8QLlKkoK5QxtkU
         o3Gdi6kAVjOU2MnTvDPB5oFQT3IhDOoM/eJyQK9ABnYQvXqYBgT09bo29dStiR32Hakl
         onIiJnMpNpr6WheKCJTWb8PyeY+SFdBNaflEzsojeh306rMxNJh+2ipkEMCRXTL6/bRb
         6M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYWDI6BG8IdRoFPaJz/bP9vC9WkcUEC9Y1+RTob9aXc=;
        b=NNd2FnlS2I6499ZEdHcrcmTKgqKQVHdfgGVu9BhGGHSlhhcl9AJqXKvcsL+Btg+I9T
         cL4r76wJ+p0Tu4P6rO8Dznm3QU+Dj1gYW4cXwH4l6fSAfaxqpnKb3EYe6uLmSve4TDjF
         UctlXA1yxJx55nrcQ0yIa4Bophc3KETzItYC3HeslngeZXmtEvsKpy6mMHAiCS7T5VWs
         LRE0t47lMuQsNvI9Gr81tztaOqlluUjStwFocqv9y4M+q8kHbvVnyWlzrElDRNQTwaVk
         4B+3oc4+3HhDeN+L8+/Dae3cOzdP3H76JLHjBXQaULGurvZK/aCApdcgs+f2nNQJAdzu
         wJcg==
X-Gm-Message-State: AOAM533hFj/LViusQeXAmhJz5w+ty5gZ6J5gmXbD23zrFtweMBTOIIfD
        NmjX6x/yTRLCD6f8qw5jtbTBVDvj125Dfg==
X-Google-Smtp-Source: ABdhPJyyaptNj1K8oWVB9T8IptJSFw4/2SNsjIpbwawKmVfW8s1K4w8ilEL0kkh4lazfgShnc3pfhQ==
X-Received: by 2002:adf:e401:: with SMTP id g1mr27533771wrm.415.1623247325881;
        Wed, 09 Jun 2021 07:02:05 -0700 (PDT)
Received: from localhost.localdomain (103.red-81-47-144.staticip.rima-tde.net. [81.47.144.103])
        by smtp.gmail.com with ESMTPSA id m23sm5673912wms.2.2021.06.09.07.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:02:05 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com,
        linux-kernel@vger.kernel.org, pali@kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
Date:   Wed,  9 Jun 2021 16:01:59 +0200
Message-Id: <20210609140159.20476-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
References: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
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
index 9c55fdcc1514..2e58fba01289 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11574,6 +11574,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
+MEDIATEK MT7621 PCI CONTROLLER DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
+F:	drivers/pci/controller/pci-mt7621.c
+
 MEDIATEK MT7621 PHY PCI DRIVER
 M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
 S:	Maintained
-- 
2.25.1

