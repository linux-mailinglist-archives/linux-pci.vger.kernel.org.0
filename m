Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693C769D65
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjGaQ6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjGaQ54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 12:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE51BF2;
        Mon, 31 Jul 2023 09:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6309461224;
        Mon, 31 Jul 2023 16:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797EDC433C8;
        Mon, 31 Jul 2023 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690822660;
        bh=72vlDAb6cANLUfOVqCWVuKkz5zP6qjIHOwbf0AhYcjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gkCYuzJEKruzml05Dmom7tB9iVBnFLB1Rm0MtX65IwvDqW8GPWQ91h4t/kzQ4jB1z
         BF9L7vKhX2dx4H4/vVVquIlPtas5qtnPGdrgD/Roc55CuNwJikJU48AmCXVpYQEz01
         0FcDopC63Wf6yaTM7zq2d9IRrmxCFfn9xm1Ec5TrTm045V52jUuHtAWuJpAK1heRI2
         y/lNTQ6hC7nxTyvmD6zyuRQA8x45S1PzgpA4ypLNzj1wFVQKQyc+aOFZ0Sb3APYDCJ
         TvjA0+iEMv9k3UABzNMTaGLKLISEVCIYocoFG8KCTYaJBblQtG0lP7OpBtDJ3r/lmC
         LjjQB0Lczqm0w==
Date:   Mon, 31 Jul 2023 11:57:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Treat unknown irq events as an error
Message-ID: <20230731165738.GA14380@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726152931.18134-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 08:59:31PM +0530, Manivannan Sadhasivam wrote:
> Sometimes, the Qcom PCIe EP controller can receive some interrupts that are
> not known to the driver like safety interrupts in newer SoCs. In those
> cases, if the driver doesn't clear the interrupts, then it will end up in
> interrupt storm. But the users won't have any idea about it due to the log
> being treated as a debug message.
> 
> So let's treat the unknown event log as an error, so that it at least makes
> the user aware, thereby getting fixed eventually.

Would it be practical to log the error message, then clear the
interrupt to avoid the interrupt storm?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 267e1247d548..802dedcc929c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -593,7 +593,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  		dw_pcie_ep_linkup(&pci->ep);
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
>  	} else {
> -		dev_dbg(dev, "Received unknown event: %d\n", status);
> +		dev_err(dev, "Received unknown event: %d\n", status);
>  	}
>  
>  	return IRQ_HANDLED;
> -- 
> 2.25.1
> 
