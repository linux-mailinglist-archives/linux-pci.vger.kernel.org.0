Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8D3204AE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 10:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBTJZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Feb 2021 04:25:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12627 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBTJZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Feb 2021 04:25:16 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DjNK04Q6Gz169bw;
        Sat, 20 Feb 2021 17:23:00 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:24:30 +0800
Subject: Re: [PATCH v1 0/4] ACPI: PCI: Unify printing of messages
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <4822757.tvZ08WQ2Gl@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7de92ec8-3a15-6165-2384-15d301e7b568@huawei.com>
Date:   Sat, 20 Feb 2021 17:24:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4822757.tvZ08WQ2Gl@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/20 2:14, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series gets rid of ACPICA debugging from non-ACPICA code related to PCI
> (patches [1-3/4]) and replaces direct printk() usage in pci_link.c with
> pr_*() or acpi_handle_*().
> 
> Please refer to the patch changelogs for details.

Looks good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
