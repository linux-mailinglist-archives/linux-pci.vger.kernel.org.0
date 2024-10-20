Return-Path: <linux-pci+bounces-14927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6749A548A
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E84D1F21A65
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FD192B62;
	Sun, 20 Oct 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhSAIBH+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FB1DFDE;
	Sun, 20 Oct 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435293; cv=none; b=CkGUI6y4zRUgni1oQm4X4MqpFZOH8t88SXlD4GV+prz1ADR/UHaWQlmGibdZJFqEWDfkM9d2GzgUXi6SwB4ZHf0hTeiRVPB+M1JEMU/5AtRA3eE1qsxYQggIIa14BZiPCfTNcOXPqqPVyp+I2L7+On9OxqLPCwUfNOjCGVU2Dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435293; c=relaxed/simple;
	bh=LwfanjgEQjqyWcvwDJM9Gy7OKlQwPcMP7YlWcbF+oPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osr50ebIt+Slszr90Y1G4kxn6mfwurYvYjxTvsi1NKzgpNgY1dKo+9AZIfuZHuPJVevPX1oRoVgUBTNSeLcKMTKe2wQUUQ4rRbPLLdkAuQ62qD1jANwt+ih/hiS4MpYFgUQd0UJO05mw8tCGa+r9axKKwnNPEY16H0s5cZDNIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhSAIBH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39ACC4CEC6;
	Sun, 20 Oct 2024 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435292;
	bh=LwfanjgEQjqyWcvwDJM9Gy7OKlQwPcMP7YlWcbF+oPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhSAIBH+KyvhoemjtmfVf14Yu7DhyPJFJ04d/eY6gx3QP1MfPbAFexhBaA5i+scti
	 JJx0CV0bT9fs+jULlxw7lwCDCCvQUgRopoqs+ScVS3EkQWn1WWQ3Q2NS9NU7Kp7gEN
	 4QtvMnJYrN7gesnb/X/Hb2hoNaM6uKQIWl/tg0v4ZMIqZFOWmjP2vV6VLrnFwLgGpl
	 a+1mX/MAmrIW5P6d35gueW8xCxVlyYAURIULTgUadCaHoJwJwWCs74PqfSmjGgnnb7
	 zi68ghQQP3U982unoBk9Qj2Mk+NFxKquzykV1Ve9oEtagQIuE/BwQ5E9UtYiOSLYqv
	 1fk8g+WRBisGg==
Date: Sun, 20 Oct 2024 16:41:25 +0200
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
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxUWlSFEPDCCXaq0@x1-carbon.lan>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
 <ZxJqITunljv0PGxn@ryzen.lan>
 <ZxJ7HoSuYNr8mwSi@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJ7HoSuYNr8mwSi@lizhi-Precision-Tower-5810>

On Fri, Oct 18, 2024 at 11:13:34AM -0400, Frank Li wrote:
> On Fri, Oct 18, 2024 at 04:01:05PM +0200, Niklas Cassel wrote:
> > > +	/* Only revid >=1 support RC-to-EP Door bell */
> > > +	ret = epf->header->revid > 0 ?  pci_epf_alloc_doorbell(epf, 1) : -EINVAL;
> >
> > I really, really don't like this idea.
> >
> > This means that you would need to write a revid > 1 in configfs to test this.
> > I also don't think that it is right that pci-epf-test takes ownership of "rev".
> >
> > How about something like this instead:
> >
> > My thinking is that you add a doorbell_capable struct member to epc_features,
> > and then populate CAPS_DOORBELL_SUPPORT based on epc_features in
> > pci_epf_test_init_caps() (similar to how my proposal sets CAPS_MSI_SUPPORT).
> 
> The primary issue is that the doorbell is not a capability of the EPC
> itself; rather, it's a capability of the entire system that requires an
> external MSI/ITS controller. The CAPS_DOORBELL_SUPPORT should handle this
> feature. Even we needn't CAPS_DOORBELL_SUPPORT, just call
> pci_epf_alloc_doorbell(), if error return, means not support DOORBELL.

Well, the idea is that CAPS_DOORBELL_SUPPORT bit is to tell the host side
driver (pci-endpoint-test.c) that the EPF supports doorbell.

In other words, if pcitest -B is executed, but the EP (pci-epf-test) does
not set the CAPS_DOORBELL_SUPPORT bit to one in the CAPS register,
the host side driver (pci-endpoint-test.c) can error out immediately,
no need to even trying to send any command to the EP.

(We can do the same with MSI and MSI-X, no need to send a command to the EP
if the EP has CAPS (CAPS_MAGIC is set), but does not indicate support for
MSI/MSI-X.)


> To use the doorbell functionality, the revid can clearly inform users that
> this feature breaks previous compatibility. Users will need to update the
> host-side driver, PID/VID values, and the pcitest tools accordingly.

I still really don't like the revid idea.


> One potential problem is that if the EPC supports CAPS_DOORBELL_SUPPORT,
> but the user continues to use older PID/VID values to enable EPF testing,
> the pcitest tool may treat the doorbell BAR as a normal BAR. This could
> lead to confusion for users as to why their system breaks after a kernel
> update.

How about we add a new pcitest --set-doorbell-mode option
(that is similar to pcitest -i which sets the interrupt mode to use).

That way, we can do:
./pcitest --set-doorbell-mode 1
(This will enable doorbell for e.g. BAR0, pci-epf-test will call
pci_epf_alloc_doorbell() when receiving this command from the RC side.
The command will return failure if pci_epf_alloc_doorbell() returned failure.)

./pcitest -B
(This will perform the doorbell test)

./pcitest --set-doorbell-mode 0
(This will disable the doorbell for BAR0,
so it will again not trigger IRQs when BAR0 is written,
and pcitest's tests to read/write the BARs will again behave as expected.)

(We probably also need another option pcitest --get-doorbell-mode.)

I think this should solve all your concerns. Thoughts?


Kind regards,
Niklas

