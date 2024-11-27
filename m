Return-Path: <linux-pci+bounces-17399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BE9DA431
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454672845AA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1271891B2;
	Wed, 27 Nov 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXKiGNly"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B69154BEA;
	Wed, 27 Nov 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697640; cv=none; b=rhZT8tyDmm62Ek+iugYMdVorYfIY5pQCNvLtEm6nDbV43iHaW3qtEz024rqQ7tewozgbr4bCszKRNqMj3EwIQjANTePADJ5gJ/TpuBh1iUUplXM+N0gXNFzDeMVUFjXkIUr7ts/jhLqHV1CJzx1AF0G6p0RuU0K79Z4e9jCuN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697640; c=relaxed/simple;
	bh=GTzXM271KTS+OKkc7ykloLsBziWS3jjzqhZTo6a8EF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1b/jnXeZ5yJqB337o/iHBR+E6/QNiRpfWacvMU0NrxFmrJJqlPEBfUySA0a1hUTeDXygSSZKZ/Ak95VKCjwpb8VRQzJuuWyOYaowtC0zYv65Jf+L6Fi6d4+SuZ/sQKaQCalKjIftGAVyoUoFL/OJnQGEJGF48nr8q1ILT1YqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXKiGNly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645DEC4CECC;
	Wed, 27 Nov 2024 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732697639;
	bh=GTzXM271KTS+OKkc7ykloLsBziWS3jjzqhZTo6a8EF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXKiGNlyZQceBCDjYgRpXnO5tlWKreUOdXPH77t5mGA0hsfCbTQbNdfOI58uftfZW
	 MDSqeVRJuuHg4lbLQpZowcfhxS5Vw22vEv6EK9c+PwCp7iYYuMlScMQOZ6CVTZp/Ti
	 MhD+dlNVdGlrjZOvi9lAxFO8HlIUY5cLWDO8M9Gs0DCiIGHBFsRxwfK+Q7JrO5MEey
	 sxJ7ZMXWHJpKtNs+ai61WvHXdzZIDgedcsNFn7r5sMAeYZ7WJRTbc/CQnu8hWIN1Mt
	 GtGeHtywiot3Fd68k82LucuP1pWQ/h5kQquk6ou8DH+kZiyjYKerC6UZYcxVFlNHls
	 vFSe1n/J62uZw==
Date: Wed, 27 Nov 2024 09:53:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Z0beIUiqXsz5DwVJ@ryzen>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
 <20241124075645.szue5nzm4gcjspxf@thinkpad>
 <Z0TNMIX4ehaB+mSn@lizhi-Precision-Tower-5810>
 <20241126042523.6qlmhkjfl5kwouth@thinkpad>
 <Z0WcKeM2630u_xSK@ryzen>
 <20241126124112.5o4c3lzem72lkvdw@thinkpad>
 <Z0X9ccbTO1I2zefm@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0X9ccbTO1I2zefm@lizhi-Precision-Tower-5810>

On Tue, Nov 26, 2024 at 11:55:13AM -0500, Frank Li wrote:
> On Tue, Nov 26, 2024 at 06:11:12PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Nov 26, 2024 at 11:00:09AM +0100, Niklas Cassel wrote:
> > > On Tue, Nov 26, 2024 at 09:55:23AM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Nov 25, 2024 at 02:17:04PM -0500, Frank Li wrote:
> > > > > On Sun, Nov 24, 2024 at 01:26:45PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> > > > > > > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> >
> > I like the idea of calling pci_epf_alloc_doorbell() in
> > pci_epf_{enable/disable}_doorbell() APIs. And as you said, it doesn't make sense
> > to call these APIs too frequently.
> 
> I not sure what's you means and direction for next version.

Move pci_epf_alloc_doorbell() from .bind() to pci_epf_enable_doorbell().
Move pci_epf_free_doorbell() from .unbind() to pci_epf_disable_doorbell().

If the pci_epf_alloc_doorbell() call within pci_epf_enable_doorbell() fails,
let pci_epf_enable_doorbell() set STATUS_DOORBELL_ENABLE_FAIL.


> This patch just go first step. If we can append to ITS to bar0 in future,
> pci_epf_alloc_doorbell() will become more reasonable at bind() function.

To be fair, we are probably quite far away from supporting a BAR with two
backing memory areas. It would require a lot of changes in the PCI endpoint
framework, and a lot of changes in the DWC driver.

And even if we do add all the support for it, why can't we keep the
doorbell allocation in pci_epf_enable_doorbell() ?


Kind regards,
Niklas

