Return-Path: <linux-pci+bounces-10169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FFB92ED04
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60086B20DA8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794EE16CD39;
	Thu, 11 Jul 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDAEbHv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37622381AD;
	Thu, 11 Jul 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716432; cv=none; b=jo3h5pS+SLdj05IQzQ4K2Oj/Hp8q2HncgHkWweENmSDH6zHf+SqTduvgmNPSsdqE7+I7bMRxo79O9Xztoz3sN/7VlvYqP2ttgiGhGYxp5+l7ZgzA0jcDYEcEXPyyO9arudbKS/zV8vFNXWaMjK15pWSIwJcvQXZDXIV1sib/bcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716432; c=relaxed/simple;
	bh=zjKGt7H07M4pHCU9lW4ij/982X9n70FZYJhQRgYo+h0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CwTA9g2xKZX9hvZmD/x5sFP+CimRiH0ljJXUg52t5raBDW3WYxIAHxVmiMYKj4SJkpP71io/YhjMr88980DZOEhfpUVNsZ8g+I7G3GpQaj9lwkNTN46eoF8yh8cBOjwdjHgrC/Y0F8+5j5Si337emO71ayd07qgSxHIHkEqsR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDAEbHv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83252C4AF07;
	Thu, 11 Jul 2024 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716431;
	bh=zjKGt7H07M4pHCU9lW4ij/982X9n70FZYJhQRgYo+h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uDAEbHv5tSBif6DWfuyRc6xa2Jjph3rGHMIE7faBVxp3oCT1EN0M8FD/RbJC0uvVm
	 K/AaQLW6f7vyAJTlPnH6z8TVSz7VymQHE/i1ayxIBMQBli3frcs+zHD1xwj+DT3/gQ
	 UCdZ0HAcir/EkpkMVQ81V/lblG/5KbfkUjzDwmWu6LsOGonfwiVA8Y+rztE9WtFSWC
	 XF7d2txz9ewDXWu8nrCcai+VaV3qUgMKxB0nh6IsGTntMH+9PuoZIPbfU27kkAxX++
	 v4H/5qWR7VnDpgndnOMWO5E5DypfDq4g7h5aQzd0Zg3/4CNZnrDsaGB3AnaPgO5DHh
	 j0vJ+bTv/Ru5A==
Date: Thu, 11 Jul 2024 11:47:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v6 5/5] bus: mhi: ep: wake up host if the MHI state is in
 M3
Message-ID: <20240711164709.GA286955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-wakeup_host-v6-5-ef00f31ea38d@quicinc.com>

On Wed, Jul 10, 2024 at 04:46:12PM +0530, Krishna chaitanya chundru wrote:
> If the MHI state is in M3 then most probably the host kept the
> device in D3 hot or D3 cold, due to that endpoint transactions will not
> reach the host, endpoint needs to wakes up the host to bring the host
> to D0 which eventually bring back the MHI state to M0.

s/needs to wakes up/needs to wake up/

s/D3 hot/D3hot/
s/D3 cold/D3cold/
to match other uses and make grep more effective.

> while queueing packets if the MHI state is in M3 wakeup host to bring
> back link to M0.

s/while/While/
s/MHI state is in M3/MHI is in M3/ (twice)

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b3eafcf2a2c5..b8713e5c1e1a 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -25,6 +25,26 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
>  static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
>  static int mhi_ep_destroy_device(struct device *dev, void *data);
>  
> +static int mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	enum mhi_state state;
> +	bool mhi_reset;
> +	u32 count = 0;
> +
> +	mhi_cntrl->wakeup_host(mhi_cntrl);
> +
> +	/* Wait for Host to set the M0 state */
> +	while (count++ < M0_WAIT_COUNT) {
> +		msleep(M0_WAIT_DELAY_MS);

Tangent: the "M0_WAIT_DELAY_MS" name suggests that is the maximum
delay, but it seems the actual maximum delay is
M0_WAIT_DELAY_MS * M0_WAIT_COUNT.

Tangent 2: unless there's a reason to be different, it would be nice
to use the same loop structure as the similar delay in mhi_ep_enable().

> +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
> +		if (state == MHI_STATE_M0)
> +			return 0;
> +	}
> +
> +	return -ENODEV;
> +}

