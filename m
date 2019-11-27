Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBF10AC8A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0JVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 04:21:20 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58624 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfK0JVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 04:21:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR9LB9Q114688;
        Wed, 27 Nov 2019 03:21:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574846471;
        bh=kwY+h74SP4fvfaUg3sDvoCaQkY6vLWbOHhk5F3RbxDU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=n/FdqzdFWUIwIYLohrMC0k0cZblz/xpQyFObpVdLoAqsyQ+QJwFfiB+vzVfrWNH6O
         KXzrGQmb3gMhKxxjcDqy0TYGERUSTi645ilbxINyiPJLZ9dLK3m+doGUw1HcJr58Ql
         q3Qb46sa52ybEY6GN1H59tb5pSr7kWw5dLd826c4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR9LB22051314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Nov 2019 03:21:11 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 27
 Nov 2019 03:21:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 27 Nov 2019 03:21:11 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR9L41M126034;
        Wed, 27 Nov 2019 03:21:06 -0600
Subject: Re: [PATCH 4/4] PCI: pci-epf-test: Add support to defer core
 initialization
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-5-vidyas@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e8e3b8b6-d115-b4d4-19c5-1eae1d8abd0f@ti.com>
Date:   Wed, 27 Nov 2019 14:50:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113090851.26345-5-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/11/19 2:38 PM, Vidya Sagar wrote:
> Add support to defer core initialization and to receive a notifier
> when core is ready to accommodate platforms where core is not for
> initialization untile reference clock from host is available.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
>  1 file changed, 77 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index bddff15052cc..068024fab544 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			   msecs_to_jiffies(1));
>  }
>  
> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> -				 void *data)
> -{
> -	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
> -	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -
> -	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> -			   msecs_to_jiffies(1));
> -
> -	return NOTIFY_OK;
> -}
> -
>  static void pci_epf_test_unbind(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_core_init(struct pci_epf *epf)
> +{
> +	struct pci_epf_header *header = epf->header;
> +	const struct pci_epc_features *epc_features;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	bool msix_capable = false;
> +	bool msi_capable = true;
> +	int ret;
> +
> +	epc_features = pci_epc_get_features(epc, epf->func_no);
> +	if (epc_features) {
> +		msix_capable = epc_features->msix_capable;
> +		msi_capable = epc_features->msi_capable;
> +	}
> +
> +	ret = pci_epc_write_header(epc, epf->func_no, header);
> +	if (ret) {
> +		dev_err(dev, "Configuration header write failed\n");
> +		return ret;
> +	}
> +
> +	ret = pci_epf_test_set_bar(epf);
> +	if (ret)
> +		return ret;
> +
> +	if (msi_capable) {
> +		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> +		if (ret) {
> +			dev_err(dev, "MSI configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (msix_capable) {
> +		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
> +		if (ret) {
> +			dev_err(dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> +				 void *data)
> +{
> +	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	int ret;
> +
> +	switch (val) {
> +	case CORE_INIT:
> +		ret = pci_epf_test_core_init(epf);
> +		if (ret)
> +			return NOTIFY_BAD;
> +		break;
> +
> +	case LINK_UP:
> +		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> +				   msecs_to_jiffies(1));
> +		break;
> +
> +	default:
> +		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -496,12 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  {
>  	int ret;
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -	struct pci_epf_header *header = epf->header;
>  	const struct pci_epc_features *epc_features;
>  	enum pci_barno test_reg_bar = BAR_0;
>  	struct pci_epc *epc = epf->epc;
> -	struct device *dev = &epf->dev;
>  	bool linkup_notifier = false;
> +	bool skip_core_init = false;
>  	bool msix_capable = false;
>  	bool msi_capable = true;
>  
> @@ -511,6 +570,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	epc_features = pci_epc_get_features(epc, epf->func_no);
>  	if (epc_features) {
>  		linkup_notifier = epc_features->linkup_notifier;
> +		skip_core_init = epc_features->skip_core_init;
>  		msix_capable = epc_features->msix_capable;
>  		msi_capable = epc_features->msi_capable;

Are these used anywhere in this function?
>  		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> @@ -520,34 +580,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
>  
> -	ret = pci_epc_write_header(epc, epf->func_no, header);
> -	if (ret) {
> -		dev_err(dev, "Configuration header write failed\n");
> -		return ret;
> -	}
> -
>  	ret = pci_epf_test_alloc_space(epf);
>  	if (ret)
>  		return ret;
>  
> -	ret = pci_epf_test_set_bar(epf);
> -	if (ret)
> -		return ret;
> -
> -	if (msi_capable) {
> -		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> -		if (ret) {
> -			dev_err(dev, "MSI configuration failed\n");
> -			return ret;
> -		}
> -	}
> -
> -	if (msix_capable) {
> -		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
> -		if (ret) {
> -			dev_err(dev, "MSI-X configuration failed\n");
> +	if (!skip_core_init) {
> +		ret = pci_epf_test_core_init(epf);
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
>  	if (linkup_notifier) {

This could as well be moved to pci_epf_test_core_init().

Thanks
Kishon
