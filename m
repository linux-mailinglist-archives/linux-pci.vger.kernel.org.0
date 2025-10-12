Return-Path: <linux-pci+bounces-37856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5052BD09E8
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4A5B4E33B2
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA125A354;
	Sun, 12 Oct 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyGLwPjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B5193077;
	Sun, 12 Oct 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294257; cv=none; b=JYLsVFLhS1kE2pG2jvykXmHF7Agf0p2Ntu74cE50l+2X4VD03HYHlLrl5a6WHptXIjqWUqs7d70z0R6quZ/W46yOlHauAyxPbUSUkwg7IkNeJo+xZlOw4jWbOli5dREwVulVK6yVijz37HHe9+HRBjVqTEp0aGq7NMTa18W6cxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294257; c=relaxed/simple;
	bh=ISZNqha6pY0OSa8MgD7namr6YOmnDQUXlgiOE8gWXQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thIXGau96DpHYg7UgQL4TBYjjM20bRPblH8KZQfGR8nIxhcDc0zPTtlHn0enDWusgi/96KGkCSkOL8xLAhppCpIDDaXKOlXB1fyb+ihkLyKgIKAk3RJSOukIjBHcOL+EqzsQERfP+xYZ0Ush5e6uHslh6A5Xcr4UKiwfBtrYJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyGLwPjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD6C4CEE7;
	Sun, 12 Oct 2025 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760294256;
	bh=ISZNqha6pY0OSa8MgD7namr6YOmnDQUXlgiOE8gWXQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SyGLwPjJj/d6+Gs8rAOV1kHewG2LoANWY6eX+sfoo316t4BPGSWntbb8h5o5ZusGR
	 ninCEAPfPKJpiR2SL9j1498IvrnXoNoe+S8B9JkUoKglkaDHDdrw2P+6m+XAiE72kG
	 6CC7lAmWc6Ngt9AvOSW+6Wk+VSkHB7trx36uykLNU7WFIfXm0/6ZJQ+fcIKMAx4SA9
	 kLPujQaHDNFpRsbEciemjmpgOubmXHPwA5Di0j3bu0aPTiEG18VOLzsttgfQQXA2uU
	 f/IjSqOP6Chpy27GikWoo9BPj4UFREoTw7nypGk2MK9ywO1LEjFIHlPhJdktJC+MBO
	 k6434iDZVZyCA==
Message-ID: <1be1a119-1fbd-435f-bb27-70f48d677ebf@kernel.org>
Date: Sun, 12 Oct 2025 13:37:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with a
 screen info check
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-3-superm1@kernel.org> <20251012182302.GA3412@sol>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251012182302.GA3412@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/25 1:23 PM, Eric Biggers wrote:
> Hi,
> 
> On Mon, Aug 11, 2025 at 11:26:04AM -0500, Mario Limonciello (AMD) wrote:
>> vga_is_firmware_default() checks firmware resources to find the owner
>> framebuffer resources to find the firmware PCI device.  This is an
>> open coded implementation of screen_info_pci_dev().  Switch to using
>> screen_info_pci_dev() instead.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> I'm getting a black screen on boot on mainline, and it bisected to this
> commit.  Reverting this commit fixed it.
> 
> Please revert.
> 
> - Eric

Can you please share more information about your issue before we jump 
straight into a revert?  What kind of hardware do you have?  Perhaps a 
kernel log from mainline and another from mainline with the revert could 
help identify what's going on?

A revert might be the right solution, but I would rather fix the issue 
if it's plausible to do so.

