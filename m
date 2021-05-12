Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88937B638
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELGhg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhELGhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 02:37:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C2C061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:36:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t4so33372238ejo.0
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nevGWaMjb5PeAfV1/F7svJNtl2lKO/LKnPavtCONiAI=;
        b=HPpOr4WJvmIPXKYS68buFhoAp5Li17j7jKX7/p4MM8Jdc8zp3Afy+9QrHlxyMLkqIl
         W0fRFCLAdUeZBL3gi7PbgBPQ2F0hcFhKcEsEbfTfQvBERFdKM/18nGInFsl/X0bSoMrR
         nR9pIlJU1StFIq8JAetJztmRo3A6V63sHQnOOaWpliocMXgE0ELlocl9ycD4j9pn7JFr
         3n0uEjA7UdCX+6oI3KKWzREefFEM0X5ZRtOwXAlMHKHKa1Cb2PUkuaNhhHeMUmQctqYU
         ZdY5BRWrjlO0ZlELbBdtQu9YnCkrzUMTOZOQtTedilA/k5K62kSLy1DVIUepVg5shp51
         ItYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nevGWaMjb5PeAfV1/F7svJNtl2lKO/LKnPavtCONiAI=;
        b=i4iU610fDJ6WhshzJAALwxyhXroz5Ju2MhTca/MPEz3egTzq7r3hCPhGz/ni4YpSsD
         YMy1PhD4z08GFYPKgpnQqhDxXkd7BmKpvB54aOJ/+llB2GFxn8+n97hgi3R7yOWbQIwv
         nGwsXGWIuDvbgZg/v8cCc62VAqQmtC3q7V2+Qj5Aw7IZ+fCPvVekdT5Zdgz5ADK4deN/
         aUu/Qrn5RuVxscKUl4/7QuKdWe6M5a3c8e2fbX7Co5cCSUkPXxSi1gEHu6fBdbNUcbQX
         K237KUU0Wh1Jxgk4t41vuj3w46svH5N+SgZPvnGsawQucSKxVv4H3mdD0FpB2sko57vH
         kQOw==
X-Gm-Message-State: AOAM530FFl3BA7hjEmj2W/P0CtCG8Xm8l3RQcjjMFXutk7exg4GArPa2
        nDzkk9tyCZBuN4UtVeyMce8K2jqTk9F+iNT/Ydcl2Q==
X-Google-Smtp-Source: ABdhPJxCxoEotHYSk6jU/Ap34pv984lwVWKfA4gMFHe/bD7fPEXF/C3Wo4s41aCcPA/bHiQZsSq+DtoYOWuPDgIL8kQ=
X-Received: by 2002:a17:906:bc8e:: with SMTP id lv14mr35741607ejb.418.1620801386118;
 Tue, 11 May 2021 23:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162042791852.1202325.8197739881935753009.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510162121.000042be@Huawei.com>
In-Reply-To: <20210510162121.000042be@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 23:36:15 -0700
Message-ID: <CAPcyv4jyGDYbwz1h3z3N-vEVXyYOu7Cbf+hnzWDQk+dOWHgZmQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] cxl/port: Introduce cxl_port objects
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 8:23 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:58 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Once the cxl_root is established then other ports in the hierarchy can
> > be attached. The cxl_port object, unlike cxl_root that is associated
> > with host bridges, is associated with PCIe Root Ports or PCIe Switch
> > Ports. Add cxl_port instances for all PCIe Root Ports in an ACPI0016
> > host bridge. The cxl_port instances for PCIe Switch Ports are not
> > included here as those are to be modeled as another service device
> > registered on the pcie_port_bus_type.
> >
> > A sample sysfs topology for a single-host-bridge with
> > single-PCIe/CXL-port follows:
> >
> > /sys/bus/cxl/devices/root0
> > =E2=94=9C=E2=94=80=E2=94=80 address_space0
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 end
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 start
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_ram
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_type2
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_type3
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > =E2=94=9C=E2=94=80=E2=94=80 address_space1
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 end
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 start
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_pmem
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_type2
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 supports_type3
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=9C=E2=94=80=E2=94=80 port1
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 host -> ../../../../LNXSYSTM:00=
/LNXSYBUS:00/ACPI0016:00
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 port2
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 host -> ../../../..=
/../pci0000:34/0000:34:00.0
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../=
../../../../bus/cxl
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target_id
> > =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../../bus=
/cxl
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target_id
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/cxl
> > =E2=94=9C=E2=94=80=E2=94=80 target_id
> > =E2=94=94=E2=94=80=E2=94=80 uevent
> >
> > In this listing the system-wide-singleton root0 has 2 address spaces, 1
> > PMEM and 1 RAM. Those address spaces are accessed through port1 which
> > represents the upstream port of an ACPI0016 host-bridge. A
> > multi-host-bridge system would have other ports as peers to port1 to
> > additionally decode root level address spaces. Port2 in this diagram
> > represents the single downstream port of the host-bridge. Were it to be
> > a multi-ported-host-bridge there would be peers / siblings of port2 wit=
h
> > port1 as their common ancestor.
>
> I guess it would be a pain to emulate a system that actually had
> multiple ports at the last level. Pity as would have made your
> explanation here a little easier to follow.
>

A pain in QEMU, but maybe not with a mocked implementation similar to
what gets injected for the nvdimm "nfit_test". I'll take a look.

> > The rationale for this port hierarchy is to be able to walk the HDM
> > decoder register sets that each port implements. Additionally it
> > provides a representation of host-bridge interleave which will be
> > necessary for follow-on work that adds CXL region devices.
> >
> > The details in the /sys/bus/cxl hierarchy that are not suitable to be
> > represented in the /sys/bus/pci hierarchy are:
> > - memory address spaces that are interleaved across host bridges
> > - common sub-device functionality represented by CXL component + device
> >   registers (enumerated via DVSEC or platform firmware (ACPI CEDT)).
>
> I'm sold :)

Thanks for the vote of confidence. It sounded like Bjorn was sold too
at the end of our last thread... I'll Cc him on this patch directly in
the resend.

>
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the review Jonathan, appreciate it.
