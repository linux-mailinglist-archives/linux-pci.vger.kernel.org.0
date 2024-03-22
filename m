Return-Path: <linux-pci+bounces-5013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CC887099
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77308284CF9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811C5FF0F;
	Fri, 22 Mar 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs7KWuJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBF5FB8A;
	Fri, 22 Mar 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123871; cv=none; b=BCFI8LA2Eds+0EOT7RG9q0JUdoUfcoUc15z8WnSVHS7BD3HimOUx7VvZYb0kGWsVUu1FFrfsGkFsg+34NhVfRQPrGqhcsxMeYq/48a+YBj0iaGVxJFFSji7d26nr4zQqrl2ByBZugrOZ82l3GLIHy2cpiadq2MndKRdl6hZAric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123871; c=relaxed/simple;
	bh=cbEyAWa2LSK/qrGis7CoFgde+V3pHY0E7i1PDMGEg3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maPPts3v4YTSXSS+ZiDtAsGy6G2gzfDR+IoEXX4ZzmRREigTz0noY1u6XHDPcmqIWzvXrfDouAIRFhT4znIc7Pjm2Js2tXSsoeBl2Norzs9D9Voor+PpmBSOOKwBYzQ/DOh3H5oHyX15Z/NPtZ7vtMe461LZwhD5YcvT3Et9YJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs7KWuJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E0C43390;
	Fri, 22 Mar 2024 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123871;
	bh=cbEyAWa2LSK/qrGis7CoFgde+V3pHY0E7i1PDMGEg3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs7KWuJ474sfmjEGkj5Ota4cPC0ClsdDEMFZghHDSxOHYY7kfwD8zcHuwy5lRYO/X
	 dPYlMicPkeKNmTAbQdkDW3OrPniLjTGZw95jZCYjz4Jk4fRXfH482TtTskCB8lkuE3
	 pYd1pYwsdsnrtJ6O7PhqnuWSxlRdg0AuZIgR0ng2j5ll55Gy3mG3UEhVQfoJ7klwu3
	 cGHE8blhmHWBKJ9JdVoVLlngKFWQC8WYdIy1+t/JvatnkCe7yC9MPeThUxDdgbpOcd
	 z0RCMXnDCglGvr5N4UE7DljNSRjV4AavXerplkxOLhov6JrEEdk1WO55iAD5BRoezm
	 2zA+G1z+/ka6Q==
Date: Fri, 22 Mar 2024 17:11:05 +0100
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
	linux-tegra@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH 11/11] PCI: tegra194: Rework {start/stop}_link()
 callbacks implementation
Message-ID: <Zf2tmbGJGq3Lo6W1@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-11-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-11-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:50PM +0530, Manivannan Sadhasivam wrote:
> DWC specific start_link() and stop_link() callbacks are supposed to start
> and stop the link training of the PCIe bus. But the current endpoint
> implementation of this driver enables/disables the PERST# IRQ.
> 
> Even though this is not causing any issues, this creates inconsistency
> among the EP controller drivers. So for the sake of consistency, let's just
> start/stop the link training in these callbacks.
> 
> Also, PERST# IRQ is now enabled from the start itself, thus allowing the
> controller driver to initialize the registers when PERST# gets deasserted
> without waiting for the user intervention though configfs.
> 
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

