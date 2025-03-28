Return-Path: <linux-pci+bounces-24918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCFA74548
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB73A667D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFE211A35;
	Fri, 28 Mar 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTuM/es2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF62153BE8;
	Fri, 28 Mar 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150149; cv=none; b=UFNJHNBLjaaFARN1FOBaFJdSS/UEWqef4JZTV0LKkMISTAF1+Lb1ENkxxY1d0zf/0Jwig4tIjcJ/B7I07zmAf+OvfH9Zw2SsYW2bOYxAbx8DSLP1HHsvEidbg7qudQ7nI3rL+jZnCxVcclDqXW18w9DxN2Z3iBbGmowT90CRhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150149; c=relaxed/simple;
	bh=2baag8An67ABokx/NaGcXx9UiUw/BBwCwZPwTm0M9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCRrrL1ticZkEoEUfy6eiG4+LhAuHPkkpbP313L7OhA4S8M8kL6sD6X9rQmx6q28klkH3bH5/zwt/AGmThLlEvhmqsSiEZalUrRRPuZ8RT2vDjpbxYbkftK626c/rZg31LPOwoyp53TK0d09syOmreUove8aZdeIpnSo2DQIgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTuM/es2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B1C4CEE9;
	Fri, 28 Mar 2025 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743150149;
	bh=2baag8An67ABokx/NaGcXx9UiUw/BBwCwZPwTm0M9BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTuM/es2Naf3TIWRv61QkD7wr7M/XgAbTnrEoq6gkar2prfUFfN4qlYaAzPfvqU2s
	 YE0tjuxq87UEoJOMSwY8JO89B4Lo+Ee75nf9CD/7e1q0XLt29MB1tK49C1NhHxdMFO
	 Bv2bcCKTeHN6qEmg6iKo26k36jkwA6LIASZdpysWCevhcUnUFMLHhs9r6EX7bfbyey
	 rt9jJfdNTYPTgPlFzJexfam0Pbr7PDXy9HtWG9IGE1W7f5oQW/yGGUEfrFsoKBKEbo
	 +v3m9zG/D1mv5NxdnD5R81LtiOrfvuLCFfvqrJpEkihi7BuRNGRQ8KWu11Qa7R+w4U
	 DhunWgMBkZhoA==
Date: Fri, 28 Mar 2025 09:22:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
Message-ID: <20250328-poised-dolphin-of-sympathy-e1d83e@krzk-bin>
References: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 11:19:47AM +0000, Manikandan Karunakaran Pillai wrote:
> Document the compatible property for the newly added values for PCIe EP and
> RP configurations. Fix the compilation issues that came up for the existing
> Cadence bindings
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++++++++++++---
>  2 files changed, 110 insertions(+), 21 deletions(-)

One more thing: SoB mismatch. Maybe got corrupted by Microsoft (it is
known), so you really need to fix your mailing setup or use b4 relay.

Best regards,
Krzysztof


