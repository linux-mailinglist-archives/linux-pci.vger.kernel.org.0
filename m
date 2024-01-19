Return-Path: <linux-pci+bounces-2330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1878322AD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 01:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317001F23892
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945780D;
	Fri, 19 Jan 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/ApML9M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B63EC2;
	Fri, 19 Jan 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705624962; cv=none; b=f3v0C34x+I0tluE0p+oGI2wfgBZX4VbAHLIRqGU24HD0fml5pyBwPsPD85qpYDkvaTJ6JTVNy4WQIH1nT0Ek2G0qvvZWt5owYEvfkat+nbJeJnwC7f1EfcOGAOQqDwTyIUgmQUe+33RlkIWlIGd23XQKQnghrQcjD78R8SaB5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705624962; c=relaxed/simple;
	bh=KFftwYqFIcoquNtZ1NqkoabheV00jhXZ9kZGcoYTiW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FKPZiCKWUm76t85LPXT0ZeR8kNCAb9tRAA7f9TbJuPmbishjQubNlWB3/LUuMuNkSP1DCM7ih1q00xnWQGbwYGJA/VBDy/0h2RZGsUV6CV5NvmP1lAR53HlWpSv37xjwG9sM9QwoSUaSff6CieVnSJuMWi2ShRXKxAt60x4EIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/ApML9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41D2CC433F1;
	Fri, 19 Jan 2024 00:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705624962;
	bh=KFftwYqFIcoquNtZ1NqkoabheV00jhXZ9kZGcoYTiW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k/ApML9MPV4+/iK5OnnqWaG2hNLCHxImi+GXb/OImwyzX/IBOPriqF2J8MXm4t0+t
	 d0FGPL+XPMaaNXmiGFle6+VSxSI3luAhdT3FcY0mt929R/4Upun2RqvMm3WxgPjmFZ
	 SMkS7Hi43+JYKSbf3R6uWoDPdfFEQQz1D8KCkUqqXVLwAJdt/6YNkX+CN2Nl6K+k7k
	 Ni2DomxEYfHO8SLF3Ia0+YHjohRR8MfainNBhARYQuADQ0k65AyFhPvTcme89fmO7+
	 SsXYf58x7k2EpF/h39/00LZihmner0M1V2XF8/kGRDjU6IbeRfgoSMnEkAIntAujL8
	 sY+1cR3xMa9Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30AF7DFC697;
	Fri, 19 Jan 2024 00:42:42 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <65a1ecd2b9b02_293042946b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <65a1ecd2b9b02_293042946b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <65a1ecd2b9b02_293042946b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.8
X-PR-Tracked-Commit-Id: 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db5ccb9eb23189e99e244a4915dd31eedd8d428b
Message-Id: <170562496219.3707.9548987370412862817.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 00:42:42 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 17:52:18 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db5ccb9eb23189e99e244a4915dd31eedd8d428b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

