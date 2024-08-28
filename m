Return-Path: <linux-pci+bounces-12384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BE963353
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE78283CCD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A001A76B5;
	Wed, 28 Aug 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am3bSmvS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C990224D7;
	Wed, 28 Aug 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878788; cv=none; b=COrKHdxxyzJOK0RbsyOj30co2yW/zA7IZvVPUO8IXpX3N2cJTqGZ7x1GwWwGWHNDNzzX+VNDAa5iN0RiERJDRt5Jqb4J6VNeMMApomynyokbxPus6pXrnc+fzbPMLcGTaL5AqykvIczBJQiH9LcJh5/0uQyoAZuCnJi+4+7jV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878788; c=relaxed/simple;
	bh=1/GAOnHCTc9FvaAIyApVEWEmUkKEJDAQPCaFu34QnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jp0YycBDCITc/+xX8A6/zTydTrgsQOcN5S7FdSZsAljGV3xwgDmRR5ar1M4dhSAyd/Tg4ju/XeCN1hGUHohevTEQ3W0XSVfZNpOSF9FDexDrZ+XefW+dGxpk/7j2trl3yYNyENGca7iKhYBCnFz2lQ2x6hQyYbtrW7fES1ZxjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am3bSmvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A434AC4CEC0;
	Wed, 28 Aug 2024 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878788;
	bh=1/GAOnHCTc9FvaAIyApVEWEmUkKEJDAQPCaFu34QnDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Am3bSmvSjXmOD2FngAf2E5bg1pIa/7/WFO/A66SrIST++xJqVJbMukfTGGi1h+/Le
	 uYLIpmTp/IxZ7aBorqs27XbFKCBlhJYihNs99DswCbA1hs5f3KKPDW4LY1qPApS6Nt
	 2CfNaTEmUdqoQ8LJadytY2PKr1VjfXxFU2C/pw0+8J6kJu+rvqncSPSc8/OXYr9LTp
	 Q+ipATiyQMne0dIsEFHN/+7KcvrMuay4aDA6Lq534njSoq8mgTbmg7i0MnMWNQkJOM
	 lBqahUeH9IvRkl/DnyXcyK7OeQUEz+T9NP+ypL9WdWkmkxzZ7tvhQtczidOLpp8PMR
	 mhMpXMcqyxN6A==
Date: Wed, 28 Aug 2024 15:59:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240828205945.GA37767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828140108.5562-1-manivannan.sadhasivam@linaro.org>

On Wed, Aug 28, 2024 at 07:31:08PM +0530, Manivannan Sadhasivam wrote:
> qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> enables the controller resources like clocks, regulator, PHY. On one of the
> new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> on all of the supported Qcom endpoint SoCs, refclk comes from the host
> (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> whole SoC crash on the new SoC.
> 
> qcom_pcie_enable_resources() is already called by
> qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> available at that time.
> 
> Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> qcom_pcie_ep_probe() to prevent the crash.
> 
> Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> - Changed the patch description to mention the crash clearly as suggested by
>   Bjorn

Clearly mentioning the crash as rationale for the change is *part* of
what I was looking for.

The rest, just as important, is information about what sort of crash
this is, because I hope and suspect the crash is recoverable, and we
*should* recover from it because PERST# may occur at arbitrary times,
so trying to avoid it is never going to be reliable.

Bjorn

