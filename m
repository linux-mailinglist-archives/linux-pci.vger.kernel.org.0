Return-Path: <linux-pci+bounces-39728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B17C1D3C0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 21:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94634E19E0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6073559FB;
	Wed, 29 Oct 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8syutju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB926D4F7;
	Wed, 29 Oct 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770390; cv=none; b=bN8FvPX1+6AANXGdpboBMC6wUP7/1ydcVJx5LRPyKRXKP5dZj1KLIKZUly7tM4tUqS3J+ZqCuXmvto7U1afCTrKtp6AK3RwLo9TujVID6PVjr25VFPx0hN35jFSby773ozbnFa827sGAGVffguj54alKyb7ThoLNMKiUogLEMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770390; c=relaxed/simple;
	bh=OR5yoCv4acTmO/f49HQZ+y3rimJ/Lc+as+3o+SzCpOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AbV1q/jPrMPO0JC7ewRzWqi+WQSYcu09mtLK+DieK4CBEycFYkSewimtRhBoA/WGuiYoHhPT35SYWSH+03RAWkM3DKu6gaxTLd2vs6/Ld64naiwWSpHHISUwQOJESIpBOLcN4jEjSFwkxBR5cEDPw+C+VrqD4WUg2FAbEFGb/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8syutju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E1FC4CEF7;
	Wed, 29 Oct 2025 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770390;
	bh=OR5yoCv4acTmO/f49HQZ+y3rimJ/Lc+as+3o+SzCpOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t8syutjuiUUcKl0oGKRTvuWIGMwkXhslUwNnZj2ENi6JEE+F+nbQ71w6puXgVyb/T
	 3g0ClFx53rxDt9HWQF697DeffaaHQhW7Cad3ekCB4YRzG1KfBFeagUan9ouPVolVD9
	 FSqPDRC0YVHGzdsRBG5HruiGudRZ9lQP0Urk2wq0WpmMr9/twihXbmDG1fMg62H3xP
	 9mrE0Wh5R3DGNO7WAzN35SqlD4bkIm5WXhvKgDbrmd72t9vPeEANNYxxupxF+MlL9R
	 UjmXMc6OAtiyjieZJDwOJL8oNniCrqG7E8r8HdrXoJHpdZT/ljD5QhT9GlDRQRKkBQ
	 XVBL+WWubcI8g==
Date: Wed, 29 Oct 2025 15:39:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
Message-ID: <20251029203948.GA1585122@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>

On Mon, Oct 13, 2025 at 04:23:32PM +0530, Krishna Chaitanya Chundru wrote:
> PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> the same frequency but differ in other characteristics like RPMh votes.
> The existing OPP selection based solely on frequency cannot distinguish
> between such cases.
> 
> In such cases, frequency alone is insufficient to identify the correct OPP.
> Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> frequency and level when selecting an OPP, here level indicates PCIe
> data rate.
> 
> To support older device tree's where opp-level is not defined, check if
> opp-level is present or not using dev_pm_opp_find_level_exact(). if
> not present fallback to frequency only match.

What are the names of the DT properties here for the exact (frequency
+ level) and frequency-only values?  I'd like to mention them in the
commit log so we can look at a DT and figure out what to expect from
this change.

