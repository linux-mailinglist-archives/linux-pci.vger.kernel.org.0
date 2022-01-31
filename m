Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876DD4A5143
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 22:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379922AbiAaVRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 16:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiAaVRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 16:17:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D2C06173B
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 13:17:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v74so13994344pfc.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7XuXJP/rX0kWkOn9Ckb/Gm9uS3d6uyBTn+SoHAamLM=;
        b=TqjIjLoNlJZn8UCLcWZCfQoqo96gNlTSC2xK8UmAmUxzU56NbZ78LwQZBM6f7qST0I
         0iqt7jqK/GyJi3u56iCqtLC0jOiYhonMmbjLqgvr2hXO+gAP3214Phob1SFcluav9ejs
         tV+CMPvS/XXjowBh+48i7zit1T5ILlCTZU518BKql6EvnOpYoWWOIVuBs93PQZ4GaqHR
         yIZcrud+qWVEzBGpd3ZxXRanamEhLR+D9CPWOyqiytAIsIY4Sg4KShbnI5u4Zj7g42KH
         AdZY00InXULJ+xBzv5/c18qu2VfJdE8RUojRSrFxSFYdqsUqVQZavIMFw5VuAg638c+L
         Fn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7XuXJP/rX0kWkOn9Ckb/Gm9uS3d6uyBTn+SoHAamLM=;
        b=uVfjNgRyHOA5fCvwOK0oAP3OljM+x+vw639dynLn8ObvZL6WlzBlxKZZxb7Ec5uBWz
         4P4r738rVDvD7kjXc/yTxc1ll6gPMr4hSmbTP1FsBj8c+f7mU30/NT1jO67kE49C/0lJ
         iK5wO1QaqR42LyKMoX+2Olw2eIxO+yw2e+OkeJDnzv3a7u2vH915RDJ3Zpr1x3Q+8DWn
         wW8iPW7EN+E+93o/OXAqW9MzuTxvdIgwCf/xRRgCYPx8d9u9fR8QphkearXZLLd0dkSR
         BpnwGSyRl9ju8inWeUxV7tKs2b3cm6JbGo4l6P2s0wByvQXFPPzWPt41eZ0Nn00yZTES
         iOUg==
X-Gm-Message-State: AOAM530Q8LGOHjlHMJf5AVN5dyI8MgGxXzzQsb4E2vuGSRFQIpVL2uBH
        rnF/6zT0+hi3dx1n2cqzk9I3vU8VD3RdmRfB/D2qTA==
X-Google-Smtp-Source: ABdhPJzMI/XGOFgsfvEj7eBwG8ZCw0CRHOH4cHmwlfAo7N/ddODHk5cHwuo2Fv/0MufRqz+y8MOtYhYYJ3bbkx6DlIY=
X-Received: by 2002:a63:550f:: with SMTP id j15mr18013816pgb.40.1643663850030;
 Mon, 31 Jan 2022 13:17:30 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298417755.3018233.850001481653928773.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131144645.000005e1@Huawei.com>
In-Reply-To: <20220131144645.000005e1@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 13:17:22 -0800
Message-ID: <CAPcyv4jMNOM4CCjt5cP1-b5ufy-sHVwENqhRfFd268pbnariuQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/40] cxl/core/port: Clarify decoder creation
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 6:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:29:37 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Add wrappers for the creation of decoder objects at the root level and
> > switch level, and keep the core helper private to cxl/core/port.c. Root
> > decoders are static descriptors conveyed from platform firmware (e.g.
> > ACPI CFMWS). Switch decoders are CXL standard decoders enumerated via
> > the HDM decoder capability structure. The base address for the HDM
> > decoder capability structure may be conveyed either by PCIe or platform
> > firmware (ACPI CEDT.CHBS).
>
> The switch naming is a bit odd for host bridge decoders, but
> I can't immediately think of an alternative. Perhaps just call
> out that case in the relevant docs?

You mean the kdoc for cxl_switch_decoder_alloc()? I'll add a comment
along the lines of:

"'Switch' decoders are any decoders that can be enumerated by PCIe
topology and the HDM Decoder Capability. This includes the decoders
that sit between Switch Upstream Ports / Switch Downstream Ports and
Host Bridges / Root Ports."

