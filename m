Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA4173BD1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgB1PmF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:42:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38658 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgB1PmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:42:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id n64so2354855wme.3;
        Fri, 28 Feb 2020 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJMCbQr8gSPH+b/sm3hd4i0Wx4L3qYeT/ZG3eWxcMSg=;
        b=qalBZFfGTeBq97wx4bKT5ES5+8Vr830pNz0mANkUaOAGPwjXV8mpYesHWh0xAnAPY/
         lB8iQGhw9Fofdzz8qndxhF5pWekrcHA8vSA2tTxVV7QfcjlNObMteD/LzviTuE3J/Ja8
         HvdEQIznu6z4Bk4LWcJceH4PMn9bLDrv/cYITsiRYL356u7M2TePhMe/2qEwCBRf4SkQ
         AP6lO8EBHatOLcEAycqA5SVnCsdK7ZG7wEwP6xN8lLRGnzeW/owLkM8V2BNl1Ap6MJOh
         MjXzwzEF8InWncNmLLTcptWqMwy7iT8VwCSrygxDXplqXjm+ql6i0ihGuS1tswkbwiaG
         v4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJMCbQr8gSPH+b/sm3hd4i0Wx4L3qYeT/ZG3eWxcMSg=;
        b=a1MxiKyb7P1BUzsMzu2+FuCJuUhs/FkSTqYAnj6iG6Q2Wh1utd4gpFA2Zt+MpvMvY6
         LiYEq2eKiObVW6O5LVuTnYlSNPWOX8w1mKAa0ivqIpwUxo/BUbkHA93hbk8P1AKHgmSv
         KL3FOKGcQDcUNI/I/WS8FAkZYFNegcvWLkpAqpQq+/cr0k2CT0At32DRozQK9UwsFhKH
         dvJFUkfdnKZjWQxVTghTD3eJ46X3O8bd6iTNFztYiQqeVSXsez9Ce0dCIPlIeVsotXCA
         cgjrv61xbYk4sCIImUKXgax8Y+o+ffSboO3XWk/hrlDucej+mVSlYu/8jXEJu58XMBHG
         vV6A==
X-Gm-Message-State: APjAAAVgorwl3rjhdszIvf9ItUQ56ZLFosQTQPmnl/7jkm5H10Et0nmj
        J0V+hZoISqezKHJKkuG7EBI2KU8Q7SrvKQ==
X-Google-Smtp-Source: APXvYqx2ARGqNtOob4sRn7xEbT9W4deKtORU8SXhzdmDNYePt3KXJa2mafIKaL6r+ZBncANzMkJXMw==
X-Received: by 2002:a1c:c344:: with SMTP id t65mr5248276wmf.97.1582904523429;
        Fri, 28 Feb 2020 07:42:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:42:02 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 3/7] PCI: rcar: Fix calculating mask for PCIEPAMR register
Date:   Fri, 28 Feb 2020 15:41:18 +0000
Message-Id: <20200228154122.14164-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The mask value was calculated incorrectly for PCIEPAMR register if the
size was less than 128 bytes. Fix this issue by adding a check on size.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 41275f9..90d47b21 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -75,7 +75,10 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
 	 * keeps things pretty simple.
 	 */
 	size = resource_size(res);
-	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	if (size > 128)
+		mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	else
+		mask = 0x0;
 	rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-- 
2.7.4

