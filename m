Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA8600E0D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJQLsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJQLsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 07:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423C53D37;
        Mon, 17 Oct 2022 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86496108B;
        Mon, 17 Oct 2022 11:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D867C433B5;
        Mon, 17 Oct 2022 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666007279;
        bh=XFapxTpHu9EzBGP12vik84DfocOA+gjV/xwOfeyX0eo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTMJIIza9WqAg9FcoVifjPEnqdm5bnc66SfCqoZNzaTiD+1fkBuPWLxLlf5L6KG6f
         MkbUXlcuWUplEpwvkxVoTOYnF/y29ieEEezT4x4dGDEBq/YQdQ+FFxq9rWqtxmrxvj
         t5KIS39DnkV2pzhoXXHpiHJrJrRKUGQ+8XWTBKU6S4v6Xn8SpaTIK0OrtDr7b07LQJ
         4qM5C6Apu1/zr5C08NCusBgjquR/368GvVOkUgKIjqzk2yNOpNVQHndpgtYTfUjGV6
         0bki8l7cajFT3inlnaUe60/CtJpeXgaY/36g7nStoZad+vNu8QeQBxdtWLN3EPv38o
         4XMDtDffrE/pQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okOay-0002Az-Ky; Mon, 17 Oct 2022 13:47:48 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/2] PCI: qcom: Add support for modular builds
Date:   Mon, 17 Oct 2022 13:47:03 +0200
Message-Id: <20221017114705.8277-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow the Qualcomm PCIe controller driver to be built as a module, which
is useful for multi-platform kernels as well as during development.

There's no rush with this, but I figured I'd send an updated version
that has been rebased on 6.1-rc1 (where post_deinit() has been removed).

I also broke out the qcom_pcie_host_deinit() handler in a separate patch
as the host_deinit() callback has now been added to dwc core and can be
used to fixes some late-probe error handling.

Johan


Changes in v3
 - rebase on 6.1-rc1 where post_deinit() has been removed
 - split out host-init error handling
 - add Stan's ack

Changes in v2
 - rebase on next-20220720 (adjust context)
 - add Rob and Mani's reviewed-by tags


Johan Hovold (2):
  PCI: qcom: Fix host-init error handling
  PCI: qcom: Add support for modular builds

 drivers/pci/controller/dwc/Kconfig     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.37.3

