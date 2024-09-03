Return-Path: <linux-pci+bounces-12704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A596ABEB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D4DB254E4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6B1D54ED;
	Tue,  3 Sep 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQazOKke"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10511D5897;
	Tue,  3 Sep 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401593; cv=none; b=NNPx4d3p62xxEhWn9LlkKXaCXJvljzQfOoVec4Diot8SquQCiNzyYgX9bY5fc7ryi5QbnsDA/eqUWPfVGgvG98Z+fpcW1XXMBRegu00JA3cZ8RuSOAc7Nk3TEHeOIwjXY4T3H24FN8HkRROz0YT/h1MRbXstwIi6QitmhcCBxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401593; c=relaxed/simple;
	bh=hnRbTCBiLUPEeMzG78scZn52td6uKH5byGGBNSgOMLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nbOHIAh3fT/qMngVkdIqV+qhlJrWlJewgR6UemKRUPf03lXYK9Rcu2sS2dQuF045pY/go1BI/6AIAfv0Vf0kyQUrWlVshoRMNWEeSl1FFhd1/47KCbfBSDd2Hc1bDzSaYwo563JPoxWi4x3cGPiMipWCFThGJUvnNBaaXrtGSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQazOKke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB2C4CEC5;
	Tue,  3 Sep 2024 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401593;
	bh=hnRbTCBiLUPEeMzG78scZn52td6uKH5byGGBNSgOMLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pQazOKkeI1qKBVVv7OCXZPFdT/ODCP+O1xNQB3JQaa3kUG9ZuCW0O+NP3UPV0HkCL
	 41+HH1UjTac0FrD0LmIK7YSC8lRSKf+0JeJyj9i6CcmquIJu6mj6h8tibP0tl2MDIr
	 TSJEx8zQqfY+x3heqircZfp/eoh210Mq5b3oJiHmSgz8BA2SkzKjCq86JaJbijy0bX
	 dXREkJPgf7QM7YntYCIsN9g4Q80Jth22DmnsH+4P2pZlOE29c683+X23Aa2xa+/5um
	 1CqdCQM8t6zdGstHaNKhqpP3CKCyKYKCnapK79/PXCz+YZxyQ3p5Llr1jTWyF8nYcN
	 Ib1UicTn09VKw==
Date: Tue, 3 Sep 2024 17:13:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 0/2] PCI/pwrctl: fixes for v6.11
Message-ID: <20240903221311.GA306706@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823093323.33450-1-brgl@bgdev.pl>

On Fri, Aug 23, 2024 at 11:33:21AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Bjorn,
> 
> Here's a respin of the PCI/pwrctl fixes that should go into v6.11. I
> eventually found a solution that doesn't require Krishna's topology
> change but Krishna: please make sure to update the code in
> drivers/pci/remove.c as well when rebasing your work once this gets
> upstream.
> 
> v2 -> v3:
> - use the correct device for unregistering the platform pwrctl device in
>   patch 1/2
> - make patch 1/2 easier to read by using device_for_each_child()
> 
> v1 -> v2:
> - use the scoped variant of for_each_child_of_node() to fix a memory
>   leak in patch 1/2
> 
> Bartosz Golaszewski (2):
>   PCI: don't rely on of_platform_depopulate() for reused OF-nodes
>   PCI/pwrctl: put the bus rescan on a different thread
> 
>  drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
>  drivers/pci/remove.c                   | 18 +++++++++++++++++-
>  include/linux/pci-pwrctl.h             |  3 +++
>  4 files changed, 44 insertions(+), 5 deletions(-)

Applied to pci/for-linus for v6.11, thanks.

