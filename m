Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6657459A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiGNHOD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiGNHOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9716A450;
        Thu, 14 Jul 2022 00:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C6461B86;
        Thu, 14 Jul 2022 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF94C34115;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=+kNu+TdPD4M5/UQ/GUlnyvCp5J5nPFJiElj8Mfx/ybY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ugj3jl+CI5oNOitBHE/1sJ0oCbaypOL7LNspQ9tnuCNIvEFSnvsIkrPh+ukeuFkf0
         JPDU5FQC5WC71ge8yuL7Cvr1VJ2VuK65SvuPV7aR2WUoQcDt5VUO5kit2RvkU0yWPk
         L1aDPqXlHRmdvFLGgNdQ4y3Y+rV+NtaWt0TJ6SfTGFnAht1Go8Aayg5zaEtxDETzc2
         wuzR9lEfMTCkbiR/iv0bJY/wOSFZIfc87/NYc2sHhGJ9cEx3ixqpu5k/2hhbCodrKG
         IIwp+WyADT9KCAXuQ0tdKlzKDdKVYo1yh2WMhxJR8Nr+AGTHfDaDqe96fYCiuw7Iy7
         GTjz6CejlQqyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt2z-0001m5-Ut; Thu, 14 Jul 2022 09:14:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Date:   Thu, 14 Jul 2022 09:13:40 +0200
Message-Id: <20220714071348.6792-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the PCIe controllers found on SC8280XP and
SA8540P.

Included are also three patches that clean up the way the driver handles
different IP revisions (e.g. by modelling optional clocks as being truly
optional).

These patches depend on the recently merged (but currently held off?)
PIPE clock series:

	https://lore.kernel.org/all/20220608105238.2973600-1-dmitry.baryshkov@linaro.org/

as well as the about-to-be-merged MSI series (v17):

	https://lore.kernel.org/all/20220707134733.2436629-6-dmitry.baryshkov@linaro.org/

Note that the final patch in the PIPE clock series is currently missing
from the pci/ctrl/qcom-pending branch:

	https://lore.kernel.org/all/20220608105238.2973600-6-dmitry.baryshkov@linaro.org/

Johan


Changes in v2
 - drop the two DT schema fixes which have been applied by Bjorn H and
   squashed into the MSI v17 series by Dmitry, respectively
 - rebase on pci/ctrl/qcom-pending (2022-07-14)
 - fix compatible sort order (Krzysztof)
 - amend commit message for first patch to clarify motivation
   (Krzysztof)
 - add acks and reviewed-by tags from Dmitry, Krzysztof, Mani and Rob


Johan Hovold (8):
  dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
  dt-bindings: PCI: qcom: Add SC8280XP to binding
  dt-bindings: PCI: qcom: Add SA8540P to binding
  PCI: qcom: Add support for SC8280XP
  PCI: qcom: Add support for SA8540P
  PCI: qcom: Make all optional clocks optional
  PCI: qcom: Clean up IP configurations
  PCI: qcom: Sort device-id table

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  70 +++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 121 +++++++-----------
 2 files changed, 114 insertions(+), 77 deletions(-)

-- 
2.35.1

