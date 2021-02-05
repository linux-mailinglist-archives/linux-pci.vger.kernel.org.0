Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAAC311151
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBERyx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 12:54:53 -0500
Received: from foss.arm.com ([217.140.110.172]:36964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233281AbhBEP33 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 10:29:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE76E31B;
        Fri,  5 Feb 2021 09:11:01 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.37.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081B43F718;
        Fri,  5 Feb 2021 09:10:59 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/2] PCI: qcom: fix PCIe support on sm8250
Date:   Fri,  5 Feb 2021 17:10:53 +0000
Message-Id: <161254496801.21053.820582580317270864.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 17 Jan 2021 04:31:12 +0300, Dmitry Baryshkov wrote:
> SM8250 platform requires additional clock to be enabled for PCIe to
> function. In case it is disabled, PCIe access will result in IOMMU
> timeouts. Add device tree binding and driver support for this clock.
> 
> Canges since v4:
>  - Remove QCOM_PCIE_2_7_0_MAX_CLOCKS define and has_sf_tbu variable.
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
      https://git.kernel.org/lpieralisi/pci/c/a8069a4831
[2/2] PCI: qcom: add support for ddrss_sf_tbu clock
      https://git.kernel.org/lpieralisi/pci/c/f5d48a3328

Thanks,
Lorenzo
