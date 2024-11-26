Return-Path: <linux-pci+bounces-17375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D69D9F4A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28358B25DBC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71511DFE06;
	Tue, 26 Nov 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tl7s4hcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30691DAC90
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660912; cv=none; b=OGLSRwOb3eYSZlBYphQtiabe+TzLShY1Ifh5LTdThT30qcL/xlarlzq3QITqtr2zcsXOZWoVubwTf5IDth8gZw42dI/ndDEEIGSQanTTnb0LfwJawn94wws5JB/7Eea3KhppYXPQbMkc3v+IfQmiAmmnPM6DspPAsYWg3GAeCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660912; c=relaxed/simple;
	bh=b7lCrDz13ILNM08LfCgzVYD9C9TH4sUkUGJSvBRHy9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RihdHG12ljPelB/ayVE8p4tL6LBEELzrd5As2DbIQW05scnr7NbIC3xdBjSRpzncZF8rhGDCuLO+YLj5BjWLFGgTAasefs4uGlLddTesfxjK6z7SRrd6djz8KtZ4aAczcWLit9LxHWcRp05PGNFZ13E9x072nrR5M5spqPa2IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tl7s4hcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732660909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjzLuFCAYERs3f8o3lK5yADWmxgixrnHXJ2IfNHbUqo=;
	b=Tl7s4hcKTCscNVwswKqdsKukeJ09sxMa6PI/mrj64TUVqlkeHz673QgAnREtcBoQITYvn+
	NgYMGtIfAu/iK3N9a+mbzC2YcqYr8IAeNxLAdHMQwuixuLvT3LGR+6I2tj3I29VievNg/C
	P2flu0V7iZxcgX3Fqr3K/286TxlFA3g=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-rs8XHlldOMyufJaXehBxOQ-1; Tue, 26 Nov 2024 17:41:47 -0500
X-MC-Unique: rs8XHlldOMyufJaXehBxOQ-1
X-Mimecast-MFC-AGG-ID: rs8XHlldOMyufJaXehBxOQ
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841a99e342fso29235939f.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 14:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660907; x=1733265707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjzLuFCAYERs3f8o3lK5yADWmxgixrnHXJ2IfNHbUqo=;
        b=oBHxjMjGboTKzpZuGs+1iobFJ3nKrkpY7+64nRw5RQR+s97aSVVn1VyrGbJWKYE1MD
         7UdF0kxftGEy88f65WElnTEMVv/kJgx+cNJx53L2Rnl+6NpWvYRwxdhwYYM1aBduh02H
         IfIPe8V0ropZ58321xtRpzqykPzO4KujwQPpNVrPr+21GaQ3vrpk+lNAozqkKBbr+fLX
         hhV/Bh9Yy7uIid0jNbqM/mrP4CQuGqxqqVdmqxBkl9Y6xpBD4qMdo+DA783STFNN+klI
         +2QSx2UexYajf9dd5joVwTlU5ZGEu7mGXCHOo/iW+mc8+mS7mcBbVhRgjhJ+KP9PM1y8
         FkKA==
X-Gm-Message-State: AOJu0YzwjO9mvL12bCF0Y0Utph3gd5MgkM5QfE3IM8NPW+y/w+8j16Wp
	+XOeKemf2F2/Nipj4JkDN/ffF/08uSx5Boa8hnYdfPQGWTXqFqx+k0cJPPS7ytzysycvby/HPCp
	xavSho+4Nnm1sArcQVWYtq/jOmZlKAcUMr6rN42tRZdT5JUDJJPGQLu90Xw==
X-Gm-Gg: ASbGncuMUpD/2JRV+JmqNPphB3OcFJoBjrAmS5oVoaYyjfUcgahbJasWSbrxDZC7rGq
	z12j56yAao6tdQN/xqg0+jShrx3QFXN5CS18yKv5K0U80ZdsuGW6DPmjaVX4wsj9/FQk9MSIW+w
	drsTz92Lz2aU9dthkYqd+rhYvhvQPhPqxhV5BUzisYhy+zgDLw42pR+hkzeAtyFq2SWRvw1txjZ
	SHMJgt6MlOqkSx7Fi7Xasxg0p/pod9ZUhsPTekbPd36fEmfG+EoSg==
X-Received: by 2002:a05:6602:150b:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-843ed0d8d35mr38815739f.4.1732660907263;
        Tue, 26 Nov 2024 14:41:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ7nxJJRG17OVR38I1h6QIFaT5CqYN0QEozIVMyIIuB4frEnlsLeSFJmypcdPsDIcw6V5jhg==
X-Received: by 2002:a05:6602:150b:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-843ed0d8d35mr38815139f.4.1732660906981;
        Tue, 26 Nov 2024 14:41:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1fcb97e1fsm1518271173.102.2024.11.26.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:41:46 -0800 (PST)
Date: Tue, 26 Nov 2024 15:41:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241126154145.638dba46.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 16:18:26 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> > The BAR space is walked, faulted, and mapped.  I'm sure you're at
> > least experiencing scaling issues of that with 128GB BARs.  
> 
> The part that is strange to me is that I don't see the initialization
> slowdown at all when the GPUs are hotplugged after boot completes.
> Isn't what you describe here also happening during the hotplugging
> process, or is it different in some way?

The only thing that comes to mind would be if you're using a vIOMMU and
it's configured in non-passthrough mode so the BARs aren't added to the
DMA address space after the vIOMMU is enabled during boot.  But your
virt-install command doesn't show a vIOMMU configuration for the VM.

If the slowness is confined to the guest kernel boot, can you share the
log of that boot with timestamps?  Thanks,

Alex


