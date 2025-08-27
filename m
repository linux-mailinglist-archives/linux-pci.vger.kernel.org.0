Return-Path: <linux-pci+bounces-34911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8690B37FF1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7026D3B9BD1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781527605A;
	Wed, 27 Aug 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOnMdSV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90F72610;
	Wed, 27 Aug 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290817; cv=none; b=BLv3Mf8q8QEJfm2ghtuhRMIK5iQRnegFoHuFBzFElw2vHQ9/uNmski4YDAoiEuh5mEGj/Sl0U5nDZlHLYmrki7m3Gnzbr6v1fKvGRN8jlFrjSmj6EfFx2Z4L1iVC7pE9FWXSxm45YJG+ZgT4BOwb1bPCb2ZMwwqzDt4f51DcMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290817; c=relaxed/simple;
	bh=9QsnH71YbkSyX/7fRAS+Fy/72P1UW6IJD9KrB9U0euc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+zBHTI9ua3bYZMuMpKcxOURlf+JTsK8ybxBngEdoO4rs1P2H0ueWO+XWs9Tqmp+4EDzIzwoYWbaO0a08SkMG7IZKPBZFCati2kAjV70OPBToxdpc6EQNFdkTRKEOw1NIaz2vQHNi+twz7WBX2zV/t3FYFtR16YPaGV39IKxNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOnMdSV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD46C4CEEB;
	Wed, 27 Aug 2025 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756290816;
	bh=9QsnH71YbkSyX/7fRAS+Fy/72P1UW6IJD9KrB9U0euc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOnMdSV3araDsoInT7APCgqwtFtYPjVxUS2hKgZDZGdHyWpqpXLV76YSCGzK6kEZ0
	 FjDmGzfiIkOelOs/qHpOJeytAxYVP+ddMm29P1nQVNwV+CAODnwR5Q8z1cHDPVhEss
	 Wozpklupd8uTwA2VB9wX3QzHlpyzfUEJed0dA3RmC2MevNGOAknS9s31L+MOFmnZi6
	 xBwEeodGCPPXYGHJiu1gl6BIXpcrEmJUpjM79xdS+tlg9QG+qkEqzZB8NMGZLUKi9k
	 5wDeAi6VSdo15cqHrRqpg45+1uylaLt6PifnEGQHyyJlsqLbpWv9fd7j+vX6PSJtT6
	 yyRb0l98iiKbw==
Date: Wed, 27 Aug 2025 11:33:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>, regressions@lists.linux.dev,
	linux-next@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de,
	dan.carpenter@linaro.org, naresh.kamboju@linaro.org,
	benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <91a9db15-8e3c-4b49-a34f-61e043040de9@sirena.org.uk>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
 <20250826220959.GA4119563@ax162>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X6vJ3MJZfuQb9wf/"
Content-Disposition: inline
In-Reply-To: <20250826220959.GA4119563@ax162>
X-Cookie: Keep out of the sunlight.


--X6vJ3MJZfuQb9wf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2025 at 03:09:59PM -0700, Nathan Chancellor wrote:
> On Tue, Aug 26, 2025 at 09:45:48PM +0200, Anders Roxell wrote:

> > <5>[    1.527859] virtio_blk virtio0: [vda] 5397504 512-byte logical
> > blocks (2.76 GB/2.57 GiB)
> > <4>[   29.761219] sched: DL replenish lagged too much
> > [here it hangs]

> FWIW, I am also seeing this on real arm64 hardware (an LX2160A board and
> an Ampere Altra one) but with my NVMe drives failing to be recognized.
> In somewhat ironic fashion, I am seeing the message from cover letter
> repeating.

>   nvme nvme0: I/O tag 8 (1008) QID 0 timeout, completion polled
>   [  125.810062] dracut-initqueue[640]: Timed out while waiting for udev queue to empty.
>   nvme nvme0: I/O tag 9 (1009) QID 0 timeout, completion polled

> I am happy to test patches or provide information.

Same here, it's breaking at least Orion O6.

--X6vJ3MJZfuQb9wf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiu3vgACgkQJNaLcl1U
h9CdeAf402KdhbaIwGLMVW/ZufuvG6tLwjEE10wBQg5laZZvUvnIyvGFbVKu7435
ZNGuRRz+vrtWUELyalj8weCiMypGRn/0cwcQMNwqRojfxNP0H7bX4sbnbJ2p+XlL
URDc8VRdIm5T7i4OuF+hd3vb3Bz4DCmLf2mnGS0FXKmq1LKywbufDgNqFLAO5QT3
X5aa8E2n5SvTMUI600g6dAc/t2qBEiwaHoj/qsME/i2LpqddFZnziad+OKQlroOa
3Ib4vOfVAKoX19X8FhiEubukWrpA14cQgM3QHz/53sM67fl+nizB+Va4+MopqxXc
KfuEuADsssk2u1Hu2+lDnBvZBKV2
=FiXm
-----END PGP SIGNATURE-----

--X6vJ3MJZfuQb9wf/--

