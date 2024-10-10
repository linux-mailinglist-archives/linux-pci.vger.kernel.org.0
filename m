Return-Path: <linux-pci+bounces-14230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B75999304
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2F7288F83
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558C1E909A;
	Thu, 10 Oct 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjD19mG2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9D1D0DC9;
	Thu, 10 Oct 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589536; cv=none; b=t+7JSbO2xHE4lEKFoTp2xKG+s1uRY15pqnvlaQXxkmtdF6wYP37DgwWZaN4wQ3h0Jv8dPPDe1XIsoeSkGuAJH99ePbJamSJVsqAhCygohn08tfdRyMQ/NXy7qPRekK7RTFaHG65p95agaFJUa0hlijopBxAlpHOE2SmjEj0WUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589536; c=relaxed/simple;
	bh=fC6e+HOlGju5RcSXlGfj2Cl4wtqqEoSiLxJ4MTzXUxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=srET88humDuviwX3LcaUCxlL5goKdL8hBYXgwA21walVbMQEia0yhU4NxymspJGvWZwdp9jMG8k87WE5f4TybU5J8+RnPeZxoEU3O2nvolrdGa2JnnJ4sgtXWx5SeqpS441HqZj+bWU0sCsxamDhVKWl+s86o6WOHa20msvtibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjD19mG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7467BC4CECC;
	Thu, 10 Oct 2024 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728589535;
	bh=fC6e+HOlGju5RcSXlGfj2Cl4wtqqEoSiLxJ4MTzXUxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NjD19mG2aWWowxO4lFiSKKhvgV+HjLCAOa22Kwfr/eYs2kN31ut3y7oMTGrapNAoE
	 rm0agtMbmy7IUTutZW/+7izZZ6XjvCcQ8Ypz/4p/CaPl9Ik9PSRlWS9J9mNViV23Bv
	 TPwab6so3VwAP1vwOBOf8TDVyPLZlbdOhFG9KKsODlMYll29HI04oHq1p4EwLWHRFY
	 Nq7jgwgfWX7gE7YpH3OAZN9gDBYqcsq3/llgb0vqufVyhMefwjqJc3WkKXUG/DdF9Q
	 sbyPWODUBvh/zOC98oLRyccnYs8U+ucn6uWRsE9kDELWM07r48xQm0u3uRG3l9NOLd
	 thYYR1fqfAa9w==
Date: Thu, 10 Oct 2024 14:45:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move no_pci_devices() to the only driver using
 it
Message-ID: <20241010194533.GA575181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009105218.7798-1-ilpo.jarvinen@linux.intel.com>

On Wed, Oct 09, 2024 at 01:52:18PM +0300, Ilpo Järvinen wrote:
> Core PCI code provides no_pci_devices() that is only used in the
> pc110pad driver during init to detect cases when PC110 definitely cannot
> be present. Move this legacy detection trickery/hack into the pc110pad
> driver.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, this is indeed a gross hack, and I'd be glad to eradicate it
from PCI.

> ---
>  drivers/input/mouse/pc110pad.c | 19 +++++++++++++++++++
>  drivers/pci/probe.c            | 17 -----------------
>  include/linux/pci.h            |  3 ---
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> index efa58049f746..f4167a7e71c8 100644
> --- a/drivers/input/mouse/pc110pad.c
> +++ b/drivers/input/mouse/pc110pad.c
> @@ -87,6 +87,25 @@ static int pc110pad_open(struct input_dev *dev)
>   * that the PC110 is not a PCI system. So if we find any
>   * PCI devices in the machine, we don't have a PC110.
>   */
> +#ifdef CONFIG_PCI
> +static int __init no_pci_devices(void)
> +{
> +	struct device *dev;
> +	int no_devices;
> +
> +	dev = bus_find_next_device(&pci_bus_type, NULL);
> +	no_devices = (dev == NULL);
> +	put_device(dev);
> +	return no_devices;
> +}
> +#else
> +static int __init no_pci_devices(void)
> +{
> +	return 1;
> +}
> +#endif
> +
> +
>  static int __init pc110pad_init(void)
>  {
>  	int err;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..2704503fa8fb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -65,23 +65,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
>  	return &r->res;
>  }
>  
> -/*
> - * Some device drivers need know if PCI is initiated.
> - * Basically, we think PCI is not initiated when there
> - * is no device to be found on the pci_bus_type.
> - */
> -int no_pci_devices(void)
> -{
> -	struct device *dev;
> -	int no_devices;
> -
> -	dev = bus_find_next_device(&pci_bus_type, NULL);
> -	no_devices = (dev == NULL);
> -	put_device(dev);
> -	return no_devices;
> -}
> -EXPORT_SYMBOL(no_pci_devices);
> -
>  /*
>   * PCI Bus Class
>   */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..4757ce7ccd53 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1107,8 +1107,6 @@ extern const struct bus_type pci_bus_type;
>  /* Do NOT directly access these two variables, unless you are arch-specific PCI
>   * code, or PCI core code. */
>  extern struct list_head pci_root_buses;	/* List of all known PCI buses */
> -/* Some device drivers need know if PCI is initiated */
> -int no_pci_devices(void);
>  
>  void pcibios_resource_survey_bus(struct pci_bus *bus);
>  void pcibios_bus_add_device(struct pci_dev *pdev);
> @@ -1969,7 +1967,6 @@ static inline struct pci_dev *pci_get_base_class(unsigned int class,
>  static inline int pci_dev_present(const struct pci_device_id *ids)
>  { return 0; }
>  
> -#define no_pci_devices()	(1)
>  #define pci_dev_put(dev)	do { } while (0)
>  
>  static inline void pci_set_master(struct pci_dev *dev) { }
> -- 
> 2.39.5
> 

