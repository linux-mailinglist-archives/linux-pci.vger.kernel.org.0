Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5D35EA10
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhDNAkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 20:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348213AbhDNAkn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 20:40:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60963C06175F
        for <linux-pci@vger.kernel.org>; Tue, 13 Apr 2021 17:40:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r9so28732186ejj.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Apr 2021 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dgx0zg/uwSfJAIpLe+lA7Jwh4OGdZHvPB/sLQQcgrjw=;
        b=R6XABSlNkDS6hYye7g2llZd1hYxrne9xBJPTNCVDoBtSjuqR0OK83afzV2GazGIIU6
         MluZRXzIpm827Lu6Dn4DKZEEPR/jCANNyPe0iT9+Vq6f94GfkqQvEi11uzypnOmxo9yP
         lbXWJt3b7cToel8jDlh3aNIfJnnIA3vFIArAOi1eSYL6lQZUDDq4MAC/trPWxlV49jUa
         DIZXsiA2F2I+EhfoumUq5JN1oys0VHr4J3zQfV0Q56pZ/F2FHkeYhVZ1/h/M6kKQ/s3M
         h6ILG+A+WTfg4hEEQA4kv4KnLbgmiEOhOHJnCt/AkE1s0Z87HZCY+sXtgPWrgBNIsZwO
         fK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dgx0zg/uwSfJAIpLe+lA7Jwh4OGdZHvPB/sLQQcgrjw=;
        b=OlgTshY1JAN66yg6uJZantvDvsOGer9LE48/qPlD2LlXMZcc6Ra4bbOFl5o1ZasvDT
         UH7D0BFj7vKtD47vTWqEmtbsEPn6S2ScyCgSOST+LJhG/smC109RebxC6kbVlwsgDolT
         MQNSZYXwA2bLmy3ZMoJO0mEwV4MVThBgflyXhmvZ/Br/TysPIHGmCGuEnrsSVB4KrN+J
         54GxVG/1VCuhIj3zcngpEU0LIzfUZtfN02Wj8NK/T1WiuMPytFRfu3bF6cQa3lY7vHvF
         8HsFVXKNW36KOuJNBkiGlAijUZQ1yw1mB5wTYaudAUxVY2APQ38WwMP6xk+2sc7uI2wJ
         sqBg==
X-Gm-Message-State: AOAM532BJvLi2FjZdrvQVZP/TgiA6qNDacVslviXgz2wnMFYMzDSPpi8
        8oZ16lU9tVLvknWcNjjj7pIpWXpfGUs2uWh4iDMe5g==
X-Google-Smtp-Source: ABdhPJxDntJqAjA21gPsoO6ArpWTc7tn3MSadgeJ586Ft88PaPvpOxexWca17ZT6xuXU3Dw1cpOBOSBP7RpLnLzSD3g=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr9626142ejc.418.1618360820549;
 Tue, 13 Apr 2021 17:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728745324.2474040.14172040051810008737.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406180037.00000474@Huawei.com>
In-Reply-To: <20210406180037.00000474@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Apr 2021 17:40:16 -0700
Message-ID: <CAPcyv4gJx+xt0sirQ3LUz2nJ_6ybek7EzL0E9QkjdYZwqN2vzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Introduce 'struct cxl_regs' for
 "composable" CXL devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 1 Apr 2021 07:30:53 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > CXL MMIO register blocks are organized by device type and capabilities.
