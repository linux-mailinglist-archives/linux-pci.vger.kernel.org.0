Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94194D1E10
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 18:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiCHREX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 12:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiCHREX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 12:04:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2D3B014;
        Tue,  8 Mar 2022 09:03:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FD860A53;
        Tue,  8 Mar 2022 17:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5C8C340F6;
        Tue,  8 Mar 2022 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646759005;
        bh=NKnnFyTivlkfLyeedrHqiD586sUqxiBFzjH+dgeXsZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d0LpCWREVCkBGMB7dwP3FyzDA9DmCKfiaoPZQz2qnK8O9mCqNBlvCjW4ovzyRpw0M
         Jue97MvArvdKZGZKx3KpMqixMnbL0PR4wEFUGyOjvJDibjKxq83G5bw89w9Gm5dvJu
         3VX6eNrQY1afVmPtQ8moAvTyWB2lePSuX7ol/w03eYoW8ilXSrr4sIBbZ2LkP2ZzEY
         DGMiierYKC/hjeKkkQoRxSy+sBBoX0lVdj4mpdfQf4HJsybqc55XCA5lXLFV4qhQxx
         QRWLvb/oUW5RhR/hOzTBb5GpgOvxYEQmdjPWlUCj4H7ynwuiL9uv6BZe3Q6npeoiRs
         HXfks9Jz/RByQ==
Received: by mail-ej1-f44.google.com with SMTP id qx21so40640810ejb.13;
        Tue, 08 Mar 2022 09:03:25 -0800 (PST)
X-Gm-Message-State: AOAM533RGQJ8RFPqxCHP6qJCt4tAOGtTGYApB7y1GFX20oszr4AxdhAT
        RKE/lFK209QxY2S2isnz8XD4E9jdvSP0PSKgWQ==
X-Google-Smtp-Source: ABdhPJzN23lpvKd1L3L5/TUPLoM0VFl/olTwDpOKkWJ4fTJqoM2LJ1xDS1gnhQCuWPgH4Mcpr3xC2yxZC4SCgRznV0U=
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id
 zl19-20020a170906991300b006d6dc485d49mr14270448ejb.325.1646758997461; Tue, 08
 Mar 2022 09:03:17 -0800 (PST)
MIME-Version: 1.0
References: <0dcdea9c559040509dd443ee75de75a1@huawei.com>
In-Reply-To: <0dcdea9c559040509dd443ee75de75a1@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Mar 2022 11:03:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
Message-ID: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
Subject: Re: [PATCH2] PCI: dwc: solve returning success but actually failed
To:     "Zhangjiantao(Kirin,Nanjing)" <water.zhangjiantao@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 8, 2022 at 9:45 AM Zhangjiantao(Kirin,Nanjing)
<water.zhangjiantao@huawei.com> wrote:
>
> When dma_mapping_error() returns error because of no enough memory available, dw_pcie_host_init() will return success, which will mislead the callers.

Again, wrap long lines. And please reword the subject as I previously suggested.

It should be 'PATCH v2', not 'PATCH2' in the subject. 'git send-email
-v2' does that for you.

>
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
>

Drop the blank line here.


> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>

As you are sending the patch, your S-o-b goes last. And the author
name still doesn't match here: 'Jiantao Zhang' vs.
'Zhangjiantao(Kirin,Nanjing)'

> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..9dcb51728dd1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -390,7 +390,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                 sizeof(pp->msi_msg),
>                                 DMA_FROM_DEVICE,
>                                 DMA_ATTR_SKIP_CPU_SYNC);
> -            if (dma_mapping_error(pci->dev, pp->msi_data)) {
> +            ret = dma_mapping_error(pci->dev, pp->msi_data);
> +            if (ret) {
>                   dev_err(pci->dev, "Failed to map MSI data\n");
>                   pp->msi_data = 0;
>                   goto err_free_msi;
> --
> 2.17.1
>
> Jiantao Zhang
>
> On 2022/3/5 5:39, Bjorn Helgaas wrote:
> > On Fri, Mar 04, 2022 at 12:06:10PM +0000, Zhangjiantao(Kirin,Nanjing) wrote:

All this should not be in new versions of patches.

> >> When dma_mapping_error returns error because of no enough memory available, dw_pcie_host_init will return success, which will mislead the callers.
> > Wrap to fit in 75 columns, add "()" after function names.
> >> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
> >> Signed-off-by: zhangjiantao <water.zhangjiantao@huawei.com>
> >>
> >> ---
> >>    drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> >>    1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index f4755f3a03be..ac691d733848 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -393,6 +393,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>                if (dma_mapping_error(pci->dev, pp->msi_data)) {
> >>                    dev_err(pci->dev, "Failed to map MSI data\n");
> >>                    pp->msi_data = 0;
> >> +                ret = -1;
> > We should save the return value from dma_mapping_error() and return
> > *that*, not -1.
> >
> > Whitespace error (indent with tabs, same as the surrounding code).
> >
> >>                    goto err_free_msi;
> >>                }
> >>            }
> >> --
> >> 2.17.1
> >>
> > .
