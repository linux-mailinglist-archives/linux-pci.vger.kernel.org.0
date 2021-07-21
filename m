Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8E3D123E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhGUOnc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 10:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbhGUOnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 10:43:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B96AC061575;
        Wed, 21 Jul 2021 08:24:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so1211474wmq.0;
        Wed, 21 Jul 2021 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oi/kmLG+yo834vJn/MBYQrG1NfEUwztJBaDA0SorlMw=;
        b=GPPygBoG0okZabi4k2zvS5PJYSyAiI3ZvpEMup6Ewo21SE5tPZ9ry+/FdFaeISL7Bc
         6C60RiG56Ta8ZNUw6wo5CcrGvXvfzuHkf3VoixI1dsM6B0m7OVMA4Wv5B/gJhKBbCVkC
         0d39uqHuQrS5YlATH1NFNKwUIS1Ne5KcvDwzjOf6a1foUQuBzkKg0IlGbs59zzJlbugF
         g+1xoep1MxZevYMn9EoqWmp9RVieSWDnJfYE5b2MCo9v/Pa9fWtaLuwk6lkqjlTcjdWs
         9wdH7hO+KBjL0VqQugznvQINceZLeeog51Lhh3dTJhsAUstG3ZIk7MuD2meazqGYLiI1
         85lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oi/kmLG+yo834vJn/MBYQrG1NfEUwztJBaDA0SorlMw=;
        b=U8NXoktdBSJ3QlbNlOdAL1ZA22FzBvuzQLoA3HeR7Jvq1GlQjvAn4ScO6kMuOIyQ1j
         OcZLBma+vVXdbjXrJcRqXbx+LIci6dT36KApNW01G0cHEOTPfKTu/Xi0HTsOV12gFcIC
         HHxXSzOBFsgtRw+DeEDK9Cp3SrKUzKuxu0EUMoeks9vrZ6T94qpwTNgHKemgJheFSHj/
         5Tp3Y4v4Pc/d3Vbo85nXelTl7QZwkbjxqvG9a2yMqvNzltrBthb5M4kPIo393FoYoXp9
         0UkA7Jbsl7J54hha0rSuicICdCrqwE5kii2Wz8Fu7SEOze9N1mgXec9EUUKzEsdXZKwH
         H/Hw==
X-Gm-Message-State: AOAM532a0aNf0MmyJR3LOb8tVZlLmHwnM7m0Xtect9nwkyaPLECstPG+
        +kHa8ZwPrKJQ34F4rYtZADw=
X-Google-Smtp-Source: ABdhPJzUR2AgoD7KuBHSGj82WNYdT6Fbt0Qdp5E+r2m1Na+R4fuxAFwmQtgBNtidSvW66hH1r3tBLQ==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr4543981wmq.20.1626881046170;
        Wed, 21 Jul 2021 08:24:06 -0700 (PDT)
Received: from chgm-pc-linux.bachmann.at ([185.67.228.2])
        by smtp.gmail.com with ESMTPSA id b8sm221299wmb.20.2021.07.21.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:24:05 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: do not ignore link errors
Date:   Wed, 21 Jul 2021 17:23:47 +0200
Message-Id: <20210721152347.2965403-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This fixes long boot delays of about 10 seconds.

I am working on a device powered by an TI am65 SoC where
we have a PCIe expansion slot. If there is no PCIe device
connected I see boot delays caused by pci_host_probe(..).

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a608ae1fad57..82ba429246f8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -408,8 +408,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	int ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		goto err_free_msi;
 
 	bridge->sysdata = pp;
 
-- 
2.31.1

