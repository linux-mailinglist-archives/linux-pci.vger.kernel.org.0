Return-Path: <linux-pci+bounces-35533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67ABB45C89
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C446AA020D5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74C2FB080;
	Fri,  5 Sep 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccCQGv8S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94C231845;
	Fri,  5 Sep 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085970; cv=none; b=qmu/LPtEj3sRXeeuy/MQD3UtZMZhP1dNCylbc3Xwq3oa66Jnl8B2xKpn28Kd3f1c78PxGgkY8dye56sdzg/4EAzZ5IKpMr+48ozgxsHni2/+pz3sgsxRL9kGAGwDREBMpWXX0ZmQaOExrFMo/Q5Mhik2p/O1nJPpvofcAPtqtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085970; c=relaxed/simple;
	bh=d84qHJOKae+uQlsSzi8MeOLR+fbLmJB9FdZwQLaJoN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u6rLb73GlbVSExsTKwZqGNIDcROAv5Crhq07ffTTy44x1RoQh1SQIX7W3hetsd5jRpt2JhcXWPfdFrUBiWFFrwqcUPTPJWiihYCnO5DuuIxS7ikvHRDmYrEhiG+dSpf1ZqPQRZORL291yv63J9hGMKkhrYQmoMAi+J7PN4KW9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccCQGv8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1649FC4CEF1;
	Fri,  5 Sep 2025 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085970;
	bh=d84qHJOKae+uQlsSzi8MeOLR+fbLmJB9FdZwQLaJoN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ccCQGv8SBYYUdxV2oW25sTbpCs4xUYzFu5kokr6HhIMR+8+38U7MfvcSdqzKnuo0V
	 Kz55FmdR4VH9Z9e6Q0BpJrN2CGIvZKA2oHm+iRJsSQsjppWLaP5+Rk/rWL378I88a8
	 BMqbZMkzxrbw7d2JWBCIt4ZWvUxT5EzQ3BNDNAiVwsylscYKzJfdiqZfVXnQmtFCoU
	 37kCeF7MZReusr5rj2+upd8ucYpHLPGwyOAfIIZ8hwLw4uwMGBemOy1ibLVppkxlHq
	 ++LVuIP5tjOZkuGgBhonnOTcc6h2D6tqzYEdQLjayc2O7eG4Z+cE2kiKq2wf7vDAkH
	 C4Zzh7yfy5lZA==
Date: Fri, 5 Sep 2025 10:26:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
Message-ID: <20250905152608.GA1305931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d44c24-d853-4128-b966-8a25aaefad73@oss.qualcomm.com>

On Fri, Sep 05, 2025 at 10:47:42AM +0530, Krishna Chaitanya Chundru wrote:
> On 9/4/2025 1:42 AM, Bjorn Helgaas wrote:
> > On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
> > > The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> > > gives us the offset from which ELBI starts. So override ELBI with the
> > > offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
> > > 
> > > On root bus, we have only the root port. Any access other than that
> > > should not go out of the link and should return all F's. Since the iATU
> > > is configured for the buses which starts after root bus, block the
> > > transactions starting from function 1 of the root bus to the end of
> > > the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> > > outside the link through ECAM blocker through PARF registers.

> > > @@ -1322,6 +1383,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	if (ret)
> > >   		return ret;
> > > +	if (pp->ecam_enabled) {
> > > +		/*
> > > +		 * Override ELBI when ECAM is enabled, as when ECAM
> > > +		 * is enabled ELBI moves along with the dbi config space.
> > > +		 */
> > > +		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
> > > +		pci->elbi_base = pci->dbi_base + offset;
> > 
> > This looks like there might be a bisection hole between this patch and
> > the previous patch that enables ECAM in the DWC core?  Obviously I
> > would want to avoid a bisection hole.
> > 
> > What happens to qcom ELBI accesses between these two patches?  It
> > looks like they would go to the wrong address until this elbi_base
> > update.

> > Is this connection between DBI and ELBI specific to qcom, or might
> > other users of ELBI (only exynos, I guess) need a similar update to
> > elbi_base?
> > 
> This is specific to QCOM only, with the commit 10ba0854c5e61 ("PCI:
> qcom: Disable mirroring of DBI and iATU register space in BAR region")
> The DBI address can moved to upper region of the PCIe region. When DBI
> is moved ELBI also moves along with it. So if this patch is not present
> elbi will not point to correct ELBI address.

So I think you're saying this [5/5] patch should be squashed into the
[4/5] patch that changes the way pci->dbi_base is computed?

After [4/5], pcie-qcom.c still uses pci->elbi_base, but apparently the
value is wrong until this update in [5/5]?

Bjorn

