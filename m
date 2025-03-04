Return-Path: <linux-pci+bounces-22918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FEA4F11A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC0D1778D0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0218F2FC;
	Tue,  4 Mar 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn05PYkE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F551F2380
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129377; cv=none; b=RVvhueycQdZi5Ntf9Ah0n3/FIwGtevkwbm1knuSIKvGg0iU/XMQBN9w3P6UwPwDsT/8brswc0Mvu5C+QSECpZGU9DftA4LJUzupT44fjB/DYhdAIL5sIQU1mp6m441jib7so9wWHirJUuHY9rvb4JeFQUDSka/mb/Ovp/5W6D74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129377; c=relaxed/simple;
	bh=jKfW+u/tqiv5Gh8IskGVLz2Bw5JKEDQLY9m11/9W1J8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hDwUPt0WSEC6HWkscN/Dd+ort0+6IATkizde0ng7koC1bdUAVy21ukwtMTNwu//nKpZqGr8h8x3e8am7POoFQmziK3wQj8eAvRtTabgqkkhFDBs0elRg4s8s6pDLT8/ejtJWw5wCs6bsfCdPOyOnhtMDAk+tIkMAGUF8egcPj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn05PYkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A23C4CEE5;
	Tue,  4 Mar 2025 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741129377;
	bh=jKfW+u/tqiv5Gh8IskGVLz2Bw5JKEDQLY9m11/9W1J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zn05PYkEE60vOodgUYEnS7kdxVtjgqSTBOtoZiUkvQWFQEZNvuRH76S0yVkxIM5Y7
	 5LAPzgyP49sSTO7yV542kWETw9YaBHvnVdJ1YJFDwjiZR45sJXaT4xfp3CcXiywSl0
	 qNn9oYr+6oErx1ZSahAllKFus6zrnfYmABwfrKEc9OEyB0W80Md5Zf4I7Q2Rr7KKuU
	 wDTT1xBcZ59YfvSpj2yeyUBmyy29oasCsb9bc6Ih/ps/KgKPM+MwmNX+vEWkut2JW8
	 DtxOw1yQXwv8UfGycd3e+/D4uT3Hqkcfd1jW6q1O5pTzr9m9N8sM6bsNDkK3vVZCEB
	 FPVJtNAyVk7eA==
Date: Tue, 4 Mar 2025 17:02:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI hotplug cleanups
Message-ID: <20250304230255.GA263624@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>

On Tue, Feb 25, 2025 at 06:06:00PM +0100, Lukas Wunner wrote:
> Here's a collection of cleanups for the PCI hotplug core.
> None of them should result in a behavioral change.
> Just removal and untangling of ancient, unnecessary code.
> 
> Lukas Wunner (5):
>   PCI: hotplug: Drop superfluous pci_hotplug_slot_list
>   PCI: hotplug: Drop superfluous try_module_get() calls
>   PCI: hotplug: Drop superfluous NULL pointer checks in has_*_file()
>   PCI: hotplug: Avoid backpointer dereferencing in has_*_file()
>   PCI: hotplug: Inline pci_hp_{create,remove}_module_link()
> 
>  drivers/pci/hotplug/pci_hotplug_core.c | 142 +++++++------------------
>  drivers/pci/slot.c                     |  44 --------
>  include/linux/pci.h                    |   5 -
>  include/linux/pci_hotplug.h            |   2 -
>  4 files changed, 41 insertions(+), 152 deletions(-)

Applied to pci/hotplug for v6.15, thanks!

