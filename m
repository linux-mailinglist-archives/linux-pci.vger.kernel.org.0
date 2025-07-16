Return-Path: <linux-pci+bounces-32238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04CDB06EC1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEEB188EE7F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C56256C6D;
	Wed, 16 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJjTmG8B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333902459E5;
	Wed, 16 Jul 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650244; cv=none; b=AmxG3bSWtTlpyng/KTlkucDMA9R1C/o6Tbmk8z9rkthlgiOCvSuWX2okhE9r0fAi3w8keDuqzHaYUb6SuKvG9K0QAhAfa1atOEJmoojElSpuOIaK3nHiiicOAYuxxe+aO7I305TdKbTGFJRNGz/izvjcJNC1Va3RhhOlNhiX/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650244; c=relaxed/simple;
	bh=vJTQesx+suD0QBepzarzrrknitZ0ytPnsI8U4eBlM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMv2jVRAUSEtvzPP+brjIWOCtRvtkw7SHCgKWl5gznHeVLnKhEffreW94HXEhIv9cLSAx+E1myxkdrtMen+5COKahjYdNG/wRdviebEM+SP2VvTXdnwUL7pSDv8ZqPfuo181oBUvGODUV1nHDOhvxVRQXxDBtJKbwBa8uEoMRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJjTmG8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD8C4CEF5;
	Wed, 16 Jul 2025 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752650243;
	bh=vJTQesx+suD0QBepzarzrrknitZ0ytPnsI8U4eBlM1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJjTmG8BlCNs6X7QOqUZZCSP/msTa6RS4Mz+riP4hCZRWO2PltbQ//fqG6tZ6OkUJ
	 tlaQwkEvfg7gd+sbGTTME2ykQx7dkE4xtbdDlWzMAFtQLy636n0Mvk+oHWhRRFg/MJ
	 3KCZlLyaaBYQbzUKGppsVST+RkV4qYqnxH93a7akO1lhwAfODcin8LbyzALwWkt6H4
	 k0IytbiUnD/AATPZ4G9Kp4LalD0nW6eDFMc2YrU6RKuNSHVpHJ2FTDC9eYa2wW4gdL
	 +mMhxwdeRnaW5PEDA6pvmv7u31MHU0dLke6ofo2FkNiej0eUpX/40dc/6s2zBGkm9s
	 H7LGebotSevUg==
Date: Wed, 16 Jul 2025 12:47:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <tikcdb63ti6hbpypusxdiaoattpuez5rgpsglzllagnqfm5voa@5eornv77pl4i>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGXEcHTfT2k2ayAj@google.com>

On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:

Sorry for jumping late into this thread. I missed it completely as I was not
CCed.

> Hi Frank,
> 
> On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > Does the AER driver actually work on these platforms?
> ...
> > There are several attempts to upstream customer Aer irq support in past years.
> > 
> > For example:
> >   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1161848.html
> > 
> > some change port drivers.
> > 
> > If you think it is valuable to support customer AER IRQ support, I can restart
> > this work.
> 
> Interesting thread. I read through it, but I'm still not convinced about
> one detail:
> 
> Are you sure that AER can't possibly work over MSI? Even today, the
> Synopsys manuals say that their integrated MSI receiver "terminate[s]
> inbound MSI requests (received on the RX wire)" and after terminating,
> "an interrupt is signaled locally through the msi_ctrl_int output."
> 
> That means that their msi_ctrl_int signal only handles MSI requests from
> downstream functions, and it implies that the default
> drivers/pci/controller/dwc/pcie-designware-host.c
> dw_pcie_msi_domain_info implementation will not actually see MSIs from
> the root port (such as PME and AER). So yes, it *appears* that AER does
> not work over MSI.
> 
> But crucially, it does *not* mean that the port will not generate valid
> MSI requests, if you have some kind of logic that will receive it. So
> for instance, I pointed out in another reply that some SoCs choose to
> hook up GIC ITS:
> 
>  commit 9c4cd0aef259 ("arm64: dts: qcom: x1e80100: enable GICv3 ITS for
>  PCIe")
> 
> """
>     Note that using the GIC ITS on x1e80100 will cause Advanced Error
>     Reporting (AER) interrupts to be received on errors unlike when using
>     the internal MSI controller. Consequently, notifications about
>     (correctable) errors may now be logged for errors that previously went
>     unnoticed.
> """
> 
> And in fact, your arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi seems
> to be doing the same. I'd be surprised if these port MSIs still don't
> work after that.
> 
> OTOH, I do also believe there are SoCs where DWC PCIe is available, but
> there is no external MSI controller, and so that same problem still may
> exist. I may even have such SoCs available...
> 

Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from this limitation.
And the same should be true for other vendors also.

Interestingly, the Qcom SoCs route the AER/PME via 'global' SPI interrupt, which
is only handled by the controller driver. This is similar to the 'aer' SPI
interrupt in layerscape platforms.

So I think there is an incentive in allowing the AER driver to work with vendor
specific IRQs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

