Return-Path: <linux-pci+bounces-32119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A989B051BD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B215B4E09DB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81842D46CE;
	Tue, 15 Jul 2025 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTfWCaQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AC2D46C3
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560910; cv=none; b=ZvUIJGyww12TVQs0BwzGv6Qi4P/C1PvHTrVj80m2+mS5Si81j+lhT8yEuGpSCl21pKC7fr2+C+Ve2t2gUrbi2qFUrXmtca4dt5ZvUS214zxfEbt+O+CE8AI8ISm4gEQ/ScTnX7vdH4oMxSW4dZ1VjJVbqSqQJ+kyr+Rn0nsA6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560910; c=relaxed/simple;
	bh=HVLAmUFsd4ca7eAhdSj+4cz9K9308blq9ThuJgyfyLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6NuOLeNsN4SvzoNbGooBAZ1Nm4+7cMsc/ayUqVC/1xTIbCjuA/EKU+Ah3R/OjWgWDKEMYXdyTsRubZ1vZgoo/ZQ8ZijmLZVr1p02OdniH8t7/wEhrZWReqWlhEpKiVzV8t0/5sTSi3SZ8mK1k+aLmDuFpcF0Orfj3qd4iB164I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTfWCaQr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752560908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/E7fOgA7iMeC5HFW7xX5wxlga24gy2xi6vLJ/NZf2b8=;
	b=RTfWCaQr6YP+/VkdZ36AlByHwimVF8E7HuDTc3MUY2oyRV4oFVy4IJWVd4MRT5DuD3OJIj
	k4AQpiaAKXit7VL4XoPWeKZrSNwNLGhouapwMg98VC1DXbs7zSQa8hgPIqQWa6CDDIiPX/
	Do45OIMUKlS6XMVFVvkAbe6Li5GX2J0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-u93Vf6cuNv-4GqhD0uthVg-1; Tue, 15 Jul 2025 02:28:24 -0400
X-MC-Unique: u93Vf6cuNv-4GqhD0uthVg-1
X-Mimecast-MFC-AGG-ID: u93Vf6cuNv-4GqhD0uthVg_1752560904
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso8205255e9.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 23:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752560903; x=1753165703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E7fOgA7iMeC5HFW7xX5wxlga24gy2xi6vLJ/NZf2b8=;
        b=DcrgRHp6ZG3ZY2pjKDadwIS7VJtVexVcS4fYVz920e5qn5K3BPUqXHhjzagmPvnTeN
         MK3/fJPLCOMO3M5eTlzQOUx1Qx6FASOGcJok8mB5w9X3rhM5rc2zBi6oUsgsT5slJuQY
         Qwy8PSTBXpP8FZZyOkkXhuxaSML67MKjqRjgCa6EH4ACu9FEOEDaW+v+akOpfEW0zEVY
         UQlv5oJwmgK+PJ4ORnIF0Doyqg/6FkJFVmstYCn0UaVMn1Ilf+wRFW5N31TZP4TQ8Owy
         g7xtmYTDEyrLZaWFP5snd5n7lO1xy3SIS49OS3mwmYDE+CMwrwxZnQ4ktF6DMukb5ATo
         t5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUipvNknqzSjhIY1VNkelBNKpG+bDzYoiklpgftdq+cGqyaBne9wLIlk6PoeBT2xpJSML/YIeeHDjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZTgzyc3c+3wXhlFG+ORtpwG0xOBuP+56bHJNotCf1YtNHZGI
	nb9fM5XO6hjI73efoYaNNZNsoXZrqfv/jLl4XrPb1MG7sMKeSo2ov7Uq5RY0I+C1BrGtuDlsE0Y
	ZCtFs+pV8YovevHYNt4cKr0VM474LgQXbWnuuH9TWupTW8sFAD5IgFr5i5YaOdA==
X-Gm-Gg: ASbGncv9tRnZct1GLvkiocaXmNSSL+tYb819pknMkAkuLrPYL8UHKrKvD9tLkW3y7Qn
	i8Sg1MwnA/HamD+IMCtkx9yH6u83Jv1z14pG4KatLbHbF4x8+ur2ObEXmWRYPsh57O/fXmsa9g9
	rU/fF2zPsZmHAXHXUjGuQRIHA4FhgMt7pWiYh0gVkCB0I3z2c8HfBR+HWwpSrUt4mCFTfbtUGCI
	9YkjJ8yCVbX/HtaIcG8uRvpIwoYs0vQq6qb0j/yjaBY+xQr0PtbGFPrMMP5JCKlEHzlpJRGhCqg
	TNrpNdfwZp3dOanuvTfZeqr1rTrOe9J/
