Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EFA436194
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUM3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 08:29:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhJUM3t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 08:29:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7424ED1;
        Thu, 21 Oct 2021 05:27:32 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663083F73D;
        Thu, 21 Oct 2021 05:27:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:27:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to
 finish
Message-ID: <20211021122728.GB12568@lpieralisi>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 07:06:42AM +0100, Mauro Carvalho Chehab wrote:
> Before code refactor, the PERST# signals were sent at the
> end of the power_on logic. Then, the PCI core would probe for
> the buses and add them.
> 
> The new logic changed it to send PERST# signals during
> add_bus operation. That altered the timings.
> 
> Also, HiKey 970 require a little more waiting time for
> the PCI bridge - which is outside the SoC - to finish
> the PERST# reset, and then initialize the eye diagram.
> 

Ok, now you explained it and we should move this explanation
in the commit log that this change is affecting (I mean we
should squash this patch with the patch that actually requires it
- I am not sure whether it is patch 6 or another one).

I can do it for you; I thought it would be a standalone change
but it actually isn't, because it is brought about by the
changes you are making and therefore there it belongs.

Thanks for explaining it and apologies for the churn.

Lorenzo

> So, increase the waiting time for the PERST# signals to
> what's required for it to also work with HiKey 970.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index de375795a3b8..bc329673632a 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -113,7 +113,7 @@ struct kirin_pcie {
>  #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
>  
>  /* Time for delay */
> -#define REF_2_PERST_MIN		20000
> +#define REF_2_PERST_MIN		21000
>  #define REF_2_PERST_MAX		25000
>  #define PERST_2_ACCESS_MIN	10000
>  #define PERST_2_ACCESS_MAX	12000
> -- 
> 2.31.1
> 
