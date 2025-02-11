Return-Path: <linux-pci+bounces-21230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB3A31718
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19FC3A6982
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D22641F8;
	Tue, 11 Feb 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr1nbdha"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340126563F;
	Tue, 11 Feb 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307757; cv=none; b=sHmva/tH/xVZnAAlTL8PfT2fKm1grSE0eNAEbRVE6cbxT2/yzZS5RgDdrgd+0G22anMMe6NbIS39srzA1zqtXdok040DPOyp/O8uI5tlja01fwqUfEu8gIYj49KuMVskofMKOO9KHgjCZhqE78vMmS0WffJIXxBHcrD+75IEbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307757; c=relaxed/simple;
	bh=/QztJwiK+yK+pqByLvZV4c6ax5WGvDEiytfyf5ixKJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HL6bNbA4OFyctZCO4uJsn610zw6ZnvJXDrX38317uxg6GhBSZZ2P4QVgzJEGKvfLECedPE+gSr3AadRGcmUQrqR8Ged4AtljCrv0lNTNCJ6720oOBM0wZREIq9eyCxaL0t0FdqJFPHEUeDgIk5SNNJz8amR6eCSwcGJb5VVvH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr1nbdha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E8FC4CEDD;
	Tue, 11 Feb 2025 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307757;
	bh=/QztJwiK+yK+pqByLvZV4c6ax5WGvDEiytfyf5ixKJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nr1nbdhaaE4ygZdMUNvwf9SjBcZYtEivnfWwTpLiVWLY6WuH+frMKoWh/wVxk3U1c
	 L4YvTPGPMrUsWM4SpkmfKH3utwpqy3sgw7oZexYf6UFkxyQqjrpsOtZjk3EZQTZeD1
	 uMfPGmOCb7vmFzgkiI/FSkSvfkYxQs+5o8tlVG4xgekivx/MhJqI7H1KEcC1RTe+Ac
	 QVfFp95Tr5NmSDDQ7flOqyKFKHLFPQQm8Afo2xUnNHtjb8heMqfOMyhs/1vFL7fjPJ
	 loxoZ06hLAdlxr60oh0wcW76RHzuoQlxU5/ZFLJ82TNvdGPe8z2A6AiCAB8YaLJBYU
	 HWblBGwUdmJ/Q==
Date: Tue, 11 Feb 2025 15:02:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, bhelgaas@google.com,
	skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
Message-ID: <20250211210235.GA54524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qFvrf1gsZGSIGo@kbusch-mbp>

On Mon, Feb 10, 2025 at 04:03:26PM -0700, Keith Busch wrote:
> On Mon, Feb 10, 2025 at 06:57:40PM +0530, Purva Yeshi wrote:
> > Fix warning detected by smatch tool:
> > Array of flexible structure occurs in 'pci_saved_state' struct
> > 
> > The warning occurs because struct pci_saved_state contains struct
> > pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
> > Arrays of structures with flexible members are not allowed, leading to this
> > warning.
> > 
> > Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
> > instead of embedding an invalid array of flexible structures.
> > 
> > Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 869d204a7..648a080ef 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
> >  
> >  struct pci_saved_state {
> >  	u32 config_space[16];
> > -	struct pci_cap_saved_data cap[];
> > +	struct pci_cap_saved_data *cap;
> >  };
> 
> I don't think this is right. Previously the space for "cap" was
> allocated at the end of the pci_saved_state, but now it's just an
> uninitialized pointer.

Thanks, I think you're right.  Dropped pending fix or better
explanation.

This is kind of a complicated data structure.  IIUC, a struct
pci_saved_state is allocated only in pci_store_saved_state(), where
the size is determined by the sum of the sizes of all the entries in
the dev->saved_cap_space list.

The pci_saved_state is filled by copying from entries in the
dev->saved_cap_space list.  The entries need not be all the same size
because we copy each entry manually based on its size.

So cap[] is really just the base of this buffer of variable-sized
entries.  Maybe "struct pci_cap_saved_data cap[]" is not the best
representation of this, but *cap (a pointer) doesn't seem better.

Bjorn

