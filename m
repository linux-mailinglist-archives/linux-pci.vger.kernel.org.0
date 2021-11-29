Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313AB4623AB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhK2Vtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 16:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhK2Vrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 16:47:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1860C091D29
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 12:07:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i12so18087030pfd.6
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 12:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJrp2+FzWwPNKC0TiiwoM0QJLZPs30y4vXdiwN3K1eI=;
        b=wdoaFhdkx5b4Neu0p1DGZnwHEG/SIHmDN4CJ50K6XljfDvdX6HT9b+3ejBMYtAFIe+
         Cc/FZi/wlBJPt1xD1hlZH5RPpWIxX0BEMPSs1iYlo9khwxd88IkPgKZBNRFQc4cxapau
         sMROcMOBmFgUhZBYwDAkiAcu81+wroFGj0+5P0ydawrb0/w0ofYqt/Xn8IKJqTS6oi0e
         mkHYZAtrpUSk/ZB7BXQvdHV64nvoJ2m2xDzYpZf+sPWCZSC8fjb9gjrw78wu3G2F2ATH
         II5RrZbQynVa3z4dmF8SHahuTA/VdqcOTp1QHnRyyk3D3NSI8xdmwlYdATKK0YeSPh6k
         Vh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJrp2+FzWwPNKC0TiiwoM0QJLZPs30y4vXdiwN3K1eI=;
        b=DXYGtt+ND47cGTwLby03ZfsFEhy5Xbvli4Lsx5r1AM0KCBoT7HZPl/2v7GsVLHOFwo
         Xz5qbkTIFftZcH/4ZudgrGBBSxpk5/kgcPMsJyjziPDXbvIgyKFrv8yY7UsnOsUA7Erj
         K/yY0lcvgN5zKhplP2E66PORBSymsS88IIjo4E3aAyiSWaBmQYuCiH/yJgCtMicve+ph
         sEmTEyGJnAFu0I1tXHSWNdaVVl73sMaeJzQV+BxWBOSdkivjwMSF962n9/IxP7WbfQ/p
         NErHfUaWrgxRFyAl+6BZTCcwk2uBuyTCMwIQr7Ux0AahNEsLEUQwP1wHDY2zJG+HrsRM
         Ht4w==
X-Gm-Message-State: AOAM531/X86VYPdvZZs3X51NZbU0O7U/kc20v/8waq62wpyS1Jw3I4Mn
        vvzUhWHi1pi4/DOjOe1WNy1lYdJ3XjdvHQVRvNmrzw==
X-Google-Smtp-Source: ABdhPJyvcANPg6SUDCV4oyzlP2Gi2CZUfp1yUKyo+IcaxZgUlJn3exxwQddmyi/EQqgweFk6HFgHF7pdNAs5KZiVOQQ=
X-Received: by 2002:a63:ef03:: with SMTP id u3mr25991020pgh.74.1638216425405;
 Mon, 29 Nov 2021 12:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-13-ben.widawsky@intel.com> <20211122162039.000022c1@Huawei.com>
 <20211122193751.gipqgs5ap24dacm3@intel.com> <CAPcyv4gBmc+C4d1RExH5qB2qunhkkMRqNZwzz29gc-1uaJiM4A@mail.gmail.com>
 <20211129200514.2o2zmjelfl3nahyt@intel.com>
In-Reply-To: <20211129200514.2o2zmjelfl3nahyt@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 12:07:00 -0800
Message-ID: <CAPcyv4gONHAxas+=LfJnQSOf+3gZPr6i+mJLV6NO8ODFGoVfJQ@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 12:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-24 16:07:23, Dan Williams wrote:
> > On Mon, Nov 22, 2021 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-11-22 16:20:39, Jonathan Cameron wrote:
> > > > On Fri, 19 Nov 2021 16:02:39 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > > Endpoints have decoders too. It is useful to share the same
> > > > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > > > targets), only the underlying physical medium. As a result, some special
> > > > > casing is needed.
> > > > >
> > > > > There is no functional change introduced yet as endpoints don't actually
> > > > > enumerate decoders yet.
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > >
> > > > I'm not a fan of special values like using 0 here to indicate endpoint
> > > > device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
> > > > and possibly wrappers for the non ep case and ep one.
> > > >
> > > > Jonathan
> > > >
> > >
> > > My inclination is the opposite. However, I think you and Dan both brought up
> > > something to this effect in the previous RFCs.
> > >
> > > Dan, do you have a preference here?
> >
> > I was thinking something along the lines of what Jonathan wants,
> > explicit per-type APIs, but internal / private to the core can use
> > heuristics like nr_targets == 0 == endpoint.
> >
> > So unexport cxl_decoder_alloc() and have separate:
> >
> > cxl_root_decoder_alloc()
> > cxl_switch_decoder_alloc()
> > cxl_endpoint_decoder_alloc()
> >
> > ...apis that use a static cxl_decoder_alloc() internally. Probably
> > also wants a cxl_endpoint_decoder_add() that drops the need to pass a
> > NULL @target_map.
>
> Would you a like a prep patch to set up the APIs first, or just do it all in
> one?

Prep patch to switch over the current usages to the new style before
introducing more helpers sounds good to me.
