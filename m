Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BDA34AD12
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 18:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZRFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 13:05:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55794 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhCZRFM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 13:05:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210326170510euoutp0206628def8d06f518fa5a187df74f829e~v8060LtxI1677516775euoutp02J
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 17:05:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210326170510euoutp0206628def8d06f518fa5a187df74f829e~v8060LtxI1677516775euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616778310;
        bh=bK6Sh1ykvaHJopM4VaF7WSzOE4FIOny1NZwJ98izPJQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A9R7rgEhiRhN3UakbNPcZ7BIpIeorCujGrDZW4c00dELoWmZHEc0oqSaEe00fCnte
         HXSaXJ1vvp+AnYuOiOQutC5XM+swUh3qGEap9uVFp9d+gtjkPBPXL4moqdHRWEg63Q
         CfEhRw/gAl9c/rsPrO35Nptzz3+bTEolxvqawzwg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210326170510eucas1p114b3d0df97f795f05c9dd188fce8a725~v806c1rCy2000520005eucas1p1A;
        Fri, 26 Mar 2021 17:05:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 29.76.09439.6441E506; Fri, 26
        Mar 2021 17:05:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210326170509eucas1p2416134a674fe6929f2cb3ee7da99ef8c~v806GIKgL0468304683eucas1p2q;
        Fri, 26 Mar 2021 17:05:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210326170509eusmtrp2a200d0c56556ef35d4028db0e4e1eae7~v806FTG9e2122521225eusmtrp2L;
        Fri, 26 Mar 2021 17:05:09 +0000 (GMT)
X-AuditID: cbfec7f5-c1bff700000024df-ae-605e1446874f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.98.08696.5441E506; Fri, 26
        Mar 2021 17:05:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210326170509eusmtip16725afc0cf58262339bd33633a5e764f~v805eKGzh2038320383eusmtip1B;
        Fri, 26 Mar 2021 17:05:09 +0000 (GMT)
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5a4a7177-f8e1-6c8b-7c8a-8f5831de8455@samsung.com>
Date:   Fri, 26 Mar 2021 18:05:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325201932.GA808102@bjorn-Precision-5520>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7puInEJBsdPclgsacqw2HW3g93i
        1Zm1bBY3frWxWqz4MpPd4vKuOWwWZ+cdZ7N48/sFu8X/PTvYLU60fWB34PJYM28No8fOWXfZ
        PRZsKvXYtKqTzWPjux1MHn1bVjF6bNn/mdHj8ya5AI4oLpuU1JzMstQifbsEroyOLZ/YC05r
        V8z7comxgfGqchcjJ4eEgInEzVW/mbsYuTiEBFYwSsz9uoAFwvnCKLFi+VEo5zOjxOy39xhh
        Wta9Ps0EkVjOKDF1whkmkISQwEdGiZsn2UFsYQE3ibmvpwLZHBwiAmoSXe2hIPXMAv1MEk8P
        XGAGqWETMJToetvFBmLzCthJ3H84DWwBi4CqxLPtrWC9ogJJEhsOxUKUCEqcnPmEBcTmFLCW
        2Dl9AyuIzSwgL7H97RxmCFtc4taT+WC3SQi0c0p8fHaZCeJoF4mOK5OZIWxhiVfHt7BD2DIS
        /3fCNDQzSjw8t5YdwulhlLjcNAPqZWuJO+d+sYFcxCygKbF+lz5E2FHibesNsEMlBPgkbrwV
        hDiCT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEalWUhem4XknVlI3pmFsHcBI8sqRvHU
        0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwNR1+t/xrzsYV7z6qHeIkYmD8RCjBAezkggv6+nY
        BCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8u7auiRcSSE8sSc1OTS1ILYLJMnFwSjUwcVQ3bznA
        cIwxjf310ZvzZgd9cPP6vcVfKlAg9/2ihwWVz+/zL7+dz+b/Z/cjZy+f0zd2FZ9/nDxRdepO
        /klTJ3H/ndActW2Gipiz3PTnkfYX+kTlT9ld7TRTk5CXXF95Wz+4gvsky0eRlzpSkTMTy/6+
        3/t8kqfp0YLW9XoiRh3u+pNsAo6smfK8ZWXijd8apzMX9EuXXuFLMFEzuSvwJYcj4U/DQ/VX
        Qqy3urZo+69pY9hU8lU8ZnnNDoemaSKH3kSmndC7ect7ekNwgNb96Qc929JZdotPm8e1SMh6
        3/9jq+S2RajO/Kd9LMnFefUK5arAj8oHtpplX/+iXnxJ/9+irYtipV97+wR7Lo55rcRSnJFo
        qMVcVJwIANi1RQvMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7quInEJBn/faVksacqw2HW3g93i
        1Zm1bBY3frWxWqz4MpPd4vKuOWwWZ+cdZ7N48/sFu8X/PTvYLU60fWB34PJYM28No8fOWXfZ
        PRZsKvXYtKqTzWPjux1MHn1bVjF6bNn/mdHj8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyOLZ/YC05rV8z7comxgfGqchcjJ4eEgInE
        utenmboYuTiEBJYySizZMoMVIiEjcXJaA5QtLPHnWhcbRNF7RonWhn52kISwgJvE3NdTgWwO
        DhEBNYmu9lCQGmaBfiaJp8s2QjX0MUq8X/6VDaSBTcBQouttF5jNK2Ancf/hNEYQm0VAVeLZ
        9lawoaICSRKXl0xkhagRlDg58wkLiM0pYC2xc/oGsDizgJnEvM0PmSFseYntb+dA2eISt57M
        Z5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmC8bjv2c8sO
        xpWvPuodYmTiYDzEKMHBrCTCy3o6NkGINyWxsiq1KD++qDQntfgQoynQPxOZpUST84EJI68k
        3tDMwNTQxMzSwNTSzFhJnNfkyJp4IYH0xJLU7NTUgtQimD4mDk6pBibTijWyj8sWuYcWC1lw
        P89avtN7+bXEmq3hvnnPSw9vXNq+xXZWihM/Q66egJlF9OKICTI/zihcCN57tNR5+xF189yi
        0yEfc6bP28p47/C+P9UfOEQlJb1mPQ63+DA5RDq2WJbJ/tYvg8O2VxZwrz2yxfO508Qlkgc3
        1+Sy1pmeNvt0fHeT5FzZ8O1LOK4zsxal5z3ec3mxoIIxo+b3nqKpfQ0q7/JlEl+uyZeOnf9a
        lkkgiGneC/5pXLUNh76fnSTDWMR1gKX9+8PC7pN9YreNNm08J7konofj/GXVpCs39XXDTEuK
        9wvGacx4uq+TS2f+IeW3Kl1Lrr1u5l70yUpe2+ER57vvE9jPu7PyViuxFGckGmoxFxUnAgCr
        uosVYAMAAA==
