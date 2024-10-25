Return-Path: <linux-pci+bounces-15349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BF9B0F7F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23C92841E1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E69618BBB7;
	Fri, 25 Oct 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnR+5JuU"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7418C027
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886707; cv=none; b=UzOgHlhP36iLIzd0z8JIa9WHGyuCdWQ9P+NU0IKy4R5N2oTA0Orb65XkPttjkA4lB985ZOmsGgUcQ1ojBMRi6r4MvcZWdm4gEsshebA2JZMQdGV0KGBMTHQxD8l4TUDGwE0ahu1DoaqGLQ4Q9Zvz0VU/RiMmstdNFcZMlRYIHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886707; c=relaxed/simple;
	bh=stievvjtUnbu0kEKEQUJIjUmYYYy/jyjyejrntzMS80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0lEYSHjbbaX/Fucsktw5rLaVcFuAYCuq9oh5CQRAy+D16t4MrlZgftoeBIXlXKJ4EWXtXpsw8+rF9j385IkiWYvh03/03wvtxb8S8UVz/bncZazd6ISfvYD2npZGQvv8kqEsYoMBwxpir8aaB7idR95dUYfQDuNa27C9KZwxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnR+5JuU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729886703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=521ZowZi7UIo78+UTtHFKtY/eHOSB9FKxW3FnvwmZfM=;
	b=WnR+5JuU0NGqi6zlW7s4nQESZ71ZA8AL4W7FjdMMzav+YjVpsI4YyZxu/6HUn0kz0wGGBU
	CE+CUQVxk1XnZxWOFL71ZWKoo8rL5aLZPpfGiUUHssqrVIF6qnMt2wEXWrOnovl1UkukPV
	i3rjTQjqPkAGoY+bPQ4yyk7YdmoY7ew=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-hIYKJCo_PFK4DM72V1-Eeg-1; Fri, 25 Oct 2024 16:05:02 -0400
X-MC-Unique: hIYKJCo_PFK4DM72V1-Eeg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5eb636b8d85so47401eaf.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 13:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729886701; x=1730491501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=521ZowZi7UIo78+UTtHFKtY/eHOSB9FKxW3FnvwmZfM=;
        b=Kr55JEiwav2Eds7VrN+I80iWrR/XpWB6Trl9jNyCO/ZnRy3Qgenm0HLHGxatx1zhZK
         B6KyyIkjoxP/hOVsokAMLrhWVt7OJCQD1rEyjIlp/BrRIRC24C1Emaqa3NNU+XhMsCnP
         sEGhG1HMEuUjTBG5gBdWlpW9rttVi65YL8U+T+TPZXzaL92e8dNU3zoB8HLX5F7TuduX
         k7Eb+1pAvdbFCkx5kRx+zimL/VffAhrryjkBHDBDiq1U3QcijiRN4nJ4YCZTM/1S4RuP
         zL2RHQ8KNhTMe5qI+RxnCJGc+86UVrRBBLKkdTVWjNNt3QrKRtvPIZH3NK1rAoMaMu2Y
         Fb9g==
X-Forwarded-Encrypted: i=1; AJvYcCW2m45Hj8oyQZeKXapDNPGS+OKD15FrSeOLrXXjQ0jlf91P/0nVMg6ePd+GLXYYOUrlei9gKXqnFDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZfRfhlc83GP5unpgQPnqA50FaD3R1UURfylaVYrAA93OnhRe
	VfWreM2KqKTgsYkWZ7auA23o7/Sv3Z4++5fQC74rA24sxPJJ8JecU4sTORIzLSn7+PBcaaD+nb/
	SzosLq+7vAaA4bp8LKgLPcm4aA4ps05YWwMYgZbwEH3Rd05NTYPuFQcGkyQ==
X-Received: by 2002:a05:6871:694:b0:27b:9f8b:277f with SMTP id 586e51a60fabf-29051dcd160mr126189fac.14.1729886700997;
        Fri, 25 Oct 2024 13:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOWokj0D8Umqplu+4UvhNHqrFV3JrlZU9YUSaD38SCqS4wjzYAzVMUSmoKRt5wq2E6xV4LCg==
