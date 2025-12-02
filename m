Return-Path: <linux-pci+bounces-42530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E6AC9D070
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE52B4E3FF7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C602F83AA;
	Tue,  2 Dec 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4tuE5iw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218262F6931
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710170; cv=none; b=erobRCQ7IKmys6vNjapv1Wqt3mbT1MzQIFzWFwz8UL1yZ6igL4WxjwkNiRzvucFEyh7uzKy/Uzg1I7tuggrKMYykTgPx9RTngjFxYnD7UuYeUWIQ23/Ph49Ru/6OhBm0gwlh5n5rB4naqTSVRWayoe5zobWRqqsNpp9QUDaGHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710170; c=relaxed/simple;
	bh=psZAockS1smX2jz734Lq+oNYVMo3hSN9xQqCt2oRORk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeMDxqXSqsatUckTZv4PU/zUZVRZgkV08v6zc7126/1s4iB8cPBjcXVHhFhu4jsfhlQbm4MiUp03Kb+aMNz5o/D+vhGjp8m9GYu0LC/kQJ/hbPxgLhCdWwrm5pDeRFYEqteQN+cwtgqNTO10xFgGlaI9IYfiN2c7m3Vc+otpJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4tuE5iw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340ba29d518so3993465a91.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764710168; x=1765314968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6k+A4j7YgFCIkzTerT25SkFiFrWoSonSfbJHItUpuU=;
        b=K4tuE5iw/UPhRNBsNF1cx0XDlFMbr/Li5JZl4zvKXMRk2d4HRVc4nRpHH+vwrDCZBU
         3qtqNzOfucQtVmm2rGEwYmuZoTflNZgwoO+zd8ugFd7RtPfYjpyDoeZq1ll15LY4J/Ov
         9Z4uIEH+W+8ZEHGJNkB2pyny3DnlTg9c7N/12dyhgLJoVkvX80OYjJ/zkeOg6htJ88gV
         ovjB/Kf7rMYuIS73X8u8Cffw3cM3L52uVs+icGp3Hs4jzlst5cgdZLtK9GJIizY2VumI
         tEAdOuH4hBECZdRoU2UJTxI7F5KPWl/grf5Ax2UZ97mZYoQQnbsgBf7yW34WYi4CZCh4
         dVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710168; x=1765314968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6k+A4j7YgFCIkzTerT25SkFiFrWoSonSfbJHItUpuU=;
        b=JZbutKOZbnx7PXYOZ1qSOGPlzFWOU8BGlzyT1sXSvu7xlprGBYSfz/fmy78kzHPwJv
         +d8J3OgiKQOSRYiU3qllAbqwj55NoW/Pi7VfmhuLfmuqosjo/AemHW+90E/mIs9LOv8t
         sj0Rso8O7ZrSRuEkBgdOE+Nrun2BgmFZvbrXuxHuSldEswOFQfCXCe9Pz8gvtsWFbEk9
         Q+43ZiAyMQgnWZC2vc0PMV7Ip/+of5b2kPEfWq+VtYmBm2dieP2D4sBq4soSG8B4Bmz2
         mdlHejng4ALsS8rmzdVySPgNCDsMRMrqMXwcZXWrLs+3xEA1tnHsj2mCLdmgYsc6X+Tz
         lJqA==
X-Forwarded-Encrypted: i=1; AJvYcCUIkWmIHqR/w1iQqWxtvsAIYwGVAIY2YUohMbGyE0ZiKARKTP0Ucw8ctPqoi9p3APGsn7ItnZSunLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TtlXghrgVaDorW39nyA0zpoGG3FzD6mWLwM/zDOyrsM0kgnk
	jEac1DkIJwBIF2y0jr/RlFIAwYILK0HFQNKU7k5a/ZL3HIR/QIxyulrWVp19TM6B5w==
X-Gm-Gg: ASbGnctG+Dd8qnT4FR5oQHrw1b6O/PBqC0pIzNv9sj+oDCSdDHV7+zTkCHMd+QuUeaK
	SO75959iBgLI2KKp9TbcVSh7KtswX/BM/7OuHDjWxywUjMntef3xhWxWy5eo44eriAl5zciMTYS
	cspuwIbz6++iFeEdpbiTKc/4cRaERAOvJkuUtOFEgGAZ/pzlGu7s+8vp4D4oqjsDrCuKlgko58e
	tOLrJBzBQIGmR4fiTlh8ALDcQNb0kb0AvIJkuSXewFJniCKLOLcEG0GMoJUqyj8DxTfaNKku0R/
	tnW95sp854nROwml4A/Gf4N4lDvbLpx1+RAkb+XcCVRFthfq5TtieTCaUPppyhgxjieHuvHy5k8
	GyKIgamL88w9ycS7j/iVbtVHxnD0mxgqUPaXlBB3Xzx9vp6eIOYXhhQYpODQ+6ZDXEh6OLZNzQl
	cZFqUJLit2Mrc9BbnO5Ven0Khg9RQPrjqXCCnj1VPsoUiCT1g=
X-Google-Smtp-Source: AGHT+IFJXXKi/z9g/exKb7UhaYzAGIOAf3+2xvy64dR1yHz7NR+ujWfrh1Xuyci/C1t+g660+I6Fuw==
X-Received: by 2002:a17:90b:4d91:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-349125ff915mr64801a91.10.1764710168053;
        Tue, 02 Dec 2025 13:16:08 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb434e8esm15829923a12.4.2025.12.02.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:16:06 -0800 (PST)
Date: Tue, 2 Dec 2025 21:16:02 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 03/21] PCI: Require driver_override for incoming Live
 Update preserved devices
Message-ID: <aS9XEm96ifPd_ier@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193608.2678510-4-dmatlack@google.com>

On 2025-11-26 07:35 PM, David Matlack wrote:
> Require driver_override to be set to bind an incoming Live Update
> preserved device to a driver. Auto-probing could lead to the device
> being bound to a different driver than what was bound to the device
> prior to Live Update.
> 
> Delegate binding preserved devices to the right driver to userspace by
> requiring driver_override to be set on the device.
> 
> This restriction is relaxed once a driver calls
> pci_liveupdate_incoming_finish().
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

After some offline discussion with Jason and Pasha, I will drop this
patch from the next version to avoid hard-coding a policy in the kernel.

Instead, for the time being, it will be the user's responsibility to
only preserve devices that do not have any built-in drivers that will
bind to the device during boot following a Live Update.

