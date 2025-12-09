Return-Path: <linux-pci+bounces-42818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6440CAEF42
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 06:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B7330443FD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A22C237F;
	Tue,  9 Dec 2025 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMXVtuAF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E555285C9D;
	Tue,  9 Dec 2025 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258608; cv=none; b=V75S52qm2UpM4lPbR8c4lCehsSFTDEAnsJ8zelNjat6vMq3HMBVhgPk6AkVmHP5JJiR4RDvcXlAknKZ3IBJuObqNflhSyHJWk3isivfRXAKhf5Is8HaKkQxP/8jsw+x3FRZFDoijiabFd97mHPIVZuox6pnrzs0BTpTK3xIx3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258608; c=relaxed/simple;
	bh=2RDv4DcIrTBucTjjuk5VLFq9dvjMqEKn4KbLFw9RQ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksY02WMm7qTqx3+A02SrCTNs7b3CMIBcY4/75ChbQQCOKDeB8TvKdclx9Tyrwa/KJOFoBaXLBQHHm7c15KG9VZgjcKVXbcrmh9Hfon2K/l6PzPIFUOCC44NifWt5LpRnVk25hKhUPY/zt0H9kVwESM5YVJ/aX1K6AW0UDy2Rlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMXVtuAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C90C4CEF5;
	Tue,  9 Dec 2025 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765258608;
	bh=2RDv4DcIrTBucTjjuk5VLFq9dvjMqEKn4KbLFw9RQ3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMXVtuAFLOJ+SsbKDzzcbohGJRut2sSqU8ai3zrpchO1F1eqwyfiGhM4gT3woR3pF
	 pY/JWYmW2Lp3nwtWVfRRWEHwmWdgigBYR5Qf2JlboV0XoYYGhhND6Jh5VcVmxd9l64
	 GwT/zblmSesZFEuW/hJnJp5lcq4bPlCkrxYnfESxh79OKibdZAC5vhtkH2bvu58Ld9
	 /SCiT6/MIV82mKEecnhrFdjGymKKcqyebul7ZTgauQivImDCLEH+SltzFhEctzUaLy
	 21/TzgPVsX9H6i9+vq8AQ3PrcV7jskjZ+nsVRprhD/mYCoQKZ/YEVKfj0BNdVmMwFB
	 CejkKw80MROSg==
Date: Tue, 9 Dec 2025 14:36:44 +0900
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aTe1bA7lcVzFD5L7@dhcp-10-89-81-223>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
 <aTev28wihes6iJqs@dhcp-10-89-81-223>
 <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>

On Tue, Dec 09, 2025 at 10:57:18AM +0530, Krishna Chaitanya Chundru wrote:
> On 12/9/2025 10:42 AM, Niklas Cassel wrote:
> > 
> > So I don't really understand your concern with this series, at least not if
> > it goes on top of your series:
> > https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com/
> Hi Niklas,
> 
> If this series goes on top of the our series i.e pwrctrl rework series, I
> don't have any concerns.
> My only concern is link up IRQ never fires if this patch goes before series.
> 
> - Krishna Chaitanya.

This patch missed the v6.19 merge window (and so did the pwrctrl rework
series), so as long as Mani queues up both for v6.20 (with the pwrctrl
rework series getting applied first), I think we are good.


Kind regards,
Niklas

