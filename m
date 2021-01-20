Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0596A2FD9A1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392227AbhATT2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392421AbhATT2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 14:28:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8DC061757
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:27:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ox12so10826225ejb.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFCMdgvZedWspt+wwjfwNdDyL/Ze+wNdJzREDBLW6Fk=;
        b=nMGspExDUuX235k2+XQanleBXymdTcxWKYQ4yt3evkAQD8sCqFjkN7MziIuY090VGl
         426mCCktSx1rp4apsLSJzVTg81exHVPASk4qRZtVT27xpal1feB4LPBtYkv3kSV2HnJM
         SwQ8F8bDk09D6EOyoMgRYxCZAV+wYxqYLv0XJ+vTif6R3fGcx8rPtz1IJsEmtc5qpC1c
         9/8F1YgUtg0WHBDmpDd8VtlZdEKGoI4RreXa2veB8HWg7kwxsOa6QJlxJnRHX+17fXqm
         AT0FYPo26h38iIqGYhB2zhE6tBg/TAuEJDeW3zYHfDgHAdMOXiAM692bclwDrkFJeT4Y
         jt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFCMdgvZedWspt+wwjfwNdDyL/Ze+wNdJzREDBLW6Fk=;
        b=YzoyirfuqXt1YfIh28F+hnTUj+54prCprAOFQ4OA/yJyVurcXeZaAfF63YjzSL4Eyv
         5qToltIrUnWIHaNJdzOA1sMiiWDK4eEzreuQiyaeoiCrY1AYt+3A4dbEBJGDqLUQ3WOG
         6CGkwrwPb+IF/eBPuszs8npRj2bk9hGjLZo/W737VibzWpftusRngYB/BxWg08GS0OKd
         S+x+Qd2QNYfRgrCqyqITyGjvWTBxIP8tvoNc/rKykGQy06F4Y15DXVRc0O+0uO6TIhmX
         HxRwIoIH3c2yONdaL22xgWMpNict7oiMxHhuTLGY9+kmzBGSjqOYLt6lOHzUNmTYz3pu
         f9DA==
X-Gm-Message-State: AOAM53184DvNdeYjdt/p+eCWGS/36mm3Nx3oXhXLHTZ7q+CTf6vCkKln
        DLxs3nza3EiJ/wx/sYfOiudtC1xjs24EJVNc9KpV0w==
X-Google-Smtp-Source: ABdhPJwM9p+beeUOnARUSMidOhUstigJfZ7qhz2P2ZIlv/8e3wdhXKdXxrWIddFKnIObRClHkNIPZbjsZjpLRCiqKJc=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr7146939ejb.341.1611170847785;
 Wed, 20 Jan 2021 11:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-3-ben.widawsky@intel.com> <20210112184355.00007632@Huawei.com>
 <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com> <MWHPR11MB1599E92A457AF6D103EECB06F0A90@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599E92A457AF6D103EECB06F0A90@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Jan 2021 11:27:21 -0800
Message-ID: <CAPcyv4gyuw7U1YFCSUbyY=xRe4EPVbKHqxJUUaXP1oHtEeEwtA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 13, 2021 at 9:55 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
[..]
> > The supplemental tables described here:
> >
> > https://www.uefi.org/acpi
> >
> > ...do eventually make there way into ACPICA. Added Bob and Erik in
> > case they can comment on when CEDT and CDAT support will be picked up.
>
> We would be happy to add support. I think Ben has reached out to me earli=
er about something like this but I haven=E2=80=99t had a chance to implemen=
t... Sorry about the delay.. How soon is the iASL/ACPICA support needed for=
 CDAT and CDET?

CDAT and CEDT definitions in include/acpi/actbl* would be useful as
soon as v5.12. If that's too soon I don't think we're blocked, but the
driver is fast approaching the point where it needs to consult these
tables to enable higher order functionality.
