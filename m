Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B248E2AA077
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 23:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgKFWkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 17:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgKFWkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 17:40:36 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0D02087E;
        Fri,  6 Nov 2020 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604702435;
        bh=LI7XGAY03yCtlMOYxKQUGueF89ZZGjsCxkyQXkTq7G0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kN7dCHr+StaLlgngJKnhsZEyAjmK88nsMt9bIFdPhTa1mebHCReIsb+KALOnxoj0V
         zQQ2EivJ9Farp2NGyaxBTbIUDhKWq7UtcgyhESSy1UX7t904Edw1irx2vRdNTnUMNk
         ax4+6ompNdw3ZvWrB8fZB/3IsL4+Vet6QpC6MINo=
Received: by mail-ot1-f49.google.com with SMTP id g19so2758683otp.13;
        Fri, 06 Nov 2020 14:40:35 -0800 (PST)
X-Gm-Message-State: AOAM533Pj7SqStTm9YjtjO9n0lQ5vJJ58G13IP4ggPm0/f9KG8YEISep
        YRyb7vM0Wo8daOFlT5M74W5HgwWr7GX09SD7fQ==
X-Google-Smtp-Source: ABdhPJyuNqsPVz5i1YucSMzUyTw1SdNWOTv/PSIMy5Zh8qaXkc5DJe4UulbFNQMcx67z+8BfhjFKBOpIXnWtbMtqZlQ=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr2355382ote.129.1604702435070;
 Fri, 06 Nov 2020 14:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20201106031208.160334-1-miaoqinglang@huawei.com> <20201106034249.169996-1-miaoqinglang@huawei.com>
In-Reply-To: <20201106034249.169996-1-miaoqinglang@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Nov 2020 16:40:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KYEYKqRcYvdy3CN+qLDq7MmMsQeQ_=RZ8+TT97wkgiA@mail.gmail.com>
Message-ID: <CAL_Jsq+KYEYKqRcYvdy3CN+qLDq7MmMsQeQ_=RZ8+TT97wkgiA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: v3: fix missing clk_disable_unprepare() on error
 in v3_pci_probe
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 5, 2020 at 9:37 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from v3_pci_probe() in the error handling case.
>
> I also move the clock-enable function later to avoid some
> fixes.
>
> Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  v2: add commit causing this problem and add more error handling
>      cases which are not enough.
>  v3: 1. fix the wrong 'Fixes commit'.
>      2. use goto to clean up this patch.
>      3. cover all error handling cases.
>  v4: fix uncorresponding author name.
>  drivers/pci/controller/pci-v3-semi.c | 49 +++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 19 deletions(-)

[...]

> @@ -889,7 +891,16 @@ static int v3_pci_probe(struct platform_device *pdev)
>         val |= V3_SYSTEM_M_LOCK;
>         writew(val, v3->base + V3_SYSTEM);
>
> -       return pci_host_probe(host);
> +       ret = pci_host_probe(host);
> +       if (ret < 0)
> +               goto err_clk;
> +
> +       return 0;

Slightly simpler to do:

    ret = pci_host_probe(host);
    if (!ret)
        return 0;

err_clk:


With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +err_clk:
> +       clk_disable_unprepare(clk);
> +
> +       return ret;
>  }
>
>  static const struct of_device_id v3_pci_of_match[] = {
> --
> 2.23.0
>
