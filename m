Return-Path: <linux-pci+bounces-16072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E29BD60C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE32839B2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5BA20E02A;
	Tue,  5 Nov 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EC9wjvko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1181CCB35;
	Tue,  5 Nov 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835810; cv=none; b=G2DBsB2PlZLNrDSmjf2PEiRQqCvvxueIqUfps32RTrjgWRqbyOriu6Vf+ST3rAlcNtCtf4oIjsTnV1Z1bRJzS3lURTEw1V4TEV8Bf7hYW1+IH/ceEXX/eTC1NzCtgucavU718WxzaarOLLeqIsTFJOjRy87dtQbZMHEsnvTIzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835810; c=relaxed/simple;
	bh=C17tWZT4NufVfVpkTpTN1izWVEWjrNml0PFkdB9Wq74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7gHMKVrmd4kGxVj5Kwnz4YNofR9gQ+ZUY1uGvmUZEf+8sTgVx8/TPoCsdJjys1kTbggYUGuLLS8diCumhhdMWJc+uF0tMTGv8owtqv6W4KvmJJK4qznWJE+92yqM+HWXXDiR9P4Edtt0a48uSiljMhdby4HoAQKxhiRwOf07Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EC9wjvko; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B95CB40E015F;
	Tue,  5 Nov 2024 19:43:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RxC1ovBftyTc; Tue,  5 Nov 2024 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730835801; bh=J66ZN1hUQRVDe5EuluSIu4mZ9g4AIQctWbK5LGpvEno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EC9wjvkou+PGGXOyz4JP4jHt3MppfhYnrrXb9L/2G94kvdPfQV4gpXpuR0k4xCYkX
	 OC1gSbTbQJ58Nil7ulBUp80H9HFgYL2ux77w/tPqDiOX17F4XXan2lFIUY1w2tNHoc
	 1TWteuXncEBhxc5jwd7NR8VFGzJq8UZDGAUiXQH2213cOQPqHay5YJsqhb5MDZkkAu
	 JqVu4triboHykxmwhmxZwwRGquN/jolcKeuzOXa0+SjV3wr2K1C/0NEyVzP5CK1Rh0
	 IEMiPgKSMMKL7oWTeXrpSQ7En/tQ45rNx6O3vCizwr+9zYFlly7Ds+5RLHs8N3wiuM
	 gwhVIBWFDlySt4Wzyl9z9xpfN6ruZCbEjKyqmMi80oovMIMtl0SsXTdpUQEymYUy1s
	 pPKpJHqJhjL2XLFO/gRurBtgJzmU6Fs1R4sV4TE46W5aq7zJ5eFQooCKGcP8gbU4r/
	 oZvJ9AGgKxzIGB1qNOvNE3/QXTlI9aoDXFQZkXPnxmHeqOPsiKuPswk03MnDzRVg1G
	 AKdZW4Z6RDP2e5Ibb2mG5rLP8vgYHQnbxPBaDuF8T8suKOHczD3ahrUnm0UEHV3WeK
	 ybr1gea6gQ/1dBW2xwAyk48me2Hof7Aq7OTG85mM0GjwtjWzsMop1yF7CfmUdNeBiD
	 pseSXMmijWxJaCA//FEuOZmw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6226640E0028;
	Tue,  5 Nov 2024 19:43:00 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:42:55 +0100
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
Subject: Re: [PATCH 10/16] x86/amd_nb: Move SMN access code to a new amd_smn
 driver
Message-ID: <20241105194255.GGZyp1P4k-TJAPrnho@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-11-yazen.ghannam@amd.com>
 <20241104142958.GVZyjaZtONnLIJAUo7@fat_crate.local>
 <20241105145826.GC916505@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105145826.GC916505@yaz-khff2.amd.com>

On Tue, Nov 05, 2024 at 09:58:26AM -0500, Yazen Ghannam wrote:
> AMD_NB (legacy systems)

That's legacy and won't get anything new.

> and AMD_SMN (Zen-based systems) would both depend on AMD_NODE. The thinking
> is that a user could build a minimal config for either legacy or Zen-based
> systems.

amd_node is three functions.

amd_node_get_func() can go into a header so that both nb.c and node.c can call
it and smn.c and node.c can be a single compilation unit.

> > Just do a single amd_node and that's it. We can always split later, if really
> > needed.
> >
> 
> Okay, will do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

