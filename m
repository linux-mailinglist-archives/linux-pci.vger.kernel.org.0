Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3D7529C0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGMRVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGMRVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 13:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522702686
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 10:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F1861B03
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12737C433C8;
        Thu, 13 Jul 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689268897;
        bh=ySRfl0lULTU/nELl9tj82XDzfEe2BbY7pOhmkNcZjKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i2JVenvDQ5XsT6z9JsiSuMMx6B0axrxLzhjlGLYy5Dx84755kMQaJlW3WA4TVd3vO
         DWPfMhgqGOVFAWAVEZpbapYNdPBanh0TE4zCQBETjSAhyYs/E733A1SEHK5sNXovYw
         cwzg1NwjO6XEjWH4Y1W70xKJcd9OJbBoW5kVlJcrsr7A08N3pY2yzJUPgDJnAQtxOS
         WxYUQczOYZw0P4A052jEOxzKPwFCa75dByBF9Ev+570ruKz2f6q3rffYE51rVHsGZL
         cRZBeXEVxWYP0FOxfWm9NR1K2lJexBVStcRtV9rfpkFVWGHznqz4Z8nkz4ez2ThyQn
         RxCFnpgPRP28Q==
Date:   Thu, 13 Jul 2023 12:21:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as DesignWare
 PCIe driver maintainer
Message-ID: <20230713172130.GA324258@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626151907.495702-1-kwilczynski@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 26, 2023 at 03:19:07PM +0000, Krzysztof Wilczyński wrote:
> Manivannan has been actively reviewing patches and testing changes
> related to the DesignWare core driver and other DWC-based PCIe drivers
> for a while now.
> 
> Thus, let's add Manivannan as a maintainer for the Synopsys DesignWare
> driver to make his role and contributions official.
> 
> Thank you Manivannan! For all the help with DWC!
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Applied with Mani's ack to for-linus for v6.5, thanks!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..61a64744e31b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16167,6 +16167,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> -- 
> 2.41.0
> 
