Return-Path: <linux-pci+bounces-5293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F388F0C6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F4429B9C2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8115250F;
	Wed, 27 Mar 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYwpC0X9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20F152186;
	Wed, 27 Mar 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574454; cv=none; b=nAz53bBMFZCvDLKaX7KwUSUfz8P0p1Ohww9AB49HmvSd5dQJKYXDcv1zddnDiez++Qj8GmJZtcgaZig9O0eXiTMdOzCpvxxSh/NUqo2TwWgzJEjEIz776wqN7mF7/768NRHuXrR5RiaMt5i3FTclPUC5IInXRvJ7W4it1KdeOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574454; c=relaxed/simple;
	bh=D5zfoZyNAHiU01f0IN7nybIm6z+xp2J38cVji5chQ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ev+ZyuO02o18knTO558UZgArBXsHATPR3UqO3vyqfAY35bofI76cZcbb80ULqeB16wiqcde/yZjntvsVvrVAvyeC+gzOLNb7SVPciBBIgK91v9nHgd6tPpRBiFsO9uq4/4fYZvsL5DxHhCU3FXFsblOYvKMvQ0lDd98bun4Is0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYwpC0X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A448AC433F1;
	Wed, 27 Mar 2024 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711574453;
	bh=D5zfoZyNAHiU01f0IN7nybIm6z+xp2J38cVji5chQ9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bYwpC0X96MMRIt/9lfT9dx6aeuytZZ6wAdmJWoLdBTvre30XxgynZEdIZtiawCzdc
	 U9rBig/VaN8oVcKdPNHxJlpy52p/61wwOXAmxjSfza67MIVX/9X0dvqqNMIKmqcoC3
	 fW+Lii2btNM2Ub/DqRw3Cc5HjpiKF8pcTIrHIw+8uvitYVi3oIuS97vMoexYNPRUlG
	 H3D7/P73nFk+2BYuXIFZHn8CUnIWsHEwVhNVRWzOyaqug/Q59YWK6YFDfBqr50FEPc
	 GWJGQ4ZQUDPjw7pOZptVjOGqOB8+L7bp7ScOhSmpmsB+dv9ryjYmOsdNKds8/1IkfN
	 XDdUuYLGE++qg==
Date: Wed, 27 Mar 2024 16:20:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v3 2/2] PCI: qcom: properly implement RC shutdown/power up
Message-ID: <20240327212050.GA1538555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-topic-8280_pcie-v3-2-ee7af6f892a0@linaro.org>

On Wed, Mar 27, 2024 at 08:49:09PM +0100, Konrad Dybcio wrote:
> Currently, we've only been minimizing the power draw while keeping the
> RC up at all times. This is suboptimal, as it draws a whole lot of power
> and prevents the SoC from power collapsing.
> 
> Implement full shutdown and re-initialization to allow for powering off
> the controller.
> 
> This is mainly intended for SC8280XP with a broken power rail setup,
> which requires a full RC shutdown/reinit in order to reach SoC-wide
> power collapse, but sleeping is generally better than not sleeping and
> less destructive suspend can be implemented later for platforms that
> support it.

Second try (first at
https://lore.kernel.org/all/20240212213216.GA1145794@bhelgaas/):

  - Capitalize subject lines to match history (sorry, I didn't mention
    the first time)

  - Drop or replace "properly" with something specific

  - "... minimizing power draw while keeping RC up at all times ...
    draws a whole lot of power" doesn't quite make sense to me

  - Reword or explain "power collapse"

  - No COMPILE_TEST provision (maybe it turned out to be impractical?)

  - Magic delay numbers below with no citation or explanation.  Even a
    short comment could be a hint about how to verify and potentially
    change in the future.  A #define for readl_poll_timeout() would be
    helpful as a place for a comment and because the name could
    include "_US" to show the units.

  - Add "()" after function names in comments

Bjorn

