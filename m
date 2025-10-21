Return-Path: <linux-pci+bounces-38840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DDBF45A5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647944081F3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76127781E;
	Tue, 21 Oct 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8/9UGAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B62773D8;
	Tue, 21 Oct 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012426; cv=none; b=VMYAiXiRXzealMOri5oxnwprVrMXRTHuLSL5nckjhW59BNg8g4Lm8FGYlxCQyOlznVSSL/JF87q9FAqCzs08SoIg8/ZXVopg3JD8sjuGqFl3b4ldPrtyVCcxscCBhm50RRFoBcS/6LSMuTiDHQFwqEsl4Ebk7vHmpjKmJcUwVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012426; c=relaxed/simple;
	bh=lea45PnhCbZ2sLHs3xr7ltskoeSEMmGeuwyEfGGX1Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMZjDQLzmcutDlkPZ44YNS6yn7TSNz9jzHL95FMS4aMv3wwcJKEBrDYL6w43K+9Ds+M2Z4Kc1YZebfIjJ1cs86oXWGMytAaucvGOdO0xeubd5LUNoLb3wugQefNWXvEmTbBVFlUtmc31FK+aH4Z1Ah5MjbNa0aXFCuVPMKoX2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8/9UGAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57556C4CEFB;
	Tue, 21 Oct 2025 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761012426;
	bh=lea45PnhCbZ2sLHs3xr7ltskoeSEMmGeuwyEfGGX1Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8/9UGAmepYo0j9vJ4bIkQchuenciclVLqqFLNwcxiSeAsEdrcZ/puGGlF1EieTyh
	 MqVVDlTmIw4CZbu6TSZfeSRy7hhE6Kr7/oMmbELETlm2HZfzPlHAbGH4R9AZETTyDu
	 77FaoE1BBY8O7lULyKNmDydHVPSg1N1Ch6bI1mMRklSilmeQ3g1IURNjZru2bJfsFx
	 SqwxMWxlHB5i/MJqmNpNjIjj5YHTCNjuaRwFqZSqfTcezJ4m56xMF1TonyNHpcUWwZ
	 /C9UaEMCIHl4yna0JpGX5pZAeL/4FC0L6vaxmRunMGx96+HzffBho6PPghAAQ5hrt2
	 r2J41Ks44Rhhw==
Date: Tue, 21 Oct 2025 07:36:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vitor Soares <vitor.soares@toradex.com>, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: j721e: Add support for optional regulator
 supplies
Message-ID: <p3l2p2raecqqkpdjswiddkthpxzvhm3rl4cw56y2epgcxfiwbb@gsieef3yqvpk>
References: <20251014112553.398845-1-ivitro@gmail.com>
 <20251014112553.398845-3-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014112553.398845-3-ivitro@gmail.com>

On Tue, Oct 14, 2025 at 12:25:49PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Some boards require external regulators to power PCIe endpoints.
> Add support for optional 1.5V, 3.3V, and 12V supplies, which may be
> defined in the device tree as vpcie1v5-supply, vpcie3v3-supply, and
> vpcie12v-supply.
> 
> Use devm_regulator_get_enable_optional() to obtain and enable each
> supply, so it will be automatically disabled when the driver is
> removed.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 5bc5ab20aa6d..f29ce2aef04e 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "../../pci.h"
>  #include "pcie-cadence.h"
> @@ -467,6 +468,10 @@ static const struct of_device_id of_j721e_pcie_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_j721e_pcie_match);
>  
> +static const char * const j721e_pcie_supplies[] = {
> +	"vpcie12v", "vpcie3v3", "vpcie1v5"
> +};

Please don't hardcode the supplies in driver. The DT binding should make sure
the relevant supplies are passed (including the optional ones). Just use
of_regulator_bulk_get_all() to acquire all the passed supplies.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

