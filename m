Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136C56F008F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbjD0F5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbjD0F5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:57:11 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 22:57:02 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070F3585;
        Wed, 26 Apr 2023 22:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682574663; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rXCIm1HH1Mu6VPt6Qv0gxr+OAcmA3KtIFU5+zFZQm5QXpAMX8X5jSmabW1ot37jMVz
    PkhZAl/bRRgnoIFL1DAMLpbJQqcgArxf9PUwwR+KWrJpOm4jJhyptuocvzNX3oC03d5b
    WTp9v9W6IUBGoXt+cY3gz/V2PVkynfAvJvBShrFO2JBG8ZNbVDGI9HPOvnHvATagdlJi
    HV0Xb8gri22Ja0UweQgNVDbwQBV5eINmqHPUhK/Ha1Vv4on1lKEPHlXWJOjKqZa/16vB
    353CMriwk1OxyecnDHKZjKpUkROTXmh+y/6cWsu5KGjbMZ8sKF4D8Mp65B6VIzAxO5lP
    cYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574663;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EIvpU9hMKyUkMspZXTVgHxY3jbtOy+UwqyUBxKeGoKA=;
    b=rL7ioc53ajQtOq30Um0PSYZpe6MCFp6DpmQKPtfW9nbHi1h37AOXa4kue/bFr/9vQk
    f64GPSz2UqXcSXluvAhTLCgUpISjpReN0Q7z0UrBQqRQs59CdLpTj4VfUXkzEkcQzAny
    8hp7KXw4ZI4Gplst2apaXo4+gtZ/z0P/SeJ8lt4k/In9zT+cdSMtP6qT4hY8WmqmfGrV
    M6+S+MN8xLOg/XDZvd+csHcUjjzWVq2bPp7nsAuQ9SwHr4MiZz0PozJdfW6ZUHRFD+lR
    LKAZenlMyflc0UDFllBQHcWrLWXwBn4sWH9n9EjfssmPcY0Rv3q0JjtQmV2WBS5euAK5
    XJnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574663;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EIvpU9hMKyUkMspZXTVgHxY3jbtOy+UwqyUBxKeGoKA=;
    b=ZXHw6i7tCzGQShm8p9IuMSPplGdr2tNrwZDJu6AOaON6OpYvqU+QnjkgeCjzix14Wj
    wQwbWmBvui4leRUHerARtGRxidD9slnwdgNkb6W7BCBS6b1VnAbFNjtrXVU8ETrgChvk
    h4cvISKTQDp1QRpO0ofzc5ftFNVwNJckUGOmukSi9Vp4simdERNcw6NpXxzJXbKDHTLV
    zFDkp4CwyQAgvoGpn+YiiTXWlOSgOENv1aK2H/ZtGgxexjegFj8g6KiYGe9/oHgXWZ7n
    iotjfEr1Zi8s9l/vjRLcnl1x8+Ifa+W86pHWmLTjIZPNTM8e1SF7Kr0Bar7VqhBYt6xx
    j7xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682574663;
    s=strato-dkim-0003; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EIvpU9hMKyUkMspZXTVgHxY3jbtOy+UwqyUBxKeGoKA=;
    b=uWMWSr9jSD3sBRBzBTw/+K/VBwv0Gl4s6FE1pca8jPVTO/5j+ijy7DjfQ7ZVejYdNL
    6LfzcE1E/tV0TGJHduAw==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+2odkF/80="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id d6376fz3R5p3NqQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Apr 2023 07:51:03 +0200 (CEST)
From:   Dominic Rath <rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        christian.gmeiner@gmail.com, bahle@ibv-augsburg.de,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-am64: Add PCIe PHY latency DT binding
Date:   Thu, 27 Apr 2023 07:50:32 +0200
Message-Id: <20230427055032.85015-4-rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230427055032.85015-1-rath@ibv-augsburg.de>
References: <20230427055032.85015-1-rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Add DT bindings for the PCIe PHY latencies. Applies to PCIe in host and
endpoint mode. Setting these improves the PTM timestamp accuracy.

The values are taken from the Link below.

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/998749/am6442-details-regarding-ptm-implementation
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 39feea78a084..f448c98f1aa1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -552,6 +552,8 @@ serdes0_pcie_link: phy@0 {
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>;
+		tx-phy-latency-ps = <138800 69400>;
+		rx-phy-latency-ps = <185200 92600>;
 	};
 };
 
-- 
2.36.0

