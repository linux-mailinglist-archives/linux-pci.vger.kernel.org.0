Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8045D180
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 01:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbhKYAKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 19:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhKYAKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 19:10:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE845C061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 16:07:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so6297132pjb.5
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I8hR1KxT4wL35Zv30bY7/ny/CJuScUrd2M5h9luPJc=;
        b=rQP9g8WcqcSUgu+wVJPZyaqA72pyJcjJdOPxk6lR282+Sce1iTiGDMO324f+MjUTgP
         S7HAp/v5nC9Uz4MYwgppClUs0doJraLsEWbcqDRPF2vXe9SMdfIQ20NoVC3MW+kdOlz1
         kgcFOcaQS62OuaoWM/HMsFtkmgF5T3Yj0UjXUUwKcpVVhKSYbgjgC00OdbLtkoFpm3jh
         3pfyeY2wfMPN3CAOn1VAVx3EQnCV3NFFAnu50tfEZAKSZsEdJXa3lbKGJQdXUN2iavCJ
         HLnE5U7xfzLU39pIeSzg6wqhU7wDQzd8BsfdDwDGtQIxRbU8ATkl5z8yXKIzAayv0bqQ
         GFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I8hR1KxT4wL35Zv30bY7/ny/CJuScUrd2M5h9luPJc=;
        b=LA7ZSekOxgedgOPMqX2tLsu2TTzQ+byq/FM3mLlu/aLhYDuNwjtrYQGxnM0+GKpdSr
         T8fCYoUJxdF9WFfvNnn8VgsfejZ0PQ+lvwydHlCLidcjs6DdY9YeHBVgzc55cEuI/q2k
         a2DAIPwou0L79DXF3SypYSUjhyqG0a2kh/HkoGUkM3j4RIpbTg/cWXNZXcEysUYY2o5e
         omV4qyceB3DRkoM5Gi89GEtUnaEsyQhtOMthzmnku9EHCdpUZa160ZCfz5MqRkDH9icc
         2xizLBLsC9VEwLNd7tMfuwnrUUd0W0vMlgENCtU0gvPdK++xNZvvclz0WCkZYTCBupBx
         E+qA==
X-Gm-Message-State: AOAM533h2b1XGdnJ8aIxo/b2XK7NyeT8QzDYe9jOhfBl/oQ06BzguEbo
        eXP/u1k92rE1rme7oT7IHSumfNw2pM2cOMK+39FSfQ==
X-Google-Smtp-Source: ABdhPJwIM1z+xHukqE41p1pECXF9iTVnQjwh+qZUXgG5v3RG+5vj3HBBsQUv9dCIIT0L/V7y+dATRLP6crENzk1EIYw=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr1473018pjb.220.1637798853373;
 Wed, 24 Nov 2021 16:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-13-ben.widawsky@intel.com> <20211122162039.000022c1@Huawei.com>
 <20211122193751.gipqgs5ap24dacm3@intel.com>
In-Reply-To: <20211122193751.gipqgs5ap24dacm3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 16:07:23 -0800
Message-ID: <CAPcyv4gBmc+C4d1RExH5qB2qunhkkMRqNZwzz29gc-1uaJiM4A@mail.gmail.com>
Subject: Re: [PATCH 12/23] cxl: Introduce endpoint decoders
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 22, 2021 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-22 16:20:39, Jonathan Cameron wrote:
> > On Fri, 19 Nov 2021 16:02:39 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > Endpoints have decoders too. It is useful to share the same
> > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > targets), only the underlying physical medium. As a result, some special
> > > casing is needed.
> > >
> > > There is no functional change introduced yet as endpoints don't actually
> > > enumerate decoders yet.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > I'm not a fan of special values like using 0 here to indicate endpoint
> > device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
> > and possibly wrappers for the non ep case and ep one.
> >
> > Jonathan
> >
>
> My inclination is the opposite. However, I think you and Dan both brought up
> something to this effect in the previous RFCs.
>
> Dan, do you have a preference here?

I was thinking something along the lines of what Jonathan wants,
explicit per-type APIs, but internal / private to the core can use
heuristics like nr_targets == 0 == endpoint.

So unexport cxl_decoder_alloc() and have separate:

cxl_root_decoder_alloc()
cxl_switch_decoder_alloc()
cxl_endpoint_decoder_alloc()

...apis that use a static cxl_decoder_alloc() internally. Probably
also wants a cxl_endpoint_decoder_add() that drops the need to pass a
NULL @target_map.
