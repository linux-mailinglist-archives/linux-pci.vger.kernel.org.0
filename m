Return-Path: <linux-pci+bounces-34418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67702B2E821
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9ED586B8C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1D2857CB;
	Wed, 20 Aug 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDSM0gsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536751DDA18;
	Wed, 20 Aug 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728710; cv=none; b=jhrIZquSlXNa/VQ9/LyKdUg5L5+ouYi6ESqOwVsPMmkikG9UZSHp3/RtwW9EAPssT7cc6LIPAuzXiOsbeK5KK04wCtKPZ8UXvFHfBOYGoNbTcaKUIrRsKFFr23ZHGnaeUw77iiarV/BtTwIgqLHY8hx/Sx+v2YO4cDO6ke2ECpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728710; c=relaxed/simple;
	bh=aUlRSOG2kc8+/rfd0Tw3BR60f19vfhNgfExAGNAfyvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ6JVXHs8PAiTCGcDiADIisZHAMLVtGMM+aNqsY0+rNJTTe6M67JPrCLn4OuUJ3wwUpRsGQcSgBbU5OA443ggi/7aSWu0GW4Df1Ez9QLtyhdLL9k665LGyhXCjxGjyG9vEo1sv2RHJjodyAt51UyNg4efSyPrUvpkoH7/qQ7srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDSM0gsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA574C4CEE7;
	Wed, 20 Aug 2025 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728709;
	bh=aUlRSOG2kc8+/rfd0Tw3BR60f19vfhNgfExAGNAfyvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDSM0gsQ5DF+lFCQxjEYughfkLP5P4wPbsHTkQRKLn0slenVV62Z9tvm58Xlrlt2Q
	 QY6bJVs1LIi0XSIyGDHdkVmcYm546MqnS47c4gcOxji+Cs48A8SvKscQPoCvuzaqig
	 dRYDzW2QLSSqu6aFaLmkC8gIkA94zimv9RvV22I5UqMnJI96GALwuZlxAHqW+V8mma
	 bjwlgJ1dFWdTG2g5s+MeLVlPcIFsGvTXVkb4fToi14QxZcE6lB+Z08kRWkk3KKH4Tz
	 6A+2Qc3yI1Gz1y7x4v12l0rgtXbT2EXZKX8NZrOanALIK9tGEzSURR21hIb2bIeIMf
	 Uswp/x7luzYZg==
Date: Wed, 20 Aug 2025 17:25:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Correct example indentation
Message-ID: <175572870848.1567859.11625606006688272585.robh@kernel.org>
References: <20250818142138.129327-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818142138.129327-2-krzysztof.kozlowski@linaro.org>


On Mon, 18 Aug 2025 16:21:39 +0200, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    |  2 +-
>  .../bindings/pci/qcom,pcie-sa8255p.yaml       | 74 +++++++++----------
>  2 files changed, 38 insertions(+), 38 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


