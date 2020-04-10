Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC71A3DBE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDJB2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 21:28:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgDJB2I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 21:28:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60A6353E6333066C1421;
        Fri, 10 Apr 2020 09:28:05 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 09:28:01 +0800
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
To:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        <helgaas@kernel.org>
References: <20200409161609.2034-1-refactormyself@gmail.com>
CC:     <bjorn@helgaas.com>, <skhan@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <31a43a1a-d271-7652-db62-1a7c55cd135b@hisilicon.com>
Date:   Fri, 10 Apr 2020 09:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200409161609.2034-1-refactormyself@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bolarinwa,

I notice some drivers use these functions and if there is an error, pass the error code
directly to the userspace. As it's our private error code, is it appropriate to pass or
should we call pcibios_err_to_errno()(include/linux/pci.h, line 672) to do the conversion?

Regards,
Yicong


On 2020/4/10 0:16, Bolarinwa Olayemi Saheed wrote:
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> ---
>  drivers/pci/access.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..451f2b8b2b3c 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  
>  	*val = 0;
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  
>  	*val = 0;
>  	if (pos & 3)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);

