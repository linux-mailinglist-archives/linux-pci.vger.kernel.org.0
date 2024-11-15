Return-Path: <linux-pci+bounces-16942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681599CF9BF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29228B2AD5B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099718DF65;
	Fri, 15 Nov 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAS5yure"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234218DF6E;
	Fri, 15 Nov 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709240; cv=none; b=RkuFgcDaNVFJXnarPTWImWvwitxYMf635r44IrVXPwtsjZfDa25wazAufUBlp1BEuivmxhTocxNWA3TOvHyR8zGyxmMJHgfDvbgHuCCzdBKfa9/I2xYeayXiZvJvWaK1/kLDIlJEyJkvKZ6UFz/3JS7SU7iRthe5Du1TSnR4r88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709240; c=relaxed/simple;
	bh=YEbIVo1wJQ4C/7AYDnCrmqFUNPjdBkHWoZanVZOmc4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nFTaT59eCQEnvSkG5UIOlFj4ipGVPolPcLkfcyB+4gU29Vo5cjAcEcSPGHhhFJiw3YA49jmRrxaj+ZfYxBBipNzfQw83eJL4mJBinMPZ3JqoPpYfXJvTcbdnWMhWfMiw/94SoJowJW4RU55xufEq0Ij9By5yvrJcl3hKDgzIclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAS5yure; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B00C4CECF;
	Fri, 15 Nov 2024 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731709240;
	bh=YEbIVo1wJQ4C/7AYDnCrmqFUNPjdBkHWoZanVZOmc4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rAS5yureYW4EChvqhEnR8hiiiPxSFVks7f31D0nZSHKh2zZto53j/IxYwczEZIWfq
	 w2v1fZJWSKc34TQ9XODi0t9of+rp24bH3GmwV0rSPgPQXHcIlek5Jx08V+xGvzAByb
	 efMGANqdLUFsru74uhL0yprtruElrdzhNEw2k/2bxTgIoGVdU+zrtt6fdq8jCcnzS8
	 9LBul4Fcw/Hte1+sXAabn4zSQ/AlM5df6bhtkaEUDhh6ARkXhmdl8OHb+0DhhwkI6g
	 armbR+bukhe2nQwi4CXk+st/0kkY+zqcRlzJy5xMB4LL1JxjTtY+Sqy0o0RWRa8V+Q
	 s/ZyybgkE7nqg==
Date: Fri, 15 Nov 2024 16:20:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bhelgaas@google.com, Wei Huang <wei.huang2@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, asml.silence@gmail.com, almasrymina@google.com,
	gospo@broadcom.com, michael.chan@broadcom.com,
	ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
	andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
	Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20241115222038.GA2063216@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115140434.50457691@kernel.org>

On Fri, Nov 15, 2024 at 02:04:34PM -0800, Jakub Kicinski wrote:
> ...
> Bjorn, do you have a strong preference to have a user of the TPH code
> merged as part of 6.13?  We're very close to the merge window, I'm not
> sure build bots etc. will have enough time to hammer this code.
> My weak preference would be to punt these driver changes to 6.14
> avoid all the conflicts and risks (unless Linus gives us another week.)

I do not have a preference.  The PCI core changes are queued for
v6.13, so driver changes will be able to go the normal netdev route
for v6.14.

I agree it seems late to add significant things for v6.13.

Bjorn

