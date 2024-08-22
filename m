Return-Path: <linux-pci+bounces-12035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6095BEA1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6365C1F23CC7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7D13CFBB;
	Thu, 22 Aug 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6IqqNur"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9876025;
	Thu, 22 Aug 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353488; cv=none; b=hfBPBlhDHB6M8g/wlzMfgz1kZy/WE+bZXYP5WXU3Dquauhxx2gRWj7M9EIaa1RRtT36hRYKuG9OzxTeFOF5ZxNY8r67yRPtVKN1ADONKs2rA5Wxr73I+gF1/NkSSQnjcSZf8nFGHWke6PN92jrpK8CeAL1SJf+3H7Qzulx8C4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353488; c=relaxed/simple;
	bh=IbxwA+3I7SLwh3Q6g1rKOQL7JcclONBKMXll4Tm+UTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rCRGpkHxLvk1WCKDSAYk87gz8tdwXndd51dOMSa+4pK1Ihtl4g48LbYxloDvtiftGN8IvLeTqQX13L4rdZ6tSzepf5m9PPNius962Ab6garRo5SN/zIA8EELR8R1qEqgmrBftfE+PAtAeHmZuF9KjAFOwgW6QMwbceFwtPao1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6IqqNur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A874CC32782;
	Thu, 22 Aug 2024 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724353487;
	bh=IbxwA+3I7SLwh3Q6g1rKOQL7JcclONBKMXll4Tm+UTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b6IqqNurVHH9Zcsyrbg+RP3F1l5N8Cbj/oYQBBDZWwIc6Z1NIq4w4JQtRjG9rUguJ
	 4hEUfDSDJac7B69y3L3NuKn3uDA83n2SWadvQ6D6jJC24X7eFEUTDIl/1klEvbIkQK
	 RHNzB7gaB3A9HTAYlMzpfm0aGhZgPtOFchMl7siQEZmVqUJr0Q9GsHULWUfKpWI9z+
	 5cwT40gn5WrE8wUQNxjNDAGYfbycx1ZIGlYJ7Z67qg6l2Wtdv1w7TdOmv2q9L3HIRM
	 Fec1/yerDOL5MwzVKMumeKOL+6QyCzYdbpcUJ2oLpGZa/Ee0ZiXsF1krRCThRK9nNg
	 fLsW8SWCQQ5FA==
Date: Thu, 22 Aug 2024 14:04:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: add support for WCN6855
Message-ID: <20240822190446.GA345619@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813191201.155123-1-brgl@bgdev.pl>

On Tue, Aug 13, 2024 at 09:12:00PM +0200, Bartosz Golaszewski wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add support for ATH11K inside the WCN6855 package to the power
> sequencing PCI power control driver.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> [Bartosz: split Konrad's bigger patch, write the commit message]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to pci/pwrctl for v6.12, thanks!

> ---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index f07758c9edad..a23a4312574b 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -66,6 +66,11 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
>  		.compatible = "pci17cb,1101",
>  		.data = "wlan",
>  	},
> +	{
> +		/* ATH11K in WCN6855 package. */
> +		.compatible = "pci17cb,1103",
> +		.data = "wlan",
> +	},
>  	{
>  		/* ATH12K in WCN7850 package. */
>  		.compatible = "pci17cb,1107",
> -- 
> 2.43.0
> 

