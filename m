Return-Path: <linux-pci+bounces-31703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B1AFD53C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78724560AF5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F52E6D14;
	Tue,  8 Jul 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv+unAi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6C2E6D0B;
	Tue,  8 Jul 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995426; cv=none; b=uj50bfihMy8rOvuF6aSunrtxNwmfmEM7zORRBew3K0Weok4FkeE//8EUe1tZpI7w9jdN3zrDGTak+j9lItabEjuteiwKV4Xw4p2qxdEG78pogQ/B/M6OBe0SI4XEhUnRHLLbm/vdicDGMRszHR18Pg1r+nxyKe19wLeJ1ALGwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995426; c=relaxed/simple;
	bh=IL2Ec5vcZd1gBfh4nN8IvjVJbCH2TCDHEEJdjkJNnvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwOJQDB9LyAV5Sk7OdyvwD976ytet77kBevGlaMW/lOQqlKw5aRm6mUk6bIYMvIXwkz3yuHtUWARho8N5C9PoJNxaYd+SFeOYurhNZTHDjGB8Kn08eho9jr2vT59SAiAEHEDUa7eB+3z3Tzu76JCKjpRban0h2sqK3i9HO0Nw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv+unAi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A93C4CEF5;
	Tue,  8 Jul 2025 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995425;
	bh=IL2Ec5vcZd1gBfh4nN8IvjVJbCH2TCDHEEJdjkJNnvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv+unAi3RatHtwdAZ+PtpIEWyLlOsvs0JJiNmgaxCpCMwLn8AtGddyj2nbcLaSU/N
	 7TUssVOmnspDrZEVOIWnnLmhGBrqqeoA6suti0yLBMfNjRUp2BP20w+rIql4mjRfJA
	 6BAXLJTUUGWzX12Sl5dTV46fSCzw7ZYuChb+43xpaelMBEyGhxfn73spu9Nr4rfmfm
	 BsOJFBUx3zoJPikR8L73iCfQ8owzy70lCWgR4DHmz5Yui4oW7GPmirDZ89hvymRNoR
	 fTePvQ3dlE3TZske4RBXO41ev/QS0ARQZz3Hpra5j59vAEND4aSMAp2aiKh0KE6qsr
	 OoMCnIzU+vsrg==
Date: Tue, 8 Jul 2025 22:53:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: Re: [PATCH v4 11/11] wifi: ath11k: Add support for MHI bandwidth
 scaling
Message-ID: <7kgg4txp6fqfom7akzcodcvkfyjm6tlkgr6lhnnkluohydoiop@ywax65nn6emn>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-11-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-11-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:32PM GMT, Krishna Chaitanya Chundru wrote:
> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Add support for MHI bandwidth scaling, which will reduce power consumption
> if WLAN operates with lower bandwidth. This feature is only enabled for
> QCA6390.
> 
> Bandwidth scaling is initiated by the endpoint firmware based upon the
> bandwidth requirements, if there is high bandwidth data endpoint requests
> for higher data rates or if there is less bandwidth they request for lower
> data rates to reduce power. Endpoint initiates this through MHI protocol.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index acd76e9392d31192aca6776319ef0829a1c69628..f79507c7a82244f9e9d8a3ae6765df3f9432ae8c 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -20,6 +20,7 @@
>  #define MHI_TIMEOUT_DEFAULT_MS	20000
>  #define RDDM_DUMP_SIZE	0x420000
>  #define MHI_CB_INVALID	0xff
> +#define MHI_BW_SCALE_CHAN_DB 126
>  
>  static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
>  	{
> @@ -73,6 +74,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
>  		.client_managed = false,
>  		.offload_channel = false,
>  	},
> +	{
> +		.num_elements = 8,
> +		.irq_moderation_ms = 0,
> +		.irq = 1,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.data_type = MHI_ER_BW_SCALE,
> +		.priority = 2,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
>  };
>  
>  static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
> @@ -313,6 +325,33 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
>  	writel(val, addr);
>  }
>  
> +static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
> +					   enum mhi_er_data_type type)
> +{
> +	if (type == MHI_ER_BW_SCALE)
> +		return MHI_BW_SCALE_CHAN_DB;
> +
> +	return -EINVAL;

-EOPNOTSUPP?

> +}
> +
> +static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
> +				  struct mhi_link_info *link_info)
> +{
> +	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
> +	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
> +	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
> +	struct pci_dev *pdev;
> +
> +	if (!pci_dev)
> +		return -EINVAL;

Is it really possible?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

