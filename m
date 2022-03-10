Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279D4D468F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 13:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiCJMPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 07:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCJMPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 07:15:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91C1480C7;
        Thu, 10 Mar 2022 04:14:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g3so6738637edu.1;
        Thu, 10 Mar 2022 04:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4COMUl/6hBE8eBhF3Ao+as3agsYqq6BZGQfwluB0PE8=;
        b=mHGo5CDUdOpB+yGzGobSid4tBRjYxrVO/wHYUbVDTMt6SgTFfcPmeguI9yHO0Iz2yJ
         2KkKb9/OpXZbl0lCWGM3QA4uVhx2S3k8TgWh/EFhs7w7M9kMFcZUGROo5HRACUk+QxEy
         dRLurHR9+6x3EYbaAtIKJudw1butP+ZnyZ/KNBdMGzvUGhgv01LQ6AJZ1rrUI3/Gu0uq
         DxjdNJfKGg3ePg+rpRXqo79YBdUPkxXH2FmuztcTDj+okJwJJ6wVtBS1ea2ZYvd6O2AO
         sFVPH03WMaUHnPdAqMQNXCbqSzIp9fqDSHJEuud8sEF1MVpKBhkza+NEXUFdX27RARGC
         rvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4COMUl/6hBE8eBhF3Ao+as3agsYqq6BZGQfwluB0PE8=;
        b=tNujJqVRZzITepxwIiQQMjEbZ4qC7WXWSekRTbwHYa8MLiu0dGgWf/gc17bB/hMqJ+
         W0VQP655sDzqbI4xjAQwN2z+hVU3gXAl443BgsH6bwvS1NJA4UKlRHPD/TL/GHA309ls
         ZkWsn957tEV0ODPLr3uozUJ3AbP50rHE42poKFli7vD/fzbGmegQkXzMOe4QpG8kUFU6
         mGCCI0EYoV2Y8x/oMbUjHbw32hZF/NddrDOq5kHxDebn1RBNOhPPwQYmRjPElBBftdIC
         RU4QCFGANtFl6+HkvF5OzZ6oa4jM5T76HEZpe0gLu5OE1G3uCHcPZsrtdVdo2YFAw68m
         smeg==
X-Gm-Message-State: AOAM53355fs78lLkuC0zR5enHVVMFAdMqU/eUemJ09cm1F16peeUdzCd
        zk3x76kMKledyilDHHoyQmkgnP1Xyhfqzxb98VXhUOvw
X-Google-Smtp-Source: ABdhPJyIQwDF4/h0ZL24np8q3S8vUukRxTE3i7k0tqR2wAFZGWr7nfyXZZkqDjDFienk7xtlxw7kl21XZD9EeYNSmww=
X-Received: by 2002:a05:6402:290f:b0:416:537b:7a2d with SMTP id
 ee15-20020a056402290f00b00416537b7a2dmr3904059edb.381.1646914456873; Thu, 10
 Mar 2022 04:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20220222162619.14645-1-christian.gmeiner@gmail.com>
In-Reply-To: <20220222162619.14645-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 10 Mar 2022 13:14:05 +0100
Message-ID: <CAH9NwWebh9QJ0VevG5b7pnaRnzJ6XcEmeKYgZ=NPPt9ZxTXUfA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: cadence: Enable Controller to respond to received
 PTM Requests
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all

> This enables the Controller [RP] to automatically respond with
> Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> and PCI_PTM_CTRL_ENABLE bits are both set.
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index fb96d37a135c..940c7dd701d6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>         return ret;
>  }
>
> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> +{
> +       u32 val;
> +
> +       val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> +}
> +
>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>  {
>         struct cdns_pcie *pcie = &rc->pcie;
> @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>         if (rc->quirk_detect_quiet_flag)
>                 cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>
> +       cdns_pcie_host_enable_ptm_response(pcie);
> +
>         ret = cdns_pcie_start_link(pcie);
>         if (ret) {
>                 dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index c8a27b6290ce..1ffa8fa77a8a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -116,6 +116,10 @@
>  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)          \
>                                         (((aperture) - 2) << ((bar) * 8))
>
> +/* PTM Control Register */
> +#define CDNS_PCIE_LM_PTM_CTRL  (CDNS_PCIE_LM_BASE + 0x0da8)
> +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN  BIT(17)
> +
>  /*
>   * Endpoint Function Registers (PCI configuration space for endpoint functions)
>   */
> --
> 2.35.1
>

This patch should be ready to land - or is anything missing?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
