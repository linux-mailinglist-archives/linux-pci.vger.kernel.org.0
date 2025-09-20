Return-Path: <linux-pci+bounces-36568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF9B8C164
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B927A80707
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7A1A0BFD;
	Sat, 20 Sep 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdMSWocC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DE34BA52;
	Sat, 20 Sep 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758353678; cv=none; b=I0BEx0FXHwm43GfNyOCU1OjDg+rS42ScySc4COn+Xengg2sc0nTFg4/KFh6RS671w9CGXiP3QAE3NTmWYYL821YGxdHhgv2ccEvGZWrUuJbGcsPgWsXl+quTkzSNaiB82M6HrTgWeN3oJ9xquk+YEz+Y8lQpNzR26WrSEAgLY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758353678; c=relaxed/simple;
	bh=JtIlPe6rz/IHPgJuGnOZzbz0njTxpzBV+gVWBopV4BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5EwfAUaAxU4TVqDW+DpavRf8i8J/iCtDMte23jEOyYFHbtYDg09zh51gMwD9u8EL/1nNKT0j+fLMU8Ujw+s9dyuX3Hu6ePOGhu56hssRjCrLX6fAgUW43qvclRGMCYinusVu4IESHPWv9AT+e/2gYwyNwZDCb0g1irrWseOXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdMSWocC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DFC4CEEB;
	Sat, 20 Sep 2025 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758353678;
	bh=JtIlPe6rz/IHPgJuGnOZzbz0njTxpzBV+gVWBopV4BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdMSWocCNpc+vEIBPvcu7BtVdSgtQX370EVlr9nt99csMhrwP4WWnXf8844GgLduA
	 Dqfm5gfq5sZW1qqHDAOhoVIsHeaD4at3pL7+l5vcr9uUC/upchpKGDDWPd832zy9au
	 /my/FJqOOKQGkgL4CNPLoQ+wclr9SMqeQtDxNTQBPQrc1RuatWlPsOLPBc/b+TWPi3
	 f2Xmzc6WF9uJ3h6T5zwUcC1PFeqqy0bYf6uNMpAWWH6il3GFpWYiptkBoodftgHW5t
	 i9Dsgbo99YixfGdiYcjqd4pGbFs6G1CRu3z3zANap9Cozjjx+h7QD3u39U5p+SqRof
	 OXvXP4+Jl/OVg==
Date: Sat, 20 Sep 2025 13:04:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: imx6: Add a method to handle CLKREQ# override
Message-ID: <wbfsxrvwb4ky3irnwm5vohmwyek3c4uskxg3dnfzrfadyx4aay@5udf6eht3cdj>
References: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917093751.1520050-1-hongxing.zhu@nxp.com>

On Wed, Sep 17, 2025 at 05:37:49PM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock.
> 
> But the CLKREQ# maybe reserved on some old device, compliant with CEM
> r3.0 or before. Thus, this signal wouldn't be driven low by these old
> devices.
> 
> Since the reference clock controlled by CLKREQ# may be required by i.MX
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x old cards described above), force
> CLKREQ# override active low for i.MX PCIe host during initialization.
> 
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card in this case.
> 
> Main changes in v2:
> - Update the commit message, and collect the reviewed-by tag.
> 
> [PATCH v2 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
> [PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ# override
> 

Patch 2 is not applying on top of 6.17-rc1. Please fix it and resend the series
(along with the CEM 4.0 citation suggested by Bjorn).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

