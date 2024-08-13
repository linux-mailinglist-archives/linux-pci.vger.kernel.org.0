Return-Path: <linux-pci+bounces-11628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1D9502CC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9336287212
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22716B39A;
	Tue, 13 Aug 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+Nv3b7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D7757E5
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546019; cv=none; b=Axf7FRZYiia1VhWD9tvsSoRrtsi1/rHBpDcYHKYTbpLOsp8kFnI7bQUGotOoVImhI7fyjYqFiFnu101PgosFB/i8Nsl96f39kXaJyRDTpv6Jw4Kyd0CAEBAARl2Iu63MD5eLOY4FPF4koJhQVvWjQiAGz3uBWNSLBzcoruu2Bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546019; c=relaxed/simple;
	bh=60u07Iu+UhkKtgwGQJ2wtOM/+Oj9papqUhljUq9Vmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBTrguvCRkEJzYB7FA8S0zLlc5rDpht+26Pzqui8eNSzBUwutohhDK/wAeE/+y5tkpfFxCMF0geG5lw3GeaTA+LM+j/uHxYnCGIuMRKfq99fJWuviQY0SUdBQgqLRSWQW0aZgGMmxt4H83Sa+hk3YXbSgfBXrpVofiUQsCbLAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+Nv3b7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C1C4AF0B;
	Tue, 13 Aug 2024 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546019;
	bh=60u07Iu+UhkKtgwGQJ2wtOM/+Oj9papqUhljUq9Vmxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+Nv3b7RnPrW8mHt4eceqNzFPW95CabIxiQ5F71C7jDg2WsqwSSr7OJ/nywc3C2Yz
	 g07ROOBL16a4EK8QHkiBsfEV/fTUsrdwJ973DUy7x5vJrk8vhX4cdFbSQTS/5Q9HZm
	 kWoI1cuQTDWSzBWqMue6q5NVpb9oUj5Z59MjW5PA=
Date: Tue, 13 Aug 2024 12:46:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: stable@kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH stable 5.15.y] PCI: dwc: Restore MSI Receiver mask during
 resume
Message-ID: <2024081340-geometry-creation-f241@gregkh>
References: <20240803112852.2263-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803112852.2263-1-jszhang@kernel.org>

On Sat, Aug 03, 2024 at 07:28:52PM +0800, Jisheng Zhang wrote:
> commit 815953dc2011ad7a34de355dfa703dcef1085219 upstream
> 
> If a host that uses the IP's integrated MSI Receiver lost power
> during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> dw_pcie_setup_rc() always sets pp->irq_mask[ctrl] to ~0, so the mask
> register is always set as 0xffffffff incorrectly, thus the MSI can't
> work after resume.
> 
> Fix this issue by moving pp->irq_mask[ctrl] initialization to
> dw_pcie_host_init() so we can correctly set the mask reg during both
> boot and resume.
> 
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Link: https://lore.kernel.org/r/20211226074019.2556-1-jszhang@kernel.org
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Now queued up, thanks.

greg k-h

