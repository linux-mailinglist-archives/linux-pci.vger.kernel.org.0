Return-Path: <linux-pci+bounces-15703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8E9B7977
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847402817D3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ACA1991BA;
	Thu, 31 Oct 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gnnaMnss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0413DB99;
	Thu, 31 Oct 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373341; cv=none; b=o9hSUrEGB5VRMHHrBfA9649p76iFs0v7pr/DLcHA5yWjSY1CNnKvkq0GMLWbYnUuTs9tmIfiRUgyzosNRg8I1bU2Hr/QX1SCPVIT43GMPJUJ7um/6e2SmZMB+fqSqMoOLNhJUc1lRAwflHVLHrHU1MekTuleLAxZm/RO70IjgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373341; c=relaxed/simple;
	bh=cnxrShd8egeuggH2MUREYrryY7UEfBJB45aOUcY6el8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk1LOaJH9P8nmmzdojqAivsWxpCDkpEeviPDdahcT7PtfnXf+s9v/Urmc8iY9W5ry55fnooanX4pndg74E4JiRzxb4kkddQWithCKH+xIoxCjSo9xnYRA0CopqLDrGtiKb4l0otFjxJaV1Fd0rrJNHlU3uPoxM65VzjSQl6fAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gnnaMnss; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C5DE640E0028;
	Thu, 31 Oct 2024 11:15:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0ve0OhI2yM8A; Thu, 31 Oct 2024 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730373331; bh=byN1H8y1tWnzMdNx6+Ui4XRnmn6lYDerMw/dcXPaHWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnnaMnss/gqMVuzKyF/vEPXnZB3W6/YiiCck0PeUI3JrUmGbyqY1exwX8G/RICIFh
	 jk8PEj2ySPWJ3ot4k53erWEQ+gFILwrCff6EzsQvNUQmpO3YEOV6fjnRmjqR+coEcd
	 zxN/yg2A9HrLZMQYjnk4l+8ykkL70X58gEM8W1bVO4TA2AWnmFwn67mrnb1lFkzQNv
	 O+trjiUorhg5tGI5tONB+9THEOLTdsbmM2JYuXygLrwz2GCxy3m2HO/wyGD/kwnSzq
	 I1l45rh9QUMOOvmpQ+nkgZ0F1zeaeQfu/BP1pzxbq4oSh49YxkUmoG6U/dLPR2bDl5
	 o44NeaFL61ExXZk9PoawHejYBvGFnfA7g458WozFqix0ydhTYOPuGMN+B791MNfC7i
	 CqGxXhcpe5i1UpAKo0TYHzk+TNW7M8YGMdsh4lLXkuDUddbYQYD0faE6nLFSunHr9x
	 fqIcoRpJBVOfbQyV8FTI4xWNUBPsms0esAiwgIXXeE0d8ZkUzXSMsA8VwWumVcgQpm
	 O1TGQ7WeUwFPIoVXKZTI8S4lQfqSOVFkIy7egcD2p1y+O1awNj1ph330s8VWlR8V32
	 lvIpFG49uCkOFaXzO6iDdJrq235u1RqxtUBriJaYeta2hzz05hx3OjRCOzJOJREfKl
	 iNymN09MeAsoPPVuHNUaBN70=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CFF340E021C;
	Thu, 31 Oct 2024 11:15:10 +0000 (UTC)
Date: Thu, 31 Oct 2024 12:15:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 05/16] x86/amd_nb: Simplify function 4 search
Message-ID: <20241031111505.GHZyNmuQ79m-enfCgI@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-6-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-6-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:39PM +0000, Yazen Ghannam wrote:
> Use the newly added helper function to look up a CPU/Node function to
> find "function 4" devices.
> 
> This avoids the need to regularly add new PCI IDs for basic discovery.
> The unique PCI IDs are still useful in case of quirks or functional
> changes. And they should be used only in such a manner.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/amd_nb.h |  1 +
>  arch/x86/kernel/amd_nb.c      | 66 ++---------------------------------
>  2 files changed, 4 insertions(+), 63 deletions(-)

Nice cleanup.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

