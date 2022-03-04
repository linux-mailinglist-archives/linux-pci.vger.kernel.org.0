Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99144CDFD2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 22:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiCDVkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 16:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 16:40:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8301FE03B;
        Fri,  4 Mar 2022 13:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60126CE2E93;
        Fri,  4 Mar 2022 21:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F326C340E9;
        Fri,  4 Mar 2022 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646429963;
        bh=SiMjJ9jBV8ROvPmd0OEnr3Kp8dWUAEessFwe8ZvnA6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bor1/1NAwIkRN3ZaChj8O+obgU1xNF6m03CRDThEMPJxRRZkoAo4EzQzfS7pHmlWn
         uQ8izIhUewIzMa/knus/VzINT0/qTG8FLnld7jb2XfHabPJelM87fzFWmASnispIgy
         5uXYgQC9aYOEzlGjK9VvdIIuU/ku851KG1nYmxvXJ6waQ1M2J+joGsTm4VIcKwdrFD
         eGiVuyEKZvLXTuEhH9qtr9HrThS2sYfCMAILmQaWubZBLgQEm1TUG+USfCLwCWe1In
         1DWbf6a+hkA10Z+lCtZ7eoYaax6AHYwC3qT7qVgex4s6SKAMvVfHAQQiC53m+548tR
         sTEhA52e06NTA==
Date:   Fri, 4 Mar 2022 15:39:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Zhangjiantao(Kirin,Nanjing)" <water.zhangjiantao@huawei.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caiyadong <caiyadong@huawei.com>,
        guhengsheng <guhengsheng@hisilicon.com>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
Subject: Re: [PATCH] PCI: dwc: solve returning success but actually failed
Message-ID: <20220304213921.GA1056382@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d26f16646294836b87611f4dc5fe763@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 12:06:10PM +0000, Zhangjiantao(Kirin,Nanjing) wrote:
> When dma_mapping_error returns error because of no enough memory available, dw_pcie_host_init will return success, which will mislead the callers.

Wrap to fit in 75 columns, add "()" after function names.
> 
> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
> Signed-off-by: zhangjiantao <water.zhangjiantao@huawei.com>
> 
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..ac691d733848 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -393,6 +393,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>               if (dma_mapping_error(pci->dev, pp->msi_data)) {
>                   dev_err(pci->dev, "Failed to map MSI data\n");
>                   pp->msi_data = 0;
> +                ret = -1;

We should save the return value from dma_mapping_error() and return
*that*, not -1.

Whitespace error (indent with tabs, same as the surrounding code).

>                   goto err_free_msi;
>               }
>           }
> --
> 2.17.1
> 
