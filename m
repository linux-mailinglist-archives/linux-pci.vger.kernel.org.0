Return-Path: <linux-pci+bounces-33437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB48B1B80E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB04181567
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A1292B36;
	Tue,  5 Aug 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QoCjH9aB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437B291C31
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410238; cv=none; b=ke3SbUNp/ns9m/KTAxZn5uad/9MuClMbmONutnQr++et7EONiYnhtIU4hTuXGvuno00VLkRSmUB0D6tvCkcqhmWja/WSrAk0lmsk4MeW9hXu3j5iqXur92DCP49u+2Yh7tERLlAswQBwKH9zCrx+DHphn2il0QNlU0n+n0Dt6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410238; c=relaxed/simple;
	bh=MSerwvz14RWslmARCsAjgCCXLaUZEmefMPtv/CC0p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi8n+jQTn3hGcmIIaOpLmG5ETV68msIyampqYSMryTs+bhvbm0szULRHgm1cgWP8RslYvYoqsecyzqb3cfd265uzzDiXsc0JaXmVqtVwZNFMhj8Pn/t8BNF49D7QnZDqnBNbnRbgnuq2Q9APtQ4Ua5eVV7EEA8iYxLRSMa+F9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QoCjH9aB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e7f940a386so154062785a.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2025 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754410236; x=1755015036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUQiiaWDlCWs+LVMgQEGU5eYzs+NIuuvY+XiZIK97rA=;
        b=QoCjH9aBzpjS6eWkvUofOeOs7IYtg/kBnNyddWH28bCfpvuah9x4DshFkY3I14gVax
         2lPSpsacVWmcEERj0mmAQgOE8dlCeRLC1+kyNw+zltB9qFmD9mxkLzJeL+WLAvOEfOzj
         u2vZdJgOPn6XTfADGp/ouoMx+bBt/DmhhZD329jIMCOltfIdujG0zOxMTebt1Mube6/n
         evvv9HLce+usE4S9gnzqQ6BvO25Lv5Kze/T0F/R1VioFq9HwqhHEVpRpGE62DtBxLC0V
         SxLIxAMr80A3Okw/d78WQBPhoDwkZwvKW9xVvnZs7XJvVOqpuRXSBAmp7h5+LIE7Z7Rq
         VlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410236; x=1755015036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUQiiaWDlCWs+LVMgQEGU5eYzs+NIuuvY+XiZIK97rA=;
        b=vZUX2A/4q5JLvu3UEC9Q+NUYyMmiDjTnjmbP9/r71KA+dQ4UcF5OK+GoONAFDqVSM4
         +iCHV3nsj1K3SPm3vib8wN9HnHupKsDAsNekDQq9AIT70uJSdsCdU8VgYnQjwiOxgrXw
         OkVeR6ej8sou3n5ECZz1k/AyGhQuuXh//jVA3/4hnGSykk5scEJGSwMXpACmC42zOYph
         +mzKlTM9s+FrKxf5Oo4IL6cMopQ0dybq+lTMJt86L4TMuF6HHRaAtKZ+/SrC9RcID+qF
         21+k/b24I2NHarN6eL1dTaBxSk5wqWUcHFjBgpopYR/aIfW9ld1X7dDYZ/UiwTqPnOps
         anWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKKHnHxRl2FLQKDZ4qOJfW3TsA7+GpaIHICay8UmA1wNqAdLz2oX0aWn2c23jhLUKpa/gZ6//9F1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWohzkTDvDiOP/6oIesOZOre85UYkEBKEtYc2LZSL1YzyP172
	7dvo0z8Qv1gln/7DBGS491/NWB2c8q2bEgwRlVCTdcEVpjrfidH0B5nG7ed6w5soI3g=
X-Gm-Gg: ASbGncuWZivfSUwxn2oJTkv85dAn3huKwYrryrkMrNvPAtbVWrMnFkQGD3NmCAb5BEN
	4jT3cARig947HigmWhHhpfV1s+1IyUQJ1StEphaDhvTruJXLkW6F2hwFflmBVeP5jNbkLOoE33L
	JediVinVhGj3C+4ss8UDdrzNL3RcIfvzBtNheAnmhEvTDhzQFRjuBH+UC8Jo63N9L2S5OvDQXPx
	kWRpBMu0n3hDLinfkUq7WvQkcUDXIas6DgbmyplmYki2dy8GMhV1M5jH8J4ghyNiAFd522iTH3u
	FRYRD8ZtmlckAQ3iIxfa6E/imeDqXojbOqC1tsvb/9+wE2RnPYRwCLhUDjvkDlyUf1xTPERbiv7
	b2CySdaJWUxhVoimD9gifO3jrfVB8ssofnpN1wSy+IeZiR88RD/XTr+CON/Ff9OT5d/VOSgXu0L
	WwqUo=
X-Google-Smtp-Source: AGHT+IEjj+v1rIgRJqmyVkBhYcdet0WfxL50iTtkAjLR8rDt3iZUkWBN7QnPGs1X6WJS44VAtI66Gw==
X-Received: by 2002:a05:620a:2649:b0:7e6:252b:9b28 with SMTP id af79cd13be357-7e69636eee2mr1728455785a.33.1754410236229;
        Tue, 05 Aug 2025 09:10:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e69e15f5e0sm369670685a.69.2025.08.05.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:10:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujKFH-00000001YwL-0rt1;
	Tue, 05 Aug 2025 13:10:35 -0300
Date: Tue, 5 Aug 2025 13:10:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250805161035.GW26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
 <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
 <20250731122217.GR26511@ziepe.ca>
 <aJFrvsURkhpTJgh8@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJFrvsURkhpTJgh8@yilunxu-OptiPlex-7050>

On Tue, Aug 05, 2025 at 10:26:06AM +0800, Xu Yilun wrote:
> > IMHO there is no use case for that, it should arguably be global to
> > the whole kernel.
> 
> I think there are 2 topics here:
> 
> 1. Prevent VFIO mmap
> 2. Prevent /sys/../resource, /dev/mem users
> 
> I assume you are refering to the 2nd, then I agree.

Yes, the region stuff is only about #2.

> > 
> > > The original purpose of this pci_region_request_*() is to prevent
> > > further mmap/read/write against a vfio_cdev FD which would be used
> > 
> > No way, the VFIO internal mmap should be controled by VFIO not by
> 
> I assume your point is never to use more than one request region in the
> same driver to achieve some mutual exclusion. I'm good to it. We could
> switch to some bound flag.

Yes and yes

> > The only thing request region should do is prevent /sys/../resource,
> > /dev/mem users and so on, which is why it can and should be
> > global. Arguably VFIO should always block those things but
> > historically hasn't..
> 
> Agree. So seems no need a global option?

I'd ask Alex if he is OK with a global behavior change to make vfio
exclusive, after any required fixing to make vfio only request the
regions once at driver probe time..

Jason

