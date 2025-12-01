Return-Path: <linux-pci+bounces-42416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA1C99473
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39F73A3593
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747542853F8;
	Mon,  1 Dec 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="elNI44tm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74044284662
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626404; cv=none; b=ckmqBNF+3WOiYAkzr2rWQ703sgTnv6s7v3p5KK1bZY7s/XAWT87XWMf6UN62wrNn5Gyq7CpQvsFJvNcBc6Q4gZhaIxfH7xTZuBL5LJI6+aEuJY3bHzANrA1vONxG1e285YNEMNWnRd91JoegssMOOufver4+qJ36FSNN+BihTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626404; c=relaxed/simple;
	bh=EmF+IprjzG3tLuBh2OQJ9CDJzfsbRPJayh06bShdbOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+ArQGycXtmsOS3a6sSxiurBWjN1BZTIIoCtsorthfGzQNSyvhAtwupjk+bBbN9cTdElyElkwNV/sFROq76s2phKRGOBFB1DFSgpzNedOb3yX8A1YaFoQYnSdu7Od4ZFZcs3Lvmyk2ltGNEvK5t3gDjviDxf2pC7SuhLat88Vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=elNI44tm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so1379757a12.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764626401; x=1765231201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd2Xjeg+cBgFdoe711EzYQ9lAKpx762O9/OXVugxKik=;
        b=elNI44tmK8cwn8cPqnflwDbhuXLhBgQTI95fEw8YPTTievNCbxL78nceytPVHCBoXu
         f/zb7P6LDyIvTkE5GsPVqE00VBPsasZC/affARu7x5XhgEHfyc3/Ok5IiczZl4xU7j8Y
         lKSc5Z2bfgGUrLn5Y0su4CqTvJKASR/8vf/0A5u8rEVTfsEp1JjiCKCZGsOlY6CgWJbc
         N5y0tMqbvp6NM0PM5rgcbAxDKPwmTLBY+Ex+OcopR8fo3RO0ldqTh9Dhq//P15JFYZns
         c5A26y05spjkwIWUR6LkYgfglu49GhK3KflTfzIJ5eJBoVkKkewiQh4niSfoFOgrXBhk
         FHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626401; x=1765231201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd2Xjeg+cBgFdoe711EzYQ9lAKpx762O9/OXVugxKik=;
        b=tDHYZAThZAp4lW1B+ad4hBVLh0+Z24/hvFiVBTtEZDKXqWA7YshgRC6ughGa59EhV5
         pUTBit3W2H6ttbwvRQl69+x76bMtXFXkrA16NSbXCOVigqkAFxVVZub0GbaTRfIWPITI
         HCyzYg8xezhK2C91dmWvUOQNZmXRjx95eh7iZAI55YjAjaRp5gS5qLcU4ffFOWFQN4wm
         nYWQIky+VtSR9+0IcC2C86MGePqi6e/+nMV/EdGPZl0goCj22VgnXPqWUMILmlQZooow
         AomzgOKLdZt0VcuVXUcrc0ejsFz7bVXcTPjZcaH8dEJ0REC1UlIuwYY71aPTCLHAfzmC
         UPCg==
X-Forwarded-Encrypted: i=1; AJvYcCUYI2UK6kbol7FGvqKLNpOaB1u8FXY8mFc/5uUW658sF4SB9bKQA1q48+ZZbP5L7Nq0Y9z2Nj38jFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihlNN52lMrFKdkIc2+xrEJ6zcZc/lfEN+aW4LJE0r0xkoxGZq
	U3hAurbOBUMA2iUfFGjIjtHwfehTYkrIlE//9KkwmWd2H7UbB+DzBlMl3OyqocBy6oQcpEQaiI/
	FLik64X6uFyx6IFFwpz0OHB8UDN4JghAb7wclFMvj+g==
X-Gm-Gg: ASbGncuyU0yF9w0rBeNsiZnrteEPxzjnj0hxJksrYSPB+p/hsrNPNgMHqg0kMKZvEgQ
	5B2Chfb2LwGSRr6w/ftHHcW99w2w8RehhDpDgJZH8vwkZ5NQ3n0soKX3VtWEnjO7O+GkYuiXCDO
	GwvhBGTfI3GLsiCdxmvpHZqyKoTIhmZ9sft1rPjIErKQKLyLLVty2VJKIlHr6TXNZuwucG4d3jm
	ieEPbbQQijuBiyrbWe5TGjYAKk+MTivAIiZdeaXylJSvY0LTVPBHnfE/gq3nzJeJmW7
X-Google-Smtp-Source: AGHT+IHQL+/4hWY0rHlV+Kk5YxRfg4trCwHexPO/1rdWBeeXSN28+uDHSHI7naTMFoAB6dYSyL64jKpEIEVUoRpWi9M=
X-Received: by 2002:a05:6402:24d4:b0:647:550a:2f3a with SMTP id
 4fb4d7f45d1cf-647550a2f6dmr12197234a12.5.1764626400875; Mon, 01 Dec 2025
 14:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 1 Dec 2025 16:59:23 -0500
X-Gm-Features: AWmQ_bl8RsO0zdF_7xZRgECm2eQrsXzs_Xyv_QYSzkI4QxVEXepZhcn_KtdIPTw
Message-ID: <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 2:36=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> This series adds the base support to preserve a VFIO device file across
> a Live Update. "Base support" means that this allows userspace to
> safetly preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
> and retrieve a preserved VFIO device file with
> LIVEUPDATE_SESSION_RETRIEVE_FD, but the device itself is not preserved
> in a fully running state across Live Update.
>
> This series unblocks 2 parallel but related streams of work:
>
>  - iommufd preservation across Live Update. This work spans iommufd,
>    the IOMMU subsystem, and IOMMU drivers [1]
>
>  - Preservation of VFIO device state across Live Update (config space,
>    BAR addresses, power state, SR-IOV state, etc.). This work spans both
>    VFIO and the core PCI subsystem.
>
> While we need all of the above to fully preserve a VFIO device across a
> Live Update without disrupting the workload on the device, this series
> aims to be functional and safe enough to merge as the first incremental
> step toward that goal.
>
> Areas for Discussion
> --------------------
>
> BDF Stability across Live Update
>
>   The PCI support for tracking preserved devices across a Live Update to
>   prevent auto-probing relies on PCI segment numbers and BDFs remaining
>   stable. For now I have disallowed VFs, as the BDFs assigned to VFs can
>   vary depending on how the kernel chooses to allocate bus numbers. For
>   non-VFs I am wondering if there is any more needed to ensure BDF
>   stability across Live Update.
>
>   While we would like to support many different systems and
>   configurations in due time (including preserving VFs), I'd like to
>   keep this first serses constrained to simple use-cases.
>
> FLB Locking
>
>   I don't see a way to properly synchronize pci_flb_finish() with
>   pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex is
>   dropped by liveupdate_flb_get_incoming() when it returns the pointer
>   to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
>   could result in a deadlock due to reversing the lock ordering.

I will re-introduce _lock/_unlock API to solve this issue.

>
> FLB Retrieving
>
>   The first patch of this series includes a fix to prevent an FLB from
>   being retrieved again it is finished. I am wondering if this is the
>   right approach or if subsystems are expected to stop calling
>   liveupdate_flb_get_incoming() after an FLB is finished.

Thanks, I will include this fix in the next version of FLB.

