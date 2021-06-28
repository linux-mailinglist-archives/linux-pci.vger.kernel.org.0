Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED43B5C97
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhF1KoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:44:00 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43637 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1Kn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:43:59 -0400
Received: by mail-ed1-f45.google.com with SMTP id w17so9649905edd.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vucUuVTN1AtpmyQisPu8422n/4wGmZRnb0PD7Yv1aA=;
        b=SRRZkFwhabeVcsRf6FP2/WCpR+ai4f1tVZ7j/TSLbQ0UfVBnGNMbrt1HLa1YD/NnyC
         0740B16b0e3nBl0tYpiIXeV5rLjKjSfPs4Tg96x30zWYss/KmmWmGTF0WqR59oMK94yu
         nsKr/2/YWsErlyCdzjTE9f53KGjddUzeO88ctY+4A2Od3EuPp9BJNN3PRS27DAuHQOGm
         keDN8zslxXD2PJZYY4mKEkJMcn7z4dHXbIIz4TrsKzAA8SKYlQb+KIjQDI8rnC14hTk+
         0eA5lpdCyvhGuFj5nEOHOsJ2uEEH01dvQ/MCr7dRxL7JkM+41eZxd++PzI39e4gVMZF1
         AY3A==
X-Gm-Message-State: AOAM533aXYNEVh+fprOs+Yo2REGcZxGf4iXDdRQpVlIJ3VXXJsrnvpvo
        SMlEVhHizmTbgFw5FtS29dI=
X-Google-Smtp-Source: ABdhPJxALm6bD4z3EJd8rv6jLEF7nURqvbElq/SyNfrpCnTt9HLf8T0EVua59+SI/K4fItfUXW3iEQ==
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr32039112edb.62.1624876892484;
        Mon, 28 Jun 2021 03:41:32 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g12sm9126630edb.23.2021.06.28.03.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:41:32 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:41:30 +0200
From:   Krzysztof Wilczy??ski <kw@linux.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali Roh??r <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs
 open callback
Message-ID: <20210628104130.GB139153@rocinante>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-2-kw@linux.com>
 <YNmf9sAB2NEnivsk@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNmf9sAB2NEnivsk@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> >  	if (battr->mapping)
> > -		of->file->f_mapping = battr->mapping;
> > +		of->file->f_mapping = battr->mapping();
> 
> I think get_mapping() is a better name now.  That being said this
> whole programming model looks a little weird.

I would have to lean on Daniel and Dan here as they might have more
context than I do, especially since in the PCI world we are only
consumers of this new API.  The related patches are:

  commit 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the region")
  commit 636b21b50152 ("PCI: Revoke mappings like devmem") 

> Also, does this patch imply the mapping field of the sysfs bin
> attributes wasn't used before at all?

No, everything worked as intended, thankfully.  Changes here are meant
to help us transition to use static sysfs objects when we add various
PCI-related attributes a particular device.  This in turn will allow us
to remove the need for late_initcall() in the drivers/pci/pci-sysfs.c,
and thus fix the race condition people noticed on some platforms when
sysfs objects are being added while PCI sub-system and devices are
initialised.

More details are captured in the following conversations:
  https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
  https://lore.kernel.org/linux-pci/20210527205845.GA1421476@bjorn-Precision-5520/
  https://lore.kernel.org/linux-pci/20210313215747.GA2394467@bjorn-Precision-5520/

Dan's original patch:
  https://lore.kernel.org/linux-pci/CAPcyv4i0y_4cMGEpNVShLUyUk3nyWH203Ry3S87BqnDJE0Rmxg@mail.gmail.com/

	Krzysztof
