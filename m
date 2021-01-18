Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB072FA053
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbhARMst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 07:48:49 -0500
Received: from foss.arm.com ([217.140.110.172]:35056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391702AbhARMsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 07:48:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78FD131B;
        Mon, 18 Jan 2021 04:47:50 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3853F719;
        Mon, 18 Jan 2021 04:47:49 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:47:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>, kishon@ti.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: functions/pci-epf-test: fix missing
 destroy_workqueue() on error in pci_epf_test_init
Message-ID: <20210118124744.GA13109@e121166-lin.cambridge.arm.com>
References: <20201028091549.136349-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028091549.136349-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 05:15:49PM +0800, Qinglang Miao wrote:
> Add the missing destroy_workqueue() before return from
> pci_epf_test_init() in the error handling case.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 1 +
>  1 file changed, 1 insertion(+)

Need Kishon's ack.

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e4e51d884..6854f2525 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -918,6 +918,7 @@ static int __init pci_epf_test_init(void)
>  	ret = pci_epf_register_driver(&test_driver);
>  	if (ret) {
>  		pr_err("Failed to register pci epf test driver --> %d\n", ret);
> +		destroy_workqueue(kpcitest_workqueue);
>  		return ret;
>  	}
>  
> -- 
> 2.23.0
> 
