Return-Path: <linux-pci+bounces-39787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0735C1F505
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77A53B902E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2530FC3D;
	Thu, 30 Oct 2025 09:30:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A22868AB;
	Thu, 30 Oct 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816624; cv=none; b=P8tKUZrLMQJ+0sboVnPDj1AmhGgNJY4tQRB7RzttwJ8ecaNBUMx4M64ZYFO+x1HQK4rxi1Mf3kzq6WJh1U0EeDn/HBVXL8Imhh9qPM8WW0KWzzkZ6UptROncW/pN68lPt0Uk2L7eoufA/jUlG/Ysqa1MuIcr3c8JzotsYhiqdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816624; c=relaxed/simple;
	bh=IiDdolWvGoh3s/xhnwLz51nodMF9z6rglepVl9ABgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7b/F79z7wBgl2n0OdAQu0WfqeXP0x0zuwk9tjXUS6ZGQggjAiS+KiwlaNiAMLLaFkOtnLAmG8mqse07dV+wkFuznXApnsXUCwofLm0sm9e5qL6SbQAYJ4trmxk82tQQm29DTqsB3yKpcNZKgeO9fPsJvsh4z+wEqjFieXYYAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 379E720083DE;
	Thu, 30 Oct 2025 10:30:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 323DF593A; Thu, 30 Oct 2025 10:30:13 +0100 (CET)
Date: Thu, 30 Oct 2025 10:30:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tony Hutter <hutter2@llnl.gov>, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <aQMwJZlHtP99brn-@wunner.de>
References: <8f35eb96-3458-45d2-a31d-7813ae4e7260@llnl.gov>
 <20240926210259.GA13456@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926210259.GA13456@bhelgaas>

On Thu, Sep 26, 2024 at 04:02:59PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 23, 2024 at 05:06:05PM -0700, Tony Hutter wrote:
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
> >  		ops->get_attention_status = pciehp_get_raw_indicator_status;
> >  		ops->set_attention_status = pciehp_set_raw_indicator_status;
> >  	}
> > +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> > +	if (is_craye1k_slot(ctrl)) {
> > +		/* slots 1-24 on Cray E1000s are controlled differently */
> > +		ops->get_attention_status = craye1k_get_attention_status;
> > +		ops->set_attention_status = craye1k_set_attention_status;
> > +	}
> > +#endif
> 
> I'm not really thrilled about dropping device-specific code in here,
> but I don't have a better suggestion yet.

For acpiphp, we have an elaborate mechanism to register attention LED
drivers via acpiphp_register_attention() / acpiphp_unregister_attention().

So far it's only used by two drivers (acpiphp_ampere_altra.c and
acpiphp_ibm.c).

For pciehp we have one custom attention LED mechanism for VMD
(enabled through pci_dev->hotplug_user_indicators) and now
this Cray E1000 mechanism.

Personally I'm fine with keeping this lightweight and not add
a similar register/unregister mechanism as we did for acpiphp.

However I think it might make sense to drop the hotplug_user_indicators
flag and instead invoke the is_vmd() check directly from init_slot()
to make it more explicit what this is about and to allow the code to be
optimized away on non-x86.

Thanks,

Lukas

