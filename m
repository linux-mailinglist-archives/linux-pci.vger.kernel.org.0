Return-Path: <linux-pci+bounces-30994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBDAEC67A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2494A0B50
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E223B631;
	Sat, 28 Jun 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/RbxkOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092012FF69;
	Sat, 28 Jun 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751104740; cv=none; b=cxcZZn1hgIwUIZprtHUTEY8m+GJ6z9IsU2KgjZ4VTru3S4nErGRT1Igj7CCMlWEapiuCo7oj9lHuUMQrIWTDmg3chFr120tO5DZ97pBflrasMKuciSliAq1of90N0bvPEMAYJsTeGsEudzQFiaNzMNlnUYC+HPHcHfsFTLfIEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751104740; c=relaxed/simple;
	bh=UN1stUXsni/d6TUJvZpDboqqcUYchqF9z6pjR6r2aIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7uluJwozXlZlHhG96ifxN3J8JXcMOl7X8zKDy74S9DMNt+v9OgOr/lF7PI7bLk/3Od7DU9kaVfIWiL2kBwZT3SP19+67ch844imAI+W9MQ5dKM4oOanKfYJsXP5pRgi10WdHNgJYjY/K3CmXqo25XcgAfaep4CgdEX97HtkwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/RbxkOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E363C4CEEA;
	Sat, 28 Jun 2025 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751104739;
	bh=UN1stUXsni/d6TUJvZpDboqqcUYchqF9z6pjR6r2aIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/RbxkOx0QOABP4ujopxBsEo2wnU4pS8HTyKjBj3hdXAdQJ0xH/Eo17uCisCLDXod
	 E6H7hnoAUDKTeEooRc+2NMJkyPqDCdhiLqAuncPhswj++/FcYVHGQHlOV08TE0WLGe
	 TTPBIQOQyGq6/CtJ4kdU+IyXeaaK5666vDVS/P/fY41z2zpZWyMhnXF/UIPLoIAI/f
	 wFNDyIiQJ0ooT7WiHXoEIRbGkAlST99DGOIWcvyqe0HvO5Yo54WDj237jWg5mdgUJS
	 UynDuRu0LxQmS0pznCaWeccR73KaO0eO7GNe8p+cqfz0CbdlB5dIjWntlBuThT1LI/
	 MLZiIu6EQFX8A==
Date: Sat, 28 Jun 2025 11:58:53 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF-83Tb4-Sxz_KFk@pollux>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
 <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
 <aF8V8hqUzjdZMZNe@tardis.local>
 <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
 <aF-N-luMxFTurl91@Mac.home>
 <DAY059Y669BX.2GVKH6RBG80B6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAY059Y669BX.2GVKH6RBG80B6@kernel.org>

On Sat, Jun 28, 2025 at 09:53:06AM +0200, Benno Lossin wrote:
> Hmm @Danilo, do you have any use-cases in mind or already done?

There may be other use-cases, but the one that I could forsee is very specific:

A Registration type that carries additional reference-counted data, where the
Registration should be released exactly when the device is unbound, independent
of the lifetime of the data.

Obviously, this implies that the ForeignOwnable is an Arc.

With KBox, Release and Drop are pretty much identical, so using
devres::release() instead, is much simpler and hence what we do for all simple
class device registrations.

Besides that, the use-case described above can also be covered by Devres with
the pin-init rework, by having the Registration  embed a Devres<Inner>, which
is what irq::Registration does and I also do in the MiscDeviceRegistration
patches.

Hence, I already considered dropping this patch -- and I think we should do this
for now.

