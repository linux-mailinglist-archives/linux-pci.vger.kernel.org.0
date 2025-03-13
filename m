Return-Path: <linux-pci+bounces-23677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB362A5FDBE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 18:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE28C7A9FE7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00349165F1A;
	Thu, 13 Mar 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ2DxQ6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE45158868;
	Thu, 13 Mar 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886910; cv=none; b=b0NpawxaFzeeIa/f4Bq11NEGTP5lB04LmPS8hwV7yz8g0qBi9tC0moc/p5Kxdnhk8Cq1vVsrB7cJM3aFDCGiuHb8llGK7rv51+4vr/BGALQPOtFPVBBjz9ad3pKPEa9ED4jm6C05ts3ZNokQP5VzJQ4/kUK7JR0hDoMFx1hcTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886910; c=relaxed/simple;
	bh=ysZJy/pStSvMTNKpMrLF6jzCLOYDpj1uIdVrASzzEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f3d7SyDKBtFlqB6a+fvCPFbMtkxPxbZhlBIoroAxyAhToYf4/FMIaoijH90AMVSvW+oWtIJIa3u0ezu1oqStTNARE3Zvznsfc190v3/4oryb4dq6+K2P62adLsxiQfX6aUBS3jLdxeINub1KgUYEZXGE9Rnn0ldBrKgALsaRMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ2DxQ6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20167C4CEDD;
	Thu, 13 Mar 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886910;
	bh=ysZJy/pStSvMTNKpMrLF6jzCLOYDpj1uIdVrASzzEoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dQ2DxQ6sIpOoITZl4zyHIxnBnbZyOGDZNCdr6pjx83cxo7HKyABB0MY5WSzJPQMiy
	 3ol/5oSMjL14PA0/ckuboggAjr77NDLlyW/cF4PCSVOSERWtWivHsQYmquJI5Reogs
	 HM7bSJ5Xii3T05scdfAqplAxvpe8MfMcdZoOUm1paIPCyvWEzJO3msis1SJCp4K1cu
	 ccxcBkbSQ0hqb0svtmMvC8pQ8gomopQTsJ6IY3MkcJ50NnDR9gbOoogZ29hSAaGpyo
	 C7Z1Z+K13kh2VAUFqfC76Fp9gcjIaawMMPBmhHRhM7iyhlimU3im7nE91MoZikvLpk
	 ZsUdRxHkoL0iA==
Date: Thu, 13 Mar 2025 12:28:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: Re: [PATCH v2 10/10] wifi: ath11k: add support for MHI bandwidth
 scaling
Message-ID: <20250313172828.GA740705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:17PM +0530, Krishna Chaitanya Chundru wrote:
> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Add support for MHI bandwidth scaling, which will reduce power consumption
> if WLAN operates with lower bandwidth. This feature is only enabled for
> QCA6390.

What is the event that initiates bandwidth scaling or reduces power
consumption?  Is there any kind of user interface like a sysfs knob
an administrator can use?

Does this happen based on ath11k usage?  Battery or thermal status?  

I guess reducing power consumption or reducing heat is probably the
driving factor since we would always use max performance if power and
heat were not issues?

Some hints here would be useful.

> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index 6e45f464a429..74769c0993ae 100644
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
> +
> +	pdev = pci_upstream_bridge(pci_dev);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	return pcie_set_target_speed(pdev, speed, true);

Seems kind of unfortunate that:

  1) The endpoint driver needs to be involved here, even though it
  does nothing that is endpoint-specific, and

  2) The endpoint driver twiddles something in *another* device (the
  upstream bridge).  There's a potential locking issue here and
  potential conflict with any other devices that may be below that
  bridge.

> +}
> +
>  static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
>  {
>  	struct device_node *np;
> @@ -389,6 +428,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>  	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
>  	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
>  	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
> +	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
> +	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
>  
>  	switch (ab->hw_rev) {
>  	case ATH11K_HW_QCN9074_HW10:
> 
> -- 
> 2.34.1
> 

