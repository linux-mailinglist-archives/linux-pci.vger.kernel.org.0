Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B748B207
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiAKQXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 11:23:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33688 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349952AbiAKQXt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 11:23:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE4B616CE;
        Tue, 11 Jan 2022 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA26C36AEB;
        Tue, 11 Jan 2022 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641918228;
        bh=iT43KF0jKXBgSZE+OciUjd6hHjJUR7L0kvKPGKl7auQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TvF1xsGbGzMVPDFeMhjz94V1sGJPbcpSrDftTUWEG15HSooUh1vA9bru/w+ejAS+g
         AOStluoI5CImvL7+l+70/DIul7GAYclbhR/WgldjZg0ftzQ10ja3ePr9jH+AIBIY9B
         sO5OLmkWGHYJmC9t/HyKINgNZv5hVyOFvdl/YsbW3t5hw/ioXdrHTRPkp680vKoLs3
         uB0IYQMlId41+OKFSFah4awUfDFBOGxCkBGC8pOSs9yVPLj3dWLfgtL5FeAg+BCdMm
         sSDyNdBrlISqVPS0gavUVS4tCh825XYUrXA+h5/k79QHNggq5iXw6Y2tVlrXVTbIcB
         qXwhav8nO/mQw==
Date:   Tue, 11 Jan 2022 10:23:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Wang <wangming01@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] misc: pci_endpoint_test: Use a semicolon as the end
 of the statement.
Message-ID: <20220111162346.GA146958@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641632977-6588-1-git-send-email-wangming01@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 08, 2022 at 05:09:37PM +0800, Ming Wang wrote:
> Even so, there is no syntax error. But, this may be a
> clerical error. ';' are more appropriate than ','.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>

Applied to pci/misc for v5.17, thanks!

> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 2ed7e3a..8f786a2 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -865,7 +865,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_release_irq;
>  	}
>  	misc_device->parent = &pdev->dev;
> -	misc_device->fops = &pci_endpoint_test_fops,
> +	misc_device->fops = &pci_endpoint_test_fops;
>  
>  	err = misc_register(misc_device);
>  	if (err) {
> -- 
> 1.8.3.1
> 
