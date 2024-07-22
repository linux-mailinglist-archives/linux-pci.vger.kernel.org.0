Return-Path: <linux-pci+bounces-10618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B65939481
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 21:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F45628249F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC52171098;
	Mon, 22 Jul 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlwd0MtU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758E1CF96;
	Mon, 22 Jul 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678290; cv=none; b=uLm6mEV5z/3CAIpsJF1wMubx2FNk8ggFRwGMwERcUQrMmc+iS32AFFciI51WqBXYuKNkKvqIT8yICltIyEcOudOpCJN7GTUWc/9PIikjy0ZM9Ye0HrUbMWQUB5dGWtZDQQ9yq8+Qqij0tpb/WaHnNLYwK+IovBOKl6dAXiccVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678290; c=relaxed/simple;
	bh=wNxQzc6PHcEur/gfPKmxYKmaxva5dftyG4TEkbeZSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TVb1F6ssGUNlZM98Yer6xMFE9zFMO963Sy2LCbr+p+7B2PA9Up4VFkAys5jkxVdeEcgcCEcoON/yxDmJ62njaCfbdpwn+D/OBONpq2wkzzbvraOoSO0VnnUpZwyRWBGAQ9+4Oo108dWzxBBihogMHuYo+3OKlvQCyHtmr1xfFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlwd0MtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9458C116B1;
	Mon, 22 Jul 2024 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678290;
	bh=wNxQzc6PHcEur/gfPKmxYKmaxva5dftyG4TEkbeZSB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mlwd0MtUG63ckboCPW5h/okSrziS2J88ECm5sIpsJ03nPt81dinQumnZKBIpH9UHP
	 Yw2NaRwE3lOXmhLm1kBaqksXYBb38BOhJyPR3myORcENIhVA1O+jdCxmVKdhKlPEmx
	 aPFf3KzuEh/qWhgUtJ21O//DX6nBlzMiXVIBvWDAn6KevryIy7qMbIM2m84xnii3SL
	 jnxRXm6P9tlmTXfueEGv5OXQJpPcDPO6ic4yFTh9ZnozD5q47RfiH6sdewAW9zpiG7
	 ycpug3EevugRAAHCCj+2AnyiJom5/TB+2BRISPanmuNcB2RTv8dc1PbRMwryaJ/UYI
	 1VacNNpxApSvw==
Date: Mon, 22 Jul 2024 14:58:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ngn <ngn@ngn.tf>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: shpchp: Remove hpc_ops
Message-ID: <20240722195808.GA729979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp48oG47T_ZcwSI1@archbtw>

On Mon, Jul 22, 2024 at 02:04:00PM +0300, ngn wrote:
> hpc_ops struct is only used by shpchp, and it's unnecessary. This is
> explained in the TODO file: drivers/pci/hotplug/TODO.

This is a true statement, but it doesn't actually say what the patch
*does* about it.

The subject line does say it, but it should also be in the commit log
itself because the subject is a title, not part of the commit log:

https://chris.beams.io/posts/git-commit/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94

Point to the commit(s) that make similar changes to other drivers.

Please also update the TODO file to remove this item.

> Signed-off-by: ngn <ngn@ngn.tf>
> ---

What's the change from v1?  It can go here (below the "---" cut line),
where it's useful but doesn't get included in the commit log when
merged.

Bjorn

