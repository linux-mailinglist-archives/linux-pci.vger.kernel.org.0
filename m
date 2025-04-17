Return-Path: <linux-pci+bounces-26060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3ADA914AE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F350440154
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5129205E2F;
	Thu, 17 Apr 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIwTodbB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0A64A98;
	Thu, 17 Apr 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873495; cv=none; b=UDqp1KasU/mYWTf6AhbxLlYW1lq8D4qaRCs8xHWS72lecBPHgIEFDAOu9RhNDcugdFFy7H0tVtyK3wbs2knR92I17CzXR9EV30l1rfE0yiyuKmuMf2ZZVCBb0Ht/7kEdo4SjLB2s4DjyFBKSu/r7Jfj+YiDzQiFwGuSjnu3/XPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873495; c=relaxed/simple;
	bh=A1UXWE3ilQY9BEMls0KvjFVXoarU66FDUevVVhE2dx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhsT9C5NEAP/lSVp5xqAEwgnt4mvjU/KCYZBTSm5FIWb+1PZchjoX6OKLSjVps6IzJtXKnSscrdZ1yjEnlrzru7txByy91tZJmG77WomDlQYmNZpVYBBOZjmKl9wG+oiXKcGWzbNuKRGUP25P+xmYJ9QTBrtqbS1mlY1H2WWYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIwTodbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE57C4CEE4;
	Thu, 17 Apr 2025 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744873495;
	bh=A1UXWE3ilQY9BEMls0KvjFVXoarU66FDUevVVhE2dx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIwTodbBMR171TZ4AX8MxpAiVF4LBuFV++eunfuyLDo2jIZl1zpE5f4KhmHssGfLC
	 OQcWFRyNDLhjyrvxLCrUbTGEW1ae4TIKGUIkdZHEH1NoTrjwGrtue3XXw2feCYrEPI
	 LfulYwe5IAACEvI2AMz6m1mwVHEACaQgKRbvPWUVI6nuluOU3JuRSKEftCtGpNqQcp
	 nnPIZslkezsAeBIYHpTjhNklZpwxRwuaHjQkftxs+VKglhBHChG7m8SfxxYRO3aOK8
	 2KzqtRqP1C9aIPeKXiT08gJunojmUrEiCg1S9pg8zGTa7YBou++qIYu1YbmAt1xDo/
	 +HcDrKaJ0Ga1w==
Date: Thu, 17 Apr 2025 09:04:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <aACoEpueUHBLjgbb@ryzen>
References: <20250416151926.140202-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416151926.140202-1-18255117159@163.com>

Hello Hans,

On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
> The RK3588's PCIe controller defaults to a 128-byte max payload size,
> but its hardware capability actually supports 256 bytes. This results
> in suboptimal performance with devices that support larger payloads.

Patch looks good to me, but please always reference the TRM when you can.

Before this patch:
		DevCap: MaxPayload 256 bytes
		DevCtl: MaxPayload 128 bytes


As per rk3588 TRM, section "11.4.3.8 DSP_PCIE_CAP Detail Registers Description"

DevCap is per the register description of DSP_PCIE_CAP_DEVICE_CAPABILITIES_REG,
field PCIE_CAP_MAX_PAYLOAD_SIZE.
Which claims that the value after reset is 0x1 (256B).

DevCtl is per the register description of
DSP_PCIE_CAP_DEVICE_CONTROL_DEVICE_STATUS, field PCIE_CAP_MAX_PAYLOAD_SIZE_CS.
Which claims that the reset value is 0x0 (128B).

Both of these match the values above.

As per the description of PCIE_CAP_MAX_PAYLOAD_SIZE_CS:
"Permissible values that
can be programmed are indicated by the Max_Payload_Size
Supported field (PCIE_CAP_MAX_PAYLOAD_SIZE) in the Device
Capabilities (DEVICE_CAPABILITIES_REG) register (for more
details, see section 7.5.3.3 of PCI Express Base Specification)."

So your patch looks good.

I guess I'm mostly surprised that the e.g. pci_configure_mps() does not
already set DevCtl to the max(DevCap.MPS of the host, DevCap.MPS of the
endpoint).

Apparently pci_configure_mps() only decreases MPS from the reset values?
It never increases it?


Kind regards,
Niklas

