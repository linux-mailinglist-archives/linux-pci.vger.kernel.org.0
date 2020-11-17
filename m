Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09D2B6D8C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgKQSi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbgKQSi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 13:38:29 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6853C0617A7
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 10:38:28 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id m16so8665806edr.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 10:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3LgJ1btHwr+UlowB5dcekxQptEcC5LkMAcIQycCj/s=;
        b=HPUWe+MEmh4/ZGZhS/NOZCJ/FcMIxqkdI1j6yjJn0rS8dL8H7TA6ft97CtJHcQhfDE
         yswJwYsO3BFqjZa1LX3WsLbKQLmPGwdx6hE+5AHWVSx+SAYOv40Q6rJykNC8KgfQidwW
         LPA3JNaUV09LZX522K+ZYhBQ4PudnNpPP+gdFTUbCYLlX1Bj8oFOPvHK2dBSblFnNJQb
         KYHJcIC4UlSR0OBgy71IGxCFAfxpx0uf9B96ghNPDSW+GPmGm37x1QKBaWLT/Zb2SywC
         gs7Om2GvQm1HTzlhJa7czIUXY0Eay0asC90kQNyTg6L2MqrXQHlVFaGqoOSyl1rnRdoO
         F1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3LgJ1btHwr+UlowB5dcekxQptEcC5LkMAcIQycCj/s=;
        b=WtHbuclIc2eTTc0TUTyyLc/WmQ8vQ+g9piRXfpYlMTBY9ZgfYi0iEjKGVGfigsbjMi
         iOKTB7rWKYVElHL87DlSm+2WKOWkJbvJSuvQv3fySYuDjp8CA6L+E9Ps4D/Cs7HcE977
         HGqDmSnxMGTYWSlNXD0PTNeI8vtJ7GpzsEdoV6aQF9NM1ILNUIDpk62ilkIMpGrEOjLX
         TuqWZmFQC1D8KQESoFEPJOv39MxoskhyUOXUIlttYOMRHdexXLHRjH+/v/Z8QF952Xk4
         0jxRXWVHDJ5lHOH7o0Vdt1jUKBCQLd74s687/uzSXXXziFy161h5x4ZuyqYSI+hLrm0z
         T+wg==
X-Gm-Message-State: AOAM531A3PaQhESID9pCq5gG1tH/oabp027eoGZ0o5XB/ok2PBCNctUL
        7oVAHVCdlOsFAtztbELPlPrg6A969xL2Rn65Hd78OA==
X-Google-Smtp-Source: ABdhPJzRbZ3GE9o2Fhnn1yExUl8l8zyNLuAMhobgMHPT7mpHWPmtL56Ye4MixpEyGH0MpV4BKUOrZSS5oTVRqdyBXvA=
X-Received: by 2002:a05:6402:31b6:: with SMTP id dj22mr22956236edb.348.1605638307225;
 Tue, 17 Nov 2020 10:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-8-ben.widawsky@intel.com> <20201117153122.00001a5a@Huawei.com>
 <20201117163438.co63em73mmil5xm5@intel.com> <20201117180638.00003703@Huawei.com>
In-Reply-To: <20201117180638.00003703@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Nov 2020 10:38:15 -0800
Message-ID: <CAPcyv4jyXR99bEUTiT8HFsb0cTLA3XBfuNrHosUR2GQOWAA_5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] cxl/mem: Implement polled mode mailbox
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
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

On Tue, Nov 17, 2020 at 10:07 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Nov 2020 08:34:38 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > On 20-11-17 15:31:22, Jonathan Cameron wrote:
> > > On Tue, 10 Nov 2020 21:43:54 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > Create a function to handle sending a command, optionally with a
> > > > payload, to the memory device, polling on a result, and then optionally
> > > > copying out the payload. The algorithm for doing this come straight out
> > > > of the CXL 2.0 specification.
> > > >
> > > > Primary mailboxes are capable of generating an interrupt when submitting
> > > > a command in the background. That implementation is saved for a later
> > > > time.
> > > >
> > > > Secondary mailboxes aren't implemented at this time.
> > > >
> > > > WARNING: This is untested with actual timeouts occurring.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > Question inline for why the preempt / local timer dance is worth bothering with.
> > > What am I missing?
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  drivers/cxl/cxl.h |  16 +++++++
> > > >  drivers/cxl/mem.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 123 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > > index 482fc9cdc890..f49ab80f68bd 100644
> > > > --- a/drivers/cxl/cxl.h
> > > > +++ b/drivers/cxl/cxl.h
> > > > @@ -21,8 +21,12 @@
> > > >  #define CXLDEV_MB_CTRL 0x04
> > > >  #define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
> > > >  #define CXLDEV_MB_CMD 0x08
> > > > +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT 16
> > > >  #define CXLDEV_MB_STATUS 0x10
> > > > +#define   CXLDEV_MB_STATUS_RET_CODE_SHIFT 32
> > > > +#define   CXLDEV_MB_STATUS_RET_CODE_MASK 0xffff
> > > >  #define CXLDEV_MB_BG_CMD_STATUS 0x18
> > > > +#define CXLDEV_MB_PAYLOAD 0x20
> > > >
> > > >  /* Memory Device */
> > > >  #define CXLMDEV_STATUS 0
> > > > @@ -114,4 +118,16 @@ static inline u64 __cxl_raw_read_reg64(struct cxl_mem *cxlm, u32 reg)
> > > >
> > > >   return readq(reg_addr + reg);
> > > >  }
> > > > +
> > > > +static inline void cxl_mbox_payload_fill(struct cxl_mem *cxlm, u8 *input,
> > > > +                                     unsigned int length)
> > > > +{
> > > > + memcpy_toio(cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, input, length);
> > > > +}
> > > > +
> > > > +static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm,
> > > > +                                      u8 *output, unsigned int length)
> > > > +{
> > > > + memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, length);
> > > > +}
> > > >  #endif /* __CXL_H__ */
> > > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > > index 9fd2d1daa534..08913360d500 100644
> > > > --- a/drivers/cxl/mem.c
> > > > +++ b/drivers/cxl/mem.c
> > > > @@ -1,5 +1,6 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-only
> > > >  // Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > > +#include <linux/sched/clock.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/io.h>
> > > > @@ -7,6 +8,112 @@
> > > >  #include "pci.h"
> > > >  #include "cxl.h"
> > > >
> > > > +struct mbox_cmd {
> > > > + u16 cmd;
> > > > + u8 *payload;
> > > > + size_t payload_size;
> > > > + u16 return_code;
> > > > +};
> > > > +
> > > > +static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
> > > > +{
> > > > + u64 start, now;
> > > > + int cpu, ret, timeout = 2000000000;
> > > > +
> > > > + start = local_clock();
> > > > + preempt_disable();
> > > > + cpu = smp_processor_id();
> > > > + for (;;) {
> > > > +         now = local_clock();
> > > > +         preempt_enable();
> > >
> > > What do we ever do with this mailbox that is particularly
> > > performance critical? I'd like to understand why we care enough
> > > to mess around with the preemption changes and local clock etc.
> > >
> >
> > It is quite obviously a premature optimization at this point (since we only
> > support a single command in QEMU). However, the polling can be anywhere from
> > instant to 2 seconds. QEMU implementation aside again, some devices may never
> > support interrupts on completion, and so I thought providing a poll function now
> > that is capable of working for most [all?] cases was wise.
>
> Definitely seems premature.  I'd want to see real numbers on hardware
> to justify this sort of complexity.  Maybe others disagree though.

The polling is definitely needed, but I think it can be a simple
jiffies based loop and avoid this sched_clock() complexity.
