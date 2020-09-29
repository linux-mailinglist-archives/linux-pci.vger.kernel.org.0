Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F7527B91F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 02:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgI2AzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgI2AzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 20:55:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D32C061755;
        Mon, 28 Sep 2020 17:55:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so3095314iol.10;
        Mon, 28 Sep 2020 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGTY5JlYWG9z0D7/RuLNr1T5K1KEPAuumqJ9jOnxLyw=;
        b=fqfX70p6n23/qMu34NxN9mlOSgogomSvdKf6fhh0zrS/y3WgqeKSOW7/unUCQhgsRK
         5vUjqKJeV/P70GeLH0wEXCqLyJH4PhJAT9kL83lGffQsKp/+EsSi1OMcAfmKByUKyVAb
         DTZ9ClinCQeMew1q726Fo7S8MIqdGXCiL9mtVqy/w05ENkImu6DgaOrYDNpXCHtWixFK
         NeU8xTwygywPahfeHfFiwRTWeWQmPUBi/FBEPtYruIjq3kXd7dXmvbNp+y2juxqp85K9
         KjxdaZIEfJW2g6fAg3Byrr2TdLFTxjD08vKI7rKPFSKeKDPKr/fH3edzBaEbrRdi4Jx2
         Eybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGTY5JlYWG9z0D7/RuLNr1T5K1KEPAuumqJ9jOnxLyw=;
        b=DqN3jzzfDK7o2SS5W4c/yjT/O8TOyA+pF3SskO0cAmSJmyHCCytWwyx9AZHEChB7ZZ
         CMQuYrzJUhUoY2Zd6m7FarOp5AJe/R0+KC+Dd5SOCIBVSHUKIpqQOfMsJyS6u4fMzDqv
         VVGKWJkKa2moPx6Cs9DbT9pLLy4xmX1FM7kZ04w7LF3U6Ufy0V6Y6KUgcVUIvDXAIuX7
         fxCElokw7VuFjp2mJ/sxkffH0Wb8bkN/QGzbclQ3PIQCY1FdQfbh7yRqfCwgay7ayC3p
         7jzoDoprNc3DQ9VwoZvRypnJOVueBirLcasrGD2X9QpnOI9EQ3ZZqR8+HyCOSLcvaTW/
         wfLg==
X-Gm-Message-State: AOAM5329x7NsE/BymVIkTBz7DA2Bf6VaxtKZ21I4lW1CSCcb+DqSuFPW
        2d0QH9qqv6gTp07lj6JNaV8xCdtEKnWhU3kGIQ4=
X-Google-Smtp-Source: ABdhPJzksqe6Wln9YBjx1ZvlFsWD4eV85ZoBEjjk7OOVTIcOb7Mo4sErIAc3CG+izUMAzwtHugSF7aZoX1oy2aKg89E=
X-Received: by 2002:a02:6623:: with SMTP id k35mr1004403jac.105.1601340922396;
 Mon, 28 Sep 2020 17:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200924051343.16052.9571.stgit@localhost.localdomain>
 <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com> <ff6a8c97-4a6a-c82b-bd35-e09fa44f8e20@linux.ibm.com>
In-Reply-To: <ff6a8c97-4a6a-c82b-bd35-e09fa44f8e20@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 29 Sep 2020 10:55:11 +1000
Message-ID: <CAOSf1CHdOk1guuST8T5t1A9O=xkbeFiJ9uZXgHeBBjeLKZ5O4g@mail.gmail.com>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel modules
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 6:50 AM Tyrel Datwyler <tyreld@linux.ibm.com> wrote:
>
> On 9/23/20 11:41 PM, Oliver O'Halloran wrote:
> > On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
> > <mamatha4@linux.vnet.ibm.com> wrote:
> >>
> >> This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> >> (descriptions taken from Kconfig file)
> >>
> >> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> >> ---
> >>  drivers/pci/hotplug/rpadlpar_core.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> >> index f979b70..bac65ed 100644
> >> --- a/drivers/pci/hotplug/rpadlpar_core.c
> >> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> >> @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
> >>  module_init(rpadlpar_io_init);
> >>  module_exit(rpadlpar_io_exit);
> >>  MODULE_LICENSE("GPL");
> >> +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");
> >
> > RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
> > this already?
>
> I seem to recall Michael and I discussed the naming briefly when I added the
> maintainer entries for the drivers and that the PAPR acronym is almost as
> meaningless to most as the original RPA. While, IBM no longer uses the term
> pseries for Power hardware marketing it is the defacto platform identifier in
> the Linux kernel tree for what we would call PAPR compliant. All in all I have
> no problem with renaming, but maybe we should consider pseries_dlpar or even
> simpler ibmdlpar.

I'm not too bothered by what we call it so long as it's consistent
with *something* else in the tree. Using pseries rather than ibm as a
prefix would probably be better since the legacy ibmphp driver is in
the same directory.
