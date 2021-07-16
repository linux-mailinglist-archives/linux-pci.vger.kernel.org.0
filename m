Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297623CB8AC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhGPOcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 10:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhGPOco (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 10:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92222608FE;
        Fri, 16 Jul 2021 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626445789;
        bh=VPwtDfFzlw2mMjhZCIjf8rYJAIRLSJ0qqv+tfTiMLqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L+iju3E9TjfAX40sCXr1w6l/1yhGm39A5FS/30uSaeW+Lsq2rZnATy/faAaI4Kg8X
         xAkgX1Y1p0mPS9uEfa/w7+9kHyEoJYSSOtJXGRdEZVF9UnUSkq18TmtGQAkrBEWvqg
         86Vmyc2ZYHn99ZraEakry6E1C95TOLwCVv41apVGUg+0qq46jQL1haF7ewlajB6Mzx
         HtOjG8VbLvrXkR9n9nZeoKW/LuqYXA0mbInPJj9uKB3xFoyOhkrv2+8i89jST2NyBX
         P49d4jE8pbMzeA/lM2o0mIyKrxwXoeIXlfaQo9GEYTt40Juxw3CnF3AMiVom58ksud
         4SF1jo27uR/2g==
Date:   Fri, 16 Jul 2021 09:29:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add DT bindings and DT nodes for PCIe and PHY in
 SC7280
Message-ID: <20210716142948.GA2098168@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626443927-32028-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Fri, Jul 16, 2021 at 07:28:43PM +0530, Prasad Malisetty wrote:
> Changes in v4 as suggested by Bjorn:
> 
> 	* Changed pipe clk mux name as gcc_pcie_1_pipe_clk_src.
> 	* Changed pipe_ext_src as phy_pipe_clk.
> 	* Updated commit message for [PATCH v4 4/4]. 
> 		
> 
> Changes in v3:
> 	* Changed pipe clock names in dt bindings as pipe_mux and phy_pipe.
> 	* Moved reset and NVMe GPIO pin configs into board specific file.
> 	* Updated pipe clk mux commit message.
> 	
> Changes in v2:
> 	* Moved pcie pin control settings into IDP file.
> 	* Replaced pipe_clk_src with pipe_clk_mux in pcie driver 
> 	* Included pipe clk mux setting change set in this series
> 
> Prasad Malisetty (4):
>   dt-bindings: pci: qcom: Document PCIe bindings for SC720
>   arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
>   arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
>   PCIe: qcom: Add support to control pipe clk src
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  17 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  38 +++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 125 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c             |  22 ++++

  $ ./scripts/get_maintainer.pl -f drivers/pci/controller/dwc/pcie-qcom.c

tells you that linux-pci should be included.  One reason that's
important is because patchwork watches linux-pci for incoming patches,
and I use patchwork as my to-do list.  
