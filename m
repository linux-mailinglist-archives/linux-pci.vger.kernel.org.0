Return-Path: <linux-pci+bounces-27193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F089AA9BA2
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7AB167578
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB9259CBD;
	Mon,  5 May 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfDNVKr1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E31BA49;
	Mon,  5 May 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470268; cv=none; b=jW4P/FUcyqSAW2zrpSSLmmejRhuuyRdKciMdNUcLD3c0mj+6OE4OmEppLvD+ppOc/EKgTVEt3hETXat9bjlgxj+2Azv++mRng/s+/ptr3plnparIKhLsuP7n9tqyy3KLWQDeZmw3PsQBMZ/x94TFERI5d4zc4XHaO4m+H5geJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470268; c=relaxed/simple;
	bh=9qPKb+Gua9cbPCEVlARsehJnRTW9bGkKm5SEPQuKcrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yg0bPIwrLR7XW6iVzX9Vnoi4Ju7IZ9oKcyiAqPL10htCLZCkTjnHD5ip2oUUu5O8/OMmaIJZKiF0mWTtd45HE9lhAnaN9r5yVGy4NXaTw0KFeM4xlhIHfJzSxZHzHWKmYNTFH8od2P0mNNoQFvp8TTsvKP1wdCCqUt4Q/IsvHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfDNVKr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C491C4CEE4;
	Mon,  5 May 2025 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746470267;
	bh=9qPKb+Gua9cbPCEVlARsehJnRTW9bGkKm5SEPQuKcrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AfDNVKr1YOX32jmVJIlKkt8WCJN0cjmngoh685Cnwd273gFdj6NGrBgwIPqGEMGGa
	 fb9RjBo3z5ey8nVhJchVKT1DcnCvKByl1OivLyOahnUKqqHoNrM0/ndzv7YXBiUpdL
	 sYyahSlnBCZJfxdvO3RHArx24qiEh2qaXf/wugM1O1Pf4rdIZvxLBZwwToIayS0Yt2
	 3l10enOSVoagw9gB9JSX7OUMZMyT/tfpvssenlWGBQxwWbPmV8CUTp12agPJm0dnJy
	 8PEgJP5zgqoS4iWMafzXyTrbuIfXXTplKVKh0I/58VogMssSbWrwhKQ1rzEoR77wfp
	 anuDQOcHFB/5w==
Date: Mon, 5 May 2025 13:37:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PCI: dwc: Pass DWC PCIe mode to
 dwc_pcie_debugfs_init()
Message-ID: <20250505183746.GA989979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pcie-ptm-v4-2-02d26d51400b@linaro.org>

On Mon, May 05, 2025 at 07:54:40PM +0530, Manivannan Sadhasivam wrote:
> Upcoming PTM debugfs interface relies on the DWC PCIe mode to expose the
> relevat debugfs attributes to userspace. So pass the mode to
> dwc_pcie_debugfs_init() API from host and ep drivers and save it in
> 'struct dw_pcie::mode'.

s/relevat/relevant/

