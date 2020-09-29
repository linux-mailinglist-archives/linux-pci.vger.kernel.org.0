Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E241527D20C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgI2PCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 11:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgI2PCz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 11:02:55 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B3C2075F;
        Tue, 29 Sep 2020 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601391774;
        bh=NXldqJpYGauanSfTEPI04TFDaHThUR0ilLTddf/V0s8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ffqPonC9r3hF2Lzzq3xl0JqoVcOpCGe/mkvAwevJ5pIIXmwau4aF7zCutg2qWnEWC
         4W12P5AOZEv8gHl3px6WzjtotcSPwF3Kasl4xiobIPt8d/AmtO4WwBJxf3TVVWhGcJ
         S1rBe+wQagOJUgpVh2pqyRa0CeYajsOpwy49Xs20=
Date:   Tue, 29 Sep 2020 10:02:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, minghuan.Lian@nxp.com,
        roy.zang@nxp.com, mingkai.hu@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
Message-ID: <20200929150252.GA2540544@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 09:13:28PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the current error response behavior, it will send a SLVERR response
> to device's internal AXI slave system interface when the PCIe controller
> experiences an erroneous completion (UR, CA and CT) from an external
> completer for its outbound non-posted request, which will result in
> SError and crash the kernel directly.

Possible wording:

  As currently configured, when the PCIe controller receives a
  Completion with UR or CA status, or a Completion Timeout occurs, it
  sends a SLVERR response to the internal AXI slave system interface,
  which results in SError and a kernel crash.

Please add a blank line between paragraphs, and
s/This patch change back it/Change it/ below.

> This patch change back it to the default behavior to increase the
> robustness of the kernel. In the default behavior, it always sends an
> OKAY response to the internal AXI slave interface when the controller
> gets these erroneous completions. And the AER driver will report and
> try to recover these errors.

This reverts 84d897d69938 ("PCI: layerscape: Change default error
response behavior"), so please mention that in the commit log,
probably as:

Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")

Maybe it also needs a stable tag, e.g., v4.15+?

Since this is a pure revert, whatever problem 84d897d69938 fixed must
now be fixed in some other way.  Otherwise, this revert would just be
reintroducing the problem fixed by 84d897d69938.

This commit log should mention that what that other fix is.

AER is only a reporting mechanism, it is asynchronous to the
instruction stream, and it's optional (may not be implemented in the
hardware, and may not be supported by the kernel), so I'm not super
convinced that it can be the answer to this problem.

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index f24f79a70d9a..e92ab8a77046 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -30,8 +30,6 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> -#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
>  
>  #define PCIE_IATU_NUM		6
>  
> @@ -123,14 +121,6 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
>  	return 1;
>  }
>  
> -/* Forward error response of outbound non-posted requests */
> -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -
> -	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> -}
> -
>  static int ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -142,7 +132,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
>  	 */
>  	ls_pcie_disable_outbound_atus(pcie);
> -	ls_pcie_fix_error_response(pcie);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	ls_pcie_clear_multifunction(pcie);
> -- 
> 2.17.1
> 
