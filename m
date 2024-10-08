Return-Path: <linux-pci+bounces-13995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7935D995059
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224A01F20620
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9B1DF25A;
	Tue,  8 Oct 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTfg6/sX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FF1DF25E;
	Tue,  8 Oct 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394801; cv=none; b=hcO5qD+G6vKZDu14q0bObmf3mZE0YT1KVtE5hTe7iqEPMtw3utjzKCwfrCrmD1ao2WaGIlzC3SVrznWCt/PPg42pWLrxVC8qpSLHtBrwpJ4QpvFTcYzpKRtOo6kanhvvyG6E5TZj2hY6x0eey/rvdn3Rfo7983zoYA2Mht2qNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394801; c=relaxed/simple;
	bh=F9YQQkqbHNcwgfVQyUpy1C+NloEUAj4v8A/JWR2xuAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPClkI8/QiADLeDo2boaTEIMlIuFJDrUhenEY9nvMkzrkF9d80h4VI9LgwIEY0zUp13OIWugq3Ox7ppo+BEuMlgWF2yacWjQVbXRJqznMuav+mAScOJhmy0ZaB1j0hUmCIVj8TbNoV7ml6HaWqqY/Wv2KA1R7vUmRbOOvSeci9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTfg6/sX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011BCC4CEC7;
	Tue,  8 Oct 2024 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394800;
	bh=F9YQQkqbHNcwgfVQyUpy1C+NloEUAj4v8A/JWR2xuAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTfg6/sXBD2y1/18g0sEw3yDVNToVFwRuusLRBZv9aXHBImEJjaM6Cd/BPRl9gmsA
	 35GW6M/leNtyGkoSrdIe0zlEOkxmpAzAMjcQ7/YZkmV82t95PB8DnQkHNaR+zCvcqV
	 oMrEDVox5Dd5TC8HpyE4G4VedvR1pWSXXa757E3rtcaCVJemUmbgiHDPMoG5McdXNN
	 GylOOLKwBC/K9pwi4y2jFy98P5TZdqc9bCWpU5jcmYQRDbWzDCnnuyrlCMUnjJq9ra
	 tv+QqtlubIOQRLJGg+0iFarx3erQ7CJe6iWJgsw0g3oukGcvmBFoKdbGyvqZHGOYMq
	 a0rStKiCSPbvg==
Date: Tue, 8 Oct 2024 06:39:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
 <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <alex.williamson@redhat.com>, <gospo@broadcom.com>,
 <michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
 <somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
 <manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>,
 <vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
 <bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
 <jing2.liu@intel.com>
Subject: Re: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20241008063959.0b073aab@kernel.org>
In-Reply-To: <20241002165954.128085-5-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
	<20241002165954.128085-5-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 11:59:53 -0500 Wei Huang wrote:
> +	if (netif_running(irq->bp->dev)) {
> +		rtnl_lock();
> +		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
> +		if (err)
> +			netdev_err(irq->bp->dev,
> +				   "rx queue restart failed: err=%d\n", err);
> +		rtnl_unlock();
> +	}
> +}
> +
> +static void __bnxt_irq_affinity_release(struct kref __always_unused *ref)
> +{
> +}

An empty release function is always a red flag.
How is the reference counting used here?
Is irq_set_affinity_notifier() not synchronous?
Otherwise the rtnl_lock() should probably cover the running check.

