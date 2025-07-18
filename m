Return-Path: <linux-pci+bounces-32527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4891B0A178
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC0D3A7806
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920B2BE03E;
	Fri, 18 Jul 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5EF0Uih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHD+AwUZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3B2BE03A;
	Fri, 18 Jul 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836525; cv=none; b=GplhQaZJ6FGQG9GkGa349g0CfPaGj/pj+csR6QjWOmwQn7GCZAMD6hdl1SMWX2RK2TJ5WWcp5r3tlLIndzT4TiihZyOX6qlqw1uK2oOjclZcPv/EYFsz3JxDBsX6zTUpde0cYD8LG9eZllsdFPoiRxz85OfVpKL+lx+TZ28lsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836525; c=relaxed/simple;
	bh=9h7aVVYYrDkHXwRvOkVokY42S8wdskjweITCzDd9S70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrgPa69HXXWN20v8LL1BDiUPciwvlDK8tmdQ9ZTTMejcbGVi+Iy0bMHwDfgKwDZ7rn9VdiLSNsVF+7JHumzd5n7qU3W4HqKP57JKv0LtuuVFbsqS3gvyFx0e4EX2LDqE9Ut6QcCvnlISyo9EEqRBe2ybzXFQK0gAefmCxcFQYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5EF0Uih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHD+AwUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 13:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752836521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z77rWYLJsQPQA+WR1w6ttuEsYazonIeb3TNtZiLJapA=;
	b=U5EF0Uih5X26U50A9Fb1lbRcnrZeq0FtOJnSo5CTywHTkGGVPjv4U7ZOWEGUgzCrliW7iG
	Gn34yoSb9oK+PkjRRiKay3EG0IC7TjD5N1nl9qiLpb1YkrT+Lr+4ivyEcsM0TPOOiPen8O
	pl4r+zAoACGzqu1BzXRpM3CSlFSnkO9vd5WBWyf6DzGdF3GY3hCFGg1aVUzXqktA8U7u1H
	v2y7tZ19bwTgl6EWCvwkH3UahtOWb6v59vxZaNzMBzLTATTXRanBOmnhFPmbVHq1i0Irgl
	hXNLW4bufNWwBJMesHhpqfz/UnPvMfg5MWdnpkMGHFkCSvXujodTn2h4Mza66Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752836521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z77rWYLJsQPQA+WR1w6ttuEsYazonIeb3TNtZiLJapA=;
	b=yHD+AwUZQmgz78krwhyqHvd6VV/g447bn5OKcRx2icl3ZCMy58siyJaCX1yJJ80zhplwBx
	lJW9Zw1nuSgIBADQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matthew Wood <thepacketgeek@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <superm1@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250718125935-75fa0343-af78-42be-bc3f-e8f806a4aee5@linutronix.de>
References: <20250717165056.562728-1-thepacketgeek@gmail.com>
 <20250717165056.562728-2-thepacketgeek@gmail.com>
 <20250718113611.00003c78@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718113611.00003c78@huawei.com>

On Fri, Jul 18, 2025 at 11:36:11AM +0100, Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 09:50:54 -0700
> Matthew Wood <thepacketgeek@gmail.com> wrote:

(...)

> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 268c69daa4d5..bc0e0add15d1 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(current_link_width);
> >  
> > +static ssize_t serial_number_show(struct device *dev,
> > +				       struct device_attribute *attr, char *buf)
> > +{
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	u64 dsn;
> > +
> > +	dsn = pci_get_dsn(pci_dev);
> > +	if (!dsn)
> > +		return -EIO;
> > +
> > +	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx\n",
> > +		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0xff,
> > +		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0xff);
> 
> I wonder if doing the following i too esoteric. Eyeballing those shifts is painful.
> 
> 	u8 bytewise[8]; /* naming hard... */
> 
> 	put_unaligned_u64(dsn, bytewise);
> 
> 	return sysfs_emit(buf, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
> 		bytewise[0], bytewise[1], bytewise[2], bytewise[3],
> 		bytewise[4], bytewise[5], bytewise[6], bytewise[7]);

This looks endianess-unsafe.

Maybe just do what some drivers are doing:

	u8 bytes[8];

	put_unaligned_be64(dsn, bytes);

	return sysfs_emit(buf, "%8phD");

> 
> 
> > +}
> > +static DEVICE_ATTR_ADMIN_RO(serial_number);
> 
> 

