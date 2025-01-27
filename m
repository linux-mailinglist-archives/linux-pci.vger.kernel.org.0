Return-Path: <linux-pci+bounces-20388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156EA1D157
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 08:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601373A446F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9511FC7C8;
	Mon, 27 Jan 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKSRJ+ub"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842A15B135;
	Mon, 27 Jan 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962830; cv=none; b=cteZxwmKwS0IYuGaJXzPNgNDKLYmszqBK6aZHnr59xbICD8OLDr+H9xIdD+ZFevOfjyDQ93/bXO3YxQ+B7anKMSc8nswv4KqNEuLW9aGKgBwoxOisErR+3qjuxsR4N58KDme7TxnCHQslRK8vehaYwS2TRA3TDw3T7ZmK6QPUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962830; c=relaxed/simple;
	bh=G24l8gYb6p1OCKWPjbkTtVBc/xNYAml5um6Gy8Ihmq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqe7TuSrkq35MbEkfB1A5B9C0utYTYnigGTLpSTB5vKVAyNY7RDUosNkUc2v756D+3cWviW5gGWy+/aglQzIDoumdnqr3A5pBERHmMdTwf+Wj9m5STPA3TH53IK3LOyQVqST5RY4DAG5JWvOHO1BflVJ2cK+6lH1UcyUIswRE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKSRJ+ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718E0C4CEE0;
	Mon, 27 Jan 2025 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737962829;
	bh=G24l8gYb6p1OCKWPjbkTtVBc/xNYAml5um6Gy8Ihmq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKSRJ+ubmsZfvZGc/NTwydneJb6KSZZx9ljgJRLTOIZfK6aXETrKAmAS41IsIz77s
	 /ib/lU295k3dOYMHF5WNNsCH7n59l8tu+REaOg91mHOhY8wTmhSkKoPq1p9v9dLR5I
	 989wqAbPvr2/pwPXMNUhQfn+NvVZ5EK9T07UwxQY/JbgTq2JV0u9TdsVwkGzB/X8OM
	 Yzbumv5Qo6yj9RTyAH3Vm0af+x974JkXo+ZbYXk1IbicbU/RlvLP5YxGbATMN7srlq
	 pC6gpEqpeUjGjN6oPHICyEz/FKvtAWhXPMzddmyru1RWhHylzANpfKgJcCgmX+VSRE
	 neoRikcaGtXRw==
Date: Mon, 27 Jan 2025 08:27:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: update interconnect cells for
 ipq5424
Message-ID: <20250127-amethyst-capybara-from-uranus-5e6bf4@krzk-bin>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250125035920.2651972-3-quic_mmanikan@quicinc.com>

On Sat, Jan 25, 2025 at 09:29:18AM +0530, Manikanta Mylavarapu wrote:
> Interconnect cells differ between the IPQ5332 and IPQ5424.
> Therefore, update the interconnect cells according to the SoC.

Why do they differ? Why they cannot be the same?

> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml       | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> index 1230183fc0a9..fac7922d2473 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> @@ -35,8 +35,6 @@ properties:
>        - description: PCIE 2-lane PHY3 pipe clock source
>  
>    '#power-domain-cells': false
> -  '#interconnect-cells':
> -    const: 1

Properties are always defined top-level or in other schema.

Best regards,
Krzysztof


