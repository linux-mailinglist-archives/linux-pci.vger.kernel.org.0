Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4882E7FC7
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfJ2Fko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 01:40:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57172 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfJ2Fko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 01:40:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9T5eVQa123431;
        Tue, 29 Oct 2019 00:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572327631;
        bh=TLIG+N2ulLyByssQEEKVgxs+nraNcwf+u9BpyOQyR18=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NcxvC5pdB2/a8lx58UwxXcUHftv+jGVmkokzU1d3G8yMWmhSbEdk7CufEp0W8E7P8
         46Cpv3rMqGwl093nfGGpbe+NJsFhsaxhmMh7gaG58wd6+0sKZUxJYXJGWFrKma7IqS
         TEOswO/fHNcXC3BQ2QfcP2xVVC5UaZRS6Ypv8FL8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9T5eVEI014555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 00:40:31 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 00:40:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 00:40:30 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9T5eSk4130719;
        Tue, 29 Oct 2019 00:40:28 -0500
Subject: Re: [PATCH] tools: PCI: Fix fd leakage
To:     Hewenliang <hewenliang4@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
CC:     <linfeilong@huawei.com>
References: <20191026013555.61016-1-hewenliang4@huawei.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d384da9a-c417-fb5f-2881-b3039af0e997@ti.com>
Date:   Tue, 29 Oct 2019 11:09:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191026013555.61016-1-hewenliang4@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26/10/19 7:05 AM, Hewenliang wrote:
> We should close fd before the return of run_test.
> 
> Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  tools/pci/pcitest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index cb1e51fcc84e..32b7c6f9043d 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -129,6 +129,7 @@ static int run_test(struct pci_test *test)
>  	}
>  
>  	fflush(stdout);
> +	close(fd);
>  	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
>  }
>  
> 
