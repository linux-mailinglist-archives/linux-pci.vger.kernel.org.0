Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98AA483EA0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiADJBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 04:01:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33830 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiADJBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 04:01:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20490q8s079900;
        Tue, 4 Jan 2022 03:00:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641286852;
        bh=QzqYOpt5aR+OmNUiSd78gneDVOkaKDiIx46QNcZXmG8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ewAhhh1EnRf8G6/MNrzYvybEuLWQudURIuEr2bV2jBpfbiDIxfBC/tZb61ne/ijz/
         PFE7gxNZNAvWc/HWZFHv+KKOmIRn09Lug3vO71G1r6nf7KGSUVmLdND3ZVFW71tGPx
         Qa9YfJjNVEt4XLVljjvawOMOk8+tvo8FzI36cssg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20490qqU097638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 03:00:52 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 03:00:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 03:00:52 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20490o3D105643;
        Tue, 4 Jan 2022 03:00:51 -0600
Subject: Re: [PATCH] PCI: endpoint: Fix alignment fault error in copy tests
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>
References: <20211217094708.28678-1-Zhiqiang.Hou@nxp.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <db9d1418-46eb-94b3-5003-1add9b2b8dc8@ti.com>
Date:   Tue, 4 Jan 2022 14:30:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217094708.28678-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17/12/21 3:17 pm, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the copy tests, it uses the memcpy() to copy data between
> IO memory space. This can cause the alignment fualt error
> (pasted the error logs below) due to the memcpy() may use
> unaligned accesses.
> 
> Alignment fault error logs:
>    Unable to handle kernel paging request at virtual address ffff8000101cd3c1
>    Mem abort info:
>      ESR = 0x96000021
>      EC = 0x25: DABT (current EL), IL = 32 bits
>      SET = 0, FnV = 0
>      EA = 0, S1PTW = 0
>      FSC = 0x21: alignment fault
>    Data abort info:
>      ISV = 0, ISS = 0x00000021
>      CM = 0, WnR = 0
>    swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081773000
>    [ffff8000101cd3c1] pgd=1000000082410003, p4d=1000000082410003, pud=1000000082411003, pmd=1000000082412003, pte=0068004000001f13
>    Internal error: Oops: 96000021 [#1] PREEMPT SMP
>    Modules linked in:
>    CPU: 0 PID: 6 Comm: kworker/0:0H Not tainted 5.15.0-rc1-next-20210914-dirty #2
>    Hardware name: LS1012A RDB Board (DT)
>    Workqueue: kpcitest pci_epf_test_cmd_handler
>    pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : __memcpy+0x168/0x230
>    lr : pci_epf_test_cmd_handler+0x6f0/0xa68
>    sp : ffff80001003bce0
>    x29: ffff80001003bce0 x28: ffff800010135000 x27: ffff8000101e5000
>    x26: ffff8000101cd000 x25: ffff6cda941cf6c8 x24: 0000000000000000
>    x23: ffff6cda863f2000 x22: ffff6cda9096c800 x21: ffff800010135000
>    x20: ffff6cda941cf680 x19: ffffaf39fd999000 x18: 0000000000000000
>    x17: 0000000000000000 x16: 0000000000000000 x15: ffffaf39fd2b6000
>    x14: 0000000000000000 x13: 15f5c8fa2f984d57 x12: 604d132b60275454
>    x11: 065cee5e5fb428b6 x10: aae662eb17d0cf3e x9 : 1d97c9a1b4ddef37
>    x8 : 7541b65edebf928c x7 : e71937c4fc595de0 x6 : b8a0e09562430d1c
>    x5 : ffff8000101e5401 x4 : ffff8000101cd401 x3 : ffff8000101e5380
>    x2 : fffffffffffffff1 x1 : ffff8000101cd3c0 x0 : ffff8000101e5000
>    Call trace:
>     __memcpy+0x168/0x230
>     process_one_work+0x1ec/0x370
>     worker_thread+0x44/0x478
>     kthread+0x154/0x160
>     ret_from_fork+0x10/0x20
>    Code: a984346c a9c4342c f1010042 54fffee8 (a97c3c8e)
>    ---[ end trace 568c28c7b6336335 ]---
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868..c7e45633beaf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -285,7 +285,17 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  	} else {
> -		memcpy(dst_addr, src_addr, reg->size);
> +		void *buf;
> +
> +		buf = kzalloc(reg->size, GFP_KERNEL);
> +		if (!buf) {
> +			ret = -ENOMEM;
> +			goto err_map_addr;
> +		}
> +
> +		memcpy_fromio(buf, src_addr, reg->size);
> +		memcpy_toio(dst_addr, buf, reg->size);
> +		kfree(buf);
>  	}
>  	ktime_get_ts64(&end);
>  	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
> 
