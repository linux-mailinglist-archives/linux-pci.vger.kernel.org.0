Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976F24C10D8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiBWK6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiBWK6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:58:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B54386E4F7;
        Wed, 23 Feb 2022 02:57:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD59106F;
        Wed, 23 Feb 2022 02:57:48 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.38.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E89D3F70D;
        Wed, 23 Feb 2022 02:57:46 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 0/4] qcom: add support for PCIe on SM8450 platform
Date:   Wed, 23 Feb 2022 10:57:40 +0000
Message-Id: <164561384675.19157.1017695661693402855.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
References: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
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

On Wed, 23 Feb 2022 13:14:31 +0300, Dmitry Baryshkov wrote:
> There are two different PCIe controllers and PHYs on SM8450, one having
> one lane and another with two lanes. Add support for both PCIe
> controllers
> 
> Changes since v5:
>  - Rebase on 5.17-rc1
>  - Drop external dependencies. The pipe_clk rework takes too much time
>    to be reviewed. SM8450 works with the current pipe_clk multiplexing
>    code. Fixing pipe_clk will be handled separately.
>  - Drop interconnect support. It will be handled separately for all
>    generations requiring interconnect usage.
> 
> [...]

Applied to pci/qcom, thanks!

[1/4] dt-bindings: pci: qcom: Document PCIe bindings for SM8450
      https://git.kernel.org/lpieralisi/pci/c/dddb4efa51
[2/4] PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
      https://git.kernel.org/lpieralisi/pci/c/f94c35e024
[3/4] PCI: qcom: Add ddrss_sf_tbu flag
      https://git.kernel.org/lpieralisi/pci/c/0614f98bbb
[4/4] PCI: qcom: Add SM8450 PCIe support
      https://git.kernel.org/lpieralisi/pci/c/1c5aa03726

Thanks,
Lorenzo
