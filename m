Return-Path: <linux-pci+bounces-27322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41FAAD4E5
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3654C3BBC
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67261DF247;
	Wed,  7 May 2025 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn/ikzLX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879831CEEBE;
	Wed,  7 May 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594763; cv=none; b=sO0BTiEXVB3Vg/4Zvjx5lPjmYoywuFOTt7Sa0XmgdedAkBGQ21j5EuJH9QlZHMUsktdXNbbzRINbRSzM8IjJEi1/tdJEv3u4qkQYWpIzJud4I+cXRD5doD34FEsbgvOi0nuiAdzJcjSgi4BvZgS+dkHEvHxilKNtZyAysmfIg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594763; c=relaxed/simple;
	bh=aAaL34SOFIosC32e/qxwi38aNbXLIxkuGdhBhlDTlRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgRUMKEM1Q19c1kOF8PolhBtPJ5Ly7WaFLTaZL04DY71ulX+JlWPN/ieyOkEiJ+G/vXJiTnXLXgv6HvTI4t/IjFlX59EXy77pQPGV5c60o+NFyIuC1ocwiaRFHAEBpohRunLTHVeldp13TcWOKzsDgm1PVuABMF3gIBKQ3bCv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn/ikzLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4E3C4CEE7;
	Wed,  7 May 2025 05:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746594761;
	bh=aAaL34SOFIosC32e/qxwi38aNbXLIxkuGdhBhlDTlRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn/ikzLXMzG5ZQXxuUdAAeftmQfP8PsTmnaT/1ehfAs+sB4MM4VnSfJ6bLlX6KF1S
	 yE2aYRk6HrGplr2kkd6ZPJ7kxR+zDnoh4QsNnaZek0SLV/YFwYR3Kp1CKjHa30gCRx
	 saVbxWHmBE74zI31ocMSgwUc0vuf+YSLjsP+E/wvpZt8M/wjHPDUrYLU37PLXktUng
	 LpvrQ0rP4HMYhBuxW79E9pcuJ1R27SgV9D489e/YmYuDo4jyYcBdOxwYUnmc9CqR1A
	 z5CCVVz1U1963BybHz+g908W0jOTDXfsMshNM7PrJCrnaWwfVZOWTBbfMTD+4R2OBB
	 JwAcNoGhrBZ/w==
Date: Wed, 7 May 2025 07:12:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for QCS615
Message-ID: <20250507-invisible-nice-ostrich-fb9c7b@kuoka>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507031559.4085159-2-quic_ziyuzhan@quicinc.com>

On Wed, May 07, 2025 at 11:15:55AM GMT, Ziyue Zhang wrote:
> QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
> ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
> from 6 clocks' list to 5 clocks' list.

Same for QCS8300 patchset: what changed in the hardware that now it uses
different amount of clocks than before?

Best regards,
Krzysztof


