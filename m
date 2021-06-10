Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42103A349B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJUNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 16:13:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34863C061574
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 13:11:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e22so631409pgv.10
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybXQ8wv/C12Ca5WDiueTj4x3bqTsPAZ5Ylr8uxI2UN8=;
        b=uniQedDJUO2c9f95UKPw6TdlwlNerlkHGcB6BORYJbsAq5UVrNd1x8o2yZlKLd/Te3
         Sd/oslHJS/3HPQT1jfKsQQ9qVSpeYTfi1H2vI9j6Jz5qSIzewWwiXfEIVmu4oKH7GILQ
         VgPO+pA+TkhwKWFyXzjlbVL4/3bf/r2zmNQwc1BH/gkXYDKAa+Y16dBNsgIVb+6eUXla
         BM0nlPQ+SuSI/3JeVZEnEvp02XsM93sKgxRKmkm6Uet+wLMKOHBh2PrMzrLf/fkqmAkj
         rM+SeOLqPMz10uMWwI3tX0tHDBH0fmGX1ff6vQ2r3Be0Fd77QnRf/PcFsFrzasMO+qZl
         D/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybXQ8wv/C12Ca5WDiueTj4x3bqTsPAZ5Ylr8uxI2UN8=;
        b=MRaSJo5fH5G06evD/AT5RjgO1gXNZz6cr4jXw0uZNsMYSfwBiAGeFZYVYXo8/7i0Os
         Vr0T44wFFz4Vu2Ex75uKScykaKQ277hPmEtjzDzZn3aIYGPChTHH4aW+WHCeRk6vut+K
         VbnKxe0hedT3JNuHNNWm+L1f+4gMrV7iMWMJL+9cWadMU3XW4T/Xcho5j57okqwpshV4
         kD5rZr0diEvC7IDFJvnBrXPNPsS9Ae21B7QkMApmblhu9lGTXGNUs4Ar9votspGdZ6+s
         D57v89vyeMgCGUiZ4ATdsN9WXyr1glLaGk2INBoLuEa/39w80UzCkC209KEUMCBdF4m0
         5kmg==
X-Gm-Message-State: AOAM5303qgZoivJSbN9pK8TlgyXh0Ahv4rnm2jN4Byop+pl80TPfcLTT
        jAm2vX0EJqpOFTNFUflfG0XBHxW2eqN65WkGh63ifA==
X-Google-Smtp-Source: ABdhPJxfjaRqh8MUgs4T2Dweyx5nPlSxYhbGFyZwRyPqLQOkYUzEvKy6Rzx8E7b+W8umVVg4sldpoXtz4S2/Qin70wI=
X-Received: by 2002:aa7:952b:0:b029:2e9:eef1:8e17 with SMTP id
 c11-20020aa7952b0000b02902e9eef18e17mr4585971pfp.70.1623355866709; Thu, 10
 Jun 2021 13:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
 <20210524133938.2815206-2-Jonathan.Cameron@huawei.com> <CAPcyv4i5-d6HrhQwUmjx7HqKA+pr8aQjPGHJ=7Sh3eTgJ1UKyg@mail.gmail.com>
 <20210610183924.0000491d@Huawei.com>
In-Reply-To: <20210610183924.0000491d@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 13:10:56 -0700
Message-ID: <CAPcyv4hE8M2qmMZYH+rRbYJyCV0LVNsc0hAYcRqOawd6aYUBRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PCI: Add vendor ID for the PCI SIG
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 10:39 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Jun 2021 08:17:23 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > This ID is used in DOE headers to identify protocols that are defined
> > > within the PCI Express Base Specification.
> > >
> > > Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> > > 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  include/linux/pci_ids.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 4c3fa5293d76..dcc8b4b14198 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -149,6 +149,7 @@
> > >  #define PCI_CLASS_OTHERS               0xff
> > >
> > >  /* Vendors and devices.  Sort key: vendor first, device next. */
> > > +#define PCI_VENDOR_ID_PCI_SIG          0x0001
> >
> > Should this not be:
> >
> > PCI_DOE_VENDOR_ID_PCI_SIG?
> >
> > ...because I don't think this value will ever show up at the typical
> > config-offset 0 vendor-id, will it?
>
> Good question.
>
> Whilst I agree it is unlikely to turn up as a conventional vendor-id
> (though I've not found any text ruling it out) it already turns up
> in locations other than DOE.
>
> Many of them aren't software visible, but potentially places
> like SPDM are in which you would have a registry ID of 0x3 (PCI-SIG)
> followed by the PCI vendor ID (this one).  Those are used in SPDM
> vendor defined requests / responses.
>
> That SPDM feature is then used in IDE establishment.
> The IDE ECN (via pcisig.com) has the following:
> "The VendorID field of the VENDOR_DEFINED_REQUEST/
>  VENDOR_DEFINED_RESPONSE must contain the value 0001h, which is assigned to
>  the PCI-SIG."
>
> Which to my reading, isn't quite the same as saying it's a vendor ID,
> but nearly so.
>
> Now, I argued the *_DVSEC_* naming in the CXL one based on the spec saying
> that was all it could be used for but I may well have been wrong longer
> term.
>
> I'm fine with renaming it to the PCI_DOE_* version then dropping the DOE
> when it gets used for something else though if that works for people.
>
> At least this time naming isn't made awkward by legalese.

For fun I did a lookup for vendor-id 1 and it came back "Fry's
Electronics Counterfeit Flash Drive"

https://pcilookup.com/?ven=0001&dev=&action=submit

The potential for it to be used in other places outside of DOE makes
me think the way you have it here is fine.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
