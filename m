Return-Path: <linux-pci+bounces-25830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B2A88097
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A8E3ACA6C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC725F964;
	Mon, 14 Apr 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8z8iQ5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04019E967;
	Mon, 14 Apr 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634387; cv=none; b=o37/DSLXy7OvyJNHt03ETm0aBvMTzRAm+ngSoTj9dG3lDJbRe0zeMQJn+n3+Dlj9CdELvDon5tNPkvdDNCBU61NkNLFJYxPESaxdvZJ389szyz+pfYy49e3i/jrLT/phnNAE4FOZymhYdvShGx/6E2f4F6MB4fH6EupQr3gP73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634387; c=relaxed/simple;
	bh=uCeUO5KN6//X5xHT59j/AmVgCSsEI4H5IxgpAbiz/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4moVV5vNSY6QKjXCNhDIueWM0VWySVntlSEtBQQsGAQBOuOA8KjnOEb/NYTRAwvw8XO5Homyqat5EqnxvzuukILflpKVPERF2KuKxYDqtm1zkJ9B3Pa+NbOYGCwUXJyNjfNGLP1U3tIqj8cOFyEcvTPJhgcmUBAjA82IVpYDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8z8iQ5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57336C4CEE9;
	Mon, 14 Apr 2025 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744634386;
	bh=uCeUO5KN6//X5xHT59j/AmVgCSsEI4H5IxgpAbiz/Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8z8iQ5JDtUhthvsOGYesKDtTctTXns9XdVrBlbbrlsBBAuJ6CpCwTM4GrB7KJ2Uy
	 4/V3zJb+5sFiCMF1AJ7CQJsC9RCWGNyrTIDL4iWdAd65vB0kYjmkSYP7u8zMIKtmLl
	 eGDU8WNv3qgmGPR0lKsphKRo/AQbRxQPP09+Xsmt2Ll2Zx5nH78SkLzynbpfR6SX3k
	 Axo7XLLTT49PAnMI495QzJdpxyVQF1jEmX7fXVi1arFVEVHf/K8ALu2MwzfidFZDeb
	 Hn2dfSoDmBW7dTkWwKosPuUSP+S8Y3Y7OD6NmyARNBz4lJy5zIC8Oqs+CntXKxsBAI
	 HPH4kvZuEuUJw==
Date: Mon, 14 Apr 2025 14:39:42 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com, kw@linux.com, kwilczynski@kernel.org
Cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: pci: add entry for Rust PCI code
Message-ID: <Z_0CDioBSwQGYmvH@cassiopeiae>
References: <20250407133059.164042-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407133059.164042-1-dakr@kernel.org>

On Mon, Apr 07, 2025 at 03:29:50PM +0200, Danilo Krummrich wrote:
> Bjorn, Krzysztof and I agreed that I will maintain the Rust PCI code.
> Therefore, create a new entry in the MAINTAINERS file.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

With the following changes, applied to driver-core-linus, thanks.

  * adjust Krzysztof's email address to his kernel.org address

- Danilo

