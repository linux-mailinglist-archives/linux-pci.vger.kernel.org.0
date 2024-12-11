Return-Path: <linux-pci+bounces-18112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB39ECA8D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013FD1690B6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFBC1EC4FE;
	Wed, 11 Dec 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXF9uNRq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96691EC4EA;
	Wed, 11 Dec 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913957; cv=none; b=ap8Al+KjELWoqKAEHUHmD+l92SDAUx612VDMOvqZwUnDcZkg283ixOhKQmCeZFdFdjKwVp1XQKKuJJkaauGTEsLDlzVEA7qApZEd3oGikTAWm3QwtR5B1pKC2qtUYDJBQjpLPm5JXVWCmai+OY7GsuN4TMjSbQWZB0qX7G9lnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913957; c=relaxed/simple;
	bh=FSJoGJA16IrMFlzP3UXcblADMuQGyd2uOHDdOrXfzug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTw0VM6hp1WSF5sX6LD0D4f+Hk5F9JtlN/PnIC/MhZPfXltsWwCYL7xJvs0chNn0P+FYoN9ilP+SQdJKY0q5g/Np0eBUezzKoaGji9BtxFC7ON5u8VJTbN/Be0iCO/g6vbNX/7wTaiWVR/jMPLAi44EvHeEeyGF64jky5WtN0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXF9uNRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CEEC4CED2;
	Wed, 11 Dec 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733913957;
	bh=FSJoGJA16IrMFlzP3UXcblADMuQGyd2uOHDdOrXfzug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXF9uNRqFX8Om3BkOdwkpt8ayUyJpKaZBIB6JNk/sK9eziaCzQrG+arR4dCR8oNcC
	 hFfzrxUgdJfqUGGTdO8iDbjZlzQ8UtNPTiVY+AuFiTfHDqGujTZYMEDkdOB1cCDGw1
	 aI4g9uoYzoZFKIkE4q97Tx/KzYhjmfGtN8EoNdK4=
Date: Wed, 11 Dec 2024 11:45:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
Message-ID: <2024121112-gala-skincare-c85e@gregkh>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210224947.23804-2-dakr@kernel.org>

On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> In a subsequent patch we introduce the `Registration` abstraction used
> to register driver structures. Some subsystems require the module name on
> driver registration (e.g. PCI in __pci_register_driver()), hence pass
> the module name to `Module::init`.

Nit, we don't need the NAME of the PCI driver (well, we do like it, but
that's not the real thing), we want the pointer to the module structure
in the register_driver call.

Does this provide for that?  I'm thinking it does, but it's not the
"name" that is the issue here.

thanks,

greg k-h

