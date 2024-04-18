Return-Path: <linux-pci+bounces-6435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A808A9D84
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B1A1C2195F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A7165FB0;
	Thu, 18 Apr 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/8l0Pg4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8F6FB0;
	Thu, 18 Apr 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451706; cv=none; b=WZFe2t0Eho7R8OrwzOfzV34hbPLhTUxvZIW8i4gJnNbjeVz0mzB39L3vj2DHg6SREdA+hqJ+YWhzcYGm8a3TgUze6mGYe8ZIHdT1VMfAcAvYCf4267oKeb0lNW++3NOylyyIAubn55H/45rDsDMxH1C453E5+h/JVcoXp3F0Ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451706; c=relaxed/simple;
	bh=kb6yHJn9WyABtdbe/69G40oetjea/tWLVhjJP1KXgWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U35iVRD+lB+FxC3Q14yBLW47MKGvvPVq8aX31zRjVNPwhfaMuA8HIOExMmZVZn3C2+ZG2dqJ6Rh4hJHAqnjDvgBy3weR931SiMYMvDec5YjH5pUlGzy4Z5GoAkrZ53vE3RH1v6rJrFK6Zr4pJZlbPKJZuVh28jaB8nv5EorxFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/8l0Pg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC05C113CC;
	Thu, 18 Apr 2024 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713451706;
	bh=kb6yHJn9WyABtdbe/69G40oetjea/tWLVhjJP1KXgWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/8l0Pg4O1H2iQ5LzdhAe5Bb95rC/XAt7dGsT/DYUyq2C9lGEQdX2lPH0gnBPzWBK
	 LhzOCrdE4mtqX8ySV6QptVR5ZPPI3W6GiB+KplyPQ9qjoeClpt0Hp9bTqv6FiEMt6y
	 f10uVLUUJTwY9yfp/RID9uyY9q2Hpa1YH16G2SNpnjDOqmAwKuSUFeXTDOzSweGjkh
	 t6Vy7N8a7Exj/eyuGKlI/2h3Gyw9Ktv20RodluSbQAu7+/fQhYPKhjfLxjLVwZMvIP
	 J6cr4dGUg5hpO90TsVSo2BQf534QM0mPDfKw2WBJofsNPtAKK7or2tk2fQcrSo0IdQ
	 O0zClbAbkHdoQ==
Date: Thu, 18 Apr 2024 16:48:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/9] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to epc_init()
Message-ID: <ZiEytLn1hl-AtTo6@ryzen>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
 <20240418-pci-epf-rework-v3-2-222a5d1ed2e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-rework-v3-2-222a5d1ed2e5@linaro.org>

On Thu, Apr 18, 2024 at 05:28:30PM +0530, Manivannan Sadhasivam wrote:
> core_init() callback is used to notify the EPC initialization event to the
> EPF drivers. The 'core' prefix was used indicate that the controller IP
> core has completed initialization. But it serves no purpose as the EPF
> driver will only care about the EPC initialization as a whole and there is
> no real benefit to distinguish the IP core part.
> 
> So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
> epc_init() to make it more clear.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

