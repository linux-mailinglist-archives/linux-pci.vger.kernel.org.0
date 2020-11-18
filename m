Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6B2B7C38
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 12:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKRLPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 06:15:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37552 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKRLPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 06:15:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id m17so1791637oie.4;
        Wed, 18 Nov 2020 03:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8wT37MkPFkyxY6qYH5+6Fkhw2mpanFwYZDumxMMKKk=;
        b=HyHYGweC6n65p+vjQ8/8miLZYweHigIBz4YeORsAnKGEDjb452OSKvcYNxHXy1irjb
         hXFSzv1aZ8usyQsRJzDyuhWX9Vb9hA8ttiY0EX89XSYccfCS3TsK+Ub1KJL8mnPeHUaz
         cSVp8AfSzbq1bKTxx2CRAvNqFMde6JcfVy20IYZO4iWDvsUrL+pOcnppd+4tu3bXDEdo
         B97MI/Xf2LF1AvSzWL2Kr3XFRcw5cbaiHHy7sYFa5qJXwqGHzqghI+WimeUcyfoBpVQp
         uHDdE1gAQSXPYC6yc/N0l1RP1v8SCI+0f0gOQ5nwvMyhaHTcNKwhrCyTkG2lz/obF5O5
         TGVw==
X-Gm-Message-State: AOAM530BapPIJyxlarGunAZBc1jK9QuAlpvCaP/HKkA84OnSf0ZvHS2d
        gxEyJBuLRpQdVCgc3n1FW9D9gTUSmkx9a5Y3t8g=
X-Google-Smtp-Source: ABdhPJzei9Pt9brHCLe1ebo8Ar52GK3xgnsIYzUePmBrlhAXtq1sMyLFWo7UO2GTITvUtXBAJsO4hUqZYtB8eqd5Eeg=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr2294643oif.69.1605698108951;
 Wed, 18 Nov 2020 03:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-2-ben.widawsky@intel.com> <CAJZ5v0i7fcoBe5o-J7q5fYW_1nUYJ-QdshWOBV5fFf85rD_sDA@mail.gmail.com>
 <CAPcyv4i6MCu6RmLCyE+K-j3bbtrYeA+hJXL4+Zy_Tfhmwv2ErA@mail.gmail.com>
In-Reply-To: <CAPcyv4i6MCu6RmLCyE+K-j3bbtrYeA+hJXL4+Zy_Tfhmwv2ErA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Nov 2020 12:14:56 +0100
Message-ID: <CAJZ5v0j_ReK3AGDdw7fLvmw_7knECCg2U_huKgJzQeLCy8smug@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 10:45 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Nov 17, 2020 at 6:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> [..]
> > > +static struct acpi_driver acpi_cxl_driver = {
> >
> > First of all, no new acpi_driver instances, pretty please!
> >
> > acpi_default_enumeration() should create a platform device with the
> > ACPI0017 ID for you.  Can't you provide a driver for this one?
> >
>
> Ah, yes, I recall we had this discussion around the time the ACPI0012
> NFIT driver was developed. IIRC the reason ACPI0012 remaining an
> acpi_driver was due to a need to handle ACPI notifications, is that
> the deciding factor?

Sort of.  In fact, a platform device driver can still handle ACPI
notifications just fine, it just needs to install a notify handler for
that.

The cases when an acpi_driver is really needed are basically when
creating the platform device during the enumeration is not desirable,
like in the PCI or PNP cases (because they both create device objects
of a different type to represent the "physical" device).

It doesn't look like it is really needed for ACPI0012, but since it is
there already, well ...

> ACPI0017 does not have any notifications so it seems like platform driver is the way to go.

Indeed.
