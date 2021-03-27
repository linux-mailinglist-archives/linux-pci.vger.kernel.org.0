Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A908034B5E8
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC0KBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 06:01:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhC0KAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 06:00:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6vRG6dGczPmdJ;
        Sat, 27 Mar 2021 17:58:02 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 18:00:34 +0800
Subject: Re: [PATCH 00/15] acpi: fix some coding style issues
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <CAHp75VcwuFYWRYfVPxbqa4TFGgqOhHc_soefmTAZcGGk3bLuhw@mail.gmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <f8fa1fd8-e9b1-041d-936b-cd0646860d65@huawei.com>
Date:   Sat, 27 Mar 2021 18:00:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcwuFYWRYfVPxbqa4TFGgqOhHc_soefmTAZcGGk3bLuhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

OK. thanks for reviewing this patch set.

On 2021/3/27 16:21, Andy Shevchenko wrote:
>
>
> On Saturday, March 27, 2021, Xiaofei Tan <tanxiaofei@huawei.com
> <mailto:tanxiaofei@huawei.com>> wrote:
>
>     Fix some coding style issues reported by checkpatch.pl
>     <http://checkpatch.pl>.
>
>
>
> NAK until it’s proven that you have tested each change on the real
> system (virtual more or less okay).
>
>
>
>     Differences from v1 to v2:
>     - Add subsystem and module name in the name of patch 05/15.
>     - Change to use more proper module name for some patch names.
>
>     Xiaofei Tan (15):
>       ACPI: APD: fix a block comment align issue
>       ACPI: processor: fix some coding style issues
>       ACPI: debug: fix some coding style issues
>       ACPI: table: replace __attribute__((packed)) by __packed
>       ACPI: ipmi: remove useless return statement for void function
>       ACPI: LPSS: fix some coding style issues
>       ACPI: memhotplug: fix a coding style issue
>       ACPI: acpi_pad: fix a coding style issue
>       ACPI: battery: fix some coding style issues
>       ACPI: button: fix some coding style issues
>       ACPI: CPPC: fix some coding style issues
>       ACPI: custom_method: fix a coding style issue
>       ACPI: PM: fix some coding style issues
>       ACPI: sysfs: fix some coding style issues
>       ACPI: dock: fix some coding style issues
>
>      drivers/acpi/acpi_apd.c        |  8 ++---
>      drivers/acpi/acpi_dbg.c        | 40 +++++++++++-------------
>      drivers/acpi/acpi_fpdt.c       |  6 ++--
>      drivers/acpi/acpi_ipmi.c       |  1 -
>      drivers/acpi/acpi_lpss.c       |  4 ++-
>      drivers/acpi/acpi_memhotplug.c |  2 +-
>      drivers/acpi/acpi_pad.c        |  4 +++
>      drivers/acpi/acpi_processor.c  | 18 +++--------
>      drivers/acpi/battery.c         | 64
>     +++++++++++++++++++++----------------
>      drivers/acpi/button.c          | 10 +++---
>      drivers/acpi/cppc_acpi.c       | 71
>     +++++++++++++++++++++---------------------
>      drivers/acpi/custom_method.c   |  2 +-
>      drivers/acpi/device_pm.c       |  3 ++
>      drivers/acpi/device_sysfs.c    | 15 ++++++---
>      drivers/acpi/dock.c            |  7 +++--
>      15 files changed, 138 insertions(+), 117 deletions(-)
>
>     --
>     2.8.1
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

