Return-Path: <linux-pci+bounces-29224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F7AD1E9C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF83ACF68
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3848256C7E;
	Mon,  9 Jun 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk9lTXNK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD42505CB;
	Mon,  9 Jun 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475020; cv=none; b=Dui+1xOIkGVfV45agU3a3wqR8Cly4BnYAb74RXepB7x8oeKaa4BjNjDcbzbt4geUXVZ7HD6falOSZNxWY66BIet/nzrvwaRvvJPEHmcfStC2DZoraY6pVLtJ/Jp3dHvhEZib0yribyOJmMPRaUhEegk4GTL8cFeWiCNK1Y+eb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475020; c=relaxed/simple;
	bh=YBrZfAOWC77371Om/Q2DCtJzOeAx6cYDgxkksmHBjdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKAti8vX61sUzsDfTCDoDU+KKq9BXZExP9lhtNGuY2qWTrtpuuS1ZCr+I+YNC7P/crojrEcjSgzDpyBNdUBBt5L/hCzJvaxg7cDlnEMBGRglNVaigBclLKkxL42ntKfLRvMCRpyfGN/5svdRL4QLmeLMOl7flJW0smnFSM2LvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk9lTXNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2630C4CEEB;
	Mon,  9 Jun 2025 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475020;
	bh=YBrZfAOWC77371Om/Q2DCtJzOeAx6cYDgxkksmHBjdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lk9lTXNKiFFxmljg3Ocr/fnCIDgQULgMZHKldFFXmAGH67geDpLERAjwNU453CerI
	 4wN0LYpigFOHVAcJAErYMGsl2DmnLt6QTNJypdNW6HEHA9SYz7JmvRa5Rwhxyx4NSF
	 3r0pziDcEaGux+YEdgtWoMUvNhiKpcSUVAcr5ri73zsFY+uFmrvMWMmhFXjTxMIe1S
	 aZhvL+gfvh8xodgZPGZ2EAHaAYKHYQmNYUcg+vL35OC/RvQQLmh5W7JqJjQ69rod4U
	 mtuBJdPRO0cdptraCHTmOaVs6+OFRIvfOgGjWSmXg2X4EY0mg1i9fC7O6bWDeoPg/F
	 fl3NnQBS8N/yg==
Date: Mon, 9 Jun 2025 08:16:59 -0500
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
	quic_vbadigan@quicinc.com, sherry.sun@nxp.com
Subject: Re: [PATCH] schemas: PCI: Add standard PCIe WAKE# signal
Message-ID: <20250609131659.GA1737613-robh@kernel.org>
References: <20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com>
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

Applied, thanks.

Rob

