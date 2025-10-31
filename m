Return-Path: <linux-pci+bounces-39894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848E3C23641
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 07:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF703B42CA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB632F39C7;
	Fri, 31 Oct 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaCUrI5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5832F3635;
	Fri, 31 Oct 2025 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892146; cv=none; b=Gyt5iGS4X7iHT4H18qIDRfdH/O2H+xt5rUh8zU8ZvGGXhGUl0Rp+v36iehpXpIOGxpE1vUSkLtXFJS+19Zk5SZZmss3WmhEi9xGi3GMhSqsCFUXi3oPyExgLzTK6dOOd6kt2UUNdjhGc/PnOiQN9oY6vjADq0S0K2msNXVC7XLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892146; c=relaxed/simple;
	bh=msn+7rMR8CJtIfyaABC/gzeHRs3sw2VizOv0Jwt5B8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omWA3su8f+3oDRsmFfgq0j7VLLOlWz8oFqmygP1aufxmH8lWNLa8dTqXI/Y7vV8PSCnA82JQs4EDuATT5k0L2175XPsAMUHlvjUvC/GLf42OzlxOxU+SkaxPF3lMSSxFSN3nqq8RZVo/fX80X+W3iT5+v+unQmN9HDeztNmL6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaCUrI5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577C6C4CEF8;
	Fri, 31 Oct 2025 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761892145;
	bh=msn+7rMR8CJtIfyaABC/gzeHRs3sw2VizOv0Jwt5B8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaCUrI5vxJaXFfl708BD6FrjRFKQ7JfRhoUr8rCD41bDDp2pFd0cTixlCKNXbCX0a
	 MstcelW2cNJZQxKXgFDZgAh2dPBezDuFIIipZUH9lHmyVwmksYNsWulZag5pjfvHZo
	 nbghdH/+lV1zLJ8WfpToldEXnKaqb8X2NxFvRBitLOp4ihk2hiBbEn6i4Cij9ljh4q
	 mKhYMh+Kae7ixD7f3niw2+28xIMZ4cB8Af2/rxx4T6BITw8P/N0dHTzT29CIcwhpOo
	 Ubu9o4Mmfo70d1Akwg0QKQBzTAt7hK1r0x9+Ci/TwbAWRwOEiAsHJAfFR7TQkKdtB8
	 bgjzuXwcUOQFg==
Date: Fri, 31 Oct 2025 11:58:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
Message-ID: <ozlhnzkzwwifwhqn54ja5xqndtyjf35nbjnsidl5nn6xe3eijf@ptzzqchq2kwq>
References: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
 <20251029203948.GA1585122@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029203948.GA1585122@bhelgaas>

On Wed, Oct 29, 2025 at 03:39:48PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 04:23:32PM +0530, Krishna Chaitanya Chundru wrote:
> > PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> > the same frequency but differ in other characteristics like RPMh votes.
> > The existing OPP selection based solely on frequency cannot distinguish
> > between such cases.
> > 
> > In such cases, frequency alone is insufficient to identify the correct OPP.
> > Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> > frequency and level when selecting an OPP, here level indicates PCIe
> > data rate.
> > 
> > To support older device tree's where opp-level is not defined, check if
> > opp-level is present or not using dev_pm_opp_find_level_exact(). if
> > not present fallback to frequency only match.
> 
> What are the names of the DT properties here for the exact (frequency
> + level) and frequency-only values?  I'd like to mention them in the
> commit log so we can look at a DT and figure out what to expect from
> this change.

Frequency: opp-hz
Level: opp-level

- Mani

-- 
மணிவண்ணன் சதாசிவம்

