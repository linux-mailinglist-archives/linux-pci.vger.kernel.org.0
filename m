Return-Path: <linux-pci+bounces-43848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681DCE9B18
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A19FD30049F3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03D2EBBAF;
	Tue, 30 Dec 2025 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTuacAkf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54A2EBB89;
	Tue, 30 Dec 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098581; cv=none; b=SZQPYexbeNJ1yfUjnUoNqZvJBA2yAKjFahIIdUTo0Q/4+gSmcA0ULKvYDeT4l10uYLQbHfQ8GSK6EybUXT/9KAY31m5N0p0A9YJjm2HcqWQtjzmBYExu/QOukt/jMEcZBHriSyLzJtNXTTxuJJ8qrE00ZiidVvqcTFwMqGIl/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098581; c=relaxed/simple;
	bh=9PXX8lI83hRACjmN1PJkzCfUsWjkr5sFSHxm5Dksyw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLtduB3SDb5tyrYYPIKkU0u4+cIkYsCWGvZbj8eBgkYe7K65LKvnqF7eFbfXxxgGRqCZKsxJpWzMqTSMbQz9SM4CG/uOC49cvQj4sfBduq59GiPYGoBIMKXejqXdsUk9ARUUHNs3f8wJ3IJSDYmTdQX4fgOfYkPMLG/B6W3Ey1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTuacAkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D877C4CEFB;
	Tue, 30 Dec 2025 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767098580;
	bh=9PXX8lI83hRACjmN1PJkzCfUsWjkr5sFSHxm5Dksyw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTuacAkfQ4Qtno4D1F7JJ/E512++/dAsNBFK5VsUYDWO7EbYm413NofwWHheQ67ix
	 BH0WI56WwKWzagF+BlggF8o87iXW7HTOODPGk9wqc0clYVr0jQW2XDk68LlqrQicoO
	 mTzEVk0Q6IuZGH/UA7hE51hsKI3aMG2wlbS2eNimCH1kVReu5YoSNNtfmoK4cKy7uZ
	 5AFozEgWPnvewd6vliKxDd2x5X3KPx7fHAy99mBHhdIAIi1MSG/5sEx365bUdc2Zgh
	 DhvK3cRJLiuq7OWJrpYV1+0hSG6kPrfOfOme7gfuGiCPATv2ZkKnUpYOO/blVOg/Us
	 3j+HYdSiUYISg==
Date: Tue, 30 Dec 2025 13:42:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 6/7] PCI: qcom: Drop the assert_perst() callbacks
Message-ID: <aVPIzp97pEFjIYBr@ryzen>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
 <20251229-pci-pwrctrl-rework-v3-6-c7d5918cd0db@oss.qualcomm.com>
 <aVPGMJkleqTJezpX@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVPGMJkleqTJezpX@ryzen>

On Tue, Dec 30, 2025 at 01:31:50PM +0100, Niklas Cassel wrote:
> On Mon, Dec 29, 2025 at 10:56:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
> Now when all pwrctrl drivers have been converted to new pwrctrl design,
> there is no need for the .assert_perst() callback in the controller drivers,
> because with the new design, the actual work by the pwrctrl driver will have
> been done before the controller driver enumerates the bus. There is thus no
> longer any need for .assert_perst() callbacks in the controller drivers.

s/before the controller driver enumerates the bus/before the controller driver
asserts + desserts PERST# and starts link training/


Kind regards,
Niklas

