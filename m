Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE256E5AC8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDRHsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjDRHsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:48:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6A72B9;
        Tue, 18 Apr 2023 00:47:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kt6so32664692ejb.0;
        Tue, 18 Apr 2023 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681804066; x=1684396066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaDb5cHcj0sq9Nv0eUzX1LbgrLSdfw3K6Yu7Lv5vb5M=;
        b=iy8MkyX0C205CH/ZIQg6+jYo8nDDTIv1sn0cJgbUnPNG9JbLRGoe/uEXFDZlL5Mo9x
         s6CQav2nfSqQex7hEzXscd6l+6dI0RW31sdgGzjzGJsyIUuBdG3j/wUAd95/uGq8AOzV
         Ev2a2CFHv12V4WohFnoFxCN9ASBiXwkwg90kRK0E1lVL6M7cOkK56qgMHGOI+MI1awv0
         fI+OqwIeJ5b+g3R1N3hJKPWqtw6dt0/siAmRea5EI5xaLF71f4vXZJ6nCD3L2C4U8pCT
         ZSv9GtB7tXucMPRQ9EWqtDNsvDjb7y250QP4Q+mU9ckasqmjxRk2VbkL5wukF0EhGEEH
         Y3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804066; x=1684396066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaDb5cHcj0sq9Nv0eUzX1LbgrLSdfw3K6Yu7Lv5vb5M=;
        b=Q+HMfn0aSbFkt65eJShQdhR+tjJD79sTrE73f2O2C7zAXDXNaF4OWabmPWAcNbNhf8
         VnNV8TTwPz3duCOqg649LX01KPNye6bx3SLmzUReRIWbbKH6/Ih40x9XZ6zmzrwknOqV
         gyNpz/oeuD+ggDQOUG937UkwlEA7s4iOXj2zBegRHydA959Npjr+VcuMHir0gMVlcXkH
         wZT6kq4DdV3VCxPfshPqiVWgnd5swRHdFmCcNgKsDkP1B5O/5X7H4ykgHvwo2b0bBfwr
         qYmMBHb6vPnyBD9xC/gUH1NuQhZjOhuPWaCR0n2hEAiPb5+zoEYuAFZCd+f/f7cgkTRq
         vtMA==
X-Gm-Message-State: AAQBX9cW7RtO4dwo+uDVlhYHwpVt0f8hBsgt1qVos7t6+jpjzueEj1RR
        HOpA2xbBaYwHGnZZ2OMTp1SBZnSwnZZ7DA==
X-Google-Smtp-Source: AKy350aEw4nobnCvQETROqWtNOjoNa5NoUTEONLCrQUYQCkCbsJM3x3G1cs6LR0LZcZrJwIe+He5Gg==
X-Received: by 2002:a17:906:f6c5:b0:94a:74b8:7a79 with SMTP id jo5-20020a170906f6c500b0094a74b87a79mr9871917ejb.59.1681804065737;
        Tue, 18 Apr 2023 00:47:45 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id gs8-20020a1709072d0800b0094f694e4ecbsm3048545ejc.146.2023.04.18.00.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:47:45 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, dlemoal@kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/11] PCI: rockchip: Remove writes to unused registers
Date:   Tue, 18 Apr 2023 09:46:48 +0200
Message-Id: <20230418074700.1083505-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove write accesses to registers that are marked "unused" (and
therefore read-only) in the technical reference manual (TRM)
(see RK3399 TRM 17.6.8.1)

Tested-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d1a200b93b2b..d5c477020417 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -61,10 +61,6 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
 	rockchip_pcie_write(rockchip, 0,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
 }
 
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
@@ -114,12 +110,6 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 		     PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
 		addr1 = upper_32_bits(cpu_addr);
 	}
-
-	/* CPU bus address region */
-	rockchip_pcie_write(rockchip, addr0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
-	rockchip_pcie_write(rockchip, addr1,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
 }
 
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
-- 
2.25.1

