Return-Path: <linux-pci+bounces-2805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37528425FD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06CD291EEB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875726A353;
	Tue, 30 Jan 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU5q95vO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B606A34B;
	Tue, 30 Jan 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620598; cv=none; b=cBXqHgi3w8fkRaSxh9ysevJz0mflmhqv2TMABPHhKUwXY5hJpquwaWvXYs0pbOJNEo/9cpGJzVuUeMvyGlXFxsHqWMfOMT9pz3dejIhSgnelJTgfBsqztN+7GnX7kxB79++I4RIz8M0/P9cyD67xtkiQ/Dm8qyHtgcLF/2HrKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620598; c=relaxed/simple;
	bh=v489qvkgYg0wbgSdIMBu2Bfp4yEzx5Cxzf30sjZ8BqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKNPjCPv1zQwFtJOfuaaW6ystsS51pEF0Ks5ElmCxaTdcnowZbMZcgMhdD7/unCgSXsdyw+WSOfccXMukHfLY/eo8OQGZuylkvF2WbEoxr6SFsV+LMuWtb2idCSPgvQivtSWOrHk+jKcHm+3x3CuvQHDRW5cGU3fF0gSTwHlk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU5q95vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FDCC433C7;
	Tue, 30 Jan 2024 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620597;
	bh=v489qvkgYg0wbgSdIMBu2Bfp4yEzx5Cxzf30sjZ8BqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rU5q95vOkv05SN8BwXNBW8vlDKa37YodUmFyb78ag5MwtIzrQUaxEZQ09x2ztsqDr
	 slw63v/+K4BR24NBZ9O0eYd5cvKxJgmVwpf3A9ROebbQb3ydOx0J8Z7Zekhj/yeQS2
	 HF+SwApnW2cw7nvhh5p5n8feTR67Jd3YqrpKZfN0SR+fna9I7s+Z8Y9/LYBhkCGLt0
	 xRFE2I8R4CntHeH03iKl2S+uZxswQD8rXCk+l7Un8AlLD0HPLmJa8x/MDOjW457neu
	 x4AX2LxJQBNf2KgUICUZ23WMIcU4+rF5zSjkNNjVtptUj7VcmDRl5K5YERHo2IIReq
	 btUbSfulr7/MQ==
Date: Tue, 30 Jan 2024 18:46:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240130131625.GA2554@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130095508.zgufudflizrpxqhy@vireshk-i7>

On Tue, Jan 30, 2024 at 03:25:08PM +0530, Viresh Kumar wrote:
> On 30-01-24, 15:18, Manivannan Sadhasivam wrote:
> > So you are saying that the ICC core itself should get the bw values from DT
> > instead of hardcoding in the driver? If so, I'd like to get the opinion from
> > Georgi/Bjorn.
> 
> Not really. The drivers or the ICC core doesn't need to do anything I
> guess. Since the values are coming via the OPP, we must just use it to
> hide all these details.
> 
> Why is the ICC core required to get into this here ? ICC core should
> be ready to get the information from DT (may or may not via the OPP
> core), or from driver.
> 

Agree. But what I'm saying is, right now there is no DT property in the
interconnect consumer nodes to specificy the bw requirements. This is all
hardcoded in the respective ICC consumer drivers.

But when we use OPP to control bw, the bw requirements come from DT. This is
what I see as a difference. Because, only nodes making use of OPP will specify
bw in DT and other nodes making use of just ICC will not.

Maybe I'm worrying too much about these details... But it looks like
inconsistency to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

