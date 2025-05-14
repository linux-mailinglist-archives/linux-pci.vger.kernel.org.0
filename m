Return-Path: <linux-pci+bounces-27761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186AAB7643
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42674A7047
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059ED293740;
	Wed, 14 May 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ5EplJJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5229372F;
	Wed, 14 May 2025 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252778; cv=none; b=B/xM5beBCbrbGoq1LhWRqzfw0ex9p7++IoAdnLbitm8W8pBzifHX9gUk6beYIsHxFUycBNZTMrrHhyORhZyvSNaiNOzsqAL7VQpKDeFk2hFq4y2UKZsl8aEhTRcrfcsIPjz0flgPolGsFP238LpgptAbqYPpSBTeOtNeqJWpiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252778; c=relaxed/simple;
	bh=qW5rFOZIUMIBxccZW3o6GhkmgWY42f309svVpKLhFmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5PyWajFOTtZbioXIap3r4pLJEkeUAp8aV2N3ULBKo/fg7dhD6PADRrU1mKYBzGOMykHkkl9rb4nN2LPQYhG30HQ5RN/uhhunrpertS4OrRzzbHH6oGm+J/3vT2RsWaeBJ7CdG5mW5N3tCgWD+hoF+6YTxcfZqYDhScINgDpOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ5EplJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F253CC4CEED;
	Wed, 14 May 2025 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747252778;
	bh=qW5rFOZIUMIBxccZW3o6GhkmgWY42f309svVpKLhFmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJ5EplJJPn6Tz9O3+AZuZXh4X+8zgKjmalug+lEd66Vad5lxOacniJp6hmODD01TM
	 Osq9ifdXaEYW+x4jYXSK338ObxTf7SQMmlhEySuRcaByx88caBfm02Z7GGHw6pHpPR
	 gqfL5mOlMSKJoMuya+QV0YRpEuc3jQxhN6IY9HIRNkvGB2DqM2J7eSTU4SpKu0rUnQ
	 FXpNuqO/4i6ZlU/2vhh/bBiKwhYPSz+HSjrXeZSnDETm7cEmqlW9FDsPabO2+K45Rw
	 SmZ4+HfqrDDrRT1Np7xc7Z9EMX63iFm4MmJEm+CCTvPHaDaLflRgkqG34Q7SOtRl5h
	 P8J5MNzz9FIPw==
Date: Wed, 14 May 2025 14:59:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, p.zabel@pengutronix.de,
	manivannan.sadhasivam@linaro.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	krzk+dt@kernel.org, johan+linaro@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, cassel@kernel.org,
	thippeswamy.havalige@amd.com, shradha.t@samsung.com,
	devicetree@vger.kernel.org, lpieralisi@kernel.org,
	mcoquelin.stm32@gmail.com, quic_schintav@quicinc.com,
	linux-arm-kernel@lists.infradead.org, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v10 3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint
 bindings
Message-ID: <174725276905.2927216.8851775897003421959.robh@kernel.org>
References: <20250514144428.3340709-1-christian.bruel@foss.st.com>
 <20250514144428.3340709-4-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514144428.3340709-4-christian.bruel@foss.st.com>


On Wed, 14 May 2025 16:44:22 +0200, Christian Bruel wrote:
> STM32MP25 PCIe Controller is based on the DesignWare core configured as
> end point mode from the SYSCFG register.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-ep.yaml        | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


