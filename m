Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB23262456
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIBAF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 21:00:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10851 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgIIBAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 21:00:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DACEB96FF17F7E8EE840;
        Wed,  9 Sep 2020 09:00:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 09:00:00 +0800
Subject: Re: [PATCH v2] PCI/ACPI: Suppress missing MCFG message
To:     Jeremy Linton <jeremy.linton@arm.com>, <linux-acpi@vger.kernel.org>
CC:     <tn@semihalf.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <steven.price@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <sudeep.holla@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20200908210359.569294-1-jeremy.linton@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f7d5522a-9e44-236e-ad9f-44d3fd5c5ade@huawei.com>
Date:   Wed, 9 Sep 2020 08:59:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200908210359.569294-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/9/9 5:03, Jeremy Linton wrote:
> MCFG is an optional ACPI table. Given there are machines
> without PCI(e) (or it is hidden) we have been receiving
> queries/complaints about what this message means given
> its being presented as an error.
> 
> Lets reduce the severity, the ACPI table list printed at
> boot will continue to provide another way to detect when
> the table is missing.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/acpi/pci_mcfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 54b36b7ad47d..c8ef3bb5aa00 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -280,5 +280,5 @@ void __init pci_mmcfg_late_init(void)
>   {
>   	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
>   	if (err)
> -		pr_err("Failed to parse MCFG (%d)\n", err);
> +		pr_debug("Failed to parse MCFG (%d)\n", err);
>   }
> 

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

