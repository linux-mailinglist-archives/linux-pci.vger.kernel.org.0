Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C0834D063
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhC2Mu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 08:50:28 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36824 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhC2MuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 08:50:23 -0400
Received: by mail-ot1-f50.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12142376otq.3;
        Mon, 29 Mar 2021 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=br2tK1trYV4Jvbr3eTgWM2JDYY7hp12me+F3CgBMdrA=;
        b=WlOKAKWAD1t30AIC64LCiFY1BwIIzb9fXU48yC3SQhKZB71X9gfvfevHIOOMwzXpV+
         qN899qFjtXv44uF/vwWiPA+lc84YaSYtTMoJgk+q6cz8DOINloYEDNaAH5MW4yY52GlW
         7FL9c/EbJPyiibYvEqI9d4MDTbxl7FD4uhvkmCUE4RyI3IrCY6HKH3LhXSctf6ixFY06
         QayThEMNol8u/JlwGB7NmeydUuGh0Sjjry5R7wAM3XIX9Zrish8W0eUEuOvo3EaUVr/I
         F+jUklpoRiTU5SEmtKroX0A8BKhG1UkItTJPFAjt8h/BJEQd803MFXLEGxiKqapx8C1b
         +FfQ==
X-Gm-Message-State: AOAM533YEynOecuLKLsDh2UezyHJV+R2iXTUI1CVoJrdI+xqLg3G2T2q
        efthYBZyY/hrD9JJdllyehZMVvut4X96yfEqZEs=
X-Google-Smtp-Source: ABdhPJyJTrglwRj2zltNzATMDclxPvxrsMLnZATq/gbKpWmce0C83JluLrG5v0kceaqH+WKTiJ5e3hauxUXLybLMCP0=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr22296906otq.260.1617022222927;
 Mon, 29 Mar 2021 05:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 14:50:08 +0200
Message-ID: <CAJZ5v0i=RPyvWfVuGQ0nWf_0QRw70=qZd6j85CTPWaaWPa_5KQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] acpi: fix some coding style issues
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 1:11 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Fix some coding style issues reported by checkpatch.pl.
> Only cleanup and no function changes.
>
> Differences from v2 to v3:
> - Remove the modifications that may cause function change.
>
> Differences from v1 to v2:
> - Add subsystem and module name in the name of patch 05/15.
> - Change to use more proper module name for some patch names.
>
> Xiaofei Tan (12):
>   ACPI: APD: fix a block comment align issue
>   ACPI: processor: fix some coding style issues
>   ACPI: ipmi: remove useless return statement for void function
>   ACPI: LPSS: add a missed blank line after declarations
>   ACPI: acpi_pad: add a missed blank line after declarations
>   ACPI: battery: fix some coding style issues
>   ACPI: button: fix some coding style issues
>   ACPI: CPPC: fix some coding style issues
>   ACPI: custom_method: fix a coding style issue
>   ACPI: PM: add a missed blank line after declarations
>   ACPI: sysfs: fix some coding style issues
>   ACPI: dock: fix some coding style issues
>
>  drivers/acpi/acpi_apd.c       |  8 ++---
>  drivers/acpi/acpi_ipmi.c      |  1 -
>  drivers/acpi/acpi_lpss.c      |  2 ++
>  drivers/acpi/acpi_pad.c       |  4 +++
>  drivers/acpi/acpi_processor.c | 18 +++--------
>  drivers/acpi/battery.c        | 63 ++++++++++++++++++++------------------
>  drivers/acpi/button.c         |  9 ++----
>  drivers/acpi/cppc_acpi.c      | 71 ++++++++++++++++++++++---------------------
>  drivers/acpi/custom_method.c  |  2 +-
>  drivers/acpi/device_pm.c      |  3 ++
>  drivers/acpi/device_sysfs.c   | 15 ++++++---
>  drivers/acpi/dock.c           |  7 +++--
>  12 files changed, 106 insertions(+), 97 deletions(-)
>
> --

Can you please stop sending new versions of this for a while?

You've sent three of them over the last weekend and honestly I haven't
had a chance to look at the first one even.
