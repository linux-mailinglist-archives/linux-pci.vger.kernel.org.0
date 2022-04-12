Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1834FDB8D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiDLKEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380806AbiDLIWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 04:22:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0815527D8
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 00:51:17 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ec42eae76bso42356667b3.10
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4OAO7nnZ8OX/KlCcPdZAiTQkP3Ef4YaiBMzQMe37GA=;
        b=XHFbMCuk71uIwAmqpOLD+1cpGGkLISo3rmscX0zDWdVz+rawJMip57rBRdFqM564Ka
         IDEMXvaUDLMk4/MRFkETpelYTzl0BpQuKd+bOXpm3O7cpB1FTZS3E2tLJnv2mk1ezK+w
         jhWqehoogEsX+UvQnb8ZbQ2YHfQqKprWe6T0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4OAO7nnZ8OX/KlCcPdZAiTQkP3Ef4YaiBMzQMe37GA=;
        b=Uex3I745g6FRgL/26xcrFCaykh6YJtu9FgZx2QgA1FZIqY96cIK/YuSOo51WvwntUu
         VhPq6GsToGtA1yLzAJDIey7VEParwsm7WokMgi3hkBtiyQbEN9bBfazzRfwfWCelE7Ac
         xy+OXfu9ez5VUn3XI7d+UbTrTd/6K+9O6MDJC1xkRXeGRn77HNnTyLugJcNMSdhtno3I
         77entW9Ul9dBOjUx1blRkjbRM1HUb9ab/WV9cF77HeAoKzLcqCXjAANpkSRK/fTDuYNP
         BO+gKYl+wzkL2uVQKHMyL/Q50y4lC471Zckxt8okOFzeYYTZgV6Dd0S9uf+nkIOp9GVu
         2mgg==
X-Gm-Message-State: AOAM530f692fXRnjf+4VR7BKIdRjD8Uh6scH/XJFWnZ5ieoQJ0yF5j6V
        laIEcaZJBE46o2VrTZDU4CRt+dKSVmvA7Kc+tTB4Rg==
X-Google-Smtp-Source: ABdhPJx8GUgxqrrj69ZZQNPISfHn9KL6DvhPn2Cv2JdROrKaOtRIGldYKBZP82LLkXg7BbRzgXz7VneADNL7bKux8Qo=
X-Received: by 2002:a0d:c602:0:b0:2ec:472:5e32 with SMTP id
 i2-20020a0dc602000000b002ec04725e32mr9740269ywd.364.1649749877009; Tue, 12
 Apr 2022 00:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220406071131.2930035-1-stevensd@google.com> <Yk1KveOnYfSrUJLD@kroah.com>
 <20220406131300.7pgdcpdhexwvczsb@pali>
In-Reply-To: <20220406131300.7pgdcpdhexwvczsb@pali>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 12 Apr 2022 16:51:06 +0900
Message-ID: <CAD=HUj5rSDGCgfLM8_waTcdMzDYp2=cnG5XpBN=4j3JMyN9g6g@mail.gmail.com>
Subject: Re: [RFC] PCI: sysfs: add bypass for config read admin check
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 6, 2022 at 10:13 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 06 April 2022 10:09:33 Greg Kroah-Hartman wrote:
> > On Wed, Apr 06, 2022 at 04:11:31PM +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Add a moduleparam that can be set to bypass the check that limits use=
rs
> > > without CAP_SYS_ADMIN to only being able to read the first 64 bytes o=
f
> > > the config space. This allows systems without problematic hardware to=
 be
> > > configured to allow users without CAP_SYS_ADMIN to read PCI
> > > capabilities.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > ---
> > >  drivers/pci/pci-sysfs.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 602f0fb0b007..162423b3c052 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -28,10 +28,17 @@
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/of.h>
> > > +#include <linux/moduleparam.h>
> > >  #include "pci.h"
> > >
> > >  static int sysfs_initialized;      /* =3D 0 */
> > >
> > > +static bool allow_unsafe_config_reads;
> > > +module_param_named(allow_unsafe_config_reads,
> > > +              allow_unsafe_config_reads, bool, 0644);
> > > +MODULE_PARM_DESC(allow_unsafe_config_reads,
> > > +            "Enable full read access to config space without CAP_SYS=
_ADMIN.");
> >
> > No, this is not the 1990's, please do not add system-wide module
> > parameters like this.  Especially ones that circumvent security
> > protections.
> >
> > Also, where did you document this new option?
> >
> > Why not just add this to a LSM instead?
> >
> > >  /* show configuration fields */
> > >  #define pci_config_attr(field, format_string)                       =
       \
> > >  static ssize_t                                                      =
       \
> > > @@ -696,7 +703,8 @@ static ssize_t pci_read_config(struct file *filp,=
 struct kobject *kobj,
> > >     u8 *data =3D (u8 *) buf;
> > >
> > >     /* Several chips lock up trying to read undefined config space */
> > > -   if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
> > > +   if (allow_unsafe_config_reads ||
> > > +       file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
> >
> > This feels really dangerous.  What benifit are you getting here by
> > allowing an unpriviliged user to read this information?
>
> Hello! This is really dangerous.
>
> Nowadays operating systems are in progress to completely disallow PCI
> config space access from userspace. So doing opposite thing and even
> enable it for unprivileged users in Linux is hazard.
>
> For example NT kernel in Windows 11 already completely disallowed access
> to PCI config space from userspace unless NT kernel is booted in mode
> for local debugging with disabled UEFI secure boot. And access in this
> case is only for highly privileged processes (debug privilege in access
> token).
>
> So... should not we move into same direction like other operating system
> and start disallowing access to PCI config space from userspace
> completely too? For example when kernel lockdown feature is enabled?
>
> In PCI config space of some devices are stored also non-PCI registers
> and accessing them was not really mean for userspace and for sure not
> for unprivileged users. On AMD x86 platforms is into PCI config space of
> some device mapped for example CPU MSR registers (at fixed offset, after
> linked listed of capabilities). Probably in Intel x86 is something
> similar too. On Synopsis Designware based PCIe HW is into PCI config
> space of Root Port mapped large range of IP configuration registers.
>
> So "This allows systems without problematic hardware" means that such
> system must be non-AMD, non-Designware and probably also non-Intel.

It's interesting to hear that what seems to have been added 18 years
ago as a safeguard against faulty hardware (i.e. "Several chips lock
up trying to read undefined config space") has become a load bearing
security check. I guess because that check is there, it wasn't worth
adding a LOCKDOWN_PCI_ACCESS check to pci_read_config?

Regardless, I've found that with a bit of work in userspace, vfio is
sufficient for my use case.

-David
