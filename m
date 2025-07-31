Return-Path: <linux-pci+bounces-33247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33CDB173A2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C048CA83905
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505A1A841A;
	Thu, 31 Jul 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hYYEbT29"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA3156228
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974098; cv=none; b=VjgU5Q+pnVAAxyUkP9u07cNVyGM8BqnNDiKUCjW2+DAEjtQiojn8DAWsd2L4MPQs2UMLDmOAb7Z/KWPO+hg41bnSvaDQCxCl8q0z8i4efAte5n3nDNVwa4ubQ5MSj+WqrBXW1p7aZufQciBA9gG0GiDIEQB5rId3v0H6ikk5GZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974098; c=relaxed/simple;
	bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSpQKDLPAF14GJJ+6t2/GSDxwEpH/Ds+UPooW6J85KWu2a/vM52MghkgmE0MkiGQEgW71WqFvd3cp4nFqQbyswFeN/2hlsjeP6J48NguVamnqMUS24amzEF2aSrea634Wh3ItT7Uaqf0XdqKJu51zsXB/MPuTvlsh3vap1mCPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hYYEbT29; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70744318bb3so9321446d6.3
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753974094; x=1754578894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
        b=hYYEbT29c5SRmAjQpFlscVTc85ax69ZIeuGrjNxAnobHM1xx3S6HPpDlQiLNDGTOjl
         NNuaqlbow7y7+pcU9hCc+uNzt/13Sa8jJF0Bh2T1CV1jYceOhn6FjJ4bG4L8BkzzUAfc
         ZVjBdeTi6PqPVy8d7sXdRUtsjIlq2Tw9bC8ictmvKNT8PLHhp0j7E4XmZGIOba+c9hWm
         yh8BtTZRxy55+8J3gOOL0ijaP1ylEtCZ7kqVp91A0d391NGocgWd0NQsEsRrtWlwnetR
         7lqeQvH5uW+aH8FCA/ukEz1jgKzMvk6BO7KYKCZkmFHrgYVrEDZ8fs7JEg88f58IQGbP
         yYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753974094; x=1754578894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
        b=OEvSR7UDR5XrZe0l6Ga6claOJC/CrTLumYYF8P+k77Q5pL3Wz4n+FoC7v0BsoIvDN/
         Y7icb99PyyGhBYqT4f7otRuh9feLMCwDYS4CEHaEwF+dIxUa5pPbyaoXIJMtXyYIFIcY
         35G+WEzZ5ReX9tPS1YM9d+v+/l7aXNrMsTI98KCL8fQEGxBGEQynASkFwy43NmqxOTNk
         D32yDFpA2q+7fJDL09TovWUVlNsnRqhJ1LCVjr4Ran9j8QRSyqVxzYSahQ7MjaWsjCz0
         3mHX1fFcdgKS5GDyAWpcRCbZXyN5k6Slu+JVK/u/Y6GtWGSoOfMmH12TMH+N2/95grAy
         lWjg==
X-Forwarded-Encrypted: i=1; AJvYcCVOCuqScBhiJPNh2cF4iaWqtvZ4kCTCizdOnnpM27oL5BEwR6e7WvMsCczZRWrZk8acIjdB1hbjwR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuLxuIxUVLyeYXiIF62D7xGSBWEzCBcWnLtW7CPwFRqa+kSSk
	ncdGLMBwaNtmu+0nt/FBm5KPYO4LLg1/ONd/mSObDyjQjf7YQ1Ws8dcxH+ZeG+XZRuo=
X-Gm-Gg: ASbGncsdylDqvoPaBeQQjt8nitveJ7CFNpeKkTgq6TfNwdcXZcPjNC2t4CT7lXZ2Qzs
	Ko+qplAakNo4Pand/oZF5Hu0h9tRmvl4NckJegFx/xvaZobhIq7ybEDQ297kwwMILFTkT4ryEh6
	6mZMbCwugMcbwPHR1Ji5X4XpIvMJruBJfDITcMxzxdhU7Sd4IcbbYe7+HrrTEVsrEL7aJmKPAuJ
	9DopuxvK9vEwsjJzFiQyR1Bea+HuAtYiDOZDW/jgAwR7jS+npBPlUsmMpALNSwBMhREHJaQRqiZ
	Aj24bfIjpFnuFo8rCkz73CXqkN9w7FAdLqmSA9XI1RjLx2g7WkZcAPVOR2So8YWH8IOiVhjcOZj
	d/L+9+R/VMOGHsca61Ohe0LuNYPoU15aPoYhXiFBsXWfAXjYRQzOKrbF38duFaJr+KHCy
X-Google-Smtp-Source: AGHT+IF3QfXy1mTLzNpz2l3j8n+LbRT0h59stfgYKkxbxlcga8yiKajrseiPdkpwZAVYyKpNGhDCSQ==
X-Received: by 2002:a05:6214:2021:b0:707:5633:d6f5 with SMTP id 6a1803df08f44-7076725cab3mr110105336d6.49.1753974094185;
        Thu, 31 Jul 2025 08:01:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea880csm8151756d6.92.2025.07.31.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:01:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhUmi-00000000pgD-2vq5;
	Thu, 31 Jul 2025 12:01:32 -0300
Date: Thu, 31 Jul 2025 12:01:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Message-ID: <20250731150132.GV26511@ziepe.ca>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
 <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>

On Tue, Jul 29, 2025 at 06:51:27PM -0700, Chris Li wrote:

> They follow a pattern that the original kernel needs to write to the
> device and change the device state. The liveupdate device needs to
> maintain the previous state not changed, therefore needs to prevent
> such write initialization in liveupdate case.

No, I fundamentally reject this position and your testing methodology.

The new kernel *should* be writing to config space and it *should* be
doing things like clearing and gaining control over MSI. It is fully
wrong to be blocking it like you are doing just to satify some
incorrect qemu based test checking for no config access.

Only some config accesse are bad. Each and every "bad" one needs to be
clearly explained *why* it is bad and only then mitigated.

Most mitigation are far harder than just if'ing around the config
write. My ATS/PASID/etc example for instance.

Jason

