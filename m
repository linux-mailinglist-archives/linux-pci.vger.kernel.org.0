Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC92A15CA52
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBMS1A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 13:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMS1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 13:27:00 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E991222C2;
        Thu, 13 Feb 2020 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581618419;
        bh=Tgkvt23nlRf0XRm+t9xKVRBeZnNy7mLvrbdLPrq1dno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bz+2U90q4xyRoqgdjfbIX6rHvFOv6QdyFS6R6dKIw0F240hKve4cOqhYLU6RzTo0/
         xYdsNw0MvvYnOGpW6fTmgezOVEAz5tB7pLxYFgxHqnypwKMrBJCb0typQTORRXWsQ1
         h3oFcMDISvLmyBj62uGuw7KgJxdfMKD092DRS7Qc=
Received: by mail-qk1-f171.google.com with SMTP id h4so6675378qkm.0;
        Thu, 13 Feb 2020 10:26:59 -0800 (PST)
X-Gm-Message-State: APjAAAUgAbpss0fNhG8qSnBl1pnJO0Al7CI4TIfyc5jCiJvb43UwLgmT
        AohdDweq6JgpMao3YinTOyzOOUGSQftkNYm0/Q==
X-Google-Smtp-Source: APXvYqydhKuBg+/ZrL4Cf+7gEQaOWH7r03zYxO/RkcD73vQs6Tc8XsgSRSpX2/PYrxCooFDmMvbFm0IEPx+1x/u9y3A=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr17247898qkd.223.1581618418620;
 Thu, 13 Feb 2020 10:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213165049.508908-1-jean-philippe@linaro.org> <20200213165049.508908-4-jean-philippe@linaro.org>
In-Reply-To: <20200213165049.508908-4-jean-philippe@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Feb 2020 12:26:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
Message-ID: <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
Subject: Re: [PATCH 03/11] PCI: OF: Check whether the host bridge supports ATS
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 10:52 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Copy the ats-supported flag into the pci_host_bridge structure.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/pci/controller/pci-host-common.c | 1 +
>  drivers/pci/of.c                         | 9 +++++++++
>  include/linux/of_pci.h                   | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 250a3fc80ec6..a6ac927be291 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -92,6 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev,
>                 return ret;
>         }
>
> +       of_pci_host_check_ats(bridge);
>         platform_set_drvdata(pdev, bridge->bus);
>         return 0;
>  }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 81ceeaa6f1d5..4b8a877f1e9f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -576,6 +576,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
>
> +void of_pci_host_check_ats(struct pci_host_bridge *bridge)
> +{
> +       struct device_node *np = bridge->bus->dev.of_node;
> +
> +       if (!np)
> +               return;
> +
> +       bridge->ats_supported = of_property_read_bool(np, "ats-supported");
> +}

Not really any point in a common function if we expect this to be only
for ECAM hosts which it seems to be based on the binding.

Otherwise, needs an export if not.

Rob
