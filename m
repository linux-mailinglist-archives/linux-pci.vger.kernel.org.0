Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3276B39FEBE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhFHSPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhFHSPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 14:15:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DBC061574
        for <linux-pci@vger.kernel.org>; Tue,  8 Jun 2021 11:13:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h16so12415367pjv.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iT+9YBrKWyvo8mgRDDIbA4IQmgaCVWxrYlNqzLFn14A=;
        b=XWFQqNL+YQzcDYg1eQjRy6ODMPIoqWVBIFfosXpwaZRK8MhvQFGnjWBjRt9BfvCENn
         UyQKBb7O47B0Wtw6yaP5RkPmGchKOQJu+qQJYc1HuTJKFudJATDVdbgxorEsWiH/Ofl4
         r6YB8ZEYXw1G11/Jc2RJRizUtOBc0t/FNMJ3ijlhGgkM4J7CjkcbWn8lkQYoUVDOn0ot
         soaNpink9zJyMQXb+aRH28J+IuzobcdbMVK8SHNAFTU2J1GyK3Ku2cgGBCJr/gWFfBs4
         aB8hA4KJxXCWwgPMgPMF6LffeRGXEuOo71mwmURkSr2MAZErRvvFugEt7O5PSn+3yS3q
         z56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iT+9YBrKWyvo8mgRDDIbA4IQmgaCVWxrYlNqzLFn14A=;
        b=JipykKCW2YLN61YGssIpqZ/5r4hKiW9hbCgdSxCKbR9k0akAoi1ZkMN0KEbE1ET9Zg
         diS8sUvqAvVeLZDRSNX2lgB4+qOC0iX1D9hMAwhPhxiDq/f3s67iUeg0y3Q48lWzJ5F8
         gBfHPc5sQ1tfKyUpPXofTbwhH+6+TJWTHBz2PWLhgGPQXrjLWKQWCkOYyHJztfkDzaqr
         NI+t4o0TJL1Zrd8o+PjW8iQRPL5znFwn2VYA/PAkSl85hth91jb8/5iHqyeO9t2xYHx1
         0vCBVn7gvSw6TD9RpWCUnvXCgqBrrtWO0HRqT6YvuDpNof5Enuipn4F2iH4R+Vj5PZHY
         ilRQ==
X-Gm-Message-State: AOAM532feBfdXeO/D+FnLl2L4C7WX4l8mg7kSLhXjJzQ4YOnFBp3M9ya
        xARvE0inxuVfEA/rrWxUeP1T+spxSZqdWQYBkVpNaA==
X-Google-Smtp-Source: ABdhPJwr+hP9MAmrFS5OZIs04DD3i9Ns4fWBZ3I0XpBW1UqqYivJHBEfXlqvob2ZNgEaHfcPgCXk6tWZMi96ZuF6cwI=
X-Received: by 2002:a17:90a:ea8c:: with SMTP id h12mr4282256pjz.149.1623175991178;
 Tue, 08 Jun 2021 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com> <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com>
In-Reply-To: <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 11:13:00 -0700
Message-ID: <CAPcyv4hBVK+ndxGdJykFiTihNKbaBidmmcVh71mvOhkouwZj+w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 7, 2021 at 10:03 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Jun 7, 2021 at 5:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > The recently released CXL specification change (ECN) for the CXL Fixed
> > > Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> > > Table (CEDT) enables a large amount of functionality. It defines the
> > > root of a CXL memory topology and is needed for all OS flows for CXL
> > > provisioning CXL memory expanders. For ease of merging and tree
> > > management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> > > such a way that they will not collide with the eventual arrival of the
> > > definitions through the ACPICA project to their final location
> > > (drivers/acpi/actbl1.h).
> >
> > I've just applied the ACPICA series including this change which can be
> > made available as a forward-only branch in my tree, if that helps.
>
> Yes, please, that would be my preference. When I created this patch
> the concern was that a stable branch was possibly weeks away.

Rafael, I see "4a2c1dcfaf59 ACPICA: Add the CFMWS structure definition
to the CEDT table" in your tree, I can safely assume that commit will
not rebase at this point? I'll likely rewind your acpica branch to
that point and merge there to avoid carrying any unrelated follow-on
commits.
