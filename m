Return-Path: <linux-pci+bounces-8346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A007F8FD46C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0281F22BC5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D67194AEF;
	Wed,  5 Jun 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnqcj30/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2425777;
	Wed,  5 Jun 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610171; cv=none; b=o80GSQAOKtcfzXjvTWIzF89UBxAlgvlYHlN3V/jmmAxsktUBMl1XWam1vOZrolvKuLeR3LgMecDyKr6kz+espNNjnsOwWScdGKCCK1zjeJMnL5yd2GTQoxUISLLGPQrgESYwkTyYS/LYHbTxVj21Y22Us75EWY4pK5TiGiMCz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610171; c=relaxed/simple;
	bh=5hTZDZgWwowr+2AQ2lcFfI09QAJ6OolISbaea+hj9pE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ilYU4JRaUVBmwM/6Vam/wKJ2q9fl6BD/RmatS2orjQRouE/L9+51+jTqqZpP/ItmItU48O4RYKAiIKh7FaKvgz/Qi/F0EOE3P6XX0tYd81pag1Pps0pcMCHT6dBDaCv5Y/3clgTO57jvOM+pX7UWYSlbCnsY2xMiRJ3UGZOFHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnqcj30/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6DAC2BD11;
	Wed,  5 Jun 2024 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610171;
	bh=5hTZDZgWwowr+2AQ2lcFfI09QAJ6OolISbaea+hj9pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bnqcj30/lc0LZwOprhljD/nn9cHX4h+CxuFrtg+3wNCxZqbE4KNaSShp3BSJfNsrX
	 8Om0TR4a851Jnx4sr6WeulZ1ygwYBhq+8fpwQYeOT2yX0NxUnJlvVqd9SC/69ZR6Da
	 mF2r+gz2YlF4Sd9esbhyIESf2nfDkiqnD/1BOh+H77meLY5WCkSBNxv5PCdk5G/T1+
	 YhINXIUoZZxPj3hC/wsLU0NsCss/84TLwLEX4bhUw5V+Z0kdrlb85ZVrWvvhgP03DS
	 +6WyOQ+FMOvX/+IX5YFDKkSvw0SBqw43PAhtMiYW1zG6ucIIoCk5z9tLO2ab+2PyH1
	 qGJkXclR+OZhQ==
Date: Wed, 5 Jun 2024 12:56:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
Message-ID: <20240605175609.GA768239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf9SDwo+RzEF8d=2Si3-KQVT_Xf8ew4k6+FQAyvOS+EvQ@mail.gmail.com>

On Tue, Jun 04, 2024 at 08:24:34PM +0200, Bartosz Golaszewski wrote:
> On Tue, Jun 4, 2024 at 7:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, May 28, 2024 at 09:03:08PM +0200, Bartosz Golaszewski wrote:
> > > Note: I am resending this series in its entirety once more for
> > > discussions and reviews. If there won't be any major objections, I'll
> > > then start sending individual bits and pieces to appropriate trees.
> > >
> > > Merging strategy: The DT binding and DTS changes are a no-brainer, they
> > > can go through the wireless, regulator and arm-msm trees separately. The
> > > bluetooth and PCI changes have a build-time dependency on the power
> > > sequencing code. The bluetooth changes also have a run-time dependency on
> > > the PCI pwrctl part. In order to get it into next I plan to pick up the
> > > power sequencing code into my own tree and maintain it. I can then
> > > provide an immutable tag for the BT and PCI trees to pull. I wouldn't
> > > stress about the BT runtime dependency as it will be fixed once all
> > > changes are in next.
> > > ...
> >
> > > ---
> > > base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
> > > change-id: 20240527-pwrseq-76fc025248a2
> >
> > What does this apply to?  I don't know what 6dc544b66971 is; it
> > doesn't seem to be in upstream or linux-next.
> 
> It's next-20240528 but it also applies to today's next without
> conflicts. What do you want me to base the PCI part when resending?

For PCI, we usually apply things on topic branches based on -rc1, so
that's the easiest.

