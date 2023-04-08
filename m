Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5976DB9D6
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDHJaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 05:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E141C140;
        Sat,  8 Apr 2023 02:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F71360C61;
        Sat,  8 Apr 2023 09:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD7C433EF;
        Sat,  8 Apr 2023 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680946219;
        bh=QPaxSX3lE++4lFklDls2/M5OGki5DbVvgLfnx2VYHZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vf5EMTu4n18afkrtUpoa8kDZL9uqbLygjX+jByM4VolzMAFO0RUtP+wH5GqwoYB46
         Ax3tHUOUV8b4nv7QvwUgGYGqc05yrkQcOMhU1zdsZluKmxIGk0VWp4mmujnMBWYVwX
         h4NwJewMtcBc0K+h3R8wIKhV4LLfnIoMTX5SWs6qpAubOI8ggycRWsKCEjRChgYy5g
         Gg9UihgzwaCNzqS9isB+iUKPoUcpKrv+zMVMf3bWX1IKeFqxv8do7Mv3PdThQOk2OK
         2gbqhpjpGhqjg8wyLT009y7BrSOA6lVJrmTf7fcnUk/+Outh2KfurVNBdyhWpIpBHM
         1EjTILes5DRCg==
Date:   Sat, 8 Apr 2023 15:00:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix potential double free in
 __pci_epc_create
Message-ID: <20230408093011.GD11124@thinkpad>
References: <20221220045930.1106921-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220045930.1106921-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 08:59:29AM +0400, Miaoqian Lin wrote:
> When all references are dropped, callback function pci_epc_release()
> for put_device() already call kfree(epc) to release memory.
> Remove abundant kfree to fix double free.
> 
> Fixes: 7711cbb4862a ("PCI: endpoint: Fix WARN() when an endpoint driver is removed")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2542196e8c3d..7dc640c99d9a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -800,8 +800,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  
>  put_dev:
>  	put_device(&epc->dev);
> -	kfree(epc);
> -
>  err_ret:
>  	return ERR_PTR(ret);
>  }
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