X-Received: by 2002:a05:600c:1c22:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-455f7ed2251mr109812115e9.1.1752560903492;
        Mon, 14 Jul 2025 23:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTxMXA6Nga+O7JNp1+JY5l+SoLtPNLGpK6hDkd5gu/u+c6TcVIx2N2jg4H0LoQJuHrnJIB9Q==
X-Received: by 2002:a05:600c:1c22:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-455f7ed2251mr109811855e9.1.1752560903057;
        Mon, 14 Jul 2025 23:28:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45614aeba29sm66298845e9.11.2025.07.14.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 23:28:22 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:28:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250715022111-mutt-send-email-mst@kernel.org>
References: <20250714022128-mutt-send-email-mst@kernel.org>
 <20250714211351.GA2418892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714211351.GA2418892@bhelgaas>

On Mon, Jul 14, 2025 at 04:13:51PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 14, 2025 at 02:26:19AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > > > At the moment, in case of a surprise removal, the regular remove
> > > > callback is invoked, exclusively.  This works well, because mostly, the
> > > > cleanup would be the same.
> > > > 
> > > > However, there's a race: imagine device removal was initiated by a user
> > > > action, such as driver unbind, and it in turn initiated some cleanup and
> > > > is now waiting for an interrupt from the device. If the device is now
> > > > surprise-removed, that never arrives and the remove callback hangs
> > > > forever.
> > > > 
> > > > For example, this was reported for virtio-blk:
> > > > 
> > > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > > 	   complete,
> > > > 
> > > > 	2. Now few requests are yet to complete, and surprise removal started.
> > > > 
> > > > 	At this point, virtio block driver will not get notified by the driver
> > > > 	core layer, because it is likely serializing remove() happening by
> > > > 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> > > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > > 	for requests completions to arrive which it never gets.  So
> > > > 	del_gendisk() gets stuck.
> > > > 
> > > > Drivers can artificially add timeouts to handle that, but it can be
> > > > flaky.
> > > > 
> > > > Instead, let's add a way for the driver to be notified about the
> > > > disconnect. It can then do any necessary cleanup, knowing that the
> > > > device is inactive.
> > > 
> > > This relies on somebody (typically pciehp, I guess) calling
> > > pci_dev_set_disconnected() when a surprise remove happens.
> > > 
> > > Do you think it would be practical for the driver's .remove() method
> > > to recognize that the device may stop responding at any point, even if
> > > no hotplug driver is present to call pci_dev_set_disconnected()?
> > > 
> > > Waiting forever for an interrupt seems kind of vulnerable in general.
> > > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > > forever for interrupts?  That doesn't seem artificial to me because
> > > it's just a fact of life that devices can disappear at arbitrary
> > > times.
> > > 
> > > It seems a little fragile to me to depend on some other part of the
> > > system to notice the surprise removal and tell you about it or
> > > schedule your work function.  I think it would be more robust for the
> > > driver to check directly, i.e., assume writes to the device may be
> > > lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
> > > never wait for an interrupt without a timeout.
> > 
> > virtio is ... kind of special, in that users already take it for
> > granted that having a device as long as they want to respond
> > still does not lead to errors and data loss.
> > 
> > Makes it a bit harder as our timeout would have to
> > check for presence and retry, we can't just fail as a
> > normal hardware device does.
> 
> Sorry, I don't know enough about virtio to follow what you said about 
> "having a device as long as they want to respond".
> 
> We started with a graceful remove.  That must mean the user no longer
> needs the device.

I'll try to clarify:

Indeed, the user will not submit new requests,
but users might also not know that there are some old requests
being in progress of being processed by the device.
The driver, currently, waits for that processsing to be complete.
Cancelling that with a reset on a timeout might be a regression,
unless the timeout is very long.

Hope this makes it clear.

> > And there's the overhead thing - poking at the device a lot
> > puts a high load on the host.
> 
> Checking for PCI_POSSIBLE_ERROR() doesn't touch the device.  If you
> did a config read already, and the result happened to be ~0, *then* we
> have the problem of figuring out whether the actual data from the
> device was ~0, or if the read failed and the Root Complex synthesized
> the ~0.  In many cases a driver knows that ~0 is not a possible
> register value.  Otherwise it might have to read another register that
> is known not to be ~0.
> 
> Bjorn

To clarify, virtio generally is designed to operate solely
by means of DMA and interrupt, completely avoiding any PCI
reads. This, due to PCI reads being very expensive in virtualized
scenarios.

The extra overhead I refer to is exactly initiating such a read
where there would not be one in normal operation.

-- 
MST


