Return-Path: <linux-pci+bounces-44462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BAD1079E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 04:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1DA4300BFA6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC840306498;
	Mon, 12 Jan 2026 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRKng5a/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A92264C9;
	Mon, 12 Jan 2026 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188433; cv=none; b=lAeRSNWpjQfXxbNqcaj/DkEXzQbyfuxU8YizgcbW3bCsp3xNYITUmkqzrz2dxzMrGAWDmn0gq2J4b8Og68LrKsiLffNJgqjacFZnlEcUse0rlb6fyl8Rlx4LR72tjt3X6g6cUhR/zxBdYcxa2wpfKXhgvq4rsNLOurg4xCrpCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188433; c=relaxed/simple;
	bh=q9jniiEEa+6T93cqGEAcHIfUw01y9XO40IggaYSSQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XuWnn77AxmA/vB72INngkzOU6sqnIORobRZusCVQVwGxxnuxX3RqdrTKvQqzEOxiQM9LKLjJE2XB04bp+aMj3kwgQg5VTdjUfSJOcYEM0IUlQenJUbL07i72yEKNEDx9l+WyIJYgXdU9s0Jc6Fju7v1Sl5X0pT0YeSbm1qcFBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRKng5a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4DC116D0;
	Mon, 12 Jan 2026 03:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768188433;
	bh=q9jniiEEa+6T93cqGEAcHIfUw01y9XO40IggaYSSQVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nRKng5a/tNoVl44MuNO4lArzF2eLwcJUsE8fHNy5rZH0z+3pJ3H7SVDAy0kwZ5c8P
	 hMCR4vLFy4imAXchq9DHy2rvxkjwYa2zaxRa+WJNpbpm8M063X3FHtwnDeEuuBICVq
	 /4aywTkb6hukNmfQ5WjmIRM9/VZg8nrIEILEJOH93FJ6cSN3TaSTqVLBbbGCXbFXaj
	 5t6PIpZPobOoExkZUT6DYC1o4rpun7ZpBWf7uVlQap1UdrvqfQrl8pBc1YQR/BpHyZ
	 IGsSlBoN3/JyzKuSSX3i3RbyoUoUzyfvF9pg/PO2VwL3GTViKFds5TjlVOQgafmrZH
	 uyEtReTRZD6ig==
Date: Sun, 11 Jan 2026 21:27:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 2/8] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Message-ID: <20260112032711.GA694710@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-2-6d41a7a49789@oss.qualcomm.com>

On Mon, Jan 05, 2026 at 07:25:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> To allow the pwrctrl core to control the power on/off sequences of the
> pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
> populate them in the respective pwrctrl drivers.
> 
> The pwrctrl drivers still power on the resources on their own now. So there
> is no functional change.
> 
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 ++++++++++++++---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 22 ++++++++++----
>  drivers/pci/pwrctrl/slot.c               | 50 +++++++++++++++++++++++---------
>  include/linux/pci-pwrctrl.h              |  4 +++
>  4 files changed, 79 insertions(+), 24 deletions(-)

I had a hard time reading this because of the gratuitous differences
in names of pwrseq, tc9563, and slot structs, members, and pointers.
These are all corresponding private structs that could be named
similarly:

  struct pci_pwrctrl_pwrseq_data
  struct tc9563_pwrctrl_ctx
  struct pci_pwrctrl_slot_data

These are all corresponding members:

  struct pci_pwrctrl_pwrseq_data.ctx
  struct tc9563_pwrctrl_ctx.pwrctrl (last in struct instead of first)
  struct pci_pwrctrl_slot_data.ctx
  
And these are all corresponding pointers or parameters:

  struct pci_pwrctrl_pwrseq_data *data
  struct tc9563_pwrctrl_ctx *ctx
  struct pci_pwrctrl_slot_data *slot

There's no need for this confusion, so I reworked those names to make
them a *little* more consistent:

  structs:
    struct pci_pwrctrl_pwrseq
    struct pci_pwrctrl_tc9563
    struct pci_pwrctrl_slot

  member:
    struct pci_pwrctrl pwrctrl (for all)

  pointers/parameters:
    struct pci_pwrctrl_pwrseq *pwrseq
    struct pci_pwrctrl_tc9563 *tc9563
    struct pci_pwrctrl_slot *slot

The file names, function names, and driver names are still not very
consistent, but I didn't do anything with them:

  pci-pwrctrl-pwrseq.c  pci_pwrctrl_pwrseq_probe()  "pci-pwrctrl-pwrseq"
  pci-pwrctrl-tc9563.c  tc9563_pwrctrl_probe()      "pwrctrl-tc9563"
  slot.c                pci_pwrctrl_slot_probe()    ""pci-pwrctrl-slot"

> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -17,13 +17,38 @@ struct pci_pwrctrl_slot_data {
>  	struct pci_pwrctrl ctx;
>  	struct regulator_bulk_data *supplies;
>  	int num_supplies;
> +	struct clk *clk;
>  };
>  
> -static void devm_pci_pwrctrl_slot_power_off(void *data)
> +static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *ctx)
>  {
> -	struct pci_pwrctrl_slot_data *slot = data;
> +	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
> +	if (ret < 0) {
> +		dev_err(slot->ctx.dev, "Failed to enable slot regulators\n");
> +		return ret;
> +	}
> +
> +	return clk_prepare_enable(slot->clk);

It would be nice if we could add a preparatory patch to factor out
pci_pwrctrl_slot_power_on() before this one.  Then the slot.c patch
would look more like the pwrseq and tc9563 ones.

Bjorn

