Return-Path: <linux-pci+bounces-1526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0481FC1C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 00:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC442855F6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF910945;
	Thu, 28 Dec 2023 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI5YX4Wz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217F10A09;
	Thu, 28 Dec 2023 23:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA423C433C7;
	Thu, 28 Dec 2023 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703807788;
	bh=Jk+86/S1r/9V2CpRQH19M/qyIpjTHBmRL8QPPZUddQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eI5YX4WzZ1aVG3cwph4pUwkL/RRMvI1HF7KysTFE7iREGtNgyIlv1lhdrC0nJBoAy
	 srGswpzMWHOes0FU9P14RrEaX8XGyz/y3UHtnvMr2ulXTei7qXpM3hcuwySJQhqCIY
	 DZdUImJ6o/DHFLtQQha/Mc1eNWG74BBxciM6VuVunD58olbeT+aYjcOLZ9TKVn26Os
	 e2Kq2zOlPxEqeRnQ5xlQsIqTOPrM9dEAv4dsxime7QbRXtBxWnZ+jG15yDy4jVzFNN
	 KjG8RHHyBZzrRL2ARvK7USq4H/DV+EegM9znlc0iz4r7G1jdUOqIDNUuRcgS3HHsVO
	 MXFnZTVjkIAaA==
Date: Thu, 28 Dec 2023 17:56:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Daniel Stodden <dns@arista.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: switchtec: Fix an error handling path in
 switchtec_pci_probe()
Message-ID: <20231228235626.GA1559849@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01446d2ccb91a578239915812f2b7dfbeb2882af.1703428183.git.christophe.jaillet@wanadoo.fr>

[+to Daniel, can you take a look?  If you like this, I'd like to
squash it into df25461119d9 and credit Christophe since that's not
upstream yet]

On Sun, Dec 24, 2023 at 03:30:01PM +0100, Christophe JAILLET wrote:
> The commit in Fixes changed the logic on how resources are released and
> introduced a new switchtec_exit_pci() that need to be called explicitly in
> order to undo a corresponding switchtec_init_pci().
> 
> This was done in the remove function, but not in the probe.
> 
> Fix the probe now.
> 
> Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pci/switch/switchtec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 1804794d0e68..5a4adf6c04cf 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1672,7 +1672,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  	rc = switchtec_init_isr(stdev);
>  	if (rc) {
>  		dev_err(&stdev->dev, "failed to init isr.\n");
> -		goto err_put;
> +		goto err_exit_pci;
>  	}
>  
>  	iowrite32(SWITCHTEC_EVENT_CLEAR |
> @@ -1693,6 +1693,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  
>  err_devadd:
>  	stdev_kill(stdev);
> +err_exit_pci:
> +	switchtec_exit_pci(stdev);
>  err_put:
>  	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	put_device(&stdev->dev);
> -- 
> 2.34.1
> 

