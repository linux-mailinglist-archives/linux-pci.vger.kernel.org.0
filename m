Return-Path: <linux-pci+bounces-26063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC6A914F5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D30A189EABD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807E2192FA;
	Thu, 17 Apr 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpvjqSLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C5218EBA;
	Thu, 17 Apr 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874538; cv=none; b=iwOltyeZJmZ2VDga3tTLu5zGPEUjlT7PAkOlrvGXoqt9opbVUwZj14/ZovcwF0klhkgZ1S/+fnxNgGnGoM64K4X6LCsHhH454YkFu19ma9n41Ugv4auhNhrfLxOhotb4YWDB9L7Wc8bBsVcb1r9pgOBwaoxI8PzdvCHii5/5OBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874538; c=relaxed/simple;
	bh=njd0Ctie5/NJ/u0nIFo0b6CFaL7VXTbcT9S6B/AcLZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyqT65NwdppDitsStT37MoST3ULHZz7+v8TNWEfQDU3Wnamy3BC1dyHh/60VBl/sE4ZTXyn3BsCrJJvslWG61lAcjof6NNb2Oc9E2/HLGHYprGPpBLn3AxaRINJW1IVO4vn1nuRd9ph6DaBVdgazErASpGJFJ5FpN15tJ2CcTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpvjqSLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4F0C4CEE4;
	Thu, 17 Apr 2025 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744874537;
	bh=njd0Ctie5/NJ/u0nIFo0b6CFaL7VXTbcT9S6B/AcLZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpvjqSLwnO5P4oov6RnrAJXFvg5T2B5X5w7SVvL3sYujMH5bf0IpFDTcWNfIXY8sH
	 ISYUjs240LTbyzWxSlvk3SclXPnsjL3106pN+tJLAWjKmn3VHFF7Dkv7sLwEFGnaQL
	 jbPsZicrvOsj6AzaMl8u9RifyRNNSY+vQLaAqOVjKE6IaSyVRqwQKv1FBYREQLvizv
	 6Qlexqzlh8L17ECPL6ZfzNikEUw2Vq+xekJevwisVsuJUZ75bXsBYkN4RMqBao9HPu
	 XjXV4gJprVmX3DLafD6kKfmLB3oyRheCLo9FBevmpnsY5IZ2zaxzsMPIxv3HYCxZNi
	 xjti22U8Axj/Q==
Date: Thu, 17 Apr 2025 09:22:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <aACsJPkSDOHbRAJM@ryzen>
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>

On Thu, Apr 17, 2025 at 03:08:34PM +0800, Shawn Lin wrote:
> 在 2025/04/17 星期四 15:04, Niklas Cassel 写道:
> > Hello Hans,
> > 
> > On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
> > > The RK3588's PCIe controller defaults to a 128-byte max payload size,
> > > but its hardware capability actually supports 256 bytes. This results
> > > in suboptimal performance with devices that support larger payloads.
> > 
> > Patch looks good to me, but please always reference the TRM when you can.
> > 
> > Before this patch:
> > 		DevCap: MaxPayload 256 bytes
> > 		DevCtl: MaxPayload 128 bytes
> > 
> > 
> > As per rk3588 TRM, section "11.4.3.8 DSP_PCIE_CAP Detail Registers Description"
> > 
> > DevCap is per the register description of DSP_PCIE_CAP_DEVICE_CAPABILITIES_REG,
> > field PCIE_CAP_MAX_PAYLOAD_SIZE.
> > Which claims that the value after reset is 0x1 (256B).
> > 
> > DevCtl is per the register description of
> > DSP_PCIE_CAP_DEVICE_CONTROL_DEVICE_STATUS, field PCIE_CAP_MAX_PAYLOAD_SIZE_CS.
> > Which claims that the reset value is 0x0 (128B).
> > 
> > Both of these match the values above.
> > 
> > As per the description of PCIE_CAP_MAX_PAYLOAD_SIZE_CS:
> > "Permissible values that
> > can be programmed are indicated by the Max_Payload_Size
> > Supported field (PCIE_CAP_MAX_PAYLOAD_SIZE) in the Device
> > Capabilities (DEVICE_CAPABILITIES_REG) register (for more
> > details, see section 7.5.3.3 of PCI Express Base Specification)."
> > 
> > So your patch looks good.
> > 
> > I guess I'm mostly surprised that the e.g. pci_configure_mps() does not
> > already set DevCtl to the max(DevCap.MPS of the host, DevCap.MPS of the
> > endpoint).
> > 
> > Apparently pci_configure_mps() only decreases MPS from the reset values?
> > It never increases it?
> > 
> 
> Actually it does:
> 
> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L4757

If that is the case, then explain the before/after with Hans lspci output here:
https://lore.kernel.org/linux-pci/bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com/

His patch changes the default value of DevCtl.MPS (from 128B to 256B), but if
pci_configure_mps() can bump DevCtl.MPS to a higher value, his patch should not
be needed, since the EP (an NVMe SSD in his case) has DevCap.MPS 512B, and the
RC itself has DevCap.MPS 256B.

Seems like we are missing something here.


Kind regards,
Niklas

