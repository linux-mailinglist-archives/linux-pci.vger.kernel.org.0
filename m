Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD674E60D8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 10:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiCXJGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349131AbiCXJGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 05:06:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149329D4CD
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 02:05:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b13so1620517pfv.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yqJ0gIjpeVMlWyc7MJuaJMsxiwBxgODQXJJnEu6bpCg=;
        b=IakckRWyyGYbDlEYV1kSZnwfC5kgsa0ongZEhYhi8jWLiSjR5rEaZstY9FxsMUxK16
         TRqPrrB8bAOoAz1nAwzLer+6mTMGRIWN4Tr2MwsXK1Acph6M1Gm/pZxm2FHxQWefSQ2O
         HOL0bDqpB5ES8GeU61fvkILekK7JrocdLikJ47Qid4Bkfer/9ncAgqtwIT73gFKyaFkc
         VvWAICnU+PnhS0NnBlFToV2q2LqpijhH6MtcTNkvv8yt7MCdmvhpTpaMkivM1hDftO5F
         KCDx6EHrr2L28N5YIdtc6Bkde84kOaev+gmOM5WdIkpg6tNmgzf6/Os9pG3OCQ8V0MHM
         bU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yqJ0gIjpeVMlWyc7MJuaJMsxiwBxgODQXJJnEu6bpCg=;
        b=V0R2lbzv9yjuGfWGKlpqP9NUIoWfezq+i4DprKNqAO/ad7JNMAccaxH1R2D2woyFa5
         fN+GB/B92eDZFkJH1QcGkFh7G0FUH5YtG0hAjFbZrlXFkFntdgOx3wNpt32XGw7/NZRO
         XW3jW4JIckX7RaqNpB/8OmffnsU4PfX2Hu5NW7LaXvxnRfFeI1poiIdMIdGGz6I4FSFC
         d/dEWqyam3ofCpx/UUgiL3RTz4SNr1qTA6xLBz5gdoxivqwpWbcWFcKIMBEs2GMwaX2Y
         m/ZZo/S3cOek2VK0s6+vJVrR+7Q6pq4R3tlWbFmsBhqY9mEm8s1uyQrHSYUSuBkFGjVO
         UXQg==
X-Gm-Message-State: AOAM5322evM0bek9uQ1zgM66Z7/Mc+B0iN9POgtG4xDslMdhdtsaHZCT
        w4EIjQ2LsIyx9FZ7otHFnMJz
X-Google-Smtp-Source: ABdhPJwFJwQrEPCoGJK6NSu/gLxMfEWgGH4jan2ZS2M4FMBWQJOnOhfRWz2BWsLgGF6m4EgvDYZKoA==
X-Received: by 2002:a05:6a00:1254:b0:4fa:874e:1319 with SMTP id u20-20020a056a00125400b004fa874e1319mr4334055pfi.14.1648112720492;
        Thu, 24 Mar 2022 02:05:20 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm9402403pjb.2.2022.03.24.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:05:20 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:35:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] PCI: dwc: Disable outbound windows for controllers
 with iATU
Message-ID: <20220324090514.GD2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:15AM +0300, Serge Semin wrote:
> In accordance with the dw_pcie_setup_rc() method semantics and judging by
> what the comment added in commit dd193929d91e ("PCI: designware: Explain
> why we don't program ATU for some platforms") states there are DWC
> PCIe-available platforms like Keystone (pci-keystone.c) or Amazon's
> Annapurna Labs (pcie-al.c) which don't have the DW PCIe internal ATU
> enabled and use it's own address translation approach implemented. In
> these cases at the very least there is no point in touching the DW PCIe
> iATU CSRs. Moreover depending on the vendor-specific address translation
> implementation it might be even erroneous. So let's move the iATU windows
> disabling procedure to being under the corresponding conditional statement
> clause thus performing that procedure only if the iATU is expected to be
> available on the platform.
> 
> Fixes: 458ad06c4cdd ("PCI: dwc: Ensure all outbound ATU windows are reset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f89e6552139b..a048d88e0c30 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -566,7 +566,6 @@ static struct pci_ops dw_pcie_ops = {
>  
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
> -	int i;
>  	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> @@ -618,19 +617,22 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>  
> -	/* Ensure all outbound windows are disabled so there are multiple matches */
> -	for (i = 0; i < pci->num_ob_windows; i++)
> -		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> -
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
>  	 * the platform uses its own address translation component rather than
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		int atu_idx = 0;
> +		int i, atu_idx = 0;
>  		struct resource_entry *entry;
>  
> +		/*
> +		 * Ensure all outbound windows are disabled so there are
> +		 * multiple matches
> +		 */
> +		for (i = 0; i < pci->num_ob_windows; i++)
> +			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> +
>  		/* Get last memory resource entry */
>  		resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  			if (resource_type(entry->res) != IORESOURCE_MEM)
> -- 
> 2.35.1
> 
