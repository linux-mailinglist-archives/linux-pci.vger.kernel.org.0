Return-Path: <linux-pci+bounces-3908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0F860AD2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 07:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7291F2483A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CE12B68;
	Fri, 23 Feb 2024 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bbGXLkDp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CD125B3;
	Fri, 23 Feb 2024 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670006; cv=none; b=Fd3TtKzSUqJWhvsFB9ZCTiNivlUB40wwk6+ZBAlOOUSC/EfTxBD/0AjNRE8JOmUj923w1gNzOMwpkCxMm0LqOF90XuFWetPBf3iQXB5Bam9vNoIaeTfrD80sU/GKOTyxqUGJtSKHXXef4ANHMK3mCVSQNuXU/KZvIkvXZnF+DrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670006; c=relaxed/simple;
	bh=dThcPl3XK7RY5dgaObaEGYKBmy4AdP7HURVc8OjMtqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unuu5gq1S/Uoo2/spxIpBsd0tqqarw+ntxtzcQ/yYvDwvIB8wxEYUSyaI9AZYd3RAdRjdfsxwYMgBxNon8JpZEwcy/homQSnmfkA1F7xUXsdZ5vMRpoKXe67STrdSdysAfq4B/GpXwHqRWEP4WGVbx1t2CWO1y8i3nvwi1xEq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bbGXLkDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D37C433C7;
	Fri, 23 Feb 2024 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708670006;
	bh=dThcPl3XK7RY5dgaObaEGYKBmy4AdP7HURVc8OjMtqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbGXLkDp5iFFUzcPFhjNZZZda8EkIIp350je1FEuGhT5XE9PiyT3g+NZVCSI4OQlr
	 BXX4mdQwq6AsXhyKzVQIGo1aw0RDEUt2j1Y+Kla2HPDX1pizKfWy/4sdcbYlIIBe3+
	 4dkOcnvQXydNa9kd53NyHNIzLFoUnBVnHjU20F2c=
Date: Fri, 23 Feb 2024 07:33:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/3] sysfs: Group visibility fixups
Message-ID: <2024022342-unbroken-september-e58d@gregkh>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Feb 22, 2024 at 12:40:48PM -0800, Dan Williams wrote:
> Hey Greg,
> 
> Marc was able to get me a backtrace for that bootup hang scenario that
> Pierre noted here [1]. A Tested-by is still pending, but I am certain
> this is the issue, and it may impact more than just the one platform if
> that "empty_attrs" pattern has been repeated anywhere else in the
> kernel.
> 
> I also took some time to document how to use the helpers a bit better,
> and introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() for cases where all
> that matters is group visibility and not per attribute visibility.
> 
> [1]: http://lore.kernel.org/r/b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com

I'll just queue these up now on my normal driver-core-next branch, and
not worry about a stable tag as I doubt anyone wants that now.  But if
they do, please let me know and I can provide one.

thanks for the quick fixes!

greg k-h

