Return-Path: <linux-pci+bounces-8188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8F8D8776
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD8C1F21D45
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5BF132811;
	Mon,  3 Jun 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgENSSJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591C4A0A;
	Mon,  3 Jun 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433625; cv=none; b=TmQJC42cyE2XRemLe2d946EIw31Kuz/3F6xRIRk9Om3mF1Fp6oGNeinp8lEcCNJT7HBLehv1zpCFVM3eEQX6S5aeeb9uKn+w7YDOJXqTang8br6CR05mDJzlkTAJr4KpRA8H7JqR27uENQl/80F7e1/2+7pwzCV/BPAM94URUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433625; c=relaxed/simple;
	bh=DyH3gpgi4qx6wflc8epTRwqQEEkxiiw8EGl6bIf3LLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oBQkdZ8ww630HEM/aBw1+q6UaQX+BvazJE5Kn///E6FtTCYZlDAdJ33p1rZHLe6OoFX+80W2vwE39/SNRlD5/03i40xjtQRvoasdcSK1qb8Qi7nahggbRVyYMNsWbi3Ael4Go1dRxFApt8eyB9Rzdx4EYKUYTS9xeIrOzySV3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgENSSJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDF7C2BD10;
	Mon,  3 Jun 2024 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717433624;
	bh=DyH3gpgi4qx6wflc8epTRwqQEEkxiiw8EGl6bIf3LLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hgENSSJYgdOnCETWiJY9P2q8PiNLuQHrp3hEsrHgzQ0pKYOsoy1fMSyxc5gUiT4/0
	 kt2eYRaUtxE9GsHNC7+/gjMM0RM/u6RQIc4eF9iHhxJ5BRAbWJKnpGqWAhezsLTw+C
	 nHXjnjB8jNexooMWyr7gS8s8q3JJQbDN9FbF1QxQhhB+ulwxiYkY+MOpRzqxqZTgVl
	 Gzcza1nHQ8D9zXVU0+IEe+vV2RFf9V9ARr6yffP4ZMcLvJWczK4XsWtjZTDzZ2vYr5
	 bflHiaCnK4DHzs3TI9dG5Li2FfJoUHV4VaIYbGmG1jLDDAvLrJYuHQ2KzTnq+/d0oV
	 /DqEeWnb+bfJA==
Date: Mon, 3 Jun 2024 11:53:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
Message-ID: <20240603165342.GA685076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5k5ukew.fsf@kernel.org>

On Sat, Jun 01, 2024 at 11:39:03AM +0300, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> >> Kalle Valo wrote:
> >> [..]
> >>> >> The proposed fix for that is here:
> >>> >>
> >>> >> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
> >>> >
> >>> > I get "Not Found" from that link, is there a typo?
> >>> 
> >>> I found this fix from for-linus branch:
> >>> 
> >>> # PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560
> >>> 
> >>> But at least that doesn't fix my crash.
> >>
> >> Sorry for the broken link I mistakenly used a message-id from an
> >> internal thread with the intel.com reporter. However, it is moot now
> >> because the new direction is to revert the lockdep infrastructure:
> >>
> >> https://lore.kernel.org/r/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com
> >>
> >> (that link works...)
> >
> > Thanks, that links works :) I did a quick test with the three patches
> > and I didn't see any crashes anymore. But to be confident I need to run
> > overnight tests, I'll provide my Tested-by after that.
> 
> Ok, I'm now quite confident that the issues I saw are solved so:
> 
> Tested-by: Kalle Valo <kvalo@kernel.org>

Thanks for reporting the issue and testing the fix!  Can you please
respond with your Tested-by to the actual patch(es) you tested?

Bjorn

