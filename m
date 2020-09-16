Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCEB26CE45
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIPWFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgIPWFC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 18:05:02 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F6321D90;
        Wed, 16 Sep 2020 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600293900;
        bh=eUTWzYD9zEfDsAwI4leq47JAEbZSdDfHGOVYQOI3a44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U1OrSH7L/TTyKLRDeuVL1jE/Z2ssgGadqyOgxlOPq+Zvozwwd7aiIYTt1CgIveFdL
         fnnuF6Pr9gmp04OpJqhun8jtw1oUzjE7CMppmtcEVdd6s6SgCqFdwoSvb2YLFJk+fu
         mxmvQVA28D5fx+IASJ5CnH6mZyd7dXIEIg5/bEXk=
Date:   Wed, 16 Sep 2020 17:04:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] pci: controller: dwc: qcom: Add PCIe support for
 SM8250 SoC
Message-ID: <20200916220459.GA1588618@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-5-manivannan.sadhasivam@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 06:49:59PM +0530, Manivannan Sadhasivam wrote:
> The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
> the support is added reusing the 2.7.0 ops. Only difference is the need
> of ATU base, which will be fetched opionally if provided by DT/ACPI.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

s/opionally/optionally/

  $ git log --oneline drivers/pci/controller/dwc/pcie-qcom.c | head -10
  824001cb64c0 PCI: qcom: Replace define with standard value
  51ed2c2b6026 PCI: qcom: Support pci speed set for ipq806x
  8df093fe2ae1 PCI: qcom: Add ipq8064 rev2 variant
  de3c4bf64897 PCI: qcom: Add support for tx term offset for rev 2.1.0
  5149901e9e6d PCI: qcom: Define some PARF params needed for ipq8064 SoC
  6a114526af46 PCI: qcom: Use bulk clk api and assert on error
  ee367e2cdd22 PCI: qcom: Add missing reset for ipq806x
  dd58318c019f PCI: qcom: Change duplicate PCI reset to phy reset

Make yours match, maybe like this:

  PCI: qcom: Add SM8250 SoC support

That way the important information ("SM8250") isn't way at the end
where it may get chopped off.

If you're ambitious, do this for the non-PCI patches, too.
