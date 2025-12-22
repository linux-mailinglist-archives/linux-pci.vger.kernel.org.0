Return-Path: <linux-pci+bounces-43491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DBCD4C70
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B7B3004F1E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CC19F13F;
	Mon, 22 Dec 2025 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua+tOSC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69B86347;
	Mon, 22 Dec 2025 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384124; cv=none; b=Ws/j7y3d6Y0CekeARMMZdcRYDtXFJ1UB9uAOzf1rBRTAAfPyZWgK5m8STwmY40WylmWk3AQDxu1tjj1FX3ParQkCNEI/TZ5NUwl1wosvuFTJ1GB5NklJJE94PrtneIhtlKzLzvfnRMbcPjvRxqumSOpPZpIt2gsJHWLKh/2PJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384124; c=relaxed/simple;
	bh=GXEtZp4QRQx0hcOsDqW5Mo0KVr1eWC8Jjb7PsD5/6AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMjxLOFcjMcJGmGCONytA0R3vD/mJAAng52KSkgmvNkOHqpx8q9/P3t3tR3A8mt0e3glSn7TWTQe9xyabx6TPQLwQi3NrlkrU5tF/DKlyI+qYQ37+wsPn5QXK46HQJZtG5g2bAu5vQ12jipD1J/v0tIUK3H937bvrOGL/bDBd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua+tOSC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAFAC4CEF1;
	Mon, 22 Dec 2025 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766384123;
	bh=GXEtZp4QRQx0hcOsDqW5Mo0KVr1eWC8Jjb7PsD5/6AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ua+tOSC3ui9atQi4EUgmggjiDNruCiGJkW5003dHm3u9C6zi/6Roi2qB7xStYF5q8
	 1LL4VQDcurSMdJwPlF9oli/tvKNTbe0bO3KAtNEIDnT5z7eZ2rRB7l4CuHWrUnomLx
	 SIp++9sGYj8AWWYm0Clftu55di+RJ5/SmMAl6/AN68UENro2APxOFaKp42pQjGbeyQ
	 1UUY1LkKCsBoS+zUjh8gZFMHH9BIz+Lxpk3Y4DqZJNa39b9Yw+UGoyuBgaM1g+J6bE
	 SefjlR34LQ/kzlaoqJR6UMJQxa/0XDjQ9a6w7ZzD01OMfvy7KDxMeXx9xvVvjC6dxu
	 W8xHzJyBxOuRA==
Date: Mon, 22 Dec 2025 11:45:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <fle74skju2rorxmfdvosmeyrx3g75rysuszov5ofvde2exj4ir@3kfjyfyhczmn>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
 <aTev28wihes6iJqs@dhcp-10-89-81-223>
 <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>
 <aTe1bA7lcVzFD5L7@dhcp-10-89-81-223>
 <pjn2gs43rqbe3odh6zvh4qaftxxl6qvdzpm6pgpadxeeid42ko@4a2qradscaqd>
 <aTu4JgDcfb_58qBK@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTu4JgDcfb_58qBK@fedora>

On Fri, Dec 12, 2025 at 03:37:26PM +0900, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, Dec 12, 2025 at 12:52:35PM +0900, Manivannan Sadhasivam wrote:
> > > This patch missed the v6.19 merge window (and so did the pwrctrl rework
> > > series), so as long as Mani queues up both for v6.20 (with the pwrctrl
> > > rework series getting applied first), I think we are good.
> > > 
> > 
> > The plan is to merge pwrctrl series to v6.20 (unless we get strong objections),
> > but once that happens, Qcom doesn't need this patch.
> > 
> > So it'd be good if you can just limit this patch to just Rockchip. Then once the
> > Rockchip also moves to pwrctrl, we can revert this patch (also the whole IRQ
> > based link up since the Root Port is not hotplug capable).
> 
> The main reason why I did not like a revert, was because it would remove
> the nice feature where the bus is enumerated automatically on link up.
> 
> I assumed that the plan was to add Link Up IRQ support in pwrctrl in the
> future.
> 

As I dig more and more into pwrctrl, it becomes clear to me that emulating
hotplug on non-hotplug capable hw is a bad idea. Though it gives a nice user
experience in majority of the cases, it also gives issue in some cases like
switch. So pwrctrl will just power on all devices/slots before initial bus scan
and will not do any link up based enumeration later. And neither the controller
driver.

> If that is not the case, and the plan is instead to eventually remove the
> existing Link Up IRQ support, then perhaps you could simply apply patches
> from:
> https://lore.kernel.org/linux-pci/20251111105100.869997-8-cassel@kernel.org/
> 
> Either the whole series or just patch 1 and 2, maintainer's choice :)
> 

I tried applying the whole series, but it fails at patch 2. Could you please
rebase against, pci/controller/dwc and repost?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

