Return-Path: <linux-pci+bounces-16181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE39BFA3E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0AEB214A1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C050201029;
	Wed,  6 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJZfy4fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2469383;
	Wed,  6 Nov 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936420; cv=none; b=aM1LrGhG4DNoU2jFcJFVg61NMUafJslMjpW/k+WxJ/y3JZS4uUTno+P71YUvQpe63VsWq+8IHJTqjsk397fGA4uvSvtizOLehqk/7YjogkdkplOPKe0Psjk7RvrP+VVd1aT07rLSBIvqUkr7k5xGjK2NjQAysf+Y2T5T3gO87Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936420; c=relaxed/simple;
	bh=CkGGHWsAOzlrkCRfO25nUXeUnK9cjDfpzkgHRPsMsIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ld+k+ENHIoa+ZFW+d4fArw13rFxDlLfcF8iUDR3cyKbYytv7gJd9iP9GForL6N1EsJikPcDBp2dnMvzdjg3uJqLJVUHgNRLGTQeht/RF3yzzpRBrf/bcj9psxgqNtGJH//8nuK/P+aHWuVuGqadRecCDicZYgfHsOErQm73w1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJZfy4fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A07C4CEC6;
	Wed,  6 Nov 2024 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730936419;
	bh=CkGGHWsAOzlrkCRfO25nUXeUnK9cjDfpzkgHRPsMsIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LJZfy4fXE8rdCT9INnntdHrIliXU/wiigikdb2LujfIuesFsgHjxQacPtd6you21Q
	 5Y7Yq4TF9YYqG8XiRSVdf4xoiGHQSJxL6kzX6hT1bL8OXTgyALmIv3efDZqzX3zKk4
	 m3dN0/rRI5irRke7cbgk+YVHfvLnvhzkj2BaLSOuVa/bZxWU+8SELp/Pkk5nDZxy+r
	 aCAh6AbGsuWqGIvnSaPFNUDtCm++/yfcMOrjan7A1imB1XBf38NWcyRX/AWfWXZu5w
	 K3O609rN1a/bDnTxVfYv/xWremg0FuQU2/6hksnP7x06KwTVTMOXyFCdGerrU6/jYP
	 tAY0B4jm2cRxA==
Date: Wed, 6 Nov 2024 17:40:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20241106234018.GA1581562@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCKTBuxKA8JdfYMCcGS=CpyuXGiLz1NdereCjqo-_2Er3Pfww@mail.gmail.com>

On Wed, Nov 06, 2024 at 06:00:08PM -0500, Jim Quinlan wrote:
> On Tue, Nov 5, 2024 at 4:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > PCIe controller driver.
> >
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> >
> > > +#define PCIE_EQ_PRESET_01_REG                0x100
> > > +#define PCIE_VAL_LN0_DOWNSTREAM              GENMASK(6, 0)
> > > +#define PCIE_VAL_LN0_UPSTREAM                GENMASK(14, 8)
> > > +#define PCIE_VAL_LN1_DOWNSTREAM              GENMASK(22, 16)
> > > +#define PCIE_VAL_LN1_UPSTREAM                GENMASK(30, 24)
> > > ...
> >
> > > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > > +{
> > > ...
> >
> > > +     val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > > +           FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > > +           FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > > +           FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > > +     writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> 
> Not sure it is worth the trouble to define fields.  In fact, you are
> already combining fields (rec+trans) so why not go further and just
> write each lane as a u16?
> >
> > This looks like it might be for the Lane Equalization Control
> > registers (PCIe r6.0, sec 7.7.3.4)?
> >
> > I would expect those values (0x47, 0x41) to be related to the platform
> > design, so maybe not completely determined by the SoC itself?  Jim and
> > Krishna have been working on DT schema for the equalization values,
> > which seems like the right place for them:
> >
> > https://lore.kernel.org/linux-pci/20241018182247.41130-2-james.quinlan@broadcom.com/
> > https://lore.kernel.org/r/77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.com
> >
> > Maybe that would be applicable here as well?  It would at least be
> > nice to use a common #define for the Lane Equalization Control
> > register offset from the capability base.
> 
> FWIW, these registers are HwInit/RO.  In our (Broadcom) case we have
> to write them using an internal register block that is not visible in
> the config space.  In other words, we do not use the cap offset.

Good point.  It looks like they're a mix of HwInit/RsvdP and
Hwinit/RO.  RsvdP is for writes, so I guess the config space registers
must be write-once and subsequently read-only until reset.  In any
case, mtk is using an internal register block as well, so a cap offset
wouldn't be useful.

Maybe it would still be worthwhile to define the fields themselves in
pci_regs.h so we can someday have common code to parse the DT
properties and assemble them.  Although I suppose there's no
requirement that the registers in the internal block even be laid out
the same as the config space register.

> > Although I see that no such #define exists in pci_regs.h, so I guess
> > there's nothing to do here yet.
> >
> > The only users of equalization settings I could find so far are:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-tegra194.c?id=v6.11#n832
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom-common.c?id=v6.12-rc1#n11
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-mediatek-gen3.c?id=v6.12-rc1#n909
> >
> > Bjorn
> >

