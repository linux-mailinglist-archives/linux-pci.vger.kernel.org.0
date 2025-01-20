Return-Path: <linux-pci+bounces-20137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B3A16AC2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932EE1889ED1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6A1B413E;
	Mon, 20 Jan 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hro/JAcX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB418FDC8;
	Mon, 20 Jan 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368980; cv=none; b=jsFCy/BaT52dhiKk5LNG4S2kIPpouk40GZpB+gtYqmpWk2epbbw91JiLRyEfERmMxMdVYc8F3bG/WzEF9u8At+mCieUYgPweSFf2RytssYTgpELEAgkO/L+8EjV/8HPGIhpsZNoLd8D54Hl0g2RX/Rq7+hs3ANcO2QU/r/99exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368980; c=relaxed/simple;
	bh=5+KuJyvD0Cc+bCHcr9Ef9KT8l8mKwIGskoiH678TfHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHyXlH/KSuOcECN/M+mqC/38DpzmwhOd+jIDNv8R/HFu4XYDaNlm48Z8p5kOkREwkDqFlGiKsFUo2UMGCgnTmlXePBawdwscdX3SAZOq3MrfzUY3QNY4EwuS3gNau4XlCHofv5QdgWTT3fys22NLa8yGZERJVoblFCBhgvy6lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hro/JAcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9DEC4CEDD;
	Mon, 20 Jan 2025 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737368979;
	bh=5+KuJyvD0Cc+bCHcr9Ef9KT8l8mKwIGskoiH678TfHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hro/JAcXZ0b8TgiIvv+8tEIDQEE9Kqgy3/W9FyrH5TnLwxwaJMuWLvi9hOmvTZ4qQ
	 /qaBoN75okTuDGxiGXKZx71yuoiAWJIjU/7Y8t/ttucGzfRgwIXJ2oLSpqP0d1b5ey
	 QmME3Bz1fnM2HoufpTuX9CWGyGJfPyWas+ocqRDhhGmEfvBDbWbgjXaMplEwPrOOl0
	 s0NbNrF9cCyLCZJ0pR/Ee8RqwEiB1W7Phh+1AAAfu9WXM6Nwwkdui78X5yhOkxHJX/
	 RBvjIIQM4qPcl6baRqV01CfqTzv0ZF06q2N+0jSoMN5GhxdZMBuWQrtu/7sHOd2Cjx
	 uhP1tE4xnMvJg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tZp2L-000000007D4-39CR;
	Mon, 20 Jan 2025 11:29:42 +0100
Date: Mon, 20 Jan 2025 11:29:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, rafael@kernel.org,
	ulf.hansson@linaro.org, Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <Z44llTKsKfbEcnnI@hovoldconsulting.com>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119152940.6yum3xnrvqx2xjme@thinkpad>

On Sun, Jan 19, 2025 at 08:59:40PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 14, 2025 at 03:16:53PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 13, 2025 at 09:55:49PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:

> > > > > > I just noticed that this change in 6.13-rc1 is causing the
> > > > > > following warning on resume from suspend on machines like the
> > > > > > Lenovo ThinkPad X13s:

> > > > > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children

> > > > > > which may have unpopulated ports (this laptop SKU does not
> > > > > > have a modem).

> > What's the plan for this?  Does anybody have a proposal?
> > 
> 
> TBH, I don't know how to fix this issue in a proper way. I need inputs from
> Rafael/Ulf.
> 
> > IIUC there is no functional issue, but the new warning must be fixed,
> > and it would sure be nice to do it before v6.13.  If there *is* a
> > functional problem, we need to consider a revert ASAP.
> > 
> 
> There is no functional problem that I'm aware of, so revert is not warranted.

I'd argue for reverting the offending commit as that is the only way to
make sure that the new warning is ever addressed.

Vendors unfortunately do not a have a good track record of following up
and fixing issues like this.

Judging from a quick look at the code (and the commit message of the
patch in question), no host controller driver depends on the commit in
question as the ones that do enable runtime PM just resume
unconditionally at probe() currently (i.e. effectively ignores the state
of their children).

Johan

