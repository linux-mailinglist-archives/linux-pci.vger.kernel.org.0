Return-Path: <linux-pci+bounces-18566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3969F3A08
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CAA16C965
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8195207DE0;
	Mon, 16 Dec 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXoc+dKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FA126C08;
	Mon, 16 Dec 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378019; cv=none; b=c9VTUUtSKaIOn5XklaOdIGKLMHgoXi3FCUKwmN8H+lC/wgGvYmfyP0jXsjbY9omSbU8Owjcp2NfV+TvpY7SLEGgIFnrIEk3k92TmuVilfyfrHT4lJO7V0jIKlZoOKUP+dmP6i6RrSHlYj96zG4oLSgKuybUGVkg9hgW60QU/SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378019; c=relaxed/simple;
	bh=bHMzhAy1IqA4eeks9HYZpJvfcxQcCI7poEaASeIwuY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2jo4Y5S4IE9qEvoWZzSuzNikuQxlsuY2Q4smZTHQ6+DzNcbzbLOE2xPFd6KdVQ+QLKVBzFTQZe3Lly+dvRMu7DoMM4ZgaoRUAWBO7uMfVwmjCy7QpaG9BqXyh+4m3qToXJhMeMgnbCrisa0W8CzFgqU7KwnDTwdrsWq4YFDuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXoc+dKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C9C4CED0;
	Mon, 16 Dec 2024 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378018;
	bh=bHMzhAy1IqA4eeks9HYZpJvfcxQcCI7poEaASeIwuY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXoc+dKSlpo3UTAWWRouX61jRVj0PxLXUWnRoam7ozlVZ5R17Y1JQ4rR4AfeBYoo6
	 1oiGyjwg6kC1BL9TmFhVKwpL0OiNBkmeBunG8rTlaweDefMggbG8D+uKPXxkRNDWNA
	 iBsYpNWqAI0ks8LYZlimG4q504bafww0teNXPy221twj0JiszBtY8WGL6wCHELATjv
	 CgNQY2wogY9hZUt32p5ajTkQmjRnl+5U87OtQk3YxTypBodCBZNEmuTF5Zr7Xxpn5K
	 lW8ayJwK5iPE9nf/1W+J5hh7NnSRO6dIVl36HRlrIrPYQdsGFR3SHXHqSone3hU3uc
	 Gap5u1/nIbQUg==
Date: Mon, 16 Dec 2024 12:40:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>

On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> However, there is an additional concern that putting an NVMe device
> into D3cold every time during system suspend on Android might cause it
> to wear out more quickly.
> 
> Is there anything else?

I recall a previous reason for this behavior was because the resume
latency was significantly faster if we don't prepare the device for D3,
and the nvme protocol specific power states for some platforms was
sufficiently low enough. Apparently this choice hasn't been universally
optimal.

