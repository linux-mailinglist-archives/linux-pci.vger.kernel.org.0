Return-Path: <linux-pci+bounces-28357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F00AC2B52
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF6C4E20AB
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32E1FE45A;
	Fri, 23 May 2025 21:26:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812691F3B87;
	Fri, 23 May 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035581; cv=none; b=UFBe8uIDra+Wmcv3F9QJzru+KuSY2fUa5+HtCSnhEaJNsCwUNcg9QZLZpK6T8/EDinI+1Kmp7KFAewbaTjKpWCzFVQiehf1wOQVJf4FcW3J/YVI8BzDgDK1WXKW5sAhlS+BcFq6qlkpC9VCNnTNDLadAx+HNAjrYRaT1t3yBwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035581; c=relaxed/simple;
	bh=SOHTYxjEKCoVoQ/vP2ctFKnsmi301z+p0Ait05tMC6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5TCz7//IvfyCxV6XnAxx/SQGbThDB+AGJOvlpAYvUfaouRIX/qabctiG43LIDlhvZWcn4TeVwdksaycHNIKQy4JVGFrUQ8xtewWyxCzvERk5oi3+O5tgPytabmyBhXOFUhTA06lwC7PCkaigCeFtKspOFrGKDDA/d9MTXatBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1CAA52009D05;
	Fri, 23 May 2025 23:26:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 07AFF24A2A7; Fri, 23 May 2025 23:26:15 +0200 (CEST)
Date: Fri, 23 May 2025 23:26:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Cyril Brulebois <kibi@debian.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <aDDn94q9gS8SfK9_@wunner.de>
References: <20250523201935.1586198-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523201935.1586198-1-helgaas@kernel.org>

On Fri, May 23, 2025 at 03:17:59PM -0500, Bjorn Helgaas wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2510,6 +2510,7 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
>  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
>  {
> +#if defined(CONFIG_PCI_PWRCTL) || defined(CONFIG_PCI_PWRCTL_MODULE)
>  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
>  	struct platform_device *pdev;
>  	struct device_node *np;
> @@ -2536,6 +2537,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
>  	}
>  
>  	return pdev;
> +#else
> +	return NULL;
> +#endif
>  }
[...]
> This an alternate to
> https://lore.kernel.org/r/20250522140326.93869-1-manivannan.sadhasivam@linaro.org
> 
> It should accomplish the same thing but I think using #ifdef makes it a
> little more visible and easier to see that pci_pwrctrl_create_device() is
> only relevant when CONFIG_PCI_PWRCTL is enabled.

Just noting though that section 21 of Documentation/process/coding-style.rst
discourages use of #ifdef and recommends IS_ENABLED() and inline stubs
instead.

Thanks,

Lukas

