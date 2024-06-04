Return-Path: <linux-pci+bounces-8271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B068FBFC6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 01:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB2283550
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688B14D446;
	Tue,  4 Jun 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLiPBDnK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EE1442F5;
	Tue,  4 Jun 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543430; cv=none; b=Z2sIp53nvEbgZkn4Ps1WbSFU+5ACKyKNfYCvWPMvKiRVt0+p+8zOp1ekWaGwJMGju0gEscF0LqE8EvQNLvZHGMpOTCGd3M0eYP8f6KmDow5PYUjJPWu77UP8jX4lqcLDT8oaT61LrcTl8GJWXkv45KHDmHa0bXhAPuB9tjyJtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543430; c=relaxed/simple;
	bh=TcM91AOH5mARdOX+sC1EAXIn04cXXNDDk3iF8SmOPds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZC+4MBiOncvQHflM4Suy6R2rD2UKjB7NFhppXg/sAWDhIdMzaHxo8jDGD3vEEv0iJTpUxCt0OaTgm+J6PGU4GjSg4BAsEDvQDPCvpgndpfSEEPfox9vvrKezYPei6Wjgk4rVMOANiWsbTYASRIc6zeHIuVuCYPeFuyHdY49lEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLiPBDnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E83C3277B;
	Tue,  4 Jun 2024 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717543429;
	bh=TcM91AOH5mARdOX+sC1EAXIn04cXXNDDk3iF8SmOPds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HLiPBDnKEroIafHmkKhjL6ZMtwQGyKIKNbO+TcKl/05kSJIwg0yO1zoMMQbmOFtv3
	 BPwiExtk5Je89Q0RCvCcP3KlX4Gh/9Y/96+4Th9xJSJREAr9tGTnYtD0hKHOUVm8i0
	 rjrBa1hjbTsB2cAxnsTkD0mIW0nAt1HupIBiC4A3ABFImA1myBc45JQ3fI68abpMiw
	 FrSRmzcAkYkvGQ9Cux3ZCT6BXB2Q07caU5VI5TY6DxiGtNCxTfI+3q8uT3jeG6ugDG
	 bMO4Zbad0NPDHHGrNKyQfl8QS8RH9L5uVpcBiiwcQRkGeBpZCcqKAFD5AbiCUxhYJc
	 Hrn3BtBW16vpg==
Date: Tue, 4 Jun 2024 18:23:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
Message-ID: <20240604232347.GA740032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-16-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power control driver that's capable of correctly powering up
> devices using the power sequencing subsystem. The first users of this
> driver are the ath11k module on QCA6390 and ath12k on WCN7850.

Can you add a little detail here about what benefit we will see from
this driver?  E.g., something that doesn't work correctly now, but
will work with this driver?

> +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> +	{
> +		/* ATH11K in QCA6390 package. */
> +		.compatible = "pci17cb,1101",
> +		.data = "wlan",
> +	},
> +	{
> +		/* ATH12K in WCN7850 package. */
> +		.compatible = "pci17cb,1107",
> +		.data = "wlan",
> +	},

IIUC, "pci17cb,1101" and "pci17cb,1107" exist partly so we can check
that a DTS conforms to the schema, e.g., a "pci17cb,1101" node
contains all the required regulators.  For that use, we obviously need
a very specific "compatible" string.

Is there any opportunity to add a more generic "compatible" string in
addition to those so this list doesn't have to be updated for every
PMU?  The .data here is "wlan" in both cases, and for this purpose, we
don't care whether it's "pci17cb,1101" or "pci17cb,1107".

