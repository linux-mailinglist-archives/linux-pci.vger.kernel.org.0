Return-Path: <linux-pci+bounces-32039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD9B036BF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B5A166F30
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0D2E3707;
	Mon, 14 Jul 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3m9PEl5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA82E3706
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473861; cv=none; b=ctX3GMTOrjpcr2Eccm798sK3KLFimpaZscfXguSTjJEcgb/sMPRvHueuWlejegtts4+cQgRQkfHGLcJvEc9krRXVcHsZGumNWOpcA1Bwt/NkcjScoP7hRMsuVMYJWrVCXr/kgi5qVUfSoLdHm/ar0pL9RAxol9k2E4B3lZYHQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473861; c=relaxed/simple;
	bh=VBy6PDnHPih2lBK2ZZwSq9hR6E2HRl5WrI7AEF/MP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUY0Gx2DMC0lSWAiUMpp0Y5czpffDP0WfWrnM5vG6EL7dk6ynp0p0Lc7mofbD/vkwGr37qRKrITPusfYY7ZUrF39F7lTb8VidbjbENVNDdZNC8K3oGUX5yS5XNOpIGfXzT9cgOzeQm0q1XX6HI+AHiILHgJbGBP2UWcsY9Y7Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3m9PEl5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752473858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
	b=c3m9PEl5/H6hdiepI+PiE+00OgQa3uGpZbxi/eYyvA0I3JT73oY6ZVE6xS009gkiU+/7DL
	YYYNK2FZxlW1Ml/HLqNXyQpaS95JxAZNKmAAI7X2vQtdyvZn/Jz5ettDMBnbl28Iuiy0gZ
	ZhNqDstITyccn86EHrvkSrSIPUSxrY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-htE5pk-hPamQJ2L_SJ0X8Q-1; Mon, 14 Jul 2025 02:17:36 -0400
X-MC-Unique: htE5pk-hPamQJ2L_SJ0X8Q-1
X-Mimecast-MFC-AGG-ID: htE5pk-hPamQJ2L_SJ0X8Q_1752473855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso25018945e9.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 23:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473855; x=1753078655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
        b=nAjOYKLkRMv0OeKE357otZ2KIk0VXvayl9CLzuy+zU0fw4i4Y3VCJQn4+ivcrqeUmK
         UT7cGP1NJzSfj+gbqG+Dn/DVUBcXte9sMkV/X/1+GoXobZKnPAbmYsZN9P0A0QzxiM3e
         23XfZL99/FVMxThUQzmO0KlIx5fBfwvlcagPbg6X14YHMIANBnuDEl45Lxbt72rnE8CP
         OLkOhFls+fmY8hEszjtRGREShpnzupfh7/kppQqgljrukrJuGGQ5qWjOQtYaqqEPxbpQ
         t8VqkHnrZo/ptdVBZEwyZjX+SMpb6NkvhM13C5HpY24GLVZGm2mVVc8VOsNXUHnnCZMC
         YWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWbVpWt00+XKq0DJb+GPFOxhn8a6eEvXMr8Lw8/vtb9VX9XBtvszcGS/IrpH5G8uFcmRnGxkMXss2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kB3gv5bZy61AMDw87so1fG8eOySyIF1bQ2zH66XKLvbdxL7m
	pSiWH01eu3Ehd8Yn3Xv6F9iXS22B+yGl077qES+9/p4QAwsnVBodZ2VVVVPXpZkcssodmu+fjhQ
	PWxVJpx0+IFKQq8+qUTjFUSL0oc9sDdB7Ai0dtiF5+Selu73mph3iK+oU4G73Og==
X-Gm-Gg: ASbGnctcid+zVVO4XAglEwbQPluP38CwQpY4ZH8oGobB44Tj2A/IjEXjEgRFNy/rwC8
	KLKF5L0Cw72Q5MPTLECRyBA9CPLbAuphsbw1Ka8Hn+c1fRxciEZOnDyAkQbaZoTcVpnPCp8qViE
	gqvjG9hoBY4IKrqb3U/aOBJ1E7vBdSbQJsC3VhSuv7rw33cagAn3z30qy3vvJPeSbv1lIxLsxlA
	zak15CRwCGIPoS7FFr9kHj/bzVXD3Rq2m0QCZ9xTK5wz7wy9TcZ3IHhLAl1rzXuuIAUea8XE5cN
	jiTNbbOkqcHxe6JStnpISYtFEARVMzcK
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020565e9.25.1752473854997;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCJSWHskQAdK6/40s2GNLhe1adxKFpy3e1bkD6X5SdYIshLCkbO2SV3+P2shMcWDz9uD6pg==
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020205e9.25.1752473854492;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm162665575e9.6.2025.07.13.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714021713-mutt-send-email-mst@kernel.org>
References: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <20250709233820.GA2212185@bhelgaas>
 <aG8BZcQZlbNsnrzt@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG8BZcQZlbNsnrzt@kbusch-mbp>

On Wed, Jul 09, 2025 at 05:55:17PM -0600, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > This relies on somebody (typically pciehp, I guess) calling
> > pci_dev_set_disconnected() when a surprise remove happens.
> > 
> > Do you think it would be practical for the driver's .remove() method
> > to recognize that the device may stop responding at any point, even if
> > no hotplug driver is present to call pci_dev_set_disconnected()?
> > 
> > Waiting forever for an interrupt seems kind of vulnerable in general.
> > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > forever for interrupts?  That doesn't seem artificial to me because
> > it's just a fact of life that devices can disappear at arbitrary
> > times.
> 
> I totally agree here. Every driver's .remove() should be able to
> guarantee forward progress some way. I put some work in blk-mq and nvme
> to ensure that happens for those devices at least.
> 
> That "forward progress" can come slow though, maybe minutes, so we do
> have opprotunisitic short cuts sprinkled about the driver. There are
> still gaps when waiting for interrupt driven IO that need the longer
> timeouts to trigger. It'd be cool if there was a mechansim to kick in
> quicker, but this is still an uncommon exceptional condition, right?

It's uncommon, yes.

-- 
MST


