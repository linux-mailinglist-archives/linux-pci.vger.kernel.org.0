Return-Path: <linux-pci+bounces-35580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FBB466C8
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 00:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA8D1B25965
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187C29D27A;
	Fri,  5 Sep 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j91+qH+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C5225761;
	Fri,  5 Sep 2025 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112274; cv=none; b=ic/157qgV2IVJ72Ge5bv44WVTpAmtQgjvsdx4VfJ/Ca6uEhd6+I1OaN8yt3xsITb0/H2tRsBrGm8j3iVD8P6l2oCDt8EnnoGgVsP3lLakPOG0dxtXYTNPItpINm/9cbXxYHXqGmGEkr9yOnKMNa0eEvgc46rbTTJQJ4hN/hJJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112274; c=relaxed/simple;
	bh=ecdRr8yDz4LhdbWsw8D/b4SVpMQdJT71OK6gvoVHdrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JGzBmzYiw1z7U7Gvmc2vkXfPWYO3Nq6iL+e1g2GQBiSNPC5yB1eQZpAG28rKV4mctZ/wVhZupj4C04g5TfHT07gTybvEbJuEfo+7QSTO11iMFE+Hs6NTNhqwPZlwuACW78YJxEjl2OUoVmHe2q9Ba4WyMh0o1XkTruPLzTpjq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j91+qH+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479A1C4CEF1;
	Fri,  5 Sep 2025 22:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757112272;
	bh=ecdRr8yDz4LhdbWsw8D/b4SVpMQdJT71OK6gvoVHdrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j91+qH+F+7zrhgPA7QmOREMjCCY9jtWORQ1GQgSLE3gNhaZ3EpcULfXyQskbKzPq7
	 Bc79AGYEReaJ5iPsPpaUTcUE6bkoJnidMz/2KoE1upgmW73yrZpisxEtFHnGd5Mtq+
	 O5cVz/EZOipDCa0Bt+O1SdlU8+6aeMbTxyALo7LZDo5dperTV9qRvAqc5041zQXgxI
	 X9+xyXQgUyyfWGPNocJQp/IxBpzyq+8d3H+zzmP6dyR4lDh+C8KlMxxaWHdDXhA+et
	 KxhhVX5wGOk/qLJhXRNS4y3Y5RPF4tO67RFV/RuIh+V5M8lKmJPfsxHJ/KY8+8G8OT
	 nCzrZrxp/DyhQ==
Date: Fri, 5 Sep 2025 17:44:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: qcom: Wait for PCIE_RESET_CONFIG_WAIT_MS
 after PERST# deassert
Message-ID: <20250905224430.GA1325412@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-1-2d461ed0e061@oss.qualcomm.com>

On Wed, Sep 03, 2025 at 12:43:23PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> PCIe spec r6.0, sec 6.6.1 mandates waiting for 100ms before deasserting
> PERST# if the downstream port does not support Link speeds greater than
> 5.0 GT/s.

I guess you mean we need to wait 100ms *after* deasserting PERST#?

I.e., this wait before sending config requests to a downstream device:

  ◦ With a Downstream Port that does not support Link speeds greater
    than 5.0 GT/s, software must wait a minimum of 100 ms following
    exit from a Conventional Reset before sending a Configuration
    Request to the device immediately below that Port.

> But in practice, this delay seem to be required irrespective of
> the supported link speed as it gives the endpoints enough time to
> initialize.

Saying "but in practice ... seems to be required" suggests that the
spec requirement isn't actually enough.  But the spec does say the
100ms delay before config requests is required for all link speeds.
The difference is when we start that timer: for 5 GT/s or slower it
starts at exit from Conventional Reset; for faster than 5 GT/s it
starts when link training completes.

> Hence, add the delay by reusing the PCIE_RESET_CONFIG_WAIT_MS definition if
> the linkup_irq is not supported. If the linkup_irq is supported, the driver
> already waits for 100ms in the IRQ handler post link up.

I didn't look into this, but I wondered whether it's possible to miss
the interrupt, especially the first time during probe.

> Also, remove the redundant comment for PCIE_T_PVPERL_MS. Finally, the
> PERST_DELAY_US sleep can be moved to PERST# assert where it should be.

Unless this PERST_DELAY_US move is logically part of the
PCIE_RESET_CONFIG_WAIT_MS change, putting it in a separate patch would
make *this* patch easier to read.

> Cc: stable+noautosel@kernel.org # non-trivial dependency
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..bcd080315d70e64eafdefd852740fe07df3dbe75 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -302,20 +302,22 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  	else
>  		list_for_each_entry(port, &pcie->ports, list)
>  			gpiod_set_value_cansleep(port->reset, val);
> -
> -	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	qcom_perst_assert(pcie, true);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
>  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  {
> -	/* Ensure that PERST has been asserted for at least 100 ms */
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +
>  	msleep(PCIE_T_PVPERL_MS);
>  	qcom_perst_assert(pcie, false);
> +	if (!pp->use_linkup_irq)
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);

I'm a little confused about why you test pp->use_linkup_irq here
instead of testing the max supported link speed.  And I'm not positive
that this is the right place, at least at this point in the series.

At this point, qcom_ep_reset_deassert() is only used by
qcom_pcie_host_init(), so the flow is like this:

  qcom_pcie_probe
    irq = platform_get_irq_byname_optional(pdev, "global")
    if (irq > 0)
      pp->use_linkup_irq = true
    dw_pcie_host_init
      pp->ops->init
        qcom_pcie_host_init                         # .init
          qcom_ep_reset_deassert                    # <--
 +          if (!pp->use_linkup_irq)
 +            msleep(PCIE_RESET_CONFIG_WAIT_MS)     # 100ms
      if (!dw_pcie_link_up(pci))
        dw_pcie_start_link
      if (!pp->use_linkup_irq)
        dw_pcie_wait_for_link
          for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++)
            if (dw_pcie_link_up(pci))
              break
            msleep(PCIE_LINK_WAIT_SLEEP_MS)         # 90ms
          if (pci->max_link_speed > 2)              # > 5.0 GT/s
            msleep(PCIE_RESET_CONFIG_WAIT_MS)       # 100ms

For slow links (<= 5 GT/s), it's possible that the link comes up
before we even call dw_pcie_link_up() the first time, which would mean
we really don't wait at all.

My guess is that most links wouldn't come up that fast but *would*
come up within 90ms.  Even in that case, we wouldn't quite meet the
spec 100ms requirement.

I wonder if dw_pcie_wait_for_link() should look more like this:

  dw_pcie_wait_for_link
    if (pci->max_link_speed <= 2)                   # <= 5.0 GT/s
      msleep(PCIE_RESET_CONFIG_WAIT_MS)             # 100ms

    for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++)
      if (dw_pcie_link_up(pci))
        break;
      msleep(...)

    if (pci->max_link_speed > 2)                    # > 5.0 GT/s
      msleep(PCIE_RESET_CONFIG_WAIT_MS)             # 100ms

Then we'd definitely wait the required 100ms even for the slow links.
The retry loop could start with a much shorter interval and back off.

I wish the max_link_speed checks used some kind of #define to make
them readable.

Bjorn

