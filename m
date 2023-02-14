Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED831696623
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjBNOLT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjBNOK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:10:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD32A6D2;
        Tue, 14 Feb 2023 06:10:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k16so8838406ejv.10;
        Tue, 14 Feb 2023 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFaCpSoOh56OQteewfZTVMaeWIQyKb2eWSuRe9wY0g4=;
        b=oawyfDtd4HUlixv3sc8fZB+y6sxxiksKZ4eU55nrdO/SmBP4kNGX255/isXuDEWjfI
         dMoeLo58pSfJRjFoOestBhkzoTulA8PDB7E3VaOp/7VSW4xhQ4lP2TdTAwT52+wxeMR5
         7AFChbur3VIZtBmRFkA1EqF9YZMwmJm0T9px+ooQXbvAKoCmtywskBQc010vH45IV4uk
         l1zM+ampBJPpo8R8JS8MGlYI+8x5dWLdrvLfiAGGsdGn/9RsIk2NnjYmXyBzHs5s5lhx
         o/XH626hiiJ2s7VjSOtc/zhNlNb/nzDqXA5JzQuea+/P5KCLxRAVfo4hkceeXdmLjpuH
         v1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFaCpSoOh56OQteewfZTVMaeWIQyKb2eWSuRe9wY0g4=;
        b=waFnDYYTZKq1sLopqW59IwitdX1GkxOwQWy0woolpLAZR6Cqx817d0tLpFkrCqf+LA
         hv3BAUBFL9c+5NGHyZysTL4zvfVDJh44TaAFboquohoMh0Vj4D7sDAO2poiEk7hNfAAh
         RZ8t5+j0wUn1IgXdjJ1ADNRyaxpdosU5vBHucUjAwiP8rcRvBcOVXIjsqmKHSb3mhOJg
         K9uWx18ywtjJAfUt75xbioBl7J310xFricoUhwWCg4BA/p0kKGLqySiyNUvoDnkElBKQ
         m/yzVnYnRtDsaofMzwaKhTThiDEXC37qSiBgeup+7uxqGj5xpEq09QLEIzOE90hXLyKa
         nJJA==
X-Gm-Message-State: AO0yUKVFZDHUIdqkaLSAE18aWLgM09KvdRpt9hihwsTwq28OWsExt8+m
        8Mn7b9n3Zh4bbdtGKabpbhk=
X-Google-Smtp-Source: AK7set9qx8i6ewx1KKF13ke9e6N7GALFeNK0DAgAP0ZyuOYAr/7qo2cNVkJA5U73LXL7dOkPQFdgNg==
X-Received: by 2002:a17:906:7c07:b0:888:7d50:33b4 with SMTP id t7-20020a1709067c0700b008887d5033b4mr3040433ejo.34.1676383817601;
        Tue, 14 Feb 2023 06:10:17 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id n11-20020a1709065e0b00b008b13814f804sm332241eju.186.2023.02.14.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:10:17 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 9/9] PCI: rockchip: Add parameter check for RK3399 PCIe endpoint core set_msi()
Date:   Tue, 14 Feb 2023 15:08:57 +0100
Message-Id: <20230214140858.1133292-10-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The RK3399 PCIe endpoint core supports only a single PCIe physcial
function (function number 0), therefore return -EINVAL if set_msi() is
called with a function number greater than 0.
The PCIe standard only allows the multi message capability (MMC) value
to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
called with a MMC value of over 0x5.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index b7865a94e..80634b690 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 flags;
 
+	if (fn) {
+		dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
+		return -EINVAL;
+	}
+
+	if (mmc > 0x5) {
+		dev_err(&epc->dev, "Number of MSI IRQs cannot be more than 32\n");
+		return -EINVAL;
+	}
+
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
-- 
2.25.1

