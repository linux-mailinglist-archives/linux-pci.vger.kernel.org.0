Return-Path: <linux-pci+bounces-35815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A0B51AB3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF95581A9B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D25335BD0;
	Wed, 10 Sep 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW5pM2Fu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD820334733;
	Wed, 10 Sep 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515601; cv=none; b=HI9NTD7lxjwO74UTyuBiDtCYZMh2Vgs+wtTL6LhNl9K0HsWVGCkYuHCU+rJmyCZzw8mUWFy0W24JU6U61F/jjvy+dG7vg7Ob3NV1S/41IEn3ziikxpZ1hO094JTq3rK8u3AmusQbtO++rolE0slb9pUCBr9/chVq0hiEG61cFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515601; c=relaxed/simple;
	bh=84vkiPKqSEhuvDni8XCaT6y5jo/x6VM2Y2bOu716BLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jKiOC8JxrriFW786cbyiID7YT3hQUow7fBOXIKKT0ICCpEpuZHspPEDSv9Yhan6hLPml7C9AhKTMyNOJZ7ng+WEPmubkuNpzYl2a3GM0bYjfRYoRzIioozehzJAc3X0uQ73a3Ia35UHg94+7U+firlCoQyirs+ICWxPto6CNUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW5pM2Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316D6C4CEEB;
	Wed, 10 Sep 2025 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515600;
	bh=84vkiPKqSEhuvDni8XCaT6y5jo/x6VM2Y2bOu716BLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KW5pM2FuSjJKYJW2gxcET8OcAb1Rldc9NmgcN9qu9VVRmQY8OImBUUUXcix8cQckW
	 jSNVyqFL7amGmUf7wkuDldCw34x5vfC4fs3T9gVytGVRFENaEVt04KcarnAzlwVANz
	 EZZVR3K9PvKcjR66/8+wda4Gbh22mxm1+1b02Io3rjhsYSpJ0yuZ6X2Mlh0Wlx9OKE
	 UPYmMZFP2kT+2NusOrtQtR6VBmSZKiLAp0YARN/j0AEH/x1N4414csaGNJAQKkeTZS
	 xVJ9pFYae9xPnC0wRLL3zV7z/6Tev21LW3sqB5+UN4uprUuhHM9oNAf6/Lx+6uGzIF
	 Pjs15lLPM32qQ==
Date: Wed, 10 Sep 2025 09:46:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v7 06/12] PCI/PM: Split out code from
 pci_pm_suspend_noirq() into helper
Message-ID: <20250910144638.GA1535343@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909191619.2580169-7-superm1@kernel.org>

On Tue, Sep 09, 2025 at 02:16:13PM -0500, Mario Limonciello (AMD) wrote:
> In order to unify suspend and hibernate codepaths without code duplication
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
> 
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you have other reason to repost this, ...

> +	if (pci_dev->current_state == PCI_D0) {
> +		pci_dev->skip_bus_pm = true;

Add a blank line here.

> +		/*
> +		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
> +		 * downstream device is in D0, so avoid changing the power state
> +		 * of the parent bridge by setting the skip_bus_pm flag for it.
> +		 */
> +		if (pci_dev->bus->self)
> +			pci_dev->bus->self->skip_bus_pm = true;
> +	}

