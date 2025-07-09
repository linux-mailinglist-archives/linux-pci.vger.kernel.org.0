Return-Path: <linux-pci+bounces-31826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53EAFF583
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 01:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7193F4A7F04
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 23:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9371237A3B;
	Wed,  9 Jul 2025 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpgH1djA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF62801;
	Wed,  9 Jul 2025 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105320; cv=none; b=TIS1HhYtoE91EsFAxw4fIvrkuaqBGp4nnNaj49+8ropj7y4vENHxGUioffFqDv4t5GDYrDLoMMl1r8KUaWFLFpb0vhvctyrUIk17/lt1w36eb9m1SMDjOKe/nNPSfzeTdsaF2D0g7Gog+9NNjGCi4Ls3Q/mDeJJo4JTUyrjSrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105320; c=relaxed/simple;
	bh=Tg/uaUSbdhhsjN8ABejUuKaFMtIV+RRGPTHEHVkkBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thx0GUtWNPT0sspWqp6nKSNazfE/sVgR38DqJuJz6tqMLk73RISrsZfY7MFsYWGWtNQpqip0Pn2A3p4RDpAaXSJCY/JBdoOCh6aCJHW8YzGiURVaoNwhdjRSCsfqwtksoXinYojkJzxJq9sEXk5xEysaNWKrlfivwdHA7oFQX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpgH1djA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A5C4CEEF;
	Wed,  9 Jul 2025 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752105319;
	bh=Tg/uaUSbdhhsjN8ABejUuKaFMtIV+RRGPTHEHVkkBcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpgH1djAzaHEkHohw7OchdX2XAma7Y8j3n4PHtCL6gJvqyYOLJaSfVXBaLG/7kgXk
	 HZOms9QJkhLeK2uNOk4RGktI7nVe6djTkMwI9t1Xl+YJct8cgsiDnufHqB535XjVEB
	 JEdV8wkgJsjWmEuVwYhWGliy43AMPLXzsb0hRd2CDfhLuMF9JWpe8FJwiGkMG/BB2A
	 pS43u9EPMPii/sRVmOhPuMZ0ESEEAxXBOOP7M2ewpLf60u/QLJH7BEdPc6klyFW/VR
	 NSl7qmFbw4MPyy1Ye+lShaPP9WLK6kZz6Jf8XmORzfaQCga5df8euyHlp07qeOWT2q
	 gnHuYroau22Xw==
Date: Wed, 9 Jul 2025 17:55:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <aG8BZcQZlbNsnrzt@kbusch-mbp>
References: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <20250709233820.GA2212185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709233820.GA2212185@bhelgaas>

On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> This relies on somebody (typically pciehp, I guess) calling
> pci_dev_set_disconnected() when a surprise remove happens.
> 
> Do you think it would be practical for the driver's .remove() method
> to recognize that the device may stop responding at any point, even if
> no hotplug driver is present to call pci_dev_set_disconnected()?
> 
> Waiting forever for an interrupt seems kind of vulnerable in general.
> Maybe "artificially adding timeouts" is alluding to *not* waiting
> forever for interrupts?  That doesn't seem artificial to me because
> it's just a fact of life that devices can disappear at arbitrary
> times.

I totally agree here. Every driver's .remove() should be able to
guarantee forward progress some way. I put some work in blk-mq and nvme
to ensure that happens for those devices at least.

That "forward progress" can come slow though, maybe minutes, so we do
have opprotunisitic short cuts sprinkled about the driver. There are
still gaps when waiting for interrupt driven IO that need the longer
timeouts to trigger. It'd be cool if there was a mechansim to kick in
quicker, but this is still an uncommon exceptional condition, right?

