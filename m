Return-Path: <linux-pci+bounces-37731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B877BC68CB
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00A84E253A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC31E9915;
	Wed,  8 Oct 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlJwLS1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7091C8630
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954485; cv=none; b=KzihGipTn24RIqWq0opKWCHJSzmsvt/Wa+PCEW+Ez1sWgqlETmmGNDw5mFDt8Wv8Ng4Fo4nRsI2olGKww/GzCi4IVk8Eu8ZQNB394IhpSgvylr4moewgBfUAzHWm/5rkPRp7XEwar6JUkcibP1gy2tMwDFFnJJZaMJ1EQUcHkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954485; c=relaxed/simple;
	bh=umcU4hxH876meT/XFGsI1IlaWGTbvdRsSpSbFYAV5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OYNOaRAX/6i5250GPBz/fkCTyhQqd6i3C65nCZjN90M2GNRXYP8ph9lJsikEUlLYxmQ5uPbfSlUR+FSiZoyD6u+n8s1LJdjswoLOBJy8yuv12N9N2qJED7CyJehyeOX+9Fxl7FK4ldnd1P/RaTkJKzG+ERWXUmpEEw2MDAUoAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlJwLS1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F1C4CEE7;
	Wed,  8 Oct 2025 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954484;
	bh=umcU4hxH876meT/XFGsI1IlaWGTbvdRsSpSbFYAV5rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SlJwLS1BPOPXe1quxWckPIRV4TQwS9NvUWORc2TfjBj8tEWetuH9WHYFyKLt+D3g7
	 9BcleiT4h55df+K/m23uoMIbhvMgnPrYNDmVp0E0KG08CAXIfx8JrRmQ2diUwps8i7
	 vjTf9bKeXpbUH8k8HAxv14M+DOOz5BfO81HFIA6crnC5vVQ+y2r1QkXNFRcXz0YjCt
	 QYE4UG+KmJkZO1Kk6PyY9Z1jxdbnExHL0Ch9c3ePydi7oi6BfEaI84+RLbGB143YKX
	 aif5tZq2kggGnoZbX0uS5ZP6beFLSa3wSNF2F0g5xi2c+F+X2osNraZqvVkDWx9yOJ
	 zcKlu0SfpxGAA==
Date: Wed, 8 Oct 2025 15:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available
 memory to use loops") gives errors enumerating TBolt devices behind my TB
 dock
Message-ID: <20251008201443.GA638724@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd551b81-9e81-480b-aab3-7cf8b8bbc1d0@panix.com>

On Tue, Oct 07, 2025 at 02:39:09PM -0700, Kenneth Crudup wrote:
> 
> I'm running Linus' master (as of a8cdf51cda30).
> 
> I have a Thunderbolt dock (Amazon Basics generic thing, but it also happens
> on my CalDigit TB4). With the above commit (and aaae2863e731 ("PCI: Refactor
> remove_dev_resources() to use pbus_select_window()), so the Subject: commit
> would come out cleanly) if I plug in a TB device past my TB Dock, they don't
> fully enumerate (i.e., no DP tunneling, no partitions created, etc.)

Can you try this patch, which identified the same 4292a1e45fd4 commit?

  https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com

I tentatively put it on pci/for-linus.

