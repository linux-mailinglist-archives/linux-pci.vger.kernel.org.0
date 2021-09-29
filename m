Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AEB41C42A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 14:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbhI2MCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 08:02:55 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44010 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbhI2MCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 08:02:52 -0400
Received: by mail-oi1-f177.google.com with SMTP id q16so2538026oiw.10;
        Wed, 29 Sep 2021 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkqbVi86S7yRX44LH10zaUFULfl6o47U8MBszhuGD14=;
        b=ZJETC+kAh5NO6mpMS9GHZ1MH2ie4ZEjwSKLMH3kFpmV81VFc9K62v2Rv1JQ6qqvPQ5
         z14PE6PHzMjgZ/Le5WIn3F+7OoIVs7giRsjb92Wpp5I3iEYZripGc7OzPei2TkavEV5z
         tqtJGVIJntDJJrIaIgM/IXoNumCnWFc92qcLVoQE3LZD/Gqk8BP62OhmoxW881iyH1uH
         SxScQLj1tJOaA99UPIe/kcwFNCaAigJlS9X3FYi97LQputnQGJ7oM0vM4dm/17JCFwph
         8SJMmA7tX5Vp80pcdum8Ci7uxOyqZ2xtlwPNjyGfBIwP5M/chEz6LKPitZEEMSSpDftp
         uC9A==
X-Gm-Message-State: AOAM532znh6ZJXdDTEMu39U/L0sE5RWzPsYNoCMObHVduSs1xhAgQrym
        h7nt87q5BaaKCO2rpBgWSIr2p0wHtzFIRl0CrPw=
X-Google-Smtp-Source: ABdhPJzqBNszuxNRS1MHW5un/eHAOQLNAv1pTp/wTZ5+hlLtyH/wRTYHcac9owjxwHyr9TrOaPV6rYw2ZU6Zu8it9z0=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr7487019oib.69.1632916871234;
 Wed, 29 Sep 2021 05:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <20210928232823.GA748352@bhelgaas>
In-Reply-To: <20210928232823.GA748352@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 14:00:59 +0200
Message-ID: <CAJZ5v0gr+o_AO7-EGRofU2UN_8aXivh5c-VQ9VKz7o4ZNq=VQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] PCI: ACPI: Get rid of struct pci_platform_pm_ops
 and clean up code
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 1:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Ferry]
>
> On Mon, Sep 20, 2021 at 08:52:19PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > As explained in the changelog of patch [2/7], using struct pci_platform_pm_ops
> > for ACPI is not particularly beneficial, so it is better to get rid of it and
> > call the functions pointed to by it directly from the PCI core.
> >
> > However, struct pci_platform_pm_ops is also used by the Intel MID support code,
> > but it is actually better to call the MID PM function directly from the PCI
> > core either, which is done in patch [1/7].
> >
> > After these changes, patch [3/7] removes struct pci_platform_pm_ops and the
> > rest is just cleanups and some code consolidation on top of that.
>
> I like these a lot.  Not sure exactly where everything is after the
> conversation with Ferry.

It's mostly OK, the problem was in one of the "tail" patches that was
not rebased properly.

There will be a follow-up series to test for Ferry (later today).

>  Let me know if I should be doing anything.

I'm going to take this lot if that's not a problem.  If I need
anything from you, I'll let you know.
