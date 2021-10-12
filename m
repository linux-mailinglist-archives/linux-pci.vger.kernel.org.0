Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42942A94C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJLQXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJLQXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 12:23:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B8C061570;
        Tue, 12 Oct 2021 09:21:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oa4so16128pjb.2;
        Tue, 12 Oct 2021 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UIVnO7nrVA1OEWq3WARzdG8dUo4RJYvgMG0Cdjlm51s=;
        b=T2OlcFKTyMJpKjcuB5mtSn7g4f4nIHRjfj6VoGsgxlF7aK4seidg9PVOSStKSnMhlx
         6+mpoxRG91LZgPkcoHNgnbq5G+0P0hN55uswcgr2EimY60igooYzpaKdHeXW7hNpCbNq
         Bsgfm04qc/vl/QfWBexUJs1USJ9XUVZFk4t6mT7Ah9bfH5EzQNYhE2fJpLE6XpY+QeDn
         WXl0E+UtBNDWRpr9eRN0gN4B6bkOsZa9R+hCmFCj8mIvDTInV/uNMrSFXGyliFHbStQk
         ca9eB6/Zi2TkCv79RpjL6FNbpTY1yLjD3G5NSx2fhHWbqv7Wew08lySNz/Uffc5fA9iY
         GCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIVnO7nrVA1OEWq3WARzdG8dUo4RJYvgMG0Cdjlm51s=;
        b=sJS3pjcU0WlrEdle433Jq77aW2OlhWQu3XvQGJf5wkVcQk7OuPi6bqFX4wlktlSoar
         ZfBzG0+aS1IHXJkQzvAdDZk39FUCkZni3DWnJRCSinEdtMk+hX5Ji2OPticLUo8iueQ1
         fXnNvZKvyERPfQquUYNLdfg7b0nfqQZpz1i4mtwCreAI2oBrrBco8/M0xzKzfMOwM80O
         nartLwRDzA8cxt2NE3uxKZbr9t2UsM+j25xQuPymCYMZMuQEzS335vHXs+s8s6mJGLY8
         rKiSlg8WPttnqGO7+iHKE47znNk1/bqBrgE0REnjwVQ2UNmoEr835B/0A4uJPbaZYt7q
         h3uw==
X-Gm-Message-State: AOAM530O2dxuOTFGFz5qAO8iS1iuilmS0DZxCwgkMZZsZNF7xwj2D8KP
        DgJGhB3WgrUyHiV/LNvajiU=
X-Google-Smtp-Source: ABdhPJzWukHJlQL4CxbE2yFzFUqlsG5dKptepJM40i1qCVm2PKx1kWl4v/t5qv5BrQGR3FvIuVWrKA==
X-Received: by 2002:a17:902:db04:b0:13e:f118:54de with SMTP id m4-20020a170902db0400b0013ef11854demr31207307plx.44.1634055677646;
        Tue, 12 Oct 2021 09:21:17 -0700 (PDT)
Received: from theprophet ([2406:7400:63:cada:3b09:6c3b:61f5:2cfd])
        by smtp.gmail.com with ESMTPSA id o6sm11679273pfp.79.2021.10.12.09.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 09:21:17 -0700 (PDT)
Date:   Tue, 12 Oct 2021 21:51:08 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.murray@arm.com
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211012162054.rxx7aubwdvhl2eqj@theprophet>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
 <YWS1QtNJh7vPCftH@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWS1QtNJh7vPCftH@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10, Rob Herring wrote:
> On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Use SET_PCI_ERROR_RESPONSE() to set the error response and
> > RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> > read.
> > 
> > These definitions make error checks consistent and easier to find.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/access.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 46935695cfb9..e1954bbbd137 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> >  
> >  	addr = bus->ops->map_bus(bus, devfn, where);
> >  	if (!addr) {
> > -		*val = ~0;
> > +		SET_PCI_ERROR_RESPONSE(val);
> 
> This to me doesn't look like kernel style. I'd rather see a define 
> replace just '~0', but I defer to Bjorn.
>

Apologies, if this is a lame question. Why is the macro
SET_PCI_ERROR_RESPONSE not a kernel style. I ask this so that I do not
end up making the same mistake again.

Bjorn, did initally make a patch with only replacing '~0' but then
Andrew suggested in the patch [1] that we should use the macro. 

[1]:
https://lore.kernel.org/linux-pci/20190823104415.GC14582@e119886-lin.cambridge.arm.com/
[Adding Andrew in the CC for this]

Apologies, I should have added this link in the cover letter but I
completely forgot about it. 

That's why I decided to go with the macro. If that is not the right
approach please let me know and I can fix it up.

> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> Neither does this using custom error codes rather than standard Linux 
> errno. I point this out as I that's were I'd start with the config 
> accessors. Though there are lots of occurrences so we'd need a way to do 
> this in manageable steps.
> 

I am sorry, but I do not have any answer for this. I really do not know
why we return custom error codes instead of standard Linux errno. Maybe
someone else can pitch in on this.

> Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value 
> and delete the drivers all doing this? Then we have 2 copies (in source) 
> rather than the many this series modifies. Though I'm not sure if there 
> are other cases of calling pci_bus.ops.read() which expect to get ~0.
> 

This seems like a really good idea :) But again, I am not entirely sure
if doing so would give us any unexpected behaviour. I'll wait for some
one to reply to this and if people agree to it, I would be glad to make
the changes to PCI_OP_READ and PCI_USER_READ_CONFIG and send a new
patch.

Thank you very much for the review :-)

> Rob
