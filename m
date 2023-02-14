Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72970696604
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjBNOKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjBNOKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:10:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816029419;
        Tue, 14 Feb 2023 06:10:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gn39so2067047ejc.8;
        Tue, 14 Feb 2023 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MA+FezG4F1FhZiXu5UiMUXpedUBh3Xy0N9KRcXckUI=;
        b=G1xR6IRfr7vwGp2wPLVa+Hb9A6hDLa6n7jzOZ9CARQAEfa7Oehy+rqcuwgKFYZvwsd
         hrAnqnVf9/4zX180IH9eCkyH1TEDePKk7EEptuasz5scZzxI7dj5QOiJLsiSKZGVS89h
         cMu7fkuBSPbt9PeNyrW8koTVe7Qp6+IhP6ZNzENlgayGEIG8o4FNAvdEggiyD2N8UEiO
         7qZeuP1+qCLmlhtxpD3nJtHoutgioxlvtoxuGBoutZsBz7rFpX3RIV81iQ2O/EcGYi2W
         gJZMfSWa9DWW8YB5YwEScCqyZRRKsHSaTkuyhh7PsxZlGiNpv9s56Uo48KH6sv8+aOkT
         lGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MA+FezG4F1FhZiXu5UiMUXpedUBh3Xy0N9KRcXckUI=;
        b=q23iqyViDtWi2hN6mI+UXpKrYnwsnU42pJT8qVx9YR0FGLDPQhtQBjz1bP8yc27DHA
         W06QGz2iK7EtwYzB1kB5BntuhXmXbDNh4zLPKgW6WFRdQhGPH2IHedNarKgAwfBvHjr+
         HoPr343MDEgfY8yomRldc/UQEMKdciTkuMpGPCHr+zpKrwXqNi5WmOM5mQqcrOk3CSNT
         +uDaehYLo7mw03iN4u8BB3nh4fjELrU/oPyCB8p/3X/MkVEGHrVdB+EqLJ595uXKF4Yt
         nv0KGZnArrQ5jihMLevgmt9hmoialRLh9LN5Y/y2Ctcrkg6Ykz1l0RqWesYxOme0l2JN
         NzSQ==
X-Gm-Message-State: AO0yUKXhiYBASd6Y5XNfWgTU7FsUrNmcvODAqcwfgfBRPLPsY9UmTkSs
        NJvKtXdFU9VHWRfKCrSyj5o=
X-Google-Smtp-Source: AK7set+gsBO80IHS6L6K/JrkjsdLQmNzyKDwSGga+oFAqSy+DEnpXAKyJueMu6hB9+W/2qWlDCpZTQ==
X-Received: by 2002:a17:906:13d2:b0:8b1:238b:80ac with SMTP id g18-20020a17090613d200b008b1238b80acmr2756454ejc.67.1676383794181;
        Tue, 14 Feb 2023 06:09:54 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id n11-20020a1709065e0b00b008b13814f804sm332241eju.186.2023.02.14.06.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:09:53 -0800 (PST)
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
Subject: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
Date:   Tue, 14 Feb 2023 15:08:49 +0100
Message-Id: <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
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

Remove write accesses to registers that are marked "unused" (and
therefore read-only) in the technical reference manual (TRM)
(see RK3399 TRM 17.6.8.1)

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d1a200b93..d5c477020 100644
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

