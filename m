Return-Path: <linux-pci+bounces-6426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E08A9AB9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433B01C215FE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADF1635BD;
	Thu, 18 Apr 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5hQYihi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501F141995;
	Thu, 18 Apr 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445194; cv=none; b=pSwqFhk/fqIy4uP8g4eD3o494XH3+Li8fMkD1ahVgQ5yeLmhcJIPuoecjZ16ynR6JcLksWrUMldTcbybrOORJHQ/82Vmm9UxBIyUl36UuEMIkvZDZbSJUEc8VTQTCHtmUL1aVpLnvKLq4mo3gbG38v5CNquUDxZP5Jb8yNP69Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445194; c=relaxed/simple;
	bh=h5+sr5kDGEE//NFdWMcxO/f4g8tK/UG2WGyXhAMaHJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTzQWKA7+BRCufJFjctJsIVN7fwVRt+IY9fMYJG0wiEN0oDAo9yFba0b/NcJr/4bg10SdycbaFlAOuFTCE6Rri4uteXW6/l57sB20eMSmx4tTgp5oFCU7LS4CSQGPu2unvn2PjFPZWK09S2t0QUVYBkfrJhvJrdWpGoFfGdSwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5hQYihi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B124C113CC;
	Thu, 18 Apr 2024 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713445194;
	bh=h5+sr5kDGEE//NFdWMcxO/f4g8tK/UG2WGyXhAMaHJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5hQYihibVQPcA2K0cB1A74OHiTQJt3Z3TDnFkzkxRBtyrnrX1F0L9gBsZyDp64c0
	 z2jgOyN/QLrnnXZyaRxoH6P2oNuMbbhoUXCL8Z8fu3t1qbjBmDOrrEGY4baUEvB/So
	 EfwrQMhHLYCCNld5NTd3ySwVRfQd+IDoiI1M4r/EU5w+1cgNKvTtW6Kec58BwgNsER
	 0EPnFEEAolz99Ck2gAhaoTZqXDCDgkKKzy8aDFk8L3+9ABnh20SeGW80YZpYRyaqpC
	 83lXVPXErEU/Zjnfm5neW57C2CVBdbxNfGjTETE2l7NZyTGl9QGTr50OzqR2YnWw0X
	 qcEDmYinGbl0A==
Date: Thu, 18 Apr 2024 07:59:51 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-clk@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-phy@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe
 controller
Message-ID: <171344513750.1014595.13170008831740751556.robh@kernel.org>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-4-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415182052.374494-4-mr.nuke.me@gmail.com>


On Mon, 15 Apr 2024 13:20:48 -0500, Alexandru Gagniuc wrote:
> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
> The difference is that the "iface" clock is not required, and the
> "sleep" reset is replaced by an "aux" reset. Document these
> differences along with the compatible string.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


