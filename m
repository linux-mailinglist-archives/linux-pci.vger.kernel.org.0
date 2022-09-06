Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680C5AE615
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiIFK6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbiIFK6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 06:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0229033E3D;
        Tue,  6 Sep 2022 03:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924C4614AE;
        Tue,  6 Sep 2022 10:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A253AC433C1;
        Tue,  6 Sep 2022 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662461923;
        bh=1UMB8q0W6BOfIZiB0QLIijgd1VBIsHWeMGabnordQp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2dOoEt4io1CvjY0VplDDDiUd9bdCxRAX2hjjOWg2FI457jIaJBRBvhQWqqkOQ+yk7
         NjLWNyelXkOTPOGK42YrWSDus6S2AN+I6fN4ECdLG+y/OPvMaeDwA1gxhN4M6MNTUd
         qrzM6TI/coB3HUn69GOPdBsULGGLTEtXbfC3d5AE=
Date:   Tue, 6 Sep 2022 12:58:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] misc: pci_endpoint_test: Aggregate params
 checking for xfer
Message-ID: <Yxcn4CPN3BkC9xg7@kroah.com>
References: <20220906101555.106033-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906101555.106033-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 07:15:54PM +0900, Shunsuke Mie wrote:
> Each transfer test functions have same parameter checking code. This patch
> unites those to an introduced function.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
> Changes in v2:
> * New patch
> ---
> ---
>  drivers/misc/pci_endpoint_test.c | 35 ++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8f786a225dcf..3bd9f135cdac 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	return false;
>  }
>  
> +static int pci_endpoint_test_validate_xfer_params(struct device *dev,
> +		struct pci_endpoint_test_xfer_param *param, size_t alignment)
> +{
> +	if (param->size > SIZE_MAX - alignment) {
> +		dev_err(dev, "Maximum transfer data size exceeded\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  				   unsigned long arg)
>  {
> @@ -363,9 +374,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  		return false;
>  	}
>  
> +	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
> +	if (err) {
> +		dev_err(dev, "Invalid parameter\n");

Also, you just printed 2 errors for the same error.  Not needed.
