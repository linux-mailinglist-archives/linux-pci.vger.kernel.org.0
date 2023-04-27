Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D386F008E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbjD0F5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjD0F5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:57:11 -0400
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACE35A6
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 22:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682574660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UhuubxIkc5Dsp4k3P3b/n/AcpMUnJ9rbdnQ0mV6XSwlEOHFnnx2b+P4mflk4E7x8gc
    AOehoYTmqTkMzw6DjVStMPBtGbBtHqAf4KoCbYMpFiV3Sf2KQZQwzaTzikK9vDEfYmyH
    /A278JUWmyxthJ2EJAWJbbbsOLG8iFEUUVZLfUGDUWtWvYe8zonGz4cc2AIl9yQM1JGz
    roj/S+EiNA08ET7Nw+/6xHsDK2RcUJfAsdYfcVTAE3QyZmnYu4eQPaxCoFZ2ih/JOl3J
    MlTffVUQxQrRFroLbgs8PJPCPyCzu4Sc8v6gOduFji1q636IyRWwC0bnczKmczU60E7v
    uR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574660;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/89t7kagvmVUH2PkZ3RsurDh1iH7jgvxPKVl7Tj7Ex8=;
    b=Z3tTuhadfiFgFGGc+YEAGgHMYc4kzu6T97vOI+a5XQBo+Borf96e6+Wam4AsRp25xJ
    3tZHEpEnGaVBNwuIfj0GTyK8eEGB+ttghRvFj6OpoaijK2lAf6E53/yeR5FlmlQPKHH4
    e3w+mH2Umen/cBt2euUNZpHY3sKqIf7aNP4NOH9hIxTGqPZptt0RRR5eb4ATagaINrZ1
    xD44pmH7ANynoMUb/bCzFOQdTFWL+U9gcOrd8lMkP/Gh28s0t8s2tZ42FfA8cdj/jPty
    Z6HmhUAGAxqEuUOqRdDzWkcnVjJ8mVkR3tMnG1zH+QoLM3JLgc3TDBupxy+IGfryHsmd
    ckhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574660;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/89t7kagvmVUH2PkZ3RsurDh1iH7jgvxPKVl7Tj7Ex8=;
    b=HqukGcd64cDnoBPVC4+dLIA3AEpSTQcDsG6aEsWspO3tAq9tqo31zfGApwucz3Waxm
    O34iM2JZeYpE1kWzUolPABs9LfYKER4dLmN2NUYjwduBxlRd1+5ie1Sa/D5X3mI05kBg
    j8tkOGCBL6ef4C8msmoAxfD2ZDILVlN2uoWqTBLGenZ4fn/dT3/j8pdwQBae48WUmnmH
    b+gNdnEDVcqlVTxZ6icr32tcFXvvcXnZUZqChOYwVuOFOCaKHqtsa4GmrTfr2rixVvgD
    LMygaFQ6o+OSOhmK5XmuaG7kjVQmsy4OQS8GSJOIH2JSVe1wOBDq+eYEKMccBe8WL7/1
    rGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682574660;
    s=strato-dkim-0003; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/89t7kagvmVUH2PkZ3RsurDh1iH7jgvxPKVl7Tj7Ex8=;
    b=jD0YsMM0J5MLq9VDYVcJpnql7ape2cXTqxrySp4I2Mhg+Al4ua2paXfQU1JfpdWRUB
    nhGZxgPpptJR1OB/pGCA==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+2odkF/80="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id d6376fz3R5p0NqM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Apr 2023 07:51:00 +0200 (CEST)
From:   Dominic Rath <rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        christian.gmeiner@gmail.com, bahle@ibv-augsburg.de,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency properties
Date:   Thu, 27 Apr 2023 07:50:30 +0200
Message-Id: <20230427055032.85015-2-rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230427055032.85015-1-rath@ibv-augsburg.de>
References: <20230427055032.85015-1-rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
setting the PCIe PHY latencies.
The properties expect a list of uint32 PHY latencies in picoseconds for
every supported speed starting at PCIe Gen1, e.g.:

  tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
  rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 2ad1faadda2a..93228a304395 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -126,6 +126,24 @@ patternProperties:
         enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
         default: 8100
 
+      tx-phy-latency-ps:
+        description:
+          The PHY latencies for the TX direction applied to PCIe PTM timestamps. Most
+          PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+          accurate PTM timestamps, the PCIe PTM specification requires that the time
+          at which the first serial bit is present on the serial lines be taken.
+          Should contain picosecond latency values for each supported speed,
+          starting with Gen1 latency.
+
+      rx-phy-latency-ps:
+        description:
+          The PHY latencies for the RX direction applied to the PTM timestamps. Most
+          PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+          accurate PTM timestamps, the PCIe PTM specification requires that the time
+          at which the first serial bit is present on the serial lines be taken.
+          Should contain picosecond latency values for each supported speed,
+          starting with Gen1 latency.
+
     required:
       - reg
       - resets
@@ -203,6 +221,8 @@ examples:
                 cdns,phy-type = <PHY_TYPE_PCIE>;
                 cdns,num-lanes = <2>;
                 cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
+                tx-phy-latency-ps = <138800 69400>;
+                rx-phy-latency-ps = <185200 92600>;
             };
 
             phy@2 {
-- 
2.36.0

