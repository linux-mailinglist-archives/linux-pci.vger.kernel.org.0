Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36A52353E
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiEKOSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiEKOSM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:18:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA0C644EE;
        Wed, 11 May 2022 07:18:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381B3ED1;
        Wed, 11 May 2022 07:18:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AF533F66F;
        Wed, 11 May 2022 07:18:08 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Wed, 11 May 2022 15:18:03 +0100
Message-Id: <165227865526.22848.18311880619180745069.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 6 May 2022 18:20:59 +0300, Dmitry Baryshkov wrote:
> Convert pci/qcom,pcie schema to YAML description. The first patch
> introduces several warnings which are fixed by the other patches in the
> series.
> 
> Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> controller uses Synopsys PCIe IP core. However it is not just fused to
> the address space. Accessing PCIe registers requires several clocks and
> regulators to be powered up. Thus it can be assumed that the qcom,pcie
> bindings are not fully compatible with the snps,dw-pcie schema.
> 
> [...]

Applied to pci/qcom, thanks!

[1/8] dt-bindings: PCI: qcom: Convert to YAML
      https://git.kernel.org/lpieralisi/pci/c/5383d16f06
[2/8] dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
      https://git.kernel.org/lpieralisi/pci/c/81dab110d3
[3/8] dt-bindings: PCI: qcom: Specify reg-names explicitly
      https://git.kernel.org/lpieralisi/pci/c/a6f2d6b1b3
[4/8] dt-bindings: PCI: qcom: Add schema for sc7280 chipset
      https://git.kernel.org/lpieralisi/pci/c/bddedfeb13

Thanks,
Lorenzo
