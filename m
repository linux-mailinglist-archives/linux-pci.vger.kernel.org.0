Return-Path: <linux-pci+bounces-31837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57972AFFF80
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 12:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1281B189BAB2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8B2D9782;
	Thu, 10 Jul 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8BjSbPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A51FC109;
	Thu, 10 Jul 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144250; cv=none; b=VNmpA1vEXh3Uyx3vt9v85ZA9n74wqQ4kMPY4lngDw7MYiT/uaommN+LF+FMIvTk3XWC/wJEYB6E7UnBJF3+OkZBOB/iF4McXcz4NkU/RbFHsBocj1mIRuIJWut6uDDKs1lEtNriwlPKZ61YSTEd2vFkcGiAfzVfX4LOV/nGXll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144250; c=relaxed/simple;
	bh=U76VKBh/7GQv+j5gpHmYAGV6Z/RI8ugyAsaX8iKw2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itViB9jmKloGH7CY9bjDv9JBqPhpiv/TbbVaQm9vwQjTW+cSH9DlaQoUKOPwHz/xz7zaoE8DuxNfivw1Ovv04n1WX4v+JfuU1ROLOELEN6Uz9+Jq3R/QqKvcZBndvo3ofl4UPsPfiyzGZFTp2W0M091EXdjIIijxhdf3XFNB4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8BjSbPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C862BC4CEE3;
	Thu, 10 Jul 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752144249;
	bh=U76VKBh/7GQv+j5gpHmYAGV6Z/RI8ugyAsaX8iKw2u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8BjSbPexN3Pw3J/0hr69DDRXMjEsyoRw7xtQcuO83Y/21Fh8KGc0i2H1oh/s6Eai
	 sF9TPOHJoRBUPT1booxVByBHXGf8ghAfsIcWmhjdc4M+bKjbvyqGJGmG/9iPUd7aUF
	 Zr+p9zeH6XnUv+8RsTTqB5xd9tkZVlu/gN8enDulVMiD9MrmCPqIumzly4ibm57WZb
	 +eQMYAMwBVa84JaW4PQlcvDgjqrJmtQh9anm3kD12LWftUBJWjS8Jb1B/+iFZ6fy7L
	 bYMTHi8+zNzQysY3sA1Q7WGXQe9KUfLIvfavIQGNPvcbLfwBKr6m4LdO9FctX+QxN7
	 N52eelHZaKM7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZol0-000000008Ko-0AXu;
	Thu, 10 Jul 2025 12:44:02 +0200
Date: Thu, 10 Jul 2025 12:44:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aG-ZcuJXISyIZavv@hovoldconsulting.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
 <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>
 <aG-LWxKE11Ah_GS0@hovoldconsulting.com>
 <4f963fcc-2b92-4a01-93a4-f0ae942c1b6f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f963fcc-2b92-4a01-93a4-f0ae942c1b6f@quicinc.com>

On Thu, Jul 10, 2025 at 06:24:57PM +0800, Ziyue Zhang wrote:
> 
> On 7/10/2025 5:43 PM, Johan Hovold wrote:
> > On Fri, Jun 27, 2025 at 04:50:57PM +0200, Konrad Dybcio wrote:
> >> On 6/25/25 11:00 AM, Ziyue Zhang wrote:
> >>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
> >>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
> >>> replace it with gcc_phy_aux_clk.
> >> GCC_PCIE_n_PHY_AUX_CLK is a downstream of the PHY's output..
> >> are you sure the PHY should be **consuming** it too?
> > Could we get a reply here, please?
> >
> > A bunch of Qualcomm SoCs in mainline do exactly this currently even
> > though it may not be correct (and some downstream dts do not use these
> > clocks).

> After reviewing the downstream platforms, it seems that GCC_PCIE_n_PHY_AUX_CLK
> is generally needed. Would you mind letting us know if there are any platforms
> where this clock is not required?

Thanks for clarifying. I was think of sc8280xp where the downstream dt
did not use this clock (and therefore neither is the dt in mainline
currently). Looking again now it seems that clock may not even exist on
this platform?

Johan

