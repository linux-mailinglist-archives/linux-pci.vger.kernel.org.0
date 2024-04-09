Return-Path: <linux-pci+bounces-5936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3C89DA5E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982001F23B9B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878A12F39E;
	Tue,  9 Apr 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZTMfB0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8112F381;
	Tue,  9 Apr 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669517; cv=none; b=syU2B+WP9wZKw66eIkPMgKInnv2VFWjYdkL6zO4J1ktWHLOB9XWRn1gqKoWl/PyrpLDXz6tyVQB4V1pkWCGyxHKwGW8kBsCtayWvpSE1O8OyQB3K+fD+byRLQmXOVo/qQmOUr0M1Bj0zTIz37rSBgU3UpWGL4FlfJl7Soz1viGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669517; c=relaxed/simple;
	bh=t+Ksp7FCYvmyEVKHHeraJyf8M135WOhzLeRnkqqR5u8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eRI7LAul0eLnEeUuMWxVyzzwkY2gyrSyMJdIEszn8kAZ2wx9df885YuBb+H3MH3pugVEZLXzCZwYXl4AiTy2jY/HkTd27i0u2Pl7hIiKgpIcbwJaA+L99bzr2FSELwvjcWMik8GJ8fFbIitwEchFsf8Yxq5HUmFb+643OSOV3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZTMfB0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0FC433F1;
	Tue,  9 Apr 2024 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669517;
	bh=t+Ksp7FCYvmyEVKHHeraJyf8M135WOhzLeRnkqqR5u8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kZTMfB0UAUPUs0ocDCsQO13zU2bvvSgpasC59IiSmHHyq5XquOjWZLfQicAj8A8aB
	 o+pn4rDwBAewqokcx0PMk+RHmw49d08jFLRV+DGu9hOEzj56AnR0SEHQQGIetF/ffd
	 qNj5FIjO4PUo7n+e/5FBfQ5t00rnGIIMGEv5ZhEDAdpCYn0flo9t7ZdzOJhNOUKRkb
	 NauVif830INUuV/PA1lNcIU/6Zg6yI7E8WyW9L34teJKhQESmDt7oyO8lkSLL0eVIt
	 L/hZgbmZr/uk9pA6PPv5p1Ot9xoHKqB/T6gWZV8SyYBrW1sQZfnAlRexOi37//klF4
	 V1i8PIrLfEFtg==
Date: Tue, 9 Apr 2024 08:31:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <20240409133155.GA2072077@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg22Dhi2c7U5oqoz@ryzen>

On Wed, Apr 03, 2024 at 10:03:26PM +0200, Niklas Cassel wrote:
> On Wed, Apr 03, 2024 at 07:02:17PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Apr 02, 2024 at 01:18:54PM +0200, Niklas Cassel wrote:
> > > On Mon, Apr 01, 2024 at 09:20:36PM +0530, Manivannan Sadhasivam wrote:
> > > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > > devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> > > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > > getting disabled at the same time. This prevents the endpoint device
> > > > firmware to properly reset the state machine. Because, if the refclk is
> > > > cutoff immediately along with PERST#, access to device specific registers
> > > > within the endpoint will result in a firmware crash.
> > > > 
> > > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > > cleanup the state machine.
> ...

> For a real PCIe card, if you assert + msleep(100) + deassert PERST, surely
> the endpoint is supposed to be in a good/well defined state, regardless if
> he REFCLK was cutoff at the exact time as PERST was asserted or not?

I think this is the key point.  This PERST#/REFCLK timing requirement
seems like a defect in the endpoint.  I know there's firmware involved
and whatnot, but IMO it's the endpoint's problem to handle these issues
internally.

Bjorn

