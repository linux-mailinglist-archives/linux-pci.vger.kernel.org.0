Return-Path: <linux-pci+bounces-6407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9448A94F9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052941F222C6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C613BC04;
	Thu, 18 Apr 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgYX6Is9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445513B5BE;
	Thu, 18 Apr 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428965; cv=none; b=sdzTixo3jquiZQcqX/Rexpn9YADIbR4jGNqzKcC9ANqFr5xQEW2r7t3oAojYUoSzhIcRqoYOnLC9eQvox1g1sAQ+iP8dLhlfl4diB+ZbZ6GwBlNsP9IflXvydgUAU8q7C604oCveqO7YB/2c7frrRRIgNgl1NqADGFgTHdBqPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428965; c=relaxed/simple;
	bh=bd8KmP0eNG6QIoiOj3QS9njH5HAgdTcy6xAd31jpY+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TceBjW89x+4FLoEKDtmFutuufl3PiIDZLJ6CgIuMNyX+ZJ4fdAepXKV3xaGOQdbH5PT083qZKXTYPUkXaJUopJpgH9ykJDWD3ATicTcwZD9Wi/AQ/etIp3Y6TknJhip6YIHx3DUg7kCf97QDOWY2STvLK0IVqEEAF2PbqFHUcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgYX6Is9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E293C116B1;
	Thu, 18 Apr 2024 08:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713428965;
	bh=bd8KmP0eNG6QIoiOj3QS9njH5HAgdTcy6xAd31jpY+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgYX6Is9pnYyLfqN4t6HRm206VvNEyftvmE/q+ffdHdAkNqCghhQoHBZoNK2b7QnF
	 THpFxKwWANBSMogYGsYR6gQ9Be1Iaxts+b72UxcszVF/76/SDY/AdLNz8mlXupnIDs
	 Nf7/g4yu5z/7A7EpGgfrDwuEzgozlFF91uHD2cddhrQA+U4Wgf80IyWiiPn4TkwyqK
	 64aJkLcJhCx5/P5jtTLwHgBp+OG7hZYFbD3qbHnw/U7dde8hLwMNfJSMg2mvY3UOt2
	 IYSbtqcoLk6ze/k9UMO5oergEZWz0LW/V8MGn677ECQh51FaetghK+r1ERnHKI8BWy
	 MJGFpsMw7i0Dg==
Date: Thu, 18 Apr 2024 10:29:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiDZ4Hgem9dP7iXz@ryzen>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
 <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>

On Thu, Apr 18, 2024 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> Instead of getting the epc_features from pci_epc_get_features() API, use
> the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> the NULL check is already performed in pci_epf_test_bind(), having one more
> check in pci_epf_test_core_init() is redundant and it is not possible to
> hit the NULL pointer dereference.
> 
> Also with commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
> flag"), 'epc_features' got dereferenced without the NULL check, leading to
> the following false positive smatch warning:
> 
> drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> error: we previously assumed 'epc_features' could be null (see line 747)
> 
> So let's remove the redundant NULL check and also use the epc_features::
> {msix_capable/msi_capable} flags directly to avoid local variables.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core initialization")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

