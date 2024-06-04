Return-Path: <linux-pci+bounces-8257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8D8FBA72
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D907D283154
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57B149E03;
	Tue,  4 Jun 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAqA3qqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA113C9C7;
	Tue,  4 Jun 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522267; cv=none; b=C/mN1BjNIFMYbBSiFRjDxE1PG7DHRJArtsNVI8muUoJpZsiqQzf/Rp791IGgWxTJwIuU1VOln/BeFUIE2z4ifigH3eVdyNXC5WJnHvW+rRv8nMEg43ibGUDq35CBNsgJ8ixaCUq66vLOSByK2qFFNDywl0dvoNlYvh0LgptL6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522267; c=relaxed/simple;
	bh=MQO9fA2pjCBtJWAIS8fIzWfvpeJKsZKwiMGN9E5r8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u1O5Zo2dxLzmZgvNn0An5SSskEQ1ujPgQCbdKBr2XqiFnV5uRqwmhHm+msLzb9Scq2dPNn53bXjkQL1PiRDOeGO4NoC0+Bn6G/6L3H89ELeWafv9CpMgD0rl4I9UQ/gFyamww1S1P06yV6b21pS9pb9J2359vETjhtvgs/fpokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAqA3qqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1568DC32786;
	Tue,  4 Jun 2024 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522267;
	bh=MQO9fA2pjCBtJWAIS8fIzWfvpeJKsZKwiMGN9E5r8N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HAqA3qqt2r3b3JsPPw2jdEIKryGHIeu0iRwJU0O404+aOi10JvyzwHhJhqM7TZAGx
	 CbYd/Iy6HwXXNrWPdf/kgTxVWTbqcPNElqm4BliZpQZMRgnscmSEcmYL6IClroZw2z
	 +jAI4Rael4VhgPwNzw3XE01TH6aSWn8HjU81u3lAMq0Oblx+YoIBSz+zdowwYjtEhZ
	 7owGBmyP86kadTlqZWJDA8FGWqpdmW/Lniw/xDo5S5LLRf/yHPr08S+zi7eB8sxEPs
	 Rcmc7ELlwop/d5XKuVELtcZoKr70m2S3t8sdTo7GU5TmN646i7EAeHXDHdXLCAZjNB
	 lsAQJaGMh+ahg==
Date: Tue, 4 Jun 2024 12:31:05 -0500
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 02/17] regulator: dt-bindings: describe the PMU module
 of the WCN7850 package
Message-ID: <20240604173105.GA733043@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-2-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:10PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The WCN7850 package contains discreet modules for WLAN and Bluetooth. They

s/discreet/discrete/

