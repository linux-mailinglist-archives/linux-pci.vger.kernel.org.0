Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E001A6319
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 08:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgDMGgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgDMGgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 02:36:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAB3C008673;
        Sun, 12 Apr 2020 23:36:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so4691483qkg.1;
        Sun, 12 Apr 2020 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMpw6K79lA/hKqIcCn2kKRSspiTDXkb2D8JjBGFr8zQ=;
        b=uz5+521nlHBocaytihEXa/MzRtF6lSl6OnhByj/4tYGgzxMgsJepipn9S0nNQZMDJz
         P9ee2v+EOPvrZl1stRWdTm9Of9V5vQioB7DSLHUIFvX8TZX3V1LKRUTYZ0fERav4znaL
         ZQk7orz6i9h4g6ZzPYHczp93XiJ1euMZ2rulHWmEGDtfoxa4CRd/aewcwaAEHQdI75YQ
         umHMLAFnEEzpJsCqD/LGFB7rPxGqxW9NBs//tY0mSGGrX1NmQJq+BRbg3orUyls6Eq5f
         nMjVM/Z+9Tvx9dFxQHWvQGH1c63oXgjcGODdQ7gvgZTD0bQCB1/tpNBC/EHYReMxxX+J
         oKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMpw6K79lA/hKqIcCn2kKRSspiTDXkb2D8JjBGFr8zQ=;
        b=tgqWtRRrxSr2eDB/injdtVY48C4Ki1TeIZ/oQz6vho80zdfdI8SgHX8YETDSlapzGq
         JPSoiq9GdKnusBkzmEPQ/JTmq3DJoWBrBJ4XEGbMQ+EP/vdYXs51yK7p2O4nQZGzdfAL
         hZ/XTzoRHQyXEMux98sq3bfzQMAZEQfK11ZGQWZKoiQdiQRjGHsDuqOaGW5RL6i8E/U2
         FPe94y6mOmDhkEf1Nr20ImDAwuUw4zM7pP3r8wekiKbXH2grtTSLEaeF1SsstnUqnQPJ
         iSZtE76y+N0yZChluiMYylYi9uBxLiWZeFY9/CpU25C/rVw/0rqu/CRxDiss/mqnWpEu
         GWqQ==
X-Gm-Message-State: AGi0PuZ55bqQ9oU4+nwCRXo5BALb5VDWQVThe4IKTmOn4vjsOwVp5rVz
        C5MWyAUUVkTiJ3nXhfHlOGC1eQDa2KP8bVf/Jng=
X-Google-Smtp-Source: APiQypLAkeIgbG9vE5BMPoUzyd5dJuTAeNpXUZF1UwhH8UT1xsBlzhBm3dFEKEbDE+I8yBJb7oDCmyFUzPvyYPBCdUQ=
X-Received: by 2002:a37:ac6:: with SMTP id 189mr952703qkk.60.1586759759747;
 Sun, 12 Apr 2020 23:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <1888197.j9z7NJ8yPn@kreacher> <5092680.jloV5Ae5OO@kreacher>
In-Reply-To: <5092680.jloV5Ae5OO@kreacher>
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Sun, 12 Apr 2020 23:35:48 -0700
Message-ID: <CAL3LdT71aa3NfqoGTvmz-XzS7Ng=LqpwPROWyf=w_+PyvEET-w@mail.gmail.com>
Subject: Re: [PATCH 5/7] PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 9:03 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Rename DPM_FLAG_NEVER_SKIP to DPM_FLAG_NO_DIRECT_COMPLETE which
> matches its purpose more closely.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the driver changes to e1000e, igb and igc.

> ---
>  Documentation/driver-api/pm/devices.rst    |  6 +++---
>  Documentation/power/pci.rst                | 10 +++++-----
>  drivers/base/power/main.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>  drivers/gpu/drm/i915/intel_runtime_pm.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_kms.c        |  2 +-
>  drivers/misc/mei/pci-me.c                  |  2 +-
>  drivers/misc/mei/pci-txe.c                 |  2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c  |  2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c  |  2 +-
>  drivers/pci/pcie/portdrv_pci.c             |  2 +-
>  include/linux/pm.h                         |  6 +++---
>  13 files changed, 21 insertions(+), 21 deletions(-)
>
