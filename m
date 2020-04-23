Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D071B52D2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 04:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDWC70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 22:59:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgDWC7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 22:59:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6792FFE03BF355170A09;
        Thu, 23 Apr 2020 10:59:23 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Apr 2020
 10:59:14 +0800
Subject: Re: [PATCH -next] PCI: dwc: Make hisi_pcie_platform_ops static
To:     Zou Wei <zou_wei@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>
References: <1587548829-107925-1-git-send-email-zou_wei@huawei.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EA10481.1080604@hisilicon.com>
Date:   Thu, 23 Apr 2020 10:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1587548829-107925-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/4/22 17:47, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning:
> symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-hisi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
> index 6d9e1b2..b440f40 100644
> --- a/drivers/pci/controller/dwc/pcie-hisi.c
> +++ b/drivers/pci/controller/dwc/pcie-hisi.c
> @@ -362,7 +362,8 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -struct pci_ecam_ops hisi_pcie_platform_ops = {
> +static struct pci_ecam_ops hisi_pcie_platform_ops = {
> +	}

why adding "}"? BTW, static is OK here.

>  	.bus_shift    = 20,
>  	.init         =  hisi_pcie_platform_init,
>  	.pci_ops      = {
> 

