Return-Path: <linux-pci+bounces-8982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F290F028
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147F8285E85
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F441802E;
	Wed, 19 Jun 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6oBF+Cd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AD15252D
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806660; cv=none; b=ofMFwbUaRcn+toMPgLAnoY99CVZPopzt86hNJvgWtCjQ6Rrk0CV/FpFF6OByB0zS8dKs1+lDxoSowxw+nPQSII/LqFtXgsGtB816LHky9IpJ6wgRe+oE3XohDzjDwXItio5JlPExGSfhAkcyOmERZ9+NbWOMfQd0dw5nITmESM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806660; c=relaxed/simple;
	bh=kJPh6yDEdtOWARX+uasQmBIz7GSmO0MaY3dKgb4yO24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N94Q8shQb6PUne8Y2ddMflhE+qUzhxgAxmymufCjeJ5E1izHzAJqkJG8X1awqLbxqhCUggCb4mRk9F4hDxYPxGjPfDQd0TMLLjlB8YePr4BrzOWWJmJbAvspOEW2pcubVAtORbvz5f8YvZviTZjxSd907LnIuFaL1a7P5xHEtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6oBF+Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D96C2BBFC;
	Wed, 19 Jun 2024 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806659;
	bh=kJPh6yDEdtOWARX+uasQmBIz7GSmO0MaY3dKgb4yO24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t6oBF+CdTJqdBcMybqxAn+99Lu4NLdNvq05t794f8fJ/mBYBchDpQVIqKfBtfO8Fk
	 VfNdENn/IB9mmMydIJRXXFlUqT1euEattK4q6pcSjYGpTEBRIWXT1cvG07wdJ2YTUK
	 Kt8TRmByc5Mk4PugejkfTTZzpW/ADKh44Fgvz1QQglkKM1M56N7h68eu8htwKPxcmL
	 KSTaO1WHJ4wyJRZZF1mjIHPjwMVZAVZIqXGKyjMEDmFqa0Uy+fF5VML9HY/5SRdGAn
	 qI/1wGTXy8xNIBcRhBnQD6vZCid6d22z06uxC3XM2MyXpsWRgdAmn0gVx2QBjXUhBe
	 ysiSO2E6/0NQg==
Date: Wed, 19 Jun 2024 09:17:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [pci:endpoint] BUILD REGRESSION
 1b2ccd0341a6124d964211bae2ec378fafd0c8b2
Message-ID: <20240619141736.GA1307542@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnLe3dOQNg4TZ5HB@rli9-mobl>

On Wed, Jun 19, 2024 at 09:36:30PM +0800, Philip Li wrote:
> On Tue, Jun 18, 2024 at 10:45:03AM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 14, 2024 at 10:32:57AM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
> > > branch HEAD: 1b2ccd0341a6124d964211bae2ec378fafd0c8b2  PCI: endpoint: Make pci_epc_class struct constant
> > > 
> > > Error/Warning ids grouped by kconfigs:
> > > 
> > > gcc_recent_errors
> > > `-- sparc-randconfig-002-20240614
> > >     `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
> > 
> > Is there any further information about this?  I don't see the config
> > file to be able to reproduce this failure.
> 
> Sorry, kindly ignore this, looks this is a false bisection and it doesn't
> send out final bisection report. It was wrongly recorded here, and we also
> need follow up to fix this problem.

Great, thank you!  I'll add that patch back in.

Bjorn

