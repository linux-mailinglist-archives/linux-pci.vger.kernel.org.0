Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D36A6219
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 23:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjB1WEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 17:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1WEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 17:04:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02277199CB;
        Tue, 28 Feb 2023 14:04:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cq23so46280662edb.1;
        Tue, 28 Feb 2023 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677621882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q3wr9vleUaBWv0fjP+3zIm41n8+4y/23bdQdfu1e5gI=;
        b=kXjIC9811i5bEaTokPhtu5hOzSi58cm3HX/Gdz2lvWFdAc4CFh6WsFEEsuGGJOMWFs
         F1hCp0Ll8wqTiPeWrT3IoImFX0EgPZPsQDOyooyAuS89S+xZ5Bqb+nO4qHrzBqPb0XpY
         LHMm3G4g0TH6lGX9G6x5N26HHDmJevRWJTQffxQvRlQ/1bOH0+aQxmnI8WBQ6yqRsGns
         PDi5y6e6Qpq8dA5HEmBxLOoY3TXq46jsU8hi8mGG8xUtJgZUaLDjsHSeu0chqgoT/Rwq
         y6VEaK/uoMqRP4yMAXegR4Mwk/Wm45jLWqbfbWPKK25p1HFcO53MRXTuWtPkBswAmfuZ
         Z9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677621882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3wr9vleUaBWv0fjP+3zIm41n8+4y/23bdQdfu1e5gI=;
        b=jSdncDGEI32TFiJ1fo9WHROEuLU9S14x3FNfmskx+ok8CIBEBmA5w+BdqpMBLZZKnU
         /R6ae6g2d2vkGbOikRnj3LV74L0UTsnjiLZaArEMuGHVwaQvU0IAyPTEPLjLGuFNlKXZ
         9rHqyLyUwInSgzFhjPwI6Dha5kxrQZrLygHukVdFUtF3PmTUW/it2Bg+pgtCwRzX67DQ
         1pqDJELWXLSyz1Uwa/RCEuQ5TLzvEkfCKwasp5JZAr6/b9q3B48U2tN7jWrbpJn1oRKP
         UYNrDTQPs+kwZ59Y3S7g2VYly5raJlRa+QHGY0tYZ6sqL3bBkZQjZSEFB+gwPERbpqNk
         brcQ==
X-Gm-Message-State: AO0yUKVruPNmmb4ztQ7dAqsHXqego2NY5E1CvnEc1wUm91FxgakdcP//
        02+7V4DNyzQ9nLNplXYP2NnSxSdxZ8gtXcopFcY=
X-Google-Smtp-Source: AK7set9yhZGiYm2bJwwuo0HrNm+yxTtsF8sAiJKGBEejQ5C0USEWoq1sx1ccRxk8TWGlICgRahPNM9mAXKE74gX5PMM=
X-Received: by 2002:a50:f69d:0:b0:4bb:f5d1:fb07 with SMTP id
 d29-20020a50f69d000000b004bbf5d1fb07mr87906edn.6.1677621882358; Tue, 28 Feb
 2023 14:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20230227201340.2087605-1-sdalvi@google.com>
In-Reply-To: <20230227201340.2087605-1-sdalvi@google.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Tue, 28 Feb 2023 14:04:30 -0800
Message-ID: <CAPOBaE4U4rCJ+4CcSoj597LsP-0ESBhiKKHz00bk+SvNHrOzKQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
To:     Sajid Dalvi <sdalvi@google.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
>
> In dw_pcie_host_init() regardless of whether the link has been started
> or not, the code waits for the link to come up. Even in cases where
> start_link() is not defined the code ends up spinning in a loop for 1
> second. Since in some systems dw_pcie_host_init() gets called during
> probe, this one second loop for each pcie interface instance ends up
> extending the boot time.
>
> Call trace when start_link() is not defined:
> dw_pcie_wait_for_link << spins in a loop for 1 second
> dw_pcie_host_init
>
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>

(CC'ed Krzysztof Kozlowski)

Acked-by: Jingoo Han <jingoohan1@gmail.com>

It looks good to me. I also checked the previous thread.
I agree with Krzysztof's opinion that we should include
only hardware-related features into DT.
Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..9709f69f173e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>                 ret = dw_pcie_start_link(pci);
>                 if (ret)
>                         goto err_remove_edma;
> -       }
>
> -       /* Ignore errors, the link may come up later */
> -       dw_pcie_wait_for_link(pci);
> +               /* Ignore errors, the link may come up later */
> +               dw_pcie_wait_for_link(pci);
> +       }
>
>         bridge->sysdata = pp;
>
> --
> 2.39.2.722.g9855ee24e9-goog
>
