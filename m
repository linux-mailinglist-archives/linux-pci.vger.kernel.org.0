Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92181563B4
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgBHJz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 04:55:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33323 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgBHJz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 04:55:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1149561pgk.0;
        Sat, 08 Feb 2020 01:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kF+soCCC+WAMeBvEXOjQ1pBqC3GDbIPValitgI3ASvY=;
        b=T/K3VRV3YIa7eEYSR/cB/qi6JO5gQ2xhVOShRUkq1BCEmZHxELulM82+pg0JM45+g8
         NK+1qPb+3XsI93CaxYwjwaRJDpwRELNIYy/RWkjYXXAEea+Ac2BOl+/bQuPIMs5PlyMl
         F8516Ld+/hrhr5SZzHFQ1K0EK/Ezi5rcgcx5iu9tHgC+Fd0JNlP/vFvE/uJtEGTSCKV9
         lsLsKLDwGJ4qQTpGFjwBYknYxrHrPb9SEyKtkb5BHTSOlGn74YAslDK8lv7s5BBFhkCp
         p+rT1Ui95F5ayOpqKRC4xL5jsjJRO2nU6PlV0dDBJ//GNFODV6iSX90Qup/MZhctGcuj
         cnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kF+soCCC+WAMeBvEXOjQ1pBqC3GDbIPValitgI3ASvY=;
        b=E4Dx9CNHTViww23hgGIBTWss0w5mnKpvw0nJZnZsoanSMokutuAYEboaxuWOGMobPV
         oleb+47hXylUGoIKEsnrt1pkq76TJQf27Nu2twRercTfxk7zmHq7omU2cf6VF+SQDJT3
         9hRchPUYyz/apkQHSqDNDVLSsXBtaAXiC5qt5HPgZ6+1bih/ZhbvpcsKwLk89UxZnJGc
         iuUrqOnq5L4oC9xuYJCorWRo1A+frEL4mHTCKM9dAcOOddhFmwreuqiht/rCfjBlhGou
         sdkEiXIdN1hVNlAidjR0qA3aWuiBVhAYr/RQtT8ecf/m7LBrVgDx1c6EN6myadvQZpFr
         923A==
X-Gm-Message-State: APjAAAWwkMUfqKdOSPstLuPK+gdT/i8Q+haS2pNeM6iBdssXqd4ELjvm
        1akUWMakoOm7xrTd2Mua4mVmH88/2xoxujiRUXA=
X-Google-Smtp-Source: APXvYqwhEJpnaRHjef6gt6GC2LPLvFpxW1xQBIoq+7f4Z9uqvcKcauUidC7WPOtZO56qgS5Stp9kfP56c5u7aFqZoNc=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr3894544pgb.4.1581155754689;
 Sat, 08 Feb 2020 01:55:54 -0800 (PST)
MIME-Version: 1.0
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com> <1581120007-5280-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1581120007-5280-2-git-send-email-jonathan.derrick@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Feb 2020 11:55:43 +0200
Message-ID: <CAHp75VeuzA+y2RzDiirskuZmwiBX4J3xz4S6jd_bikScQ52sRw@mail.gmail.com>
Subject: Re: [RFC 1/9] PCI: pci-bridge-emul: Update PCIe register behaviors
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 8, 2020 at 2:02 AM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
> Update the PCIe register behaviors and comments for PCIe v5.0.

I think you may elaborate the changes here, like a summary.

> Replace the specific bit definitions with BIT and GENMASK to make
> updating easier in the future.

...

> +                * Device status register has bits 6 and [3:0] W1C, [5:4] RO,
> +                * the rest is reserved

Perhaps it makes sense to add '.' (period) to the end of sentence. And
the same for the rest comments.

...

> -               .w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -                       PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
> -                       PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
> -               .ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
> -                      PCI_EXP_SLTSTA_EIS) << 16,

> +               .w1c = (BIT(8) | GENMASK(4, 0)) << 16,
> +               .ro = GENMASK(7, 5) << 16,

I'm not sure the new one is better. Perhaps you need to add
description for the new bits and, if you consider it's needed, add a
picture of the bits in the comment, like  XXXX rwX1 XXrX XwXX, where r
= ro, w = rw, 1 = w1c, X = rsvd. But it's up to Bjorn and you, I have
no strong opinion here.

Same for the rest similar changes.

...

> -               .rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
> -                      PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
> -                      PCI_EXP_RTCTL_CRSSVE),
> -               .ro = PCI_EXP_RTCAP_CRSVIS << 16,
> +               .rw = GENMASK(4, 0),
> +               .ro = BIT(0) << 16,

Bit 0 in both rw and ro -- is it correct?

-- 
With Best Regards,
Andy Shevchenko
