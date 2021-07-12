Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955643C652A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhGLUyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 16:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGLUyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 16:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05F4660C3D;
        Mon, 12 Jul 2021 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626123111;
        bh=VMIMHBBaYQoT8fF3u11+Rozs5wvt1WTtFd3dA//VIyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LL8sY04sR9nrKo+VTPVybolNRfzEE0Ro4z/LgYNdb87QMWFYR5tRRycRTZAHC/DsL
         LyRdEl/WM9Mfvk34aq7ONTV99P19xU4hu0niHbOGXxdkx+SrCEsniqmQxzMQgCcv2i
         PE+fqlZMOw74w8GMxvvFv/HWlnR3IyTslvIYgdYl12sR1v/tBN/65AlE3VNzdnB9oV
         FL7d53vC+Gz6uHzvMq/I8T5D6rHfFioA1blO5Bt/04KppG/0mZJ2YgjXtybx2oSM27
         EH9ts2usw2EXp5SIFhoHjbcncgFIoKxIHOFdonJqrUjne1cduhbUINSM29Ef9YNoUR
         8Wb1vpiyOQSHQ==
Date:   Mon, 12 Jul 2021 15:51:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210712205149.GA1675719@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 23, 2021 at 10:07:57AM +0100, Uwe Kleine-König wrote:
> The driver core ignores the return value of pci_epf_device_remove()
> (because there is only little it can do when a device disappears) and
> there are no pci_epf_drivers with a remove callback.
> 
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
> 
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Can you just include this with the rest of your series that depends on
it, like you did for the s390 patches, so they're all together?

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 5 ++---
>  include/linux/pci-epf.h             | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 7646c8660d42..a19c375f9ec9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *dev)
>  
>  static int pci_epf_device_remove(struct device *dev)
>  {
> -	int ret = 0;
>  	struct pci_epf *epf = to_pci_epf(dev);
>  	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
>  
>  	if (driver->remove)
> -		ret = driver->remove(epf);
> +		driver->remove(epf);
>  	epf->driver = NULL;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct bus_type pci_epf_bus_type = {
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..f8a17b6b1d31 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -85,7 +85,7 @@ struct pci_epf_ops {
>   */
>  struct pci_epf_driver {
>  	int	(*probe)(struct pci_epf *epf);
> -	int	(*remove)(struct pci_epf *epf);
> +	void	(*remove)(struct pci_epf *epf);
>  
>  	struct device_driver	driver;
>  	struct pci_epf_ops	*ops;
> -- 
> 2.30.0
> 
