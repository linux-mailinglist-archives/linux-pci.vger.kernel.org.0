Return-Path: <linux-pci+bounces-36263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF02B59A14
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A581C00880
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5D311C3D;
	Tue, 16 Sep 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlzvzNC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919D2F83DE;
	Tue, 16 Sep 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032597; cv=none; b=IfZgSmqRbIuxDH2DTi5t3oDWM5X/1bhfymgvv9sV4R6QomfyYgI4j4BM9HLdYfrxBHZTFMKB1HUuEEgBeG660iKlNxbZUBS8n0LoLrdeUV1/z5vmlFhry54XUMZ/yjjETFA6ATjjWItdZ+7VrsDDdaL2P7abbVnLyWTEvbJaPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032597; c=relaxed/simple;
	bh=XEetWU2DNn7YAZx5ChfEf0v6aUr32SLIPyIUZ8Zz3MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QlWpoMDth7Av5a4XxGwnJTaq756zWjrd4UdSBX01WFQM6eEXrr667noM13Htt4oLXKVzFzqpaGGoZ249fE9hCOFVXAeRzWniVnQi434nPmWrIw6NtrGbe/65g7RlC3lxy630zqOHA/JLlQzis56pc90QWe/sXTJB39eCJr9iEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlzvzNC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA7C4CEEB;
	Tue, 16 Sep 2025 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758032594;
	bh=XEetWU2DNn7YAZx5ChfEf0v6aUr32SLIPyIUZ8Zz3MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dlzvzNC0id/9Fjio4OifV+Ag3lBlJaaRDquAue0R8OmXvrAukjZKbuTSxuuRYhmAk
	 RXGZp3DOO5NlOBBNvRKEHHwZULqo0LrQLOLieLA0/t83qvaM5ca3N4M/qo6nHNXHGs
	 UB7UjP9x4blU7OQJEmGnFDgST/9C7r/EZPeD+A9x5q/Wssi6m4HuMJf/0jbrRO6DHe
	 kht7STqv+PVoDKW7UdkuVnkqboi9RUt4NnJHKsnfXUAVqLUd04WpFjdnOzPzgvo64I
	 1BPryxHuYLxMF95WXT+0uERSEdBWB0kmL3P6bNiqJmOPdqQ49COdZVdfFkQC0wGNHG
	 3Sc6o3r190EJA==
Date: Tue, 16 Sep 2025 09:23:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <20250916142313.GA1795171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDog36hBZ0XvhC-NyfL0SwB5ve53nLFpofToKt1ebhuGQ@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > Describe the PCIe controller available on the S32G platforms.

> > > > +                  num-lanes = <2>;
> > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > >
> > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > Please put them in a separate stanza.  See this for details and
> > > examples:
> > >
> > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> >
> > Ok, I'm going to have a look
> 
> This driver relies on dw_pcie_host_init() to get common resources like
> num-lane which doesn't look at childs to get num-lane.
> 
> I have to keep num-lane in the pcie node. Having this in mind should I
> keep phys as well as they are both linked ?

Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?

dw_pcie_host_init() includes several things that assume a single Root
Port: num_lanes, of_pci_get_equalization_presets(),
dw_pcie_start_link() are all per-Root Port things.

Bjorn

