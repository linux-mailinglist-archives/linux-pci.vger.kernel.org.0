Return-Path: <linux-pci+bounces-37478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F553BB58A7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5BCB4E2EDE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B219255F28;
	Thu,  2 Oct 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJgKeatG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AB245023
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444134; cv=none; b=THhUHJRS/DEW26LBaG33iNSwy7OI91MhXQPTgyD4TVWOAzCrYFf8VtRKeEF19D6x6aIu3bsfPgaHjR18LYBecTcCByAUMe6+YpbI+cbzs8rtLI5aVVwhgW0Yay+aEQcBKmjwrh7t86ucCniadSCChvdPG6ANYkkip4EbaoS7Ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444134; c=relaxed/simple;
	bh=dqgAhKd7BQrihK2iidqb02v4x//Kt9aXUe4EEIyggoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxH2fqdosoqCIUrMW4d722nHoIeWu3+lpb8Du4Z3PfTIepl7gyumDw2KYvlhA8SJc3RJKB8YjBtwKj6JfjB2zjDEo6XflDWen3m+Pti03DuM+BF3TcnRlqzKc8uaWh1u0Gqchy9ShJoqYvhIqVnJtBuKzi3EAWesew7/ntwsJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJgKeatG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7833765433cso2185507b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759444132; x=1760048932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mykXEANGb9m/pxHxlW/Bcifojvn2/EYPaGAn9FHin3A=;
        b=fJgKeatGq8oHxjrWaAUmFRY7+hMso6wm0m4a50dLe2uYkgX8M7M1xn2RPUS2DrNkOr
         lAW/YYnnuRm23fzFSzCsARgifmFz9PKu4FVd8KJPlioHH1i5EoHoaUm84xWG8jVNCNUA
         85xuCMuj7+IDpiEjkrvnvIjn4A+on08Za1TZBX4sMH8tcF59xb9swZYTX6u+7qH+RSmz
         corv+AMZcAbopxm4KpUzd4ka1SorQASyPQ/ZLmILR7wjFWUMw5nuYyD2qRE79DtmyASq
         uWCt4aUL2wCscAcgEvn54q44Wp5Wn/8AZjlUs4qNMdpPZ7RShclCwBzzNmYgYOe2g0+G
         dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759444132; x=1760048932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mykXEANGb9m/pxHxlW/Bcifojvn2/EYPaGAn9FHin3A=;
        b=kvlXYy6Ct00PWnPbnlIeoHNJBTBLnzd5Yt8ix4qLdfslCVi/0ju2r+C4uCRtcY5VWA
         hCTueSKSvWDDRU0MVKgW6VxO0/tFes1EtlDTy+1OJMEaTy7vqXj3x3jX3Rz/DB2zncpo
         ud6ne4Me1OYz0eSGD4O7K2e6SnzxMLpUmi8fSB9lpDgJQqYGDtMCAHOaMgO2+H6/voFx
         W0iauq35i3btpduqcwYI7e2Eo6MzaBeynbSVNOkGE1xy3l33pom9/lmeTKG5qYhUWh7z
         ICdXRIQZhW3lYkcjzWBAR/4Ehd7qnvdhKNkFUNRMLG/TeYjM0g7LmbiazX5bhjVo9tbU
         XK/A==
X-Forwarded-Encrypted: i=1; AJvYcCWanQhjooFRI8f7GesouwfFV0SPe+Rxu7x8crh5B0F0bXgNuws246DhQYj4kIP0JgYkNx45Wy15XB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4OYIXCRwgmMUqWb9ajNd1FkwdNMHxsCX9Avpk61UPxhsRhaH
	Fk5AJWY5AO0dYylNgfPKcIwz9wTLB7IcdpDRSP9MN//gqTQjr3iQgYkm
X-Gm-Gg: ASbGnctL2/qUCYoQ3r2Dq3BhEVx3u4XHorPL4rCdxB76tx2XiJhLD1FitBNOfR2b74u
	ra1UOy+7b4C2ZjbaEDOjz0Dt8YzO+Ez+e1mw6WIjI5vXfXsqWOlZCmzc3pAVccuSY4h9FNJjHfe
	C23UPGNE+F9mb9pOnR0z+zpEl3dm0DaKTDZ3Gz00ZZ5PEOwe60iXVELjRyOMNgWhoMa6X0NXD4P
	7R1iyYPSk1edgZ14tU57HZ6AfwZk1RSxIk7AHnSCa9xZd+Hju4wUED59jodHGvlPQ28fNRcUnx/
	yEekxRE6xXE6tQuf/Qk7WVkPJ0WeUFLoH3U2frSfw+FTSf2hO1QKcgwLuFfYgdPYaZhfuEV7tcQ
	pjW+CUeVNtC4qvDp9nQT3DTOdNaJQ5tVwxcVMBpEPUTJT35E+T5IMtUhw
X-Google-Smtp-Source: AGHT+IFsYWU3SRspqkrXIjGDOVkLJ+kQyKDDSNyZCQDEDegtnCI0D74q2dClnukHDD8W6Usm+Tcxow==
X-Received: by 2002:a05:6a00:b8c:b0:77f:4b9b:8c3e with SMTP id d2e1a72fcca58-78c98dfda99mr1179792b3a.22.1759444131826;
        Thu, 02 Oct 2025 15:28:51 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b0204edf0sm3085103b3a.44.2025.10.02.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:28:50 -0700 (PDT)
Date: Fri, 3 Oct 2025 06:28:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, inochiama@gmail.com
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>

On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> 
> I'm running Linus' master (as of 7f7072574).
> 
> I bisected it to the above named commit (but had to back out ba9d484ed3
> (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> cond_[startup|shutdown]_parent()") first for a clean revert.)
> 
> I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> the xe video driver from the EFI FB driver (not sure if this is a symptom or
> partial cause) and I'd see a message akin to "not being able to set up DP
> tunnels, destroying" as the last thing printed before it hangs. (If it's
> important to see those messages I believe I can force a pstore crash to get
> them where they can be saved off, let me know).
> 
> LMK if you need further info,
> 

I think this has been fixed and the patch is merged in the latest
mainline. Can you try
https://lore.kernel.org/all/20250827230943.17829-1-inochiama@gmail.com

Regards,
Inochi

