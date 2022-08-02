Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A1588122
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiHBRgq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiHBRgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 13:36:43 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC6DF00;
        Tue,  2 Aug 2022 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/XIWlzqkr1Js3B0BB649mTkJR8GdTs5awWpSmRtzimU=; b=DYxK+YN8QnkGK/pQ5PewvbG0Xv
        2TAU9t48tYA1cJuRBgw8hSX/9yrkqa7mI31CL0kU0lNeB8iQWYf7TpajxxaWUv6o5y9T15ZSHZG9t
        pjqcIRwDsP1eaEkLVUYVQU2DhrcQPKHDoH8RttlVqMLu5Wvm750mWd+2EpxzAo7OoQa+TztaDrOiM
        EU1Gs9UJHEZdmsOZMrhcu1GRqvMOvgf1VbzC+sUDrVf+bLOdbq9dT0OJThMzRAB9fQD0Fr+ghdvBn
        bKoWfHucaHUIkpmQMPr/FndznXt/UYIk7PpVObmI1JjDzK14nSZLry/sNcXzkZnoxgkA6P6cBCuhy
        F1Jk6wOg==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:55982 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oIvon-008Ymu-9I; Tue, 02 Aug 2022 20:36:34 +0300
Received: by localhost (sSMTP sendmail emulation); Tue, 02 Aug 2022 20:36:31 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Tue,  2 Aug 2022 20:34:21 +0300
Message-Id: <20220802173423.47230-1-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718202843.6766-1-maukka@ext.kapsi.fi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 0/2] PCI: mvebu: add support for orion soc
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello all,

Here a cleaned up version of the previous series.

Changes
 - instead of removing PCIe related mvebu windows add them in pcie_setup()

I intentionally left the ORION5X_PCIE_WA_VIRT_BASE in place as all pieces
in the puzzle have not found their place yet. It will be replaced with
ioremap() or similar when the problem of passing the address to
configuration space from a device tree is solved.

Tested with DNS323 both DT and non-DT builds.

Thanks,
Mauri

Mauri Sandberg (2):
  dt-bindings: PCI: mvebu: Add orion5x compatible
  PCI: mvebu: add support for orion5x

 .../devicetree/bindings/pci/mvebu-pci.txt     |  1 +
 arch/arm/mach-orion5x/common.c                | 13 ----
 arch/arm/mach-orion5x/pci.c                   | 14 +++++
 drivers/pci/controller/Kconfig                |  2 +-
 drivers/pci/controller/pci-mvebu.c            | 59 +++++++++++++++++++
 5 files changed, 75 insertions(+), 14 deletions(-)


base-commit: 7d0d3fa7339ed5a06d6608b7cde9f079eba62bb1
--
2.25.1
