Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4062964AC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369692AbgJVSad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 14:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2902394AbgJVSad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 14:30:33 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725852417D;
        Thu, 22 Oct 2020 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603391432;
        bh=Tfgw8a9yJa1Bptc6TRFHmxnsWQUQEFem9ZSdTO+hYPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i15iiJFXwJaHq5Q5+fNY4YQfC868Ug6sLHCxzv+DV5JLSATluG/lSXoAjc4EOrato
         u4gUKHmZPhmAsRP9JJua5WTKYsaH9SiPwptt0D6iwQKYaHQeJHHmfHEpte5dkBVMk1
         7xjnESjmteasZzCoqr4dxk4FhWyxsjc/BX7TMmfU=
Date:   Thu, 22 Oct 2020 13:30:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20201022183030.GA513862@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZuFi6OiyZTY6ZQS9mveAYvhWVf89RSqogxpVH5JKg_hOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 05:41:45PM +0200, Ian Kumlien wrote:
> On Thu, Oct 22, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sun, Oct 18, 2020 at 01:35:27PM +0200, Ian Kumlien wrote:
> > > On Sat, Oct 17, 2020 at 12:41 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > On Fri, Oct 16, 2020 at 11:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > > > > Can you please, please, collect these on your system, Ian?  I assume
> > > > > that you can easily collect it once without your patch, when you see
> > > > > poor I211 NIC performance but the system is otherwise working.  And
> > > > > you can collect it again *with* your patch.  Same Kconfig, same
> > > > > *everything* except adding your patch.
> > > >
> > > > Yeah I can do that, but I would like the changes output from the
> > > > latest patch suggestion
> > > > running on Kai-Heng's system so we can actually see what it does...
> > >
> > > Is:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=209725
> >
> > That's a great start.  Can you attach the patch to the bugzilla too,
> > please, so it is self-contained?
> >
> > And also the analysis of the path from Root Port to Endpoint, with the
> > exit latencies of each link, the acceptable latency of the endpoint
> > and
> >
> >   (1) the computation done by the existing code that results in
> >   "latency < acceptable" that means we can enable ASPM, and
> >
> >   (2) the correct computation per spec that results in
> >   "latency > acceptable" so we cannot enable ASPM?
> >
> > This analysis will be the core of the commit log, and the bugzilla
> > with lspci info is the supporting evidence.
> 
> Ok, will do, there will be some bio-latency though
> 
> Were you ok with the pr_cont output per endpoint?

Haven't looked at that yet.  Will respond to that patch when I do.
