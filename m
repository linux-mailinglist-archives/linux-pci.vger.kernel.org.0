Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5E1AF310
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 20:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRSIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 14:08:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34753 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgDRSIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 14:08:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id 8so397977otj.1;
        Sat, 18 Apr 2020 11:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLJngupcywgnMR82TqdZKZr1eEprvnTgR3v/FNMOKrg=;
        b=UBBU0CC828Q3eu8kWV1YswfgWGodW5jIUPAnnDJLOJr2PmTB5jSzhjFwgKrqYkYprN
         u6qdWU4ckumoV0NZ2DpSR2gHMQUJiRP9xkk3y9/rhPB03AwG8Zs+2x92z6FDAvFkgP5C
         SoV1PETRpBsyusUuGTvxzBrukc8RkYvRTLEIT2kN3RDPIqVHnaM78C8vf7ZhICOoouJp
         kIU2ByMGOswadL9npUnxxr+4A6C1iCp2tGpFNCXjlrBwtKyHc7y3NiXsZHiqTjMcgyGg
         6wF+3aEX7wBCnU5ZHH9mntSGxtl21p6MurqVTiO08ExC5JvPggPTmpD3QgspzuH/GKnW
         UgAQ==
X-Gm-Message-State: AGi0Pua66YupCBf/e/8ahZqjgsYwg89DbHtdx1Xuag72YCsPlr4VvICx
        DSiAX6vfq7evKQZXwfdHxYowxuCWNOWsA14SikY=
X-Google-Smtp-Source: APiQypJglJno/ncjr7rJgMge6SotqwSZ0EY57A3iTHjuavimH3o9LJ4snUV77A2wQh3CwWu523P9Or+ovKvgrhH74PA=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr3529283otm.167.1587233292593;
 Sat, 18 Apr 2020 11:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <5673945.BT02kTCndr@kreacher> <Pine.LNX.4.44L0.2004181356070.2069-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004181356070.2069-100000@netrider.rowland.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 18 Apr 2020 20:08:01 +0200
Message-ID: <CAJZ5v0hAyLv2+xE_eMgmra5kccDLGY941inJbKZyWPStKXk2nQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 18, 2020 at 8:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:
>
> > Hi,
> >
> > This is an update including some fixes and extra patches based on the
> > continuation of the discussion [1].
>
> I haven't checked the updates in detail yet.  However, it seems that
> dev_pm_skip_suspend() and dev_pm_skip_resume() should be EXPORTed,
> since they are intended to be used by subsystems, which may be in
> modules.

OK, so what about an extra patch to export them?

Currently there are no modular users of these functions.
