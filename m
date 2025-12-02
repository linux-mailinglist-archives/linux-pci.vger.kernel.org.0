Return-Path: <linux-pci+bounces-42537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A0C9D3AD
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D5D3A94DA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6F2F1FFE;
	Tue,  2 Dec 2025 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUHPoTSQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5582D6E7C;
	Tue,  2 Dec 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715078; cv=none; b=L5cGGwsqDf1FQqjstgbQMotl1xnWRixYRcHlodEqc+ts8/lP4ThY23MtrS3e0a8bhgcjCaZFYqZKMRUfTCTSYavajz8kwk88DrUiFRiopogNskAVfLG7qvbE+zKEwm0dMS4l9JDPhsjEwMzdYZa11uViHcA6IcVIyI+c1h6G9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715078; c=relaxed/simple;
	bh=HR0YJi9mmcUYSXhB+a1IUnAGSFfyK8SPaU1Ih3LCPhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKRfgFIpiCOplPLklH2LERpgW8Fc/C73JoiAv3WBhy6vRBAYM6t3e7F5Ws7OQKRch4DBxq9iLyCdz1oON5WVSLwRWsMFIt56SBhH8Z6O9sf87BSgZ/FRLnGqbi4uIovfxQGyRwCfZW+hTAkLGvgi6uUQA0LK6DbsOHzN6YenfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GUHPoTSQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=H2Uo/+AoQ5NQJdx5MNHBMbHN+4OzPRgqvPH+BTOYJTA=; b=GUHPoTSQS/sVFkKit/c/I1TzDP
	f3gFt8pVLBw4dNUzyjmdY/lHwAsJJvyQ+NUwhyYYsUh5ElV8EJTNBPh4f1sa8S7EIgf4HEHVz58ZE
	E+VCb3rU66tGD70YLk0xs3wPfcHM7ex5wYTv/rQhv97+zzR3kKJldotBiOBLvb5yE8kwm3NGVVTQK
	U7h48ZNJJyeMtlN2Yfs2xN//y4VyGGBKFf0i7dInoaY3KPkwdpLxvj1o9gil5EpEglOhkwNQE5cPO
	RuYuwDVtpA57+SujZjFSRYKDMLhTVuSyrc0UB0k9G9zosEu4JSuY95ijJgceI1KPDaQlR/SG2d7SN
	DhgrCM/Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQZ0M-00000005uGP-0aLZ;
	Tue, 02 Dec 2025 22:37:54 +0000
Message-ID: <77bad218-9120-49d5-9d5a-7b1dcebf09b2@infradead.org>
Date: Tue, 2 Dec 2025 14:37:53 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
To: Manivannan Sadhasivam <mani@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20251128162928.36eec2d6@canb.auug.org.au>
 <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
 <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>
 <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
 <CAKfTPtCKmj_dHGU-2WPsEevf7CR-isRiyM0+oftCrMy5MswE4A@mail.gmail.com>
 <6ulzkdgd6j35ptu5mesgtgh2xa6fwalcmkgcxr2fdjwwfvzhrf@4dtcadsl2mvm>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6ulzkdgd6j35ptu5mesgtgh2xa6fwalcmkgcxr2fdjwwfvzhrf@4dtcadsl2mvm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/2/25 2:12 AM, Manivannan Sadhasivam wrote:
> On Tue, Dec 02, 2025 at 11:03:07AM +0100, Vincent Guittot wrote:
>> On Tue, 2 Dec 2025 at 10:53, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>
>>> On Tue, Dec 02, 2025 at 09:54:24AM +0100, Vincent Guittot wrote:
>>>> On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>>>
>>>>> + Vincent
>>>>
>>>> Thanks for looping me in.
>>>>>
>>>>> On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
>>>>>>
>>>>>>
>>>>>> On 11/27/25 9:29 PM, Stephen Rothwell wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Changes since 20251127:
>>>>>>>
>>>>>>
>>>>>> on i386 (allmodconfig):
>>>>>>
>>>>>> WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)
>>>>
>>>> Are there details to reproduce the warning ? I don't have such warning
>>>> when compiling allmodconfig locally
>>>>
>>>> s32 pcie can only be built in but I may have to use
>>>> builtin_platform_driver_probe() instead of builtin_platform_driver()
>>>>
>>>
>>> The is due to calling a function belonging to the __init section from non-init
>>> function. Ideally, functions prefixed with __init like memblock_start_of_DRAM()
>>> should be called from the module init functions.
>>>
>>> One way to fix would be to call memblock_start_of_DRAM() in probe(), and
>>> annotate probe() with __init. Since there is no remove, you could use
>>> builtin_platform_driver_probe().
>>>
>>> This also makes me wonder if we really should be using memblock_start_of_DRAM()
>>> in the driver. I know that this was suggested to you during reviews, but I would
>>> prefer to avoid it, especially due to this being the __init function.
>>
>> yeah, I suppose I can directly define the value in the driver has
>> there is only one memory config for now anyway
>>
>> /* Boundary between peripheral space and physical memory space */
>> #define S32G_MEMORY_BOUNDARY_ADDR 0x80000000
>>
> 
> Ok. I fixed it up myself with below diff:

Thanks.
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> index eacf0229762c..70b1dc404bbe 100644
> --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -7,7 +7,6 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/memblock.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
> @@ -35,6 +34,9 @@
>  #define PCIE_S32G_PE0_INT_STS                  0xE8
>  #define HP_INT_STS                             BIT(6)
>  
> +/* Boundary between peripheral space and physical memory space */
> +#define S32G_MEMORY_BOUNDARY_ADDR              0x80000000
> +
>  struct s32g_pcie_port {
>         struct list_head list;
>         struct phy *phy;
> @@ -99,10 +101,10 @@ static struct dw_pcie_ops s32g_pcie_ops = {
>  };
>  
>  /* Configure the AMBA AXI Coherency Extensions (ACE) interface */
> -static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci)
>  {
> -       u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> -       u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> +       u32 ddr_base_low = lower_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
> +       u32 ddr_base_high = upper_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
>  
>         dw_pcie_dbi_ro_wr_en(pci);
>         dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> @@ -149,7 +151,7 @@ static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
>          * Make sure we use the coherency defaults (just in case the settings
>          * have been changed from their reset values)
>          */
> -       s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> +       s32g_pcie_reset_mstr_ace(pci);
>  
>         dw_pcie_dbi_ro_wr_en(pci);
> 
> - Mani
> 

-- 
~Randy

