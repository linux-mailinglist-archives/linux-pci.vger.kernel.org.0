Return-Path: <linux-pci+bounces-33238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7777EB17143
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1753BF4A2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D54225417;
	Thu, 31 Jul 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GwKg8OzK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E239E94
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964992; cv=none; b=ZDcAB3VGMFmxDSRDfP10cGDcdG1jlPI93LMicwBPxfksovrWM9WGk91tERQGAXRY7TrFRMPFvILrQw42CkmqfK8/m9pDRVjniBumMt0AyUXDHuBNn/TLY2EqDOPUF1GhllCGay8LeZo6hbC5fzDqjM2OKjwT663EnS4IDn2ey/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964992; c=relaxed/simple;
	bh=stFuxurLK8Z8AnaZ49l9W8w7aFsmtWO77oIxpAGLTIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1H0mJvCNNf0rPO0Mab/qKM4FAWmV8CITdAHGDwFSyQdGOkx+nNiEzcbWVVkZhT/Va7rM5MPArQeUkiXrNGlhzY+LF+lOwGU59/a9f074SWD2himA5Agv2RvX6Xi74tlmRhpu0KMF6l7giE/A2RVjbVINGBkV9G7PmN9yBVsn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GwKg8OzK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7074bad0523so3304106d6.3
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964990; x=1754569790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r16L0lPAepHRljLoRD2C+qwfP2TiLc2fMDqSQ/mjsSA=;
        b=GwKg8OzKH1FJJ0EGcYmgcoOpKXaG8y4xKTXo4OsawCfSQP8AmzYIzXZ7vHimU38ijP
         7R4ddgMEQpAOC9viO4g1BUb9/NFYlV8X9S7FHUmdcCmg3kCQN55JVeGd4frnBeIZM0Gh
         3pJ7p4KQnBdclbmmXiHGT+jzZtRD/1CMrYNV5EtDvDNVUvsVCRjqxMFG1yFPewdmOBU7
         ktLAI3orHjdvWetkW1iKqbF/UmimM+epIhWVplhWwmrD/FH8Oh+sTla1gXP2y7wSJ+fI
         OMkRroDn6+DKArFYAvBW2KACi4+aX2zxNdwmZ/M+ehTsyAwr7IH1F1xoBPehGrzF5h9/
         GbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964990; x=1754569790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r16L0lPAepHRljLoRD2C+qwfP2TiLc2fMDqSQ/mjsSA=;
        b=DzB73pHPQKl5Gz6WUUxrIANdxHAH/ln6nvggwzUga4dGp/Hyvm6TQuIMnbRfIo16Jn
         0Ydq5mDggdvGVUWDH5+u5Yu3JjP4gQAnc/YzXm07mcvUGYbnEbbaWJDpW5fPD1BoTC+S
         aK3o3m6E7IntSTiSmGfy5CIOgsNxmcdDyiIxm2Hx3AVEncOspTHMKxYPaIUV6xFt/c3p
         MFc1i4CkkZovmrpM1jpMoYgpqTfWHtJxH7L9cYXLvyLqnSpD4sm85InNjf9CvqQkqDFH
         TfVKySTZnPAyg5GckJSKMqg5l6FFOAEJfRsIsZEpGz9RzqJ39hSAKMT2i/h9k1X/VoG6
         DVJA==
X-Forwarded-Encrypted: i=1; AJvYcCXL8vBRKZd4Kw+Xm1jaBD/I2wBjACWKT7DLpj4iUzM/8srGhpwIB+xGD20TlLQrLsyuSgulg90GQoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayaT+wO5wzurqud4J5s5Iyay1hlrFO9ho54Ihnci/5L57no9Z
	txnPregPbGhnMKy4DJ/sesqjptXQJM9iRSiFu+VMLla/PoC7gVr9LCo2bv+lTSp0yxI=
X-Gm-Gg: ASbGncudrCz3rTpM2CyfN6/PsEagoCJw8uNZSAuKAFoNgI7ktAGmS/epxZ5Zp9SyexU
	smQ/XqqhHv+sQGloCEgT4sqYZOAZt4ddGjZdgpekBpHFKr5P1NNQckBfrXI9UYt6KhBoPNNF1Nw
	9nSRriJJhD3hMpXbH77TkjRXb8oJ6pz2amIISLZ4cEWRtT4W+fVcxbgUd16x08ikMzeTSpvgPWO
	kiT+BKdJS0x5B23goWAQpJSs17s2ZbLz3acFhIwGxwTSDrfIpA/kjHYW3LYhuwkJSDhQGBlCyJ0
	o+ExTD99UfVk/27IYfePPeF1jmeGGyVeTNZqXvjAzBPi5ewM/KcD4gEgl4ujmKZO5tzG6zI/evQ
	QQBhKMULdoUeTg/o/QTKPVQh6w6x0PPgtKwhkk9NfFg2ohhjht/38LaDuZ4rhlamJ54n3eoa1D7
	eHD+Y=
X-Google-Smtp-Source: AGHT+IGFRiq4QY4lDaxJA1kOgdG4s98/jc148KJ+4RcbhXD0Gv7ljg9jqdQ+tgIuoEfTT/tXWxH4vA==
X-Received: by 2002:a05:6214:248a:b0:6fa:fddf:734b with SMTP id 6a1803df08f44-7076710c664mr94449716d6.24.1753964989913;
        Thu, 31 Jul 2025 05:29:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d98ecsm6607476d6.2.2025.07.31.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:29:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSPs-00000000obJ-3nd7;
	Thu, 31 Jul 2025 09:29:48 -0300
Date: Thu, 31 Jul 2025 09:29:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 23/38] coco: guest: arm64: Update arm CCA guest
 driver
Message-ID: <20250731122948.GU26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-24-aneesh.kumar@kernel.org>
 <20250730152204.00006f79@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730152204.00006f79@huawei.com>

On Wed, Jul 30, 2025 at 03:22:04PM +0100, Jonathan Cameron wrote:
> > -static void __exit arm_cca_guest_exit(void)
> > -{
> > -	tsm_report_unregister(&arm_cca_tsm_ops);
> > +	return ret;
> 
> 	return devm_add_action_or_reset()
> 
> Mind you, Jason probably won't like this ;)

devm in a module __exit function? How ?

Jason

