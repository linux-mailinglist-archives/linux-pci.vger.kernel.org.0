Return-Path: <linux-pci+bounces-38833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE32BF44A2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 03:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 692FD351F81
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028923D7DB;
	Tue, 21 Oct 2025 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTlt2Lad"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609515D1;
	Tue, 21 Oct 2025 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011034; cv=none; b=OXEZPFY0lniTH26SFf7uUOTXD9zRO21jZrGRotBl8QJLCDoDTuAzZQhAcl087acOaCPPpKc0+6KkrDELe477sUU6UR2mnX8gIRqXn0057V5qm9bDtxWPw9dXMep0SvuzQP2DsxWGSxFREFISqmeCJHceyrfvvpwK92vDih+umNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011034; c=relaxed/simple;
	bh=1WKtCB5AhrFfORNLMEgBu5CyX6aGiLkLwQM4OsgYaIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laHnyfPU220iCfQOoRHEsBdQBReuLQjKd7rbKIpB9SB4UcEBnY169oMuE1X8q/jP3Zh4+BEigkP8xg2Q/wMBKgPerYm7YfVnT32nw1QjI7YFjMI/OTs8igdKS6dTTmjRr9lkFqXx4NvHl123LcefqndZPhH5O5Od90QtSIvJEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTlt2Lad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF57C4CEFB;
	Tue, 21 Oct 2025 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011032;
	bh=1WKtCB5AhrFfORNLMEgBu5CyX6aGiLkLwQM4OsgYaIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTlt2Lad2t1VZP8oQUT1/MYv3J4mNf6kz5yhAGlr1hg9W1ruLo/PbwKhzmt8vOS8W
	 pjcMvdYuMAe3w6+AqCkrpT7wMrfTaKQjtpNfaduKniIm66uHtBFbdljUpOxaMOfxWG
	 CbTdMkgfKnc2BMIf4eWIpT6aVgRxQTO03JDi1KlwQ/qHdG4gESii2TVSgfQp9d86N9
	 0+XjTPRP5892Lwia9r5/wB9A7XevUxjpm/7gk/x+n0H16LpHugp3QcMbc+lDwBet2u
	 bJvDoLSUzM+Vnj4FMciVd9dymGQQ/0Biy6NsnQO6PShOtVFw/IdFYlxzI6x1pYK3R6
	 qt0REkGfU5Fhg==
Date: Tue, 21 Oct 2025 07:13:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v1 3/5] PCI: tegra: Use readl_poll_timeout() for link
 status polling
Message-ID: <6eqqafz2dojo533fw2j7say3p37simug5bol2s5dvcpac77jzb@2x22ekyl4qdq>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-4-linux.amoon@gmail.com>
 <ose3ww7me26byqwsyk33tipylkx3kolnc3mjwrlmjwsmza2zf3@os7lkt4svaqi>
 <CANAwSgT0VRFFpKv3saJTAA99oGoAHhP+bx6Xe-QGf5b4Dgik=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgT0VRFFpKv3saJTAA99oGoAHhP+bx6Xe-QGf5b4Dgik=A@mail.gmail.com>

On Mon, Oct 20, 2025 at 05:47:15PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> Thanks for your review comment.
> 
> On Sun, 19 Oct 2025 at 13:20, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:57:44PM +0530, Anand Moon wrote:
> > > Replace the manual `do-while` polling loops with the readl_poll_timeout()
> > > helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> > > during link bring-up. This simplifies the code by removing the open-coded
> > > timeout logic in favor of the standard, more robust iopoll framework.
> > > The change improves readability and reduces code duplication.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v1: dropped the include  <linux/iopoll.h> header file.
> > > ---
> > >  drivers/pci/controller/pci-tegra.c | 37 +++++++++++-------------------
> > >  1 file changed, 14 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > > index 07a61d902eae..b0056818a203 100644
> > > --- a/drivers/pci/controller/pci-tegra.c
> > > +++ b/drivers/pci/controller/pci-tegra.c
> > > @@ -2169,37 +2169,28 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
> > >       value |= RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
> > >       writel(value, port->base + RP_PRIV_MISC);
> > >
> > > -     do {
> > > -             unsigned int timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
> > > +     while (retries--) {
> > > +             int err;
> > >
> > > -             do {
> > > -                     value = readl(port->base + RP_VEND_XP);
> > > -
> > > -                     if (value & RP_VEND_XP_DL_UP)
> > > -                             break;
> > > -
> > > -                     usleep_range(1000, 2000);
> > > -             } while (--timeout);
> > > -
> > > -             if (!timeout) {
> > > +             err = readl_poll_timeout(port->base + RP_VEND_XP, value,
> > > +                                      value & RP_VEND_XP_DL_UP,
> > > +                                      1000,
> >
> > The delay between the iterations had range of (1000, 2000), now it will become
> > (250, 1000). How can you ensure that this delay is sufficient?
> >
> I asked if the timeout should be increased for the loops, but Mikko
> Perttunen said that 200ms delay is fine.
> 

readl_poll_timeout() internally uses usleep_range(), which transforms the 1000us
delay into, usleep_range(251, 1000). So the delay *could* theoretically be 251us
* 200 = ~50ms.

So I doubt it will be sifficient, as from the old code, it looks like the
hardware could take around 200ms to complete link up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

