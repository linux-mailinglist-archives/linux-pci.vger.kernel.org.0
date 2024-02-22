Return-Path: <linux-pci+bounces-3894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8E86056B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA31C2345E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0012D1EC;
	Thu, 22 Feb 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8FQdZtL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33B73F37;
	Thu, 22 Feb 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639693; cv=none; b=lMbZqr8Vzq16Xy75IgRWGA/3kdmpD1tChqb2tt5919EdI5avtL6lSDPJI4TyfPrPXgQvEYHO8rG/uVNxU2sGAViOtQuSjv5s2cYvljBQPJk4fhVgESvMvrnqK3rh8F2fkjq0foodwC0tvCRMV8EG7PKWQaPH9e4/bPQU76uIjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639693; c=relaxed/simple;
	bh=CuQc5x7leFz9R9+zLGnroGX22UpyIfplVvG4ngR5Kso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lfCl0gRbFIku/RAkaOMtaEgtsBr+bsi3iiFJrL1RQJqAB32rbeAQaM45hZ1W1PnrP08AD4rE+vpyzgYAxFaY331vXFXEJUOpPpoV5Zfkp7ZIlJOJepvcX9xCPyu3wS1plTd6BpnC4zyn9jT08RYJ+eE5Nh9cyAHCndQ6E+tel3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8FQdZtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3C4C433C7;
	Thu, 22 Feb 2024 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708639693;
	bh=CuQc5x7leFz9R9+zLGnroGX22UpyIfplVvG4ngR5Kso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u8FQdZtLixiIeEa3nlQA2BOqfuEA288VBLVysxbhcTY4n1/4y/QUfks1sYI02qEPM
	 33YgWKHaHGQGIhkzXWhheAQvDCTrOQUjFnH47obguKW+fwXagbH+/rf+3OMrnay5vW
	 9qQUH3oPxce+mPGwmLv2a4l3HmTW5c/dsW7NvVE23ojrSrthlUwus4sP22itOfAvwR
	 Y4aUq4zBmJKrK75vOgtzavOIA/viEL1JfBV1NKao6YIvkZNuMsAdv1MuaIu1P1Cz69
	 OJTXHfOp/FaP7di+biTTklm+hwaP7sWDa0XtaGQj5LarxV09L6bFEhq1qxPVVRXi+/
	 IhHSr9wDoQ2ag==
Date: Thu, 22 Feb 2024 16:08:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: Add support for preserving boot configuration
Message-ID: <20240222220811.GA31251@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a29a7e-b013-4568-8e21-9647969b6b6d@nvidia.com>

On Fri, Feb 23, 2024 at 02:48:24AM +0530, Vidya Sagar wrote:
> On 22-02-2024 22:36, Bjorn Helgaas wrote:
> > On Thu, Feb 22, 2024 at 06:11:10PM +0530, Vidya Sagar wrote:

> > > +     if (&host_bridge->dev) {
> > Checking &host_bridge->dev doesn't seem like the right way to
> > determine whether this is an ACPI host bridge.

BTW, I think this condition is *always* true, since it's testing the
address of a member of a struct.

> Honestly, I couldn't find a clear way to differentiate between an
> ACPI based host bridge and a DT based host bridge. Hence, the
> current code tries to get the information using both ways and since
> a system can only be either ACPI or DT based, but one at a time,
> preserve_config will be set only once (assuming the system wants it
> to be set). Let me know if there is a better approach for this?

I'm not sure ACPI and DT will always be mutually exclusive; I think
we're headed toward some combinations, e.g.,
https://lore.kernel.org/linux-pci/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/

But I think "if (ACPI_HANDLE(&host_bridge->dev))" would work.

Bjorn

