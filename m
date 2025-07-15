Return-Path: <linux-pci+bounces-32151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A51B05A31
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A10B4A42ED
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55802DEA6A;
	Tue, 15 Jul 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYCsxBJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85274274670;
	Tue, 15 Jul 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582670; cv=none; b=MkIrlABGU+snZHanwZcQljpsnpyBNOeGohCyM/sPzG/i9Gpc212VQ6btg6q9IqSjrgSp6QK8jWrfxTVnDpWfaVg3cZEOSyFoUJYtshPXzJIpFRHDzY52LIsVNGFLmXPkMy1SG+SPbdC0h7vggUtcPmpFlCethNGT8P5Vg9eE6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582670; c=relaxed/simple;
	bh=T1kRkbMbFy0pFWhOLhwbNykdfC7wFmv/WTrdLgvck6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJp62oIsYqgT5NhwBakhbnpykfHNixuLSgjpUAql8gxWdBQM3YLmAr8UdPTZGA/Dnbg+E0cXhNOo3nWSqpjuArGhQsUUJwkLFKSFZEaI+7w3ysI82z0K8g3/8VHEukWxJAqhQcGI6GHtNlaXEcQogBknbvazxYBSWnklF/fCVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYCsxBJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67478C4CEE3;
	Tue, 15 Jul 2025 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752582670;
	bh=T1kRkbMbFy0pFWhOLhwbNykdfC7wFmv/WTrdLgvck6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYCsxBJnRHRyFfKAR8IQhOrM0qHfEma/BetdIk8M7+tTmfgLrdxy9lT9q7832Ntxb
	 v2sJeaIHduxsNo6IzD/wYzP+hKnmvoYbGYXpywOQuvsLxH393WIQBB8k3jlqwzgiXh
	 DnQhXpneYjrYLyqs5cQUumvShn01SFjp3PDJMPNnLhGGluh00oBIqpLkOwem65yARi
	 QXfCB0RYPr3AyolFWWY8v9W9Rttp0FKbfB4m8KEXT5cLm8drqUeF2nMCtQE5XBtTdH
	 r2Lia5gLtLfOLk+n/bf+ofjkw39hmqEGRiuDrtExVszp6TLtXdE13iDDunu4B6Ay3U
	 jIslcbRKdC56g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubeoL-000000008Eb-3LCP;
	Tue, 15 Jul 2025 14:31:06 +0200
Date: Tue, 15 Jul 2025 14:31:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <aHZKCXNu6k0hZbVg@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aHYHzrl0DE2HV86S@hovoldconsulting.com>
 <yqot334mqik74bb7rmoj27kfppwfb4fvfk2ziuczwsylsff4ll@oqaozypwpwa2>
 <aHYgXKkoYbdIYCOE@hovoldconsulting.com>
 <jmj2aeuguitas75xxos4wbhqjoaniur7psoccfxqniask7yxcu@3azibftfflch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jmj2aeuguitas75xxos4wbhqjoaniur7psoccfxqniask7yxcu@3azibftfflch>

On Tue, Jul 15, 2025 at 03:57:12PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 11:33:16AM GMT, Johan Hovold wrote:
> > On Tue, Jul 15, 2025 at 02:41:23PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 15, 2025 at 09:48:30AM GMT, Johan Hovold wrote:

> > > > A problem with this approach is that ASPM will never be enabled (and
> > > > power consumption will be higher) in case an endpoint driver is missing.
> > > 
> > > I'm aware of this limiation. But I don't think we should really worry about that
> > > scenario. No one is going to run an OS intentionally with a PCI device and
> > > without the relevant driver. If that happens, it might be due to some issue in
> > > driver loading or the user is doing it intentionally. Such scenarios are short
> > > lived IMO.
> > 
> > There may not even be a driver (yet). A user could plug in whatever
> > device in a free slot. I can also imagine someone wanting to blacklist
> > a driver temporarily for whatever reason.
> 
> Yes, that's why I said these scenarios are 'shortlived'.

My point is the opposite; that you should not make such assumptions
(e.g. hardware not supported by linux or drivers disabled due to
stability or security concerns).

Johan

