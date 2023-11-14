Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34907EB14F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKNN4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjKNN4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 08:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A2D4F;
        Tue, 14 Nov 2023 05:56:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC537C433D9;
        Tue, 14 Nov 2023 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699970193;
        bh=zn1cZkdmxow6oXx9mlxw4Bxyw+vPUUKmI1YntwViffA=;
        h=From:To:Cc:Subject:Date:From;
        b=ewfHx0DX6mWUD5x+Ub9YsdD/9h2Zx4P++52qj+6g/lLhdIMYPULBmDccX740UIkFV
         h2v1wfdtDWZxpTibEafrM2WXZYn8EMoTUAu85RqPkz/nBH2KYvs2cuMAL3lwu9bXzo
         UOmC0UC9b65g5nBpaGWNOtuV3trO9LwO73cuaqVEMCtCjmndpvoQ2zm5ouspzDedfz
         RTC0eKoXwKakmq4i9IYYGYXIknP7cGPsduJnrWJCymoNyq7TLtKfHXsELqNbRh6Fi2
         JKiETamQ7EmHJZvmblRZijBNX+pV/UxVAg+Ap6VV5f/2HDH492Dt4uPMwg07h32ZfS
         gOCPoIyRsnyCQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r2tu2-0008PN-1V;
        Tue, 14 Nov 2023 14:56:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] PCI: Fix deadlocks when enabling ASPM
Date:   Tue, 14 Nov 2023 14:55:47 +0100
Message-ID: <20231114135553.32301-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_enable_link_state() helper is currently only called from
pci_walk_bus(), something which can lead to a deadlock as both helpers
take a pci_bus_sem read lock.

Add a new locked helper which can be called with the read lock held and
fix up the two current users (the second is new in 6.7-rc1).

Note that there are no users left of the original unlocked variant after
this series, but I decided to leave it in place for now (e.g. to mirror
the corresponding helpers to disable link states).

Included are also a couple of related cleanups.

Johan


Johan Hovold (6):
  PCI/ASPM: Add locked helper for enabling link state
  PCI: vmd: Fix deadlock when enabling ASPM
  PCI: qcom: Fix deadlock when enabling ASPM
  PCI: qcom: Clean up ASPM comment
  PCI/ASPM: Clean up disable link state parameter
  PCI/ASPM: Add lockdep assert to link state helper

 drivers/pci/controller/dwc/pcie-qcom.c |  7 ++-
 drivers/pci/controller/vmd.c           |  2 +-
 drivers/pci/pcie/aspm.c                | 65 +++++++++++++++++++-------
 include/linux/pci.h                    |  3 ++
 4 files changed, 56 insertions(+), 21 deletions(-)

-- 
2.41.0

