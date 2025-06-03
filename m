Return-Path: <linux-pci+bounces-28860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B66ACC8C4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68C53A4BB6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0B239099;
	Tue,  3 Jun 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfiIq1Zh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32D239086
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959702; cv=none; b=WTe8vYSg1N0bQ7XPL/qBTY+d9C49hm39DOKQ6ULFIpeOMX/skdaloAaQ61BZ32zOtdIfpZ4fp+RP23/j6eRJ+tbev0SyzdqZBWYMSeRSewj3y4otkgcgk5GxQ25DwtbbbiwbJ4Y3e4XPxk3HVGm9eBCJ1hXhiHNj0fgO8yPxhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959702; c=relaxed/simple;
	bh=GSLFrdjvG8RldMoj4IELfQn2sm484jTH1lKYktZEKTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELmXTMeHB3ZtHy/FXaneJadf1adAvQmxMqIUExAjPtdaw4zBNfoDrfOGW7fuSsP0WTYfDggY6tEq2YwosL5mezG3yH7rW9Dy444f95yXPtEme5qtA1BYWuNRX/h6CXdaik6fUMlt2HiFi+xogvhVXIoTktmBvZtf07I+3JqOwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfiIq1Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7064C4CEF0;
	Tue,  3 Jun 2025 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748959701;
	bh=GSLFrdjvG8RldMoj4IELfQn2sm484jTH1lKYktZEKTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfiIq1ZhOVZHTwSXrTE1c02luHTBGAGqgJJymOpNj0PubwN/lk2m6GoEhswr2IATO
	 TUNJe2kppWhiXa2m9DJ/B4DhPZNXx9CPwdmPSxYBmQbSIJGF8mqFXxlWPDUwFCzEZI
	 aORv5slprcs6Pk8CmTwabGbs8GRNwaT0ruYwO6vnVQRwt/FNc6S+NbWsyYw9ZhOilo
	 w3lWa82IEaHxofNSh80wuQYRXV1SYqHzj/RYY/Virsz0o02nHZtLjOHV47Aj7yuKam
	 w8N22RuQCtqMqdo1hSeyIw3bhO/FCwt5bDVLlkq0r63UZB/rEsCEsvdkoEG6wyyQA4
	 nVDH1ytHohV8w==
Date: Tue, 3 Jun 2025 16:08:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <aD8Bz4CkdnAd8Col@ryzen>
References: <76F22449-6A2D-4F64-BF23-DF733E6B9165@kernel.org>
 <20250530194347.GA217284@bhelgaas>
 <domwxd2beelpnuuzgbxuizqnfo24aekhtxsahodsbfkpc3n6fd@rahjejxklr47>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <domwxd2beelpnuuzgbxuizqnfo24aekhtxsahodsbfkpc3n6fd@rahjejxklr47>

On Sat, May 31, 2025 at 12:17:43PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 30, 2025 at 02:43:47PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 30, 2025 at 07:24:53PM +0200, Niklas Cassel wrote:
> > > On 30 May 2025 19:19:37 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > >I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
> > > >from Conventional Reset (if port only supports <= 5.0 GT/s) or after
> > > >link training completes (if port supports > 5.0 GT/s).
> > > >
> > > >> So I don't think this is a device specific issue but rather
> > > >> controller specific.  And this makes the Qcom patch that I dropped a
> > > >> valid one (ofc with change in description).
> > > >
> > > >URL?
> > > 
> > > PATCH 4/4 of this series.
> > 
> > If you mean
> > https://lore.kernel.org/r/20250506073934.433176-10-cassel@kernel.org,
> > that patch merely replaces "100" with PCIE_T_PVPERL_MS, which doesn't
> > fix anything and is valid regardless of this Plextor-related patch
> > ("PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
> > ready").
> 
> It is patch 2/4:
> https://lore.kernel.org/all/20250506073934.433176-8-cassel@kernel.org


Hello all,


I'm getting some mixed messages here.

If I understand Bjorn correctly, he would prefer a NVMe quirk, and looking
at pci/next, PATCH 1/4 has been dropped.

If I understand Mani correctly, he thinks that we should queue up PATCH 1/4
and PATCH 2/4 (although with modified commit messages).

So, what is the consensus here?


As you know, I do not have the (problematic) Plextor drive, so we go with
the quirk option, then we would need to ask Laszlo nicely to retest.
(And to provide the PCI device and PCI vendor ID of his NVMe device so we
can write a quirk.)


Kind regards,
Niklas

