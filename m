Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E12B3194
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKOAXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 19:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKOAXO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Nov 2020 19:23:14 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75CC0613D2
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2020 16:23:14 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id me8so19260262ejb.10
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2020 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDh65djbL3+0Re90HpQ5uGMlQP39/tC1wlxppwwaGTY=;
        b=zc3rdizNfrZHTpuFBKiOHjqOwj6YqI2lGQqq1CIM1svWbGLkuj/ogSOyy17y75VwVd
         L6cc3S/XVvEFZqqX4pdVY/cGrRQ+flMvXHh7oynk2Ie8/VBSbHKRG+ThVDKyqbaANL0k
         FQfx0sfijJHCliwLeja2xC/HTr8wnJi8CEeGZ1JLSnHpY5Z++1yiEZDbJoCKCQSQ6c37
         VWein7kr8k8BWh8IKbOK1OQs1YRg027F2crWu1EA/LCdCZWqd70sOZ0A+3Byul3gFs/E
         3jefRbgfwN/hymenfNMTypRKITs4C+ZP2tilUmsar59vknU4dfx7XK82wThhMsaLKtet
         gONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDh65djbL3+0Re90HpQ5uGMlQP39/tC1wlxppwwaGTY=;
        b=mh/dI5kKPSuzhmVdVsQUs582emTnSMP3GoqDlDJ471hXsOQ61yxY+pb3PmBWvWE/2p
         2M6CenNwfaKy5CZvblmgDpsqp4zdIB/Yc6OMskLkFxTMkIEzymi0dUgl6Ym5Ea4X+Kaw
         704kaRifOMer+KPHxMMlypYIgxpw72ofp7BLjn5TkguCWGzHzHEDY4+3OkxBZsRnGiRv
         WpY6g+qdIAI+k3wd6/7uujVSQxcK1vdN4ucuDReWdHbquf7+Xn9Pczu4BVOVD9e7GFfM
         HJd4nomv6XcFzcwT/o/79co9YnJ5GBK+DaGjSlCoEdiATezG/HbNz+bEKmjV/ryc0r/M
         Ohiw==
X-Gm-Message-State: AOAM530NbYOs9NFRN9ekLgSFB5JGyUdaMH9XFRIvoR+/QoygB5Lyb/kQ
        iLXZG5IDBS1PBosgyjEkPjVIbjcmub+ip/KF+lahmA==
X-Google-Smtp-Source: ABdhPJxu7z1ds+uPMjji3l7IMz1L0jCGl0EvxBCAcYszfLVIk8E4wu3dHa0UYb/r0y+qQAQvl39SnBZ7N8XVf4izdPU=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr8596908ejb.472.1605399792950;
 Sat, 14 Nov 2020 16:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-4-ben.widawsky@intel.com>
 <20201113181728.GA1119310@bjorn-Precision-5520> <20201114010857.t77h4h3ff7ythnml@intel.com>
In-Reply-To: <20201114010857.t77h4h3ff7ythnml@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 14 Nov 2020 16:23:04 -0800
Message-ID: <CAPcyv4g+27K-Amk_PhBvSx9+NnWTTP=yDHLdukK1AmK63X8Abw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13, 2020 at 5:09 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > Unused, maybe move it to the patch that adds the use?
> >
>
> This is a remnant from when Dan gave me the basis to do the mmio work. I agree
> it can be removed now.

Yes.

