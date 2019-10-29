Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D587DE8C48
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfJ2P7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 11:59:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389940AbfJ2P7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 11:59:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so2305997wmf.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2019 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jW6z4fKWJsBlYxKn7twBcd7IWPitytMCLX6jbiyT3C8=;
        b=R58RieOynQzxeOkYflDGPYNaowJp2iGxd/hBMRiOQ6dXaUV6q/dEFJAfuprFleLnbr
         2UZ5Py8YcpQPPN5KcmEqcPFoA8f7jGrIj/2s3Lca0AM9uzgIy+YlDBbF1PbzWdoY0MnS
         tbwtvlpJiWkIC5PmqYdS4J3BO6xh9HNEDLYkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW6z4fKWJsBlYxKn7twBcd7IWPitytMCLX6jbiyT3C8=;
        b=Sl6reMR8TW8NfTqYPAMLRBDzR3TIcQ3UTve+65p//wnSCg/bkpiff1524Y+x8ivnIs
         nGp1dqVigYkK4dx2gyHNjlVbmNtQI85E7fLyXLltsvuZ4I+nfluofO6nBkVmyjoIp5oE
         rwEnCJfRvIpCcvd0Hcffh2KqZQGdbMPUplL85krQRIqLpqoSg+9pTYYiMSQaHeZxgbcQ
         qEm/jNAMhcYMz/IAnSUaXT0mmbxtNNuZKvkWpDm0oJpNRWeDhj0Gki1KOjNeMR2hC204
         S9FcVIpIXCXV9q+flNUBwuvSzB/BUL0PJCKOdBiTarCYQlf5P7MtUs48TgRf04aHYIIb
         0PgQ==
X-Gm-Message-State: APjAAAUmWndXtMkSOFTcozn0lTk3uaCKh3uJ4tvZdsokL4MYypAayuLv
        bOUQYKPjk698pQUkEeWkVC06RHJXgb1Sw4UvSU9YPw==
X-Google-Smtp-Source: APXvYqyUalWNgn46AHsfEyAbE1JclhNBGQx9jhMwfsntmJynyRXE6Rw4WOC1O2HAw7rZ07ZQDAROcByNyjIizGr51ZM=
X-Received: by 2002:a05:600c:142:: with SMTP id w2mr4773242wmm.121.1572364786709;
 Tue, 29 Oct 2019 08:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191028163256.8004-1-robh@kernel.org> <20191028163256.8004-24-robh@kernel.org>
In-Reply-To: <20191028163256.8004-24-robh@kernel.org>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 29 Oct 2019 21:29:35 +0530
Message-ID: <CABe79T4p-YJp7nNx0iyyx46PFWBC57H-2+VL=RM9rKK-X4qdFg@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] PCI: iproc: Use inbound resources for setup
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

I reviewed and verified this change.. It is working fine.

Regards,
Srinath.

On Mon, Oct 28, 2019 at 10:03 PM Rob Herring <robh@kernel.org> wrote:
>
> Now that the helpers provide the inbound resources in the host bridge
> 'dma_ranges' resource list, convert Broadcom iProc host bridge to use
> the resource list to setup the inbound addresses.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix iproc_pcie_paxb_v2_msi_steer() to use resource_entry
> ---
>  drivers/pci/controller/pcie-iproc.c | 77 +++++++----------------------
>  1 file changed, 17 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 223335ee791a..f4d78e66846e 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1122,15 +1122,16 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
>  }
>
>  static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
> -                              struct of_pci_range *range,
> +                              struct resource_entry *entry,
>                                enum iproc_pcie_ib_map_type type)
>  {
>         struct device *dev = pcie->dev;
>         struct iproc_pcie_ib *ib = &pcie->ib;
>         int ret;
>         unsigned int region_idx, size_idx;
> -       u64 axi_addr = range->cpu_addr, pci_addr = range->pci_addr;
> -       resource_size_t size = range->size;
> +       u64 axi_addr = entry->res->start;
> +       u64 pci_addr = entry->res->start - entry->offset;
> +       resource_size_t size = resource_size(entry->res);
>
>         /* iterate through all IARR mapping regions */
>         for (region_idx = 0; region_idx < ib->nr_regions; region_idx++) {
> @@ -1182,66 +1183,19 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>         return ret;
>  }
>
> -static int iproc_pcie_add_dma_range(struct device *dev,
> -                                   struct list_head *resources,
> -                                   struct of_pci_range *range)
> -{
> -       struct resource *res;
> -       struct resource_entry *entry, *tmp;
> -       struct list_head *head = resources;
> -
> -       res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> -       if (!res)
> -               return -ENOMEM;
> -
> -       resource_list_for_each_entry(tmp, resources) {
> -               if (tmp->res->start < range->cpu_addr)
> -                       head = &tmp->node;
> -       }
> -
> -       res->start = range->cpu_addr;
> -       res->end = res->start + range->size - 1;
> -
> -       entry = resource_list_create_entry(res, 0);
> -       if (!entry)
> -               return -ENOMEM;
> -
> -       entry->offset = res->start - range->cpu_addr;
> -       resource_list_add(entry, head);
> -
> -       return 0;
> -}
> -
>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  {
>         struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> -       struct of_pci_range range;
> -       struct of_pci_range_parser parser;
> -       int ret;
> -       LIST_HEAD(resources);
> -
> -       /* Get the dma-ranges from DT */
> -       ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> -       if (ret)
> -               return ret;
> +       struct resource_entry *entry;
> +       int ret = 0;
>
> -       for_each_of_pci_range(&parser, &range) {
> -               ret = iproc_pcie_add_dma_range(pcie->dev,
> -                                              &resources,
> -                                              &range);
> -               if (ret)
> -                       goto out;
> +       resource_list_for_each_entry(entry, &host->dma_ranges) {
>                 /* Each range entry corresponds to an inbound mapping region */
> -               ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
> +               ret = iproc_pcie_setup_ib(pcie, entry, IPROC_PCIE_IB_MAP_MEM);
>                 if (ret)
> -                       goto out;
> +                       break;
>         }
>
> -       list_splice_init(&resources, &host->dma_ranges);
> -
> -       return 0;
> -out:
> -       pci_free_resource_list(&resources);
>         return ret;
>  }
>
> @@ -1276,13 +1230,16 @@ static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
>  static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
>  {
>         int ret;
> -       struct of_pci_range range;
> +       struct resource_entry entry;
> +
> +       memset(&entry, 0, sizeof(entry));
> +       entry.res = &entry.__res;
>
> -       memset(&range, 0, sizeof(range));
> -       range.size = SZ_32K;
> -       range.pci_addr = range.cpu_addr = msi_addr & ~(range.size - 1);
> +       msi_addr &= ~(SZ_32K - 1);
> +       entry.res->start = msi_addr;
> +       entry.res->end = msi_addr + SZ_32K - 1;
>
> -       ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_IO);
> +       ret = iproc_pcie_setup_ib(pcie, &entry, IPROC_PCIE_IB_MAP_IO);
>         return ret;
>  }
>
> --
> 2.20.1
>
