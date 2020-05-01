Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C281C1B23
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgEARHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 13:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgEARHj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 13:07:39 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5556D20857;
        Fri,  1 May 2020 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588352858;
        bh=HSlpgB4cakLv+R39qkkcQgmHk+36wQXD52MTboqytnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ww3GKHKclFIad96d/VkKC5pcHDUX9mlZA/ugl1W8spvvK1ZRKC7QiXCR6Iav6eWOM
         nCcZZck/KLqWZrW4Jl/VJvcz8ZO098W5/l9hamC6nM8+vd0keDlYWDFUpPsPMWXmmH
         JroqMRfDrYaTKmu534yvn7pX0J6MMbeEBfW/L+Ck=
Date:   Fri, 1 May 2020 12:07:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Multiple fixes in PCIe qcom driver
Message-ID: <20200501170736.GA115107@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 12:06:07AM +0200, Ansuel Smith wrote:
> This contains multiple fix for PCIe qcom driver.
> Some optional reset and clocks were missing.
> Fix a problem with no PARF programming that cause kernel lock on load.
> Add support to force gen 1 speed if needed. (due to hardware limitation)
> Add ipq8064 rev 2 support that use a different tx termination offset.
> 
> v3:
> * Fix check reported by checkpatch --strict
> * Rename force_gen1 to gen
> * Fix spelling error
> * Better describe qcom_clear_and_set_dword
> * Make PARF deemph and equalization configurable
> 
> v2:
> * Drop iATU programming (already done in pcie init)
> * Use max-link-speed instead of force-gen1 custom definition
> * Drop MRRS to 256B (Can't find a realy reason why this was suggested)
> * Introduce a new variant for different revision of ipq8064
> 
> Abhishek Sahu (1):
>   PCI: qcom: change duplicate PCI reset to phy reset
> 
> Ansuel Smith (8):
>   PCI: qcom: add missing ipq806x clocks in PCIe driver

s/in PCIe driver// (obvious from context)

>   devicetree: bindings: pci: add missing clks to qcom,pcie
>   PCI: qcom: add missing reset for ipq806x
>   devicetree: bindings: pci: add ext reset to qcom,pcie

s/to qcom,pcie// (obvious from context after updating as below)

>   PCI: qcom: introduce qcom_clear_and_set_dword
>   PCI: qcom: add support for defining some PARF params
>   devicetree: bindings: pci: document PARF params bindings
>   devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie

s/to qcom,pcie// (obvious from context after updating as below)

> Sham Muthayyan (2):
>   PCI: qcom: add ipq8064 rev2 variant and set tx term offset
>   PCI: qcom: add Force GEN1 support

Hi Ansuel, if you post this again, would you mind adjusting your
subject lines to match the history, e.g.,

  $ git log --oneline drivers/pci/controller/dwc/pcie-qcom.c
  604f3956524a PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM
  ed8cc3b1fc84 PCI: qcom: Add support for SDM845 PCIe controller
  64adde31c8e9 PCI: qcom: Ensure that PERST is asserted for at least 100 ms
  ...

  $ git log --oneline Documentation/devicetree/bindings/pci/qcom,pcie.txt
  5d28bee7c91e dt-bindings: PCI: qcom: Add support for SDM845 PCIe
  29a50257a9d6 dt-bindings: PCI: qcom: Add QCS404 to the binding

(Capitalize first word, follow "dt-bindings: PCI: qcom" example).

Some of the commit logs also have random-length short lines.  Please
wrap them to use the entire ~75 column width and add blank lines
between paragraphs.

Add ("..") on the Fixes: lines.  See git log for common practice.  I
use this alias to make them:

  $ type gsr
  gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
  $ gsr 82a823833f4e
  82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")

Some of the logs use "SoC", some use "soc".  I prefer "SoC" because
"soc" really isn't an English word.

You don't need to post a new version just for these tweaks, but maybe
make them in your local copy so if you do post a v4 for some other
reason, they'll be included.

>  .../devicetree/bindings/pci/qcom,pcie.txt     |  51 +++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 241 ++++++++++++------
>  2 files changed, 211 insertions(+), 81 deletions(-)
> 
> -- 
> 2.25.1
> 
