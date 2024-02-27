Return-Path: <linux-pci+bounces-4164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB886A3D0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 00:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95F9283358
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102256460;
	Tue, 27 Feb 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InXp1LE2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA855E48;
	Tue, 27 Feb 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076999; cv=none; b=Q0/cdxHNN6zFS9nuvGSuNmsH8a0+Pj9egVB1hISb/XsdQzdnqYR4oleVoGA97xnQOhyxrItQdRF2daxjXzNtlszr0vJzfS82cxShX6xtMuIlEHKcBNDr16pb9BV7D3IJahzCf2QMSPTG6YSFMEdS7cXXimaI8JtYjfH0yoHSL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076999; c=relaxed/simple;
	bh=/VRb4MzHv0+QTH7GnhhfKoUNkiWk+9BsaZq59IGyA5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FnTkZc1B3HyKbtlfITSxRmz5dei1Q3krUygj7ApE/ZFRTRao0XVfBPDB2nZl03rrzk3YOvQWGvY0l7FvCPH35jkrDOpOO4KrfEljjUE2VSazdl/7usUUb7OMrdPFZ6W+S91QlxIi7KSKMFVAhIqCgsHO8r3HWYWu6pSTaq5qLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InXp1LE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0F5C433C7;
	Tue, 27 Feb 2024 23:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709076998;
	bh=/VRb4MzHv0+QTH7GnhhfKoUNkiWk+9BsaZq59IGyA5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=InXp1LE2ZQE4DIutfgEWvLKJ1q/QXKsCzvoLz5Sb8i7MsnequWVpZkW5heGmHn/rg
	 vGWFHT87IHzlXUfF9/VZ1jFjnYf7FCbABCnU4fWZ+y/up/O6b18GslbL5wLVm/6tb6
	 vuLLE7YELsaHU82jfvBkXUtFOl1OuA6mrSaHbnGvU8AwqjHzLbJ6bkVUfebNXqxnc2
	 aDmuc05+egn0HoxKyQM0nBNyonBqIC5JeTeOioABy5POiMeMlzU6pU7/yNmEvsfkmk
	 P5f+DqNMGGQlE52BnipoK1QWEYfhbHVNk1lcKtyBj85moaWQjauhEe7NGpgo6zaWWv
	 pqqAqCRMU6Niw==
Date: Tue, 27 Feb 2024 17:36:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v7 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240227233636.GA250826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-opp_support-v7-7-10b4363d7e71@quicinc.com>

On Fri, Feb 23, 2024 at 08:18:04PM +0530, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the clients.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.

s/up on/on/ (or "upon" if you prefer) (also below)

I understand changing the performance state based on the link speed,
but I don't understand the variation from target to target.  Do you
mean just that the link speed may vary based on the rates supported by
the downstream device?

> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.

It sounds like it's more power efficient, but not actually
*mandatory*.  Maybe something like this?

  The SoC can be more power efficient if we scale the performance
  state based on the aggregate PCIe link speed.

> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon the speed link is operating.

Space before open paren, e.g., "Points (OPP)".

"... based on the link speed."

> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> framework if OPP entries are present.
> 
> In PCIe certain speeds like GEN1x2 & GEN2x1 or GEN3x2 & GEN4x1 use
> same bw and frequency and thus the OPP entry, so use frequency based
> search to reduce number of entries in the OPP table.

GEN1x2, GEN2x1, etc are not "speeds".  I would say:

  Different link configurations may share the same aggregate speed,
  e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same speed
  and share the same OPP entry.

> Don't initialize ICC if OPP is supported.

Because?  Maybe this should say something about OPP including the ICC
voting?

> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));

Wrap to fit in 80 columns.

> +	 * Use highest OPP here if the OPP table is present. At the end of the probe(),
> +	 * OPP will be updated using qcom_pcie_icc_opp_update().

Wrap to fit in 80 columns.

> +	/* Skip ICC init if OPP is supported as ICC bw vote is handled by OPP framework */

Wrap to fit in 80 columns.

