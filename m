Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34E34B4FA
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhC0HVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 03:21:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15341 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhC0HUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:20:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6qvN3RRmz93xW;
        Sat, 27 Mar 2021 15:18:40 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 15:20:40 +0800
Subject: Re: [PATCH 00/15] acpi: fix some coding style issues
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
References: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <cfb9c696-d916-c23c-28e6-3829b0a19ec9@huawei.com>
Date:   Sat, 27 Mar 2021 15:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please ignore this patch set. thanks.

On 2021/3/27 14:40, Xiaofei Tan wrote:
> Fix some coding style issues reported by checkpatch.pl.
>
> Xiaofei Tan (15):
>   ACPI: APD: fix a block comment align issue
>   ACPI: processor: fix some coding style issues
>   ACPI: acpi_dbg: fix some coding style issues
>   ACPI: acpi_fpdt: replace __attribute__((packed)) by __packed
>   remove useless return statement for void function
>   ACPI: acpi_lpss: fix some coding style issues
>   ACPI: acpi_memhotplug: fix a coding style issue
>   ACPI: acpi_pad: fix a coding style issue
>   ACPI: battery: fix some coding style issues
>   ACPI: button: fix some coding style issues
>   ACPI: cppc_acpi: fix some coding style issues
>   ACPI: custom_method: fix a coding style issue
>   ACPI: device_pm: fix some coding style issues
>   ACPI: device_sysfs: fix some coding style issues
>   ACPI: dock: fix some coding style issues
>
>  drivers/acpi/acpi_apd.c        |  8 ++---
>  drivers/acpi/acpi_dbg.c        | 40 +++++++++++-------------
>  drivers/acpi/acpi_fpdt.c       |  6 ++--
>  drivers/acpi/acpi_ipmi.c       |  1 -
>  drivers/acpi/acpi_lpss.c       |  4 ++-
>  drivers/acpi/acpi_memhotplug.c |  2 +-
>  drivers/acpi/acpi_pad.c        |  4 +++
>  drivers/acpi/acpi_processor.c  | 18 +++--------
>  drivers/acpi/battery.c         | 64 +++++++++++++++++++++----------------
>  drivers/acpi/button.c          | 10 +++---
>  drivers/acpi/cppc_acpi.c       | 71 +++++++++++++++++++++---------------------
>  drivers/acpi/custom_method.c   |  2 +-
>  drivers/acpi/device_pm.c       |  3 ++
>  drivers/acpi/device_sysfs.c    | 15 ++++++---
>  drivers/acpi/dock.c            |  7 +++--
>  15 files changed, 138 insertions(+), 117 deletions(-)
>

