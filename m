Return-Path: <linux-pci+bounces-3725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5185A399
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C01C21507
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BA2E65B;
	Mon, 19 Feb 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIJ3kPhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD962E644;
	Mon, 19 Feb 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346301; cv=none; b=cuTq5hpUygisTOXZj21UVh9CTCiwLkpFWyUVusrNg1KQHhZKvLyj5CVTvU/BfF19r6Ji3yG82Bo5RmqMVb5NXG7//nygPYGKEUfm8rhfusj+hkwjQ4ZhlKUlQBhyBkwPPcHRJbDU3mpNIrKCW1bHHnz08E1KRLbBli3WIezq9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346301; c=relaxed/simple;
	bh=2tY2MZjkFTTdw1DjZNPEnmqZhflzeeQAO/A2N+2m5pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP7bE9vhyzu4hA3GZ6feM/mRsBxlgtYtsVl2BmNPycCi+fiKXBf+V3GiZ84p7rKGzI+iLDCqOwFc2JDedDgLzoJN050/yyJtuy1gW392lkCAZvGPEemBs2Z8F3urD369TdlXtLG+6bQJQpM4y84/x+FLxf0TuVJMrRAoL4OrENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIJ3kPhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF95C433C7;
	Mon, 19 Feb 2024 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708346300;
	bh=2tY2MZjkFTTdw1DjZNPEnmqZhflzeeQAO/A2N+2m5pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIJ3kPhZFfFWJQsqCAUgP3SYF7pexh2h3cTq1B1TScLDQJKsHiH3xn5yGNkbByzoz
	 qtuJtysq3MOhCOnD324DOo7J3GCAqLHQ/u2M7oIwzcLsjlzqYQXyN2AKTTJHeKCbhg
	 3Qh1zuU2nRm2RUL/vYX75FOxgzuKspXx+XZaKAuyq66AM0uDUms1PlNa4Q1qzzR8Pz
	 FsHcyJbyCOY5ZeGjA4qHvnL9jawRW7/ZvImwH8yIL4fRJ0rDHbeQjmmh7Ir7dy9usq
	 Jryb+IFM0fg4qGGgg5wAJ2CjI32jkmf1udSE+bFoNqrPvDGskMXbEspH4/8N6Q8nHw
	 3rb6vN7chyMCg==
Date: Mon, 19 Feb 2024 18:08:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240219123808.GB3281@thinkpad>
References: <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
 <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
 <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>
 <20240202073334.mkabgezwxn3qe7iy@vireshk-i7>
 <8a7b63a8-0583-43cf-9876-8a964c8b77ee@linaro.org>
 <20240219102834.x22ggazkmzppsdxc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219102834.x22ggazkmzppsdxc@vireshk-i7>

On Mon, Feb 19, 2024 at 03:58:34PM +0530, Viresh Kumar wrote:
> On 09-02-24, 22:14, Konrad Dybcio wrote:
> > On 2.02.2024 08:33, Viresh Kumar wrote:
> > > On 01-02-24, 15:45, Konrad Dybcio wrote:
> > >> I'm lukewarm on this.
> > >>
> > >> A *lot* of hardware has more complex requirements than "x MBps at y MHz",
> > >> especially when performance counters come into the picture for dynamic
> > >> bw management.
> > >>
> > >> OPP tables can't really handle this properly.
> > > 
> > > There was a similar concern for voltages earlier on and we added the capability
> > > of adjusting the voltage for OPPs in the OPP core. Maybe something similar can
> > > be done here ?
> > > 
> > I really don't think it's fitting.. At any moment the device may require any
> > bandwidth value between 0 and MAX_BW_PER_LINK_GEN * LINK_WIDTH..
> 
> Okay, I leave it up to you guys to decide on how you want to do it. I still
> believe getting the information via DT is the right thing, but maybe I still
> don't understand the problem fully.
> 

I argued for a different issue, but what Konrad pointed out is not a valid
concern to me. The driver may only require _fixed_ bandwidth between 0 and
(MAX_BW_PER_LINK_GEN * LINK_WIDTH) and DT can pass those bandwidth values.

Chaitanya pointed out that this may end up with long entries in DT once the PCIe
Gen versions start to increase (current Qcom platforms support upto Gen 4 only).
But that shouldn't be a real concern if we look at what DT has to provide.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

