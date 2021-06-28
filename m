Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C363B680F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhF1SJY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 14:09:24 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39468 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhF1SJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 14:09:24 -0400
Received: by mail-lj1-f182.google.com with SMTP id c11so26983575ljd.6
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 11:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWVbCjuZsjTZsJMX8FBVTKnlwWDgPqL7UE3MExLbcdg=;
        b=k3KNA5HDh6xDwIOpiMQ80YTwvEJgOB5MMjOZenYUpqvC4v9USKPRhT13e9rIBkCr3w
         5BM/rvg7myXL2VRaY9Gh2IpQxngS7OeeiJHe82a/+PcZ1hHV881XqNDCgLLhUgm7HU2q
         TaRxaP+9yEk5Jq+D6qkGbl4ExMS6Gh7jhF9gaD7wYK329ydm1KSZnJArTx1Im075+YaP
         2qXNVJOC2unNnIGQoPfaBKzzo7kIbylzpbF8HMAhvGCqzSoDRLmJCYXyV6zDKZGMHYA4
         cmc8+SVZ0kBIDhgafLFlcNlT7AxubOHYo49Fz9iMhUMjXM8/QtMus0lucTno/yQhpCiR
         8HIA==
X-Gm-Message-State: AOAM5338bhfciUgF4mEcApp689NCwdOfupMwT25S1OGaUzc9xWLyW7kN
        NvzkmPe9nM4nTxJtWyCtRG0=
X-Google-Smtp-Source: ABdhPJz9H0p6DDFuiggK4qln/1kXn5dyQkG1Y25N7axnW+PEsoknXqWD+kKQV6gOl+mb7BzcQQq2oQ==
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr488089ljk.243.1624903616735;
        Mon, 28 Jun 2021 11:06:56 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h22sm1637322ljk.133.2021.06.28.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:06:56 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:06:54 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs
 open callback
Message-ID: <20210628180654.GA168658@rocinante>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-2-kw@linux.com>
 <YNmf9sAB2NEnivsk@infradead.org>
 <CAPcyv4ihEZB7kXKVA1GCbWv=ZR2hvBfhwBX9fBFYYTCdg=aLrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4ihEZB7kXKVA1GCbWv=ZR2hvBfhwBX9fBFYYTCdg=aLrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

On 21-06-28 10:36:13, Dan Williams wrote:
> On Mon, Jun 28, 2021 at 3:12 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Jun 25, 2021 at 11:31:17PM +0000, Krzysztof Wilczy??ski wrote:
> > >       if (battr->mapping)
> > > -             of->file->f_mapping = battr->mapping;
> > > +             of->file->f_mapping = battr->mapping();
> >
> > I think get_mapping() is a better name now.  That being said this
> > whole programming model looks a little weird.
> 
> I think both those points are fair.

Anything for us to do?

> > Also, does this patch imply the mapping field of the sysfs bin
> > attributes wasn't used before at all?
> 
> It defaulted to an address_space per file rather than a shared address
> space across all files that map physical addresses as file offsets.

I will include this in the commit message for v3 of the patch series, if
you don't mind.  Also, would this shared address space be a potential
issue?  Security, functional, etc.

	Krzysztof
