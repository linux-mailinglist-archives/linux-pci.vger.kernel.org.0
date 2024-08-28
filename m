Return-Path: <linux-pci+bounces-12391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D817C9633CA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907482835BA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8A1ABEBB;
	Wed, 28 Aug 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF6P6F3X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836515C146;
	Wed, 28 Aug 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880312; cv=none; b=LLRUBM0F/r4BLDPYD+uUJMipaVW2xbv44eTPzwA5AfMjWZ9OnxVsT5wzWMlah5SS29fUnbwKWZReTkyVrDNOW5oT8ylgAlJ99D8EN8XtML+U1vG/8SkHXUU7ycZwWscbshAwRbvSQIe/jQ81CqpXiEfdCDyMJGrL7BY98uFuqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880312; c=relaxed/simple;
	bh=BIrLiphukfW+vmOHt6jiLTZupXYGWDly0fj1I+2oBHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rwtcr6LEN2QrZDdAOGkC8r+sEOWXKrexJomOUEphqEoVOhF3IT7vKE9Rcd9BKHbnlEnx/4zPnWSPXpnYZbzl++Nr9gCm0u2i2m0ws0MQcTo1SLSQluluAtli/qvb498JS26eezMv2Di5qGOUycGtLhVRhthq7vSDPYpx3gMqIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF6P6F3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA9DC4CEC0;
	Wed, 28 Aug 2024 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724880311;
	bh=BIrLiphukfW+vmOHt6jiLTZupXYGWDly0fj1I+2oBHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KF6P6F3Xskomdh1xkvtAKsQwZnTWX6mLMDwo76fbv3gpYyY/n6srkPOB+zm/OWsJt
	 6rNhc6VsURHh3aVW1Q3rsrXhybIJ3HdtC1gDeIrQUH0efRKC2O/WkIFCMLLwE4UNb4
	 03uSkfJ5rTXJreX5RK1OgFfTV3XTBiz5NIeMIYw0NMeEN2z172FpLUEDSicPQ649P1
	 77jDy/cc4tWjttQwNdJ5i9WllUTAtCsd9bBaaPux4TPzXFoDP5m/jxikD/+RGY3hxZ
	 XMsQ5u7+NB3lPdiubyUWvkWSmsu6p1/ahCc29T+5g9Y3qPTPUABg8rd9PZQUhi8ii1
	 ZrtaK7WPJPQow==
Date: Wed, 28 Aug 2024 16:25:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] PCI: Remove two unused declarations
Message-ID: <20240828212509.GA39447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824100331.586036-1-yuehaibing@huawei.com>

On Sat, Aug 24, 2024 at 06:03:31PM +0800, Yue Haibing wrote:
> Commit b67ea76172d4 ("PCI / ACPI / PM: Platform support for PCI PME
> wake-up") declared but never implemented __pci_pme_wakeup().
> Commit fd00faa375fb ("PCI/VPD: Embed struct pci_vpd in struct pci_dev")
> removed pci_vpd_release() but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Split into two patches (PCI/PM and PCI/VPD) and applied to pci/misc
for v6.12, thank you!

> ---
> v2: Add pci_vpd_release() history
> ---
>  drivers/pci/pci.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e9b1c7b94a5..4c284c55a0c5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -124,7 +124,6 @@ void pcie_clear_device_status(struct pci_dev *dev);
>  void pcie_clear_root_pme_status(struct pci_dev *dev);
>  bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
> -int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
>  void pci_pme_restore(struct pci_dev *dev);
>  bool pci_dev_need_resume(struct pci_dev *dev);
>  void pci_dev_adjust_pme(struct pci_dev *dev);
> @@ -169,7 +168,6 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
>  }
>  
>  void pci_vpd_init(struct pci_dev *dev);
> -void pci_vpd_release(struct pci_dev *dev);
>  extern const struct attribute_group pci_dev_vpd_attr_group;
>  
>  /* PCI Virtual Channel */
> -- 
> 2.34.1
> 

