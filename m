Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6B77C3B9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjHNXA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHNXAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 19:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C76E5F;
        Mon, 14 Aug 2023 16:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E696064775;
        Mon, 14 Aug 2023 23:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BE6C433C8;
        Mon, 14 Aug 2023 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692054011;
        bh=EGJa219ihsXwvLRWPwGjLPQ3UTuDHjV8KLOtyo3Xz5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pyhcsuGhgXNLbgCZ/if9Xu8DF/2u9Ax1DOX6dC4ngl9hHTcVkYVhQf3tOAe0OjwVm
         PpklY7mWveA1pALcUTFYqOm9z6mKj/PazrqpffyWSJY8AxnhkdBdrdqa4ZbwDxDAry
         ya8myKXKh0pGTK5B5xwK/MAK/LasV/V1OJdH0ipv3+VNos/vD0C3gxcI7H5TQR8CvZ
         rR1+fwslOxyyp29K35WAU41hWP57hJBc4b0fy78cwIr4dnBFcDABQCZ4qvSx+QSRNs
         lJbGEcI3M8WB29JPfGg4Eb2CO5vlmfcZoMRJBXXzcySJzCTkhnOXMwAvnEGXlLDhga
         w1DyPKBO92mPQ==
Date:   Mon, 14 Aug 2023 18:00:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230814230008.GA196797@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-void-drivers-pci-controller-pcie-iproc-platform-v1-1-81a121607851@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 14, 2023 at 10:29:22PM +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
> |                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
> 
> This is due to the fact that `of_device_get_match_data` returns a void*
> while `enum iproc_pcie_type` has the size of an int. This leads to
> truncation and possible data loss.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: There is likely no data loss occurring here since `enum
> iproc_pcie_type` has only a few fields enumerated from 0. Definitely not
> enough to cause data loss from pointer-width to int-width.
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index acdc583d2980..83cbc95f4384 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -52,7 +52,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> -	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
> +	pcie->type = (uintptr_t) of_device_get_match_data(dev);

This seems a little ugly on both ends: we have to cast the enum to
(int *) in the of_device_id table:

  static const struct of_device_id iproc_pcie_of_match_table[] = {
    {
      .compatible = "brcm,iproc-pcie",
      .data = (int *)IPROC_PCIE_PAXB,
    },

and then we have to cast it back to the the enum type here, and we
can't even use the actual enum type:

  pcie->type = (uintptr_t) of_device_get_match_data(dev);

I think this would be nicer if we made a struct iproc_pcie_of_data
along the lines of ks_pcie_of_data and put the enum values in
instances of that struct.

It's definitely a little more code and space, but it might also help
us get rid of some of the "switch (pcie->type)" stuff scattered around
this driver.

Bjorn
