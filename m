Return-Path: <linux-pci+bounces-34140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6ADB29351
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1FC189D40D
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C7243364;
	Sun, 17 Aug 2025 13:45:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305F317705
	for <linux-pci@vger.kernel.org>; Sun, 17 Aug 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438329; cv=none; b=bB3kLTMk2eloQJHjGzWaaQG5gbxFdtfD+cAhyVdYOdKsWIqfz+qJR2j/UFaims4Y8AchkUlFxQwAP9WqCM5EXkZVj2yOayTgsvwEeqlxE0yoSANPcCJIvVMmJibSqjdxNqLod53ZzRMTyheq5dxCp7qnILluMrHy+UMy1FI3Qwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438329; c=relaxed/simple;
	bh=bF1Gi+ZK6PjI5s7cRcU2TGY9CaqziJJHuUPmyThBBdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4WeOV+Rr+h3aBrQq1Lzlf47ZRnvVPmCsV0/mX5kRe0J8QQ1m1ozfBOuQjziRb0yyBxus+ihgbwnzvv0KusD4gGUcmHQZZD4Fh+dfD9mvZPa2XyyPaIlJSYc1lkmsw5q6ngEgRlYtnBYGGv2WRLpc17PtWf3w+5RB6NwceOU3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5E0DC2C051CC;
	Sun, 17 Aug 2025 15:45:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2047E3BEDFB; Sun, 17 Aug 2025 15:45:25 +0200 (CEST)
Date: Sun, 17 Aug 2025 15:45:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
Message-ID: <aKHc9RxYHC0CpbeS@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
 <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
 <cd952c82-9f8b-4396-9170-b34d539a8fac@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd952c82-9f8b-4396-9170-b34d539a8fac@linux.intel.com>

On Wed, Aug 13, 2025 at 04:01:09PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 8/12/25 10:11 PM, Lukas Wunner wrote:
> > The file Documentation/PCI/pcieaer-howto.rst hints at a rationale for
> > always performing a Bus Reset on Fatal Errors:  "Fatal errors [...] cause
> > the link to be unreliable.  [...] This [reset_link] callback is used to
> > reset the PCIe physical link when a fatal error happens.  If an error
> > message indicates a fatal error, [...] performing link reset at upstream
> > is necessary."
> 
> In the code we don't seem to differentiate link_reset and slot_reset. But
> the Documentation calls them into two steps. Do you think we should
> fix the Documentation?

reset_link and slot_reset are two different things:

* slot_reset is the ->slot_reset() callback in struct pci_error_handlers.

* reset_link is the reset_subordinates() callback passed in to
  pcie_do_recovery().

Commit 8f1bbfbc3596 renamed reset_link() to reset_subordinates() but
neglected to update Documentation/PCI/pcieaer-howto.rst.

Commit b6cf1a42f916 dropped the reset_link() callback from struct
pcie_port_service_driver and dropped default_reset_link() in favor
of passing aer_root_reset() to pcie_do_recovery().  Yet the documentation
continues referring to a "default reset_link callback" and incorrectly
claims that "Upstream Port drivers may provide their own reset_link
functions".

I've begun updating the documentation and intend to submit that separately.

Thanks,

Lukas

