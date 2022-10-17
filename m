Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3568600DB0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJQL1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJQL1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 07:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEC5F982;
        Mon, 17 Oct 2022 04:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE09561068;
        Mon, 17 Oct 2022 11:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F530C433C1;
        Mon, 17 Oct 2022 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666006028;
        bh=fDX3YKS2ZbQApo4ilsZMUNMy6l8gRgEh8LArIOkE5bI=;
        h=From:To:Cc:Subject:Date:From;
        b=jZzoTqrzZoHvlj+P2Pbmq6AxayBbUILIvPyxw8U/T4yT5pTU0l8EOn3yWtF0SI8X0
         kRK+YLKWR1+DUbclH++zquLoTuYl7vmsR/WmDZHK+ehHXdo7tOlT3ZWCSySKzIKDpJ
         Eni2whm0BwJkR/4PuuxDQj96MQpstxizW4Ocj1biaatEEn6WX7y0++hONXLon5DeEP
         hSy0Obo7a/NDgw0CIDM9N5vsw81DuOHB8u+JS+fheuZGkTHzypp9LOlc2cHPJY/lHL
         A96NH8JiuhMZdW5boGMmxoZQKcK0KAStcUDV/aO62Z/mI0yDTFKROJ8jtBDekj3QKj
         Ls4YOqX0MjsjQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okOGm-0000aX-RY; Mon, 17 Oct 2022 13:26:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] PCI: qcom: Add basic interconnect support
Date:   Mon, 17 Oct 2022 13:24:47 +0200
Message-Id: <20221017112449.2146-1-johan+linaro@kernel.org>
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

On Qualcomm platforms like SC8280XP and SA8540P interconnect bandwidth
must be requested before enabling interconnect clocks.

Add basic support for managing an optional "pcie-mem" interconnect path
by setting a low constraint before enabling clocks and updating it after
the link is up.

This is specifically needed to prevent a crash on SC8280XP/SA8540P when
the interconnect constraints are enforced during boot.

As support for these platforms was added in 6.1-rc1 it would be nice to
have this merged as a fix for 6.1, but deferring for 6.2 works as well.

Johan


Johan Hovold (2):
  dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
  PCI: qcom: Add basic interconnect support

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 25 ++++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 76 +++++++++++++++++++
 2 files changed, 101 insertions(+)

-- 
2.37.3