X-Received: by 2002:a05:6871:694:b0:27b:9f8b:277f with SMTP id 586e51a60fabf-29051dcd160mr126181fac.14.1729886700689;
        Fri, 25 Oct 2024 13:05:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290368a27ccsm460640fac.32.2024.10.25.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:05:00 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:04:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Keith Busch <kbusch@kernel.org>, Amey Narkhede
 <ameynarkhede03@gmail.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] pci: provide bus reset attribute
Message-ID: <20241025140458.5040cc29.alex.williamson@redhat.com>
In-Reply-To: <20241025165725.GA1025232@bhelgaas>
References: <20241025145021.1410645-1-kbusch@meta.com>
	<20241025165725.GA1025232@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 11:57:25 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, Amey, Raphael]
> 
> On Fri, Oct 25, 2024 at 07:50:21AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Attempting a bus reset on an end device only works if it's the only
> > function on or below that bus.
> > 
> > Provide an attribute on the pci_bus device that can perform the
> > secondary bus reset. This makes it possible for a user to safely reset
> > multiple devices in a single command using the secondary bus reset
> > method.  
> 
> I confess to being a little ambivalent or even hesitant about
> operations on the pci_bus (as opposed to on a pci_dev), but I can't
> really articulate a great reason, other than the fact that the "bus"
> is kind of abstract and from a hardware perspective, the *devices* are
> the only things we can control.
> 
> I assume this is useful in some scenario.  I guess this is root-only,
> so there's no real concern about whether all the devices are used by
> the same VM or in the same IOMMU group or anything?

I can understand your hesitation, but TBH I've wished for such a thing
in the past.  We can already twiddle the secondary bus reset bit using
setpci, but then we don't restore config space of the subordinate
devices and at best we need to remove and rescan those devices.

As Keith notes in his reply, we can also effectively trigger this same
thing through vfio-pci, so I think we're only making it a little easier
to accomplish through this sysfs attribute.  Yes, bad things can happen
if we were to reset a bus of running devices, but I don't know that
it's any more bad than resetting each of those devices individually.

I would agree that "reset" is not a great name since we're resetting
the subordinate devices and not the bridge device under which this
attribute would appear.  Seems there should also be an update to
Documentation/ABI/testing/sysfs-bus-pci in this patch too.  Thanks,

Alex

 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/pci/pci-sysfs.c | 23 +++++++++++++++++++++++
> >  drivers/pci/pci.c       |  2 +-
> >  drivers/pci/pci.h       |  1 +
> >  3 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5d0f4db1cab78..616d64f12da4d 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -521,6 +521,28 @@ static ssize_t bus_rescan_store(struct device *dev,
> >  static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
> >  							    bus_rescan_store);
> >  
> > +static ssize_t bus_reset_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct pci_bus *bus = to_pci_bus(dev);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 0, &val) < 0)
> > +		return -EINVAL;
> > +
> > +	if (val) {
> > +		int ret = __pci_reset_bus(bus);
> > +
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return count;
> > +}
> > +static struct device_attribute dev_attr_bus_reset = __ATTR(reset, 0200, NULL,
> > +							   bus_reset_store);
> > +
> >  #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
> >  static ssize_t d3cold_allowed_store(struct device *dev,
> >  				    struct device_attribute *attr,
> > @@ -638,6 +660,7 @@ static struct attribute *pcie_dev_attrs[] = {
> >  
> >  static struct attribute *pcibus_attrs[] = {
> >  	&dev_attr_bus_rescan.attr,
> > +	&dev_attr_bus_reset.attr,
> >  	&dev_attr_cpuaffinity.attr,
> >  	&dev_attr_cpulistaffinity.attr,
> >  	NULL,
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7d85c04fbba2a..338dfcd983f1e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5880,7 +5880,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
> >   *
> >   * Same as above except return -EAGAIN if the bus cannot be locked
> >   */
> > -static int __pci_reset_bus(struct pci_bus *bus)
> > +int __pci_reset_bus(struct pci_bus *bus)
> >  {
> >  	int rc;
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 14d00ce45bfa9..1cdc2c9547a7e 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -104,6 +104,7 @@ bool pci_reset_supported(struct pci_dev *dev);
> >  void pci_init_reset_methods(struct pci_dev *dev);
> >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> >  int pci_bus_error_reset(struct pci_dev *dev);
> > +int __pci_reset_bus(struct pci_bus *bus);
> >  
> >  struct pci_cap_saved_data {
> >  	u16		cap_nr;
> > -- 
> > 2.43.5
> >   
> 


