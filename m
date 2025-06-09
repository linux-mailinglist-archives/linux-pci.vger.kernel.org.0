Return-Path: <linux-pci+bounces-29232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5BBAD2118
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13023188B96E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553F25D8FA;
	Mon,  9 Jun 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyxXw5I8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B91E5702;
	Mon,  9 Jun 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479856; cv=none; b=UcsGxpTgb8zpqr4uSKSg4ne8dlpBDRMHhJc0zgmd1gZd8GDD72ELYwa51JyrMCuwPd9BB+ujqNb+F+tln0II1vAhru+2xS3LLd3MdEhf6PdxeJ4ITPv/rR6agSra6IzbBgqqFKUGioOlq7uNxc+naXvSpW6u0f1lat2iHqU3nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479856; c=relaxed/simple;
	bh=2sfPGZXf9nL04ZmKYHBs6lFfZZyiD7KoRwG4xEmoK1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vAxC6J+ApEVq4PAVdcexfHaQjopoeWUxhcuJFWVL3eLqQCqaVF/tOzMsI5M71HZmpsQM00Qkl8S7I1NNhr9IDOGEyxbqBi75VzoSBEdB2h3YwqeMBwSHT5FVxqw1oog2gJzdNCzlWGO76kvEN3MyMZScBvDIzb3XgLeOGiA1XK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyxXw5I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD43C4CEEB;
	Mon,  9 Jun 2025 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749479856;
	bh=2sfPGZXf9nL04ZmKYHBs6lFfZZyiD7KoRwG4xEmoK1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XyxXw5I8SoayKLpxOhzvrSwjw1yl5O2mDErpWdmZx8j3cyJJz4ItrkVO2Da/Yujol
	 wiaH9pLYhFX0WDwm5FHlb8TnB/93yk2IaD+KU0fv/Kj979l7pVdQjXuU1Xg6l25xn/
	 HzdobK81V7/OHpJFi4UbnhudzLfUfqizucJWCZIjhQshZtc5eWh3nq/xHCC3DxFjSI
	 DmCJWWw8IaCKY0dSJIHGmo7jOeFTNm8sjt87q13moTxQtORqZ4jh+b9sLxsTT+39zU
	 EPVFn9cwyw0y1CVTYkOsR97pOcklzZli6CJBYskZJMLHBKO1E0eYA/C/34laalTs/K
	 dgJyuuJ0o1tyg==
Date: Mon, 9 Jun 2025 09:37:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
	sherry.sun@nxp.com
Subject: Re: [PATCH] schemas: PCI: Add standard PCIe WAKE# signal
Message-ID: <20250609143734.GA749760@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com>

On Thu, May 15, 2025 at 02:35:17PM +0530, Krishna Chaitanya Chundru wrote:
> As per PCIe spec 6, sec 5.3.3.2 document PCI standard WAKE# signal,
> which is used to re-establish power and reference clocks to the
> components within its domain.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index ca97a00..a39fafc 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -142,6 +142,10 @@ properties:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
>  
> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# signal

"GPIO controlled" makes it sound like the GPIO can assert or deassert
the WAKE# signal.  But isn't WAKE# driven ("controlled") by a PCIe
endpoint, and this GPIO would be input-only at the other end to sense
the state of WAKE#?

