Return-Path: <linux-pci+bounces-25417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102FA7E608
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13291445190
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36618205AD8;
	Mon,  7 Apr 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxpP7otZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CB76035
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042202; cv=none; b=HNvEAXqnjMeT+rPGwSsTSMBOSgyfefZrzFp5JlUc6lCzO3KoGnBgjOjB2AK8jG+w46Ax0HlmXx4yqxEqwgEXmqOJpssP0NJZ/heGaMSigBr/1Vcjf1HSkhDDGIEh1EWd6O7wiEW8TGxqLUJrsUlX8eCp95yWI92lK9lgRaUaoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042202; c=relaxed/simple;
	bh=b/+uQFdQQGmMzXPysgm3jt6hMce0vcwkuj4h9ZE01cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FmnIPdXGglJMnZqygzWRIZWrACUMvWtDrDCA4Yvc9H6jsDRrerv0yWNtuoTr0IG0ThJcWhgqFSDV9RyDNW3cDjs3sba/rGMeLHDlKo9yZVsKAO7Y1FJszgTp5GmVurEKb1c+6BzG5vimG1wG7QPc90z83VrGO9ONzD57HxGXYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxpP7otZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0383C4CEE7;
	Mon,  7 Apr 2025 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042201;
	bh=b/+uQFdQQGmMzXPysgm3jt6hMce0vcwkuj4h9ZE01cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hxpP7otZIX8scJyddiCt6WrFwSIISKX1Is2hN+KkzwKaOCo+PEsxHrp0SY8SY8fBk
	 zTMc8ideRW/U80ngNt4k7RzEPtkGEmVayVFMGAAYRIpTcqvCP0awTh5WdwHRFwRnu1
	 3GWE8q1CrRGvHjQCBHlXakyPHX25txTcTeQ1311fzxM/qGI6haS5SIWNhKBUjpeGU/
	 NsoMiG6i+gPQnPHkOVF1iBFNNYRaqyPFJDD5FQbJa11sQl3PAroiVVEENdMwEQYfof
	 1M1zTHc/egX3mTVGuxHAdQ+K90VukCCBFU6l9MLSJuBn0DDGSTCqbdM3HQWM6VBnq1
	 sLVacwuUg/0qA==
Date: Mon, 7 Apr 2025 11:10:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250407161000.GA180182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407155742.GA178541@bhelgaas>

On Mon, Apr 07, 2025 at 10:57:44AM -0500, Bjorn Helgaas wrote:
> [bugzilla reporter bcc'd]
> 
> Bisected to https://git.kernel.org/linus/7afeb84d14ea
> 
> I'll take a look; including linux-pci for completeness and in case
> others are interested.

Sergey, would you mind collecting the output of "sudo lspci -vv" for
both v6.14 and v6.14 with 7afeb84d14ea ("PCI/ASPM: Correct
LTR_L1.2_THRESHOLD computation") reverted?

You can include the output here via email or (if you prefer not to
expose your email address) attach to the bugzilla.

> On Sun, Apr 06, 2025 at 03:11:54PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219984
> > 
> >             Bug ID: 219984
> >            Summary: [BISECTED] High power usage since 'PCI/ASPM: Correct
> >                     LTR_L1.2_THRESHOLD computation'
> >           Reporter: sergey.v.dolgov@gmail.com
> >         Regression: No
> > 
> > Created attachment 307924
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=307924&action=edit
> > Bisection log
> > 
> > I have been observing increased power consumption on my HP Spectre x360
> > Convertible 15-df1xxx (CoffeeLake) since kernel 6.1. Bisection revealed a
> > regression in commit 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 (PCI/ASPM:
> > Correct LTR_L1.2_THRESHOLD computation). This still affects the mainline. 
> > 
> > With the original kernel 6.14, turbostat shows that the CPU sticks to Pkg%pc3
> > more than 50% of the time, resulting in a discharge rate of 3.52 W reported by
> > powertop during an idle empty plasma6 session with screen off.
> > 
> > After reverting 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 and recompiling the
> > kernel with the same config, Pk%pc10, CPU%LPI and SYS%LPI residencies are all
> > above 80% during the same session, and "The battery reports a discharge rate of
> > 1.35 W."
> > 
> > The two kernels above had no nvidia drivers to avoid tainting. However,
> > compiling also the proprietary nvidia modules reduces the idle power
> > consumption further to 796 mW.
> > 
> > Could you please revert 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 upstream? Or,
> > at least, to switch between the two encode_l12_threshold algorithms selectively
> > depending on the system.

