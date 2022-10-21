Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A008607066
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUGsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 02:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJUGrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 02:47:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3C242CB9;
        Thu, 20 Oct 2022 23:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F5D8B82B1B;
        Fri, 21 Oct 2022 06:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C0DC43140;
        Fri, 21 Oct 2022 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666334868;
        bh=QZFgdFVSmg4MEVl1gC6mhp0X7Dh0uB8lyTuIoyqeqJU=;
        h=From:To:Cc:Subject:Date:From;
        b=nGIJTj94A6u2iWr3KT/xLh33Ds3CQomSVUTa5Q43f6HcLCGMdV0B2aWzSg8h0EkQJ
         dq6DMJHM3Q1r1sXgAbZzlOtDBnhbV7Drcsz6sj/jbSLo0NgyiEjUuoOXBFnpX81+RD
         q8zBZBtBkCgmBcjsHKEQmDyO5RyAkQED6cqch/wDC+mwW6dd/DyqMULmjk49Hh1acW
         vstHHPOJ8LAAySfBZIcSYvQZdRRWrBodnvoHpB8GDEHu42/9hzsFCjS3SEQPLN3iKU
         pAPtB0YdKemzjavJD6tGSoFDhLDvafxws+Lo14Z4ArnqQJwdHb+80KsmI0t6034+zW
         +esyQWAHKZtlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ollob-0001fQ-JG; Fri, 21 Oct 2022 08:47:34 +0200
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
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/2] PCI: qcom: Add basic interconnect support
Date:   Fri, 21 Oct 2022 08:46:14 +0200
Message-Id: <20221021064616.6380-1-johan+linaro@kernel.org>
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

Changes in v2
 - update the bindings so that the interconnect-names constraints apply
   to all platforms (Krzysztof)


Johan Hovold (2):
  dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
  PCI: qcom: Add basic interconnect support

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 20 +++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 76 +++++++++++++++++++
 2 files changed, 96 insertions(+)

-- 
2.37.3

