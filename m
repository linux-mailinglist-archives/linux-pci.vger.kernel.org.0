Return-Path: <linux-pci+bounces-33559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F6B1D9BE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363057A0614
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA857262FF8;
	Thu,  7 Aug 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG1qvKkj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFA226D18;
	Thu,  7 Aug 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576045; cv=none; b=Oilf2uwHUu6FF6uGrDd6FRyXYj+90oDktk3oAgVj9cdePd7Q5X4QqXnsVC5r61St1PSuwzgoSuxEanBoOeoamlagmHbXvTomUcYBihZbYXuvhNXESy9zUJ0nb/YfVbXA+g06TjYvpFG3P/UmugKCdAhG1OAvBIWMwlItFVe565U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576045; c=relaxed/simple;
	bh=/02FlV5Egn/tfIa7fbsKslPM15U2iH7ACtYtX+6Buc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIEq6Buljt6Wc5lcmb5l0NZaIc/Dsw0DhRNRcuF44+OWXa3xkh9itFoI1hXJsSZLxosOAxcEb9F9e8OQ7D883dFjpfOVKfsgavytEnaaPMDeoJvaZ+uPFdDhCO7vfDaV69nRKNvFIly1GDJb9bZnbRUyB3bZSOT2T63G6TqjMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG1qvKkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD454C4CEF9;
	Thu,  7 Aug 2025 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754576045;
	bh=/02FlV5Egn/tfIa7fbsKslPM15U2iH7ACtYtX+6Buc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG1qvKkjhbxol9XnGzMf7Y1wCp1gdWsJ6VYLH4jI8aS76RnfLXuO5XdyriqcY5sx1
	 Xdn13D5vukJ35xe4jmb64uvn3RoLATHfVOrHa1GHSHHLO14Y/aTRI37lPxOpunE7k9
	 hxepZtJ/z+a6whgIK5sowXaKhPfeO1dAGdCJP4rhVQjkH2yFiIVPRV1po21SxqKnEm
	 p8nPuKzr/8SplnY7ogaGwj6vY2yoVWBAdqmRUBYgbAJFGEsCgzFik7SL+PB0fhZz1s
	 wU6L2C4v8MIDl4A59P07/pEgRkC1/3eq5B2E8mdqOP5Gf0ZAfB62TTUyupmnz3qB3S
	 ATfBC32smmNUA==
Date: Thu, 7 Aug 2025 23:14:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shuan He <heshuan@bytedance.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] PCI: Remove redudant calls to
 pci_create_sysfs_dev_files() and pci_proc_attach_device()
Message-ID: <20250807141403.GA3052587@rocinante>
References: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
 <aIDbwNdWgtKcrfF_@wunner.de>
 <d2ty2hr5jqmlqwkdnd252ctix4xqmxtonx6wqyq3oj5f3j3cpf@yuibbj5owarp>
 <CAKmKDK=dOZp1a_syV1fjdo2gjEJX=C21A_mDsMqZVZrKLjf46A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmKDK=dOZp1a_syV1fjdo2gjEJX=C21A_mDsMqZVZrKLjf46A@mail.gmail.com>

Hello,

[...]
> Or we should wait Krzysztof's work got finished first, then
> make further moves?

What "moves" do you plan to make here?  I would say... please be a little
patient.  My day job is keeping me busy at the moment. Nevertheless, I plan
to get to this very soon.

[...]
> > https://github.com/kwilczynski/linux/commits/kwilczynski/sysfs-static-resource-attributes/

This is not the latest version, please don't use it for anything (this has
been since removed).

Thank you!

P.S. Try not to top post when replying.

	Krzysztof

