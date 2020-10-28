Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8840B29D663
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgJ1WOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbgJ1WOf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:14:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D74C0613CF;
        Wed, 28 Oct 2020 15:14:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w14so681907wrs.9;
        Wed, 28 Oct 2020 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fi8q6ESdpC7mVsibaiRpL1bxWlgrgEmpFL9r1sjf6UY=;
        b=WAu8G8orwmCYoTCx32SD0nlUGeCSwaRuBotGjPZZ8b7IgWSntsmVgNHi9oPvplimUD
         LwUDzzYni8SR7FIt0xVcsW8jbuOKTEejyAAEJN3ttp6ss5MRnzeCsD0m/JHnKACp3agD
         pi7IMfoga8YaKJfjCTmqmO3/TBQY9pWwcd6wN1euID3y2S6dxDpK+2olJYu8AcrWB2bt
         F/HLLBRRg3WSVTJBZ3bO4vbyTmYzxpXFzKWaOoI1bJJcPLVtLGHDVRKx/BcAQgteTsUw
         lPHyQzfM1VD+qXedgfjF/kdZaRaA5dMeIoa1lmKfmvGMU9s0wVfMBKyhmtlmZkyCwsys
         bVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi8q6ESdpC7mVsibaiRpL1bxWlgrgEmpFL9r1sjf6UY=;
        b=ZGWqTcG/OVq84i/IyvgHppKpwJnOHMaJx2QbNwOWFpUiiTACKtdfoO4T9pkOvIE1CC
         RLpXeI2s3mkq7JAa7PA/+mxebW+1/34nKEPQCh94voWNfyal35IMGLoAPLpqq6W5f/n6
         erNvMDT3rBivgUd/74OLdP/ZrKmCyK0x2tFpfBL4Qnm/q72zOMUsWvt1y10n2ZHG8Hz0
         3sijBI+fw7ugtWKX1Vx46hayCUdC0rdm0GLDUUN/zCp5Y2WDe0cLkbEHHkbWXuKeqxSC
         vR6ign22CPOHitCthl4xuvG5wLJMTRmMDWLCmvHRz6aDWWNZjbHkhKW9SgBxQBzBl1Dy
         tZjg==
X-Gm-Message-State: AOAM530J3MZy0DaVtPzTrxbgbs+CKP6M6KbTBwSq21l781qLtUvvoID5
        xOgntlcEkFrZrKUeTFZm4oQ05ZuU5B2rNUQ+PYxKvoWSjC0=
X-Google-Smtp-Source: ABdhPJxgNeQYyUP3wsaYIP1EcdBr4YCdS5q1Lr29sZZpUjWqHjAgz2QBJgcfwbn4NAYJn6kFqYgiihfTSMeV1jB+8OQ=
X-Received: by 2002:a50:fc85:: with SMTP id f5mr5636774edq.187.1603853287026;
 Tue, 27 Oct 2020 19:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080330.8877-1-vidyas@nvidia.com> <20201027080330.8877-2-vidyas@nvidia.com>
In-Reply-To: <20201027080330.8877-2-vidyas@nvidia.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 28 Oct 2020 10:47:55 +0800
Message-ID: <CAKF3qh2Rh7pc59j2THpNi=rsj1OYG7Ac5yg+yTcqoP8J9X6DxQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] PCI/AER: Add pcie_is_ecrc_enabled() API
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        amurray@thegoodpenguin.co.uk, robh@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 9:48 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Adds pcie_is_ecrc_enabled() API to let other sub-systems (like DesignWare)
> to query if ECRC policy is enabled and perform any configuration
> required in those respective sub-systems.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * None from V1
>
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..325fdbf91dde 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -575,9 +575,11 @@ static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #ifdef CONFIG_PCIE_ECRC
>  void pcie_set_ecrc_checking(struct pci_dev *dev);
>  void pcie_ecrc_get_policy(char *str);
> +bool pcie_is_ecrc_enabled(void);
>  #else
>  static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
> +static inline bool pcie_is_ecrc_enabled(void) { return false; }
>  #endif
>
>  #ifdef CONFIG_PCIE_PTM
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..24363c895aba 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -207,6 +207,17 @@ void pcie_ecrc_get_policy(char *str)
>
>         ecrc_policy = i;
>  }
> +
> +/**
> + * pcie_is_ecrc_enabled - returns if ECRC is enabled in the system or not
> + *
> + * Returns 1 if ECRC policy is enabled and 0 otherwise
 How about 'Returns true if ECRC policy is enabled and false otherwise'  ?
> + */
> +bool pcie_is_ecrc_enabled(void)
> +{
> +       return ecrc_policy == ECRC_POLICY_ON;
> +}
> +EXPORT_SYMBOL(pcie_is_ecrc_enabled);
>  #endif /* CONFIG_PCIE_ECRC */
>
>  #define        PCI_EXP_AER_FLAGS       (PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
> --
> 2.17.1
>