X-CMS-MailID: 20210326170509eucas1p2416134a674fe6929f2cb3ee7da99ef8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941
References: <CGME20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941@eucas1p1.samsung.com>
        <20210325201932.GA808102@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.03.2021 21:19, Bjorn Helgaas wrote:
> On Thu, Mar 25, 2021 at 10:24:28AM +0100, Marek Szyprowski wrote:
>> On 25.01.2021 05:48, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> In the dw_pcie_ep_init(), it depends on the detected iATU region
>>> numbers to allocate the in/outbound window management bit map.
>>> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
>>> of iATU windows").
>>>
>>> So this patch move the iATU region detection into a new function,
>>> move forward the detection to the very beginning of functions
>>> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
>>> from the dw_pcie_setup(), since it's more like a software
>>> perspective initialization step than hardware setup.
>>>
>>> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> This patch causes exynos-pcie to hang during the initialization. It
>> looks that some resources are not enabled yet, so calling
>> dw_pcie_iatu_detect() much earlier causes a hang. When I have some time,
>> I will try to identify what is needed to call it properly.
> Thanks, I dropped it for now.  We can add it back after we figure out
> what the exynos issue is.
Thanks, I will try to identify at which point of initialization it is 
safe to call iATU region detection.
> For reference, here's the patch I dropped (I had made some minor
> corrections to the commit log):
>
> commit fd4162f05194 ("PCI: dwc: Move iATU detection earlier")
> Author: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Date:   Mon Jan 25 12:48:03 2021 +0800
>
>      PCI: dwc: Move iATU detection earlier
>      
>      dw_pcie_ep_init() depends on the detected iATU region numbers to allocate
>      the in/outbound window management bitmap.  It fails after 281f1f99cf3a
>      ("PCI: dwc: Detect number of iATU windows").
>      
>      Move the iATU region detection into a new function, move the detection to
>      the very beginning of dw_pcie_host_init() and dw_pcie_ep_init().  Also
>      remove it from the dw_pcie_setup(), since it's more like a software
>      initialization step than hardware setup.
>      
>      Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>      Link: https://lore.kernel.org/r/20210125044803.4310-1-Zhiqiang.Hou@nxp.com
>      Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>      Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Rob Herring <robh@kernel.org>
>      Cc: stable@vger.kernel.org	# v5.11+
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1c25d8337151..8d028a88b375 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -705,6 +705,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   		}
>   	}
>   
> +	dw_pcie_iatu_detect(pci);
> +
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>   	if (!res)
>   		return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7e55b2b66182..52f6887179cd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -319,6 +319,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   			return PTR_ERR(pci->dbi_base);
>   	}
>   
> +	dw_pcie_iatu_detect(pci);
> +
>   	bridge = devm_pci_alloc_host_bridge(dev, 0);
>   	if (!bridge)
>   		return -ENOMEM;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 004cb860e266..a945f0c0e73d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -660,11 +660,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>   	pci->num_ob_windows = ob;
>   }
>   
> -void dw_pcie_setup(struct dw_pcie *pci)
> +void dw_pcie_iatu_detect(struct dw_pcie *pci)
>   {
> -	u32 val;
>   	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>   	struct platform_device *pdev = to_platform_device(dev);
>   
>   	if (pci->version >= 0x480A || (!pci->version &&
> @@ -693,6 +691,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>   
>   	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
>   		 pci->num_ob_windows, pci->num_ib_windows);
> +}
> +
> +void dw_pcie_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>   
>   	if (pci->link_gen > 0)
>   		dw_pcie_link_set_max_speed(pci, pci->link_gen);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7247c8b01f04..7d6e9b7576be 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -306,6 +306,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>   void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>   			 enum dw_pcie_region_type type);
>   void dw_pcie_setup(struct dw_pcie *pci);
> +void dw_pcie_iatu_detect(struct dw_pcie *pci);
>   
>   static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>   {
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

