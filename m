Return-Path: <linux-pci+bounces-2870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360C8439D2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DBD1F2B993
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764CF69D15;
	Wed, 31 Jan 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqYyOtWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F388605DD;
	Wed, 31 Jan 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690818; cv=none; b=Jpmj7Rs8fzpzve2n2GCw+Ea52tp+bdFTi3lBrrwCu/fWd9a4t6MvmcqIRkilsH2fpmaIYv+hi9cvCG/Am/d5a2fLQtPrihZr3Hu3qn3JBIzqSin3v9gFs0B7+qAveUmk4IuR+GORs3GNHRmr6xyxxGDHSUcwqcDOHhnntxR4UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690818; c=relaxed/simple;
	bh=4BkvKFgglVdCeGCFuHgP4W0v2mzK44qTzIo31u8u7+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEpazUu1yI0zqMeFwphBwb+mNsdxaSphcSEL3JQCNs2lcD6Bx/GMxIh3JPTd6fmwmBlWPfjG8/W5ms3MTQ/zP+/PDZMb3pDBZdd9WTOQ4jXtqmm0tlM2pvHmzrTLQZk/aMYo8GdB3hwXG0Nlx5peLgIOZIY4Tjt/Bw28B9MYEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqYyOtWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632E0C433C7;
	Wed, 31 Jan 2024 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690817;
	bh=4BkvKFgglVdCeGCFuHgP4W0v2mzK44qTzIo31u8u7+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqYyOtWzgUP5d3v0ololIBtkDRw9WWO09sd7gzCIIZgBxAVy9xat/jVBxOlXH+Ota
	 YllfHjS+fywz95pELreHMdcRlqvYFz4jsazUgYcpK+JUOomn95jfjK2JzWKm6LhjNF
	 Sw3frW+HAnotWiExQZFAHpvynylQmuOMLTnCWCw/JEPkwWco4Lk/KNihcL57pCHTwi
	 yQv9czAHewVkFrRyByVCT4EgG8MlFLQF8x664CKTKg2PXEClUz0pSurPWpB9YnUqui
	 nPxYK89diN8aDA5sgV5J6Anwow34s92tz/Dz6OAyi0s0exKKSK5qWNNnYx3HU1Fm55
	 kJu35LRJzFDoQ==
Date: Wed, 31 Jan 2024 14:16:45 +0530
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
Message-ID: <20240131084645.GA3481@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
 <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131052335.6nqpmccgr64voque@vireshk-i7>

On Wed, Jan 31, 2024 at 10:53:35AM +0530, Viresh Kumar wrote:
> On 30-01-24, 18:46, Manivannan Sadhasivam wrote:
> > Agree. But what I'm saying is, right now there is no DT property in the
> > interconnect consumer nodes to specificy the bw requirements. This is all
> > hardcoded in the respective ICC consumer drivers.
> 
> I thought there are a lot of users already in there..
> 
> $ git grep -i opp.*bps arch/arm64/boot/dts/ | wc -l
> 864

Most of the hits are from CPU nodes... For some reasons, peripheral drivers are
sticking to hardcoded values.

> 
> > But when we use OPP to control bw, the bw requirements come from DT. This is
> > what I see as a difference. Because, only nodes making use of OPP will specify
> > bw in DT and other nodes making use of just ICC will not.
> > 
> > Maybe I'm worrying too much about these details... But it looks like
> > inconsistency to me.
> 
> Right. So is there inconsistency right now ? Yes, there is.
> 
> The important question we need to answer is where do we want to see
> all these drivers (specially new ones) in the future. What's the right
> thing to do eventually ? Hardcode stuff ? Or Move it to DT ?
> 
> The answer is DT for me, so the code can be generic enough to be
> reused. This is just one step in the right direction I guess.
> Eventually the drivers must get simplified, which they are I guess.
> 

I completely agree that hardcoding the bw values is not the right thing, but was
worried about the inconsistency. But anyway, I hope either ICC will also move
towards DT for bw or we will convert all the drivers to use OPP in the future.

Thanks for the discussion so far! It clarified.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

