Return-Path: <linux-pci+bounces-31139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B72AEEF50
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C3D7A9C8A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747841CBEAA;
	Tue,  1 Jul 2025 07:00:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92D158DAC;
	Tue,  1 Jul 2025 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353248; cv=none; b=s1BbpRf3l9k9gvOXMJdmP7Sj/ASLfn1dDxr/UZ4kdT2s5UwtfO7HNBFuefn7ilQeCODaZ0xDiDFtcAXKCUG6AhLo9N+Q2sNvGKv9DYxj5X2YtfeMnvT1kF/E3PixxA9OPBL9oQ63mjU4dLftK5gkNVMKOUtN9maWUXP1dRvWYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353248; c=relaxed/simple;
	bh=GBKpsxJ1frf7WrGf4FbqRv4hljWob214NmfNQEvM6Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ/kG/J+pWrKRTDbhDFQAH1DK0zXPB1jekvArZbj+f2xsLWFOCjEiqaV9/w+NCDBIPdjP5IvO6lmO+ZFuKW57qdYH0XCY0s8/2ZaDN/golgUS6TAkk4Uz1LD2tLQmpi6L7/8+X1b9lXTYndgVeA4Sq6bDHtjq5/yavirfN7vxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CE16E2C00E9B;
	Tue,  1 Jul 2025 09:00:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BB1033D6A42; Tue,  1 Jul 2025 09:00:34 +0200 (CEST)
Date: Tue, 1 Jul 2025 09:00:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <aGOHkmG1jnDistgh@wunner.de>
References: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>

On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
>  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
>  {

Hm, why does pci_pwrctrl_create_device() return a pointer, even though the
sole caller doesn't make any use of it?  Why not return a negative errno?

Then you could just do this:

	if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
		return 0;

... at the top of the function and you don't need the extra LoC for the
empty inline stub.

Another option is to set "struct pci_dev *pdev = NULL;" and #ifdef the body
of the function, save for the "return pdev;" at the bottom.

Of course you could also do:

	if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
		return NULL;

... at the top of the function, but again, the caller doesn't make any
use of the returned pointer.

Thanks,

Lukas

