Return-Path: <linux-pci+bounces-20189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB06A17EBA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 14:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5E3A2857
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F94437A;
	Tue, 21 Jan 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu+4hMmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB02219FC;
	Tue, 21 Jan 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465526; cv=none; b=o0Ibfq6qKHhWCsnHHuNYDq4cWCf3lJmVfa6MBt0sZGzQvpN/cu7Ngstj1gpiS8WFbBHUP3q4GN4DODMlc+aPBIjZoPlGRG+Ryeu3ZXpSvMp5jyr7fu4iVTHiXN6SQAlFCYKBbw6deFusBRI03JKPywXtDZb6O5vs6tiWFHl3BWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465526; c=relaxed/simple;
	bh=MuYGISXNRVMNaSs05q2YDQ7DN6hiegO5L08Iz8kLAbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjJwQ1aPkbThQiFZimmB1iea98ApVsJuR7uiSegCA9ocq26jYq8T3NJFdoF3Pgv9GLO6JWSZGj+79pUpB5ICjCdngJstSu+qvgg91l2adeaQWLtuBALU//IJK8Og4QKH8DLkDeflWsVayD3x9aYKds6oQqk3/wJ9XQrzpBtYjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu+4hMmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9EC4CEDF;
	Tue, 21 Jan 2025 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737465525;
	bh=MuYGISXNRVMNaSs05q2YDQ7DN6hiegO5L08Iz8kLAbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lu+4hMmr7Oqr6PLD1o9KOdkwHLZzdF/qTW2a0qHWn4glg/ACILOpElK4pdMqyURyi
	 TfxCQUza1ewTEYm31dbx4RPK2sGYeJN3JSasIZwEYuI0Yh/P6URQNOqUT7kjApp+AU
	 rRAdNQzxs5iHh3FalN70e0BHLghd1unJHhk8gIWhbDrdHLOmQzF/09AUaOD77UEv5Y
	 LcxDnxmkNcc2sanqrckRlxup1uPSuGJWuq0H50ZPcZiddcqArcKcdO+lSV0/NiWuG/
	 pRMtfr0CU/uqxLZljhEjo4x1Rn5atwp5or3yXbeU7ZYq72s8hcQSYfwi+Z4nI1YBX1
	 erT03jT26Kk0g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1taE9Z-000000005RC-1yRg;
	Tue, 21 Jan 2025 14:18:49 +0100
Date: Tue, 21 Jan 2025 14:18:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	rafael@kernel.org, ulf.hansson@linaro.org,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <Z4-eufq4M04XHjck@hovoldconsulting.com>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
 <Z44llTKsKfbEcnnI@hovoldconsulting.com>
 <20250120152829.7wrnwdji2bnfqrhw@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120152829.7wrnwdji2bnfqrhw@thinkpad>

On Mon, Jan 20, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 20, 2025 at 11:29:41AM +0100, Johan Hovold wrote:

> > I'd argue for reverting the offending commit as that is the only way to
> > make sure that the new warning is ever addressed.

> How come reverting becomes the *only* way to address the issue?

I didn't say it was the only way to address the issue, just that it's
the only way to make sure that the new warning gets addressed. Once code
is upstream, some vendors tend to lose interest.

> There seems to
> be nothing wrong with the commit in question and the same pattern in being used
> in other drivers as well. The issue looks to be in the PM core.

After taking a closer look now, I agree that the underlying issue seems
to be in PM core.

Possibly introduced by Rafael's commit 6e176bf8d461 ("PM: sleep: core:
Do not skip callbacks in the resume phase") which moved the set_active()
call from resume_noirq() to resume_early().

> Moreover, the warning is not causing any functional issue as far as I know. So
> just reverting the commit that took so much effort to get merged for the sake of
> hiding a warning doesn't feel right to me.

My point was simply that this commit introduced a new warning in 6.13,
and there is still no fix available. The code is also effectively dead,
well aside from triggering the warning, and runtime suspending the host
controller cannot even be tested with mainline yet (and this was
unfortunately not made clear in the commit message).

The change should have been part of a series that actually enabled the
functionality and not just a potential piece of it which cannot yet be
tested. Also, for Qualcomm controllers, we don't even yet have proper
suspend so it's probably not a good idea to throw runtime PM into the
mix there just yet.

But, sure, a revert would have made more sense last week. I guess you
have a few more weeks to address this now. We can always backport a
revert once rc1 is out.

Johan

