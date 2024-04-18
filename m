Return-Path: <linux-pci+bounces-6436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3532B8A9D8A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EB92837F1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE76168AE9;
	Thu, 18 Apr 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW4/11Zc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08240165FCB;
	Thu, 18 Apr 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451751; cv=none; b=SD7VzRQ4G2zsNOlWu8qtdqWoDdKWTNhZSvhlW5yBusAhB4nn0irpe7D19UHuY3W4ECrLfXfhKisA4l+URfiyKDeyNmsdgE+nEYOZ5Ym5Bna51yrpNHL+tX5UB5PE9V0ewV1xSB6oyaEgmUiYndivLnotCveKk6wamx7GhANCgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451751; c=relaxed/simple;
	bh=rDbUab31w3dB1JmzdTeQ6kvukXa2XZnDAfrUgOMw7rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz1Cpw0hm6Lmzc24dp6wJm0QPP6R81yy9DPcQZ7g7y+pjZiqdJJkBwl1PyHssygmex0GUQDJX8oSw2VwBq9Xup8JXsyf4UR18sJpBLsKrXlHeC6dCN36JdvFeKQ6hojx1tLjMtkjxygU33ySqkH/yqajr+TpO92zfHknWu1dwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW4/11Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA2CC113CC;
	Thu, 18 Apr 2024 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713451750;
	bh=rDbUab31w3dB1JmzdTeQ6kvukXa2XZnDAfrUgOMw7rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW4/11Zc0MAOdJOuCp9c+QFLurWnhvoH2qdgj7xHlsJIHUetIlBa92h+/4VhJcqPX
	 eQzaeTWsxSZFVdot+9Se00mUeADHsUAr7XFDyPwssQnvlkutqNzlTMBgeFvqrDdIxz
	 kSmctl6EFgw+4pX+ESbHbK0khZlOvpirfg8NnEUQq695oKHBXLcoic6v7vbLVDjAhe
	 AmsJGALJDKYg018EenIyUy9Zr4IoCRQXIj3ibuLRYbP+T9PI4XX5ZjibvHYUp0Fsn7
	 r8FpEizpVvGQiQSCdqilFsOn7DSjMHexvtO+D3VLl4rcvvZdCpOwli24TVga1J7gOY
	 MQaHdQl6UKf9w==
Date: Thu, 18 Apr 2024 16:49:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <ZiEy4EVcVpUry9qn@ryzen>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
 <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>

On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> BME which stands for 'Bus Master Enable' is not defined in the PCIe base
> spec even though it is commonly referred in many places (vendor docs). But
> to align with the spec, let's rename it to its expansion 'Bus Master
> Enable'.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


Outside the scope of this patch/series:
Do we perhaps want to add a bus_master_enable() callback also for the
pci-epf-test driver?

In my opinion, the test driver should be "the driver" that tests that
all the EPF features/callbacks work, at least a basic test "does it
work at all". Other EPF drivers can implement the callbacks, and do
more intelligent things, i.e. more than just seeing that "it works".


Kind regards,
Niklas

