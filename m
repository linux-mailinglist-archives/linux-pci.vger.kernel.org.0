Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684B3E2FDA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 21:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbhHFTsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 15:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhHFTsT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 15:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A04BC611BF;
        Fri,  6 Aug 2021 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628279283;
        bh=A6nLSI9mCf6mhp34t8GesHN20NVCy2XtPV0FcrWZoyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aHwyEPqZQjQqD/Z98svs+HauUDSyCNlqKKe7OApL00K7PMn96Y5CvQItAIjqabxoP
         Rpai4fhu5SM+A73eQTE2WsjX6lGvA/j8vvWkSTrnZk0O32dSMJm8/OF+L8icGy5Hbs
         VTKWiw9rTcV3cGa03KcznUgexrj5DcehKjYTue2AVM5w2ce7IoPbpKzSewhwvm7+EI
         2zjItvepB0O5VzjQZBAo5TM6On8jxJnjCW0EmK2wmdBwjEb7DwD8EA0wl8RXCaNHSq
         R2FpDJTuj/ppy/Gx1eS8HEBC01HO1Z6vggmytuY8SjKRly9r1zUm2EhSys64w1AdQC
         AVgei3lb3X/lA==
Received: by mail-ej1-f51.google.com with SMTP id hw6so16829720ejc.10;
        Fri, 06 Aug 2021 12:48:03 -0700 (PDT)
X-Gm-Message-State: AOAM533ZVQzc/77zDBxyqRxnFNBk061GCYZOe6Io2tzxKYU+kneXXgAy
        4DaNIbnuiZU4R7fZJKU6sf9O8l5yPT3h+a4WqQ==
X-Google-Smtp-Source: ABdhPJzchWTvDeHq2trbxdxbRY5qp5nwFN4uSbf8D1NAK7KPGhs0/CO4eEDCG1J5SF8SgKAnHxpX2jEhCXIqQcnyhlU=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr11272506eje.341.1628279282121;
 Fri, 06 Aug 2021 12:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620203062.git.baruch@tkos.co.il> <c15ac1443ec765e32a2801241dcd8e924abc769b.1620203062.git.baruch@tkos.co.il>
In-Reply-To: <c15ac1443ec765e32a2801241dcd8e924abc769b.1620203062.git.baruch@tkos.co.il>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 6 Aug 2021 13:47:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SBRP4n-0Q9RShxj2Od-EGpBURNUZo8fLnscOY-m7SmA@mail.gmail.com>
Message-ID: <CAL_Jsq+SBRP4n-0Q9RShxj2Od-EGpBURNUZo8fLnscOY-m7SmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PCI: dwc: tegra: move GEN3_RELATED DBI register to
 common header
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> These are common dwc macros that will be used for other platforms.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 6 ++++++
>  drivers/pci/controller/dwc/pcie-tegra194.c   | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
