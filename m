Return-Path: <linux-pci+bounces-35011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD8B39DF4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A7618947AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BE30F950;
	Thu, 28 Aug 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrHdgpmx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43D86337;
	Thu, 28 Aug 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386012; cv=none; b=s8T6e5W5PBkiY6j9XX+k1KzrVL84MtCdRmzoYqBKLroRpkkR34zCKpREyW7Q16Bzitge75nLa9mlIqUG0UX+X6Gyb7iOnS2X1iWdlKzWpSACNIemdnsRvsbQpG8dz/1DHxw43kJxB6OkyXubfZ0pRTZx/7FD8+b4RVnKFoqxCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386012; c=relaxed/simple;
	bh=rX0j8rIu7l1wKKVnMUgdtQN5WgVXsm2ecMpja6Lgwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO8qxoE/rhV1pG1blCeceqf0OFBWcO4KoV7aP4l7E3Vww3ZG+rvqb7c2q1bve9gPM0BK5i346tdUuedHAcFnPvNRhiOYSJ2twpqIGnibwSFMmmG50QZQMRZjyJgAlq2nAFRLQShVcSpExnjvBtZUw0jpoWd6cYcJb7moEMTiLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrHdgpmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F0EC4CEF5;
	Thu, 28 Aug 2025 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756386011;
	bh=rX0j8rIu7l1wKKVnMUgdtQN5WgVXsm2ecMpja6Lgwos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrHdgpmxiEiN799FqNTj74ysbOc87fJ3Jd97uGB8oKnEXqJR4K+cmLP0lwF/NktKQ
	 ORQ4m7i57lSYQZvbvfZEpQUHptwdYHXlOKTOfAEuvqHnKaSRQmWIrADPICVvfnW/zm
	 J8koj+uCjYo9XzRA5Bm7tphKL9k/EyA7jOrxaEG3IgS/9qV11iGXSmo2hWCM15JN8G
	 ffHQK57wBNPG0liccYzGGyrgOQBUoFteB13Jq0Whnw5n4Z6XEaLyjISincIwW4E67J
	 fTvQFuNOlDZ0Urab+n3NeVEzvRK6emPQFghhXw9cp0Az6jZdDS+TB9yFckTJzwNciY
	 P53urWk7SYuAA==
Date: Thu, 28 Aug 2025 18:30:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com, amitk@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v6 7/9] PCI: Add pcie_link_is_active() to determine if
 the link is active
Message-ID: <zzrgt2dgkyap2dacmh4afg7yf2jrwohg3qkocgep3shehnzpli@4jggy6ged6pe>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
 <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>
 <aLBMdeZbsplpPIsX@wunner.de>
 <r2bhgghyunfcy5ppjcvxm746kzh7vyhsnbphlw4pj52wxtuxru@qzy7earmlnjf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r2bhgghyunfcy5ppjcvxm746kzh7vyhsnbphlw4pj52wxtuxru@qzy7earmlnjf>

On Thu, Aug 28, 2025 at 03:48:26PM GMT, Dmitry Baryshkov wrote:
> On Thu, Aug 28, 2025 at 02:32:53PM +0200, Lukas Wunner wrote:
> > On Thu, Aug 28, 2025 at 05:39:04PM +0530, Krishna Chaitanya Chundru wrote:
> > > Add pcie_link_is_active() a common API to check if the PCIe link is active,
> > > replacing duplicate code in multiple locations.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> > > Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> > 
> > I think the submitter of the patch (who will become the git commit author)
> > needs to come last in the Signed-off-by chain.
> 
> Not quite... The git commit author is the author of the commit and
> usually the _first_ person in the SoB list. Then the patch is being
> handled by several other people which leave their SoBs. The final SoB is
> usually an entry from the maintainer who applied the patch to the Git.
> 

Still, the submitter's s-o-b should come last to clearly represent the history.
This patch was initially authored by Krishna, submitted by two other folks, and
now Krishna is again submitting it again.

So even if it results in dual s-o-b tag, I think it would be canonically
correct.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

