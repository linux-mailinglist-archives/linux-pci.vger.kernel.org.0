Return-Path: <linux-pci+bounces-10809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3DB93CA23
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BA5B21D40
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647873478;
	Thu, 25 Jul 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQNdFat8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB7487AE;
	Thu, 25 Jul 2024 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942384; cv=none; b=bQC3rhcn9wP7VYqpgY6enBEnhVgsLxepJng1TvLy/VcV1xCV/+PEEgGJqhJDOMF7MMH0HE23TRQM3vlDR6qeDiUVDW+LoIYkxgJ6GoAjSelmIWkEmpI6LPUug+n1bdtYuezwJEpRzYdsPKStxPP6r7EViFuKxPtwMvFmrwt4TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942384; c=relaxed/simple;
	bh=4sRlyc9TAiWNwMx8udh+t85YIZuWizvHF8I605Y+otI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RPdMmyKf60kDBV7SVGrPEqunM7OQMSNt7VBPLNIJkcqGj3wKIBQbT4gmhO5IaAMKTdnwd9sh35QaxBOJjRTppqNdqWAqizuE3qz3q71GmECCFwln9s1NUTqG74PfxNHUCfzHeCCyt5oVpVuFbvHjD7v8CxSZ6610QxFGEM1rw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQNdFat8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE71C116B1;
	Thu, 25 Jul 2024 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721942383;
	bh=4sRlyc9TAiWNwMx8udh+t85YIZuWizvHF8I605Y+otI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cQNdFat81C9R5idXilDUFZOWeYcVwSyKi+bUw0J8nnfSw1rrKYKTfv3TQHc3o1r2U
	 vXp8RK8jKbeAK55GkBIgW0CGDDz/nWDNRQh7QOMRI5EGO16vfDAh+41gcIfzPbM7L5
	 pwHShrOOquJ/A9zx5Da0yCNJVZ4e1Xkl6ZG4qPJPix1EOiuv/8JwmubEcILicZ0Wb3
	 C3DaGtfdV4HUaxxZt5JZ3WV98h3jKp4dG0edTrqMJMr6CKgPHXcP5L8XOZyxCRabi+
	 XvGqyumrTP6W6NGqZFvgPLTQ1FQio+LeK19jsgdVCmGvwBqMn6w/oxS3tcir61kz/y
	 gKWb1kRIQAYcQ==
Date: Thu, 25 Jul 2024 16:19:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240725211941.GA860190@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3e3c5f-0d48-41b0-87f4-2210f13b9460@ti.com>

On Thu, Jul 25, 2024 at 11:23:43AM +0530, Siddharth Vadapalli wrote:
> On Wed, Jul 24, 2024 at 11:23:04AM -0500, Bjorn Helgaas wrote:
> > Subject should say something about why this change is needed, not just
> > translate the C code to English.
> 
> My intent was to summarize the change to make it easy for anyone to find
> out what's being done. The commit message below explains in detail as to
> why they are set to NULL. As an alternative, I could change the $subject
> to:
> PCI: j721e: Disable INTx mapping and swizzling
> where the "Disable" is equivalent to NULL. Kindly let me know if this is
> acceptable or needs to be improved further.

Sounds fine to me.

