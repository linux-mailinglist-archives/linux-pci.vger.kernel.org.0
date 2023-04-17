Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04F6E43AC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDQJ1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDQJ1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 05:27:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384FAD;
        Mon, 17 Apr 2023 02:27:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id xi5so62353815ejb.13;
        Mon, 17 Apr 2023 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723619; x=1684315619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utnt45WNES8x5nuh03dm8k/Z+7rA8EuGdWHHb+kLIVU=;
        b=fol01En1PXPTlo0VOyAj4tTv45dA1FEA6GFQ+ChSx0vH38CW78Khp+5eaPFxnk0sW/
         53n1PofGRNkHla1/fO9e4nBfTDJ5sn1S/YaM8E9kaTc87RFTRMlmEEviMJ4CaGY86sYC
         QrflxB5LhQGydlSWrjBwsvCHrQq+7oLNEeK0lksLDa8+rJifRULdUn/AAlBOgrKOOdyF
         PXBg0WSqlx/PK+kdrev9RsUCONPnzTdKONWiH/U5JcOyytypfg2cIBAUgznpJAFZqAm9
         5sGArfIJ7ZTUl9hJ63qAlR2qSQrVm6WQ044l98bRNZsaZgbkHxrANk7tTy+K6NBo+i9N
         9M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723619; x=1684315619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utnt45WNES8x5nuh03dm8k/Z+7rA8EuGdWHHb+kLIVU=;
        b=EEYlsr3N4AalYjVZyZ314QlxbFau2pWHvylF3s9YafC5P9rqRAzGCtWXod3ZIvNjgq
         E5rslb6EWnoNbWxyGKptdWZEhRO9uehNw+1L7Cn7d8ZxohD/KcRDBebgaq4HSvp274lp
         cEB+7X944JGH43AvUEcz5SzLyYf4ppkHoGfUfWqA/kX5CNPAMCmme/Im2E4faSQ3Wb+d
         BrYu1Lu4X7aPmAe4f44P9DO5s6n5XP4Aq7btZO2jrjlk1clMa+K2mtAheDobJMKM6JZS
         F2LhnVV81kQabEpAE/n4EsBeylC71oP6tT2Q5/zGomqt+0bhJ41VPGdCDU/AVEsXxrTd
         u2Og==
X-Gm-Message-State: AAQBX9cMSo4ThWSMNT1XTTe0wz7/NngLSOR3ysB6wvgfvfon7vOCKGUE
        K+XYRiomNbPeow3uF8M1jE8=
X-Google-Smtp-Source: AKy350Z//c2BIX+K3WfJ+lBvrMgsF4284a13OLueOa57Kqv+CDn1V/Vy1sHTSeneK+YDAqsc2eN5OQ==
X-Received: by 2002:a17:907:844:b0:94f:61f5:9ef7 with SMTP id ww4-20020a170907084400b0094f61f59ef7mr3680011ejb.44.1681723618587;
        Mon, 17 Apr 2023 02:26:58 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id p20-20020a170906615400b0094aa087578csm6398596ejl.171.2023.04.17.02.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:26:58 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] PCI: rockchip: Remove writes to unused registers
Date:   Mon, 17 Apr 2023 11:26:19 +0200
Message-Id: <20230417092631.347976-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
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

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
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

