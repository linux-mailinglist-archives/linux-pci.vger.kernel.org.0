Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D85FD4D4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJMGaO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJMGaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:30:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B2A196;
        Wed, 12 Oct 2022 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665642428;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=CWmn6To0JGv1MnQjd+D2BA6cBu0DjvbJImy3KZ7KMkg=;
    b=KclTgTuV5ztq/fS4TRV4G8cgI8+aRIvPhXtDf1LQGfy6iSgSN/FSt3auoqByTc5CO7
    ehgcOWOpWnKyVoTm66hBaxo/XJAEJ1P/Kx1b2ZvLaXR6u9Uqs5HYpx+Cbb6dFtpUg5zW
    yz6Dj3AU28OH652W/OW9j3BlIMcrNhtJ1uypH9OtqyJ+NWVOKvDe42tGj2Jo7ci88cwb
    /8VcydtvktiCg1505zYRTlOIiOjvaczPLeT/aGHv1uJQ1dDowJbfd/KV2tEPZuCZnB5m
    UfVSBHL+NRtyS7yQ1N0xHWBb7lh5ANhsGihm7jbeSOYLgAEbLF13IscUK7nVdNV5jSy4
    ro5Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+8odoEkA=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id R6cb4ey9D6R7C0V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 Oct 2022 08:27:07 +0200 (CEST)
From:   Dominic Rath <dominic.rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dominic Rath <dominic.rath@ibv-augsburg.de>
Subject: [PATCH 0/3] Cadence PCIe PHY latency for PTM
Date:   Thu, 13 Oct 2022 08:26:46 +0200
Message-Id: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Best Regards,

Dominic

Alexander Bahle (3):
  dt-bindings: PCI: cdns: Add PHY latency properties
  PCI: cadence: Use DT bindings to set PHY latencies
  arm64: dts: ti: k3-am64-main: Add latency DT binding

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |  2 +
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 +++++
 .../bindings/pci/cdns-pcie-host.yaml          | 20 +++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  4 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +
 .../controller/cadence/pcie-cadence-host.c    |  1 +
 drivers/pci/controller/cadence/pcie-cadence.c | 81 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 23 ++++++
 9 files changed, 155 insertions(+)


base-commit: a185a0995518a3355c8623c95c36aaaae489de10
-- 
2.36.0

