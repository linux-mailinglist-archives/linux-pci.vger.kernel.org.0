Return-Path: <linux-pci+bounces-32835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D7B0F809
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C037BAC32E9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9CA157E99;
	Wed, 23 Jul 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8H4yG2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E92E36F0;
	Wed, 23 Jul 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287943; cv=none; b=Myz5xvF0sxexxb8axWfFtHp8Rr9upz/28iKJJy38xuCZryxQnycA6FIFux+tuRfhDWiQViCEW0q11Msf8kdZ/v9gZHyO5E1tRTf5N53AdJqYm3k9tanrcoEh8n/TUP+pOvqQsyem/nXQ4Q0bVWSkcE9RlUlIl8wD+zmcm2FFFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287943; c=relaxed/simple;
	bh=nLC91lUvP3zaJg6UlqQrBSAOMHuwcblVye+egF7o2Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpjOaDEpkqh4jAWPWXzEbNgJxXluHWDAHXMOWKIdo0s3oTsczaHV7OLkTDUfmp9SgjSOrIv94pVwNpPoY5QkKLUlrRD1hLeHMZM6Z/RmwbU/B0f+rqBNFeZ4luFeUO6FEm2rEs0OHKa5Qbzd6a8wH+urbpawOYRYNfNnlIFyDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8H4yG2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E0C4CEE7;
	Wed, 23 Jul 2025 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287942;
	bh=nLC91lUvP3zaJg6UlqQrBSAOMHuwcblVye+egF7o2Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8H4yG2sLM3EtMIyyp3VER+MZNetfiBhRLouHhWKhwRpYBCBdtJfBQFI+9fmQ1for
	 8B/wEdAoNqSUu4VOesl07v6HNCu9olofUWlx2A60mZ4MN7T7gyajRq/Uup2WndNjuC
	 QiLjGI9EjELN+U/L030mP1AVQip63ygQ/teTrGgUprT9PwdmwWeqF0KCfuFpEY7SrF
	 nF9t4CDiztR5/YLRw29ipCNmcuWXkuhx00rl0yPHncOgoNmLVOlpxtwSJ7xazqd+rx
	 kFBfz1V69Pwb9Ie/DvVGG/DLUwYV6/jN14DRnmo5aWGyi6xNYJPfLzAfaIdj0woL3O
	 ICHkDV7g6cfwQ==
Date: Wed, 23 Jul 2025 21:55:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v4 04/11] bus: mhi: host: Add support for Bandwidth scale
Message-ID: <76txeoaa7k3nquvegvmivjazlzdtsnsxa3jtfrlfzbndffc7dx@c2nfzty73scj>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>
 <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
 <31c192f7-cd69-46ad-9443-5d57ae2aa86e@oss.qualcomm.com>
 <eg2v3kctnztxcaulffu7tvysljimmyhnramyjj5gpa4vrv3yxu@g3pgwpwx37iq>
 <2c42bbe7-79aa-42f6-8af8-65d1be7253a5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c42bbe7-79aa-42f6-8af8-65d1be7253a5@oss.qualcomm.com>

On Fri, Jul 11, 2025 at 12:25:30PM GMT, Krishna Chaitanya Chundru wrote:

[...]

> > > > > +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
> > > > > +			     int bw_scale_db)
> > > > > +{
> > > > > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > > > > +	u32 bw_cfg_offset, val;
> > > > > +	int ret, er_index;
> > > > > +
> > > > > +	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
> > > > > +	if (er_index < 0)
> > > > > +		return er_index;
> > > > > +
> > > > > +	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
> > > > > +
> > > > > +	/* Advertise host support */
> > > > > +	val = (__force u32)cpu_to_le32(FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
> > > > > +				       FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
> > > > > +				       MHI_BW_SCALE_ENABLED);
> > > > > +
> > > > 
> > > > It is wrong to store the value of cpu_to_le32() in a non-le32 variable.
> > > > mhi_write_reg() accepts the 'val' in native endian. writel used in the
> > > > controller drivers should take care of converting to LE before writing to the
> > > > device.
> > > > 
> > > ok then I will revert to u32.
> > > 
> > > I think we need a patch in the controller drivers seperately to handle
> > > this.
> > 
> > Why?
> > 
> what I understood from your previous comment is from here we need to
> send u32 only and the controller drivers should take care of
> converting u32 to le32.
> As of today controller drivers are not considering this and writing
> u32 only.
> So we need a seperate patch in the controller driver to convert it to
> le32.

No. All controller drivers are using writel() to write the register. Since
writel() converts the value to little endian from native endian, you do not need
to do anything.

> > > > > +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
> > > > > +
> > > > > +	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
> > > > > +		er_index);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +

[...]

> > > > > +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
> > > > > +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
> > > > > +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
> > > > > +
> > > > > +	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
> > > > > +		link_info.sequence_num,
> > > > > +		link_info.target_link_speed,
> > > > > +		link_info.target_link_width);
> > > > > +
> > > > > +	/* Bring host and device out of suspended states */
> > > > > +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> > > > 
> > > > Looks like mhi_device_get_sync() is going runtime_get()/runtime_put() inside
> > > > mhi_trigger_resume(). I'm wondering why that is necessary.
> > > > 
> > > Before mhi_trigger_resume we are doing wake_get, which will make sure
> > > device will not transition to the low power modes while servicing this
> > > event. And also make sure mhi state is in M0 only.
> > > 
> > > As we are in workqueue this can be scheduled at some later time and by
> > > that time mhi can go to m1 or m2 state.
> > > 
> > 
> > My comment was more about the behavior of mhi_trigger_resume(). Why does it call
> > get() and put()? Sorry if I was not clear.
> > Get() needed for bringing out of suspend, put() is for balancing the
> get() I belive the intention here is to trigger resume only and balance
> pm framework.
> 
> That said mhi_device_get_sync() has a bug we are doing wake_get() before
> triggering resume and also trigger resume will not guarantee that device
> had resumed, it is not safe to do wake_get untill device is out of
> suspend, we might need to introduce runtime_get_sync() function and new
> API for this purpose.
> mhi_trigger_resume makes sense in the place like this[1], where ever
> there are register writes after trigger resume it may need  to be
> replaced with runtime_get_sync().
> 
> This function needs to do mhi_cntrl->runtime_get_sync(mhi_cntrl); first
> to make sure controller is not in suspend and then mhi_device_get_sync()
> to make sure device is staying in M0. and in the end we balance these
> with mhi_cntrl->runtime_put(mhi_cntrl) & mhi_device_put().
> 

Sounds good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

