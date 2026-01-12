Return-Path: <linux-pci+bounces-44475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32176D11066
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8171730E56B0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F033AD8D;
	Mon, 12 Jan 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKFOd+CI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8A338586;
	Mon, 12 Jan 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204728; cv=none; b=W2Z0rYAuxT6q198eJh9QhbKM5W60BMlz5rNUEFOSfUMAvvg5mUM/ND8JZIH6zC0PRWPLmC7v5njI2j4z6xqyigQBnfEftIleWaJCK6HeZtl4mr3stwiLTR7fbR+o2uePoe11ZoW9/oB2m7uVGSSVsKyXN/YqymYGB4i2/xYLpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204728; c=relaxed/simple;
	bh=0LZKsjkXfHySOPGTc0+a4TfkOx3ctR7uJHuXAFkeim4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhGwyFIXa89kfoWntZS9U+PgAwHjOn9ug7waCxYDI8j6ysRZOmFjmyQ1t3k6WfCC4nvl/u4aaU37MA8b+3x8slLIyjdjM58A63wSDdCj8Ud86+rLg2dU8dI/D1UOz7fY9qbBFzBruhS2+vgg7i2wRKWd2y1b6ks2UYt3gYl/EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKFOd+CI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE9C116D0;
	Mon, 12 Jan 2026 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768204728;
	bh=0LZKsjkXfHySOPGTc0+a4TfkOx3ctR7uJHuXAFkeim4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKFOd+CIasEo8xokhexO3iZF3L802utZN2eUuCQr4Jffj+DnW3PyHPo+R5iCKV8AM
	 XtuPtsWfiz0ler9bUvFzbAquPGAXQ9dDeFoShatXvJ5x9/gQKgmyPRDimQ6CMbUurG
	 bAmtibAqXswRG0EMfJZZ9damkJ0zhrCTUESMKeneUHLh79lNAwLPFCK8jaGXubbEOo
	 ObdygZg6/N52gViFE6cZVu/xFg5uC4gGA5wtFhpoYMekcG3sknaflxjr7Gf9AqxlIC
	 CoNp2UFwH02CujLFS68m+CXlXBNvVG7/5+yuXAP7iw5JnxYFLgJfxSsh1+y9Pa5YOX
	 IHk35sz6krzyA==
Date: Mon, 12 Jan 2026 13:28:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <ix7mu6twdd35clxyglgcwilwn3o3u5jvkmf6wwyz7zwgsscbc5@awwwnouy4pyh>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
 <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
 <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
 <375ea14c-b089-4ae4-9827-5c19139f69c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <375ea14c-b089-4ae4-9827-5c19139f69c4@kernel.org>

On Fri, Jan 09, 2026 at 10:02:10AM +0100, Damien Le Moal wrote:
> On 1/9/26 07:02, Manivannan Sadhasivam wrote:
> > On Thu, Jan 08, 2026 at 01:15:12PM +0100, Bartosz Golaszewski wrote:
> >> On Wed, Jan 7, 2026 at 3:11 PM Manivannan Sadhasivam via B4 Relay
> >> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >>>
> >>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>>
> >>> This driver is used to control the PCIe M.2 connectors of different
> >>> Mechanical Keys attached to the host machines and supporting different
> >>> interfaces like PCIe/SATA, USB/UART etc...
> >>>
> >>> Currently, this driver supports only the Mechanical Key M connectors with
> >>> PCIe interface. The driver also only supports driving the mandatory 3.3v
> >>> and optional 1.8v power supplies. The optional signals of the Key M
> >>> connectors are not currently supported.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>
> >> This looks good to me, though there are some nits I may fix when applying.
> >>
> >> I'll pick it up for v7.0 once the bindings are reviewed.
> >>
> > 
> > Ok. I'm expecting patch 1 to go through ATA tree, patch 2 through DT, and
> > patches 3,4 through PCI tree.
> 
> Patch 1 seems to be completely unrelated to the power changes, so please send it
> to the ata list separately. It is otherwise very complicated and confusing for
> everyone to have patches from one series being applied through multiple trees.
> 

Many maintainers often prefer patches in a single series for the complete
picture. That's why I clubbed all of them in a single series. But I can send the
ATA binding separately also (once it got reviewed by Rob).

Btw, with b4, it is no longer a hassle to apply individual patches from a single
series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

