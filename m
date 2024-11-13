Return-Path: <linux-pci+bounces-16695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707D9C7D57
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B026EB26ADA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55A207203;
	Wed, 13 Nov 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGSja/AJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A41DEFC7
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532291; cv=none; b=tJ2zVxMDHDwaM7r6kcJzi5o42LqAKx0vBX6+i0PFnxjj5Wia9dmaB4MrFTbNgEYtB3WFiE5Nu3Xwqxx/aF+KBk8AMjv0qbMAIGdC2xjl24qODbOZAQDl9Ehz1Zr53dx8STy/hmLeKphJRAB2Fm4odUZBy2nbMgILZOR8WPlgPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532291; c=relaxed/simple;
	bh=RQtVXr+sLaEk9udzqbyN0RJFZt5+ahvYG/tRLOp2QKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6qesIkG/F9bgkwv04DF3qNbS+QofJfCaDjv1I+V2zKqWA/q5lWRH1I344pG3QcZjqjZ9c9NQlzeXlSB8Je3s8ENE+bqqag0MjDjdLo3u1oOuJRD6I+kgueckWR+hsdMyiWF+U0/vNigER/S48xe8TEazqdaG4+Sd3XD8lralQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGSja/AJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731532288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19WqiZx5bXY2R+jht+rSBfkiigCwXnU+vnSwdvgIJwQ=;
	b=gGSja/AJZXKf/1oL/OvuPAR6/m3HlV/R57OWQfuuHI3BfQhCSTOwH1BPVqjPi0vZdq0Rwl
	6Ku7IwSbCykMSGTE39KqQdpxMz9S1GrGiMmgzdw5e5E+cHnrIH2zNzEwciPup1gKkXnKo8
	SrSd2oo1B7f5eK5Oc8eLY8QDxQiUYfk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-w7ghdLhBO7OG4gGgvWsc1Q-1; Wed, 13 Nov 2024 16:11:27 -0500
X-MC-Unique: w7ghdLhBO7OG4gGgvWsc1Q-1
X-Mimecast-MFC-AGG-ID: w7ghdLhBO7OG4gGgvWsc1Q
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab645ca84so42545339f.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 13:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731532286; x=1732137086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19WqiZx5bXY2R+jht+rSBfkiigCwXnU+vnSwdvgIJwQ=;
        b=KDvH/wieqtgZ8+QPMLY6xHl5rlcVSPoueMrviHjH+Qh3fmWMKtwTmuhrdNtXB5CliH
         H1GICi1b1wclmVsxfeWOtiWAQORaTsLP3ZY24x9I3QISS0Dg5EbxqQgKXEoU/ppAemgo
         YAbAG8CK+FpjMfNQET94VpGbpBrHoep5lJBuYZWTS2qlNoc9qZ6qumbDAANgXObjqqyY
         +h6a2fFrA7zKmOIeEDhRhiMRDU3RmFHFybJhgQ2CDJKDoyriS76XbfiaDejiIBu82Z1i
         e3T7InfbTeG+UczMjk/O7Sp2igi7+kO8czIuyY7+qq3kbKUVBk/9shUg1nVFCae25RAx
         4kHg==
X-Forwarded-Encrypted: i=1; AJvYcCXvklBOs6VGtR67dodcvX70nnonEht1IlvAOcc+y0f+a7s4uBb4XXwOX1lnnZU38K2eh/BMUbm8ZeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKL0zt11FIRXZXnW9S8yxzBFMDhVt0/37cQAS6JcTq6lUSQ1pv
	bkongGXknFmmFzDsn0LSL3V8qZVuZJzLIftPgXMA3IQnKznb0s/Bc8RqwxMPTKzIcwYYzKYYJ2K
	qXQCHLDK6S+Wm234CC9T/XOWAVUaHV7+aeh2hhyjjTCtdEHHTrHvhU3W/bw==
X-Received: by 2002:a05:6e02:194d:b0:3a6:c23b:5aa9 with SMTP id e9e14a558f8ab-3a6f1a58b22mr59857815ab.4.1731532286166;
        Wed, 13 Nov 2024 13:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcnNYHsvq3x3d625NCahmbJAqiMdAoQaQkPCDLvS9tewBxW1j7AU7rltZUYu0Dp25868Fj8g==
