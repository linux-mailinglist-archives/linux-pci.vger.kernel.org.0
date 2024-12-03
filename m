Return-Path: <linux-pci+bounces-17584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9E9E2917
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 18:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B7A168E3C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372151FA27C;
	Tue,  3 Dec 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="swUKoHjl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF271FA241
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246704; cv=none; b=TMPCxi4edRRG0taG5Hdhm4j+peX6zri6i6y1lQOF2IZWbREqQkm5EE45OBULnn3/GhXeNTJvCzEOt1j18scScVolKrV0gSd5HaPv/Ib8MU4DI2dVbhYx8VklkoxfXDToDocYELYVihCMFvVwlUJXvgIV3stEg1hnoUH0U/WyF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246704; c=relaxed/simple;
	bh=S+DV4vomlAhrWT8NL5FQwF27Xis8NyVEDDUdlUYe3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMtvbSh7Zd9jmvZRRfHwVyFR9wOAl+n/9bAa4DsR3DwPsvFK4uURrlbVyC2gpCOfp3e+0Sh7HY97/+osvFm8gCoC6xLsS2Re527QpBCaLwDKM+ociRPCyfnE5JT2hyCObCL9t/FnHT+DS08nh+nQ8/iTysDxGhv9Wtjzh0VLur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=swUKoHjl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f4325168c8so2976341a12.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 09:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733246701; x=1733851501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDIAp0k+WulLvelBjh0iQOU14uQ0KAvxIWVqAJex2I8=;
        b=swUKoHjlhCq4CTm29QqyIPDNg0hvTkNZIBSeepo30ryOb/aaE8JvRt6mlMpvGP2iQe
         I5TQppJdw0IKoeBmELxHPpmNcdP1S8+ooVgGfnSNgfWrYbsBnXK2oeeIkwaKfR95iQOp
         yX9ob52SML4TIm7biqV8wydOzM08Ez329oTNMTyhQ4/3sF6NQPIgcB6cLNuPC0JhnT2g
         VHSR98Xrya6Rfn0qOlSqghjB+PwFIVoN7uAFg4ZpTZD7Bqh3jsjSnkKWPeeFeIAunrc5
         NylRzO/YT1tVHQq6/zYqj/q3hea73bYEPJuInq7/8kd809xMe2peckF6e7jOqixINfEe
         0sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246701; x=1733851501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDIAp0k+WulLvelBjh0iQOU14uQ0KAvxIWVqAJex2I8=;
        b=amVo8iX76llKjAei8HkDbhe/rLUtwhHvcHkdr4t+vzUbqsZdmDEp6NuUlyfqz6B6wF
         FbdWI/2+bnKLNnJWQmSxgm1AgGogrf53rkym10Zkq2ANNop+0ShWOnF0Iwm5vWokoRxf
         Yd+92qtFhDfdqQXltv4GKJkNH2VB5PUiiWC1TUmU0KZKzq9QCoK9x444ZKf7k1yK8lpq
         YO6UY1nNq7KVT0ldhoQ1V9U5AeiVuqQLgKlY1/msXA2oVGwkBnSoexaSuk//mYnGpPHU
         v9yWO1zpRy/+08IyMRQ9z7Mv832JDrHnrqV4bV8yafavA0fqhZ0ChKeF9/Om8ydmX/pJ
         YhfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV06AdCp/CWSk2FIQJE4w+DBhnkagknhrMqxEPQYaNzWdodOamoIX82V5DygioBRn70a3u/6bNKJPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFZKl/Fe5TzLckfb4zE+ZDE8DYAc9avVSwHS8xtD1KsoWGTe3
	M0jvmJHSNJJrqPbJP0NMCeJQsqdYHr1StaOHCT3W/I5YGID6TEPn+6uTlePaIlU=
X-Gm-Gg: ASbGnctzUVNNUignwtyr1OjO7lTeEkJ0e06l2Lj6dMlQ89dTIjASluT3hKKFz41NJmK
	b6tQNpWXa4yD9bGsU7/E9micKv+FxYL7vYfmHe3t5TgoNqnSnGSTL6VOmJCARmhg7PwYqzHFSwV
	3SVbs9nrZSrXcgyHnl4D6g1TDCqtwVqtK8pGKG8NV540Gg6Fu+6WnJzLuVSKo96XUlNmpFQ9aK2
	uopm4DfFtFta78acNqlhtxOocRsxXSP5wPCn3FffsNId20hAL7sZd/d2Q+i92B70+9P7csY0CFf
	CZ5Zaq6LV0YSj0pWcwLsy8niqWY=
X-Google-Smtp-Source: AGHT+IFVttCytH4uriYlAc5b6vwoVfhSr0LlSgnBO9ywPRQ8142EzJA8hps3tzOfjvW84YqxE5vXHw==
X-Received: by 2002:a05:6a20:c908:b0:1e0:d240:19c with SMTP id adf61e73a8af0-1e16539f323mr5225858637.6.1733246701595;
        Tue, 03 Dec 2024 09:25:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f571sm10707168b3a.58.2024.12.03.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:25:01 -0800 (PST)
Date: Tue, 3 Dec 2024 09:24:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, Aditya Prabhune
 <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, Jonathan Chocron
 <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jean
 Delvare <jdelvare@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>
Subject: Re: [PATCH v3] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241203092456.5dde2476@hermes.local>
In-Reply-To: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
References: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 14:15:28 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> The Vital Product Data (VPD) attribute is not readable by regular
> user without root permissions. Such restriction is not needed at
> all for Mellanox devices, as data presented in that VPD is not
> sensitive and access to the HW is safe and well tested.
> 
> This change changes the permissions of the VPD attribute to be accessible
> for read by all users for Mellanox devices, while write continue to be
> restricted to root only.
> 
> The main use case is to remove need to have root/setuid permissions
> while using monitoring library [1].
> 
> [leonro@vm ~]$ lspci |grep nox
> 00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> 
> Before:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> After:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> 
> [1] https://developer.nvidia.com/management-library-nvml
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v3:
>  * Used | to change file attributes
>  * Remove WARN_ON
> v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
>  * Another implementation to make sure that user is presented with
>    correct permissions without need for driver intervention.
> v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
>  * Changed implementation from open-read-to-everyone to be opt-in
>  * Removed stable and Fixes tags, as it seems like feature now.
> v0:
> https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> ---
>  drivers/pci/vpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a469bcbc0da7..a7aa54203321 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
>  	if (!pdev->vpd.cap)
>  		return 0;
>  
> +	/*
> +	 * Mellanox devices have implementation that allows VPD read by
> +	 * unprivileged users, so just add needed bits to allow read.
> +	 */
> +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> +		return a->attr.mode | 0044;
> +
>  	return a->attr.mode;
>  }
>  

Could this be with other vendor specific quirks instead?

Also, the wording of the comment is awkward. Suggest:
	On Mellanox devices reading VPD is safe for unprivileged users.

