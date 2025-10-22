Return-Path: <linux-pci+bounces-39055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB4BFDB64
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3701897CD8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387A2D9487;
	Wed, 22 Oct 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z4S7iqqE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761F2D5938
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155516; cv=none; b=GwF8ciuUMyBi8zqmq4CKQ717lvBNS0HIkAHxyz++XtgYDZgut2ElIPMzahhtZKPUJGM06L3EbzZWU0mZ3ovJ9NCYFeVzQ9AEE395FZR2wQt12gSJvJA19mV5sc9krxuWKP4f4yGBUvG8vTwHhbyWhrNQziF25CJFIJ8Z7j9V3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155516; c=relaxed/simple;
	bh=4HaaXDR/LHQu198ef3JyPuMYkr9oqG+YsjWt7cbNCw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WndEWxNSOXFKAiFwVcNymL6Augqw+P0VxyuAoN5z/LPSbvQEyyTmeCiHwF1BZmXRRStL96W5VN99DL5teDlVjEiU7H2Z8BVWE7aF6B0f491nYFGAOueoxcjDmXk8rTQj7D9hkFys7aa8j9GL65nScYJL+HQlZN8bLVdZzPBQQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z4S7iqqE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88f86727622so1000810585a.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761155513; x=1761760313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KHWh/jKrHs1DdtC5lcScutvVgEeB0TcBCM9LGz47JlA=;
        b=Z4S7iqqEOPkzQCY36TDaakKaNk/RODGTCUJka+yI2Flr6m9fnlH+eoN5jSUVEcYNK8
         75SUVfLwNl9lnpU1EyHKCH4a/E2O8IKC0nwxtvqsSriqAvG+jTUdL7tj9jbKYekuigsl
         /SEIO40lx3K/hbib13S0rBefcIE+A9pA4CL2phRX3hw9QoHN/hghEA6n86VPGLB80Orm
         sSfQjph/VG7FHAydLBiLilfsD7XY0EqeaWs0wM7/Z5BV+YrWg4ZtuavdSk5NytsDxEjp
         o+R+H87sHKo6/FTc3ancsg0q9fZDFA2M7Rb0TzkxwYIoEVb/4D1011lbElSS479pLAcO
         gWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155513; x=1761760313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHWh/jKrHs1DdtC5lcScutvVgEeB0TcBCM9LGz47JlA=;
        b=fy/qqj0D6zLNIw1ufRUDL/b1clwn9E9d5hK8jEvlBFY2gGM31MEp83p1spyZ+9yXv4
         XxJVRgM9P8AU77FER1swG1WBwzjEvBfyHtFNnBM0itIcWVdFOUOliZg9Y6qg4Ky956QU
         9c0U0Okw4pL6OkFL/TU/wCu+g/QIvZcbHLhI/UNHzZbbj0XVjy2uqpqTrGShAt2kg0Tw
         w1ElYuz3C8s++p+A4YZluTCv5Ec0bdAqBbQ9Sx0xSCN4akPX09R/3vF2ACK801GjHNjY
         9U8KnrHoicS5piCtrc0wIJJUlnNmj1HwqQNUSBlKmEzsuM4mieTU3Fr7xFw/rSDfRY3M
         tmVg==
X-Forwarded-Encrypted: i=1; AJvYcCUjW3RVKLoT7dBrXd4uH5rjDGqC/MMjakAqv0woBcFXxaWT0zQ+pFTKjLkjGKl3V3h46GTDE3tEzdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFArnkv5E0LbzvyGAF7Kt91NyweGUNzhjD9rRrtig7WFEAmp5X
	YIGbc7oBKoSdrDuYtASl/HEhx9Ff9nDPK72i8+LxPtqQCIk3xKeq2A+RAQzGHXgppXo=
X-Gm-Gg: ASbGncv5d9cbZULE79OaB2YAPSBc+/fu0/3NmGCtC/4jdUStCbxGHQmpTFCfFMBUG2T
	x8nZJJ78+MTZ20CIIqQydJoMt/WvHUPVhi1SSYvCcNKPqpcmHy8vh0j+dGl9w7MS/lktg8DJB8G
	LgDGdm2lKqZTBtbXFcPCAgwElF86QSIg3TH+gzWiqs3TSz502AwOtHqBoldIvKeXCqSua6gcik1
	VU0DFkEgtedhdBOSV3rLoJC+BVQsiEPWePmtV956wJHCzIgEjrgjDX5ROGJPcllp+zJhEltr3wC
	Jxta0BAqowFAlDma/C3Jbv1R68CRzd89EtNnHvBozGfWxel3YcmeC0Lji2eBGvJoZSxTg/pMvCR
	zKYxSbPeXwvWPnu9ijsRnBc82t+mY2vXuA5ik0Spu/tO1dRNBPA9AVruAm2GWPRCxCENxgKd+aR
	dPjSEd+tjTAjbi1xDGrSxwFQjPaN3KzplZyoG3i0Tp2MeAfw==
X-Google-Smtp-Source: AGHT+IEYALJ+9B/lobgy3w+EObmI4AQjPiv2ADEkieSdC2CNpT2TTJQRK4oxJ8OfChPFR/4y0Hbz2g==
X-Received: by 2002:a05:620a:294e:b0:85f:ed51:e920 with SMTP id af79cd13be357-8906e6b279amr2306580185a.4.1761155513429;
        Wed, 22 Oct 2025 10:51:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0ee857sm97295781cf.31.2025.10.22.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:51:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBd04-00000002rPt-1SQi;
	Wed, 22 Oct 2025 14:51:52 -0300
Date: Wed, 22 Oct 2025 14:51:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Lukas Wunner <lukas@wunner.de>,
	bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251022175152.GE21554@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca>
 <20251020234934.GB648579.vipinsh@google.com>
 <CALzav=eO4Lc15NV5fh-=LCaXz+s4-5+UxPLC4ePMqwUatvLXtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eO4Lc15NV5fh-=LCaXz+s4-5+UxPLC4ePMqwUatvLXtw@mail.gmail.com>

On Wed, Oct 22, 2025 at 10:45:31AM -0700, David Matlack wrote:
> On Mon, Oct 20, 2025 at 4:49 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On 2025-10-18 20:11:26, Jason Gunthorpe wrote:
> > > On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> > >
> > > > Having __packed in my version of struct, I can build validation like
> > > > hardcoded offset of members. I can add version number (not added in this
> > > > series) for checking compatbility in the struct for serialization and
> > > > deserialization. Overall, it is providing some freedom to how to pass
> > > > data to next kernel without changing or modifying the PCI state
> > > > structs.
> > >
> > > I keep saying this, and this series really strongly shows why, we need
> > > to have a dedicated header directroy for LUO "ABI" structs. Putting
> > > this random struct in some random header and then declaring it is part
> > > of the luo ABI is really bad.
> >
> > Now that we have PCI, IOMMU, and VFIO series out. What should be the
> > strategy for LUO "ABI" structs? I would like some more clarity on how
> > you are visioning this.
> >
> > Are you suggesting that each subsystem create a separate header file for
> > their serialization structs or we can have one common header file used
> > by all subsystems as dumping ground for their structs?
> 
> I think we should have multiple header files in one directory, that
> way we can assign separate MAINTAINERS for each file as needed.
> 
> Jason Miu proposed the first such header for KHO in
> https://lore.kernel.org/lkml/CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com/.
> 
> Following that example we can add vfio_pci.h and pci.h to that
> directory for VFIO and PCI ABI structs respectively.

Seems like a good idea to me.

Jason

