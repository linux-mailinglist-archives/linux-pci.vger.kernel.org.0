Return-Path: <linux-pci+bounces-35879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896DB52B35
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 10:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5850916E7BE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7E2D63ED;
	Thu, 11 Sep 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fuDdhKdr"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B82D5952;
	Thu, 11 Sep 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578197; cv=none; b=iev93yJxQKzqWWJ/SdZke6NMNIU69yNM5l3JEaK10eorGeyCKvXjbkERNGSRFblLu56KNguipb8aLhGZu2j7msYe1LzE8KUffwB/Mr0ur03EVO+J0vBNDytXvwB0WB51JIf+oz6RngVKbUherO4oOV9d0VgXYK18A618n0wvg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578197; c=relaxed/simple;
	bh=x352PQuhLLNf6YiSW+jdH4w7Z+cRMhcTOsK7TWAibzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDDRHuTdUBdJ6djLsL9O9tk+H2aRT8XsDlCeyVMRwvNNK5p+7mrGif0rqtKVmYV/Lhd21+7y48oZSPFQBNoKlFEnx9/DN+afns6xk6VgNOZncHgvfVfM7Uuj6OiZCkRtdfTj7IldqG9etlqlhelcdCtm9HsoLoaeIaX45upn98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fuDdhKdr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D2F3E21AC3;
	Thu, 11 Sep 2025 10:09:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YH6VOlBShjIH; Thu, 11 Sep 2025 10:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757578193; bh=x352PQuhLLNf6YiSW+jdH4w7Z+cRMhcTOsK7TWAibzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fuDdhKdrSXxaYAPHhpfiXcmtnT926GU+qcEojSTORsEPqoel76uoRXDdpxMUdccPM
	 3UmdTwgzFvn60ZXhAX5BywthCQXxvmGImelUv6ZaGfp4nuXYtsNUqNo8xTm5IOaW/G
	 EcbiT9DdgSXEVhIS9WGpf98wG64U67QT8B7VVxMN8DE6pWrDJ9/5Xy7s1dW47IlxVB
	 L3LFYl+YqsPlv92PV+veJTj17TIsNZNfjgnGlwxZJFlvduseMiq29W9PL005kAdSFG
	 iubM+kckz5QPAUknYQYpa4MG861jZsjXrJw9pRC441mIjRsyqXy+o0QVVZCfuTq9ci
	 JuUyGgUggRtSw==
Date: Thu, 11 Sep 2025 08:09:33 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
	kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for
 RK3528
Message-ID: <aMKDvcbJ2T-QNYxw@pie>
References: <20250906135246.19398-3-ziyao@disroot.org>
 <20250909125029.2553286-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909125029.2553286-1-amadeus@jmu.edu.cn>

On Tue, Sep 09, 2025 at 08:50:29PM +0800, Chukun Pan wrote:
> Hi,
> 
> > +			reg = <0x1 0x40000000 0x0 0x400000>,
> > +			      <0x0 0xfe4f0000 0x0 0x10000>,
> > +			      <0x0 0xfc000000 0x0 0x100000>;
> 
> Aligning the address for reg and ranges will look better:
> 
> 		reg = <0x1 0x40000000 0x0 0x400000>,
> 		      <0x0 0xfe4f0000 0x0 0x010000>,
> 		      <0x0 0xfc000000 0x0 0x100000>;

Thanks, this makes sense.

> BTW do we possibly need this?
> https://github.com/rockchip-linux/kernel/commit/e9397245c4b1bd62ef929d221e20225d58467dc7

I'm still unsure its purpose, but am willing to adapt this change. See
my reply to Jonas' comment.

> > +			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
> > +				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
> > +				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;
> 
> <&cru PCLK_PCIE_PHY> has already been defined in the combphy node,
> is it repeated here?

Yes, it should be managed by PHY instead of the controller. I'll fix it
in v2.

> Thanks,
> Chukun

Best regards,
Yao Zi

