Return-Path: <linux-pci+bounces-12692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C196A716
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153CA285C4F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0E1D5CC6;
	Tue,  3 Sep 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UaCoRUQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA841D5CC0;
	Tue,  3 Sep 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390387; cv=none; b=cmQc6e5XjfaMqUYKbYy4Bxl2jeqvGeKiNSdROE9GfCw2UpzgTkADZByYX6EQ3KjTWsFGS4iFwbZ3QKf+g/iTyrWgBX2qZM0bHw6JWWAULPMt2WzTc2qxpt8MT/WuvtyHK9faYdUY69a6dWUelW2FsQR6ipayFRx0DsmmOWHuk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390387; c=relaxed/simple;
	bh=/n5u1654Q5rzMISWujbIP8voRgjx6JkejMERgmKCImc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGwaWzjL5BS8ZWU4GJ7HAN4cewfLvpT6NswrAyiNcjzaDK5d8/pZbH2/2GG2qM+uQoj+2S9+sgqMTJM5rMarjJgP2rKbzH5BDzp8MVlFuRKtLcDcXT6qJT2xFjalUNNX6WIuO6oweMlmGyWiN8dQHNuZIpENQutsEUiuskhtcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UaCoRUQQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EOgkwVKRurnNpdIKVIOmmcQJPvtabWNaS20z9ZqkdiM=; b=UaCoRUQQo9aPK2t4bSEYVcHPxa
	HegkcytAjX8NOL4Sg90B3chFlgzEutc2pd9O6lxcjqECPvrM/BVeT7jd9LAD2JV+R1tM7j3p+v9Mu
	XZje35/fJ+zFjErzCWLkQFJ26Vgc+xNHGhOwJ8E351WwEuhIaMbBOSFRvj6WUWv2F++s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slYr2-006Smc-Ub; Tue, 03 Sep 2024 21:06:16 +0200
Date: Tue, 3 Sep 2024 21:06:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	pali@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH -next] PCI: mvebu: Enable module autoloading
Message-ID: <f9566bb5-6926-4333-80ba-869d18b6ec42@lunn.ch>
References: <20240903132311.961646-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903132311.961646-1-liaochen4@huawei.com>

On Tue, Sep 03, 2024 at 01:23:11PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

It is maybe too late for this merge window. Please repost when the
next cycle starts.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

