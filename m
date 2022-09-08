Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BF5B1DE9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIHNGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiIHNGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 09:06:37 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B286A98D1;
        Thu,  8 Sep 2022 06:06:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b136so5592417yba.2;
        Thu, 08 Sep 2022 06:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3UXnKp6Go6PYoz7q4luoMbKTxeTdnrB40pbBHe3oIck=;
        b=qYMkL/1GPIlupcop7SK2QFxw/xunYwZ+pifSxIdDfLe1YD0/DZwmA3C4Yj2BWLhLz7
         DOGIY5RVQapCDzjxE7v5JNu3CRIEqt8MN4ZZLYIYMbEJKUPWSuF4EOWUlZro0QIFiLlD
         BvW4YCb0s9sYzXdcrImKElImcXNTMFSuNqxvdrEDOSvK3GpeNXGUaNAAsiIaEHHNJKqu
         QugkxUfjJxU2SvT5tZcxNzqLZOLts6XOKVF+Cu5odk2/8Pg0aHabfMM8vmZYgAxKnhbU
         6eZUxE+mcDDYQUSnZ4WJlFA0RpNMGoHF6PHBc500emjFLyFswRx2gX8xIBUI4bvkTtqq
         XUtg==
X-Gm-Message-State: ACgBeo2hZYLVmM4wXIhg57QEcXIm8sv7Tguie0DxYRgVEXXZ8JyXIP/s
        +DZDGpZvNXABVHbH99hmwgBA3g6n7FAi3JQl3LM=
X-Google-Smtp-Source: AA6agR7JfxV2Yoj7H8PCx3cEMWJrgl/Qcf6liBySgxNOmF/gnXgvb7A+TyrlQZCVTQ+myxJvl0T6Vv6kpknuIu4njkI=
X-Received: by 2002:a25:e64c:0:b0:6a9:89cf:155 with SMTP id
 d73-20020a25e64c000000b006a989cf0155mr6520399ybh.365.1662642395130; Thu, 08
 Sep 2022 06:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220831081603.3415-1-rrichter@amd.com> <20220831081603.3415-7-rrichter@amd.com>
 <63198617c7854_5801629450@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63198617c7854_5801629450@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Sep 2022 15:06:16 +0200
Message-ID: <CAJZ5v0iQNSNzO+mw7zqkvpniiYdipprTYnkzx-M7Jxq4_Cs8VQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 8, 2022 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Robert Richter wrote:
> > A lookup of a host bridge's corresponding acpi device (struct
> > acpi_device) is not possible, for example:
> >
> >       adev = ACPI_COMPANION(&host_bridge->dev);
> >
> > This could be useful to find a host bridge's fwnode handle and to
> > determine and call additional host bridge ACPI parameters and methods
> > such as HID/CID or _UID.
>
> When is this explicitly needed. "Could be useful" is interesting, but it
> needs to have a practical need.

It is needed and it is present on x86 AFAICS (see my last reply in this thread).

This seems to be addressing an ARM64-specific issue.

> >
> > Make this work by linking the host bridge to its ACPI fw node.
> >
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/acpi/pci_root.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index d57cf8454b93..846c979e4c29 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -1083,6 +1083,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >               goto out_release_info;
> >
> >       host_bridge = to_pci_host_bridge(bus->bridge);
> > +     host_bridge->dev.fwnode = acpi_fwnode_handle(device);
> >       if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> >               host_bridge->native_pcie_hotplug = 0;
> >       if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> > --
> > 2.30.2
> >
>
>
