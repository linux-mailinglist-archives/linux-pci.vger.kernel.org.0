Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BF2A2C89
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 15:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgKBOSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 09:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKBOQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 09:16:01 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E32A2415A;
        Mon,  2 Nov 2020 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604326560;
        bh=BteA5gzi7Uc4vRznHTY1jzjlxtohwfi7tjYpM1Pa+kg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+Y92WQb7KI1O+cmweJ/DKgowsz6auuN2X+fmPan9lDeUPfatkX9v9tEx3b+IZnqL
         IrH6z3QtUyIiGuRPR+rDsmJqz1sHHNC+byLWpIwalVHOeGHXVi7M3S7AQusuO/0az+
         Ib1llJ/RXnc0zV4v4tVINltTdrTfy2VHj3C5AdRg=
Received: by mail-ot1-f51.google.com with SMTP id j14so2488929ots.1;
        Mon, 02 Nov 2020 06:16:00 -0800 (PST)
X-Gm-Message-State: AOAM530MBNK5UfYBjTnB5fLMCMHBQRf6ejgGQMFDYR9vUQTvcyT85V6q
        dkPfQi9O6yx3F4BJSXffb5JAXNRUCneHGlCATg==
X-Google-Smtp-Source: ABdhPJxML32jJZ3qQ1A9Es6W1bxqsPN29fgL87NHAnZ1Aq73CytCsBQV2B0zZKDeQKXafYAhwxjHZhVjwXlWjG169gE=
X-Received: by 2002:a9d:6e0c:: with SMTP id e12mr1325014otr.129.1604326559463;
 Mon, 02 Nov 2020 06:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20201029053959.31361-1-vidyas@nvidia.com> <20201029053959.31361-3-vidyas@nvidia.com>
In-Reply-To: <20201029053959.31361-3-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Nov 2020 08:15:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
Message-ID: <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 12:40 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a. This patch does the required programming in ATU upon
> querying the system policy for ECRC.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> V3:
> * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
>
> V2:
> * Addressed Jingoo's review comment
> * Removed saving 'td' bit information in 'dw_pcie' structure
>
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index b5e438b70cd5..cbd651b219d2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>                                  upper_32_bits(pci_addr));
>         val = type | PCIE_ATU_FUNC_NUM(func_no);
> +       if (pci->version == 0x490A)
> +               val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
>         val = upper_32_bits(size - 1) ?
>                 val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>                            lower_32_bits(pci_addr));
>         dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>                            upper_32_bits(pci_addr));
> -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -                          PCIE_ATU_FUNC_NUM(func_no));
> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
> +       if (pci->version == 0x490A)

Is this even possible? Are the non-unroll ATU registers available post 4.80?

Rob
