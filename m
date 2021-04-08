Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07E5358728
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhDHO3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 10:29:15 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:33555 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHO3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 10:29:14 -0400
Received: by mail-oo1-f49.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so559749ool.0;
        Thu, 08 Apr 2021 07:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H04usHloaVg6tf6A8ybuI1YTbDpURH0NcMFvOKIlRQU=;
        b=oX3m8+x+oj3Dr2nMmjzQu02VqXj03kfelebUinN9mBHLAgqXYJF6fZXQUNL0YJjO+x
         PHkjtcoO9yzmCbaIiDy9YTD1S9t6sSfKtWZ+qf6ncnz+wHJTsx/C1WGvXff7jpJ6MfTw
         0Zbbbxu7LbxJzn3PKTbdCbYNqkfUSmVLIBsBOlGPDTx1sVdRbii7pfYk82EzKGKA+eDG
         gtsnIhhKKd8bduzYfnY4J086Negt0ZaG/k5Hjmc048n6mdBIAMLCldk98UtnlgkL0POX
         Eg7Qwr8RDEbWI5njTQubc6Lc1rIov7um6A2ozML2hrv0Y8t5RlbF5ojCGwG7iKOJkhMc
         uNtA==
X-Gm-Message-State: AOAM530ofJQ8rmwhWVTmb52gSrvzLSli9thS/0d4gm6u3hdPbCzMyI8w
        npmmk99F1+YTaMKcWf4MeeAMTmZLnw8IMtstK5A=
X-Google-Smtp-Source: ABdhPJyX+7fnmLnCETM7MrmUY9bylTJxEFAdLApno+5ZbW7NFaljU1VN6MCtAKB8dVUH1FdOzdvfB7Y43869vOkk1+Y=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr7726147oos.2.1617892142020;
 Thu, 08 Apr 2021 07:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 16:28:51 +0200
Message-ID: <CAJZ5v0jNktGd+dPZG-1ui3qZt9GZH5AbTae9uQBQCWYMj-y+VA@mail.gmail.com>
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

All applied as 5.13 material, thanks!
