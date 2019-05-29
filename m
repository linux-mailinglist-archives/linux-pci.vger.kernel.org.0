Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C922E24D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfE2QcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 12:32:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QcD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 12:32:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B0E341;
        Wed, 29 May 2019 09:32:02 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B3A3F5AF;
        Wed, 29 May 2019 09:32:01 -0700 (PDT)
Date:   Wed, 29 May 2019 17:31:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Message-ID: <20190529163155.GA24655@redmoon>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529005710.23950-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 28, 2019 at 05:57:07PM -0700, Bjorn Andersson wrote:
> This series adds support for the PCIe controller in the Qualcomm QCS404
> platform.
> 
> Bjorn Andersson (3):
>   PCI: qcom: Use clk_bulk API for 2.4.0 controllers
>   dt-bindings: PCI: qcom: Add QCS404 to the binding
>   PCI: qcom: Add QCS404 PCIe controller support
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 113 ++++++++----------
>  2 files changed, 75 insertions(+), 63 deletions(-)

Applied to pci/qcom for v5.3, thanks.

Lorenzo
