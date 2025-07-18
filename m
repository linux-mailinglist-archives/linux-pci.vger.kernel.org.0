Return-Path: <linux-pci+bounces-32514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD07B09E34
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD08B163F5A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCA29345E;
	Fri, 18 Jul 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXHqICwx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D27AD21
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828032; cv=none; b=ik8sWo1Qkqh8B0kNJyp8m3LegeVObtATq15ehelLYohJKDEO/HVZLsxb8V3VEOPjzUgvPzbM18RVaGQn3sdpxRtVoc79xNIzHgmhzBSNPn8JwGR9uKiv27hjp9icyO1+OPzKpEaC5omZaaSudIc4XnFURl6DiZm6UB3O5gSfv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828032; c=relaxed/simple;
	bh=d/cITLBHlMU6TAxUTNaIP7pa1O0kFJWp8UkvhASv7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COqiJvwZimKVdlZ+MftHDDruPppJbYJAfbjT9DyKm9Q9TaMXrr9ZJCWi/JR/2R7uJy8FgT2a82WUKs1U4C/IHdQzjXdbCrJFMCzMe2F1XSyPVAOlK8k33celpnh4jWjrDv/DW3LutxwWprwe3nlOWn/1dxtayJyt9SK/FLBNJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXHqICwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
	b=HXHqICwxi26lEexVsaR4U9e9udGaNGU2w3SODjSWoXLGVgYpS0+G6m4YA1RX/EHoRNlNn9
	mneJyg4fmQBnz6YaMk+St+t1QKAg0WmnMnP/knS6eM66m6GM9O9sbTgSIdkSxhqektAwkh
	Zi+Kp3+OS7zu8FTI5Oit1M1Fm/oQ6qw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-F2AQDUqNNaKhZAf0i_2OEw-1; Fri, 18 Jul 2025 04:40:27 -0400
X-MC-Unique: F2AQDUqNNaKhZAf0i_2OEw-1
X-Mimecast-MFC-AGG-ID: F2AQDUqNNaKhZAf0i_2OEw_1752828027
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so1011447f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 01:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828026; x=1753432826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
        b=KzzV6Z8sbzGeLsSGpEqC35mq0fGj0AmRVSa3ioFHpQylj5aVXyOS2nsLJ2OX7uUdaQ
         CeFvtn70eP1tbHFVA3IQ77Pu83mm//X91ZJux6n8D9jM/IySn+zDGWOdL7otewwlMGrN
         1Y+krlqU68w2AXJ4r/e8EO5tWHCq+lxs2Krs1Be5QegWU9UlNaA8ze7jF41jMmqv5LX+
         2JSPsgTcDeQg6bWoX4jIcYoHe/i6h0DSuSONO/kcI0VVkXZkLwUPLw4aw1OrnNenReRA
         7lVcZxdPVaFXeBb61RPiqAMKeLPyukTgghguJI+PdgqLDPsNksDWrMnxV8YbTiVJ1IbM
         ALXg==
X-Forwarded-Encrypted: i=1; AJvYcCWHEFkjR86YI1U0i9REzlRI6mczXL6NhXrM5rXtueaY2Y1DcAANs9YdF9zxEHMx5d7WW+eKuQlr/ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPc/AHki5+5wXyMEYPXxisC3CxTcBkV/wyAd4U67JDFqAzlEI8
	81P57XuS3/owT+Y1m6Tn7blZ3htZyFNkVaN+SfHzziYZW/slmsp2khDEHdSuIbLISGJ8RROzggS
	Qnxep+NBFW5a9ap76V78P/qWt6sKhE61IR8BBz4afoNOfT0v6A1WqLavWW6N1QQ==
X-Gm-Gg: ASbGncvEM1joDQ4yTYIWyEv8IIW53gq0A478oOfg8A7h4lvDWUWjCIuJTvn9PtSHjmq
	koc3dlBbMHGieeSF+XAYVZQUOA1lepokanoWUPf7N6SNGASjnxpNGx/Wo1AflPMbvySNaDEYHZc
	NXo9nB1/SBu1o9zDDZNlc/GvZ2OUZDBxJ+8T903K+QZbpRoLrAFLH5IQ0C5TiqEoaZtjrX5gX+P
	b33aEvwaHnjXcTcraCntvvOYBJEi8bRhidwCcCvQ5YBUXApc5SDKxTwX6xgWG3KrEVED0+0kQua
	xgN/58EYpwbdrNNgVd3TkmrULkrFkQ6U
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511858f8f.5.1752828026481;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBvIibZpxmEevMb7PnR+yqkZwG63DgOrUJ7WvDQrH3ySphvekTPCQWQL3DTfQJNDfF22bDw==
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511830f8f.5.1752828026104;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d475sm1164451f8f.65.2025.07.18.01.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:40:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250718044006-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
 <aHlZE18kPuHuDtTT@wunner.de>
 <20250717193122-mutt-send-email-mst@kernel.org>
 <aHnPLIe-0ScYDfej@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHnPLIe-0ScYDfej@wunner.de>

On Fri, Jul 18, 2025 at 06:35:56AM +0200, Lukas Wunner wrote:
> On Thu, Jul 17, 2025 at 07:31:57PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 17, 2025 at 10:12:03PM +0200, Lukas Wunner wrote:
> > > pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
> > > the IRQ thread.  During safe removal the IRQ thread is busy in
> > > pciehp_unconfigure_device() and waiting for the driver to unbind
> > > from devices being safe-removed.
> > 
> > Confused. I thought safe removal happens in the userspace thread
> > that wrote into sysfs?
> 
> No, the userspace thread synthesizes a DISABLE_SLOT event,
> calls irq_wake_thread(), then waits for the IRQ thread to
> finish handling that event.  See pciehp_sysfs_disable_slot().
> 
> Until 2018 we indeed brought down the slot in the userspace
> thread, but that required locking between the workqueue fed
> by the interrupt handler on the one hand and the userspace
> thread on the other hand.  It was difficult to reason about
> the code.
> 
> We had bug reports about slots flapping the link or presence
> bits on slot bringdown that we could easily address by handling
> everything in the IRQ thread, see 3943af9d01e9.  The same was
> reported for slot bringup and addressed by 6c35a1ac3da6.
> 
> This wouldn't have been possible with the architecture prior
> to 2018, at least not this easily.
> 
> Thanks,
> 
> Lukas

Got it, thanks!

-- 
MST


