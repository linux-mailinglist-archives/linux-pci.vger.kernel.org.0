Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6560A2961CF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506206AbgJVPl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504625AbgJVPl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 11:41:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE3DC0613CE
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 08:41:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ev17so1063543qvb.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFzuMhGwKMO/HNEyHVw0k27/Nr1jzF+rLeIGFdGk+vc=;
        b=qz3X7ZuuTEqOCs1ZZYy2/ocxgGZ5qMaycxdu/ELKhFmLG7fsU6KukMf8w2wOYRZFJb
         yUeGvucW1e7qRhUtd+TY+wc9UPb2Sva+Wjk++Bxv4hTw7zbrHxZ2dNzcveaQtsMbGxno
         XABHrnAuwZNDHuqhqpTlrHmcAonNx+oCZ8L9ovIUCwGkjEXz0+V6OwXUjMAfkFh74bcD
         3MwrtZmL08fWIv+mqJTtQ0jdbfCAexNpNkCeCGZuj8OVIe442gYgjjAFNyzQJnxD+Epq
         qYceyy/LhteAlK6n5B0yq/x9KM/m8jCVCuxyxYUNkX9DLJ4atQJd5Ls/7EUfKJ5b5pYU
         +cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFzuMhGwKMO/HNEyHVw0k27/Nr1jzF+rLeIGFdGk+vc=;
        b=bghKzQ0RkAqO9JvzURLNaZxhU+vV8F/iKznNK02L6wVoB2cFUxJKwg2f96d1bf5V2l
         SrhLBBx4ZDLVEG0cMDBwtQcBvq0ajsZe6CLl5OIyWj80sTrQwowITdynAGW8Gp6epvpg
         fXHzL2FHzq4OB+gBz+jg57cV8LKkpTi9Ua1OW2ft3IoxaZVJzYzL+6JZ1ExYFq/h8Yo4
         vppw1n0axCRL9jAKdtgx7CIgHdi+gzR7EyMNYBg/7afZKuVJs7zLm//iDL6T9ilSaRHK
         OkWZi1i66NNo2eE+cfho3QuHyis/96hExb5wVrpQOPTkvSyXPqOchINxZHbzbQCzLb+o
         Ns7g==
X-Gm-Message-State: AOAM5325mAkpDgcvBbzoiCS89n9Hx69mJROZs2o2OXNw3gw/Kc4fRhsx
        acZ4Ty1/J/HJJ3U4jL9M27+aszwcf+JGL4Tiv0I=
X-Google-Smtp-Source: ABdhPJyRHehJz7HoSQkuv0q1VzfFaGDDn/VsYDHsIJFPyr/GqnrRI90p8c8ZayyRPDTosM+8gIzDwH1kveV3H77qn+0=
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr2937567qve.25.1603381315904;
 Thu, 22 Oct 2020 08:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZufMEAieVgzxdPrbCzaPV0eM_NYX7idWkLVxQaJrYjC+A@mail.gmail.com>
 <20201022153750.GA503849@bjorn-Precision-5520>
In-Reply-To: <20201022153750.GA503849@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 22 Oct 2020 17:41:45 +0200
Message-ID: <CAA85sZuFi6OiyZTY6ZQS9mveAYvhWVf89RSqogxpVH5JKg_hOQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Oct 18, 2020 at 01:35:27PM +0200, Ian Kumlien wrote:
> > On Sat, Oct 17, 2020 at 12:41 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > On Fri, Oct 16, 2020 at 11:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > > > Can you please, please, collect these on your system, Ian?  I assume
> > > > that you can easily collect it once without your patch, when you see
> > > > poor I211 NIC performance but the system is otherwise working.  And
> > > > you can collect it again *with* your patch.  Same Kconfig, same
> > > > *everything* except adding your patch.
> > >
> > > Yeah I can do that, but I would like the changes output from the
> > > latest patch suggestion
> > > running on Kai-Heng's system so we can actually see what it does...
> >
> > Is:
> > https://bugzilla.kernel.org/show_bug.cgi?id=209725
>
> That's a great start.  Can you attach the patch to the bugzilla too,
> please, so it is self-contained?
>
> And also the analysis of the path from Root Port to Endpoint, with the
> exit latencies of each link, the acceptable latency of the endpoint
> and
>
>   (1) the computation done by the existing code that results in
>   "latency < acceptable" that means we can enable ASPM, and
>
>   (2) the correct computation per spec that results in
>   "latency > acceptable" so we cannot enable ASPM?
>
> This analysis will be the core of the commit log, and the bugzilla
> with lspci info is the supporting evidence.

Ok, will do, there will be some bio-latency though

Were you ok with the pr_cont output per endpoint?

> Bjorn
