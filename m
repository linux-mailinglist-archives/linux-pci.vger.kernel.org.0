Return-Path: <linux-pci+bounces-30906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA5AEB2FD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80217189B83C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244C293B75;
	Fri, 27 Jun 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3QCbd3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401F14A82;
	Fri, 27 Jun 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016697; cv=none; b=StfTJvkVZsRIdZ8KeDAEh1x3BFceBFlQkrHbNuBpd2eh6y9eXKxg3BrPegE+13ZcY/F7oMdCQ+ah3ilvdSTBnDUhypm8P2XYPH5nRGwyyxQIRlENk48NVhJkWw/Nwo3PvOtzouMhWsBtvXhkbkpgB6GChGLgeDR6YwVkgKtu+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016697; c=relaxed/simple;
	bh=VVXzjakLrbQT4ZfJ9FQFUeBjGu5c9RhpGPfJmxmATuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3Kp4dY1B8k5lQpapXYads3XgYaZ44CKYJVI/cICMg7EH59uS3UYtphqFFIOCIZmHodE+hiKjXtcPRt75HGnRjcX5HegqfCjIQtAoG//LVjuflrO9OX7owMWxkf3SqIMRaxcAEH+UUWSdWeMQvsVi1gb/3Kgf0tMv0N7VTQ2Fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3QCbd3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D03C4CEE3;
	Fri, 27 Jun 2025 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016697;
	bh=VVXzjakLrbQT4ZfJ9FQFUeBjGu5c9RhpGPfJmxmATuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3QCbd3a3WNQO6uK0sf1DKlI8wHjWukKpFM/KjCKtA+rSTrUNhlikURX0cRcKGFka
	 DVAew2kURrmw64+U+ImSg1Jism4TRa/lRm1w/ax6ym4YoQk7WAcKZZeCgk3GA6b9yg
	 FQAogSMZPMWSsAHHg3X/B5h1Crf+Q1g6gRUP+tSvtA+pMzsD+kuilwxzzYKXIf3Sk0
	 jq+W2CecRi5eekzvv2aTVf6RVsrf6Qe9vDxshtrOqIs8OZlwo5uxZJYuDafFah0sBQ
	 iVdqrDmapGye4qXlYSW0sumwt8+CWiq80IDs7IXMHc50VynCUPpfvZ0SUa67ZvzJeY
	 78t0FRuqcZ2TA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV5Qn-000000000FB-1fEb;
	Fri, 27 Jun 2025 11:31:37 +0200
Date: Fri, 27 Jun 2025 11:31:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aF5k-Scgk6KTI_uQ@hovoldconsulting.com>
References: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
 <20250625092539.762075-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625092539.762075-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 05:25:35PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> As no compatible need the entry which require seven clocks, delete it.

Please add the missing Fixes tag.

> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---

This patch depends on

	https://lore.kernel.org/lkml/20250625090048.624399-2-quic_ziyuzhan@quicinc.com/

(which you point out in the cover letter), but you should be removing
the bogus 'phy_aux' clock when removing the last user and not before.

Johan