> > > +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > > +{
> > > +   int pos;
> > > +
> > > +   pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > > +   if (!pos)
> > > +           return 0;
> > > +
> > > +   while (pos) {
> > > +           u16 vendor, id;
> > > +
> > > +           pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > > +           pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > > +           if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > > +                   return pos;
> > > +
> > > +           pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> >
> > I assume we'll refactor and move this into the PCI core after we
> > resolve the several places this is needed.  When we do that, the
> > vendor would be passed in, so maybe we should do that here to make it
> > simpler to move this to the PCI core.
> >
>
> I think we'll need to keep this in order to try to keep the dream alive of
> loading a CXL kernel module on an older kernel. However, PCI code would benefit
> from having it (in an ideal world, it'd only be there).

So I think this is fine / expected to move standalone common code like
this to the PCI core. What I'm aiming to avoid with "the dream" Ben
references is unnecessary dependencies on core changes. CXL is large
enough that it will generate more backport pressure than ACPI NFIT /
LIBNVDIMM ever did. From a self interest perspective maximizing how
much of CXL can be enabled without core dependencies is a goal just to
lighten my own backport load. The internals of cxl_mem_dvsec() are
simple enough to backport.

>
> > > +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +   struct device *dev = &pdev->dev;
> > > +   struct cxl_mem *cxlm;
> > > +   int rc, regloc;
> > > +
> > > +   rc = cxl_bus_prepared(pdev);
> > > +   if (rc != 0) {
> > > +           dev_err(dev, "failed to acquire interface\n");
> >
> > Interesting naming: apparently when cxl_bus_prepared() returns a
> > non-zero ("true") value, it is actually *not* prepared?
> >
>
> This looks like a rebase fail to me, but I'll let Dan answer.

Yeah, I originally envisioned this as a ternary result with
-EPROBE_DEFER as a possible return value, but now that we've found a
way to handle CXL _OSC without colliding with legacy PCIE _OSC this
can indeed move to a boolean result.

Will fix up.

>
> > > +           return rc;
> > > +   }
> > > +
> > > +   regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > > +   if (!regloc) {
> > > +           dev_err(dev, "register location dvsec not found\n");
> > > +           return -ENXIO;
> > > +   }
> > > +
> > > +   cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> > > +   if (!cxlm)
> > > +           return -ENOMEM;
> >
> > Unused.  And [4/9] removes it before it's *ever* used :)
> >
>
> Same as a few above, I think Dan was providing this for me to implement the
> reset. It could go away...

Yes, a collaboration artifact that we can clean up.

>
> > > +   return 0;
> > > +}
> > > +
> > > +static void cxl_mem_remove(struct pci_dev *pdev)
> > > +{
> > > +}
> > > +
> > > +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > > +   /* PCI class code for CXL.mem Type-3 Devices */
> > > +   { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > +     PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
> > > +   { /* terminate list */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> > > +
> > > +static struct pci_driver cxl_mem_driver = {
> > > +   .name                   = KBUILD_MODNAME,
> > > +   .id_table               = cxl_mem_pci_tbl,
> > > +   .probe                  = cxl_mem_probe,
> > > +   .remove                 = cxl_mem_remove,
> > > +};
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_AUTHOR("Intel Corporation");
> > > +module_pci_driver(cxl_mem_driver);
> > > +MODULE_IMPORT_NS(CXL);
> > > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > > new file mode 100644
> > > index 000000000000..beb03921e6da
> > > --- /dev/null
> >
> > > +++ b/drivers/cxl/pci.h
> > > @@ -0,0 +1,15 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> >
> > /* SPDX-... */
> > /* Copyright ...*/
> >
> > The SPDX rules are a bit arcane and annoyingly hard to grep for, but
> > I found them in Documentation/process/license-rules.rst

Yes, I did not realize the header vs source /* */ vs // SPDX style.

> >
> > > +#ifndef __CXL_PCI_H__
> > > +#define __CXL_PCI_H__
> > > +
> > > +#define PCI_CLASS_MEMORY_CXL       0x050210
> > > +
> > > +#define PCI_EXT_CAP_ID_DVSEC       0x23
> > > +#define PCI_DVSEC_VENDOR_CXL       0x1E98
> > > +#define PCI_DVSEC_VENDOR_OFFSET    0x4
> > > +#define PCI_DVSEC_ID_OFFSET        0x8
> > > +#define PCI_DVSEC_ID_CXL   0x0
> > > +#define PCI_DVSEC_ID_CXL_REGLOC    0x8
> >
> > I assume these will go in include/linux/pci_ids.h (PCI_CLASS_...) and
> > include/uapi/linux/pci_regs.h (the rest) eventually, after we get the
> > merge issues sorted out.  But if they're only used in cxl/mem.c, I'd
> > put them there for now.

Yes, I assume they'll move eventually. I'm cheating a standalone
backport driver organization in the meantime.
