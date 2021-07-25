Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8E3D4B42
	for <lists+linux-pci@lfdr.de>; Sun, 25 Jul 2021 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGYDWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jul 2021 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGYDV4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jul 2021 23:21:56 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BCAC06175F
        for <linux-pci@vger.kernel.org>; Sat, 24 Jul 2021 21:02:25 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so1416797oos.10
        for <linux-pci@vger.kernel.org>; Sat, 24 Jul 2021 21:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSKQIS1eXHkXAAiSsxbJmy25M4G9M0+9BKL+NlEs6yQ=;
        b=lOGiCRJZFY30dtNS9yNCiGC76kgyvvX87Vw5dUDuXbXEGqlhJiOC5fYFX5QMxV0YLR
         Hn6ZNfB8hRF5ePLZc3lueHbwVAT19MKi1Hxhkv0guSLTa17V9t48BwDoKuIXuYwkOBN1
         k8DzhYI1YnUW8LbXV17+be/uzL0mKLF6SID9kr3G4o6PjVNCLOC0ag2yRvcArbxFaIwS
         BLh1YE2LvBs/Pi7R9cbWz9zFero8TsPYqEaUYUvT9XPbuhe7TmIrrIiAoG0MRFAuI8FH
         kBktGgfmJpcERrk/Gaqz/IpsuY+78jZzhNnS4ZGtMFLxve9ZPpF0HXG0lRRG/vp9R7LO
         s96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSKQIS1eXHkXAAiSsxbJmy25M4G9M0+9BKL+NlEs6yQ=;
        b=dSmRnrgQZJgyi/1EmkC8k6O8xgj0MPmsgJI0fnIJbXWL6Ey+ocpsLlVYyOW/y3/XWv
         WZcBbWqBjMqc9yUkaLVw2MBQdvfZWYKkT2sKWCAq0xHsfaiT0Ge6wfl5PAJvDDV9wbfJ
         6+uoZLNeNEpZYmIHss3zCk3eB8fuVXHvl5PwNy9aTY5Ioy/jueOS8cIN5avKmCE2s6d/
         uGJz5tvrSp72rXKvQzsZGoo5pfRvtizVXt0d7dgLDZKuEzN5g6RSbwPGlVIRI/cQPESW
         4i0g97BuhtZ1nsTkP8MQCDrHQajJjpLY48JNjNkdu96eHTupHag61g9py6ZZsJYf1Qs2
         Hd8Q==
X-Gm-Message-State: AOAM533P2YxdQ1j5vsLus3QlwaySeQLuVXsSzjxAeAAFJSi9AJEKPMxV
        8ZCyyv4OIygP+b3yBCHbB2h9nQ==
X-Google-Smtp-Source: ABdhPJx2HUDLQrOLavGF/TIF+2KoSRtMvzbA6aYnA7qBQVSfe8FqWCX6VIgTP2MBPBOZBPTxPMKqbw==
X-Received: by 2002:a4a:4fca:: with SMTP id c193mr6882870oob.33.1627185745129;
        Sat, 24 Jul 2021 21:02:25 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q20sm872910otv.50.2021.07.24.21.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 21:02:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: qcom: Add sc8180x support
Date:   Sat, 24 Jul 2021 21:00:35 -0700
Message-Id: <20210725040038.3966348-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SC8180x (8cx) platform is used primarily in Windows laptops, the platform
comes with 4 PCIe controllers so far seen being used for NVME storage and SDX55
5G modem. With the PHY already landed in the QMP driver, this adds the
controller support.

Bjorn Andersson (3):
  PCI: qcom: Introduce enable/disable resource ops
  PCI: qcom: Split init and enable for 1.9.0 and 2.7.0
  PCI: qcom: Add sc8180x compatible

 .../devicetree/bindings/pci/qcom,pcie.txt     |  5 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 74 +++++++++++++++----
 2 files changed, 62 insertions(+), 17 deletions(-)

-- 
2.29.2

