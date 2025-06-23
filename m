Return-Path: <linux-pci+bounces-30346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D92AE3653
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4101892AE6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218E1EDA14;
	Mon, 23 Jun 2025 06:53:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966B45948;
	Mon, 23 Jun 2025 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661606; cv=none; b=dpmJOU39e1FQ16DdQL49q17P9RH/5Df6DOboZl2wH/j9E/JXS4QMWpNUbmolX+MUoMIFYHoQSnxtNptQUtKo0Q7LUPD2dJ57F785Opk54wLw4c9cUmR3YYo1aL9t2yyZwbUL21fVpwr85lsA4gC9beYhR2TCSW4x5g1soKN27OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661606; c=relaxed/simple;
	bh=rQjLc31C3d45UrSCDZ/vtO7SV3kPk8gR9r+g1qGuSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXrRDCx5kof7DOLTcukI0RQR7wqCibIxcV9kSuucyyJlM2ffgoFMvKqTN7iywm+0TZPdCZw0/R24hSX0XlN7pbQxcuqcnpXNA3uNnkEBpgszJiuW1lC1mFZ3QDEEbDdG9kAXKL4CWaRJLfEDWX59hGPgivn1Tr2suY30afNFt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7FE792C000BF;
	Mon, 23 Jun 2025 08:53:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4ECFB359BF3; Mon, 23 Jun 2025 08:53:21 +0200 (CEST)
Date: Mon, 23 Jun 2025 08:53:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFj54TvKfQNLyOm9@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <c5950427-8a65-4659-96d1-5bb013955090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5950427-8a65-4659-96d1-5bb013955090@kernel.org>

On Sun, Jun 22, 2025 at 08:47:03PM -0500, Mario Limonciello wrote:
> Actually I came up with the idea to forbid runtime PM on the service when it
> doesn't allow d3 at probe which I believe means no need to check again on
> remove.
> 
> This works cleanly for me.  LMK what you think of this.

User space can override the allow/forbid setting through the
sysfs "control" attribute, hence this doesn't seem like a
suitable way to somehow cache the return value of
pci_bridge_d3_possible() and thus avoid its re-execution
on remove.

However we shouldn't have to cache the return value anyway
as the underlying assumption is that the function always
returns the same value.

Thanks,

Lukas