X-Received: by 2002:a05:6e02:194d:b0:3a6:c23b:5aa9 with SMTP id e9e14a558f8ab-3a6f1a58b22mr59857625ab.4.1731532285757;
        Wed, 13 Nov 2024 13:11:25 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f983826csm31967665ab.27.2024.11.13.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:11:25 -0800 (PST)
Date: Wed, 13 Nov 2024 14:11:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, tglx@linutronix.de, Robin Murphy
 <robin.murphy@arm.com>, maz@kernel.org, bhelgaas@google.com,
 leonro@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 dlemoal@kernel.org, kevin.tian@intel.com, smostafa@google.com,
 andriy.shevchenko@linux.intel.com, reinette.chatre@intel.com,
 eric.auger@redhat.com, ddutile@redhat.com, yebin10@huawei.com,
 brauner@kernel.org, apatel@ventanamicro.com,
 shivamurthy.shastri@linutronix.de, anna-maria@linutronix.de,
 nipun.gupta@amd.com, marek.vasut+renesas@mailbox.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFCv1 0/7] vfio: Allow userspace to specify the address
 for each MSI vector
Message-ID: <20241113141122.2518c55a.alex.williamson@redhat.com>
In-Reply-To: <20241113013430.GC35230@nvidia.com>
References: <cover.1731130093.git.nicolinc@nvidia.com>
	<a63e7c3b-ce96-47a5-b462-d5de3a2edb56@arm.com>
	<ZzPOsrbkmztWZ4U/@Asurada-Nvidia>
	<20241113013430.GC35230@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 21:34:30 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 12, 2024 at 01:54:58PM -0800, Nicolin Chen wrote:
> > On Mon, Nov 11, 2024 at 01:09:20PM +0000, Robin Murphy wrote:  
> > > On 2024-11-09 5:48 am, Nicolin Chen wrote:  
> > > > To solve this problem the VMM should capture the MSI IOVA allocated by the
> > > > guest kernel and relay it to the GIC driver in the host kernel, to program
> > > > the correct MSI IOVA. And this requires a new ioctl via VFIO.  
> > > 
> > > Once VFIO has that information from userspace, though, do we really need
> > > the whole complicated dance to push it right down into the irqchip layer
> > > just so it can be passed back up again? AFAICS
> > > vfio_msi_set_vector_signal() via VFIO_DEVICE_SET_IRQS already explicitly
> > > rewrites MSI-X vectors, so it seems like it should be pretty
> > > straightforward to override the message address in general at that
> > > level, without the lower layers having to be aware at all, no?  
> > 
> > Didn't see that clearly!! It works with a simple following override:
> > --------------------------------------------------------------------
> > @@ -497,6 +497,10 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >                 struct msi_msg msg;
> > 
> >                 get_cached_msi_msg(irq, &msg);
> > +               if (vdev->msi_iovas) {
> > +                       msg.address_lo = lower_32_bits(vdev->msi_iovas[vector]);
> > +                       msg.address_hi = upper_32_bits(vdev->msi_iovas[vector]);
> > +               }
> >                 pci_write_msi_msg(irq, &msg);
> >         }
> >  
> > --------------------------------------------------------------------
> > 
> > With that, I think we only need one VFIO change for this part :)  
> 
> Wow, is that really OK from a layering perspective? The comment is
> pretty clear on the intention that this is to resync the irq layer
> view of the device with the physical HW.
> 
> Editing the msi_msg while doing that resync smells bad.
> 
> Also, this is only doing MSI-X, we should include normal MSI as
> well. (it probably should have a resync too?)

This was added for a specific IBM HBA that clears the vector table
during a built-in self test, so it's possible the MSI table being in
config space never had the same issue, or we just haven't encountered
it.  I don't expect anything else actually requires this.

> I'd want Thomas/Marc/Alex to agree.. (please read the cover letter for
> context)

It seems suspect to me too.  In a sense it is still just synchronizing
the MSI address, but to a different address space.

Is it possible to do this with the existing write_msi_msg callback on
the msi descriptor?  For instance we could simply translate the msg
address and call pci_write_msi_msg() (while avoiding an infinite
recursion).  Or maybe there should be an xlate_msi_msg callback we can
register.  Or I suppose there might be a way to insert an irqchip that
does the translation on write.  Thanks,

Alex


