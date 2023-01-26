Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46567CCC5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjAZNxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjAZNxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:53:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB96F227;
        Thu, 26 Jan 2023 05:52:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v10so1900325edi.8;
        Thu, 26 Jan 2023 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBzXbIjLvRdTa0w/vaMb2dG2HneZvQO9eV3thnNBNwg=;
        b=UUI3q8aCmq00poNBppLPOHFyK7c1z19Lbv5d5242AVypMv5CUSByag+ZAIL4asl6jH
         mlJ/UNNr+K6rqA4G5AvnKS3WJ9fKlcn5psHIymCeIPm+AIKsT4xKt+6OL8rxe3aEFSbz
         5cMHf5j2u01IM3hId20J+ddmOe/CXCdKrzp351JCRYlJr/Hr5fIprTa0yX1UHS1mpP9k
         w78/u57yXnVr9RUNQPt2/hzQTyaXqWJQWcqs1gm5AH0E73j2Sne7Gka6phFJYn4KSkbP
         MwRSZF9j4NqXvFUHOcxUGMf/HlhhsBFxMsvxb5kv8s1oCSL+YiVEybTLkzNTdX8zojeJ
         sKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBzXbIjLvRdTa0w/vaMb2dG2HneZvQO9eV3thnNBNwg=;
        b=T2Y7haAU8V+LJdQQtdR7vaZxrNzgcJwwtjqEh7wRAOYbRL65/VMsVKyncG9OD+5KVv
         m6mpGmkKXoYNkcx1RjiyKoDX8WvPQv0OflKW4Ov16sDLQg2pw9oyScTMeeyrKfYZPr9S
         F6mpaFG3FnrW7CK8upG3XD1lkBp1H7ge85vcPVK2zViwXhYepeEJGue05hBwfP7yg2nG
         IE0Rmys31zG9cTXk7jpxwyV9Gx/xQ01A+PHBC1bfxmwfioXHQTX+etOFKxslmN0GQGof
         1lbY4n+2kp2IoRuUY1ZLv47sdRDyV8PnikwIzuEq7R3zPc9WzMt3S62XHpSXmj3RLzkj
         pSaA==
X-Gm-Message-State: AFqh2krjNxMtpsT1IYe/58rJSVzSJNsSFmWJ/3UtKv2pKvFIChHTIzmg
        uY2QKMNHvrFPthFxMoO93p4=
X-Google-Smtp-Source: AMrXdXuXbuQdJhGAds2G2gVCjtPY37NcvVJ07i7nNOIPmyaLny8F50OQaCvccSlqKRST8WATWLo8CA==
X-Received: by 2002:a05:6402:5110:b0:49d:32d0:126 with SMTP id m16-20020a056402511000b0049d32d00126mr44761910edd.20.1674741160602;
        Thu, 26 Jan 2023 05:52:40 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:40 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint controller
Date:   Thu, 26 Jan 2023 14:50:45 +0100
Message-Id: <20230126135049.708524-6-rick.wertenbroek@gmail.com>
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

Added missing PCIe endpoint controller entry in the device tree. This
entry is documented in :
Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
The status is disabled by default, so it will not be loaded unless
explicitly chosen to.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9d5b0e8c9..5f7251118 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -265,6 +265,31 @@ pcie0_intc: interrupt-controller {
 		};
 	};
 
+	pcie0_ep: pcie-ep@f8000000 {
+		compatible = "rockchip,rk3399-pcie-ep";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		rockchip,max-outbound-regions = <32>;
+		clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+			<&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+		clock-names = "aclk", "aclk-perf",
+				"hclk", "pm";
+		max-functions = /bits/ 8 <8>;
+		num-lanes = <4>;
+		reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
+		reg-names = "apb-base", "mem-base";
+		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+			<&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
+			<&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
+		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+				"pm", "pclk", "aclk";
+		phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+		phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_clkreqnb_cpm>;
+		status = "disabled";
+	};
+
 	gmac: ethernet@fe300000 {
 		compatible = "rockchip,rk3399-gmac";
 		reg = <0x0 0xfe300000 0x0 0x10000>;
-- 
2.25.1

