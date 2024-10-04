Return-Path: <linux-pci+bounces-13875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2F99122D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 00:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F112832B5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DB1146A93;
	Fri,  4 Oct 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwIcvep7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A81411C8
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079925; cv=none; b=E9t2FMOjg9jF6eJVYEpVg9nFJXlpUjw9wOVgU3XiOwaTG0wlFO44hSjePH0BLtOUEUJP3WhdyxFXYxnDDHmcNPgquUVWrMn3nmaRb/T71A70uNxKR3z6YPcE4kbbZAJaPG2icVVmWvBFiyKGOlKu6Rfmbf2UGi+pjUv74cdtnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079925; c=relaxed/simple;
	bh=KbiQcFYiVJAE6boBPJAsK7pL0080Bl8fCggDl22vH5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dk5vVCn1j2x+ZhF2ZId+On70khkhw9asyFNRgiUUfmiT0naS1kFpPDZYJ/RhVkQmjhmZc2v0v/lKIiraipl64hzjfcP/9lQY86s7AWC35sYPMXZJL4VvdFT1vntTnMdxNcGUU+KnfWha+hZxGrfZA/vfZu1UkjJ6KBzVeALRbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwIcvep7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5ACC4CECD;
	Fri,  4 Oct 2024 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079924;
	bh=KbiQcFYiVJAE6boBPJAsK7pL0080Bl8fCggDl22vH5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OwIcvep7lAo0cTeifgH74WX8fw4KBoRC6NU8ki1GQXm3YjjaA6fEeLx8fRwGgm9l5
	 73fbS4S0V7NXWKLrpxDKu0Khxv0WfEceWPNVoKMlRhOD3hisRv4kKVEGet7XL449Ae
	 d0JaUdk7oFCS5nnZHDhXLOY8PTbusjty7wRi7iF8OkEoSSKvUoIFb0lCegngRD3FN+
	 V23BCIJFmNPGdyM+D3VzxwhpmcYq0ZrbQsYwRqMTAUR68boGcLu5dfWbbN2TRcePS6
	 9OeRJxWK24UFLYM+q7lx5nSi9MW4npPpSL3oT1zpypzvPJhA7Mu6XfvI1x1s+1/J3w
	 bp4V4Y+pkqoYA==
Date: Fri, 4 Oct 2024 17:12:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] PCI: endpoint: test: Synchronously cancel command
 handler work
Message-ID: <20241004221202.GA364252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004141255.5202-1-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 11:12:55PM +0900, Damien Le Moal wrote:
> Use cancel_delayed_work_sync() in pci_epf_test_epc_deinit() to ensure
> that the command handler is really stopped when proceeding with dma
> and bar cleanup.
> 
> The same change is also done in pci_epf_test_link_down() to ensure that
> the link down handling completes with the command handler fully stopped.

s/when proceeding/before proceeding/
s/dma/DMA/
s/bar/BAR/

Whoever applies this can tweak it.

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index a73bc0771d35..c2e7f67e5107 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -800,7 +800,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	pci_epf_test_clear_bar(epf);
>  }
> @@ -931,7 +931,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epc *epc = epf->epc;
>  
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	if (epc->init_complete) {
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);
> -- 
> 2.46.2
> 

