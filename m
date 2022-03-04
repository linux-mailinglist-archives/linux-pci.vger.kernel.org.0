Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C94CD9D0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 18:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiCDRLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbiCDRLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 12:11:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2581CD9D6;
        Fri,  4 Mar 2022 09:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33402B827EA;
        Fri,  4 Mar 2022 17:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16C1C340E9;
        Fri,  4 Mar 2022 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646413849;
        bh=Ds1CUkU7UJjiWAdE0+xZMgQsZmoxCwPqtCIMS0NNp5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EA7yu/IROGfdSgKyOrBu8bT76eexmYri8ZSVbgz1qHTtzt1RI+qQdCks6wtlyl3eW
         4XWB3HCTp6HtkpAAFNwdzQFn60forLUNs1zvg+mdX4mTJFCV9fKz03gGy3lgRHmrsZ
         DNKBc28pZVlNB9VBlpkpVozlz75RUsvq+YXASqYajSkHNEv8c1BXroYR9QRz+0b6B9
         Ss1SYTBV4zI9Xolb5L+Yl+HuevD4rfjGKHOKtehMtBNWH9hKbjkxqHGOlLf5GrvGVK
         oSPmW8nEIyt0j1fVH15vsJShel4+aqY4NkDb4PpnaFKwAJ2qAYn7Ur9qMjr8jEg4us
         qbX0wXDKvNj+A==
Received: by mail-ed1-f50.google.com with SMTP id q17so11607608edd.4;
        Fri, 04 Mar 2022 09:10:48 -0800 (PST)
X-Gm-Message-State: AOAM533fofffIpN/fp+iKoMny2wK8/ThsGaGKWbVvZnu310+u70mbHqN
        XEdJadZ7nGqlI5bV6Dxpl+SZ81fqAO1M9H4m2A==
X-Google-Smtp-Source: ABdhPJyv33ipIntcHpbv1qfxGMnwrXmM5pCVhZvYqYuBcIOtqTdc2+oPX0xtMXbyCVPXlf8ixI0YtHesErJAvOBNjaY=
X-Received: by 2002:aa7:d147:0:b0:415:c68c:f8d6 with SMTP id
 r7-20020aa7d147000000b00415c68cf8d6mr12008248edo.67.1646413847174; Fri, 04
 Mar 2022 09:10:47 -0800 (PST)
MIME-Version: 1.0
References: <6d26f16646294836b87611f4dc5fe763@huawei.com>
In-Reply-To: <6d26f16646294836b87611f4dc5fe763@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Mar 2022 11:10:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKj5znW1z7Oyk03O1qLVADUNRC5GthoVcM37HajHnxBA@mail.gmail.com>
Message-ID: <CAL_JsqKKj5znW1z7Oyk03O1qLVADUNRC5GthoVcM37HajHnxBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: solve returning success but actually failed
To:     "Zhangjiantao(Kirin,Nanjing)" <water.zhangjiantao@huawei.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caiyadong <caiyadong@huawei.com>,
        guhengsheng <guhengsheng@hisilicon.com>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 4, 2022 at 6:06 AM Zhangjiantao(Kirin,Nanjing)
<water.zhangjiantao@huawei.com> wrote:
>

For the subject, something like: 'PCI: dwc: Fix setting error return
on MSI DMA mapping failure'

> When dma_mapping_error returns error because of no enough memory available, dw_pcie_host_init will return success, which will mislead the callers.

Wrap lines at 72 char.

>

Add a Fixes tag with whatever commit introduced the problem.

> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
> Signed-off-by: zhangjiantao <water.zhangjiantao@huawei.com>

Author and S-o-b names should match.

>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..ac691d733848 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -393,6 +393,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>               if (dma_mapping_error(pci->dev, pp->msi_data)) {
>                   dev_err(pci->dev, "Failed to map MSI data\n");
>                   pp->msi_data = 0;
> +                ret = -1;

Use an errno value. ENOMEM seems to be common, but I also see EIO and
EFAULT used.

Rob
