Return-Path: <linux-pci+bounces-6499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19D8AC0D2
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C91F21385
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56B3D978;
	Sun, 21 Apr 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXtAHIMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3F3B185;
	Sun, 21 Apr 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726207; cv=none; b=bj9fyceaF9qUqpBMybsLDdVHbWcBf5QK7maK7C5BXwi4kXVzI3gcvI+qym+Pa3d2Nz3shoO2wQiXnaNadnLfZFa96XX/PNtin4P1A2eoWaQnrP5u7gFsafxMLW5gBprB5LBpSS1xWQWtjvUu2lOh4CGBJqawIw0llLI4BPfYKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726207; c=relaxed/simple;
	bh=n6SwaZjcVFkNjY8H2WkLa4Pno+VxulX+IYzOLA17DN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QFZSAhRKj/VF/M6Y2ZrdTfwnx6ZmtlrTmnW8rBrSqNGSDQTQ4mm5w7bQOqkRAnSHEe74pQ+04Umj8y2bFMeJ2dr/kZZFlLZMpb8kYhsK+BmH+TFffiLKIKASFgjC4389BlOGZESY76uJoA9Wrrz4Ti+8anNaEBpFt6Yr5Kgwi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXtAHIMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0F2C113CE;
	Sun, 21 Apr 2024 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713726206;
	bh=n6SwaZjcVFkNjY8H2WkLa4Pno+VxulX+IYzOLA17DN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uXtAHIMZ+qdvwY4KOBlp6kyl/izvObBoe0q9E24/x2a/oAvezSFan1OX6VQTOp5sp
	 XbGSwwLd9l+P5+xnWrZ6I8KOTHVWcrWSbpLP42QT8DyqGhcoOqtc+a4DOCmgRm9IFe
	 oiDyiIdBxuKDhRFLp4hadXjFd7MqxDhekNxh4U47OZkS47ymQAtT8qZ8kej/O6J1Uo
	 jtfSym6QZTLu+OP9Fuec09FOoXd77svf/Ixyw6ARqTOX7uCDJ5jgA7HSRRA3gEsKmD
	 +CU3Cgb0BdfBgGTD+eIL5Inooarzhz6Un0ujHX+X5m2SBtGa8Mm+aYlkfQ3NmUeyNG
	 M0WIDRGCe6UbQ==
Date: Sun, 21 Apr 2024 14:03:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6] PCI: Add support for preserving boot configuration
Message-ID: <20240421190324.GA373874@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418174043.3750240-1-vidyas@nvidia.com>

On Thu, Apr 18, 2024 at 11:10:43PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.

This looks great; my only comments are:

  - It might make sense to move the _DSM evaluation to pci-acpi.c
    instead of probe.c.

  - There are a few different things going on (move _DSM, look at DT
    host bridge in addition to of_chosen, integrate ACPI and DT flows,
    tweak usage of PCI_PROBE_ONLY vs bridge->preserve_config, use
    pci_assign_unassigned_root_bus_resources() when we didn't before),
    and I think they could be split into multiple patches to make it
    easier to read.

I took a stab at splitting this, but didn't quite complete it.  I'll
post that as v7-incomplete, and if you compare with v6, you'll see
what's missing (the PCI_PROBE_ONLY and assign resources stuff --
there's some subtlety there that wasn't obvious to me).

Bjorn

