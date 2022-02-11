Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882AD4B1CBB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 03:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiBKCyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 21:54:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbiBKCyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 21:54:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82F5F5B
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 18:54:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w1so3539042plb.6
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIFupKjScNCpYUypn/cIhD7JLtCVAeh6PLxmrAitRYA=;
        b=liNDrbQ5qLKYyheA7YyqzvUjCK4Md1FDophA9rnAmj7c8qrIi5laNaHwKU4eFrB53R
         Q7inJruYR907OTZ9RTAcSewzni7BLvKKPKVqeBmGZxNlkKIhGkKYh4WccpQuG8gc2iOw
         YG4YqDWcHpvZg3RnqUT/pJB0XoXTeGoFXRrJKN7F2ZBLOhswM2JhofuKC94T9WvK91pD
         dg+iOnr61COPXt4zz53rr9P+G5vuRq/0QXax/xfrPh6FA4UqZTgeUMZYfip/lr9I3bLx
         yp+ULnDIJ08XwUBYBS5uEw1sxahhVMSHR9sCcmdHe8ALSNZJ30wQEeHBWjmFYNkW08ps
         UHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIFupKjScNCpYUypn/cIhD7JLtCVAeh6PLxmrAitRYA=;
        b=ePAS/cYG6oxJ4YulIlrSZHd6kW7Cdj7ayX20NmwdCQLCvR26TFUwAeryLT0nwr58FI
         ToIkiLGpICaoUIiqgyjFn0Xwi5xhnggc9fgtsKi2z2MuXlgFhxEPSH01mlK8ro3ONgrK
         tyREdYms0U+l+O/aFDBidsWWZLE3DjvVMA7dEB5IFoKk9UctbaN+f8icxhApE949aIsz
         weZ2XbbzioWDEwfH9U0sb4AlT788BkBaimVuW+0Xx0qAoPzb3z+qeTpNf3jrpEQx7NIt
         A37Z84HOx3nmRZzs7Bk2TR5dmHR5A2rTAY9Et4lSl7jMkEvF+is7kW1ueCLp8OBE/MqF
         X6jA==
X-Gm-Message-State: AOAM531YaszKorMIQZ1ZfPup0JOkkxZyNAsa2Kh9cKCO1vyWS0k7hs0B
        qg+Ne1tm3BJ3s4pO9TNgkDodDwFfUQvJv3k8XJlP9w==
X-Google-Smtp-Source: ABdhPJy59gRdBarJ6og4EY7AWGuckDxQh2sKFdYTKqP3kOnSJO+ar7lp0FCGy/K7jL/a6RJ7Wtnq9PkjN9oPpHIYVDA=
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr468122pjb.93.1644548071677;
 Thu, 10 Feb 2022 18:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20220204145116.00000f5c@Huawei.com> <20220204162756.GA187525@bhelgaas>
In-Reply-To: <20220204162756.GA187525@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Feb 2022 18:54:20 -0800
Message-ID: <CAPcyv4jRGKJOVJdZEFgPZzFp8vP2ADd1NexN=OJTWz34RgcaCA@mail.gmail.com>
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 4, 2022 at 8:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Feb 04, 2022 at 02:51:16PM +0000, Jonathan Cameron wrote:
> > On Thu, 3 Feb 2022 16:44:37 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Jan 31, 2022 at 11:19:46PM -0800, ira.weiny@intel.com wrote:
>
> > > > + * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
> > > > + *                              mailboxes found
> > > > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > > > + *
> > > > + * There is no coresponding destroy of these devices.  This function associates
> > > > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > > > + * association is device managed (devm_*) such that the DOE auxiliary device
> > > > + * lifetime is always greater than or equal to the lifetime of the pci_dev.
> > >
> > > This seems backwards.  What does it mean if the DOE aux dev
> > > lifetime is *greater* than that of the pci_dev?  Surely you can't
> > > access a PCI DOE Capability if the pci_dev is gone?
> >
> > I think the description is inaccurate - the end of life is the same
> > as that of the PCI driver binding to the pci_dev.  It'll get cleared
> > up if that is unbound etc.
>
> I don't know much about devm, but I *think* the devm things get
> released by devres_release_all(), which is called by
> __device_release_driver() after it calls the bus or driver's .remove()
> method (pci_device_remove(), in this case).
>
> So in this case, I think the aux dev is created after the pci_dev and
> released after the PCI driver and the PCI core are done with the
> pci_dev.  I assume some refcounting prevents the pci_dev from actually
> being deallocated until the aux dev is done with it.
>
> I'm not confident that this is a robust situation.

devm is a replacement for hand coding driver ->remove() handlers.
Anything devm allocated at ->probe() will be freed in the proper
reverse order by the driver core after it calls ->remove(). Ideally
for pure devm usage the ->remove() handler can be elided altogether.
I'll go read this patch to make sure it follows the expected pattern
which is:

1/ Parent device driver performs kmalloc(), device_initialize(), and
device_add() of a child device.
2/ Parent registers a devm handler for that child device that will
trigger device_unregister() at remove

During parent device unregister or unbind the devm action will
complete device_unregister() for all children first.

That process is independent of the device lifetime that can be
arbitrarily extended by 3rd party get_device() or
CONFIG_DEBUG_KOBJECT_RELEASE. The device core / kobject hierarchy
guarantees that the parent device is pinned until after child-device
final put event. I.e. final put_device() on a child also triggers a
put_device() on the parent paired with the get_device() taken on the
parent at device_add() time.
