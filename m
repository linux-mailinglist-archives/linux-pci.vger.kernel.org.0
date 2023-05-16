Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E47057E4
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEPTtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPTtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C5A9;
        Tue, 16 May 2023 12:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA2162D8A;
        Tue, 16 May 2023 19:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD71C433D2;
        Tue, 16 May 2023 19:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266578;
        bh=K90crMBvGWv1uFUHmxW01PE2M6Nmno0yReDGlpG1yUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i38RnsNXEGAT4Q2f69Z/KFOKrz6IDzh8dR9mh5/NQGvzl++wCasx8R/rulrL156IA
         fs1YIKV55Nj4VXr/ijEYiDbPaxoUFHE4PaG3yFEw2z9ZNdNbdlSbNBJ3DqX+5I4E5s
         rK2ih/C+nzAwd8p384qrzL3Y1P2+Cg82RQbiNfzbIezifo7UE1VTqkYbiVRBrO/ffh
         eogPSspVZ443o//v8lekINHrHM85a5/ww43sRC1woMlj2zVapLaEG0nAbx9aCDGlrx
         /v+bjORKf57xcIeIwqAe0VexcNO8wFAnwdad6auNzEgKWOQbbFwh9/h3m4RTMEEopz
         bG0SJZWPoF6tA==
Date:   Tue, 16 May 2023 14:49:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: keystone: Free IRQ in `ks_pcie_remove` and the
 error handling section of `ks_pcie_probe`
Message-ID: <ZGPeUNqznHKETgqs@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516051659.22194-1-xyzeng@stu.xidian.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 16, 2023 at 01:16:59PM +0800, Xiangyi Zeng wrote:
> Smatch complains that:
> drivers/pci/controller/dwc/pci-keystone.c:1303 ks_pcie_probe() warn:
> 'irq' from request_irq() not released on lines: 1183,1187,1303.

Make this the entire warning line from smatch with no extra newlines
inserted.

> "ks-pcie-error-irq" was requested in the `ks_pcie_probe` function, but
> was not freed neither in the error handling part of `ks_pcie_probe`
> nor in the `ks_pcie_remove` function.
> 
> Fix this by adding `free_irq` in `ks_pcie_remove` and in a new error
> handling label `err_alloc` after `err_link` in `ks_pcie_probe`. In
> `ks_pcie_probe`, if `phy` or `link` memory allocation fails, we will
> fall to `err_alloc`. If any other error occurs that leads to
> `err_get_sync` or `err_link`, we end up going to `err_alloc`.

I think the backticks (`) are markdown that makes these "code".
Personally I think ks_pcie_probe() is more readable than
`ks_pcie_probe` since most people (I think) read these in plain-ASCII
situations.  And using backticks for labels and local variables seems
like overkill.

> Fixes: 0790eb175ee0 ("PCI: keystone: Cleanup error_irq configuration")
> Signed-off-by: Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

It's best if the Reviewed-by tag is not added until Dongliang sends
email with that tag directly to the mailing list.  Internal reviews
before posting to the mailing list aren't worth much.

> @@ -1309,12 +1316,14 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
>  	struct device_link **link = ks_pcie->link;
>  	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
> +	int irq = platform_get_irq(pdev, 0);

I think it's better to save the irq we looked up in ks_pcie_probe()
and free *that*.  It's probably the same thing you get by calling
platform_get_irq() again, but it seems cleaner to me to save what we
got in ks_pcie_probe().

>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
>  	while (num_lanes--)
>  		device_link_del(link[num_lanes]);
> +	free_irq(irq, ks_pcie);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
