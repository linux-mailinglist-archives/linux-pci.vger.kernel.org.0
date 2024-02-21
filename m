Return-Path: <linux-pci+bounces-3838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2185E6B2
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B24EB233CA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54D85C46;
	Wed, 21 Feb 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIVVntlq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254885642;
	Wed, 21 Feb 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541611; cv=none; b=qndjWyh53WsQ9FNZ4vEDds+uSf7B49f5EHw6DbUrUBnex585H2EW1nk1NYpMESwBQN118/3Ypz1gdj8gg7DgD9R2oT80m+Ik9Wqd3FoS+r6OMt2OhpFJJcMcXfUnzApcxXPfupbmGcfZ2yUtHx5BskVt09RCFPanDcLZwwyK+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541611; c=relaxed/simple;
	bh=jfvnL/ZYlAe+/y5bpm0I1DGqSMo+KfI5bflCLpUrPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcdO0gP+yK9TeKbW7C9VWn0ebHDTDIheG+XCLDdALl/fSJAhBO5EQue4T2q9plHLnK7+3gP0OUrt2wADP40UR6bH/lQrO6ixYf9Z9XX5CYSKLRp62Tw/MsMLlAA0qORC3GbwPRK5BmWFdtp5yggEcovvjST3Vin6k2OJy1o/smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIVVntlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEFFC433F1;
	Wed, 21 Feb 2024 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541610;
	bh=jfvnL/ZYlAe+/y5bpm0I1DGqSMo+KfI5bflCLpUrPgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIVVntlqc/MTKynjKmZnhGk5EOtyKFXhbXh2cIBE9a2FUCkwOawlCTn8s6SvdAgeq
	 9LEqVTOhVmCaHuoJ+YwwX3ofnq3xVhHHSPeM4+rPVwsGdHFX1jPgBQjo9gOY2103NN
	 OBAJxduIs4nsRgKHG3hBRx7HUZ96mNvUaebw1lY7L1HQDXXmFpH/UEAqh5NHwwUF39
	 FNu7L/ri02VnF8iuxqZtxH/8cA+5pAEY+CYniGQ6zY3bsbmUJkW+cu7YDOFzK298Wm
	 Pkq1BgZeZwX/mn3LEsI0HIc32UXGFhtLHp7kq+j2wLh3Wy6G3+XgtfKJuIVnbccJX0
	 64hCSmmTVMqAg==
Date: Wed, 21 Feb 2024 13:53:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 23/28] PCI: dwc: Clean up
 dw_pcie_ep_raise_msi_irq() alignment
Message-ID: <ZdZGqeX8VQT66rmG@sashalap>
References: <20240213002235.671934-1-sashal@kernel.org>
 <20240213002235.671934-23-sashal@kernel.org>
 <ZdJF4fpSn/0goBqb@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdJF4fpSn/0goBqb@duo.ucw.cz>

On Sun, Feb 18, 2024 at 07:01:05PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>>
>> [ Upstream commit 67057f48df79a3d73683385f521215146861684b ]
>>
>> I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().  The
>> code in dw_pcie_ep_raise_msi_irq() is similar, so update it to match, just
>> for consistency.  (No effect on runtime, just a cleanup).
>
>Just a cleanup, we don't need it in stable.

Dropped, thanks!

-- 
Thanks,
Sasha

