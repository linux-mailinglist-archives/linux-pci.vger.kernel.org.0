Return-Path: <linux-pci+bounces-13888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50184991E31
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDB728243F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E716191B;
	Sun,  6 Oct 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6uYmNdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB4EC5
	for <linux-pci@vger.kernel.org>; Sun,  6 Oct 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215216; cv=none; b=Tq9aVlHFT9i7tHdEK13bQhwiKR6pLHqxQ6l56YGpTIjj5czpovnPx8zm5UOsBhbamZ4aqYSb1GJrrvTq9TY7EJULl5lVOSaRGl9QolZ4g7Jvx5x90YT9XhyJC9URDg5gmviZhvpE7/CM9RgIJJkX/dVipoRa4uPSgV8R6lg9ucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215216; c=relaxed/simple;
	bh=mEN2QyJbdEKJP2MbKh833cHP+xCtPU/Jjx69ngq6RR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXZlzBnlJ44nYK+AE0vyEsHlcep7WUrvN9ZJr0zZ8VLPMefomFHG/ja4kDdjgyvUkJfAMmpDJ/VRsZzcQfxrkN5beitP0ka0U2R2o1JcUXzHMrtvmqKlypvDsv5lvmJkR/xtWkrLT/mRCd81+6ZEaoDVPZLAv2cXgM9uR+1VYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6uYmNdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE0DC4CEC5;
	Sun,  6 Oct 2024 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728215216;
	bh=mEN2QyJbdEKJP2MbKh833cHP+xCtPU/Jjx69ngq6RR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6uYmNdoyQrvOs8ujs8WVsbi0ZBSuueQvL6vug5Bm1JTGM39/YWJq8IMA8HJsI3Bu
	 Vg5cS2XE3vhFrHvt09qAYn/cPGWSi21Vw9GbUt/soaPWCZq/u3PTsQBHJRhJGhe12H
	 xS9l6xp97EdmYN5jjMCu3j5yKrZLkeY01WrJYUXpZC6r0YTtLFQKL1c7xrYvNtAOlT
	 Mf+jBtqfhWzUfeOkwmLyX+h1au/mvT6tRf61f9On9JTJsKprxyjisx9aKd4JhPnNOE
	 xPKVp3kGJc6xreTZ1XMXwxAkt827dExKOrq1zOAhbK2JFWPhfSLWfihk8g2MX2Tyr1
	 hgGf+Dm50KesQ==
Date: Sun, 6 Oct 2024 13:46:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v3 0/7] Improve PCI memory mapping API
Message-ID: <ZwJ4qmueen8HHTnc@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <Zv_p3CjYblYnY9Dj@ryzen.lan>
 <00e56c66-fed0-417e-b009-5bf11b05b1cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e56c66-fed0-417e-b009-5bf11b05b1cc@kernel.org>

On Fri, Oct 04, 2024 at 10:25:54PM +0900, Damien Le Moal wrote:
> On 10/4/24 22:13, Niklas Cassel wrote:
> > On Fri, Oct 04, 2024 at 02:07:35PM +0900, Damien Le Moal wrote:

(snip)

> > I think the cover letter is missing some text on how this series has been
> > tested.
> > 
> > In V2 I suggested adding a new option to pcitest.c, so that it doesn't
> > ensure that buffers are aligned. pci_test will currently use a 4k alignment
> > by default, and for some PCI device IDs and vendor IDs, it will ensure that
> > the buffers are aligned to something else. (E.g. for the PCI device ID used
> > by rk3588, buffers will be aligned to 64K.)
> > 
> > By adding an --no-alignment option to pci_test, we can ensure that this new
> > API is actually working.
> > 
> > Did you perhaps ifdef out all the alignment from pci_endpoint_test.c when
> > testing?
> 
> Yes I did. And I also extensively tested using the nvme epf function driver
> (coming soon !) which has very random PCI addresses for data buffers (e.g.
> BIOSes and GRUB are happy using on-stack totally unaligned buffers...).

I know that you did test using a nvme EPF :)

But for anyone reading the cover letter, it wasn't clear how this series
was tested, so it would have been nice if the information which you
provided above would have been part of the cover letter.


Kind regards,
Niklas

