Return-Path: <linux-pci+bounces-43932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DBCEE729
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA813004F3C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84D30EF6A;
	Fri,  2 Jan 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9Y6xjLF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347B30EF67;
	Fri,  2 Jan 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355269; cv=none; b=N4iwuDvntNmomHvZC7GVDYzfYpSu4yRVbxeDuvlWATbDinXnMiu9Dhy0LjB/ZlGxIbhxpTsfv2unpteP6gOUz5DW+G6ssRzMjAYTmWF6EDZMXYcS11oD7dEh/kwhM0H8x0eg/EjsXTB7YDjNGwTz7Ry/Hn+xKvseZGz3mH0FJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355269; c=relaxed/simple;
	bh=oKL2JRMVAzjGtblPX6Jm8euHCY5PAs+o+Jm/MbBHH1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeu8HxR9mZUVxm3pWVdt4TxAdeXRXVzPy3R9zV1Vx4bFFwj+VnxeilihO/FGd0ZHgaAAjvCQaeVnUtucJTNkZAXaTsTTU5GX/HknXueZAj72nsHEiPueZrQStaQVHPlB1bSumMVOUsj7Ha+QhZ+tQieR68uiK//FJkkRbSYsy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9Y6xjLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0981C116B1;
	Fri,  2 Jan 2026 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767355267;
	bh=oKL2JRMVAzjGtblPX6Jm8euHCY5PAs+o+Jm/MbBHH1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9Y6xjLFkV/Iv/PSHZ2PbjJxBfQG+kT4TDiZh9V8t7KDWpJUqySAKlRXQyYr3g5z6
	 fx8CJU3PXvkTnhFnY0SHmPjCwVgEduBGdQ1yRdXvuo/KKfLT9TzssK8u1Cyb2f3Tlz
	 xXjkZlcXUUOLuKQIPzHuDjXBLGBwuFzfIjJq+Ce0sxu/B57YQXXNrRFn6Sx0shivJS
	 7o6aS4nCg50JhnK6cYBKgo/rv5yoU0iXza5YHpCrKsclJMkHCBUqY3C9/Vlomf3xo6
	 F38888QEDMgjJuH10ecWmbwd8a5ZsP8+iFP+Bt+J1KY71nwh6N0mSQNrsAlRLwNsyj
	 b4/nB0FrH6N5g==
Date: Fri, 2 Jan 2026 13:01:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <aVezfq-8bTKczYkp@ryzen>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>

On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
>
> This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> detect the absence of the device on the bus and skip the failure.
>
> Compared to v2, I've reworked the patch 2 to improve the API further and
> dropped the patch 1 that got applied (hence changed the subject). I've also
> modified the error code based on the feedback in v2 to return -ENODEV if device
> is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> skip the failure if device is not detected and handle error for other failure.
>
> Testing
> =======
>
> Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> dw_pcie_wait_for_link() API prints:
>
>	qcom-pcie 1c08000.pcie: Device not found
>
> Instead of the previous log:
>
>	qcom-pcie 1c08000.pcie: Phy link never came up

Hello Mani,

I really like this series.

However when testing my usual setup with 2 Rock 5B:s, one in EP mode, one
in RC mode, where I usually power on both boards at the same time, but only
after both boards are booted, do I do the configfs write to enable the link
training on EP, and then do a rescan on the RC.

Even with this series, this workflow still works in 8 out of 10 boots.


However, in 2 out of 10 boots I instead got:
[    2.285827] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE
[    2.286584] rockchip-dw-pcie a40000000.pcie: probe with driver rockchip-dw-pcie failed with error -110

In both cases LTSSM was in POLL_COMPLIANCE.


Considering that things work in 8 out of 10 boots, means that the LTSSM state
was in Detect.Quiet or Detect.Active.

I did comment out goto err_stop_link if dw_pcie_wait_for_link(), so I can dump
LTSSM afterwards, when this happens.

[    2.293785] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE

Then I do:

# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
POLL_COMPLIANCE (0x03)

So LTSSM is still in Poll.Compliance.

However, as soon as I do the configfs writes on the EP board:


# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
L0 (0x11)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
L0 (0x11)

LTSSM transitions out of compliance, and rescan will find my device:

# echo 1 > /sys/bus/pci/devices/0000:00:00.0/rescan 
[  246.777867] pci 0000:01:00.0: [1d87:3588] type 00 class 0xff0000 PCIe Endpoint
[  246.778627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[  246.779151] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000fffff]
[  246.779672] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000fffff]
[  246.780192] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x000fffff]
[  246.780716] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
[  246.781236] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]



I understand that in most normal situations, the endpoint is powered on
before powering on the host side (or there is no EP connected at all).
But somehow, for us PCIe endpoint developers, it would be nice if we
could keep the behavior of being able to rescan the bus, even when the EP
is not powered on before the host side.

Perhaps a Kconfig or module param? Suggestions?


Kind regards,
Niklas

