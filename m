Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA8319048
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBKQqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 11:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhBKQoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 11:44:08 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F2C061788
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 08:43:28 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v10so2232867qtq.7
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TnTqaJo6o1YbIsxOlUU5El2AYFoCRaTMv2k74gwpYCk=;
        b=j7wENnRNfYfPWqF0G9QGfDUzZk153Z4UQUmIveNotABQDwPIRR70vxmq35a7doUKCZ
         /HcvOQ86RpZiIANzXlYIfy+cAgGoUtdPhMADXIwhA2mdI+cZmuULVLbyvajkEAzTFDUD
         HlQENYNoYVeOG5qtbcqxQm6f93n6rMe0lE2Q/7B1Q0BVTLr+Tv6TXhbb4QBf/RUGDOIL
         jvNkGUYiXZOX9S7SYbN6U7aMi36Jvs+F6dKWmArqhvay3h5S4R8nxzeejQBYTIaCr8Lu
         7ak3Pb8RxDoS2+C/OcgfbO/o40kFyaZsGykValmew5XF14xbnK46yn5yPxRz3jn4yz/o
         OW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TnTqaJo6o1YbIsxOlUU5El2AYFoCRaTMv2k74gwpYCk=;
        b=GLNwW3qVkWhPMx170k/aw10nkLPfooJ5rvWUm08ClXAgssjQY1OUJ7+4D7Rka9IYeE
         M8aVJZxfnmmx8RFO7bxb6g7loO98x0XokF6ekfzWr3/w3Y935bbZHEWuHsXwdWAHRPpM
         1rHIZcKbKDikyr0yqq5x+KqktaNVXPtFx6WXND3LmJqLhJPHFmEIeex0xE9e541rFGj3
         P6Q/TO3Lwcx8zRl41xo/KxxEliZ4F7sWAIakPk5JE9X8H2Hv12K2bGSeZYKNEoqBrYId
         2A8KqCaT5bVkVO+vBV1Ct7kTWczhjyzB1SLBbFQOopYofUVJGO76bSCMsheh3ZdZXOvW
         jqWQ==
X-Gm-Message-State: AOAM531kgjTeDb2uNGt3ENC9gB/OY88bIPrFeg7JFMrXtryhUoRtRJpd
        2VcHOuhq8nvhRJmzHtiMHo/CrwxTh+lwqbqYDnhyhQ==
X-Google-Smtp-Source: ABdhPJyIzcNVaFrr0OmiD16y+FCSfW1u7IpTJXN6zk3LpMSJgVXwchFQE+2/kSNg4CVmCoH61WURtiFXXMwaao4ZUhM=
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr8369890qtf.230.1613061807236;
 Thu, 11 Feb 2021 08:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com> <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Feb 2021 08:43:16 -0800
Message-ID: <CAPcyv4i9q8CaOehPDe2m7gSWVmRtSxX37G8+D8RdCgiL6jt1JA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
To:     Ariel.Sibley@microchip.com
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 7:27 AM <Ariel.Sibley@microchip.com> wrote:
>
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index c4ba3aa0a05d..08eaa8e52083 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -33,6 +33,24 @@ config CXL_MEM
> >
> >           If unsure say 'm'.
> >
> > +config CXL_MEM_RAW_COMMANDS
> > +       bool "RAW Command Interface for Memory Devices"
> > +       depends on CXL_MEM
> > +       help
> > +         Enable CXL RAW command interface.
> > +
> > +         The CXL driver ioctl interface may assign a kernel ioctl comm=
and
> > +         number for each specification defined opcode. At any given po=
int in
> > +         time the number of opcodes that the specification defines and=
 a device
> > +         may implement may exceed the kernel's set of associated ioctl=
 function
> > +         numbers. The mismatch is either by omission, specification is=
 too new,
> > +         or by design. When prototyping new hardware, or developing /
> > debugging
> > +         the driver it is useful to be able to submit any possible com=
mand to
> > +         the hardware, even commands that may crash the kernel due to =
their
> > +         potential impact to memory currently in use by the kernel.
> > +
> > +         If developing CXL hardware or the driver say Y, otherwise say=
 N.
>
> Blocking RAW commands by default will prevent vendors from developing use=
r space tools that utilize vendor specific commands. Vendors of CXL.mem dev=
ices should take ownership of ensuring any vendor defined commands that cou=
ld cause user data to be exposed or corrupted are disabled at the device le=
vel for shipping configurations.

What follows is my personal opinion as a Linux kernel developer, not
necessarily the opinion of my employer...

Aside from the convention that new functionality is always default N
it is the Linux distributor that decides the configuration. In an
environment where the kernel is developing features like
CONFIG_SECURITY_LOCKDOWN_LSM that limit the ability of the kernel to
subvert platform features like secure boot, it is incumbent upon
drivers to evaluate what they must do to protect platform integrity.
See the ongoing tightening of /dev/mem like interfaces for an example
of the shrinking ability of root to have unfettered access to all
platform/hardware capabilities.

CXL is unique in that it impacts "System RAM" resources and that it
interleaves multiple devices. Compare this to NVME where the blast
radius of misbehavior is contained to an endpoint and is behind an
IOMMU. The larger impact to me increases the responsibility of CXL
enabling to review system impacts and vendor specific functionality is
typically unreviewable.

There are 2 proposals I can see to improve the unreviewable problem.
First, of course, get commands into the standard proper. One strawman
proposal is to take the "Code First" process that seems to be working
well for the ACPI and UEFI working groups and apply it to CXL command
definitions. That vastly shortens the time between proposal and Linux
enabling. The second proposal is to define a mechanism for de-facto
standards to develop. That need I believe was the motivation for
"designated vendor-specific" in the first instance? I.e. to share
implementations across vendors pre-standardization.

So, allocate a public id for the command space, publish a public
specification, and then send kernel patches. This was the process for
accepting command sets outside of ACPI into the LIBNVDIMM subsystem.
See drivers/acpi/nfit/nfit.h for the reference to the public command
sets.
