Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6666E8C8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAQV4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 16:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAQV4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 16:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA73EC46;
        Tue, 17 Jan 2023 12:23:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B0F61518;
        Tue, 17 Jan 2023 20:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC958C433EF;
        Tue, 17 Jan 2023 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673987014;
        bh=n6m+ald1WgX//enXYtbifctYkdlMCaoOBEM/pBEAw0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y3nk2mG5ymMIQ3hrg9lHGrndqDLsxu+f1KXLkc4BdaaCxDxG4p76LCBai7GJJjVbI
         64bwAa/u5TOD31JSp0gx8oA7gt4JT+7qPtK+wTx7ttveT26EBslgqER/u0jdY1nD0i
         WIG3921swwcOcEDY87rF4egoJIxX6IsMfKGz41eE6QnOH1/VsqNfiLtaHhjwrgH9s/
         7ZNVOXs/RDMYq9IdgQkW70PID7gfQLRTKl1PQ+cyRHCJVTf+9zYkx6EErIPm5WinfK
         TAQW7C1uvhUKi+lDJyMDVVKzs1qyDtbArtIbdtc4H8j6C3oiVCpVKb3c2zda3Ba8rp
         G9A/zjtLJO4Ug==
Date:   Tue, 17 Jan 2023 14:23:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] misc: pci_endpoint_test: drop initial kernel-doc marker
Message-ID: <20230117202332.GA144641@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113063937.20912-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 10:39:37PM -0800, Randy Dunlap wrote:
> This beginning comment is not kernel-doc, so change the "/**" to a
> normal "/*" comment to prevent a kernel-doc warning:
> 
> drivers/misc/pci_endpoint_test.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Host side test driver to test endpoint functionality
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to pci/misc for v6.3, thanks!

> ---
>  drivers/misc/pci_endpoint_test.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Host side test driver to test endpoint functionality
>   *
>   * Copyright (C) 2017 Texas Instruments
