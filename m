Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C733343965E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhJYMeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhJYMeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 08:34:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4021C061745
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 05:31:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c28so8023882lfv.13
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsXzxcxV0y5xMwXg4e7QntuXuk695o/R/LGfdUxufpA=;
        b=UclQCWoAv/aInb3BX+pcCYm0XwoRRLg80Fem/NVkw+y0qjEEcpB76FpBdjTp8vuK1l
         z50Yeu6KoK2B/7LVypXChh0LkNiwjKjm3orMDx5yOABtMiwwjkYs3NEIx7h3KxkjdDdP
         Ek7NLHytlcCgWuz6xBQYu3Q403aKF7vQuGLXhTVh6z0Pzvn+JGXltleEp250t38JzH5j
         s4EPzZTZxzd/l83xcwuR+WVOPek9mSUTXQbRelreN6AZqWyrHC3KmxczQUZfWae9+KEL
         vTq70uNd/ShSO42sqqkPdHucUQN/mJWzpyYYCytxFaJSHRB87w0ZDUWAzYEf5GEHdsqO
         ar2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsXzxcxV0y5xMwXg4e7QntuXuk695o/R/LGfdUxufpA=;
        b=DYztUS13UhZqFPTftnxc07Q1ipgjhiva1FyWSac5vwZBP+ibPyWGa+dmhXeRYV7HxA
         2hEHvoVMSt2XPWFHDPZ8/HYQSQ18UnjF4egef9cKPGJghD7DjGWYiSWKy3m4axGEz525
         4UIG0rJem72OFx90Oj1awCAjZOQppqc2/091GUmk5UYO3zQNd0yqOEl9+/h7faSZTkTQ
         BNCCx+TjF6X1sS0b2AN7geTt/V2iZarylr580rAzVC1SDqI5+wN+BlDjMgfVNxWxJORF
         Eiu+qRgcMQcY4hsx42sE44sQ2Xh0u/0eeF5rThSx0qaS2H5vFO2FD2vuIcqb3PYGTtpI
         wu5Q==
X-Gm-Message-State: AOAM533/d/zOjMiyrwJXFx4aEtfGAyqKdsDfsuIBRlVm92iyQe/ZpJtT
        agdnKn6vZAh1JgO+gMMelywd36jtLpSmwp2Jpcs=
X-Google-Smtp-Source: ABdhPJzmw7j45jN5rCnXFGhqUnslOEjOY9G+jsrw/HmHox7WH0FH5oHXmcXWmHzJplbhYRjkRg+VGMR9MuRvpdL6/j4=
X-Received: by 2002:a19:7903:: with SMTP id u3mr15963739lfc.406.1635165113269;
 Mon, 25 Oct 2021 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
In-Reply-To: <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 25 Oct 2021 08:31:41 -0400
Message-ID: <CAKf6xpvkF55U7Zrtx4PK=tqT8fjdmY-kZSm3WJO1gAnutnum-A@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Josef Johansson <josef@oderland.se>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 3:44 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Sun, 2021-10-24 at 21:25 -0400, Jason Andryuk wrote:
> > commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
> > functions") introduce functions pci_msi_update_mask() and
> > pci_msix_write_vector_ctrl() that is missing checks for
> > pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
> > new mask/unmask functions").  The checks are in place at the high level
> > __pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
> > directly to the helpers.
> >
> > Push the pci_msi_ignore_mask check down to the functions that make
> > the actual writes.  This keeps the logic local to the writes that need
> > to be bypassed.
> >
> > With Xen PV, the hypervisor is responsible for masking and unmasking the
> > interrupts, which pci_msi_ignore_mask is used to indicate.
>
> This isn't just for Xen PV; Xen HVM guests let Xen unmask the MSI for
> them too.

Ah, that makes sense that Xen handles both.  I was repeating another
commit message's statement.  Oh, it looks like pci_msi_ignore_mask is
PV-specific.

Regards,
Jason
