Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC14468BC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 19:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhKETCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 15:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhKETCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 15:02:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45763604AC;
        Fri,  5 Nov 2021 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636138792;
        bh=1NO8uQVnvgttsvTHkhigZrBgaijDJw1yYma8oHwx2PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t7+aYOcSWjBzHqiFD4sjFu00H4+pqtXUJli3LpUs/mxwhGm2x4oPf8ypHbgIWR4AO
         um60uauslNvnpqSVK0IgYmi2NlSCPCRliUyodIYEveoIICS17D8gB/LpAr3YZntfem
         AQAuMpJCRTIjvH4/Z1U2Zjc0MVaktl/wUTL6O4VhjPiOtP166V9vKrZPmWj0zjV1Sm
         KdWwtJ6Ax0lmxoXUshqIgsomzgTxv53jm2jHdfYXMnnZwHG0qNmXiWiIgL2N0/Gj0s
         Bis+PKRLs88hG3jvL1AzKXNS0bXd/AzHfcTRPii3GtoSBJCyOHzMI4f3ciHmmq4AWL
         vsdhLfqitfJjw==
Date:   Fri, 5 Nov 2021 13:59:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v2] PCI: kirin: Fix of_node_put() issue in pcie-kirin
Message-ID: <20211105185950.GA938070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105020711.32572-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04, 2021 at 10:07:11PM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before return.
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter. Replace return by goto here and add a missing
> of_node_put for parent.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

I had already squashed this into:

  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=b22dbbb24571

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 06017e826832..b72a12bac49d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -422,7 +422,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto put_node;
>  			}
>  
>  			ret = of_pci_get_devfn(child);
> @@ -446,6 +447,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  	return 0;
>  
>  put_node:
> +	of_node_put(parent);
>  	of_node_put(child);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
