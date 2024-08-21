Return-Path: <linux-pci+bounces-11977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62095A6F1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BAAB20757
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100B175D59;
	Wed, 21 Aug 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhjPjrLs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80F13A3E8;
	Wed, 21 Aug 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276595; cv=none; b=lUKPW5yYsd7xGD5U/g+j6ZQ5jdpeJQ3c7ZGB6AOXl/6nt63mQ1fVRepcZgnsMnfjMeA2BN/TX67i5K1VFYkNhk2ndVPg10CyV/2koO8XwfXB6quF0nvA01DeWovrlx+OdL5edD0LadkYKaUbSU8V9jeDevIXwah2emqGYa6h0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276595; c=relaxed/simple;
	bh=0Yu32Y2Y97+J7V2U2AZCL0+qw3bl5E2OZ9XQy9g/wxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sSAKvsdY9OclugnwZkyDsrV6a+pz+59AWAPKsYXeT7zEqY+yPwfYvEe0CaIUmN6hxv2IxUTGqOOo3VxV1MsQSf0/y5uHz0gtph+4MxjmjwVRiSpDQ8LlrapCy2dyMDog9fPV5H9mXvjv6LCjppvm1guyB6TizODK0hZOizYN2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhjPjrLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66549C32781;
	Wed, 21 Aug 2024 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724276594;
	bh=0Yu32Y2Y97+J7V2U2AZCL0+qw3bl5E2OZ9XQy9g/wxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OhjPjrLsmnbkOEwzQ9TSQaOGfhTR81foJZIrjn0jymdJ+DsxoJcgziNLu+BGWtDNN
	 s8/2P9SG/UL0N0I4n/zenqFhKZy+RdEm288mPAHUHy7z+BJmrk+loKShjm/EU/3GcL
	 iYjRgE/CEVnsy8cNEaMZBfT6eYkgsD3bydNA8R+jwhITiKi8KaMj1GVTjGHWhVWV11
	 KzqtRREbV7A9NVOQ5sABE8OGsfW9ad8dJ2WxZqFWh2NSNeeLgFAGExDKKf6NQYiYXF
	 slZHRazBltWpNdsA+eCG6oi1lYoowuOqOMyo39nRRvGrW9I+AWhRYBk5nJC1jkWAXn
	 5YlrqUOysjyNA==
Date: Wed, 21 Aug 2024 16:43:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240821214312.GA270533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813202837.GE1922056@rocinante>

On Wed, Aug 14, 2024 at 05:28:37AM +0900, Krzysztof Wilczyński wrote:
> > Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> > deinit notify function pci_epc_deinit_notify() are called during the
> > execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> > PERST#. But quickly after this step, refclk will also be disabled by the
> > host.
> > 
> > All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> > the host for keeping the controller operational. Due to this limitation,
> > any access to the hardware registers in the absence of refclk will result
> > in a whole endpoint crash. Unfortunately, most of the controller cleanups
> > require accessing the hardware registers (like eDMA cleanup performed in
> > dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> > functions are currently causing the crash in the endpoint SoC once host
> > asserts PERST#.
> > 
> > One way to address this issue is by generating the refclk in the endpoint
> > itself and not depending on the host. But that is not always possible as
> > some of the endpoint designs do require the endpoint to consume refclk from
> > the host (as I was told by the Qcom engineers).
> > 
> > So let's fix this crash by moving the controller cleanups to the start of
> > the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> > called whenever the host has deasserted PERST# and it is guaranteed that
> > the refclk would be active at this point. So at the start of this function,
> > the controller cleanup can be performed. Once finished, rest of the code
> > execution for PERST# deassert can continue as usual.
> 
> Applied to controller/qcom, thank you!
> 
> [1/1] PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
>       https://git.kernel.org/pci/pci/c/6960cdc1ef97

I dropped this for now, looking for a new simpler version without
"cleanup_pending" and a similar change for tegra194 (separate patch).

I think it's still an open question whether both
pci_epc_deinit_notify() and pci_epc_init_notify() are needed, but that
should be separate and I don't think that would fix a crash.

You said this was not strictly v6.11 material, but it does fix a
crash, and it only touches the endpoint driver, so ... it seems like a
possible candidate, especially if we can identify a recent commit that
caused the crash.

Bjorn

