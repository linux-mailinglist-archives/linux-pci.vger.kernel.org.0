Return-Path: <linux-pci+bounces-8201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397FA8D8AF7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 22:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC191C2131D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83313A865;
	Mon,  3 Jun 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTPrjdyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BA20ED;
	Mon,  3 Jun 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447035; cv=none; b=cISTfVJW2p0+j1VjY/1bTZADb8P5yLu4jWEE3kV85OZT2UuCwKl1G4GSK//KPRQJbj6l8NAN6kIKenbelJBwaxSxsW275wf1JnqUYFIHiN58SJWezsBPvlxlzMNL8T7vbNZEvn90Pveu2CJOZCXzoZbkcMw7A6jsgKiCwKt6HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447035; c=relaxed/simple;
	bh=Swf7JB3j5W82F8GO7QCzrjcVhRSmIR3+V0DoxX7ppRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u2Q5qNiF+0dEI0M548z2tMePIwlt+bd5zjaJU5jmHmDlsLIfpKl1kS0wqodO0iM9cvFyaX0FkWc8Zq27NbqdxUiU1HA3pSrV0JAKYKuXhYQLT/DxrvJ2o3pVkMiCWQKWTH57EcAJURtisSSEuJJFdypbeKMHPV5TsPcyN2HOYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTPrjdyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C77C2BD10;
	Mon,  3 Jun 2024 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717447035;
	bh=Swf7JB3j5W82F8GO7QCzrjcVhRSmIR3+V0DoxX7ppRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nTPrjdylwFFyKBXzYysHsPgBEqkiTXixvOzjRc22k5wZfpLMArhKMge2gilFPKjYo
	 FfI+vVi/qKyNw+I8yBrQdxtilwFoF9g2qJqHDCdQyHIjXQ7PBrrCWgWF0xktufg7KJ
	 hZlPRxHzFsyl2VyIRhw9Z5a9cWbHQ6ZD8Yx0iEsBJkAzFwTrdLStSNYfaSZmNcC1u4
	 KawaCQxjZ9H1uzMY9P4F41kE8IEfZBza8Q5mhZVjDLXH0pEyAt9dM5VwSzVwUWqhjt
	 I6tVXXp82WLDoDP9T6TNXqE/QemFvKoEprHxymYJREtBgRzkJWc7h1/WN9yXk3DmI0
	 9ks8AjYl08kUQ==
Date: Mon, 3 Jun 2024 15:37:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
	Dave Jiang <dave.jiang@intel.com>, Imre Deak <imre.deak@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
Message-ID: <20240603203712.GA692178@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6daf3a21-6e78-4a82-b03f-af9462fad012@redhat.com>

On Mon, Jun 03, 2024 at 09:49:39PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/31/24 3:04 AM, Dan Williams wrote:
> > Changes since v1 [1]:
> > - split out the new warning into its own patch (Bjorn)
> > - include the provisional fix to the pci_reset_bus() path
> > 
> > [1]: http://lore.kernel.org/r/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com
> > 
> > Hi Bjorn,
> > 
> > Here is the targeted revert of the cfg_access_lock lockdep
> > infrastructure, but with the new proposed warning for catching "unlocked
> > pci_bridge_secondary_bus_reset()" events broken out into its own change.
> > I also included the proposed fix for at least one known case where
> > pci_bridge_secondary_bus_reset() is being called without
> > cfg_access_lock.
> > 
> > Given there may be more cases to unwind, and the fact that I am not
> > convinced patch3 will be problem free I would, as you suggested,
> > consider patch2 and patch3 v6.11 material. Patch1 is urgent for v6.10-rc
> > to put out these lockdep false positive reports.
> 
> I can confirm that this series fixes the lockdep errors which
> I was seeing:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Added to the three patches in this series, thanks, Hans!

> > ---
> > 
> > Dan Williams (3):
> >       PCI: Revert the cfg_access_lock lockdep mechanism
> >       PCI: Warn on missing cfg_access_lock during secondary bus reset
> >       PCI: Add missing bridge lock to pci_bus_lock()
> > 
> > 
> >  drivers/pci/access.c    |    4 ----
> >  drivers/pci/pci.c       |    8 +++++++-
> >  drivers/pci/probe.c     |    3 ---
> >  include/linux/lockdep.h |    5 -----
> >  include/linux/pci.h     |    2 --
> >  5 files changed, 7 insertions(+), 15 deletions(-)
> > 
> > base-commit: 56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c
> > 
> 

