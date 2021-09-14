Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8240B037
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhINOFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 10:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhINOFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 10:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48B5D6109E;
        Tue, 14 Sep 2021 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631628277;
        bh=iQJMVWDJXIz4+Xnw+Zmg2wTPTmdj6J/jGV1015/5YnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sh0LzS3sjwfoLX0GTTG4bYX4blk6Ke37ZobsjjU36s3FXmpuukuAVFMlrgFE8TZhx
         EeJTMn0gyT3HSSR4sdkvIe7StpiDB7V85s8j29p5SpXCMfl73qNxySVT8Ie60y2vcV
         vpix8KeCPPe3P81A+ergZLI6GmhIf4aMDBVK6jpzZa3jwvCpze4fyg8qmaNhURy5Wf
         aiHr6ir8zwQlRN1fT/mqpLFTqaLxoP/fDxYZ5qICbI5RjU8kbA9HYnpJsD8/cwosjB
         jIfwjYdhrAcZvCqucxW3WWay2IaphC8JawlfMJP8AiOGLWbBeG+Fw3+RZR7Y1aDhJR
         6oIELkkIGQ5Hw==
Received: by mail-ed1-f47.google.com with SMTP id t6so18690146edi.9;
        Tue, 14 Sep 2021 07:04:37 -0700 (PDT)
X-Gm-Message-State: AOAM5310p/B6mj6bG67L2XaY/HsdqnmaocVzCvDZ9IrnxLOBCdONFl0S
        W+sFC8mrsvUTDXFH5XlItBwpJl6xlzk4xm2Wbw==
X-Google-Smtp-Source: ABdhPJwUbUy1IP1vgkqhQdfLkWfsy/Qq1h3BMnp5iQMqPnzVJ11nLcXtGK+gUd4ZWnMAlXCfmg09DjEmu8QfDA/aRZs=
X-Received: by 2002:a05:6402:b23:: with SMTP id bo3mr16054495edb.145.1631628275923;
 Tue, 14 Sep 2021 07:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org> <20210722121242.47838-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210722121242.47838-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Sep 2021 09:04:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKW+yCx5Hzgz0tFNcX0irhJ9aQ=TNeewLHsheoyMRFLjw@mail.gmail.com>
Message-ID: <CAL_JsqKW+yCx5Hzgz0tFNcX0irhJ9aQ=TNeewLHsheoyMRFLjw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: qcom-ep: Add Qualcomm PCIe Endpoint
 controller driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        hemantk@codeaurora.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 7:13 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add driver support for Qualcomm PCIe Endpoint controller driver based on
> the Designware core with added Qualcomm specific wrapper around the
> core. The driver support is very basic such that it supports only
> enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> for now but these will be added later.
>
> The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> operation and written on top of the DWC PCI framework.
>
> Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> [mani: restructured the driver and fixed several bugs for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  10 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 710 ++++++++++++++++++++++
>  3 files changed, 721 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

Reviewed-by: Rob Herring <robh@kernel.org>
