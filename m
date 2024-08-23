Return-Path: <linux-pci+bounces-12140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E095D84A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E2B216CF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA32186E3B;
	Fri, 23 Aug 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me4fsmzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8C7D401
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446984; cv=none; b=B77aCqVQ/WuSzbl8iKyEgFnYNl9Yq5wPM9+8WhyLKdixJFnIURSLTQQ/oi0d/eB6lg9jzffz8P+DleDlVbqBBl4yDphtbVhtwqxtKw8LWTm3XCF+ouKTMRIUYWGdSseeU1xYqjMUOZXQCmiHm2YMzBg5j447UZ/GwMNXcgZGyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446984; c=relaxed/simple;
	bh=dF9dkzodItU/CO+qAZGmCor1MDbLY68eG0ctBSD3Vu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sLvZsQat0mmxt4l7ep48owzsIkvKZNQoSKSXCtlYZPcqKD3+vo3x1vNItctF6Adbj+XEZ0Kg0VJIkA3SOhX5d+KcMWXrcCqBTlfykwzD0PVY1z3cTGLHfyWq1nP2zAlxZJ+CbzVXrqu7sbhLGvaGHqUFClyj0ew4pm7+sbftkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me4fsmzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2750C32786;
	Fri, 23 Aug 2024 21:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724446984;
	bh=dF9dkzodItU/CO+qAZGmCor1MDbLY68eG0ctBSD3Vu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=me4fsmzVVf4OVsI/llD8pcOv+OI2K6rkiO5vZzU4fDZ1dmLJehHNncB0Oiik7SY04
	 vo66zd4MrpApiVTrX4CG7viAAQQjar4lP2RKgNVDYlXP+kr6taXHXhDdrge2NYw8Km
	 DSEs9GAGo3pX8yx3dlbZpya/DGAWkg9wtN7p/pl6+uCjq8up7M/mjp4rTBEJi2T8CM
	 1aWyVqq9T5A2gwaZrZHOW3Z6VG4jkl5LcDj41TkDdd+MtxUkmtSnQU90e1Pbzqe2rD
	 7DrZL8MEo/pg4xe5Simfi1zSOBIHySKJbPi5fFbMVowy/D/f1if6U1gHDdkTJL6gto
	 yTocp+al8ZHUQ==
Date: Fri, 23 Aug 2024 16:03:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Erin_Tsao@wistron.com
Cc: Linux-PCI Mailing List <linux-pci@vger.kernel.org>,
	Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Subject: Re: Issue about PCI physical slot fetch incorrect number
Message-ID: <20240823210301.GA385342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20240823.185024.10254.nikam@ucw.cz>

Hi Erin, thanks for your question.

On Fri, Aug 23, 2024 at 08:51:58PM +0200, Martin Mareš wrote:
> Hi!
> 
> > This is Erin from Taiwan. I have a question about physical slot
> > number.  Currently we are working on the PCIE slot number
> > assigning by PCIE switch. In the PCIe slot assignment process, the
> > slot numbers are assigned to bridges first, and then the end
> > devices fetch the slot ID from the bridge in the upper layer.
> > 
> > I have observed that under our PCIE switch, GPUs will create a
> > bridge before reaching the end device. If GPUs also fetch the slot
> > ID from the upper bridge layer, they may retrieve incorrect
> > values.
> > 
> > Our GPU will get the physical slot number with number “0”, and
> > show the slot number “0”、”0-1” , etc.
> > May I ask
> > 
> >   1.  Why GPU will fetch the slot number “0”? Is the slot number
> >   assigned to GPU related to any register? Or can we set any bit
> >   to fetch the right number?
> >
> >   2.  Is there any possible for us not to show the physical slot
> >   number of GPU?

Can you supply logs showing what you see and what's incorrect?

For example, if lspci is showing the wrong thing, can you provide the
complete output of "sudo lspci -vv" and indicate which things are
wrong?

If the kernel dmesg log is wrong, can you supply that output and point
out what's wrong?

Also, I think slots are exposed in /sys, so please include the output
of "grep . /sys/bus/pci/slots/*/address".

Slot numbering is messy because there are several sources of
information, e.g., the Physical Slot Number in the Slot Capabilities
register, SMBIOS table, ACPI _DSM methods, etc., and they are not all
coordinated.  So the kernel goes to some trouble to come up with a
unique "slot number" for each slot.

Bjorn

