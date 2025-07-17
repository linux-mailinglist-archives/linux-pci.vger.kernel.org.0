Return-Path: <linux-pci+bounces-32470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C89B09810
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B19189426B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7B26E165;
	Thu, 17 Jul 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXwmBhO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298C247284
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795126; cv=none; b=JwJ7b4kRIWDD3GcZNoDT28BoV1tycCFXMLN+dfBDqBDpzguv2qnIf0NN/pjwLAi3+ObyQ05d9GSIy+TiF2jXY2saLs5KBSy1KZuNsQRUq+8nwNYsAV8z4bIDvSI10Tf+vE4+L+c7H5SKh/7ZCZRRxiqA9vHTeOHghXF/F+fS8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795126; c=relaxed/simple;
	bh=uzxWS3lULfWWEQq2HQszI0g0C6y0xwg1naBkY2aPFXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcIePa2+aaew4z7rT8FithVP67hGNK7ZeNporNh4atU7qzIbRx1dYX8RDpsIzinBKG6QxYQmHS9fbTgJUCfnLJhHjCzRQqUFc/VbxrjRi0BxCRDe4i0CenC9ydKhf9ZqCeu1FmBeoHBOzjREcZVrHz26aB0IA3DLdLDDfFdV+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXwmBhO/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752795123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CpZT+Mzo2oQHVk3kzL8pLB1r2CdXyvoZE7LSvS2Rg/U=;
	b=gXwmBhO/LUmmXJl0fjOUsbcf++1bsL11mLid6AuIhL117ZLfVZSnwA/z8zmBwRKEfH6P+d
	KnJzoK7OtAyZRqZo7Sgrsg6Vtx0ZI7DFkm+yqTy5RmEnbrl4h26IAxFcz6TyEBcxkggnH8
	5LwhXkFKAFibUkp/ywrpjP7IVDpBIco=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UXnrLfzrMy6pnLGAiQFhzA-1; Thu, 17 Jul 2025 19:32:02 -0400
X-MC-Unique: UXnrLfzrMy6pnLGAiQFhzA-1
X-Mimecast-MFC-AGG-ID: UXnrLfzrMy6pnLGAiQFhzA_1752795121
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso1112711f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 16:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752795121; x=1753399921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpZT+Mzo2oQHVk3kzL8pLB1r2CdXyvoZE7LSvS2Rg/U=;
        b=Fkf1zPBAdsbHBZeIb+QV5SwtvSgrQM2laXUVtYJ/0Kp3ULwCb3GzboA5SUKWOR/Niq
         j3BPuYMd86QCXsI2KYld9ZxCZee8fKzNgyKbZH9Gq0ofy/cuni322oakgcO8Kwk0BijP
         VP7Wy9BcT4NGAPfQkHqsi7w4vdlh/uQGsIfKK5SiKPcc+79/VsUELiwMsAP3o5ArFAIV
         ccurNkAu8o26hTvOy4DOBh/xhGx7FWIzjRS/u+z+1i25ryUlO0S1UOMrNZtOmFsO/eij
         oWasz6UqFFQUMoHJ505gKZrSZgb0qeV6EuL6OH4gtuneIYmf+UQLX5Biph/j3bdtItNv
         0i0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRJWs2+u/rKOZEGxk4j+QPwtN9mRVBBX+4dzOAYwR7fMhuqEgGDnAEsaHiEfU1c8SvGYE5Yh6FMW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOZtwOZq7mBK0/aFiRFrwPHzPXLOCvgyTRxaLQXC0BOReCuwM
	Llb4g9GalJWKczNRTRw/YxiS3jAivX0/Kaj1QvuQwlEZb53E78bHrpe8P8oWBu6p77Du7lPT1DW
	AwH+h3HUIpoMlY41CN+bF8x66VFrF01w25dyxd1QGGHCjRvumnXnrSCh3UqYN/BNq98Bt1g==
