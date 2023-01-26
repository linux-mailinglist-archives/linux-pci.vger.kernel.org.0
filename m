Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAA67CCB8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAZNwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZNwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:52:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA014CE7F;
        Thu, 26 Jan 2023 05:52:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y15so1232534edq.13;
        Thu, 26 Jan 2023 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+EvojORsODacWviA5H6y0wNxHBR0n+JtQ47P84KEr8=;
        b=M7WFhI8SKAtXB+pSxFmiYwpUgGxWXlqZNu3JXhuS+yfnD8O/JAdK0MjemWn5kLTG3X
         komoX6IN9FoiJBCIWTL8o5/B52AykwawZPJsDcjzFBeRafA8ilG9pdvXzNPvWB14YwJF
         NhLYjKkNNXv3wZ7tYtE3wfGbWR+c69MY4OZI8bWF2wOwitccG7xcuABKH8ZSJOegBmzG
         jphwOgBEnxUV0IOh7Nuqw32OyCpDy5kjfhTo7nII5eYFwaITHD7/dmVR5IW4qPFaGrO4
         HnWIyogEeYmklC4WBC5AqTVfaKTEW3BYbqvGyr0I2g46UoPeNbBjWsWqhw0QKOgiw2yA
         XC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+EvojORsODacWviA5H6y0wNxHBR0n+JtQ47P84KEr8=;
        b=MWwd2dTUGQACG+4pIQtTLVftnVoAVoGCuZjPeS8FZPzbM5mqVB2XRbm9K9JOqFoXkN
         e4SpnlZjb5GFv4HfrUQjnAi4yB7OzTW2nTDZurQ6b4dLsGbqOHTbtkrU2Fp7TClpOIu9
         D5PP/h2fxBJpnxRz1Wya1WXH/yXpVBgdVJvZZJ1v52vgu2IWg85zQvPe8d9tcBe9PduC
         hnlK3Tw2TM48vf+UMMtWIkgxzRCTTK+bojP8oQjO8N/Ul2+/9XJaLkzT9xekJlsHUF8j
         ITPcCQ+nOPRtfo0sDOQ8de/eyfevmVBg7WZplf6x5Y7niC54ssMILAz+Ju1enXP2QuIG
         Yjmg==
X-Gm-Message-State: AFqh2krLHNXz90nZkaakiXx0Kj5zTbS6COEvHo4uXxKtA23XQSZS49Hh
        iWTo6zV7Ibk1AT5v66T2ngA=
X-Google-Smtp-Source: AMrXdXvjXviGbRsmtS1HM0FbuBSRmsHH00RtTIKoAbetJeuAmVMFhdIktIVjaSaunZT/005k2AIfZA==
X-Received: by 2002:a05:6402:388c:b0:497:1787:13af with SMTP id fd12-20020a056402388c00b00497178713afmr36209189edb.32.1674741146889;
        Thu, 26 Jan 2023 05:52:26 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:26 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/8] PCI: rockchip: Removed writes to unused registers
Date:   Thu, 26 Jan 2023 14:50:41 +0100
Message-Id: <20230126135049.708524-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
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

Removed write accesses to registers that are marked "unused" in the
technical reference manual (TRM) (see RK3399 TRM 17.6.8.1)

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

