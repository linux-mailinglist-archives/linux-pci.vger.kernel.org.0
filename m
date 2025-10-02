Return-Path: <linux-pci+bounces-37465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2ABB4F1F
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D578819E2936
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056427A924;
	Thu,  2 Oct 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wANDu37B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AA279DC4
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431256; cv=none; b=TkL9oCAelPBj7D7jLQmVLp/oq1cG4l5J0Y9F6P1ZwKpfRc9eJrXRzfxUyy2mNlWX+VarEZs+1mFBVt16gNzeMvijBdFK74Khr13VoheGNoPV0Ok1hsjrA+KBfk/eO5RYvWB+8+lZhP2OWqRHHWq3F/nTU3lHbJL2LjA20W+cykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431256; c=relaxed/simple;
	bh=PAV7dODpUq5SOsBUKbBPpgKo2FeIhFOGW1RmqfttTJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtqQZ5G44wgxgntmmaGHufs7UgjGpozXk0NicfhLLSq6oNHHajvyDreZJgfGAW+CoGsJO6ebJutC2Lfye0o16SZDu1SNrBk5vBCrpVm1kx4mgzzzCWjUOgaK2r/djVbRF6Ftm/KQy24WurvsHm5Vc9icwmpg5aoPj8qkhq93drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wANDu37B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so29348505ad.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759431254; x=1760036054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i0ZeG/ZsrWkusTKjLcfAPOs9+zmmUF2Y1kjBg9Y/N8o=;
        b=wANDu37B6bZkBpvUKfs2E5S7bM1oX9Fx20SWNvXxzeWUOZaH1jWTmiI2ZbXVjz8opF
         s3MuJWsi1CMI7YQ4lkr7I2JXTrprhexDneQ5AhNyDPhA//8MmBZ3+L4GNn1IZ22Jb27u
         ENgRgtGOTBft3BoHNbeUBu3dQPQ3V77g4pZvG4YeZlQTlayXbBaPG36XbGjQSvHgdWb2
         ZyjRnrk4JojsbHZFChDVzYXe2nxQo5PBPmDFxyG5to8N5WlZdRVPJMrvo7tzb60X+T4g
         2td+Ee8uKMK+rNVD2bOGnRB0FMpISt2R4y6XBIle8CfFO8eot5iv82UzL2AHmD72y3d/
         jb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431254; x=1760036054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0ZeG/ZsrWkusTKjLcfAPOs9+zmmUF2Y1kjBg9Y/N8o=;
        b=T4JcRRCkIxMVSfvLuPOfe40KjYSVK69Xg/3IyB2SJbV8ceW2nFPVmlpKqCb91b6sEK
         f49QyXH/EEMgdaXXGj1y6xYNNEMCYhSjhWFGJ6VSLPuKeb1vw+Zgzp5rBGgYEWk2J2fu
         6uro0I1N6K/UcgNKUe94o5eLboJI94mwD8iJiJdpCUPq/zaFDASYo3DiY6+j/0UZzvGc
         l4Edb9/7uaXvsXqnvsZFQ+foXQflFloDRUZzFc3/lNXoX2EEKunX9HQpPOBtdUH8Fw3n
         Oo0sgAkBbPGrjQF39Qyry5KsfnFbT0bwZJxdZLqqubFKtUlWXU0TqUury8KPpCfFANVe
         Q/LA==
X-Forwarded-Encrypted: i=1; AJvYcCVmexXMbo3U+p/QXlFs1IcNYRfALn0qBcciiuKZ2XfCGtUr9KmNDevTpdSSCiQct5MTaAHT5N/Tqzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI50kmmcmho56JN2Vn4AxcjL/StHzX0bmC8BmIDPPXh27g8630
	7pd2auArcmqP9fPjfBm+m6nz4hozY0OLBiIl4X7uMJ7rSM2zh7aW94UpdQdJVmvAXA==
X-Gm-Gg: ASbGncuNyeovGNxjn+WoCjOazkvVLFqcKJvPoK8kL5k6aqk9sdM2wNvUXHuf++3tIam
	jdVO99Q1Lw0xrLbrhv6SO16T80xVULTwUmZb+zKQGkSGQFSRMBTMBVN9DJozNwQ8iyExS/m80h8
	RzJZfYvzA+3DjD79yv3VdW0mDibXE27MzbOxclk1g3BrDEealJ9yNBKCJZNP3Ce+jKPeUDhaogL
	G6afiLR5+K+8SBhm/ir/xiZLmpR4ikmkWe3pXj3A1UayzmiJ4+vZTKwu+wTe/ZFYhv9n3gRADQ6
	gWmQpwUwrAmVor+acEJOOdJKzoSROsbsDNXZQZzMuNr3n/IM7eAt8YVz92hrWHDGZcTCXW+LMr+
	42MHQHwQzeX2KkACpg7vRLHp74XbUtGcH1UFIhTLupmDYFoQArEEENq8aCdF3HmA4ItSFqp/nNH
	FTSvwCVz70gYVrxSS5VDLCuEo=
X-Google-Smtp-Source: AGHT+IFcEU4MoidaXq4fyYy6sgN3wbN2wiM+4VOq94uwaXmvAuNHKZZgFAMksU+bbPyUW4gKLeNTLQ==
X-Received: by 2002:a17:902:f24c:b0:271:bd13:7e73 with SMTP id d9443c01a7336-28e8d0a1ac9mr32071205ad.19.1759431254139;
        Thu, 02 Oct 2025 11:54:14 -0700 (PDT)
Received: from google.com (96.75.168.34.bc.googleusercontent.com. [34.168.75.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cdc7b41sm3980630a91.3.2025.10.02.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:54:13 -0700 (PDT)
Date: Thu, 2 Oct 2025 18:54:08 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <aN7KUNGoHrFHzagu@google.com>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930163837.GQ2695987@ziepe.ca>

On 2025-09-30 01:38 PM, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 07:11:06PM -0700, Chris Li wrote:
> > On Mon, Sep 29, 2025 at 10:48 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > > > After the list of preserved devices is constructed, the PCI subsystem can
> > > > now forward the liveupdate request to the driver.
> > >
> > > This also seems completely backwards for how iommufd should be
> > > working. It doesn't want callbacks triggered on prepare, it wants to
> > > drive everything from its own ioctl.
> > 
> > This series is about basic PCI device support, not IOMMUFD.
> > 
> > > Let's just do one thing at a time please and make this series about
> > > iommufd to match the other luo series for iommufd.
> > 
> > I am confused by you.
> > 
> > > non-iommufd cases can be proposed in their own series.
> > 
> > This is that non-iommufd series.
> 
> Then don't do generic devices until we get iommufd done and you have a
> meaningful in-tree driver to consume what you are adding.

I agree with Jason. I don't think we can reasonably make the argument
that we need this series until we have actualy use-cases for it.

I think we should focus on vfio-pci device preservation next, and use
that to incrementally drive whatever changes are necessary to the PCI
and generic device layer bit by bit.

For example, once we a basic vfio-pci device preservation working, we
can start thinking about how to handle when that device is a VF, and we
have to start also preserving the SR-IOV state on the PF and get the PF
driver involved in the process. At that point we can discuss how to
solve that specific problem. Maybe the solution will look something like
this series, maybe it will look like something else. There is open
design space.

Without approaching it this way, I don't see how we can't reasonably
argue that anything in this series is necessary. And I suspect some
parts of this series truly are unnecessary, at least in the short term.
In our internal implementation, the only dependent device that truly
needed to participate is the PF driver when a VF is preserved.
Everything else (e.g. pcieport callbacks) have just been no-ops.

