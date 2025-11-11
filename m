Return-Path: <linux-pci+bounces-40905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B9C4DE51
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D508A4FE277
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3203246F4;
	Tue, 11 Nov 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk+Onx+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B093246E7;
	Tue, 11 Nov 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864752; cv=none; b=pGsMFFFHslrHj2KeDgmzubfEDWSNNl/k5Y6DVuY89jf+5ssqO6HmFvskbYxMQPlU4gf7iC3CBUCk4hqblcn5cYv/dD3ZSoD72DtNrnGaJhTkR11p2UZjQWnAJPVCuGiAMMYk2RfWvdaRbntnykcXLqaWWEyxrTqLIjV+xTyDgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864752; c=relaxed/simple;
	bh=esQHRI8kjTrLvjtgO/6g3Cn+MJc1AfYjyYOhFVM+O/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNWISt5ombUAnALfUdUFArSJ45TRtwslFYktDbsn6MtdPlSN+j1dj98d/AcYkGeIjTzUurW1XnbVN/5Z1Vb6UF6GinBa1iEJEGN9rlB69xJK6rPK17yTnXb6xty42mAuUrjKHpoYAEfVp82EZwukuAPDSaUAR6cpILGWypxiXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk+Onx+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3352DC116B1;
	Tue, 11 Nov 2025 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762864752;
	bh=esQHRI8kjTrLvjtgO/6g3Cn+MJc1AfYjyYOhFVM+O/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fk+Onx+GRKUPG65R/pu9BypCrp20PthfFhqBxaKyGgHDdx2K8PW/r5QQR9wW0c6+N
	 SfuQiE1mjfhOSmfAOLXiz15L0Z5AcoINETlSEnh12THxHFehPq5qemda1a36CLUHOC
	 tAWcDKZi/dz/WuevDyD9iJgh0ADaFRisAyFKnagXwNrFLPw+h7wu2DQvlFE05ZAbql
	 A+HHIDliRyNgdg0EiN9Gd0Ao7GnO2X99d6qsxX2o9r1zdEu2T7TskOR8r/wFaXHhdN
	 tJB8+ppTqEyLLk98RsPj8Acg2FyTi8rt4/bfm3+Crhc5aApsD36p0/2dLQ5FwCEdst
	 L+BI2s47TbA6A==
Date: Tue, 11 Nov 2025 13:39:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?B?V2lsY3p577+9P3NraQ==?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <aRMuascJFSuE6NBd@ryzen>
References: <20251111105100.869997-8-cassel@kernel.org>
 <aRMZS3EUYx189Xup@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMZS3EUYx189Xup@wunner.de>

Hello Lukas,

On Tue, Nov 11, 2025 at 12:08:59PM +0100, Lukas Wunner wrote:
> On Tue, Nov 11, 2025 at 11:51:00AM +0100, Niklas Cassel wrote:
> > Revert all patches related to pcie-designware Root Complex Link Up IRQ
> > support.
> > 
> > While this fake hotplugging was a nice idea, it has shown that this feature
> > does not handle PCIe switches correctly:
> [...]
> > During the initial scan, PCI core doesn't see the switch and since the Root
> > Port is not hot plug capable, the secondary bus number gets assigned as the
> > subordinate bus number. This means, the PCI core assumes that only one bus
> > will appear behind the Root Port since the Root Port is not hot plug
> > capable.
> > 
> > This works perfectly fine for PCIe endpoints connected to the Root Port,
> > since they don't extend the bus. However, if a PCIe switch is connected,
> > then there is a problem when the downstream busses starts showing up and
> > the PCI core doesn't extend the subordinate bus number after initial scan
> > during boot.
> 
> In principle it is possible to set the is_hotplug_bridge flag on the
> bridge to force allocation of more buses.  We've already got a quirk
> to set the flag on a Conventional PCI bridge whose hotplug capability
> cannot be discovered otherwise (see quirk_hotplug_bridge() in
> drivers/pci/quirks.c).

While pdev->is_hotplug_bridge was also mentioned by Mani, he seems to
prefer a revert + eventual migration to pwrctrl framework:
https://lore.kernel.org/linux-pci/4f4wsgf56eublizg63fz6xmdjixesalb2q3rxetphd55jpqqju@zfyzsxfgiyim/
https://lore.kernel.org/linux-pci/2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6/


Kind regards,
Niklas

