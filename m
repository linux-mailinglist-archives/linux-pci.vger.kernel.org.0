Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858FE39E4B8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFGRHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 13:07:00 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:42547 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGRG7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 13:06:59 -0400
Received: by mail-pj1-f48.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so442155pjb.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=ed/0PzMWKcKEyHTP/yKjwBx0JvITUSJQcZm8zLlSmnLmTn3XfbBvCvTUprBKit9LiI
         mEfZstpZ3HjM4s5khmBvBsJH5XdDYs75OEPphft1zPtGdG19kU5l7Qlu/lko9AmpgoK9
         qknyWnlJ8aIDK5ItieJ1cII0XqSLwUe6h7PBLQ0xnTzzzeGgARou9TXEx6NJ1mTWa+dz
         PboVozhKwY82GAQ/HNVbBi4ykNnfwnOjefgWT/P3nMz8jalTcpRqQ6XxZitfCdIbOMHG
         8HGzmoRQp53yAfDM6W+uPM3XfWtvsu2WRGhyqB9p6ocpzivvWRB6d16bwdVDKhCqDrsQ
         UTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=J96owazD494AuxZ4jqKax/QGSzFAy5f+4bf5qCd7m2XP4M0XwmGDg/e2HHUIyrYE+r
         aUjv2CSUW2NlaNju+HG8Ay8WbH4NyTjh3blLcZHGP8WlUoK1BejHCvkI5Zn4vrQHYW2J
         dV5DMuqig+Wd/PmTOYGAL6/BppqSdga7Pw+AgcrFs5HpYYYdB2OhyhCmBnmr2Nc/c2r4
         h1YHHgVZ8XLn6qLaTMpUzg6CC/FY9/yzsP16jagyhTqZ0Z6yWngolDLLkNOYPNWSDeQi
         dYlAOR93CdbIwqw9PdQtWe4lsRAuXytVpIKIk8YnXR8TF4HoWlVwstPrN5hPl8Sp95dB
         sp8w==
X-Gm-Message-State: AOAM532feSaYsTzqq2tnc+mM0hDuEz42m45lt05viz01LVvlBqXzIb4a
        G+qPM6XQOLSfMXYc/dvrMY7eVTl3bQ2T5F8Xm+pYCg==
X-Google-Smtp-Source: ABdhPJxYAfvSMbKm5tmzBj3vnoPe4a8Paiz65/ivTITcRl25ajJ+YtxumvZdZK55xIyWjmiQ3dvqnRN/amfMUhHvDrM=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr114198pjb.13.1623085448150;
 Mon, 07 Jun 2021 10:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jun 2021 10:03:57 -0700
Message-ID: <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 5:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The recently released CXL specification change (ECN) for the CXL Fixed
> > Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> > Table (CEDT) enables a large amount of functionality. It defines the
> > root of a CXL memory topology and is needed for all OS flows for CXL
> > provisioning CXL memory expanders. For ease of merging and tree
> > management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> > such a way that they will not collide with the eventual arrival of the
> > definitions through the ACPICA project to their final location
> > (drivers/acpi/actbl1.h).
>
> I've just applied the ACPICA series including this change which can be
> made available as a forward-only branch in my tree, if that helps.

Yes, please, that would be my preference. When I created this patch
the concern was that a stable branch was possibly weeks away.
