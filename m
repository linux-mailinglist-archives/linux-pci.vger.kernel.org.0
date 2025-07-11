Return-Path: <linux-pci+bounces-31957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4867B0261B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3089F5C3B96
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561561DF25C;
	Fri, 11 Jul 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va0teick"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA0288CC;
	Fri, 11 Jul 2025 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267912; cv=none; b=PnxbmCGyZyLIRJMjvsbn1QTjIOmAORzOCiin62P9x/YG+OqFMIIiTr3NTre7kgjHoj5e4Ln/BYsP1w5gHidknocJ1Ni/kV4NsXRT5uRbL0HlviGFCTNY40ksHdCL5apKmSMiIepOAN6pkZrNg2lYALAadjei1tBhaq/M9HK4Wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267912; c=relaxed/simple;
	bh=uHv2HgJnKbhKwjNP1Z1NjX9olIzNk5naCNk8EoEhros=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p4TPlL37yd63LWyJD4sLMZqlzSX0qDQdGdz0DKLtrS0vQSP6iEEfNUTdgS3mSG3gjTwpk3nwQKkr6axEocC4mT9Qztnwrru8h2BKtanhwNFau5l0/8WE/irleh0thKat2BXWFea1mmfdrpeiN7MTTI+6mJl//zfDuZQABrjF1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va0teick; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A3C4CEED;
	Fri, 11 Jul 2025 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752267911;
	bh=uHv2HgJnKbhKwjNP1Z1NjX9olIzNk5naCNk8EoEhros=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Va0teickhjzFgErQ9hAONAf8bZW3XPHI+c2FMG/SBppey4C0hi8xjsm9cRdTGb40B
	 jOPCgyQctdfLGL7M222hOeqgsM4EbSAqw+LBCKn3fyxvmJjaLS/WNEnBTUyvsRrE4o
	 LsKkIJyBEsP+WU9HgK46sKvy25tW1GXPIr50/PHfUwwN0TpdSVARlEd6ppl9DbcsJ+
	 rTdqH+svHAVaP+UQb6eWTQCP6Z4+wr1cNjJtEC1UtoSxGXvKdJOLSEeRXueJMpGIFZ
	 f8OtNzEDIDhsZ0IQh/uX5CtIsFf/juPLpxwmdpjSiJFUX2HXP0v11wI2CKNWlYne7H
	 R8s0Kt9soYEhw==
Date: Fri, 11 Jul 2025 16:05:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Krishna Kumar <krishnak@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Message-ID: <20250711210510.GA2306333@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1841754281.1353162.1752257887865.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jul 11, 2025 at 01:18:07PM -0500, Timothy Pearson wrote:
> ----- Original Message -----
> > From: "Krishna Kumar" <krishnak@linux.ibm.com>
> > To: "Bjorn Helgaas" <helgaas@kernel.org>, "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> > <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> > "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> > <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>, "Lukas Wunner" <lukas@wunner.de>
> > Sent: Monday, July 7, 2025 3:01:00 AM
> > Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention indicator
> 
> > Thanks all for the review and Thanks a bunch to Timothy for fixing the PE Freeze
> > issue. The hotplug issues are like you fix N issue and N+1 th issue will come
> > with new HW.
> > 
> > We had a meeting of around 1.5 -2.0 hr with demo, code review and log review and
> > we decided to let these fixes go ahead. I am consolidating what we discussed -
> > 
> > 
> > 1. Let these fixes go ahead as it solves wider and much needed customer issue
> > and its urgently needed for time being. We have verified in live demo that
> > nothing is broken from legacy flow and
> > 
> > PE/PHB freeze, race condition, hung, oops etc has been solved correctly.
> > Basically it fixes below issues -
> > 
> > root-port(phb) -> switch(having4 port)--> 2 nvme devices
> > 
> > 1st case - only removal of EP-nvme device (surprise hotplug disables msi at root
> > port), soft removal may work
> > 2nd case  - If we remove switch itself (surprise hotplug disable msi at root
> > port) .
> 
> Just a quick follow up to see if anything else is needed from my end
> before this merge can occur?

I was waiting for a v3 to fix at least these:

  - Subject line style matching history in drivers/pci/hotplug/ (use
    "git log --oneline" to see it)

  - Broken subject line wrapping into commit log

  - Spelling fixes

  - Comment reformat to match prevailing style

  - Note attention indicator behavior changes in commit log

  - Some minor refactoring

Basically everything mentioned in the responses to the original
posting.  Or was there a v3 that I missed?

Bjorn

