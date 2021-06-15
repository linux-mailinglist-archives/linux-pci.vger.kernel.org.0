Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43943A8B49
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOVmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhFOVmy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:42:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0551D610A2;
        Tue, 15 Jun 2021 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623793249;
        bh=/oWKsJvcxdMz4Rzoy3pE+j7Iv7xWCF+ZYupP97KOmKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aXR0SfR6dp9FSdmaNvBHqVz5z8mnf/59BkVJt86UYIU+BSZg1J9jqV0YZyRBggCCY
         deA2wkpV7slrL1m5RFdACByKIx00u6VNdusvpHIFF5c74mZu7Y5xWfmnAOx8ZUI9P5
         033jQAWEknB1kr+QzXRiqTyX+tPaEZvoz9ArleVckiZm6J4iJ+aMNg8z91qpPYUMbQ
         OBEPSjWULqgs5M4bp+qX3ywFFj3HjJadoBqH5om/V1INIU4S28x9gAwLsWuoUG/3Qh
         7bq8GzfljmU2sHmL6w/7VgxxuKVWa9+pvZdHVi0BOaWjaApMvmqfKAvKthsjqeTP20
         g9d66GgdII56g==
Received: by mail-qk1-f177.google.com with SMTP id c18so441632qkc.11;
        Tue, 15 Jun 2021 14:40:48 -0700 (PDT)
X-Gm-Message-State: AOAM530csdEHuU+c0oHSdWvqqTA8ckCygCGIwF5FxBgybvnZmAPklGqw
        EK9isBpxSFmWDwVQVcGDzsun0TwsQwLnS6qO3g==
X-Google-Smtp-Source: ABdhPJz/0cruuS8J7a6V1fXkhT9dT8IPshEj5fOX6o+PdZ6Rz1bo0/Pa0u1uPJxt+3RO+D9aKPcUX5aWfodohh+B8wk=
X-Received: by 2002:a37:a2d3:: with SMTP id l202mr1708344qke.311.1623793248238;
 Tue, 15 Jun 2021 14:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-3-manivannan.sadhasivam@linaro.org> <YLw744UeM6fj/xoS@builder.lan>
In-Reply-To: <YLw744UeM6fj/xoS@builder.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Jun 2021 15:40:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com>
Message-ID: <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 5, 2021 at 9:07 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
>
> > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > the Designware core with added Qualcomm specific wrapper around the
> > core. The driver support is very basic such that it supports only
> > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > for now but these will be added later.
> >
> > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > operation and written on top of the DWC PCI framework.
> >
> > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > [mani: restructured the driver and fixed several bugs for upstream]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Really nice to see this working!

[...]

> > +static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
> > +{
> > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PCIE_PERST_EN);
>
> Please avoid _relaxed accessor unless there's a strong reason, and if so
> document it.

Uhhh, what!? That's the wrong way around from what I've ever seen
anyone say. Have you ever looked at the resulting code on arm32 with
OMAP enabled? It's just a memory barrier and an indirect function call
on every access.

Use readl/writel if you have an ordering requirement WRT DMA,
otherwise use relaxed variants.

> > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PERST_SEPARATION_ENABLE);
> > +}
> > +

[...]

> > +static struct platform_driver qcom_pcie_ep_driver = {
> > +     .probe  = qcom_pcie_ep_probe,
> > +     .driver = {
> > +             .name           = "qcom-pcie-ep",
>
> Skip the indentation of the '='.
>
> > +             .suppress_bind_attrs = true,
>
> Why do we suppress_bind_attrs?

Because remove is not handled.

Rob
