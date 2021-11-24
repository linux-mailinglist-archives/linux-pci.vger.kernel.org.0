Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E645B305
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 05:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhKXESc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 23:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhKXESc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 23:18:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FACC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 20:15:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f65so999567pgc.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 20:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxLF7u8QoM20c372oL9wZ9ZMbqobmlvg8VEP/5FR5bw=;
        b=rXcXoN9mjL9HrOaVuVtr0OkHqnoLKOCUGz9XXIMvBXGU8zsOAWbjvutZy+O9pXOGbm
         eSjnHVSuutZ5RAPctBjRftWx5lyNMq+cLkiliGVSKtmfHOYCJJ7VI9tVMgwkEauaN837
         HOYtZYddjYFnc5UDVkK960qAZVheSl1a8q2tx2YQ9k+5Z8rz1he9fx7/22JbCcnqNCxB
         7FaVpqndimVqCoZ+mLq7VZLxl26PhNCrDYWot7W47EXe92rONBodpmjWZhhaUFxkcHQl
         OovvbP105Dtch1rSxJ3L2f75iX7pcYOkUaGfgbjeQv2k7F6wWVq3CuJMlieIVZO556BB
         K9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxLF7u8QoM20c372oL9wZ9ZMbqobmlvg8VEP/5FR5bw=;
        b=Kxwr3Wog9ycb6SUyn9U9bPx7KWtxLfqg+uoJQ6J8kfadCILqwh+Ryqutz/+g/hEMUz
         7+7Pr4NSWiEd5y3YStcC6H3VbmxUa+yfT49Ra3Qik1cGnqneuR9c4XDAVfpyM4l+qk8H
         GlFuRHFVnyAMmwZfQlho5tWmJNK577mS285yYwveAaylIW7VmO49jyjLfra09DA5LjXt
         SuUrXMh6iyp8CSUh/MxKWezLz8mMp3UBseU72AAwSsFNJvy1QRsl1r8pwABQ5uaKpDip
         5MqiES6gwZagl37LeP1vuBrGOXMDI95i59wdpM7xTSjf/A3ViIgSf+Brbqz+jugz9TVA
         HMOA==
X-Gm-Message-State: AOAM531JmrLYeoMeG9zBo49juZPhpRmMEk85heDE1jqMv8Utzeb3b2ww
        WqmNmTSqP32rVmxksVGPQRHiQs2yniySpL3KT1/84wSS10A=
X-Google-Smtp-Source: ABdhPJwn8C0TVVqaIkNJMKGMZskgbr7QkoamHPCDWPdmW74faUztMSRwKmwGJ2ltAb/0UnFcxQ39nsQ7DZeKTFbl8sk=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr2819706pfe.86.1637727323026; Tue, 23
 Nov 2021 20:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-2-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 20:15:12 -0800
Message-ID: <CAPcyv4iinb288amqu=QZ78wXMSNOADTtTzybcSVgKKvm74u-Sg@mail.gmail.com>
Subject: Re: [PATCH 01/23] cxl: Rename CXL_MEM to CXL_PCI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
> Rename mem to pci"). In preparation for adding an ancillary driver for
> cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
> rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
> that new driver to manage CXL.mem endpoint operations.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since RFCv2:
> - Reword commit message (Dan)
> - Reword Kconfig description (Dan)
> ---
>  drivers/cxl/Kconfig  | 23 ++++++++++++-----------
>  drivers/cxl/Makefile |  2 +-
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67c91378f2dd..ef05e96f8f97 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -13,25 +13,26 @@ menuconfig CXL_BUS
>
>  if CXL_BUS
>
> -config CXL_MEM
> -       tristate "CXL.mem: Memory Devices"
> +config CXL_PCI
> +       tristate "PCI manageability"
>         default CXL_BUS
>         help
> -         The CXL.mem protocol allows a device to act as a provider of
> -         "System RAM" and/or "Persistent Memory" that is fully coherent
> -         as if the memory was attached to the typical CPU memory
> -         controller.
> +         The CXL specification defines a "CXL memory device" sub-class in the
> +         PCI "memory controller" base class of devices. Device's identified by
> +         this class code provide support for volatile and / or persistent
> +         memory to be mapped into the system address map (Host-managed Device
> +         Memory (HDM)).
>
> -         Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> -         configuration and management primarily via the mailbox interface. See
> -         Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
> -         details.
> +         Say 'y/m' to enable a driver that will attach to CXL memory expander
> +         devices enumerated by the memory device class code for configuration
> +         and management primarily via the mailbox interface. See Chapter 2.3
> +         Type 3 CXL Device in the CXL 2.0 specification for more details.
>
>           If unsure say 'm'.
>
>  config CXL_MEM_RAW_COMMANDS
>         bool "RAW Command Interface for Memory Devices"
> -       depends on CXL_MEM
> +       depends on CXL_PCI
>         help
>           Enable CXL RAW command interface.
>
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d1aaabc940f3..cf07ae6cea17 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += core/
> -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>
> --
> 2.34.0
>
