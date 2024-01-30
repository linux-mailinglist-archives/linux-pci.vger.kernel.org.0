Return-Path: <linux-pci+bounces-2795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B505A8420BB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC641F2D13A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C060885;
	Tue, 30 Jan 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXjU7ZJV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCC60869;
	Tue, 30 Jan 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609271; cv=none; b=ScLQTSvX3hDJJ7l8sX/W8IhZ0YjnVw5Vg+TsmU/3yOREB+z0IMzfyt7oTu01Oe8l5CDj6Gku0HfP8VqRErbgnb3DouiNt5dWNPD72CAj+t0HeZIkLyX2bQ0rtF0NdZVXVlZx7MmqMvAHkg7L8G/e4qSyC8ca4Oq+9v8vj67N7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609271; c=relaxed/simple;
	bh=8CKJrkkGZM/Di0WcrrdDLyXgOONeUOLpOJVPXsgvDfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHuYMJoh8CaV/ZfSDlaiVZ23rAc3ek/kxbQBaShDvmqjCg6lbEIGQV7h4P9dci5dZsLECvfJ2PCeTUiIGaNgvS4wrHBg6PycCgXuNH6QkMi5PfWHfnvFS27hR9Bn1UKTMSzd1n8zfT+x7j8+ljFmE/c79hNpKvIvPV7oQYFldGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXjU7ZJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A63C43394;
	Tue, 30 Jan 2024 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706609270;
	bh=8CKJrkkGZM/Di0WcrrdDLyXgOONeUOLpOJVPXsgvDfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXjU7ZJVNQetTKK+iu7bcpvfWtFQHKDYE888Y16U4NH5V/n7E9rrIu1Ei+fhqxJ1C
	 aTJ/Hl/ukgxMj9wx17vqA7bZiJvKh131t5jj5sRt/z5PFd41VoUVWGO6YColmMbyMh
	 GBPJ3XabbpiUYPRbKUPm5eh/XYRMpDk6JSGHWcZRpOYSA9pXVf8Yp1a7JPCoJKK9tc
	 j011Q3TokZY8sC5v0t+K0Y3vc204C5daTI/DJ+S0FMqtS2yhNr6f2/ba4Rk9gBruif
	 jxzuBfQ2wkaSrugKhbz0XIhldCgUmbqRTF6UzbTO0rjUaHZahAB6kg3FsMd5qnrp+T
	 rSSlSOaf6POow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUl1u-000000002uC-18CJ;
	Tue, 30 Jan 2024 11:07:46 +0100
Date: Tue, 30 Jan 2024 11:07:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	regressions@leemhuis.info
Subject: Re: PCI/ASPM locking regression in 6.7-final (was: Re: [PATCH]
 Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()")
Message-ID: <ZbjKci6GuWVrpbri@hovoldconsulting.com>
References: <Za_2oKTUksw8Di5E@hovoldconsulting.com>
 <20240123223648.GA331671@bhelgaas>
 <ZbDHZtR8Tg1hWAzc@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbDHZtR8Tg1hWAzc@hovoldconsulting.com>

On Wed, Jan 24, 2024 at 09:16:38AM +0100, Johan Hovold wrote:
> On Tue, Jan 23, 2024 at 04:36:48PM -0600, Bjorn Helgaas wrote:

> > I don't quite follow.  By simply reverting, do you mean to revert
> > f93e71aea6c6 ("Revert "PCI/ASPM: Remove
> > pcie_aspm_pm_state_change()"")?  IIUC that would break Michael's
> > machine again.
> 
> Right, at least until that issue is fully understood and alternative
> fixes have been considered.
> 
> If that's not an option, we need to rework core to pass a flag through
> more than one layer to indicate whether pcie_aspm_pm_state_change()
> should take the bus semaphore or not. I'd rather not do that if it can
> be avoided.

As a revert appears unlikely to happen, let's fix the regression by
adding a new helper pci_set_power_state_locked() that can be called
with the bus lock held:

	https://lore.kernel.org/lkml/20240130100243.11011-1-johan+linaro@kernel.org/

Johan

