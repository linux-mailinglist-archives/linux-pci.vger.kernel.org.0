Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F274E24A4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbiCUKuq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiCUKup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 06:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997A23BD7;
        Mon, 21 Mar 2022 03:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 736D7B81202;
        Mon, 21 Mar 2022 10:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DB5C340E8;
        Mon, 21 Mar 2022 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647859757;
        bh=huUpho3oZIwwEpj2ZIcjMR8j8ncYN4uWkyHSQ8QxcSg=;
        h=From:To:Cc:Subject:Date:From;
        b=RlpZskjfYCQaHWnm3drieTw6GwGmKilaNAWb6JJpHjiRftl/luhKimA3ugS8iUjys
         9PcvMy7xLWmhAhsI0FxaRZzgJt5Kd/w/PJuIyy+vlLi01PnhLQBwL5Em809Zy0+E5j
         daOnB02G1bC3mFPOQezcP6gNNLJLyrGBnXM+XN8ZjVV9ZG3xDyB/XZodYBFudRTsjH
         Xv4H/Z7C2yUGatVUPvVX8MGezPMc5YUpkNcTRMtGrt8+ymHY4VNd6NBTXbJVI+tDKM
         KHZVeOBiKA700Zyt7Fe4ZBZyVh7bLhlpsXPHXKudFcva4ThrczkYX2OwOE9BwYkfwf
         O5Z28nXSLtoCA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWFb8-00FvJp-On; Mon, 21 Mar 2022 10:49:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        kernel-team@android.com
Subject: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Date:   Mon, 21 Mar 2022 10:48:41 +0000
Message-Id: <20220321104843.949645-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, robh@kernel.org, toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com, stgraber@ubuntu.com, dann.frazier@canonical.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
merged in the 5.5 time frame, PCIe on the venerable XGene platform has
been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
IB window setup") fixed XGene-2, but left the rest of the zoo
unusable.

It is understood that this systems come with "creative" DTs that don't
match the expectations of modern kernels. However, there is little to
be gained by forcing these changes on users -- the firmware is not
upgradable, and the current owner of the IP will deny that these
machines have ever existed.

Given that, revert both changes and let people enjoy their XGene boxes
once again.

* From v1 [1]:
  - Also revert c7a75d07827a ("PCI: xgene: Fix IB window setup")

[1] https://lore.kernel.org/r/20220314144429.1947610-1-maz@kernel.org

Marc Zyngier (2):
  PCI: xgene: Revert "PCI: xgene: Use inbound resources for setup"
  PCI: xgene: Revert "PCI: xgene: Fix IB window setup"

 drivers/pci/controller/pci-xgene.c | 35 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.34.1

