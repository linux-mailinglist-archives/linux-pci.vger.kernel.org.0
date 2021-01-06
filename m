Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757A2EBF22
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhAFNrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 08:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAFNrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 08:47:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BE6D2311E;
        Wed,  6 Jan 2021 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609940786;
        bh=tYKdxArNM4nHAHfgzQ+s9wREa9C4OBkvvuMWxCIRM50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8OlBfLIAVBEcTXbyTmWAbDjrXox/N/ncOzpWyUyxwAr7m1JZ1rAwvQ+mIkGBT/L4
         cuYC6eqbEZQKw/lYye7CNXjJ7TovOPnGeBiWlUCccC0dLtvxht861vvQBWLyAvgg+E
         80NYRIIoUDu/3Sn/XbhFEgAHgXL8y9HiBQ4qLOwbyUeTctqDa3bp8BLd3fQuMf6YPq
         hMRJSTXD9i7XLhWNJ9sXfFdmd07LDYCdCX9rG7Jr8/1C2BGpQjg3N1shbDrDJ6rodp
         fTXkkRFuZC2OsvbGeSR+rMdRtoYPxQ3nEb3JXSzChmK95SZ9zOTwbhoe4pojbOCEZs
         7tDgGqtoSwPrw==
Received: by wens.tw (Postfix, from userid 1000)
        id 63E3D5FBBF; Wed,  6 Jan 2021 21:46:24 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
Date:   Wed,  6 Jan 2021 21:46:15 +0800
Message-Id: <20210106134617.391-3-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106134617.391-1-wens@kernel.org>
References: <20210106134617.391-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The NanoPi M4B is a minor revision of the original M4.

The differences against the original Nanopi M4 that are common with the
other M4V2 revision include:

  - microphone header removed
  - power button added
  - recovery button added

Additional changes specific to the M4B:

  - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
    USB 2.0 ports
  - ADB toggle switch added; this changes the top USB 3.0 host port to
    a peripheral port
  - Type-C port no longer supports data or PD
  - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
    but only 1T1R (down from 2T2R) for WiFi

Add a compatible string for the new board revision.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ef4544ad6f82..773fd4c531ed 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -132,6 +132,7 @@ properties:
           - enum:
               - friendlyarm,nanopc-t4
               - friendlyarm,nanopi-m4
+              - friendlyarm,nanopi-m4b
               - friendlyarm,nanopi-neo4
           - const: rockchip,rk3399
 
-- 
2.29.2

