Return-Path: <linux-pci+bounces-16071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8E9BD5C6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5831F23831
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8D1EBA13;
	Tue,  5 Nov 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZJ17AfwW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AF17BEB7;
	Tue,  5 Nov 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834520; cv=none; b=TwEiXNiXADuA5tDl4CGZXoUzhBrGpl3A7k/kBN5HRN/XS3HRG908tdnnTIGy8l9bU+O28QnAkbWCyqGiSaQLDobYBvWH635KGDkItTDGTv05jhSwkzGIgaVdW4H9IrmeIJx/uDtr+6ktScMRlinoOdc4BfgzoTbsDLsZugJB4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834520; c=relaxed/simple;
	bh=rjSmDAqas44E73Jc89rJS4/Gi+iOC33uC+9A+dpOFLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnQGClNHCyNKYHMIqjyEOU3//nHCWb9+PZUERkvNBbYAqOIPl8ER0u86PM2hT30srqyUvyg7PGUh2PNGQBfoSfd+4WrhDe1NZXM0xZ7G56cZMv30wEA4pzeQYN4sm1YZFTkGb31b9PAoPMsk86hu+H/5ynJvcOYwY474mnx0r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZJ17AfwW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5B77640E0191;
	Tue,  5 Nov 2024 19:21:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5ILfy9COutIC; Tue,  5 Nov 2024 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730834511; bh=ioOwYX7zIxRjEwWRkmoYKIBtPhnM5jWoFFIAP6pf7+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJ17AfwWZkQt6i/32mOI1xzrqkSltK/Z9h/F7OPbMbfJxM50Y1MtQ6OEymCAJDMWj
	 snOjxzT7GmAt44c47R8JQJFv9FkeoXbRCOBS9lR7JTAmrmP/dQAS/Ok7eIlNB0HTy5
	 BVECZL5upaAJcc+uNuNLh/Yyt2j7+a4QLVXZVe/cVSIh79JnoD+QwQ7wOA9xhkD08x
	 ztJeQVenWIeST16Ja55l5qo6QWhDEVJcC+t1sAsV+jY4aLWQM8Ey44nwRIE+fH9UGR
	 OD8BzfK/tf7A+iOmEnNRiX+CCUyDeZ1t4vLxZZFfBCPXJyRdDQ9IdlOl0CV659yxi2
	 LD2k6Iyx6/enHx6usys64T3ZI1Ug/Vg0zVumbVrShy01p8inaMyW5o+kAzdevSrFtX
	 39mLiE95vrpVjcpgMfQoE6VufwsJGVgyMkeH+1gvYQQ6XEyuw17QU+Mzv+jJuUY2fq
	 f/+vaOl0ot5jd7UvxvaMuL3tyfOLebB9vaGdmXuTkXTuD2ZSbHxG5ON2aV6k5pG1lA
	 /hsSJIcC9QrMWr7kSNNNJc04lOy5WGJzHrjhFT+RcGi2L+HdSOqgRT3nBnDV8BT+HE
	 9Mhh2C82SmkuJ00n/dgsHk3HDAaaF3tudvsVchLpHgufr4KX8j6BaOHP1/fmi4rD7W
	 4uxJsgwH2ndzWf2PikfHehmc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C33D540E0028;
	Tue,  5 Nov 2024 19:21:29 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:21:24 +0100
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
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
Message-ID: <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-17-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:50PM +0000, Yazen Ghannam wrote:
> +static ssize_t smn_value_write(struct file *file, const char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = kstrtouint_from_user(userbuf, count, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);

That looks like a TAINT_CPU_OUT_OF_SPEC to me.

> +	ret = amd_smn_write(debug_node, debug_address, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
> +
>  static int amd_cache_roots(void)
>  {
>  	u16 node, num_nodes = amd_num_nodes();
> @@ -180,6 +257,12 @@ static int __init amd_smn_init(void)
>  	if (err)
>  		return err;
>  
> +	debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
> +
> +	debugfs_create_file("node",	0600, debugfs_dir, NULL, &smn_node_fops);
> +	debugfs_create_file("address",	0600, debugfs_dir, NULL, &smn_address_fops);
> +	debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);

Can we pls stick this behind a module param which is off by default? I don't
want that crap exposed even in debugfs, by default.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

