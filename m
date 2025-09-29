Return-Path: <linux-pci+bounces-37204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ADABA9773
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D307A6B8A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348827E1A1;
	Mon, 29 Sep 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiyiJkY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF62AD31;
	Mon, 29 Sep 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154492; cv=none; b=DAHejieLE4pdaNhZAVj8UUvm+d/0j/txqGB/jTu5eZmSzkrXHiAzQGdLHNU00DdGiv2NqAzTqvl8o+sgXcXw9uwZUou3apiMuWmwr+0HNpWnBTk7gXTJ2qFd5waapVoLgkUZEzZo+WP19KbFyh2XeW9sqncHpFw34UQJPoVZo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154492; c=relaxed/simple;
	bh=AGBrlJgZMXwWrvzDJ0mbyXAW4IA6QpxXN4UJJSZ2Ugo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q17Z7WDu6KcbIDGibSfTIYe/fVf/1bdHSClhBE71HWOZ2NIlMnB2sqzXTojUtpEQIML4RyCaHst6NzzioSaJgzPr7neM9FHLArdLQ9UU3DdazP8RhIEgXgZPbTL3hD2iUC14YmqKJdrsnYTxvZeanPGExRuas4BljBT4scuZk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiyiJkY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE87C4CEF4;
	Mon, 29 Sep 2025 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759154492;
	bh=AGBrlJgZMXwWrvzDJ0mbyXAW4IA6QpxXN4UJJSZ2Ugo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiyiJkY1ok13BJg6ud1Zx8GmOYD1YFY+hEE+A6Qhu+aPow78hwcioGpnF2S88+2+f
	 Q3ikYtlAVuPDyCT0ZUXj8JvuZPx1aL5tDkmFxBOBig0D0DxpjXR7XNqHFmVQlCMRLW
	 YmKKsLtbCscxxKUG0+nl6Hu0DG/5lrhT+G/S5XhgTu/avQ9UBh55LRoR3KonhwX1xG
	 hHztIG/p9vdilYziFhAeqsILLDHasO7mYdtnDyZmQu7xY+zdU5SLTxY3AkVdYBvM0X
	 7A59u+eqR4Hv0Rbg6cqyHbcB6pmPhKD5aDjRCmeFmTioCEBSeintxP+MopI932ZnhS
	 eFRSo4ZSLEj8A==
Date: Mon, 29 Sep 2025 19:31:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
Message-ID: <aw3flahx3g4exezj5245cgrixasshvf26yibctxsd3l42ygwke@equdzipwspvx>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-3-linux.amoon@gmail.com>
 <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
 <CANAwSgT3inDQZ40uFtXwFze2m4hZUvnyKTek3PQ9jb6picgi-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgT3inDQZ40uFtXwFze2m4hZUvnyKTek3PQ9jb6picgi-A@mail.gmail.com>

On Sat, Sep 27, 2025 at 11:20:10AM +0530, Anand Moon wrote:
> Hi Frank,
> 
> On Fri, 26 Sept 2025 at 23:42, Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:57:43PM +0530, Anand Moon wrote:
> > > Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> > > the clocks individually thereby making the driver complex to read.
> > >
> > > The driver can be simplified by using the clk_bulk*() APIs.
> > >
> > > Use:
> > >   - devm_clk_bulk_get() API to acquire all the clocks
> > >   - clk_bulk_prepare_enable() to prepare/enable clocks
> > >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
> > >
> > > Following change also removes the legacy has_cml_clk flag and its associated
> > > conditional logic. Instead, the driver now relies on the clock definitions from
> > > the device tree to determine the correct clock sequencing.
> > > This reduces hardcoded dependencies and improves the driver's maintainability.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
> > >       fix clks array.
> >
> > why not use devm_clk_bulk_get_all()?
> >
> My RFC used this devm_clk_bulk_get_all() which could work for all the SoC,
> However, Jon recommended switching to named clocks, following the
> approach used in .
> but Jon suggested to use clock names as per dwmac-tegra.c driver.
> 

The concern was with validating the DTS files with binding. Since it was in .txt
format, validation was not possible. But you are converting it to .yaml, so you
can safely use devm_clk_bulk_get_all().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

