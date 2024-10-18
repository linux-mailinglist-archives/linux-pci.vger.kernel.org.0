Return-Path: <linux-pci+bounces-14842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEC9A3327
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 05:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A45E1F2251C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 03:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BB153803;
	Fri, 18 Oct 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bRvIxH+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DBC143888;
	Fri, 18 Oct 2024 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220724; cv=none; b=W/PRuNgPkg8tIv5WLrtkbReHDKrE9FqEDDJu76vOqKKJnaEbPKo//SEbA8W7CbQ9p91ByD3K05hy/MzUhDmR1daoOWBROI5ut73vj4gc/Eh4T6uEOjL6dkEHWYIxoXXBTB6IuxzxHgvxO247uyddF8sM2VFKnPwZAyd0ilJ5+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220724; c=relaxed/simple;
	bh=sKd9P8jTOJeM166Iz7PoYor7fm4C5ermi2U42p2utes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdgexnBE9AmBTcR9lrY/NMoHpLnIgyJMHruzKdhHglOWv63uUwj3GVPFLt8sZsm9oUIFA9NRPjd8poRiaK4Nnwwh2zvpNzPbFAGY5CK8XEYjTXp10HpkbgO3ujOq1cTRn4uQ5PtFPLEMFwopG/H6pW6/q10vKNNUOfW0z7jxPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bRvIxH+m; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=i3Cg69Q0bahCHm6u4HeVjWPJfCKMx1F2c/XVlhq5uNQ=;
	b=bRvIxH+mLDVYL+lFOOPYI652Tpor7Q6ii9g9/HVe7Z6JFdf1o2t89u/siQnNCg
	pa5j7dfXWOJRwjnaE7yxwBNRsxeqMZKMQDsHFebUraBdbD3qMji8iz4GsHCaqMA0
	zYV/BmhMCR7BLJPGZjBfRAp8nJ+DMHD90YD6Ki7+wCHF4=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCnjwr1zxFn0dU_AA--.1978S3;
	Fri, 18 Oct 2024 11:03:19 +0800 (CST)
Date: Fri, 18 Oct 2024 11:03:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 2/3] arm64: dts: fsl-lx2160a: add rev2 support
Message-ID: <ZxHP9XEiIMHuv1TB@dragon>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-2-106340d538d6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-2-106340d538d6@nxp.com>
X-CM-TRANSID:M88vCgCnjwr1zxFn0dU_AA--.1978S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhh8ZWcRl-6bMQAAs2

On Mon, Aug 26, 2024 at 05:38:33PM -0400, Frank Li wrote:
> Add rev2 dtsi. Although uboot fixup can change compatible string
> fsl,lx2160a-pcie to fsl,ls2088a-pcie since 2019, it is quite confused and
> should correctly reflect hardware status. So add fsl-lx2160a-rev2.dtsi to
> overwrite pcie's compatible string.
> 
> Add PCIe EP nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