> > There are Component registers, Device registers (yes, an ambiguous
> > name), and Memory Device registers (a specific extension of Device
> > registers).
> >
> > It is possible for a given device instance (endpoint or port) to
> > implement register sets from multiple of the above categories.
> >
> > The driver code that enumerates and maps the registers is type specific
> > so it is useful to have a dedicated type and helpers for each block
> > type.
> >
> > At the same time, once the registers are mapped the origin type does not
> > matter. It is overly pedantic to reference the register block type in
> > code that is using the registers.
> >
> > In preparation for the endpoint driver to incorporate Component registers
> > into its MMIO operations reorganize the registers to allow typed
> > enumeration + mapping, but anonymous usage. With the end state of
> > 'struct cxl_regs' to be:
> >
> > struct cxl_regs {
> >       union {
> >               struct {
> >                       CXL_DEVICE_REGS();
> >               };
> >               struct cxl_device_regs device_regs;
> >       };
> >       union {
> >               struct {
> >                       CXL_COMPONENT_REGS();
> >               };
> >               struct cxl_component_regs component_regs;
> >       };
> > };
> >
> > With this arrangement the driver can share component init code with
> > ports, but when using the registers it can directly reference the
> > component register block type by name without the 'component_regs'
> > prefix.
> >
> > So, map + enumerate can be shared across drivers of different CXL
> > classes e.g.:
> >
> > void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> >                          struct cxl_device_regs *regs);
> >
> > void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> >                             struct cxl_component_regs *regs);
> >
> > ...while inline usage in the driver need not indicate where the
> > registers came from:
> >
> > readl(cxlm->regs.mbox + MBOX_OFFSET);
> > readl(cxlm->regs.hdm + HDM_OFFSET);
> >
> > ...instead of:
> >
> > readl(cxlm->regs.device_regs.mbox + MBOX_OFFSET);
> > readl(cxlm->regs.component_regs.hdm + HDM_OFFSET);
> >
> > This complexity of the definition in .h yields improvement in code
> > readability in .c while maintaining type-safety for organization of
> > setup code. It prepares the implementation to maintain organization in
> > the face of CXL devices that compose register interfaces consisting of
> > multiple types.
> >
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> A few minor things inline.
>
> > ---
> >  drivers/cxl/cxl.h |   33 +++++++++++++++++++++++++++++++++
> >  drivers/cxl/mem.c |   44 ++++++++++++++++++++++++--------------------
> >  drivers/cxl/mem.h |   13 +++++--------
> >  3 files changed, 62 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 2e3bdacb32e7..37325e504fb7 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -34,5 +34,38 @@
> >  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> >  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> >
> > +/* See note for 'struct cxl_regs' for the rationale of this organization */
> > +#define CXL_DEVICE_REGS() \
> > +     void __iomem *status; \
> > +     void __iomem *mbox; \
> > +     void __iomem *memdev
> > +
> > +/**
> > + * struct cxl_device_regs - Common container of CXL Device register
> > + *                       block base pointers
> > + * @status: CXL 2.0 8.2.8.3 Device Status Registers
> > + * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> > + * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
>
> kernel-doc script is not going to be happy with documenting fields it can't see
> + not documenting the CXL_DEVICE_REGS() field it can.
>
> I've no idea what the right way to handle this might be.

Sure, I'll at least check that the tool does not complain, I might
just make this not a kernel-doc and change the /** to plain /*.


[..]
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index daa9aba0e218..c247cf9c71af 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -53,10 +53,9 @@ struct cxl_memdev {
> >  /**
> >   * struct cxl_mem - A CXL memory device
> >   * @pdev: The PCI device associated with this CXL device.
> > - * @regs: IO mappings to the device's MMIO
> > - * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> > - * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> > - * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> > + * @base: IO mappings to the device's MMIO
> > + * @cxlmd: Logical memory device chardev / interface
>
> Unrelated missing docs fix?

Yeah, I'll declare that in the changelog.

>
> > + * @regs: Parsed register blocks
> >   * @payload_size: Size of space for payload
> >   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> > @@ -67,12 +66,10 @@ struct cxl_memdev {
> >   */
> >  struct cxl_mem {
> >       struct pci_dev *pdev;
> > -     void __iomem *regs;
> > +     void __iomem *base;
>
> Whilst I have no problem with the rename and fact you want to free it
> up for other uses, perhaps call it out in the patch description?

Sure.
