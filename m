Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF282D646D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbgLJSFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391093AbgLJSFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 13:05:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41667C0613CF;
        Thu, 10 Dec 2020 10:04:40 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x23so7721380lji.7;
        Thu, 10 Dec 2020 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMJBLlAjP8wSFID5GV3n2OSs8Pdq22oopeS+FLP5wos=;
        b=sELdec03/ChHc4t7iqICbFd674XO4Gvlas6DBjCjwFmvdIHNbvpVhCtMjh6g7WCd8t
         47MSkqS+bfXzFgdhQeRogPDNhYPRy/rXBDN+dI+FEtWgGmH+D+R9yEI/jCgG+o8k/YJf
         WBEtP/uNGiC4CXfrsylhc1Bmqa3PtCvRY4cqqK5nTeZQ5a45phGvd1QCxLyhgRFyAZYX
         8FSx1A9zDquyFbTlXDho0SXaHGbUdQyt5IseE7dKDszPDlOcXwKIiEjOyWuw2tPc8ATe
         +dtUNEnlu9bPmmT939iUgWpG9wesyzePcQ/ExzTM3s0bUSzPHyhXEtzAkLHwX7JHpJRq
         m9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMJBLlAjP8wSFID5GV3n2OSs8Pdq22oopeS+FLP5wos=;
        b=XeJQlarCYC3fF4ud2ZlK+pNgFm6ui+T+/gh7em0YarKQPPUB1dBUX1XcatVenZuckZ
         PM0ipsILXovkvHAR0Kk/Wk9mx2myo6+F2jvqtTLH3J5fJo/0fjT9gfpTkzVwvhqUUJAn
         WDzkjFaIqd/epzU+BgPoetURK7ACd3UnuMh7X7yO6sFEj6VX+nMBQSE+ZjUN8GkbdBbu
         fe6/GY8rFalvxaMzDX6+pySaXCd0CIBhWJLLKTmsd30icVHc9PSWZ42yUZSnUyvgXVOL
         ziWKejPNxwReIzVgMDFiKAYLYgL7iZm9yks0hVrdHJ1x02jdMNNzw/pVU0T+0MhqcNbd
         6XSg==
X-Gm-Message-State: AOAM531Aajot4sSwaYgMIC4K4QUBo+U/RXrLlAbPKH1YLoaSUsGEsu3A
        ByGbcmFvgwm6/NiVO4lt44s=
X-Google-Smtp-Source: ABdhPJwUQ0qFYpspzairXUY5Vk1vHLdRXvBe0mb0QlrUyjL1o5E06Rre2M0l3z1OOcPy4NA+Flsa4A==
X-Received: by 2002:a2e:b522:: with SMTP id z2mr3335754ljm.500.1607623477535;
        Thu, 10 Dec 2020 10:04:37 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id c136sm601855lfg.306.2020.12.10.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:04:36 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v3 0/2] brcmstb: initial work on BCM4908
Date:   Thu, 10 Dec 2020 19:04:19 +0100
Message-Id: <20201210180421.7230-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses very similar hardware to the STB one. It still requires
some tweaks but this initial work allows accessing hardware without:

Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP

Rafał Miłecki (2):
  dt-bindings: PCI: brcmstb: add BCM4908 binding
  PCI: brcmstb: support BCM4908 with external PERST# signal controller

 .../bindings/pci/brcm,stb-pcie.yaml           | 37 ++++++++++++++-----
 drivers/pci/controller/Kconfig                |  2 +-
 drivers/pci/controller/pcie-brcmstb.c         | 32 ++++++++++++++++
 3 files changed, 61 insertions(+), 10 deletions(-)

-- 
2.26.2

