Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5162D3F7AC3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhHYQi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 12:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhHYQi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 12:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1563860F5C;
        Wed, 25 Aug 2021 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629909460;
        bh=N72KKszat2eurPq6Rq0lAoXAPysG/3U7/Mw/+e7I324=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=omCp8M1WBd8MHOqFiIUGp0HkP5mgHlX3wnDg2GdzRdfC46d+zijrDdu+ZkgK7hVZI
         iM/uog3O6yv+2UOR6CLYIyQ8WdIJDmGS/IzQmavks/9uW1xsFOENSuYW6mpBRnogJ+
         C39dTfoEVo+iXeciXDYTaPqDhxNkfYQEx/IwtKC36aNpPBwaKiLVY3tKCdHyNDspwN
         IcfMjgOqN5UVwM2+irGa+rAi/WRNDfSkY4q7j4tbyhi9yVuzyVgaXTVytICyMznu34
         8ioVnYZdBqBzAW2BQK2fKAvPm8EhTeOtoZRqdbxxDGnG2qrLIRpmYJxQJEonFgSgcv
         k/vh/srhvHd0Q==
Date:   Wed, 25 Aug 2021 11:37:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
Message-ID: <20210825163738.GA3576149@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

s/add support/Add support/ to match previous history.

On Wed, May 05, 2021 at 12:18:30PM +0300, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> 
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
> 
> The code is based on downstream Codeaurora kernel v5.4. Split out the
> DBI registers access part from .init into .post_init. DBI registers are
> only accessible after phy_power_on().

The "downstream Codeaurora kernel v5.4" reference would be more useful
if there were a URL reference to that driver.

> +#define AXI_CLK_RATE				200000000
> +#define RCHNG_CLK_RATE				100000000

These are unused.

> +	for (i = 0;i < 256;i++)

Add spaces after semicolons.
