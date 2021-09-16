Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0D40D886
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhIPLbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 07:31:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:40993 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhIPLbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 07:31:42 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Sep 2021 20:30:21 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 5C7662059034;
        Thu, 16 Sep 2021 20:30:21 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 16 Sep 2021 20:30:21 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0994CAB192;
        Thu, 16 Sep 2021 20:30:21 +0900 (JST)
Received: from [10.212.183.234] (unknown [10.212.183.234])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 1FD3EB62B3;
        Thu, 16 Sep 2021 20:30:16 +0900 (JST)
Subject: Re: [PATCH v2] PCI: endpoint: Use sysfs_emit() in "show" functions
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <b9eb71b0-8328-fb05-3b8c-112cb8dbbda2@socionext.com>
Date:   Thu, 16 Sep 2021 20:30:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle ping, are there any comments?

Thank you,

On 2021/09/01 14:09, Kunihiko Hayashi wrote:
> Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
> check for buffer overruns in sysfs outputs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> ---
> Changes since v1:
> - Add Reviewed-by line
> 
> ---
> drivers/pci/endpoint/functions/pci-epf-ntb.c |  4 ++--
>   drivers/pci/endpoint/pci-ep-cfs.c            | 13 ++++++-------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 8b47561..99266f05 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1937,7 +1937,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
>   	struct config_group *group = to_config_group(item);		\
>   	struct epf_ntb *ntb = to_epf_ntb(group);			\
>   									\
> -	return sprintf(page, "%d\n", ntb->_name);			\
> +	return sysfs_emit(page, "%d\n", ntb->_name);			\
>   }
>   
>   #define EPF_NTB_W(_name)						\
> @@ -1968,7 +1968,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
>   									\
>   	sscanf(#_name, "mw%d", &win_no);				\
>   									\
> -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> +	return sysfs_emit(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
>   }
>   
>   #define EPF_NTB_MW_W(_name)						\
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 9999118..5a0394a 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -198,8 +198,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
>   
>   static ssize_t pci_epc_start_show(struct config_item *item, char *page)
>   {
> -	return sprintf(page, "%d\n",
> -		       to_pci_epc_group(item)->start);
> +	return sysfs_emit(page, "%d\n", to_pci_epc_group(item)->start);
>   }
>   
>   CONFIGFS_ATTR(pci_epc_, start);
> @@ -321,7 +320,7 @@ static ssize_t pci_epf_##_name##_show(struct config_item *item,	char *page)    \
>   	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
>   	if (WARN_ON_ONCE(!epf->header))					       \
>   		return -EINVAL;						       \
> -	return sprintf(page, "0x%04x\n", epf->header->_name);		       \
> +	return sysfs_emit(page, "0x%04x\n", epf->header->_name);	       \
>   }
>   
>   #define PCI_EPF_HEADER_W_u32(_name)					       \
> @@ -390,8 +389,8 @@ static ssize_t pci_epf_msi_interrupts_store(struct config_item *item,
>   static ssize_t pci_epf_msi_interrupts_show(struct config_item *item,
>   					   char *page)
>   {
> -	return sprintf(page, "%d\n",
> -		       to_pci_epf_group(item)->epf->msi_interrupts);
> +	return sysfs_emit(page, "%d\n",
> +			  to_pci_epf_group(item)->epf->msi_interrupts);
>   }
>   
>   static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
> @@ -412,8 +411,8 @@ static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
>   static ssize_t pci_epf_msix_interrupts_show(struct config_item *item,
>   					    char *page)
>   {
> -	return sprintf(page, "%d\n",
> -		       to_pci_epf_group(item)->epf->msix_interrupts);
> +	return sysfs_emit(page, "%d\n",
> +			  to_pci_epf_group(item)->epf->msix_interrupts);
>   }
>   
>   PCI_EPF_HEADER_R(vendorid)
> 

-- 
---
Best Regards
Kunihiko Hayashi
