Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218076D5AB6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjDDIZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjDDIZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:25:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9831BD9;
        Tue,  4 Apr 2023 01:25:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h8so127300507ede.8;
        Tue, 04 Apr 2023 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LATqscNFMcH4PAHBJjlISDFEuv7xzk5EEPEPEjIGOGg=;
        b=iA5g5EAFgrskWNW3yKe/MzpR8TsGNVrCM3f8tYxwedNV4pg3OKc4DJ2TxjK/RYz+fh
         rsDkQ8NwtgU2Ewvwch1AzR/XhcnHkC3ve1dfrQyKegNwKESte7ywvjPMdPfcnqS/s2MR
         WLroOyZfBo7RdVBsCOL3fVD7cKBes4zpzSsQK/iKusk9x0p25Ph41yjOgV4pygkinASx
         mZi+kj+Szo9wrkju6PFn1g/mdFEp9SOa6Vvpyx9SpnVLXOAjvB6aM4o1xirW37i0CkNA
         vgUeEe8jxJ99idId+hgmVexAGiy5nPWZuyjwRXSj34Mi7pcX2FsPRZ29XmhZ4Dqe6MKZ
         p6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LATqscNFMcH4PAHBJjlISDFEuv7xzk5EEPEPEjIGOGg=;
        b=fIYYmqYhWfXyxIJWYKoQ9os0qtfW90513RlCYtACJuRDILi5UXvp4Eominx/MkT86y
         SCym8he7kEU2D2qE0tEXAsyPRxwb7LqqrqeM1w9CLpzOabmdHwztNNUdTMhXkuc93Dn3
         tjRBNcBLWLCMS8fyG4VC06sAB3nRCledODGZ73PoHsRymY/FCVaqBDi0nlpVn8rTbZUs
         jnveHseVUS2cYvvNv7rk2QedVggjjhlWt0mTeMdJE/Bnt2STw7LiNNNtjgLIJGgIDUAA
         zjE2DMHMeCAuimpKxiS2E+BzfkVQUVOZBY5JeNo714zDIVhAQtSVR+D9a3RBawvVVqje
         BJUQ==
X-Gm-Message-State: AAQBX9ewif7djZyo0uqmLp/FiYhsryUkdzN+PCVL6M0goTs2RJeLg41k
        SC585DHIFHIWJ5uUw+JUm1s=
X-Google-Smtp-Source: AKy350ZXrMPUzaP14iKn59qHacF97SbvB67QrQBgU4TMCCQPoUiIAVASBVpUIcIpgsqSGI277y9dTA==
X-Received: by 2002:a17:906:9611:b0:8b1:3131:76e9 with SMTP id s17-20020a170906961100b008b1313176e9mr1185126ejx.46.1680596700232;
        Tue, 04 Apr 2023 01:25:00 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id s5-20020a170906454500b008e54ac90de1sm5640652ejq.74.2023.04.04.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:24:59 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] PCI: rockchip: Remove writes to unused registers
Date:   Tue,  4 Apr 2023 10:24:14 +0200
Message-Id: <20230404082426.3880812-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove write accesses to registers that are marked "unused" (and
therefore read-only) in the technical reference manual (TRM)
(see RK3399 TRM 17.6.8.1)

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

