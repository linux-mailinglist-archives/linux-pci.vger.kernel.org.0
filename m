Return-Path: <linux-pci+bounces-12731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0A96B77E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8131F260BB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851B1CDA0F;
	Wed,  4 Sep 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnJ9Bzqj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF11EBFEA;
	Wed,  4 Sep 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443751; cv=none; b=X725wPmfhPDbwmRHQTjFeNWPhlW9YD3PkyToQFhLRg6wXWympEyAMV0Cg1PuZTvW0iLderuwqtUosuvGrjrar/oJQii39yaZWz0FTd4uGVGHXBN5w2GhSoAXNgoHoX0Pq/wo/KaT8dUXwyCp/DN1pW5gJ0V1o16n7As3faHnsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443751; c=relaxed/simple;
	bh=EuDZd0Ya7FrnlxmHNJIyAGIIKpdgej/0oZFl2tmBO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AojEIzmlT+S8d5F3AgSDNHDH/gWDhCMRxsxuV6A7shIPAlclbDfY6C5PYHJJyr9TJYqBxPUvN4OEg5cMqZRW6BIUaJQCAL1tauom8+uCtooWCbxN8U4PlbAvoXDMNyE9WiJ/pHpo8awQINTMPX1+VCcFKRQu2Sqbe90u4tn6Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnJ9Bzqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7CC4CEC8;
	Wed,  4 Sep 2024 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443750;
	bh=EuDZd0Ya7FrnlxmHNJIyAGIIKpdgej/0oZFl2tmBO2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnJ9Bzqj4RYCZ9vf9dPFdvK6SEXNfaLlJjoorGOIZuEBUsBE9da1HKpbJrsC+Yj3I
	 RWmHoWsR1yaqCbSSOORbumQ8xYz/u+JfLUn/KIEEkYt59RITwu2aQAKQUmR3doW6+c
	 LLJgkV/tbK5msO2lmTqCZjgSY87pWUVsDFReimQ+cRKDQ6hAR6Rkw0x2RzsHA5umrp
	 Hypz8KqoYhS4L39wzqwGnE6NOKfls7VrnqhBCT6idvxKuB/nKK+V9fLWcXE8FE4yCU
	 IbTAwS3RikXTJ9EsMH1e0SjZzIoc+XmRWDjDTBL3GVjXoJVmZsIjQOe+iVYF9pb9IL
	 M0T3dSbjXZdrA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slmkB-000000002Fn-1v3g;
	Wed, 04 Sep 2024 11:56:07 +0200
Date: Wed, 4 Sep 2024 11:56:07 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 0/4] PCI: qcom: Add 16.0 GT/s equalization and
 margining settings
Message-ID: <ZtgutzysJ-3GeSDE@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>

On Wed, Sep 04, 2024 at 12:41:56PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> This series adds 16.0 GT/s specific equalization and RX lane margining settings
> to the Qcom RC and EP drivers. This series is mandatory for the stable operation
> of the PCIe link at 16.0 GT/s on the Qcom platforms.

> Changes in v6:
> 
> - Dropped the code refactoring patch as suggested by Johan
> - Added 2 patches to fix the caching of maximum supported link speed value that
>   is needed to apply the equalization/margining settings
> - Updated the commit message of patch 3 as per Bjorn's suggestion

Thanks for the update. This series fixes the NVMe link errors on the
x1e80100 CRD:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

