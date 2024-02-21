Return-Path: <linux-pci+bounces-3816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1785D80D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 13:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1447283104
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A469311;
	Wed, 21 Feb 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISW2JygL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C26930C;
	Wed, 21 Feb 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519226; cv=none; b=HMvKGGuPAPGa/kT2wnwVX0pWKFdo2viTwAH8/tpxsjIdzTGqOzYSdpwTmIQnbYIDWoj/c9mSB5EXfpHUTTOYDw6P+ryCy+qzeLSv1O8qMVNQjmlSsZpYldOLu5HVaapNyyNwqfzz9Uw1H6oGaVmagN60/K6Xf0zBmbtAEBd3Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519226; c=relaxed/simple;
	bh=mySX1ne+VVu/IzcUye/DqZlRl18q3rR0tlVeJkzE5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/4yD0BUsGcZsKqjGMjj2EwtQdZZWMQJ1o9QNkaN90alg9YUW6sa/IxGeZDJY4M/I7LQoaoJ4mHiZSD0rlYjnqbs+sjH4Pu1RXLqLiLxe9IwzvcozkEVjdzoaIYer7c6Zn7BTANjhTmIYGA9RQe5lKZerFF9SLhn5yNXN1uZhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISW2JygL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C0C433F1;
	Wed, 21 Feb 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519226;
	bh=mySX1ne+VVu/IzcUye/DqZlRl18q3rR0tlVeJkzE5/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISW2JygLXhMELVUdE3zkaJPH2wFaQGqCllLwdjxL0zhHfX5micPxv93tO3FIRp+hS
	 egiccIPkd0sXZYuDjukp/XMZaxdMSTD76c4ypMNxVotZG/2gtsna1ezbNVPDzD5ckQ
	 dprnnU4OvuljGRuK81rIZm87vRzPjSVVDlnH9atKIlhP1sp/eriVs3roV9XwknGzHP
	 0Lyquo9ueMetKzppKM2g9+KXAPPB5MER7TSe+R8rBIbHaUR/d5SX/VJHTVPs26RyV0
	 L0DkMSr/5dJPCD/M5MzkYLm53o884/fahkHSCJpVYEVgePYqAzWEjUpR50obnYdKuB
	 nVie4I1PHiKIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcltj-000000001dB-2uhu;
	Wed, 21 Feb 2024 13:40:28 +0100
Date: Wed, 21 Feb 2024 13:40:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZdXvO6q8IQWQlGk5@hovoldconsulting.com>
References: <ZdRhfCXejhrKQLPC@hovoldconsulting.com>
 <20240220230048.GA1511259@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220230048.GA1511259@bhelgaas>

On Tue, Feb 20, 2024 at 05:00:48PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 20, 2024 at 09:23:24AM +0100, Johan Hovold wrote:
> > On Thu, Feb 15, 2024 at 06:46:55PM +0100, Konrad Dybcio wrote:
> > > On 15.02.2024 18:02, Bjorn Helgaas wrote:
> > > > On Thu, Feb 15, 2024 at 02:35:13PM +0100, Alexander Lobakin wrote:

> > > >> Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
> > > >> function to pick.
> > > 
> > > IMO, fsleep only makes sense when the argument is variable.. This way, we
> > > can save on bothering the compiler or adding an unnecessary branch
> > 
> > I fully agree. Using fsleep() with a constant just looks sloppy (e.g.
> > with that hardcoded usleep range) and hides what is really going on for
> > no good reason.
> 
> Why does it look sloppy?  I'd be surprised if using a constant led to
> more executable code, given that fsleep() is inline.  I'm all for
> having the compiler choose the right thing instead of having to look
> up the guidelines myself.

It's not about the generated code, but about hiding what's really going
from kernel developers that should be aware of such things. The fact
that you end up with an usleep range of 20 to 40 ms if you want to sleep
for 20 ms is not very nice either.

Except possibly for a few cases where you'd otherwise end up open-coding
fsleep() I don't think there's any reason to use it.

Johan

