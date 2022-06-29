Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF27A560230
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiF2OMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiF2OMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04082F021;
        Wed, 29 Jun 2022 07:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5779BB824B5;
        Wed, 29 Jun 2022 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F87C341CC;
        Wed, 29 Jun 2022 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=8S+TkRsSy+p3BiBnqfbIgdvnP2TeLi48aB8hIhUXsMg=;
        h=From:To:Cc:Subject:Date:From;
        b=fjLhBuC5EuNRjFebZqXprS0Z2nVi4Qz86WnqqmQTESb3Qtj1EnS+AlEv82Mc1F3vD
         Pswr7K+3goFaC668xoi7nE62nkWMv4JusvNZ2jUlI7nvknRE5N9Jm1l9vArwjocfQL
         JwwEjMmt96OszrRjgTcvT/qRHk22BjK5RptZ+LCKWJW5uxql9JG0aTjwZquDDnjoc2
         03kcxBTYppM07JbhM5kLUnz9myDQvuYC4R7cdcgpyYSS8PSJjWkaz7sJIBZ6OJwQSN
         l461+DE8OCvvpDPTY+wvQyRqp8gZsgaZL5rqLEVH9E/HM87UsOWE48jbY9jpdMJTF3
         nrtOLoznzT/lA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQe-0004l6-9D; Wed, 29 Jun 2022 16:12:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/10] PCI: qcom: Add support for SC8280XP and SA8540P
Date:   Wed, 29 Jun 2022 16:09:50 +0200
Message-Id: <20220629141000.18111-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

as well as the about-to-be-merged MSI series:

	https://lore.kernel.org/all/20220620112015.1600380-1-dmitry.baryshkov@linaro.org/

While preparing the dt-binding update I found a bug in the dt-schema
introduced by the latter series and which is fixed by the second patch
below. Not sure it's worth respinning a v16 of the MSI series just for
that but if so then the fix could be folded into:

	https://lore.kernel.org/all/20220620112015.1600380-6-dmitry.baryshkov@linaro.org/

Johan


Johan Hovold (10):
  dt-bindings: PCI: qcom: Fix reset conditional
  dt-bindings: PCI: qcom: Fix msi-interrupt conditional
  dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
  dt-bindings: PCI: qcom: Add SC8280XP to binding
  dt-bindings: PCI: qcom: Add SA8540P to binding
  PCI: qcom: Add support for SC8280XP
  PCI: qcom: Add support for SA8540P
  PCI: qcom: Make all optional clocks optional
  PCI: qcom: Clean up IP configurations
  PCI: qcom: Sort device-id table

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  74 ++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 117 +++++++-----------
 2 files changed, 114 insertions(+), 77 deletions(-)

-- 
2.35.1