X-Gm-Gg: ASbGncvCzAPjjmtz5YxWObc8ZYYXbQvIe19lE6FT01okC/L3mjfQi0yusPLZT8nCz5/
	h3zWUuzOk8kS1ymrEJbJcutn1C+d86QkXVaHZMeiGA4aBFWynqhAH4Rz34LH3pC2XmEIKesf0fw
	sxFSecNnjfh4i69gwrhc0S6L4req3DgDf7omqaFx2KvMS3A/1sUXaYzhVsURV+v4yq+AUAyX8WR
	3GSsCiRXvPWeTQV2ONU1B1HAfZhJVFJn4i7E3f4zcV047n3NM5f6ENN0O1bzBvr/boZ9/wcKSdc
	wTgdJNSlfcYDOXrjEFAAo3ezh8atHpOM
X-Received: by 2002:a5d:5d10:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b60dd0db62mr8300299f8f.0.1752795120805;
        Thu, 17 Jul 2025 16:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExuHiZKPsl7+fM4ddbkHTlANT8kdKZ8czJfqKssVMAXmY7AK0qAvc0j4x6/StlbI3vHNtqEw==
X-Received: by 2002:a5d:5d10:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b60dd0db62mr8300286f8f.0.1752795120388;
        Thu, 17 Jul 2025 16:32:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e81ccb4sm63884635e9.17.2025.07.17.16.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:31:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 19:31:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250717193122-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
 <aHlZE18kPuHuDtTT@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHlZE18kPuHuDtTT@wunner.de>

On Thu, Jul 17, 2025 at 10:12:03PM +0200, Lukas Wunner wrote:
> On Thu, Jul 17, 2025 at 11:11:44AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
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
> > > 
> > > For PCI devices in a hotplug slot, user space can initiate "safe removal"
> > > by writing "0" to the hotplug slot's "power" file in sysfs.
> > > 
> > > If the PCI device is yanked from the slot while safe removal is ongoing,
> > > there is likewise no way for the driver to know that the device is
> > > suddenly gone.  That's because pciehp_unconfigure_device() only calls
> > > pci_dev_set_disconnected() in the surprise removal case, not for
> > > safe removal.
> > > 
> > > The solution proposed here is thus not a complete one:  It may work
> > > if user space initiated *driver* removal, but not if it initiated *safe*
> > > removal of the entire device.  For virtio, that may be sufficient.
> > 
> > So just as an idea, something like this can work I guess?  I'm yet to
> > test this - wrote this on the go -
> 
> Don't bother, it won't work:
> 
> pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
> the IRQ thread.  During safe removal the IRQ thread is busy in
> pciehp_unconfigure_device() and waiting for the driver to unbind
> from devices being safe-removed.

Confused. I thought safe removal happens in the userspace thread
that wrote into sysfs?

> An IRQ thread is always single-threaded.  There's no second instance
> of the IRQ thread being run when another interrupt is signaled.
> Rather, the IRQ thread is re-run when it has finished.
> 
> In *theory* what would be possible is to plumb this into pciehp_isr().
> That's the hardirq handler.  This one will indeed be run when an
> interrupt comes in while the IRQ thread is running.  Normally the
> hardirq handler would just collect the events for later consumption
> by the IRQ thread.  The hardirq handler could *theoretically* mark
> devices gone while they're being safe-removed.
> 
> I'm saying "theoretically" because in reality I don't think this is
> a viable approach either:  pciehp_ist() contains code to *ignore*
> link or presence changes if they were caused by a Secondary Bus Reset
> or Downstream Port Containment.  In that case we do *not* want to mark
> devices disconnected because they're only *temporarily* inaccessible.
> This requires waiting for the SBR or DPC to conclude, which can take
> several seconds.  We can't wait in the hardirq handler.
> 
> So this cannot be solved with the current architecture of pciehp,
> at least not easily or in an elegant way.  Sorry!
> 
> Thanks,
> 
> Lukas


