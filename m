Return-Path: <linux-pci+bounces-31768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04EEAFE901
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEFD1C4737A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5228FA87;
	Wed,  9 Jul 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRo2ZBkn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82335962;
	Wed,  9 Jul 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064376; cv=none; b=SX1d4MI2kdlyLTYGO0BkXquJKUyfkyqSoDcHZpyJ721Pg82e334hX77CCt5EhtXogeMArLS8b57eHF+HpN/R8Qx4CLB2Gz/i2Uqf6wtH3ESYQl3QdOvjk9QpaabzVYC8+75EvIDyAXsF7VCQ3gTNJzD34chtmbgWZj2Jr+4rlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064376; c=relaxed/simple;
	bh=k7oBzbUjKiMJ0Q6br+E4o5sLW0SuJMJPvvMOS+TTwB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppWWA0JoQL0U7OqKkeloC2eQUTWR7FuGtypOSkpzWfuVpJX++p67hRJ+WHV9wVY4GrIShqt3x1gSEQv34PWgWVmg8yADaFWAHqU86ICGXVSIQhP0jMz/Aidvs0Hn052TKp/UHKY9/igAd35bMTCq0CFz/t/D9LZxRuiWe/vGnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRo2ZBkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6DCC4CEF4;
	Wed,  9 Jul 2025 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752064375;
	bh=k7oBzbUjKiMJ0Q6br+E4o5sLW0SuJMJPvvMOS+TTwB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRo2ZBknsQXEL2PqhpkMfov9GoHoVLEFK+mGaAD/zykvYjQoxAFBbWBESB7gT+Afe
	 4vJlGVe6oDN8cTQoK6+nMdRNbw4zpfcOKW7McKj1ZhrlHnGWc2C9F6oajfHdpTq2fE
	 45o/gKZGbTQfWpXwiwblIFd90+riYbc8NM1+apOYwxTpwnirc7co5q6qt90GhXMZYA
	 H5F02DWDnqeMDqfrcEnJ/NNdQoQAtpioxpjGgqIKnvvryLVFAUVMrPkxnw+VDb/YtI
	 bsNGtm/53f4RO28Z+SbrhhMTL/jmEm02GocgFDe02LFwK1LUuOadkd4WvSydBZwQp2
	 XajktGCcknU9A==
Date: Wed, 9 Jul 2025 18:02:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Zhou Wang <wangzhou1@hisilicon.com>, Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, Lukas Wunner <lukas@wunner.de>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <fpb23ogxfppvrkbr7mwk5jinq3m5bswzzepkt4hqpchycvttfl@o72xdeqm3eia>
References: <fr6orvqq62hozn5g3svpyyazdshv4kh4xszchxbmpdcpgp5pg6@mlehmlasbvrm>
 <20250530113404.GA138859@bhelgaas>
 <bixtbu7hzs5rwrgj22ff53souxvpd7vqysktpcnxvd66jrsizf@pelid4rjhips>
 <aGuqA92VDLK8eRY1@ryzen>
 <aGuvkkeVkezGJWXn@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGuvkkeVkezGJWXn@ryzen>

On Mon, Jul 07, 2025 at 01:29:22PM GMT, Niklas Cassel wrote:
> + Mani's kernel.org email.
> 
> On Mon, Jul 07, 2025 at 01:05:39PM +0200, Niklas Cassel wrote:
> > Hello Mani,
> > 
> > On Fri, May 30, 2025 at 09:39:28PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, May 30, 2025 at 06:34:04AM -0500, Bjorn Helgaas wrote:
> > > 
> > > > I think pci_host_handle_link_down() should take a Root Port, not a
> > > > host bridge, and the controller driver should figure out which port
> > > > needs to be recovered, or the controller driver can have its own loop
> > > > to recover all of them if it can't figure out which one needs it.
> > > > 
> > > 
> > > This should also work. Feel free to drop the relevant commits for v6.16, I can
> > > resubmit them (including dw-rockchip after -rc1).
> > 
> > What is the current status of this?
> > 

Thanks for the nudge!

I couldn't respin the series as I lost access to the hardware I was testing on
due to job change. I'll figure out a way to test it and respin it asap.

> > I assume that there is not much time left before 6.17 cut-off.

Mid of -rc5 is not that bad ;) Let's see how long it takes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

