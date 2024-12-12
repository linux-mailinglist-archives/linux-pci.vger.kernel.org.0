Return-Path: <linux-pci+bounces-18279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E399EE68E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04901164E96
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1668212D89;
	Thu, 12 Dec 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="X08qOiSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838D158DB1;
	Thu, 12 Dec 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006115; cv=none; b=c7cC9oVcNUgAZWPBYmLC1VyvQ5NBU2dfH8t8GNXAqMp1cCbaM9RRCVBBb1YJEZ9uITOoKce9w6xqD3Dp5jVTIaSwl8CyskTdyunQ2IoiiqgRcUYW8/z+dzjqRciVQIp2lhH54qS311PAEyn1xrFGkgw4+VmmXv+uy5rMrQTjphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006115; c=relaxed/simple;
	bh=kWUPjvQaoxNBzOTT4VbNlf0Zq+E3gREB48uYjM0Jcyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldIfz69cO77JHRedD/JRv8KjRnVJKgWRrmYlKeNXun4uM30utbaGLac24grabrt9yQ6WNVB/ayhw20xyEUfabKnWZvw2TJ/gbZnXRtEJHlm+wz8uVbYJ9DsQFrVpr6dT2Hmmx/vdZS7586R/JPWP6IBoiMd4HKu6ZuaHYVoIexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=X08qOiSZ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9bd38cac647772b5; Thu, 12 Dec 2024 13:21:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BBC377F5D85;
	Thu, 12 Dec 2024 13:21:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1734006111;
	bh=kWUPjvQaoxNBzOTT4VbNlf0Zq+E3gREB48uYjM0Jcyc=;
	h=From:Subject:Date;
	b=X08qOiSZDhFsu40YznaIwmRogZC0ucTkN/P6t6t7Oni4/pxdDDc6cvKFulHy/qPED
	 6FNFLl2A9hywmOBg5RyN4qSSA1maGKhSCdB/LoiYVaEhNW2tXx2EfupwCFJypliYe6
	 3ypuD9fMQ5dr97faASrG95dzZEj1e6foEMTRoGRGlB7AXIJUcJrg2g4SunoR2ggsda
	 PEjHm+c7/mkD3JwjjAqCV3+liaoQ7R60dgG0iDwK0T0APd3+UtdS8dmEr6Cvg5rNF1
	 DbTwbUnSw7iiF5Ju8ayK6U2peHwGvRebBjwUq6HG4QDSZqyluTFTtKCVkJdgW4dL5Z
	 UROxHiBKNw6cw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
Date: Thu, 12 Dec 2024 13:21:50 +0100
Message-ID: <13662231.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <20241212055920.GB4825@lst.de>
References:
 <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

On Thursday, December 12, 2024 6:59:20 AM CET Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > The istory here is the the NVMe internal power states are significantly
> > > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > > creates a lot of extra erase cycles and reduces life time.  It also
> > > prevents the SSD from performing maintainance operations while the host
> > > system is idle, which is the perfect time for them.  But the idea of
> > > putting all periphals into D3 is gaining a lot of ground because it
> > > makes the platform vendors life a lot simpler at the cost of others.
> > 
> > No, I disagree with the last comment. When the system goes to low power mode
> > (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> > D3Cold to save power.
> 
> Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
> supposed to catch.

pm_suspend_via_firmware() is to distinguish different flavors of system
suspend.

For runtime-suspend, there are different callbacks, but it doesn't look
like they are used by NVMe.  At least nvme_dev_pm_ops doesn't set them.




