Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312814A560D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 06:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiBAFKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 00:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiBAFKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 00:10:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990BC061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 21:10:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o64so16049943pjo.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 21:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zERJMJPBpohrP2OBXDhHeMNlTlvak+q9cq9xkLiq8cs=;
        b=Q7p0+fZRtjBpmrqg7yoZiXmzq7FfO/5CVGMmaEQ5y8m6HF3302/Bd+d2ezzYvoGXuR
         CBdblKqJYmZvq82bremm7D+yQollQTFy1CyBJyRHUDuRRdC0/b9Rj3XNq9CroLQsCxME
         iMjtFcH7qSGLdZpegl28C/TTqK51dl0/2sGnLoW73SUWv67kX7swbmPmJ03YBkT+WRkC
         vcak5hTYwmULKKR/lUGV5Dc3HtwALjt7B4BaHLqPyPZD6jGUXvvmXVOfcw5hTtnBaNnu
         pbokaUO7NTdW5UjTaxVygugmb1Q1koSJ9Ds6ks6yrfkhexM7LPXZJCbmHeu3vNRJ4o/o
         17LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zERJMJPBpohrP2OBXDhHeMNlTlvak+q9cq9xkLiq8cs=;
        b=RiqJ+FLpcaQ5lXFtIdeZJrKhHV66uS4/7lV4yPqcGonAe7cJOZ5WXSuMIuToAjnLFP
         p9tOZDJJQ8/05ufftZ7bPR2qHPX0eXK7EDE29MlBmi5NWkkVo6t6v9EMZK8UGfoYSN4Q
         N27MLnKkCYp4Q7dvpsbMzEoh1SogX+eKFv+k3mNd/EEirFdyLOkMnCGfTl7OKIbSYoqk
         nsboHpfghwxLhHnRPcPh4P5GGISK42ty04USY7C05Ga+92hqZ97WcmNisDjWYHXqe1RT
         QJgmvPDvuOCenKehaJoETXm25WWteuglhX/BSDfB5J+w7qp1UwPFrv7HwPg/JFy+IUXm
         yr+Q==
X-Gm-Message-State: AOAM532WLrGSCooulZzIjccBwDTfPzA07jfa9eT1yPd1k8TTMBAT5Ybq
        mWoU+PlhuJG2QJv2ftDa0ObgkkC70EVNvTaihOTzg1W4ZFsIZw==
X-Google-Smtp-Source: ABdhPJxgY6Cc29jss7BazwLtJXT9yMAR83l9do4jRuSf73vp02djQpT6psSdBHq5yiTwZhKqmfbeb3s9NJU9RKL7ef0=
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr24503898pll.147.1643692245630;
 Mon, 31 Jan 2022 21:10:45 -0800 (PST)
MIME-Version: 1.0
References: <164298423561.3018233.8938479363856921038.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131175159.00006d3d@Huawei.com>
In-Reply-To: <20220131175159.00006d3d@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 21:10:38 -0800
Message-ID: <CAPcyv4gxeKEq93h1dC7noRPANnQRxT0xAgpJyR9ecJWLb-hewQ@mail.gmail.com>
Subject: Re: [PATCH v4 22/40] cxl/core/hdm: Add CXL standard decoder
 enumeration to the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 9:52 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 25 Jan 2022 19:09:25 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Unlike the decoder enumeration for "root decoders" described by platform
