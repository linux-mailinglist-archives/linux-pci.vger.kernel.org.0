Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AF1FCACC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQK0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQK0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:26:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A840C061573;
        Wed, 17 Jun 2020 03:26:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so1710351wru.12;
        Wed, 17 Jun 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUsNDRJx4UdhHJ9XZ2hWvZsvpKhRR87KicV5rBQcMlA=;
        b=REjFk9PljVEzzc8bmjLN3vf+ZmWBNUGi/7sn+3Rw9k9s1UO32qTb5nIbKbMQ6j15sJ
         IqSnMuNHZjEuGKuhFm7XR53lHucGJ8yVPgzNyeKhR5J2vKcc6MhDIH6EWOnpuPWR2hbu
         Ql02vpK5F2WUrK5Zapm2RmgkwtMiBRYBBJ8C05PViIow0Su/oqlpqx80qCmfTkedgb+w
         9leTVqNlADqzPADiijWc5h+4161ZBfc5/g8IMYgET5FH03vb4aqTstvNDnSllHiFg46U
         6EUzorPt7IrzMFksl6KlnRGHW0NyvGBji6ywZS3BYmcDkTypvKjS5aKb+TQomeYTEdFL
         fUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUsNDRJx4UdhHJ9XZ2hWvZsvpKhRR87KicV5rBQcMlA=;
        b=c0cmcBPy8svecV8JynhLBWU80mQYquNXY25n7FHhbNGPswOGydEHzbYc2J2FnlA6pi
         nnr65FEiw3ujh/Pu9T+WJeHZsIzgpNSYuPGVKKJvXHtxuQ63D7XnlFoyF4fEECpRowwl
         umX+v6/bOtzimudVgxgLqA20GZ/KZG+b77Kwv9rWU3YbQI4xZseHo6V7ueb1uOX1FzF9
         l9njx4RYT8V/qF0LM8FMntWnZQx5Y1/FnUgJWCbS87LqIHE5yDhFYpMHdrtqprcg+OTm
         f+DGK/soWGUrGJ0BWqWE29joI+H1eqc3yAGIBzHgweurUv5sDxFXgdoyg2Qpi9rOJu3Z
         tvSw==
X-Gm-Message-State: AOAM532Evp6nr6L2p5be8gmcBnJfTXgtiNQfk1ns5/ujyH63q8TSsWEG
        V3uctyw/K0pYcf6jdk6PTf0=
X-Google-Smtp-Source: ABdhPJw/BV83JYk1Qad+8wyFBqupdYqj3LlDIYo3Vsn7/VdgTbvcdpxEfsQuXw7pA3hk0bdKQShlBw==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr8192114wru.357.1592389558982;
        Wed, 17 Jun 2020 03:25:58 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id z206sm7569847wmg.30.2020.06.17.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:25:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/3] mips: bmips: add BCM6328 PCIe support
Date:   Wed, 17 Jun 2020 12:25:53 +0200
Message-Id: <20200617102556.3792821-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.

Álvaro Fernández Rojas (3):
  mips: bmips: add PCI support
  dt-bindings: Document BCM6328 PCIe Host Controller
  pci: add BCM6328 PCIe controller support

 .../bindings/pci/brcm,bcm6328-pcie.yaml       | 109 ++++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/pci/Makefile                        |   1 +
 arch/mips/pci/fixup-bmips.c                   |  17 +
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-bcm6328.c         | 346 ++++++++++++++++++
 7 files changed, 483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
 create mode 100644 arch/mips/pci/fixup-bmips.c
 create mode 100644 drivers/pci/controller/pcie-bcm6328.c

-- 
2.27.0

