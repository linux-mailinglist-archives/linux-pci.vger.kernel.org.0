Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746954BE92
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfFSQqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:46:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40351 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSQqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:46:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so19020989otl.7
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAeca+NaeasgKg8wLjwxe/d8KFhZwiNtk4NpQn2oH10=;
        b=eEIpXOcPgh/FQm8AcRovuq2bVonIAGIxG4O8hqog+t2sNo8lmrfYIpq/+3PFypMTty
         siI4svCj0XFFk8DvueW2Zz7Zvoia5aS+WjHA2V9kjitsGk2Dr7OrDOGRxd+jgBEHrThr
         EHGL3vlgHvvthlk8Gfj633B1vbDSWX+nCllo+CoYhKFeZWAJNLlFWMmdziVMMg2G+cne
         9LkPYCnW/ZVKV1OTMMtvp9jixEL4J8gu4orI34DCJ30mCCAblY3ezSDjxZuDDDsPUqbB
         ZHR6EtInNGpbX74S1TmPO0TGeYVW9GToDYCY1yWZmGb6+1NQToWu8/vN0HJQG43y5Q4m
         K3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAeca+NaeasgKg8wLjwxe/d8KFhZwiNtk4NpQn2oH10=;
        b=ZSe7We/olFm3G9R2sy2b3Oe4RttBAiLOf5cKIC3bv+XuLb0BtO4oaxq/8J/XWCE9Jo
         Pl7TbiY3EW//M+saDWYc1mhc+F12yAGT3M/PZrthoxn3uY+6n21L89V50xQ2hiKj1Fs2
         0Xk7RCUr5UCbyGLSBK0sTSjO9jBAqLZcUlIUxyMSH4v367s8PeVw0vFU8Gb76EhSA+Tz
         inojlvnjKOM6pC5yXZoDZWgsYiIg80mYwyv0qtTWpmz6Nob2OOkhOdRSDSmXu0c0FjbT
         U0WnA/jBMiq3Eo65s75VxhCgWprd6boQ8OPJMhEXT+Upg/bhpkPz0SaopwZ+zfMFxXN9
         i/+g==
X-Gm-Message-State: APjAAAVU+qV2t2GtCy4t0+722eBOW6XMkO0H7JVZ67b+MzELdbKXwXcO
        Y0ZVHomlV19+qjD8Rrt4JZ9irAFrIrwrRJAFGB9Kiw==
X-Google-Smtp-Source: APXvYqxu7jzERtujGtRB1JUPTrrSRxaJnnRx7A59gFxSd7DNSrReLEw7sHQTmTBvokQEtVRT1Qlvl4tg5ll4Z2fBIRs=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9700022oto.207.1560962794186;
 Wed, 19 Jun 2019 09:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
 <20190619094032.GA8928@lst.de> <20190619163655.GG9360@ziepe.ca>
In-Reply-To: <20190619163655.GG9360@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Jun 2019 09:46:23 -0700
Message-ID: <CAPcyv4hYtQdg0DTYjrJxCNXNjadBSWQ5QaMJYsA-QSribKuwrQ@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups v2
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 9:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 19, 2019 at 11:40:32AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 18, 2019 at 12:47:10PM -0700, Dan Williams wrote:
> > > > Git tree:
> > > >
> > > >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2
> > > >
> > > > Gitweb:
> > > >
> > > >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2
> >
> > >
> > > Attached is my incremental fixups on top of this series, with those
> > > integrated you can add:
> >
> > I've folded your incremental bits in and pushed out a new
> > hmm-devmem-cleanup.3 to the repo above.  Let me know if I didn't mess
> > up anything else.  I'll wait for a few more comments and Jason's
> > planned rebase of the hmm branch before reposting.
>
> I said I wouldn't rebase the hmm.git (as it needs to go to DRM, AMD
> and RDMA git trees)..
>
> Instead I will merge v5.2-rc5 to the tree before applying this series.
>
> I've understood this to be Linus's prefered workflow.
>
> So, please send the next iteration of this against either
> plainv5.2-rc5 or v5.2-rc5 merged with hmm.git and I'll sort it out.

Just make sure that when you backmerge v5.2-rc5 you have a clear
reason in the merge commit message about why you needed to do it.
While needless rebasing is top of the pet peeve list, second place, as
I found out, is mystery merges without explanations.
