Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86384A8362
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350269AbiBCLyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 06:54:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350340AbiBCLyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 06:54:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D699B11D4;
        Thu,  3 Feb 2022 03:54:32 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371BE3F774;
        Thu,  3 Feb 2022 03:54:31 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:54:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 0/5] qcom: add support for PCIe on SM8450 platform
Message-ID: <20220203115425.GA24443@lpieralisi>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 18, 2021 at 05:10:19PM +0300, Dmitry Baryshkov wrote:
> There are two different PCIe controllers and PHYs on SM8450, one having
> one lane and another with two lanes. Add support for both PCIe
> controllers
> 
> Dependencies:
>  - https://lore.kernel.org/linux-arm-msm/20211218140223.500390-1-dmitry.baryshkov@linaro.org/
> 
> Changes since v4:
>  - Add PCIe1 support
>  - Change binding accordingly, to use qcom,pcie-sm8450-pcie0 and
>    qcom,pcie-sm8450-pcie1 compatibility strings
>  - Rebase on top of (pending) pipe_clock cleanup/rework patchset
> 
> Changes since v3:
>  - Fix pcie gpios to follow defined schema as noted by Rob
>  - Fix commit message according to Bjorn's suggestions
> 
> Changes since v2:
>  - Remove unnecessary comment in struct qcom_pcie_cfg
> 
> Changes since v1:
>  - Fix capitalization/wording of PCI patch subjects
>  - Add missing gen3x1 specification to PHY table names
> 
> ----------------------------------------------------------------
> Dmitry Baryshkov (5):
>       dt-bindings: pci: qcom: Document PCIe bindings for SM8450
>       PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
>       PCI: qcom: Add ddrss_sf_tbu flag
>       PCI: qcom: Add interconnect support to 2.7.0/1.9.0 ops
>       PCI: qcom: Add SM8450 PCIe support
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  22 ++++-
>  drivers/pci/controller/dwc/pcie-qcom.c             | 101 ++++++++++++++-------
>  2 files changed, 91 insertions(+), 32 deletions(-)

Need an ACK from pci-qcom maintainers, thanks.

Lorenzo
