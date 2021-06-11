Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21463A3E3D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhFKIrL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 04:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFKIrL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 04:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D986613B3;
        Fri, 11 Jun 2021 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623401113;
        bh=lFOCAvTa5kzm9zjAjf2Cb6+Xc+gz2Rbc6efLS2UFKkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BE54IPKK/mj7XtJint2tB9C5Rd87WaGfFjnd3Qz6D+K5jHuhoULdezgurcXosn2Yv
         itC/ZCAjXBR3aR4Bm/9wR2sCPrOXHiEL5kGUL71exlcF+Ix1zjrM9+aMGS1oS+Utob
         5tBmxzN92lAF5wWOszdETku6UgPAI7pnqbgdBvgu0w6HjimxEFLZl6VKbOKs3QjRbd
         HiXZM6r5X9ujiKTnC8hHjzEvYQWYvWUg+m3vtK7QtvwaHrOL3gnDPeXaQVTrEAYU44
         I+zOqz2rfXQlMiVyNEUFxfMBlT+jyCP0mjZPmZQNkBT7JiT/exq0be5n9+xuyNep8B
         ZWEMtyK/AEOBw==
Date:   Fri, 11 Jun 2021 10:45:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 26/34] docs: PCI: endpoint: pci-endpoint-cfs.rst: avoid
 using ReSt :doc:`foo` markup
Message-ID: <20210611104507.01bbd489@coco.lan>
In-Reply-To: <20210610234622.GA2795707@bjorn-Precision-5520>
References: <5268f6eb75bc0fe000f4884bca0a17f01eddbc40.1622898327.git.mchehab+huawei@kernel.org>
        <20210610234622.GA2795707@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 10 Jun 2021 18:46:22 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> On Sat, Jun 05, 2021 at 03:18:25PM +0200, Mauro Carvalho Chehab wrote:
> > The :doc:`foo` tag is auto-generated via automarkup.py.
> > So, use the filename at the sources, instead of :doc:`foo`.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> It'd be nice to know why we're doing this and what the benefit is.

That came from an upstream discussion, mentioned on patch 00/34:

		https://lore.kernel.org/linux-doc/871r9k6rmy.fsf@meer.lwn.net/

Basically, using Documentation/.../foo.rst allows some text editors
to navigate directly to the file. Also, there's a preference from
some maintainers to keep the ReST files as close as possible to plain
text.

> Maybe if you know more about ReSt, it's obvious that using :doc:`foo`
> is wrong and produces the wrong output or something.  But I don't
> know.

It is more a matter of preference. That's said, there is indeed
an issue with the current builder: when using SPHINXDIRS="book",
doc:`foo` references may not work well. For instance, if one is
building just the driver-api book, a reference like :doc:`../admin-guide/foo`
can't be solved and will produce a warning, plus a bad output.

By using Documentation/admin-guide/foo.rst, it will simply be
displayed as a text without producing any harm.

We discussed in the past about that, but we didn't reach to any
conclusion about the proper way to fix it.

> I do think the pathname in the new text is easier for plain-text
> readers to follow.

Yes.

> 
> (What's the correct spelling of "ReSt", BTW?  The cover letter has
> "ReST", this patch has "ReSt", wikipedia says "RST, ReST, or reST".)

ReSt was a typo.. sorry for that. I guess the proper way is ReST,
but several places use RST instead. For instance, the conversion
tool pandoc uses "rst" to refer to this format.

> 
> But anyway,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
Mauro

> 
> > ---
> >  Documentation/PCI/endpoint/pci-endpoint-cfs.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> > index 696f8eeb4738..db609b97ad58 100644
> > --- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> > +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> > @@ -125,4 +125,4 @@ all the EPF devices are created and linked with the EPC device.
> >  						| interrupt_pin
> >  						| function
> >  
> > -[1] :doc:`pci-endpoint`
> > +[1] Documentation/PCI/endpoint/pci-endpoint.rst
> > -- 
> > 2.31.1
> >   



Thanks,
Mauro
