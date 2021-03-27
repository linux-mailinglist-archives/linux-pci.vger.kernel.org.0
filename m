Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7D34B5DD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 10:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhC0J7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 05:59:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15358 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0J6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 05:58:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6vPW00WMz8yBB;
        Sat, 27 Mar 2021 17:56:30 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 17:58:29 +0800
Subject: Re: [PATCH v2 06/15] ACPI: LPSS: fix some coding style issues
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <1616831193-17920-7-git-send-email-tanxiaofei@huawei.com>
 <CAHp75Vd0hVqsfsZK=d1dz98Kbchqz-w4RqQQp6FwisxSGG5BzA@mail.gmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        Joe Perches <joe@perches.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <22ba9fc3-11c6-bda4-d666-5d8b2f874349@huawei.com>
Date:   Sat, 27 Mar 2021 17:58:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd0hVqsfsZK=d1dz98Kbchqz-w4RqQQp6FwisxSGG5BzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On 2021/3/27 16:19, Andy Shevchenko wrote:
>
>
> On Saturday, March 27, 2021, Xiaofei Tan <tanxiaofei@huawei.com
> <mailto:tanxiaofei@huawei.com>> wrote:
>
>     Fix some coding style issues reported by checkpatch.pl
>     <http://checkpatch.pl>, including
>     following types:
>
>     WARNING: simple_strtol is obsolete, use kstrtol instead
>
>
> And one more thing, the above message is bogus. Read what the comments
> in the code says about use cases for simple_*() vs. kstrto*() ones.
>

OK. I would remove this modification from the patch.

> Joe?
>
>
>     WARNING: Missing a blank line after declarations
>
>     Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com
>     <mailto:tanxiaofei@huawei.com>>
>     ---
>      drivers/acpi/acpi_lpss.c | 4 +++-
>      1 file changed, 3 insertions(+), 1 deletion(-)
>
>     diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>     index be73974..2df231e 100644
>     --- a/drivers/acpi/acpi_lpss.c
>     +++ b/drivers/acpi/acpi_lpss.c
>     @@ -187,7 +187,7 @@ static void byt_i2c_setup(struct
>     lpss_private_data *pdata)
>
>             /* Expected to always be true, but better safe then sorry */
>             if (uid_str)
>     -               uid = simple_strtol(uid_str, NULL, 10);
>     +               uid = kstrtol(uid_str, NULL, 10);
>
>             /* Detect I2C bus shared with PUNIT and ignore its d3 status */
>             status = acpi_evaluate_integer(handle, "_SEM", NULL,
>     &shared_host);
>     @@ -377,6 +377,7 @@ static const struct acpi_device_id
>     acpi_lpss_device_ids[] = {
>      static int is_memory(struct acpi_resource *res, void *not_used)
>      {
>             struct resource r;
>     +
>             return !acpi_dev_resource_memory(res, &r);
>      }
>
>     @@ -1200,6 +1201,7 @@ static int acpi_lpss_poweroff_noirq(struct
>     device *dev)
>             if (pdata->dev_desc->resume_from_noirq) {
>                     /* This is analogous to the
>     acpi_lpss_suspend_noirq() case. */
>                     int ret = acpi_lpss_do_poweroff_late(dev);
>     +
>                     if (ret)
>                             return ret;
>             }
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

