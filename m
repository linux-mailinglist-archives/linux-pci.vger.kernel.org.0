Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438EE25F210
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 05:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIGDaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 23:30:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgIGDaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Sep 2020 23:30:07 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 57BD27BAAAD434CF8B0E;
        Mon,  7 Sep 2020 11:30:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 11:30:02 +0800
Subject: Re: [PATCH] PCI/ACPI: Suppress missing MCFG message
To:     Jeremy Linton <jeremy.linton@arm.com>, <linux-acpi@vger.kernel.org>
CC:     <tn@semihalf.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <steven.price@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <sudeep.holla@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20200904170829.431900-1-jeremy.linton@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f0c815a0-91f0-aaa6-0f1c-843400a83fd8@huawei.com>
Date:   Mon, 7 Sep 2020 11:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904170829.431900-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jeremy,

On 2020/9/5 1:08, Jeremy Linton wrote:
> MCFG is an optional ACPI table. Given there are machines
> without PCI(e) (or it is hidden) we have been receiving
> queries/complaints about what this message means given
> its being presented as an error.
> 
> Lets only print an error if something is wrong with the
> the given table/etc. The ACPI table list printed at boot
> will continue to provide a way to detect when the table
> is missing.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/acpi/pci_mcfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 54b36b7ad47d..0bc8c012f157 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -279,6 +279,6 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>   void __init pci_mmcfg_late_init(void)
>   {
>   	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);

acpi_table_parse() will return errno -ENODEV and -EINVAL, and only
returns -EINVAL if the table id or the handler is NULL, which is
impossible here.

> -	if (err)
> +	if (err && err != -ENODEV)

So the error message below will never be printed, I would
prefer update the pr_err() to pr_dbg() for optional ACPI
table.

>   		pr_err("Failed to parse MCFG (%d)\n", err);
>   }

Thanks
Hanjun

