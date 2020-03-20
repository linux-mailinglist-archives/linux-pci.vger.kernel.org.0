Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A18D79D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTSrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTSrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 14:47:53 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6831C20767;
        Fri, 20 Mar 2020 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584730072;
        bh=HqpiTJQyr9fDyPSNuUEqWWkbEn51JriLn0w+UPbw2yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RRZFBvsbfiHI+AmQu/N+eR167scn+qgU4oNVo5beyw2SGt6t9vaMknwVf3fD3uGzz
         gI9C9c8HLqIJ1flmCtV5aXvQPGFVDfeu1ru8jIO1V2hzWWARhouxJxeb024GNSSqWm
         kPEgK86HvDj86XSNOAT+dBUUjTw2V53nyQrUNJCE=
Date:   Fri, 20 Mar 2020 13:47:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] pcie: qcom: add missing ipq806x clocks in pcie
 driver
Message-ID: <20200320184750.GA241809@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please add a cover letter with the patches as responses to it.

Make your subjects match in capitalization, verb tense, etc.:

  $ git log --oneline drivers/pci/controller/dwc/pcie-qcom.c
  ed8cc3b1fc84 PCI: qcom: Add support for SDM845 PCIe controller
  64adde31c8e9 PCI: qcom: Ensure that PERST is asserted for at least 100 ms
  67021ae0bbe9 PCI: qcom: Add QCS404 PCIe controller support
  5aa180974e4d PCI: qcom: Use clk bulk API for 2.4.0 controllers
  322f03436692 PCI: qcom: Use default config space read function
  02b485e31d98 PCI: qcom: Don't deassert reset GPIO during probe
  6e5da6f7d824 PCI: qcom: Fix error handling in runtime PM support
  739cd35918b7 PCI: qcom: Drop unnecessary root_bus_nr setting

On Fri, Mar 20, 2020 at 07:34:43PM +0100, Ansuel Smith wrote:
> Aux and Ref clk are missing in pcie qcom driver.
> Add support in the driver to fix pcie inizialization
> in ipq806x

s/pcie/PCIe/ in English text like commit logs and comments.
s/inizialization/initialization/

It'd be useful to have enough context to know what "ipq806x" is.

Add period at end of sentence.
