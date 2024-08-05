Return-Path: <linux-pci+bounces-11300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41156947C05
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711B71C212F2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC5364AB;
	Mon,  5 Aug 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3BQJDYY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004492C6BD;
	Mon,  5 Aug 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865245; cv=none; b=ikPSZSxATC9lG7MuwqH7Dz/xcLLHH3pyzSJnkXt807VOyugntnMaKhWwOq66CfnL/sOwhB8B+Y1p7Iq2T83xaHO3jK3kKItImrqf5eyKm+mAIAEvD4FQXzehV7tWzFJantin6dXrSeXVfT+kVsJu1nSaAgBKf+fgS9Erg11zbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865245; c=relaxed/simple;
	bh=XY+dscO9tTyktveRJky0Xx7/WBsaLA+Ui51Oy0cLUDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uInt4lgSZ/cNwUQu9iJalJXsQfi7wfZAJTrod9T/N3BuQFP3Jv/hUqNGFe2nM36Bm8OUWYAGVvv8LfM4rSxjInvI7faWl7yTqOYG17o8qeTGgMGd5DIfYFMeWudl4SL2CRzwZUcpVC4r51z3MkbdjF7I3ict1wtUI4nG4FlyTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3BQJDYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE7BC32782;
	Mon,  5 Aug 2024 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865244;
	bh=XY+dscO9tTyktveRJky0Xx7/WBsaLA+Ui51Oy0cLUDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3BQJDYYx66efgPjMKURA+QQYAxvi0RIAhGRCzgLJ2L1AHbFimYq3qUHtzffd2x9l
	 BRs21lCgh73vlRdRTqiuHjBQvmoEYZodIS5ZugI7CgzzhkzXdScWM8FxN4THztm8KC
	 r+UqkerC5BXyjCAZRKNv3VT6L5jVv4MxCl8ZXKVB3G79hfGT0lEGL7sl269MFx3K8H
	 dLnqcC9srRu7/fdl8jVpV9+seYxPE3g+iRYLhfXp4eJr/m5h8/pL8w0S9MH3gXE4Yq
	 WFG/avuc0uK53O3UyLiHvFv2nYNVqH5qt5awDzMIWBSsJdO4ZZK/UkPZjtFfGxhk7n
	 Ci83Kquml7mzA==
Date: Mon, 5 Aug 2024 14:40:39 +0100
From: Will Deacon <will@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: steven <steven_ygui@163.com>, linux-pci@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: does dtb not support pci acs enable?
Message-ID: <20240805134038.GA9669@willie-the-truck>
References: <20240801234356.GA128584@bhelgaas>
 <20240802000042.GA129381@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802000042.GA129381@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 01, 2024 at 07:00:42PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2024 at 06:43:59PM -0500, Bjorn Helgaas wrote:
> > [+cc ARM, IOMMU folks; I don't know the answer, but maybe they do]
> 
> [+cc Vidya, Pavan, also see this recent thread:
> https://lore.kernel.org/r/PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com]

Specifically, it would be great to know if the diff from Pavan at the
end of that thread [1] helps you, Steven.

Will

[1] https://lore.kernel.org/r/f551eecc-33fa-4729-b004-64a532493705@quicinc.com

