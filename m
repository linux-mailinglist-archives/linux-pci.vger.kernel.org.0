Return-Path: <linux-pci+bounces-4860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6287DB08
	for <lists+linux-pci@lfdr.de>; Sat, 16 Mar 2024 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE612824C5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Mar 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704381BDD3;
	Sat, 16 Mar 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgq7KwvV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB961774E;
	Sat, 16 Mar 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609767; cv=none; b=f8eEAJ5zGM7thO1XKmpDnSgMPcewt5pybQ3qB/qyduhVegiHuvME6u0Mo7E63le2v/Rs64+M/flGPElSQxhAu15JLQOl3fPuzt/xRMLvvWyz/iWv2hH2L47H91RM5i+oKn4qrvZ5k3DDUwN3oEa9o+eZuIl90Bp1TnSHO6pIQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609767; c=relaxed/simple;
	bh=OwcZhnZw1/IKXQR0KBtUkffKK97jJwa0HroO/EWQklc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fGcetUaVuhF9xlKxJWzGwGkNfwHHMFMtOkWA8qqtmCRbPnlYzL5SbGYAw09d/jtsjL0F4ozDUjOvhH7xBDFgWq/+rGVJQ/MFq2o019FD/RIL+xDZktkDRZxCskX3ozievwbk1OAV3UofU8eQjgdY2R6+0SBe3KNeoRalgkAeEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgq7KwvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 201EAC433C7;
	Sat, 16 Mar 2024 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710609767;
	bh=OwcZhnZw1/IKXQR0KBtUkffKK97jJwa0HroO/EWQklc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mgq7KwvVl6bBnQxhdqOba3fd/SFx6JB0i9br8Ni4lkDbVlf+QlykSJ5CCJfU7apig
	 1XIr0QtCKHznTKki2gbMhN0cOzpOQZac68MWhURPLyCxVxAOTTl3ClnShjA1WTtAN2
	 +tfQ4pD8WZ7D2BBCygP+I3g2xP5lCKMZZvOL5dv3AmpHkgSjvQhTcCNfdTL9YolPho
	 ml9k3R8TZifvJaiVDuLHwKcqRn0Aq7ECTanapR1aA5/qSs8DyFrMlWPW7Ea03qgFCK
	 VzYg8c/zBWG5O77TOV1mNFJ2VabVVLwWDzs0l1AAbOEnfEz7auUULm3/9henXhJzk+
	 i/Obbc8N9MoAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1723AD95053;
	Sat, 16 Mar 2024 17:22:47 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <65f4ca886d04c_aa22294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <65f4ca886d04c_aa22294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <65f4ca886d04c_aa22294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.9
X-PR-Tracked-Commit-Id: ed1ff2fba7afa7baca7ceb93824a4699130b8377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02c163e959b72059ce409a8516170dc40193001f
Message-Id: <171060976708.10702.16553926827123077337.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 17:22:47 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 15:24:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02c163e959b72059ce409a8516170dc40193001f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

