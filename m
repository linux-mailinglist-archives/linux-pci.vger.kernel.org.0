Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7024D1BF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHUJwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHUJwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 05:52:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF97C061385;
        Fri, 21 Aug 2020 02:52:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so640329plk.10;
        Fri, 21 Aug 2020 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vI9mO8HnX6t9W8shIT4/LTp6bxe8W2StQmuh+lanvF8=;
        b=GMotWNycqT1E/lPDQE8YxedWVYl6vMLx5GX6XNQWd18ro4iVT6uds94AA8NHx8ZuNp
         mhESZvHPpPauR3FU2XxtpWyFOro3+bLMIfGYOeg1SdDv6kbQII5APvToJ7gHaWSrWsGl
         me4zrPf/x/fQkGQPatOrFujm1kpi23evo4y9L48ZDk7DnnvvXFVjzCM50LInsSueyvw0
         PJwHWbUVgiU2UrwoiMEAieXaKhxw14i85gxfUjXeA+uHKK6gUg/8OwTiGqUGYU2zJ/br
         y0jRHOAoO27/oHAW7X9wmow1jB5OFBWuBwKezS7e16I/7Iw7mCLjhp8YPRIjD74TUrWy
         IBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vI9mO8HnX6t9W8shIT4/LTp6bxe8W2StQmuh+lanvF8=;
        b=m2wTLT6oe5+XkH7wwHAA9Q+hDbtkTe+bD/o8HlJ9LvopsPiDSh5ZwY7C7YaWYob11b
         f9vouyijRTZu3xQe/lriSQM/kFWeS4pJKvbEiD3bUTiwPIkhGd1aps+nyWc/VsHbao64
         QtgBYFnSNmTAZm0z4PUkybm/CBrdXrw6PugIWliYMRk79s6Y+n8inIElKLIyh3slLpY9
         C667ydGoNEqm3RowESJ5pYJTC0WP+ILQTfI/lNvbMdhQP5BLJdMppkgDn3T8hL1vNGuv
         /ze7ucfehokE+PW/gOj05oQPlEdcvd78/vWNOX2vkFKD4gYIfzL5aDRQxZylNfIl7MOO
         x+iQ==
X-Gm-Message-State: AOAM533rLsgtG0E3jqx0aRL8vNT+uZmVTX2YMKmXJXXF5pCF9hPraIMR
        UnFh7hwObWxas//WnSR6gFg=
X-Google-Smtp-Source: ABdhPJxKdVDX462cAY6jXOhpg3VyShvratvz74tXjra6Av8RhLd5BIoG8g0vjauFtU56/H6zyknm+Q==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr1762857pjq.210.1598003527247;
        Fri, 21 Aug 2020 02:52:07 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d5sm1479828pjw.18.2020.08.21.02.52.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:52:06 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: [PATCH 0/2] PCI: Add new Unisoc PCIe driver
Date:   Fri, 21 Aug 2020 17:51:47 +0800
Message-Id: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Billows Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.


Billows Wu (2):
  dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
  PCI: sprd: Add support for Unisoc SoCs' PCIe controller

 .../devicetree/bindings/pci/sprd-pcie.yaml         |  88 +++++++
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c             | 256 +++++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

-- 
2.7.4

