Return-Path: <linux-pci+bounces-34720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B6B35515
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3633B6CC9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD22F6571;
	Tue, 26 Aug 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1A0r4b0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02927EFFE;
	Tue, 26 Aug 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192518; cv=none; b=r1HiWD/MHrR9DAzfOqeogM/95mo5TxrmOJR7gXhJyQkI8zPVlL8osA+06JuIyhkuZz3B7inuQl/+cqrYB1Es2LwHVDbxI8Hb/sL9fO37g11CVXCism0m4kT/tMPzdtub6vl2HeE9yKkh4u0arqFmBUorSHq6s32Z5dys9T+QJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192518; c=relaxed/simple;
	bh=aYIVm+aKRLtltfxrMsj38OhXw3B6ZTzRaFrq3NQzEIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz5puSip5YqG2AcQ7VM2YOlBgHByAMHFplkeOg661WraJ2fi+QXilhl8Nr59Z6SuuNumeWcKsaJ9LtUKrHivqTCO02DPpjVuGtbSz7i8BtxLpPctIYpEIitDxnzFEJHzZnIvlcu2Mrk2cK+ZIBU+zGu33tYKlELsWFVN9xLOxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1A0r4b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B064C4CEF1;
	Tue, 26 Aug 2025 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192517;
	bh=aYIVm+aKRLtltfxrMsj38OhXw3B6ZTzRaFrq3NQzEIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1A0r4b0I+6n4uHTHmN33PPcN7L5aYBEDvRXzT8XnmI/npegDJXUUigz7LeUBLHsJ
	 hDRMf0fefK23a2r4GBcTOVRCtUewX4llg5ocpVwB3CAtV8t8ELmpVwnAg8se1xj+mV
	 PUAB6GAnaGHLye/UFCcydpZo65ZtQb9/9Wc5vrkaQ0WOuyf5rl5G4nDAFvQhHR7NB+
	 F8/cfgR2IxPZHk/1/I2AmI+sWEvi/CkNVFllayOtYcClDLc0UT9QFNVe6XNk0M8dOo
	 XroksPuMgDwyU+Hl03PiXe79AGYVX/oN4Pv/iLnbqWS4GBy+y+XrGNVt0g5hpB3Jss
	 X7zfhbyXG6XsA==
Date: Tue, 26 Aug 2025 12:45:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device
 node
Message-ID: <jqgvw3u6lkewaz2ycjkozcfqrmdln5gacgrog4lhioazhvk5yz@3ph2z25zwqvj>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
 <20250822135147.GA3480664-robh@kernel.org>
 <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>
 <20250825224315.GA771834-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825224315.GA771834-robh@kernel.org>

On Mon, Aug 25, 2025 at 05:43:15PM GMT, Rob Herring wrote:
> On Fri, Aug 22, 2025 at 07:57:41PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Aug 22, 2025 at 08:51:47AM GMT, Rob Herring wrote:
> > > On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wrote:
> > > > Bus:Device:Function (BDF) numbers are used to uniquely identify a
> > > > device/function on a PCI bus. Hence, add an API to get the BDF from the
> > > > devicetree node of a device.
> > > 
> > > For FDT, the bus should always be 0. It doesn't make sense for FDT. The 
> > > bus number in DT reflects how firmware configured the PCI buses, but 
> > > there's no firmware configuration of PCI for FDT.
> > 
> > This API is targeted for DT platforms only, where it is used to uniquely
> > identify a devfn. What should I do to make it DT specific and not FDT?
> 
> I don't understand. There are FDT and OF (actual OpenFirmware) 
> platforms. I'm pretty sure you don't care about the latter.
> 

Sorry, I mixed the terminologies. Yes, I did refer the platforms making use of
the FDT binary and not OF platforms.

In the DTS, we do use bus number to differentiate between devices, not just
devfn. But I get your point, bus no other than 0 are not fixed and allocated by
the OS during runtime or by the firmware.

So how should we uniquely identify a PCIe node here, if not by BDF?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

