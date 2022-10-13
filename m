Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EBC5FD4F5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJMGjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJMGjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:39:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67A139E67;
        Wed, 12 Oct 2022 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665642447;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=T2sxiAy8yMu84bcZbky/5CvmTsSFzanDcbu9cCBIsQ4=;
    b=Z4xRsbjzhNQMLN2JYlkbETVc7PvedX0LTCSrE0HkxXJBDuBYjzcFhjmxM6eNTOjVen
    821w/sxRlB1KpFuI84xATMHxtwkH2+0ZngEdSjVzd2uewn77lbYQV2Q1aKzGIKCKCWwa
    VMFK53O+7s5xHUYgSt18zTO2WMTmAyJik51hbNhChFkwFMI/KuAx7SF4TO/Xy4sT87Ru
    e0FjwQ5lbKgr0dVCiN+WztkgfVeLO6ekaRy+uOsYjh0uujFfGTkN87wdw8WajjLFU84y
    R2HUeKnvnKNAls6tl5r637JPOG7s61bs9L3ujwwF2CtpuILKfGBAU1pgcCPyAUrLFMha
    2cnw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+8odoEkA=="
X-RZG-CLASS-ID: mo02
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id R6cb4ey9D6RRC0b
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 Oct 2022 08:27:27 +0200 (CEST)
From:   Dominic Rath <dominic.rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH 3/3] arm64: dts: ti: k3-am64-main: Add latency DT binding
Date:   Thu, 13 Oct 2022 08:26:49 +0200
Message-Id: <20221013062649.303184-4-dominic.rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Add DT bindings for the PCIe PHY latencies in host and endpoint mode.
Setting these improves the PTM timestamp accuracy.

The values are taken from the Link below.

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/998749/am6442-details-regarding-ptm-implementation
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d6aa23681bbe..032abb343c36 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -855,6 +855,8 @@ pcie0_rc: pcie@f102000 {
 		ranges = <0x01000000 0x00 0x68001000  0x00 0x68001000  0x00 0x0010000>,
 			 <0x02000000 0x00 0x68011000  0x00 0x68011000  0x00 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000010 0x0>;
+		cdns,tx-phy-latency-ps = <138800 69400>;
+		cdns,rx-phy-latency-ps = <185200 92600>;
 	};
 
 	pcie0_ep: pcie-ep@f102000 {
@@ -873,6 +875,8 @@ pcie0_ep: pcie-ep@f102000 {
 		clocks = <&k3_clks 114 0>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <1>;
+		cdns,tx-phy-latency-ps = <138800 69400>;
+		cdns,rx-phy-latency-ps = <185200 92600>;
 	};
 
 	epwm0: pwm@23000000 {
-- 
2.36.0

