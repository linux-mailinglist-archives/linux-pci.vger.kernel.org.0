Return-Path: <linux-pci+bounces-9529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334191E8DB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A31F23142
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB917085A;
	Mon,  1 Jul 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izRjTP7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0D16CD15;
	Mon,  1 Jul 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863345; cv=none; b=Qj8jShG12RYyg6kmizj5GYZf40VCAX3SkZtoVsUUQbfMdWd/BvLjJJitJS5c2ZnrHM+MdsYYhmpRyazm1Q/6dZd2+DV56YvH4SfUgqfj63n/TUyFAQVhSA8Ch1uqHYzrKi48DYkSuD4MHW2wAT8HSfsIVczCRcR4vWwhXiLhb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863345; c=relaxed/simple;
	bh=zQLlNeL1vEPNYFTUeDSkHfau4N62hdB+0K+910LcGDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lS63IAvceLfxb+6sKRvU19uWvrDwf1hlG3iUZudYL0vdFYcvpCCREiFP09Xdlz7SbT5b/1ZZLtZWmRIf+OuDLyrD87RKmwac3qmccdo0+gWmu3odvxO/JRMRIEdHR02hCn6VPi+d4Y8Mx528La0wNcDStFqdeOz/cIYpFxWJa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izRjTP7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3894AC32786;
	Mon,  1 Jul 2024 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719863344;
	bh=zQLlNeL1vEPNYFTUeDSkHfau4N62hdB+0K+910LcGDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=izRjTP7fn/CmHJ8zsepzQCFxuspZHpEY4VgfgjR53mrr5p9EY3+7ZTr7GLzd/cGYl
	 9VX0nxhj/ukhlI9kVaENGku38ir6u57ZepHtP6ULabOv74DjOgqEwrunVluJwd2onf
	 0y1xbLaXMEoYrdfRPP+60R/uiRgpWINoYZsRk1hxd+QcK/Oi+gUnhNilUC1P/PuoSd
	 6MuBcKlQOF2xg6AsKEZY/omYk/fKKM+vhvxJV3OA82OQSahRsqEr77CqshDbrbqx+g
	 cyWApNcp+SBy2Yuspcct1eEy7XFvW4Z+ca2KLWMzcshKpGcHbY4Udb2c1Gv2qfa+3t
	 fhqsetWXDtS+Q==
Date: Mon, 1 Jul 2024 14:49:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/8] PCI: brcmstb: Use "clk_out" error path label
Message-ID: <20240701194902.GA14422@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628205430.24775-3-james.quinlan@broadcom.com>

On Fri, Jun 28, 2024 at 04:54:21PM -0400, Jim Quinlan wrote:
> Instead of invoking "clk_disable_unprepare(pcie->clk)" in
> a number of error paths.

It's nice if the commit log is readable by itself, without reading the
subject line as the first line of the commit log.  Same way a title is
not directly part of an article/essay/book itself.

