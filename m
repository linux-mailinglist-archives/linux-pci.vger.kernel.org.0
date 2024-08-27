Return-Path: <linux-pci+bounces-12246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF096019C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694AF282FE9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C371422D4;
	Tue, 27 Aug 2024 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQVmn9YG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC133CFC;
	Tue, 27 Aug 2024 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740062; cv=none; b=JAS0VB7WB4/jXRjjfkZpsnV09x2h8khubW6wRM5A39atg5BfNooEfkQkEg8CfO3RxhqxxjUJdDEoN9He8koy4phi9ecqSqjqo4u3gQeXHnGnUvg9TiXmAO0NEufgdaF741tdk7MvvrxxUBpINVyoP143hhb0f24wIgAlFp2qedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740062; c=relaxed/simple;
	bh=lq0ooS8TfOdhCz9BfpL7TIlbaqhjsSyuKwzJ4JP4Gkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXE7EY+le6aoxMxrygiE8CJl2/MuBGvOBj0U4znQndnpStp6uDouRhok1e8s8B6PmRXhUPZv46qpDZiVgWL2FxWjkU+SH66m5YPLvIXt98X2kORSA+AhE29KAuBONte+UnUusMBrnwLciFPIdpLSPjDiGNPz+GjGBWWMU+ERv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQVmn9YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445C1C8B7AC;
	Tue, 27 Aug 2024 06:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724740061;
	bh=lq0ooS8TfOdhCz9BfpL7TIlbaqhjsSyuKwzJ4JP4Gkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQVmn9YG6XM+90vlPAqRatnRa8LaM8MjhdYi1RMid8R7bTwH8bqqRjoBTjRgAxqx0
	 6VUXAANOS14etlla05mVRcZh9xSlgxENxq2tmWHbILYxzjYmtKsSJowmZSVkWUTVf3
	 E9DJ2/Pnf2QQWQwwhF0XdYbqikonzThvRGsdo6SIyeQOk849JhBE54b27dStDThAgv
	 qd7GawPSXipEwTlaVs6pa4t4UinFw84q/Y+wqtir1NxIVFKJB4XQ8SzFKcq89o2Q0j
	 yUE5OqhT9vBC5x849wEv6MYM01RWs/grcoe3skcxcr5IqxdjwPk0UpvpOwvajFofrr
	 PCOASFcUBcffw==
Date: Tue, 27 Aug 2024 08:27:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <q7s3iv5plsfbk75d3ecjjpcqc7ywwc2ygekfozty52lejvui4z@dpyhwken7a6y>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-2-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827045757.1101194-2-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:52AM +0530, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
> [v2]  Fixed filename, title, fixed clock-name, reset-names

OK, I see detailed changelog in commit, not in cover letter, so this
solves my previous comment.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


