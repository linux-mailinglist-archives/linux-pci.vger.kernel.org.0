Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7C4A9B82
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbiBDOy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiBDOy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:54:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3928C06173D
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:54:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x15-20020a17090a6b4f00b001b8778c9183so368698pjl.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAzGX2KRF3xTv3jELkNUUo9hmDUDOEqLvI+SzwJPEUk=;
        b=griiqNV/EpySOJADrjSZGVBCvHIfo8JtMRKTCD2Fbi6SX+VDfMUHxtL9dC9G2u80mM
         cfSVMJ/7Wjk++keAgFDd0AMK/A1caKcmpJsp0Lc6hBdqT3Ie71O2+xBFdOA/Tc9HZ3Mm
         C/966ddr0venVBJBmbBQ/vmp/N7gGQJ/viatTp0yRqBOtonxP04xfJzih2KGEKRnB03c
         t14YFpij1YCMY52PNCpwTt2t834y8c+OTYFsz15F+T2DFc9PfXqhndtnwlAt7KqfNAYM
         CCHRwivmqE6eBq3v1/XxNV5wU2cjkLFbyb6V+iwSnbWOAncHtitZfzhhsK/4ualIFW8R
         CIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAzGX2KRF3xTv3jELkNUUo9hmDUDOEqLvI+SzwJPEUk=;
        b=TYILim7yNE+RTAgg6NqLsyLL52Rt127LzJMPHNCUYTEIbGVjKpm1usvhsKar+SkC2Y
         eKE5NVTrHpjkArVRkPAZd3sznkKK/Q6T1JarOcZn0SVzt0RPakfRPmrcdq2U2f0xM5af
         zhDx7AxjtBf216S7i73STgyY2IsHNyhnhqTYNAxW6iHNB7z7euJ1CxZ66CkfDJrcPQPP
         kghP1QMs720XJvsBioSBVlo27ddV5hGl8vMnV02LC99sqbKZppiXLwWtDj7PfC60N09N
         4qIVh0GGIjqEinh4rsSvZ21uBL+Jt+/LpCU0IkxmwLdsBX5NbnbRNiwn896rtkeN9GPg
         4OGQ==
X-Gm-Message-State: AOAM532CWeeYd7iD96FIUmCdUUf8GtoLI6e6JUrRRoHURo9XJ6PiKZMJ
        /dWsjkM4gZJyuZaM5H9zm2rSy9zfhRSahMXA1zUnAQ==
X-Google-Smtp-Source: ABdhPJxqz8hHiR92IvNiFO0gzB7syV6xa+eUIXWjFCOucavErfp5yrYtVvMBzd1i5JI0hU5YBLO2w6ngWkbj0kD1iTk=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr3648499ply.34.1643986463432;
 Fri, 04 Feb 2022 06:54:23 -0800 (PST)
MIME-Version: 1.0
References: <164298429450.3018233.13269591903486669825.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316691403.3437657.5374419213236572727.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201124506.000031e2@Huawei.com> <CAPcyv4jBs4DXGUE0rtyhp2WG2pU45zBv1zGJuLjMfyAKGmfVyw@mail.gmail.com>
 <20220203095959.000078f1@Huawei.com>
In-Reply-To: <20220203095959.000078f1@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 06:54:12 -0800
Message-ID: <CAPcyv4gqOAMPSHdG2pzXCUFPu0Wd9XNJsF1_mtGkr8rFKK2SHg@mail.gmail.com>
Subject: Re: [PATCH v4 33/40] cxl/mem: Add the cxl_mem driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 3, 2022 at 2:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Hi Dan,
>
> > > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > > index b71d40b68ccd..0bbe394f2f26 100644
> > > > --- a/drivers/cxl/cxl.h
> > > > +++ b/drivers/cxl/cxl.h
> > > > @@ -323,6 +323,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> > > >  struct cxl_port *find_cxl_root(struct device *dev);
> > > >  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
> > > >  int cxl_bus_rescan(void);
> > > > +struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
> > >
> > > Should be in previous patch where the function is defined.
> >
> > Not really, because this patch is the first time it is used outside of
> > core/port.c. I would say convert the previous patch to make it static,
> > and move the export into this patch, but I'm also tempted to leave
> > well enough alone here unless there some additional reason to respin
> > patch 32.
>
> I hadn't read this when I sent reply to previous patch v4.  Up to you on
> whether you tidy up or not.  Though I'm fairly sure you'll get
> a missing static warning if you build previous patch without a header definition.
> Agreed adding static then removing it again would be an option, but
> meh, too much noise...  The one going the other way (defining a function
> before it exists) is probably more important to fix.

There's no warning about declaring a function that is never defined,
but that's egregious enough to go fixup.
