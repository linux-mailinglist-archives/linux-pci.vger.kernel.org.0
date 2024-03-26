Return-Path: <linux-pci+bounces-5179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D974B88C414
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173971C3EBB8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316D7F7C4;
	Tue, 26 Mar 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYeJpAUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4974C17;
	Tue, 26 Mar 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460857; cv=none; b=gyCnljRFV/0Jdo6aKKVlfMld2HUxB48ROTX+ENJcU2kPLZo9jexOmbou5G7KEL9K6TbC7hcGhyJTBo1HL6jDe9LZBDJkg9PD98v77cazCbi7SA5SvZVQpIXg53TLlAAYh0Algkjk3ENWgLTsjwUFq0afREL60NK6uPjimBcZxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460857; c=relaxed/simple;
	bh=P2qK25AOinNz1eP+vHSK/lBmvdrjVtBZ8Su3RQbwtRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHoba7KgkBBzapWlV7ExMnPz2tfbkYjx2WO6jTOu3cBWOw+qab1TdW6nsEC1a+CMcaEeB/gX3XuhEzfEnekZTFeqQZKY4C9xabPCYCGF+O8A2Rb8co4nVl6hjAcelwROkwFSazIVIP5RJx+RS/6ezl6VMtH4HJJiP1yyRADV+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYeJpAUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A807CC433C7;
	Tue, 26 Mar 2024 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711460856;
	bh=P2qK25AOinNz1eP+vHSK/lBmvdrjVtBZ8Su3RQbwtRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYeJpAUHeFOtG+bIdXG4Ruq0TGZaT46Di9QiU5jbnT4y5EU9XK1+HYVCYRYP+QIGd
	 H85d8RqAmdnILOZQGO1qo1KdsKLrUibL0+sH46/JIdwl99uiItbPikVDfNWmvWAVZb
	 ucKWnIWAwts3UaDdSfSyN3bmzu/9xOt24yVX9WAaL/GuyLS6YcW2JvnEh+USq8VDmn
	 WEp9bB5M1INWnORCaztLLJ9m1LP9cTLSMOIdhui4ACXSvAimJ+CCWr8f/cyN4RkTsb
	 If9D5XeKXZDIun/nWRAOJcv7IcL2go3FXh61EAbq3DJeQf1kUd+HKY8wAt6hK1e4CC
	 DcGcFdR15J+0w==
Date: Tue, 26 Mar 2024 14:47:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <ZgLR8jWfBcZB8laa@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
 <20240326074429.GC9565@thinkpad>
 <ZgKiUogkgrMwV1uD@x1-carbon>
 <20240326111021.GA13849@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326111021.GA13849@thinkpad>

On Tue, Mar 26, 2024 at 04:40:21PM +0530, Manivannan Sadhasivam wrote:
> 
> I was planning to drop enable_resources() from Qcom driver once the DBI rework
> series gets merged. Because, the resource enablement during probe is currently
> done to avoid the crash that is bound to happen if registers are accessed during
> probe.
> 
> But what your observation reveals is that it is possible to get PERST# assert
> during the EP boot up itself which I was not accounting for. I always assumed
> that the EP will receive PERST# deassert first. If that is not the case, then
> this patch needs to be dropped.

From what I saw when having debug prints from my old email to you:
https://lore.kernel.org/linux-pci/Zalu%2F%2FdNi5BhZlBU@x1-carbon/


## RC side:
# reboot

## EP side
[  845.606810] pci: PERST asserted by host!
[  852.483985] pci: PERST de-asserted by host!
[  852.503041] pci: PERST asserted by host!
[  852.522375] pci: link up! (LTSSM_STATUS: 0x230011)
[  852.610318] pci: PERST de-asserted by host!



So in my case, I assume that the RC asserts PERST during a SoC reset.

This is obviously from the RC driver asserting PERST + sleep 100 ms +
PERST deassert:
[  852.503041] pci: PERST asserted by host!
[  852.610318] pci: PERST de-asserted by host!

The two before that:
[  852.483985] pci: PERST de-asserted by host!
[  852.503041] pci: PERST asserted by host!

appears to be because the RC I am using, incorrectly sets the PERST gpio as
ACTIVE HIGH:
https://github.com/torvalds/linux/blob/v6.9-rc1/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L300

Well, at least they are bug compatible and sets the output to:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L170-L184

0 and the 1, which, since the DT binding is incorrect, will actually
do the right thing and assert and the deassert PERST.

The problem seems to be that the initial flags:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L242-L243
is: GPIOD_OUT_HIGH

which explains why I get the extra:
[  852.483985] pci: PERST de-asserted by host!
before
[  852.503041] pci: PERST asserted by host!

with basically no time between them..


I guess I should send a patch to set the initial value to
GPIOD_OUT_LOW, so that the RC driver does not trigger a
"spurious" PERST deassertion when requesting the IRQ.


So I think this patch should be fine if the RC is not buggy,
but as we can see, in reality there are at least one platform
in mainline that does manage to get this wrong.


Kind regards,
Niklas