>
> Probably a good idea to call out that this patch also adds some documentation
> to related functions alongside the changes mentioned above.
>
> A few minor comments inline.
>
> Jonathan
>
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: fixup changelog]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c      |    4 +-
> >  drivers/cxl/core/port.c |   78 ++++++++++++++++++++++++++++++++++++++++++-----
> >  drivers/cxl/cxl.h       |   10 +++++-
> >  3 files changed, 81 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index da70f1836db6..0b267eabb15e 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >       for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
> >               target_map[i] = cfmws->interleave_targets[i];
> >
> > -     cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
> > +     cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
> >       if (IS_ERR(cxld))
> >               return 0;
> >
> > @@ -260,7 +260,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >        * dport. Disable the range until the first CXL region is enumerated /
> >        * activated.
> >        */
> > -     cxld = cxl_decoder_alloc(port, 1);
> > +     cxld = cxl_switch_decoder_alloc(port, 1);
> >       if (IS_ERR(cxld))
> >               return PTR_ERR(cxld);
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 63c76cb2a2ec..2910c36a0e58 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -495,13 +495,26 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
> >       return rc;
> >  }
> >
> > -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > +/**
> > + * cxl_decoder_alloc - Allocate a new CXL decoder
> > + * @port: owning port of this decoder
> > + * @nr_targets: downstream targets accessible by this decoder. All upstream
> > + *           ports and root ports must have at least 1 target.
> > + *
> > + * A port should contain one or more decoders. Each of those decoders enable
> > + * some address space for CXL.mem utilization. A decoder is expected to be
> > + * configured by the caller before registering.
> > + *
> > + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> > + */
> > +static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > +                                          unsigned int nr_targets)
> >  {
> >       struct cxl_decoder *cxld;
> >       struct device *dev;
> >       int rc = 0;
> >
> > -     if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> > +     if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
> >               return ERR_PTR(-EINVAL);
> >
> >       cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > @@ -519,20 +532,69 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >       device_set_pm_not_required(dev);
> >       dev->parent = &port->dev;
> >       dev->bus = &cxl_bus_type;
> > -
> > -     /* root ports do not have a cxl_port_type parent */
> > -     if (port->dev.parent->type == &cxl_port_type)
> > -             dev->type = &cxl_decoder_switch_type;
> > +     if (is_cxl_root(port))
> > +             cxld->dev.type = &cxl_decoder_root_type;
> >       else
> > -             dev->type = &cxl_decoder_root_type;
> > +             cxld->dev.type = &cxl_decoder_switch_type;
> >
> >       return cxld;
> >  err:
> >       kfree(cxld);
> >       return ERR_PTR(rc);
> >  }
> > -EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
> >
> > +/**
> > + * cxl_root_decoder_alloc - Allocate a root level decoder
> > + * @port: owning CXL root port of this decoder
>
> root port is a bit confusing here given the other meanings of that in PCI.
> Perhaps port of CXL root or something else?

I'll add some verbiage defining CXL root independent of a PCIe Root Port.

>
> > + * @nr_targets: number of downstream targets. The number of downstream targets
> > + *           is determined with a platform specific mechanism.
> > + *
> > + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> > + */
> > +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > +                                        unsigned int nr_targets)
> > +{
> > +     if (!is_cxl_root(port))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     return cxl_decoder_alloc(port, nr_targets);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> > +
> > +/**
> > + * cxl_switch_decoder_alloc - Allocate a switch level decoder
> > + * @port: owning CXL switch port of this decoder
> > + * @nr_targets: number of downstream targets. The number of downstream targets
> > + *           is determined via CXL capability registers.
>
> Perhaps call out that it's the _maximum_ number of downstream targets?
> Whether all are used is I think a configuration choice.

Correct, I can clean up kdoc a bit.

> The accessible wording you use above gives the appropriate indication
> of flexibility.
>
> > + *
> > + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> > + */
> > +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > +                                          unsigned int nr_targets)
> > +{
> > +     if (is_cxl_root(port))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     return cxl_decoder_alloc(port, nr_targets);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> > +
> > +/**
>
> This new documentation is non trivial enough it should either be in a separate
> patch, or at least called out in the patch description.

Ok.

>
> > + * cxl_decoder_add - Add a decoder with targets
> > + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> > + * @target_map: A list of downstream ports that this decoder can direct memory
> > + *              traffic to. These numbers should correspond with the port number
> > + *              in the PCIe Link Capabilities structure.
> > + *
> > + * Certain types of decoders may not have any targets. The main example of this
> > + * is an endpoint device. A more awkward example is a hostbridge whose root
> > + * ports get hot added (technically possible, though unlikely).
> > + *
> > + * Context: Process context. Takes and releases the cxld's device lock.
> > + *
> > + * Return: Negative error code if the decoder wasn't properly configured; else
> > + *      returns 0.
> > + */
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> >  {
> >       struct cxl_port *port;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index bfd95acea66c..e60878ab4569 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -278,6 +278,11 @@ struct cxl_dport {
> >       struct list_head list;
> >  };
> >
> > +static inline bool is_cxl_root(struct cxl_port *port)
> This is non obvious enough to perhaps warrant an explanation
> of why this condition indicates a cxl_root.

Sure.

>
> > +{
> > +     return port->uport == port->dev.parent;
> > +}
> > +
> >  struct cxl_port *to_cxl_port(struct device *dev);
> >  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >                                  resource_size_t component_reg_phys,
> > @@ -288,7 +293,10 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> >
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> > -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> > +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > +                                        unsigned int nr_targets);
> > +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > +                                          unsigned int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> >
> >
>
