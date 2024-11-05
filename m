Return-Path: <linux-pci+bounces-16079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B59BD66A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B375B2125B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC4215C76;
	Tue,  5 Nov 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LSyZ8AbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A72215C5D;
	Tue,  5 Nov 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836795; cv=none; b=KAm4L+X65P2CzDjrUuBlxFKJk9XfYQmv3McNzLsnyMpOy6hnQvPm1mBJ/BAeDpmNGYw2arIsWdILoBjkIvIVVDk5+Wu2koOggmlLKtU91WazaqV+BaunH4fbOzgBzBZx48XUV7Xita+UNh8xja6fIqTIjWBjRA+FCsiEiZFr+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836795; c=relaxed/simple;
	bh=j41Kh1BtbgPWZYM0Buh0jvF4cjs2tf3j0qf7oQkqDRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW9JW0iAPyzDiurNQmT39EKO0etjKFisubjFLlbJT3QaBI6sJnqmNNfAFrGkcXmYmeJ7Q64HIswXIGuz1wiipRJqg3ZY6XjA8kf7gu/lS8fV5kznxxKabyC0HQdDCI1vUp7NWjoH0ud2Ay3oPKvscBI5K59miVHr2DtItC5l8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LSyZ8AbX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7047240E0266;
	Tue,  5 Nov 2024 19:59:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WY4hckbG8ZsB; Tue,  5 Nov 2024 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730836787; bh=QaGrq4jRM1c6jhfUKBGPNxJah5e27K7X6DEAeC/Yyww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSyZ8AbXnPcvAN1jszLwx4nRqEh54bPrd9i8ExUV2DT1lABL7BbXAn45DkF6yIUeS
	 +LULeqa+SA79VXafwcww7n5Da+9v6e0uEpsjY0oPG3z7wE3cSTwe2qcP2JkF99aXq6
	 9/ti1RnqzsVjXeW9e6cSf6WV/zc0q3YWj540KlLRXLk0P3Ivvd3TkRAAxQtFBiaHtB
	 83IaNXeGv6qwMyCWc0pP0yf5wjVuW8K7BkQWmyli5uNx+JgE0CAOxsSsn/eMkmjQV3
	 EZVFeILbzn9oIWlK5qAyWK8C/Ycl0HDOBcAxS6sUuHkOtjtNgpJt9aeVC3n5kKXJhY
	 PXPGqgO/NAKViVOGTDI8Q6XmZKm+J1507MXmZo30zeUGK7oTRmQDMXbHsJLfRFtVPg
	 GBvwYxWzLSMXZ15xNJkJGRd+WhdMtNMjPoT7kQeqyk1WUGydvak9/LH8ZSK00H2BCr
	 Wwyel44SCb1qU+os0+MEnSiUawwWnKiJwum/i4DyKSVeTRV3C5cqYIaBBsxP2PD+l/
	 jpNwQvHGV///Y/V/neSgnHmfw9QjIypg3JYbkZMkfv6kL9/OgAtKES/ZpbqiEKR0eT
	 FiQeTldyST3uTBe4CSXndQlhheTKsCdGJytuvG7g6befgHoF8wlzVWXRFmnDkGmHG3
	 78DY2fwWRpQN4F+OMRobqXnM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E131940E0191;
	Tue,  5 Nov 2024 19:59:25 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:59:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com, Shyam-sundar.S-k@amd.com,
	richard.gong@amd.com, jdelvare@suse.com, linux@roeck-us.net,
	clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
Message-ID: <20241105195924.GIZyp5HLel7Pi2oAo3@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
 <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
 <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>
 <20241105195329.GHZyp3uVMKHAF3BEmV@fat_crate.local>
 <9137b724-d342-4f35-b554-0e56ef37b2d9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9137b724-d342-4f35-b554-0e56ef37b2d9@amd.com>

On Tue, Nov 05, 2024 at 01:56:23PM -0600, Mario Limonciello wrote:
> OK got it.  Considering that I think after this series lands we need to
> re-open the conversation about PCI config space access to userspace;
> particularly on regions that have been marked as exclusions.

I could imagine a patch that goes and requests those regions exclusively if
luserspace has no business poking there. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

