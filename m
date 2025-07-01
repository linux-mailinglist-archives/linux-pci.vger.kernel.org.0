Return-Path: <linux-pci+bounces-31169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827BBAEF924
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50254E06C6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5A22094;
	Tue,  1 Jul 2025 12:49:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05371A29A;
	Tue,  1 Jul 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374193; cv=none; b=rJbARhw1kRPG6LvoOEs/RHxeAhj8RwCw9HoOFylqP7DrdQujmoyL2uFFOOLf/i4IbEgcMJ8zVqEuCNl4WedqdLGJuye7Y1sAe9eWnfxBOYn+I2T/VpyDYHJyaTt0Dv898+vjdgMfz7Alpx7vQMYLty0P/Rhq7uOm4P1ta32k7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374193; c=relaxed/simple;
	bh=SfWAk3wIbxwA6nMEpDKa5BYTQX2mvHu4Y0ggJuZsX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/YHJQ1iBsejU7QZCS9fjTNztu2uog96JLIqDuQubMFL4JQFRdML7Hai6tAUcAw7SzQCEGiaidw7o4LXFKQkztAzEDAKiEm1ZVnxYBsqH2DsSru6FgjCOtshp+5JTdgFK1hO5qQKGyDrvNJY9K3u1TaVqogzv7n9QaBzNXkMi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id F156C200918B;
	Tue,  1 Jul 2025 14:49:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DE504316C0B; Tue,  1 Jul 2025 14:49:41 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:49:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <aGPZZcb9D4qKr2rM@wunner.de>
References: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
 <aGOHkmG1jnDistgh@wunner.de>
 <n23tedrmgzfo7bxe4mbde2rrsayalcz4jya5yopoeahlll3qaw@mpz4oemtyern>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n23tedrmgzfo7bxe4mbde2rrsayalcz4jya5yopoeahlll3qaw@mpz4oemtyern>

On Tue, Jul 01, 2025 at 05:27:27PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 01, 2025 at 09:00:34AM GMT, Lukas Wunner wrote:
> > Hm, why does pci_pwrctrl_create_device() return a pointer, even though the
> > sole caller doesn't make any use of it?  Why not return a negative errno?
> > 
> > Then you could just do this:
> > 
> > 	if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
> > 		return 0;
> > 
> > ... at the top of the function and you don't need the extra LoC for the
> > empty inline stub.
> 
> This is what I initially submitted [1] though that returned NULL, but the
> idea was the same. But Bjorn didn't like that.
[...]

Thanks for summarizing the state of the discussion, I apologize for not
having paid sufficient attention to the thread.

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Lukas

