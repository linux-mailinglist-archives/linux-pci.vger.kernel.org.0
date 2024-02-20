Return-Path: <linux-pci+bounces-3799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5885CB93
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 00:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876FE1C21B0C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51472154425;
	Tue, 20 Feb 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgmqLd2t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831B6BB28;
	Tue, 20 Feb 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470051; cv=none; b=t4d9mzzynwwn2oPdiC/oVOlJRvBsKmLXd4BWb/zVqYJOsZJwG7iZtBTgdbwNPl1JR3bL827oNC4Ncg4FQ8q9Ndi6+drcoYjrmcHo8AU2A0nBAe0bva0jRt6tXjo+t8XX9fN7jqFuOWaFV+BncWkCZDax2ocJzmI4DRrGZ1PN7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470051; c=relaxed/simple;
	bh=jKBfjTUdRWgFvuI3OGU/e3rvaepyJgkddbWLEUWTlPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CJJtnnkvYNsQsa2BRiR5YPMXsZG3UD+3xpx5FTfBfdbtp7P7DV5BFvHxqXV0fIW9RsfVwbl5tul4/qkheyDTP1uteRasoZxe/Tel7jtqSpyOgsEvfA80gI453xvTgIfCsceTAEl+3GZJQYG8erJ2s9vyZw7SFEX1apSw2GNmFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgmqLd2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E2C433F1;
	Tue, 20 Feb 2024 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708470050;
	bh=jKBfjTUdRWgFvuI3OGU/e3rvaepyJgkddbWLEUWTlPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KgmqLd2tP8VN28KBXvqfoz5j7uiJ08OgTk4ShX+dOx2HMSWw4hDan7a7SCxg/nnHB
	 2N9pySZlUtoIxD0Q6t/dJtixyCnmiZuvRUGgUNenZ+w7n7VA0ZY4cl5WyCMbG/nN1k
	 CrD5b/4mBHLMRtEswJPCF/mC4DFvs+BPnupF1jrFbYqJ28mw1ABpWDjQbIPg3KFJOe
	 C5eOVneKv7jaLOfMm9Yr+h62mbeNLqIc9+eBwXV59xA6MU26nWbB0YEpwzNRIEviPC
	 Z4sLU6Ky6RuoLo/oPngPgnRSDlj9dXZlX1sRXG3siaWmpX9QGmbU7CwFtXBOenAt8S
	 SWmZN18sXLDqQ==
Date: Tue, 20 Feb 2024 17:00:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Message-ID: <20240220230048.GA1511259@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRhfCXejhrKQLPC@hovoldconsulting.com>

On Tue, Feb 20, 2024 at 09:23:24AM +0100, Johan Hovold wrote:
> On Thu, Feb 15, 2024 at 06:46:55PM +0100, Konrad Dybcio wrote:
> > On 15.02.2024 18:02, Bjorn Helgaas wrote:
> > > On Thu, Feb 15, 2024 at 02:35:13PM +0100, Alexander Lobakin wrote:
> > >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> > >> Date: Thu, 15 Feb 2024 11:39:31 +0100
> > >>
> > >>> According to [1], msleep should be used for large sleeps, such as the
> > >>> 100-ish ms one in this function. Comply with the guide and use it.
> > >>>
> > >>> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> > >>>
> > >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > >>> ---
> > >>> Tested on Qualcomm SC8280XP CRD
> > >>> ---
> > >>>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > >>>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
> > >>>  2 files changed, 2 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > >>> index 250cf7f40b85..abce6afceb91 100644
> > >>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> > >>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > >>> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > >>>  		if (dw_pcie_link_up(pci))
> > >>>  			break;
> > >>>  
> > >>> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> > >>> +		msleep(LINK_WAIT_MSLEEP_MAX);
> > >>
> > >> Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
> > >> function to pick.
> > 
> > IMO, fsleep only makes sense when the argument is variable.. This way, we
> > can save on bothering the compiler or adding an unnecessary branch
> 
> I fully agree. Using fsleep() with a constant just looks sloppy (e.g.
> with that hardcoded usleep range) and hides what is really going on for
> no good reason.

Why does it look sloppy?  I'd be surprised if using a constant led to
more executable code, given that fsleep() is inline.  I'm all for
having the compiler choose the right thing instead of having to look
up the guidelines myself.

Bjorn

