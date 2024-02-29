Return-Path: <linux-pci+bounces-4283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC986D5BB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 22:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B521C23787
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B0154C1D;
	Thu, 29 Feb 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfpV3OEI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8C1509B8;
	Thu, 29 Feb 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240237; cv=none; b=D2uGSAjjhKXqZ2IVTr7KBmC4S1vQCjS7t9LqYuKKrsJaZTW1gDoioS8O+8kc0bD+CwNhiUR5s33VovlGVVvRoja1sGJUL9bqJNYupcmmdLuBEjwB9z5Aveh42Fay7gaOOf5QLz/VBGgVrT6E2W65p9YLQAWbTOa1E0QsTZ3U4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240237; c=relaxed/simple;
	bh=KH2/toeuHIyQl/xKOAzMTzUVCjsQKDQqj30epruguyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oue0YmD86sQ/LDJVUIS8T65WhmniG3CTbHLlzYPuo9X7vsP2qu87cDZAFOqC6l71HRO2bojVZAHaUvxg7e5XO1vd2PMcHHood0JmOC0TgsiYO2YhuGYPdHmhL4wJnL9zHd7KezyYtJUM8+FctHQOZSPsBqpIocxHJ+6Bwk06fsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfpV3OEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D0C433F1;
	Thu, 29 Feb 2024 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709240236;
	bh=KH2/toeuHIyQl/xKOAzMTzUVCjsQKDQqj30epruguyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rfpV3OEIy5UmT/zXcKsgZUDdNpd4JcDBgfsqyrjtKbe9tdSQdUW0WU4WTZP9+fl3e
	 BT1SMH2YuV8HMmae+FrurpAip3SL/EIAHlUkIesw1tyviWgRMKAf78wWHTGwneTriS
	 QTU/yIhckof7mFMSbl8bI06hHmSqW0vfwEfCTwShpBheBGOMyeKSqGPUzm6Srq1568
	 LtNygqGGfABX3mVXzfe49ix6fO4wxiiAUy5lEmXoRz/GUc1vkVjk5cS2DbWIp3Ju44
	 ObFuBC4QZYoJ8O3nJV5Upr/kUKc++VmS5GVRZC33BP+dLFIiP95n0UZayhLKmweKHt
	 C7VT8bj71o+2w==
Date: Thu, 29 Feb 2024 14:57:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Make PCI's devres API more consistent
Message-ID: <20240229205715.GA362688@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2057fd477ad404c9adf603eac1ad933c04ecf293.camel@redhat.com>

On Thu, Feb 29, 2024 at 09:31:20AM +0100, Philipp Stanner wrote:
> @Bjorn:
> Hey Bjorn, are we good with this series? Any more wishes or
> suggestions?

Sorry, haven't had a chance to go through it yet.  

FWIW, I just tried to apply these on top of pci/devres, but it failed
here:

  Applying: PCI: Add new set of devres functions
  Applying: PCI: Deprecate iomap-table functions
  Applying: PCI: Warn users about complicated devres nature
  Applying: PCI: Make devres region requests consistent
  Applying: PCI: Move dev-enabled status bit to struct pci_dev
  error: patch failed: drivers/pci/pci.h:811
  error: drivers/pci/pci.h: patch does not apply
  Patch failed at 0005 PCI: Move dev-enabled status bit to struct pci_dev

Haven't investigated, so maybe it's some trivial easily fixed thing.

Bjorn

