Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD0572237
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGLSKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGLSKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 14:10:15 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460612AC7;
        Tue, 12 Jul 2022 11:10:15 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id h62so12677572ybb.11;
        Tue, 12 Jul 2022 11:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ajRROCzsGzf/oZHzGwM4u5js6AqaHpYWximnT5xFfY=;
        b=W+0HGuMhvGpJzOudWOqt6t7gwiSInJ701w28lFuQPKJLdfZvoppC+SQJJG91S//pB8
         8Vvb+daiAx2uN38J2J+XgmbifCtrzAWwtIvW9G9SjRdtafgAYeLdfx3PG6uX+RorKDYK
         O87/DQiI8kL8UPr1N9xBlPhNvd6huLJX6QDbbglC0iuwo61uAHJHK+U6bUqp4Rih3QlV
         ZdbbN+IArgo2jaUshwihJABaEGgbGCfFRAoJhqDcZyVqrXhpZ1Sz+60fiqxaKXdoCVN0
         YYU1pLsIKLpOxDsDbanN9GN1YSBh9TJ+etrTmIDaf+O0ZGQi98bUAQVZ9DLyhXJF8OKB
         y80A==
X-Gm-Message-State: AJIora9VDt+QO6OSnr+QyEHYpzIyvNsAyO3Jcg5RERZSK6iaEE2lONMz
        p8mcASbFNCBqaDIAXidIm4ww9Hro8rN0jwfFfoo=
X-Google-Smtp-Source: AGRyM1sW4QB3B6/zvLrzkhAsEvuKPbuv9+dLMLAn+66dCgmzTc20cxd5Fs/TvjLJShPV/tcbQyP8nRIs/u720kHZ0kY=
X-Received: by 2002:a25:fb02:0:b0:66e:3db9:5d49 with SMTP id
 j2-20020a25fb02000000b0066e3db95d49mr24779010ybe.137.1657649414441; Tue, 12
 Jul 2022 11:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220711231419.706639-1-helgaas@kernel.org>
In-Reply-To: <20220711231419.706639-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:10:03 +0200
Message-ID: <CAJZ5v0gYhSkFWF49+orQsiqO0Kbmc_A+1L+QiZWcO6Q8sGWFKQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Unexport pcie_aspm_support_enabled()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 1:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pcie_aspm_support_enabled() is used only by the acpi/pci_root.c driver,
> which cannot be built as a module, so it does not need to be exported.
> Unexport it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pcie/aspm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7f76a5875feb..a8aec190986c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1347,4 +1347,3 @@ bool pcie_aspm_support_enabled(void)
>  {
>         return aspm_support_enabled;
>  }
> -EXPORT_SYMBOL(pcie_aspm_support_enabled);
> --
> 2.25.1
>
