Return-Path: <linux-pci+bounces-42505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCDC9C3C3
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64A1D348979
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006B2BD030;
	Tue,  2 Dec 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzvHQtrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AC29ACD1
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693426; cv=none; b=GP4M7S5YjsHOWkXesDfb7ijLYPsw0IaZgPzW3dJsy7xF+DtMCliJQ1ZmGvtZbyWgWUxTMn+oZ+LQaWvH2bW59uDMBlPM2HIY5CE79Xuft8uQJnkfBB6bUrD0XZj8dKP9s72ZZR3LgZfSUTz9c11vfOT3TAsT/3a2ZpEA8/v2w/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693426; c=relaxed/simple;
	bh=137moXo8s/LmN37PzrzHz3oClS2z0BOI660OGTmkq9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtGErtb26hHDw0V5HqIpcf5A7D5WulTh1B5ZCv/O1nZzGQfyXLz3I266idvKTnqnkJFGVQrxk9ZTy2mRuSPBNbP7F7IXuQX0OivSyzQ+85skJvs6/KxMme9XD9KAaglKG+EKGRGuCvzxDN9Q6/Jo3bqwhtbpVoeVlbHf+/xzK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzvHQtrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EAAC16AAE
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764693425;
	bh=137moXo8s/LmN37PzrzHz3oClS2z0BOI660OGTmkq9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzvHQtrIyyQfQV/Iz3CjgyT9gqMZbEwDW/p2zvN92TmwugOpF/UP/oCUx+BIz0x8M
	 AcKdqicqIDA+6DF9PkwOZq/79oBW9osyNJg74lj6W8XtHToYS1yk9EYLwP6hmEvoz9
	 qIc99FiYIcLiMj7Yp0ONQICl9DJ3JUm0JrdVAe9QxMIna4rtPNU2S1800YJcoo1z83
	 EilHSPemzCQOgxNj1wvUgzdin8qQIZ6dLqQCd9U5BSokzKTP9I2+f78+GzM5HRI9Ke
	 /bt1PydAxkPqKhSmR212BcdFhdFVU2pwzbHCuuumYp1gqJD4PyvLMpKBm2b2Qs8mdM
	 GOtmtlm8SjisQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787e7aa1631so71013367b3.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 08:37:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXO/d7OZy/koPdBtgfmfu6qDwJjB5LOlfAo/GCg5L7zASxcKUjVsCfqmD+jMoK1Pcoe6o1NIMiTxFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+k6ixg/MPx7pYzHnbKCrNhJiNRNjyn3Swv4jRdUAermvqADV
	TtP1Ha0sSCtuduHPB0tUtmF/pbphqp2TXK546+rVDqdzX6FiFVDMOy4Rpp2uCWMq3HYYhMvpctn
	9ejB6FMKDXX9KvB7dhhcbupo8tYNxYOUCenUPFU7RcA==
X-Google-Smtp-Source: AGHT+IGBjNPjFljsTlPxo4WA2SJdBNwTPxDeLBltGjpOxyikR+XugUL9DT8xEhxT2+IgiyRotcSK36cErNv3/7fdio8=
X-Received: by 2002:a05:690e:1349:b0:63c:f5a6:f308 with SMTP id
 956f58d0204a3-6442f1af559mr2807207d50.31.1764693424538; Tue, 02 Dec 2025
 08:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de> <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com> <aS3kUwlVV_WGT66w@google.com>
 <aS6FJz0725VRLF00@wunner.de> <20251202145925.GC1075897@nvidia.com>
In-Reply-To: <20251202145925.GC1075897@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Dec 2025 20:36:53 +0400
X-Gmail-Original-Message-ID: <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>
X-Gm-Features: AWmQ_bnbbe-i2loCjPCRmFKkZMkrwcLJ0pPNoTuT2OJK0ymAFbAsS-FLNs74Umc
Message-ID: <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

Sorry I am late to the party.

On Tue, Dec 2, 2025 at 6:59=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Dec 02, 2025 at 07:20:23AM +0100, Lukas Wunner wrote:
>
> > But you do gain a bit of reliability if you don't assume bus numbers
> > to stay the same and instead use the "path from root" approach to
> > identify devices.
>
> Again, that's not reliability it is subtle bugs. The device is active
> during KHO, you CAN NOT do any resource reassignment, not bus numbers,
> not mmio. It must be fully disabled.

I agree with Jason. The bus number is used in the low level hardware
to do the DMA transfer. The bus number can not change for a device
during livedupate with pending DMA transfer. The BDF MUST remain the
same as the liveupdate with DMA transfer requirement. Given the BDF
remains the same. Using the path from root doesn't buy you more
protections. It just makes the patch more complicated but achieves the
same thing. That is why I chose the BDF approach for the PCI
liveupdate subsystem in the first place. To keep it simple.

Jason, please correct me if I am wrong. My understanding is that not
only the device that is actively doing the DMA requires the bus number
to stay the same, I think all the parent bridge, all the way to the
root PCI host bridge, bus number must remain the same. After all, the
DMA will need to route through the parent bridges.

Another point is that, on the same machine it can have multiple PCI
host bridges. Each PCI host bridge bus number is acquired from the
ACPI table walk. I am not aware of any way to get the slot number of
the PCI host bridge. Lukas, do you know how to get the PCI host bridge
slot number to form a path?

Chris

