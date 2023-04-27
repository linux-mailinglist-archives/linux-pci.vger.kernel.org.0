Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADC6F008B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbjD0F5H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbjD0F5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:57:07 -0400
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 22:57:00 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DB359E
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 22:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682574657; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a9wMPiyLwLZIZyJNVcCPMTW1DGrzOvwMTVs1TVeG+WUZboU6R9Vvqi/ZEx5l1MA9FY
    kshrK/bVt+3uHU5PTzTckUCP8zoH1Elmi+czlJ0XAXv0L+dfortRo2TTHktSn9vwZ2Vv
    sRifZy0OhTVshwgDFLfhgt+4Lh2JqHojPeE1pPrycdcu15jf9eWtuS0RyAFtq7FeI+Ky
    ty3kerOI0BwmlMxePzISZ35DcLse83w5HQQVqxf/66mOifYynDUjHrVp5DYpo23Otx68
    Aa6a07MipXOD4C1EgyMwUALv+Kr5Rue1i2wxS+w8SaHIoMUQ1TlqYS7H2pnyUSolNSFH
    Rg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574657;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0RdX+7xAWsp826jhstTm3kG2Y6PBNziZpbmEFFXWF3Y=;
    b=jhbOqiCi4JgSXuKRRplcslsdWuzukr25w8SXYsjyyp8GI2thbt74L28YGxF9tXmY7w
    XOTx29lmiOamh0R4gGKkjZkbq9Vg/eNTkt9jPOkIEjhY16ZMYOUybQEKidyeP1bLWPH+
    b3qlCrNjZGdEvpTxD/F9BfbvG54IgDAHegWws+Vr45vu7K10cgfvyn7r10WidG2MA+Zk
    HoFmhXe3Sc+S/vY52mYq21Tl0ZsLzo/VmQJoX3kZc1ZJ4jTCz15kK4WbTBTdDDj6HZgr
    nTf0ekY+DHyiGf3y6vciqZkY1B2lAGWslxnjrQw563/NIIWRf+YV5XNqWjffU+cKMrje
    ctow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574657;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0RdX+7xAWsp826jhstTm3kG2Y6PBNziZpbmEFFXWF3Y=;
    b=tZqtGHpaoTL/yO8uE9qhFTHngpEet9QwIKKkWnr+3sbrQ8ihg630FkyDp4clPGD5DL
    gBzgu/OJYPuvCMZf4LXAcSmhlU3Ve/09u/qyjLDH80mUXlnukYWVk/MRSp3x1qswpc5V
    MJw7YNQBcPgcmQHT6BLpUyDZUxUo57AKE9m9pV49E29LvVN5BIqUdhENu2M8oOR7x6/V
    IsplirYexhILnB448FHojCOGxiCN8pVx8TqZNSz2mMmyQmhgEyJz2bIM9W9jVsYmbEIo
    39ZcCxvv9UxRwFBn4q+W05l7nGoiIqW1JjHRrMqKIPHMyr2z+5kigDcHFC8YFk0H1nWh
    asGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682574657;
    s=strato-dkim-0003; d=ibv-augsburg.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0RdX+7xAWsp826jhstTm3kG2Y6PBNziZpbmEFFXWF3Y=;
    b=xKYautB97pS4GwqEPdS2wUVQ3RB2/vtTGR3gy9FXSQgXJkpz+xLw+JtIJdrepABDQW
    C7YCnA7UHx5pcOzLt3DA==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+2odkF/80="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id d6376fz3R5ouNqL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Apr 2023 07:50:56 +0200 (CEST)
From:   Dominic Rath <rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        christian.gmeiner@gmail.com, bahle@ibv-augsburg.de,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH v2 0/3] Cadence PCIe PHY latency for PTM
Date:   Thu, 27 Apr 2023 07:50:29 +0200
Message-Id: <20230427055032.85015-1-rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
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

Hello Everyone,

this series adds PHY latency properties to the Cadence PCIe
driver to improve PTM accuracy, and configures the necessary
values for TI's AM64x processors.

These latencies are implementation specific and need to be
configured in the PCIe IP core's registers to allow the
PCIe controller to exactly determine the RX/TX timestamps for
PCIe PTM messages.

TI doesn't document these values in the datasheet or reference
manual as of now, but provided the necessary data via TI's E2E
forums (see PATCH 3/3).

Changes from v1 to v2:
   - move latency property to PHY instead of PCIe controller
   - drop vendor prefix from property name
   - rephrase commit message regarding optional properties
   - emit an info message instead of a warning in case
     an optional property is missing

Best Regards,

Dominic

Alexander Bahle (3):
  dt-bindings: phy: cadence-torrent: Add latency properties
  PCI: cadence: Use DT bindings to set PHY latencies
  arm64: dts: ti: k3-am64: Add PCIe PHY latency DT binding

 .../bindings/phy/phy-cadence-torrent.yaml     | 20 ++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  2 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +
 .../controller/cadence/pcie-cadence-host.c    |  1 +
 drivers/pci/controller/cadence/pcie-cadence.c | 92 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++
 6 files changed, 140 insertions(+)


base-commit: 0cfd8703e7da687924371e9bc77a025bdeba9637
-- 
2.36.0

