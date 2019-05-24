Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0729834
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbfEXMnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 08:43:03 -0400
Received: from ns.iliad.fr ([212.27.33.1]:40062 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389057AbfEXMnD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 08:43:03 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3AF3A21331;
        Fri, 24 May 2019 14:43:01 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1B00D206AA;
        Fri, 24 May 2019 14:43:01 +0200 (CEST)
Subject: Re: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least 100
 ms
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190523194409.17718-1-niklas.cassel@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
Date:   Fri, 24 May 2019 14:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523194409.17718-1-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri May 24 14:43:01 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/05/2019 21:44, Niklas Cassel wrote:

> Currently, there is only a 1 ms sleep after asserting PERST.
> 
> Reading the datasheets for different endpoints, some require PERST to be
> asserted for 10 ms in order for the endpoint to perform a reset, others
> require it to be asserted for 50 ms.
> 
> Several SoCs using this driver uses PCIe Mini Card, where we don't know
> what endpoint will be plugged in.
> 
> The PCI Express Card Electromechanical Specification specifies:
> "On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
> the power rails achieving specified operating limits."
> 
> Add a sleep of 100 ms before deasserting PERST, in order to ensure that
> we are compliant with the spec.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0ed235d560e3..cae24376237c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
>  
> +	/* Ensure that PERST has been asserted for at least 100 ms */
> +	msleep(100);
>  	qcom_ep_reset_deassert(pcie);
>  
>  	ret = qcom_pcie_establish_link(pcie);

Currently, qcom_ep_reset_assert() and qcom_ep_reset_deassert() both include
a call to usleep_range() of 1.0 to 1.5 ms

Can we git rid of both if we sleep 100 ms before qcom_ep_reset_deassert?

Should the msleep() call be included in one of the two wrappers?

Regards.
