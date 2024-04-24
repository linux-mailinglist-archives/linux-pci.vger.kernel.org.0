Return-Path: <linux-pci+bounces-6651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1395C8B1439
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03BA287E74
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9413C9C8;
	Wed, 24 Apr 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxuogYdE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0101BC46;
	Wed, 24 Apr 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989559; cv=none; b=BprrcnaONJ6SDRdx8l9zSNcjOY6gBWNYFjHJONjguLlbWlIP9YR4hkGMiriVY3ACbZM9afGmBeos98TIUA55fXURprFlulusGcuiSP25FC1jlKvj3/gerBpJojh6cvwuNiFJjUIW9IywK2bm6UyoVnhFqxSehFBxNY1aLQOswrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989559; c=relaxed/simple;
	bh=2Dj97MqB0+KxSUpFoSn5vPI5paGeISoPys0v4rngQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LBY2MGjVOU4Lt5IpxPy860Qplyi/8FWkNZCnd06q2RM33zjILYH9VHjXDlbYY9yPoYE/hy6ORo6m8fpw124fUBMQ1wXMTJEWJm8IXuSFKqyll02GuzBUJ9ib48xPu7H4CMeO7yIvUhPa1A0DWtGSpcp696Q0EwZSJXvqkeEs7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxuogYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB87C113CD;
	Wed, 24 Apr 2024 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989558;
	bh=2Dj97MqB0+KxSUpFoSn5vPI5paGeISoPys0v4rngQK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dxuogYdE8Ogd4lUlvyAT+sHHTarFFWfuxlSxa2pzl+W+XCxzQa35pR8eENXgHkTVw
	 yHH8e15VPFYJb7zvfxIefVyS0+NrTGFAr8VapDkdspYAFZUrxbbjoX0PDf/5mQzNIG
	 zlJezJ2N5tkTil3iGXVoJUE0atjSwar0qE65RG6IfpDgKV/flhymiDbFHjqay9BuVe
	 XVz8b58UOyipf1ZbfPFc8GvbmaNZFySxAxJAQuUGdBqR6JZ38X+8eKaTnumZJTR1a+
	 xW1t0Iz60W3pYNZ20GoQkxdpcX3Q8fnBM6a27nJ76PEIJd6qpyUN/oppprwTG9VxuY
	 iqed37IeeSyZQ==
Date: Wed, 24 Apr 2024 15:12:36 -0500
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
Subject: Re: [PATCH v6 04/10] PCI: Make devres region requests consistent
Message-ID: <20240424201236.GA504035@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408084423.6697-5-pstanner@redhat.com>

On Mon, Apr 08, 2024 at 10:44:16AM +0200, Philipp Stanner wrote:
> Now that pure managed region request functions are available, the
> implementation of the hybrid-functions which are only sometimes managed
> can be made more consistent and readable by wrapping those
> always-managed functions.
> 
> Implement a new pcim_ function for exclusively requested regions.
> Have the pci_request / release functions call their pcim_ counterparts.
> Remove the now surplus region_mask from struct pci_devres.

This looks like two patches; could they be separated?

  - Convert __pci_request_region() etc to the new pcim model

  - Add pcim_request_region_exclusive()

IORESOURCE_EXCLUSIVE was added by e8de1481fd71 ("resource: allow MMIO
exclusivity for device drivers") in 2008 to help debug an e1000e
problem.  In the 16 years since, there's only been one new PCI-related
use (ne_pci_probe()), and we don't add a user of
pcim_request_region_exclusive() in this series, so I would defer it
until somebody wants it.

Bjorn

