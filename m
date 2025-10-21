Return-Path: <linux-pci+bounces-38921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131CBF786D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3788D4FDC86
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A5355057;
	Tue, 21 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neAq776I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D23431FF;
	Tue, 21 Oct 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062224; cv=none; b=NS56bFHC9CA3Yf3GoAkkP0Y37xDR1K654hpj+woFyex7ScL0jlYfiU5dB273tuEytBrKzbNgSWzGS0FF6HS6yrIKgirmyQShknv6sK72vZrvPKCg9PoAyGHw5+ulDa0pfrun9dLVVYZG7uxLoLeWPK39CKgJsqZGcjHTbYjnh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062224; c=relaxed/simple;
	bh=3Tpx8/zEzc/sy6ATcQr2dHJqhvmbjFFSErsGZF0iSBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nK8ozNWZud61bjPD+nLudl52Lbmf86kTwy8sUGY+UKwLoFjFjpJod5HlLmqK6FpCwrg8XKEx87fT1orxRS95bXYD8iIqzv9enuSeRnZRzS+dGzcR0uMZ1XW5BdVmeZ0BfJ+s56hLPwP5RLAhptp9Rr643BEpyLzZBXgbxDlEgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neAq776I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D9C4CEF1;
	Tue, 21 Oct 2025 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062224;
	bh=3Tpx8/zEzc/sy6ATcQr2dHJqhvmbjFFSErsGZF0iSBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=neAq776IgYAAsIkIK3t7gtlBbOzeG3elrHG44YOAT2lel31tnaRy6sFVYqKtNouZc
	 2qJAL1kLOLPx4SgySEjke88Mn6KLr/m9ia2IHVVMCm9iSbHaxied1n1FTKrq2hSnWj
	 d5YPCIOB1RElZBWAicuRJtypSBBN5vIF1JjhdRi8ux1dDS5eelYO6LLOHdc4jM2AXW
	 5x3Y8VQ+ihJZCIYAv9MgrtDDfqUYFMBmVvPESdvjXGJU1Z7rUMmV2ljY/NfRmqIKU7
	 /mzvezg4WrEQXdoBwHQZS7JWDsin71plP5iOiJq0267SdjqRqKW+M/DHeNxj8wHfk0
	 58zaG0qYPhN+Q==
Date: Tue, 21 Oct 2025 10:57:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Message-ID: <20251021155702.GA1193049@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80e1d58-cae1-4f3b-8b66-fc920ad4c5ba@oss.qualcomm.com>

On Tue, Oct 21, 2025 at 05:42:39PM +0530, Krishna Chaitanya Chundru wrote:
> On 10/18/2025 12:40 AM, Bjorn Helgaas wrote:
> > On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru wrote:

> > > +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> > > +{
> > > +	struct pci_config_window *cfg = bus->sysdata;
> > > +	struct dw_pcie_rp *pp = cfg->priv;
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	unsigned int busn = bus->number;
> > > +
> > > +	if (busn > 0)
> > > +		return pci_ecam_map_bus(bus, devfn, where);
> > 
> > Is there a way to avoid the "root bus is bus 00" assumption here?  It
> > looks like something like this might work (it inverts the condition
> > to take care of the root bus special case first):
> > 
> >    if (bus == pp->bridge->bus) {
> >      if (PCI_SLOT(devfn) > 0)
> >        return NULL;
> > 
> >      return pci->dbi_base + where;
> >    }
> > 
> >    return pci_ecam_map_bus(bus, devfn, where);
> > This is working fine Bjorn, shall I send v2 with this change.

Yes, please :)

