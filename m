Return-Path: <linux-pci+bounces-39861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526BEC2285C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91292188AB68
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54180332EB6;
	Thu, 30 Oct 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpkVaNAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2C2BEC30;
	Thu, 30 Oct 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862319; cv=none; b=ejFLMfrUkSUcUSQiv8Mz0PDxVIOUW064W7qeb7zI3nEa9hhKlgIGL3WfPIo4XyD5rGSEyJ2+k268Jhlm5Lsj+3ISEg2+GHW5uK5mCVC0/Uc0uFsCNRfGK04CgpvguYhD5MmdzWOIv3WXvyMmQNWOYfroN789zdaPafzXdHGas+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862319; c=relaxed/simple;
	bh=ANsDWcvXGFKqRpeDoJiS5nLcPhuShWzOx6h8WZp7DHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KVU3ur4a4OYFLxOSx4kkjFD2g8JEt/r/6EyNoWMGNlrkgjq7IoPhD6dJRdvFaD1o7gefdZdJMhFP88JU0mjldODo9th7x+Uhs5+2bqyLFNw/HmIYTQkqw5JGRlxrE+qefCuRbkGCkqCRFWDx3f+XfZoh0jqpjqxg/6KyzrYNcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpkVaNAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78317C4CEF1;
	Thu, 30 Oct 2025 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862317;
	bh=ANsDWcvXGFKqRpeDoJiS5nLcPhuShWzOx6h8WZp7DHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rpkVaNAK42KbaB7YIawxEJpZQszaydDn+sfLWBjub8tN2BiwYgI+g+wbSktjaeDVu
	 FTuLYt0u2eg4y7x8tzFHf+NdwLcTuEInmYlMWlcfLtBkiYhr/gNhk7k/BBkxirKzae
	 40hxdubrtE7KZbiwWVMtskS/WEbjJhi3uAhmYXd3BBT60DZ/rid8Lv430KYUASL6kO
	 2nkcjvSMXT6sy8FfPyLz06jghw4bRhUwwIHU6JORtif1qblABRYhitBLwTM9jhKTwh
	 REcsxr8+uO23ShMJSSvGCYA60KrfxdLyUX50AkAZG9/kegTHfBWBymxqIh6GL+23f+
	 DVfmFK1mHUHqw==
Date: Thu, 30 Oct 2025 17:11:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251030221156.GA1656310@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013210602.GA864364@bhelgaas>

On Mon, Oct 13, 2025 at 04:06:02PM -0500, Bjorn Helgaas wrote:
> [+cc Adrian, Lukas, Mani, regressions]
> 
> On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> > Hello,
> > 
> > Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> > 
> > Without the pci-v6.18-changes, the PPC boards boot without any problems.
> > 
> > Boot log with error messages: https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> > 
> > Further information: https://github.com/chzigotzky/kernels/issues/17
> > 
> > Please check the pci-v6.18-changes. [2]
> > 
> > Thanks,
> > Christian
> > 
> > 
> > [1]
> > - https://wiki.amiga.org/index.php/X5000
> > - https://en.wikipedia.org/wiki/AmigaOne_X1000
> > 
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> 
> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")

Maybe this will point regzbot at the correct email report and a better
commit?

#regzbot report: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
#regzbot introduced: f3ac2ff14834

