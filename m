Return-Path: <linux-pci+bounces-41996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC998C82BEC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47FFC34A659
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6F26F46E;
	Mon, 24 Nov 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVbK/YME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033C26E70E;
	Mon, 24 Nov 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024849; cv=none; b=AJ57S/TlQT+ShqRaCz0qhbYU9KFCG9OKSmEIx0LsodLygNOuhGW/Dj3sW+V3ONSQqDRRcddmEPTer908PwSKqFRo7gtbURIySRdt+jp6x5UuyUdqjcFRmT/hYSVqHN3166ySTqb4nM1dI8+vhS6L+WgPRSVw7JLDTECX32BqYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024849; c=relaxed/simple;
	bh=BC240MSG5119oWxbshF7QWyxMleqYZRlgI7AAnOCTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IEQUKNM/EZBuqfvmJgslHwRdFbNww9fcGKHnq2dOaIqWplmLlKg0NeXFYeCr09udgfHEYKM9IS7Vs6kF521AOYybZS0tuCT6pYUBLEvj/C6ZHFA46zkLigEYmxwnJ1Dyhn6DBoaEg2AdpYJfsiKuUtrwRkNEPYJFDgJ38EAHT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVbK/YME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC06C4CEF1;
	Mon, 24 Nov 2025 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024849;
	bh=BC240MSG5119oWxbshF7QWyxMleqYZRlgI7AAnOCTdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PVbK/YMEeFuUggJRkgUcS3aXBbXzFLLmnI9Brc13WJokHXTPMhfDuDlBRVQOl6rc5
	 ZrxqKA1UwL2Cw6SQp3Au8/i6ZF2l9MsRWpKpA53AB4ugMv72ZtgdThE01kKplr9qh1
	 ZDibUZxdWpGKxUfxJFWaSFnKyk63+JtA/T//NDjKOyJgd3B+ogw1kKlSOL7LlqllBU
	 BB+OPy6QP8OUNjvFuy7WDO31rgQa4T8KuojwFHwvF4w/qrExQ/AsVtmBfvY5zYyjtW
	 x2E+Xl+Uh1W+PYrBnnOz8GBwKjEJBz85qUHgu0805EARDNHoNRxbI4Pb0v0EUiFJ2i
	 pyyLCSNUbFHpQ==
Date: Mon, 24 Nov 2025 16:54:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Linas Vepstas <linasvepstas@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: Amend error recovery doc with
 pci_save_state() rules
Message-ID: <20251124225407.GA2722237@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de>

On Fri, Nov 21, 2025 at 06:31:17PM +0100, Lukas Wunner wrote:
> After recovering from a PCI error through reset, affected devices are in
> D0_uninitialized state and need to be brought into D0_active state by
> re-initializing their Config Space registers (PCIe r7.0 sec 5.3.1.1).
> 
> To facilitate that, the PCI core provides pci_restore_state() and
> pci_save_state() helpers.  Document rules governing their usage.
> 
> As Bjorn notes, so far no file in "Documentation/ includes anything about
> the idea of a driver using pci_save_state() to capture the state it wants
> to restore after an error", even though it is a common pattern in drivers.
> So that's obviously a gap that should be closed.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20251113161556.GA2284238@bhelgaas/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied with Rafael's ack to pci/err for v6.19, thanks!

> ---
>  Documentation/PCI/pci-error-recovery.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 5df481a..43bc4e3 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -326,6 +326,21 @@ be recovered, there is nothing more that can be done;  the platform
>  will typically report a "permanent failure" in such a case.  The
>  device will be considered "dead" in this case.
>  
> +Drivers typically need to call pci_restore_state() after reset to
> +re-initialize the device's config space registers and thereby
> +bring it from D0\ :sub:`uninitialized` into D0\ :sub:`active` state
> +(PCIe r7.0 sec 5.3.1.1).  The PCI core invokes pci_save_state()
> +on enumeration after initializing config space to ensure that a
> +saved state is available for subsequent error recovery.
> +Drivers which modify config space on probe may need to invoke
> +pci_save_state() afterwards to record those changes for later
> +error recovery.  When going into system suspend, pci_save_state()
> +is called for every PCI device and that state will be restored
> +not only on resume, but also on any subsequent error recovery.
> +In the unlikely event that the saved state recorded on suspend
> +is unsuitable for error recovery, drivers should call
> +pci_save_state() on resume.
> +
>  Drivers for multi-function cards will need to coordinate among
>  themselves as to which driver instance will perform any "one-shot"
>  or global device initialization. For example, the Symbios sym53cxx2
> -- 
> 2.51.0
> 

