Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77034B4D9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhC0Gum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 02:50:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14156 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhC0GuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:50:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6qCM0tyrznYxZ;
        Sat, 27 Mar 2021 14:47:27 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 14:49:56 +0800
Subject: Re: [PATCH 05/15] remove useless return statement for void function
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
References: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
 <1616827256-51840-6-git-send-email-tanxiaofei@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <dce63f98-9825-3204-fb0e-0e4d958bf581@huawei.com>
Date:   Sat, 27 Mar 2021 14:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1616827256-51840-6-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Oh, sorry, the title doesn't contain subsystem and module name. I'll 
send v2 later. Please ignore this one. thanks.

On 2021/3/27 14:40, Xiaofei Tan wrote:
> Remove useless return statement for void function, reported by
> checkpatch.pl.
>
> WARNING: void function return statements are not generally useful
> FILE: drivers/acpi/acpi_ipmi.c:482:
> +       return;
> +}
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/acpi_ipmi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 9d6c0fc..bbd00d9 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -478,7 +478,6 @@ static void ipmi_register_bmc(int iface, struct device *dev)
>  	ipmi_dev_release(ipmi_device);
>  err_ref:
>  	put_device(smi_data.dev);
> -	return;
>  }
>
>  static void ipmi_bmc_gone(int iface)
>

