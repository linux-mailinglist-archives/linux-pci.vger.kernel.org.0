Return-Path: <linux-pci+bounces-18113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8419ECA99
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE428965A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A377239BD1;
	Wed, 11 Dec 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n2JcU3tG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D8239BA6;
	Wed, 11 Dec 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914141; cv=none; b=cibv0clx1bvZa4bdcJaEn2LNWXglEbfHO5UdVtFoBD6p8XaBr6/hYGGzT3BlDv3jUe/MJZpFfT7stQRx70fTRxaAaz4eH/mZ+erXpOrqBNIWQVACYhs2J96/ImPTixrueB3lSHqStfB7X05kUb3bPSCbjIlHB2PbCtyKMwwL1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914141; c=relaxed/simple;
	bh=AGZGhdaWjQwrZwP2A3JSVxVnl0guSnYP24yoGYOd1OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej4ROZRQhirCkWNJGgusV4oszc53pA4rbUEJ8chw9aLnMlAn8Iynh0Uzq+1x2fwvaiC+h5BBUK3stZk33RioD/OQistguIcmfFN6P3Ocx2V7A7HbLjIL62OKVCgB3ouJJ1QO0icKgfUsZXng10K1lFYjGxQ3GNGsFxKExN8e7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n2JcU3tG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16301C4CED2;
	Wed, 11 Dec 2024 10:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733914140;
	bh=AGZGhdaWjQwrZwP2A3JSVxVnl0guSnYP24yoGYOd1OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2JcU3tGFV3G98fXdxCsxoPVlMBo2xG9Kg8jeRvTuY06U7VuEAEaXw/VTeLS5f65d
	 mEKUO7Nt5DBis7X7lrkxirmno9T3gBGdEaXLxAZr4gbuSNUtCF6OtHtlxoYuBhaQRM
	 g/JvHEDB7KHDp+CAuYojM0LW4/xy1bIBOd/WWnjo=
Date: Wed, 11 Dec 2024 11:48:23 +0100
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
Message-ID: <2024121111-acquire-jarring-71af@gregkh>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121112-gala-skincare-c85e@gregkh>

On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > In a subsequent patch we introduce the `Registration` abstraction used
> > to register driver structures. Some subsystems require the module name on
> > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > the module name to `Module::init`.
> 
> Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> that's not the real thing), we want the pointer to the module structure
> in the register_driver call.
> 
> Does this provide for that?  I'm thinking it does, but it's not the
> "name" that is the issue here.

Wait, no, you really do want the name, don't you.  You refer to
"module.0" to get the module structure pointer (if I'm reading the code
right), but as you have that pointer already, why can't you just use
module->name there as well as you have a pointer to a valid module
structure that has the name already embedded in it.

still confused,

greg k-h

