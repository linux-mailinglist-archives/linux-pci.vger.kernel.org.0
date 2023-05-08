Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297E6FA8F8
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjEHKqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjEHKq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:46:28 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954B5595
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=MT9L6OCk50d9T2qe5Tb3KXKgRVt
        VU7f6zuqoqw8sTOk=; b=t+t2ipuw872AtktbXlwXpAFQYAe0Z/evBfefxUYVs9C
        w+PqxwOYS23yq5Hkyha65hWuDLqTZ2E93BMtEERn147x9fr2sJoMLK37OqRM9+Vg
        R+02cF/JRXdI0FpK7ldpjs/cH3/6U3/u9PbHqz+OwnmCsYRMHMHOv02NpWWa61tc
        =
Received: (qmail 1693227 invoked from network); 8 May 2023 12:46:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 May 2023 12:46:08 +0200
X-UD-Smtp-Session: l3s3148p1@F7GtWCz7moEujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [RFC PATCH 0/3] KingFisher: support regulators for PCIe
Date:   Mon,  8 May 2023 12:45:54 +0200
Message-Id: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here are the patches to make PCIe cards work in the slot CN15 on a
KingFisher board. This is still RFC only, so we can agree on all the DT
namings before I send out the patches individually. Looking forward to
comments!

   Wolfram

Wolfram Sang (3):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators
  arm64: dts: renesas: ulcb-kf: add regulators for PCIe ch1

 .../bindings/pci/rcar-pci-host.yaml           |  8 +++++++
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi      | 21 +++++++++++++++++++
 drivers/pci/controller/pcie-rcar-host.c       |  9 ++++++++
 3 files changed, 38 insertions(+)

-- 
2.30.2

