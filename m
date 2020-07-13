Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA721D4AB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGMLRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 07:17:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37691 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMLRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 07:17:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id 12so10656097oir.4;
        Mon, 13 Jul 2020 04:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxHZ+WJ7gl/kfFuw5mZWEwR5qtLWbkNAErzAGlqlI+M=;
        b=XXIg+d9Nu26xRIcZvGf/WkvVP9EmZ/uo6l2+DkL9UPyAiacOuX35vvjV1TXPYr/LtQ
         iAchSaUvETOZVE/1ZRtpiGsH0/mw9vaNv7tCmFRnmeRK9Zdm9ZPGL/A2Eyudw7aOJfBC
         P4t1e/KS9qhYE/aaFHONal2rdKe4JwtlmGd8ME6hZ1hcoeHPWRwgZJPOkV9uGFrwf2cR
         x+Mn6TAcIP+lznSx8X8vGHrUklA+ZIviwco5vzuRZ265WsYUdwh2MrsKrZRXRKMx/OBC
         rE2qKvqEgCLDoIEgYM9a6WdlMkwabl1mcs+lQoGb85jD8QFl+ZqiAK92/SF9p5CUSnS4
         Z3lQ==
X-Gm-Message-State: AOAM532dU4700m4FhqJ2Mv71oH1qJ3n0UMrSQ5uZr6CGcC7Qz2OxHSxm
        eDyuR2Ufpe8OU8PX8QX1DBVXGFS6Fy1FdtEEVhw=
X-Google-Smtp-Source: ABdhPJyoLEUbgUanvggbAuiWxx6tG0pbvTKcqE019Cf4J51+OoImh2nW2kLi3Y6TzKoBvHUOr7Wm7P7xrszUfxIFw6w=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr13870224oiy.110.1594639068426;
 Mon, 13 Jul 2020 04:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200622120527.690-1-shiju.jose@huawei.com> <20200622120527.690-2-shiju.jose@huawei.com>
 <05c8916f4f85421f871e9cbff112512b@huawei.com>
In-Reply-To: <05c8916f4f85421f871e9cbff112512b@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 13:17:31 +0200
Message-ID: <CAJZ5v0gfpsejvNAOso2ODqLdSBCZFe=mV32BtTr6aZ2-C=X-BA@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 10:35 AM Shiju Jose <shiju.jose@huawei.com> wrote:
>
> Hi Rafael, Hi James,
>
> Can you help to merge this patch because I added and tested all the suggestions from James.

I could apply the [1/2] in principle, but I need an ACK for the [2/2]
from the PCI side.

That said, it looks like the [1/2] is a James' patch that you are
sending with some changes made by you.

In that case the ordering of the S-o-b tags under it should be
different (the S-o-b from James, the what-you-have-change line and the
S-o-b from you) and also the From: tag should point to James.

Thanks!
