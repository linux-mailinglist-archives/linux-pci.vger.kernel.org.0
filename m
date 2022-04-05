Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6F4F3EF5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiDEOqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349825AbiDENGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 09:06:07 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800175625;
        Tue,  5 Apr 2022 05:07:16 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g9so22971564ybf.1;
        Tue, 05 Apr 2022 05:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knCnV41xjhnnJ0VL0WEqN+kHikKWH8noX35ww6a147E=;
        b=O7lckBcjELkuaLNv/vx9Zk/dwxb9uNuvdTAK9RfD2UeFpLI+xa1ocEs2O+vfLgUcsy
         E6lMViABScXgrmVNn0UwQsQhGsBMZjx2E+J1SF4r6LWvm47xalDPaI0XJ2x+wI7/O4VW
         hLWnU8IchmREOD59IjWNEVY3v3AhTniApfIMW+33/WKIqoHL00Cc5FpHrYpe82q0Sw5f
         yYlqC0H9t+ZUIzWY9yhWmmJlA9jlW+JvfvfUm1iPBPJBlGqg44x1XmHa5Mx2jl+5l5Nx
         YtKYSoqyZDYZ+I2EUT8bGKLtTFar7nvRsKdGKsStiFkHJo53hRUX/Zyy2PYRi16wMF4W
         oWMw==
X-Gm-Message-State: AOAM531oN2BMuSlLOg4c+fubzN47QHtqt6CXO/IXNgKM6WoRUnL+NEHf
        dOMvpaK3MYr/99JV7bZnf1StMsg1GNX/S5tJN+ueJseC
X-Google-Smtp-Source: ABdhPJzm72VVZWMJatZlptDAM3D3/uPEoLzUPr4PBmAZeVrej6UKEUv7t6NBnltKTsOgvbQB0rfxyKF5TOgeLVOvss8=
X-Received: by 2002:a25:cc08:0:b0:63d:2c6d:162 with SMTP id
 l8-20020a25cc08000000b0063d2c6d0162mr2240396ybf.137.1649160435809; Tue, 05
 Apr 2022 05:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <21439956.EfDdHjke4D@kreacher> <YkwQAKcFU4CzYX5E@lahna>
In-Reply-To: <YkwQAKcFU4CzYX5E@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 14:07:03 +0200
Message-ID: <CAJZ5v0ja5OKUh004wEMhrgVtk-yp_Dzvmk33xNhabjDqzV0JsQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: PCI: PM: Power up PCI devices with ACPI
 companions upfront
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
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

On Tue, Apr 5, 2022 at 1:45 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Apr 04, 2022 at 05:20:30PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > There are cases in which the power state of a PCI device depends on an ACPI
> > power resource (or more of them) in such a way that when the given power
> > resource is in the "off" state, the PCI device depending on it is in D3cold.
> >
> > On some systems, the initial state of these power resources is "off", so the
> > kernel should not access the config space of PCI devices depending on them,
> > until the power resources in question are turned "on", but currently that is
> > not respected during PCI device enumeration.  Namely, the PCI device
> > enumeration code walks the entire bus and enumerates all of the devices it
> > can find, including the ones whose initial power state in principle depends on
> > the ACPI power resources in the "off" state.
>
> I guess these devices do not have _PRE() method either.

Personally, I haven't seen any ACPI tables containing any _PRE yet.

> > Apparently, most of the time, the config space of such devices is accessible
> > regardless of the state of the ACPI power resource associated with the PCI
> > device, so the device enumeration is successful, but there are two potential
> > issues related to this behavior.  First off, even if the given PCI device
> > is accessible when the ACPI power resource depended on by it is "off",
> > changing its configuration may confuse the platform firmware and lead to
> > problems when the ACPI power resource in question is turned "on".  Second,
> > the PCI device may not be actually accessible at all when the ACPI power
> > resource depended on by it is "off", in which case it won't be found during
> > the PCI enumeration of devices.
> >
> > This patch series addresses that problem by turning "on" all ACPI power
> > resources depended on by PCI devices before attempting to access the config
> > space of those devices for the first time.
>
> Makes sense.
>
> For the series,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