> > firmware, standard coders can be enumerated from the component registers
> > space once the base address has been identified (via PCI, ACPI, or
> > another mechanism).
> >
> > Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
> > enumeration and share it between host-bridge, upstream switch port, and
> > cxl_test defined decoders.
> >
> > The locking model for switch level decoders is to hold the port lock
> > over the enumeration. This facilitates moving the dport and decoder
> > enumeration to a 'port' driver. For now, the only enumerator of decoder
> > resources is the cxl_acpi root driver.
> >
> > [ben: fixup kdoc]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Mostly looks nice.  A couple of queries inline.
>
> Jonathan
>
> > ---
> > Changes since v3:
> > - Fixup kdoc for devm_cxl_enumerate_decoders() (Ben)
> > - Cleanup a sparse warning around __iomem usage (Ben)
> >
> >  drivers/cxl/acpi.c            |   43 ++-----
> >  drivers/cxl/core/Makefile     |    1
> >  drivers/cxl/core/core.h       |    2
> >  drivers/cxl/core/hdm.c        |  248 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c       |   57 +++++++--
> >  drivers/cxl/core/regs.c       |    5 -
> >  drivers/cxl/cxl.h             |   33 ++++-
> >  drivers/cxl/cxlmem.h          |    8 +
> >  tools/testing/cxl/Kbuild      |    4 +
> >  tools/testing/cxl/test/cxl.c  |   29 +++++
> >  tools/testing/cxl/test/mock.c |   50 ++++++++
> >  tools/testing/cxl/test/mock.h |    3
> >  12 files changed, 434 insertions(+), 49 deletions(-)
> >  create mode 100644 drivers/cxl/core/hdm.c
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 259441245687..8c2ced91518b 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -168,10 +168,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       struct device *host = root_port->dev.parent;
> >       struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> >       struct acpi_pci_root *pci_root;
> > -     int single_port_map[1], rc;
> > -     struct cxl_decoder *cxld;
> >       struct cxl_dport *dport;
> > +     struct cxl_hdm *cxlhdm;
> >       struct cxl_port *port;
> > +     int rc;
> >
> >       if (!bridge)
> >               return 0;
> > @@ -200,37 +200,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       rc = devm_cxl_port_enumerate_dports(host, port);
> >       if (rc < 0)
> >               return rc;
> > -     if (rc > 1)
> > -             return 0;
> > -
> > -     /* TODO: Scan CHBCR for HDM Decoder resources */
> > -
> > -     /*
> > -      * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> > -      * Structure) single ported host-bridges need not publish a decoder
> > -      * capability when a passthrough decode can be assumed, i.e. all
> > -      * transactions that the uport sees are claimed and passed to the single
> > -      * dport. Disable the range until the first CXL region is enumerated /
> > -      * activated.
> > -      */
> > -     cxld = cxl_switch_decoder_alloc(port, 1);
> > -     if (IS_ERR(cxld))
> > -             return PTR_ERR(cxld);
> > -
> >       cxl_device_lock(&port->dev);
> > -     dport = list_first_entry(&port->dports, typeof(*dport), list);
> > -     cxl_device_unlock(&port->dev);
> > +     if (rc == 1) {
> > +             rc = devm_cxl_add_passthrough_decoder(host, port);
> > +             goto out;
> > +     }
> >
> > -     single_port_map[0] = dport->port_id;
> > +     cxlhdm = devm_cxl_setup_hdm(host, port);
> > +     if (IS_ERR(cxlhdm)) {
> > +             rc = PTR_ERR(cxlhdm);
> > +             goto out;
> > +     }
> >
> > -     rc = cxl_decoder_add(cxld, single_port_map);
> > +     rc = devm_cxl_enumerate_decoders(host, cxlhdm);
> >       if (rc)
> > -             put_device(&cxld->dev);
> > -     else
> > -             rc = cxl_decoder_autoremove(host, cxld);
> > +             dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
> >
> > -     if (rc == 0)
> > -             dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
> > +out:
> > +     cxl_device_unlock(&port->dev);
> >       return rc;
> >  }
> >
>
> ...
>
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > new file mode 100644
> > index 000000000000..fd9782269c56
> > --- /dev/null
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -0,0 +1,248 @@
>
>
> ...
>
> > +
> > +static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> > +                                       void __iomem *crb)
> > +{
> > +     struct cxl_register_map map;
> > +     struct cxl_component_reg_map *comp_map = &map.component_map;
>
> Why can't we use a cxl_register_map directly in here?
> Doesn't seem to make use of the containing structure.

Yeah, I don't see a reason for cxl_register_map to be used here since
that was built for cxl_find_regblock(). The cxl_find_regblock() work
was already done.

>
> > +
> > +     cxl_probe_component_regs(&port->dev, crb, comp_map);
> > +     if (!comp_map->hdm_decoder.valid) {
> > +             dev_err(&port->dev, "HDM decoder registers invalid\n");
> > +             return IOMEM_ERR_PTR(-ENXIO);
> > +     }
> > +
> > +     return crb + comp_map->hdm_decoder.offset;
> > +}
> > +
> > +/**
> > + * devm_cxl_setup_hdm - map HDM decoder component registers
> > + * @port: cxl_port to map
> > + */
> > +struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)
>
> Mentioned this in earlier reply, but good to keep docs in sync with
> code even if going to change it shortly.

Yeah, I meant to fix that up, looks like I didn't commit the hunk on the resend.
