Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E37066C1
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjEQLdK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 May 2023 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEQLdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 07:33:09 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DC3586;
        Wed, 17 May 2023 04:33:08 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9659dee48edso14904766b.0;
        Wed, 17 May 2023 04:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684323187; x=1686915187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl9g4P9fn/ow2SVfxZLfrDHoUGbKllbUHO/i8DHz10U=;
        b=dQCQHHR6fdQzKMoP0z3RcmA0E99oTgixH7FaiQaX6olAgz6TtSdmqEPDFrggOhXyMS
         9UhosN1gPdEnOBbX1O9VCY4gIVEIGO6NQXLD6+b8+Bxt75LonXkJByNkNgBCcHUYjnO3
         sJtqCQkxcPEGumDflGZUv1A/l3skE+FMWhkY/VBTPxrq9TYGtKRBJC25qBtxBCN284J7
         i45GU5n6VKAcL49bbuSmfuh7w81oxehumPjnWeLgyYOAYm64Fj4iJD1ppRFAjIItdPLu
         9vlfa5++bhdu9z3WNp5QKBekg2Wt2uNod89pQO6G7ycjAK+7GwPwgDRVcDJ1GE9yLUI3
         1GHQ==
X-Gm-Message-State: AC+VfDzXCWeEipkPEDSX4EzxT6AzMWVwGtv1JKmtRn/hoiIopAwXzUaK
        sttX8QR7tY9AUXqJvFJWY9MGWGaDewZHkYMB+IE=
X-Google-Smtp-Source: ACHHUZ50fbAAxtJUeYyoZEDxDXkML5PHCTkLAd8EIK8CYo/D7X7qDb8I8MVqT33c2HnEOnEdnVmr2s3OtHNkqVDZnEE=
X-Received: by 2002:a17:906:ce:b0:965:9db5:3821 with SMTP id
 14-20020a17090600ce00b009659db53821mr1937007eji.7.1684323186699; Wed, 17 May
 2023 04:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com> <20230517105235.29176-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230517105235.29176-3-ilpo.jarvinen@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 13:32:55 +0200
Message-ID: <CAJZ5v0jUG+4ey18VX5OJyzxXJDfDtxasH-HRYeba-oAB9VJJ8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] PCI: pciehp: Use RMW accessors for changing LNKCTL
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 12:53 PM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> As hotplug is not the only driver touching LNKCTL, use the RMW
> capability accessor which handles concurrent changes correctly.
>
> Fixes: 7f822999e12a ("PCI: pciehp: Add Disable/enable link functions")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index f8c70115b691..26623e2884a3 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -332,17 +332,11 @@ int pciehp_check_link_status(struct controller *ctrl)
>  static int __pciehp_link_set(struct controller *ctrl, bool enable)
>  {
>         struct pci_dev *pdev = ctrl_dev(ctrl);
> -       u16 lnk_ctrl;
>
> -       pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
> +       pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> +                                          PCI_EXP_LNKCTL_LD,
> +                                          !enable ? PCI_EXP_LNKCTL_LD : 0);
>
> -       if (enable)
> -               lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
> -       else
> -               lnk_ctrl |= PCI_EXP_LNKCTL_LD;
> -
> -       pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
> -       ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
>         return 0;
>  }
>
> --
> 2.30.2
>
