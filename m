Return-Path: <linux-pci+bounces-9528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560F91E8D0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C69B21525
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248416F8E3;
	Mon,  1 Jul 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF0s7e1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9916CD15;
	Mon,  1 Jul 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863232; cv=none; b=q4OG1b+wTnP/hlY75WYLqEA7YquvvJB4GQDknVfeBx5vpGYUjKcWcCAgvY0G7f7gen85/CPtWWKMeddL8efCCujkJSxNddd/xekEYYhDL6DzkK82uPRWZdgWSqKO0KQNqfiIGbteAOODaQ6ZPqekloMrIRMpyiKPUp2cnc/iDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863232; c=relaxed/simple;
	bh=0Dpt9CZRFDhfHJtQg86N/UvtSJVphsziDzf1rpJxaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rg5tvO3hgJfc1NyblK4t3U3wV+QmGs+QIzPm0Kjqa3U3NyhOQfBqfs2waLBXb7EPyKq2R2eJwrdPEBdvC2eSKcHWgdILt6vCuNQ5eSYaNba+JhoIlbZd1klUOc6yv/tfRUyAmgwl5xg1FXIoIrzftTiUXxYVTW1Wle5kkEXGCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF0s7e1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C1C116B1;
	Mon,  1 Jul 2024 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719863231;
	bh=0Dpt9CZRFDhfHJtQg86N/UvtSJVphsziDzf1rpJxaPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gF0s7e1JZmSo/8EZUEKabsIT94KSKvd6J8wKizWy6EbuqMxxQ4r7yAxir9kHLahnB
	 BozgKSRwLWH3t3rmTa3UGjDJnW+wZ+hPeZ0PZwOKfSfqBdQlgobSYFfrsZmXz2tCvI
	 8on31+uaf3oFKRf5yXSeFTh902MkT0TtOU5qb2EntgUc+VLTVKqX9hbC1bOaW7Jb7S
	 LW59wtnggDi0cF1ivB2VL5iQnjkpXLjAATmq/t5m/sGN8opFgsukzgFcv/TxbUc4EO
	 yD6OpAdNrYvy2dfGNTcSecPpRGybJNyseytVT4Xoy1jZLhk8YjEB8ZJDpRv/NkvURj
	 3s0njYaDWr1jA==
Date: Mon, 1 Jul 2024 14:47:08 -0500
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] dt-bindings: PCI: Add Broadcom STB 7712 SOC,
 update maintainter
Message-ID: <20240701194708.GA14347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628205430.24775-2-james.quinlan@broadcom.com>

s/maintainter/maintainer/ in subject

On Fri, Jun 28, 2024 at 04:54:20PM -0400, Jim Quinlan wrote:
> - Update maintainer.
> - Adds a driver compatible string for the new STB SOC 7712
> - Adds two new resets for the 7712: "bridge", for the
>   the bridge between the PCIe core and the memory bus;
>   and "swinit", the PCIe core reset.

s/Adds/Add/ to be imperative and match "Update".

