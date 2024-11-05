Return-Path: <linux-pci+bounces-16075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56489BD62E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D38C1F231D4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E775215C5D;
	Tue,  5 Nov 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AqbI3EfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80D21314D;
	Tue,  5 Nov 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836444; cv=none; b=h3AAPCDa1pVX+qGUO6hWziwVQ2kWPEVrJFAGDD9rJie8gkZf7Ri8YK/QNa7AVF7WUXlAGJ3Ruqrym8jXIbLVfqolAA60LMZHEECc6kE4WLK2iBd7X/1iDhPB++OkRh9BzvRUc4iX3XM/psy0Sh5JRR01WmivBPyKXzRHEOH6OQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836444; c=relaxed/simple;
	bh=+efwDgsL5kdxhquJ726B2aVtSTKsUaVpwEJV0U7NngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLSbyCbtjtbcPvi7V9Vj+6g7NzTcjLDDf9zTMe9tQbmryV/qvkYeGIUPS4xTCUm7FH5i5Adg55GQ2jjz+G7Eq+6tNYuFIaTp1EU5YdZFMEPggpNEnIMtfbTdp8eLZANMP8uPoxbjX/ZPh0rmSwdqEirj4D9AJdEKq6dAcjYOJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AqbI3EfZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39F4D40E015F;
	Tue,  5 Nov 2024 19:54:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wIxVrSRs8AUn; Tue,  5 Nov 2024 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730836435; bh=4i0MWhcttt8lP/8hNHTEbVLBL2+Rd38cASnwAE9yTrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqbI3EfZ1QLV99B2e1E3+cY4+WI34Nq2zxk/oDxCpnzsRiEPdxQa8XGG3fe3gBiu1
	 R8Ivw8kbEiPsuYys3WfJkuPYWfLq41SpuA79wnqWE+OIcgp0jpeMPqi8oo1fO5Il7P
	 fHyIDoOgNgrl+kh+8dZY903FbPzrRTIo8JZjyMbnPrC8oVycwsKoF7DId2f144PHDN
	 CEAU7wbhvgnEFWdLw7u6+BOAZdXC6AhJAe8JsHHRBt9OKQjFoze2T/TTf7NQ7Kv8f+
	 iQdaWJUGVYZ64SYOJJDaWUYB0eZ+gmVbvcEJ8ld8eZp4dpTw36xoWGNd0P6H1v6a0y
	 30tYk5yqTc0qkCZnYl+Ih1+z+T6jELPPHM9Hs0kQ6BtRsb+4d7PBrt8PwbBs2sI4se
	 c8MTnt4TGnnEbvXhl+aI6YSU6Zc0nrgcierMIN3oT/QjIBKn3GxuiozvM2DJIpt0PP
	 Ghzp/K/v8NkNlOeFFfykXLPRJtRV8l99Jziq/fryIrWYxy2cVlS2Yxl+GZliTglOMx
	 ++BJ3FpEh2y1Ksz7cNa4E/qGDPG8JEBTahRmDAF8aBlF80NnqyMMv/lr2BKqXbQEoX
	 F/8Q97UsYZo61Fchmdyya7QwgoRC0xRjAvQsDTUV5ruGyEOmy8CEdUWdUdqNR8fQ/e
	 6pry3terSAVsLoVnHSJO3Dcg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D05340E0028;
	Tue,  5 Nov 2024 19:53:34 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:53:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
Message-ID: <20241105195329.GHZyp3uVMKHAF3BEmV@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
 <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
 <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>

On Tue, Nov 05, 2024 at 01:46:46PM -0600, Mario Limonciello wrote:
> Why the worry about it being in debugfs by default?

I want people to *actively* and *explicitly* do something before they can
brick their systems.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

