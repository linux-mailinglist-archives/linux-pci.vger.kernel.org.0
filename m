Return-Path: <linux-pci+bounces-22367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D639A448F3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34490886AA0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB320F09C;
	Tue, 25 Feb 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tpqM2TGw"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA7197A67;
	Tue, 25 Feb 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504648; cv=none; b=rAwXwuXImNZnHTNql5VTeUBrmNwVCYFOtpTJPqkCOlfSEkzeI5Ro+p38HIuTflfI6R4q9zlAQWqKj/TzF95W5u7U83Uz8SaQrP/WPLuNNom+fDJSrQX7ePwW8wTvlGugihHNX5x0Dc0q28XaLOsGyf/E8YxjbTvnoQFwcVWeb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504648; c=relaxed/simple;
	bh=itwgK22G9rllbagjd/8jiNO6p0Fq5QxWo+ez3b+qMAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly0K5mgYg/BZausavHXJUGQmIq5mHvxwmy7ChMv8zxhFuUxgjcmKohC289T+QnSmqDPsAHUKSF6qCBekq3BD4WuX0XBvRgH5BLCfU2yQVaDQkrrWGXlqhwvIH2mE+oANCZLvyAnHI/fEW2nEx1XkZzpweDH8t6x1e2vng3lRS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tpqM2TGw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PoNy04ufD75FmyL3FJfDlJ+7bfM+YkXytgxrTMkPUTA=; b=tpqM2TGwG8r9JI43TiUsJZQcyV
	N9QO1ezGwHjR2jGSg2DWKw7IZMrQHjxQSjawlFNPZvaa3Bk1qJ4f8DeGF+TfoSOStek9kDCizeVqN
	092U3o64glZQQ2yDCbcURyVpo49zDdnuUcgq8IilS6S3WNpRIubzydAv62Rgm4aTiMxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmylF-00HaE9-TD; Tue, 25 Feb 2025 18:30:25 +0100
Date: Tue, 25 Feb 2025 18:30:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <7ff54e42-a76c-42b1-b95c-1dd2ee47fe93@lunn.ch>
References: <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
 <20250225160542.GA507421@bhelgaas>
 <20250225165746.GH53094@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225165746.GH53094@unreal>

> We always read VPD by using "sudo ..." command, until one of our customers
> requested to provide a way to run monitoring library without any root access.
> It runs on hypervisor and being non-root there is super important for them.

You can chmod files in sys. So the administrator can change the
permissions, and then non-root users can access it.

This seems a more scalable solution that adding a special case in the
kernel.

	Andrew

