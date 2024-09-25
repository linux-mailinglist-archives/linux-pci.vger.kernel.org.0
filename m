Return-Path: <linux-pci+bounces-13529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D49866E1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90C2846BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F113E043;
	Wed, 25 Sep 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlWRpqeP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E21EEE9
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292534; cv=none; b=YNJqK1CacOOR7EBR/XibcRx3SDsJ8uwILbQi2dp+u38fX1q5Pv5sm6Divc8YwqPWyPBoYTDaSPS+sD0pSUt2IZ+Ym15bjOZYVbvAEj6CYSz9mlDNPhs+MUMpP8A8BJA84+RvOxc9dx5MrbPFb81SNyuX6vKc+fLGz/2B2oVUQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292534; c=relaxed/simple;
	bh=2p6rSWpJHI86fF++mKRzgd+G59Aro6HVbKw40/eSKz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oWdxk4O2GGj7LaxTjSFhLGHDHd0HAk9ZrGmUDMyEIR3NBhsVfEmmrLQVRyAdC3unMUQMzWioggkJZ3LqKZZQDH4RHs9bPpeVx3isMH8rHQ/Ht5isvn1LlncocsiBwEiocGc3s/P4rVmIecVPHGilPHpfXD8gt71mfV/QSbbwiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlWRpqeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F550C4CEC3;
	Wed, 25 Sep 2024 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727292533;
	bh=2p6rSWpJHI86fF++mKRzgd+G59Aro6HVbKw40/eSKz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DlWRpqePUnblESnukyDU/cwDtFisQ9nkB9jQIMYLsn7RvZ8K0+DcunnxYxrTRHF12
	 z6yC3OpnhuMaierjBxV35SGFOdL9JYRifgvsJTpeW2Z1CAhkK5nOHDrHFanMyL57sf
	 O2VfGVZpCha4y6Sz4h3F/2FY4+nS/yDAXCMqhoX5S3+Ws4qI+pdlxaZO4I1nokYKVY
	 IL4KNh+ufMQe2NsMAUZl2NmboNBUsTdeo0EPcKfu2Lz7YDDtWTcXEUG2CsfHCvgciO
	 6Irfd0XjFdA8raXKU8wj+g1Kum+KED/d1EmIYtjpbXDTbtVMeHThE/wltYAgLoad/h
	 uq1RMPlY4K2qQ==
Date: Wed, 25 Sep 2024 14:28:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/i915/pm: Move the hibernate+D3 quirk stuff into
 noirq() pm hooks
Message-ID: <20240925192852.GA10106@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925144526.2482-5-ville.syrjala@linux.intel.com>

On Wed, Sep 25, 2024 at 05:45:24PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> If the driver doesn't call pci_save_state() driver/pci will
> normally save+power manage the device from the _noirq() pm
> hooks.

drivers/pci.  Or maybe just mention the PM hook names specifically.

> We can't let that happen as some old BIOSes fail to hibernate
> when the device is in D3. However, we can get a bit closer to
> the standard behaviour by doing our explicit pci_save_state()
> and pci_set_power_state() stuff from driver provided _noirq()
> hooks as well.
> 
> This results in a change of behaviur where we no longer go
> into D3 at the end of .freeze_late(), so when it comes time
> to .thaw() we'll already be in D0, and thus we can drop the
> explicit pci_set_power_state(D0) call.

s/behaviur/behaviour/

> Presumable swictcheroo suspend will want to go into D3 so
> call the _noirq() stuff from the switcheroo suspend hook,
> and since we dropped the pci_set_power_state(D0) from
> .resume_early() we'll need to add one back into the
> swtcheroo resume hook.

s/swictcheroo/switcheroo/
s/swtcheroo/switcheroo/

Or maybe just use the actual function names here too.  That saves
time for me, at least, because it points me at exactly where to look.

Bjorn

