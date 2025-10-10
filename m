Return-Path: <linux-pci+bounces-37832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74CBCEB2C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 00:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D599D3ACCA4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543627702A;
	Fri, 10 Oct 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X6I7iV5R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFF2586E8
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135689; cv=none; b=cWCkXFRczmXUTWUARd83Crf6jh04CosbIfXmH2yHaEwFlbPuUzGJG6cqEhDNzgt5K2zDP6fd8UXOMnzG5P5Zw9lBNyBV7nfslV9KIRR9zMKIWDBHDU0azhY3soE/xTRTNvigu1ESTcI1E+kOdaTtTP62BXkyzDH5HAR/VO/GrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135689; c=relaxed/simple;
	bh=Pk2+8/IwqNSzhAu614JVEvZm09rKZH8rHw8rZM0DYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjOftzh+khNWco6rczfSamxCsxeSkmhbee9jy2iGAvVv0AoiivwamdawXkmU6MNXCAhKuv+HrM+WdrrfiKccxsYZpBT43JGMbiGmO0RPYtAkKacIoRKE4Vhor7UaaY6/u1d1eBhTuVGqjGCuxbVZ1oJIxFC1n5S5+EZcNqJu/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X6I7iV5R; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-795be3a3644so16784486d6.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760135685; x=1760740485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2mC6oaVhDB8uY07Xh45M+WrV8K3BihoQCe6CsvnzAk=;
        b=X6I7iV5RLmLJK4Gr/0GbKkwcqvGxq+FE8LFK/yFzebLarnssRBwHyEg6URBs7RnOV0
         Y2SieomcM6hbAKaYnyo8j1R90PlXlq9Jglm9m6gU02a33xXkqPAJerD5AOTYOXPv1QFW
         z+2JlMopkvMRN8qaZOW9lAibr33gHQuAo0jw4fXUD2iyjDhXPKKHEE1Mv6oGjBCg9QN0
         dKNtocEO3GErE7L/QZev1G7TSZFdzGMHoBvBLSWsIMtQ8ezvmsF65+0jTjKZpE21vENY
         iS6dxfAjhUME+ps5ynYWBdBthzDdlowDXMP0EsdLTGrby25k4EWzJt2SlXXEQOXe9DaE
         i86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760135685; x=1760740485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2mC6oaVhDB8uY07Xh45M+WrV8K3BihoQCe6CsvnzAk=;
        b=oAcIGLqKLjr913z408nt/d3y8z/4NM8Mu5J8lbNDW8p45oW+J/rtW98fcxcgl0tmba
         Qqj0HawQXxwYtPJvwe7K3UTvOeSO6zpDAqTMhLRHZXIztRpfaeBp6dBHQhA2uJosChGr
         vjNUTWzp0+JilgstKEgc8U+NLTXADBaA5+O10UWCgJAGCrzAvBD7ieOwnRwEPszDI9zk
         CHf/7IHUzeurwWb7RHlwWNJ49yf0E+0PxoaaKm+OF6CAJMfdjgxRBy6sHO/0wMMIbwab
         vuPhh9bm3R4cyPixUAO/xc9XwlW9mGkAsS1SclFvaytctZJoCWpnZQu7PATnSIaMRwWj
         IpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRQA3uAlhSdPlLDrNTf9QRY8DIKseFaZf2TNhkvb7s4W1/EEEsTpJAgoRn+aNMQ79vFew9UmsoYCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkHbaAJ8Vfej53mpLhN7J0eDTeUiG/cryId0RPPhm+dBc7eXx
	/4nycjpmT812unuFWgD1GOxlFA4K9g9DLgkdhhoXE82JSGvT7ogh4i56LpG+DBNFNRg=
X-Gm-Gg: ASbGncv1Uxl0iAQSGp4Vc0LFYm2jz5LojQhdOOeJWQ5R24jSCaAiuUskZ2LEtR3ftGV
	NX4pp66zsJyidp05IHZ9bEIV4PDgtG0VBd2YA2RW3ZEePF8FCNd+6uiDaGjjyCFCcS5AS9+sJSy
	+gJ6/FUhGyGeBnTHscSiQipJ/IWYblpIjOw6wxpHtNd5b4tDbJYGYxI2S34V7OFDAHyujuFXVzn
	qjwDPdAqY+W628TsSyT8mmlmYriPYx9PwN+6QLZKcQf/eKtQGiCOgIFvbrfYO4LxGr+hvdiIstm
	vynjazxZhbBnQzSpTpiE+RBPMldVibGVktLwmFoAlwO8bpq+EO05dd7o286nf0MqISw9kO2pUWK
	/mkGJ68MDl1q986K6HQ5pmhS+PxZbzQDEW7rmcvVjLmD9Gi+G4ukZvQc4Wugl/q8kY9vs4Wr1tw
	Jk5kL7opn3zG4=
X-Google-Smtp-Source: AGHT+IECAcR/KGy/e7wbySPEFRjHLCdMYKTul/IVB6jvzNGBmryovZWE46iccPi7Pk1ulqBzRKwDww==
X-Received: by 2002:a05:622a:5984:b0:4cb:57b4:4d6c with SMTP id d75a77b69052e-4e6eaccc73cmr181726641cf.12.1760135685384;
        Fri, 10 Oct 2025 15:34:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706de73ccsm26004611cf.45.2025.10.10.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:34:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7LhE-0000000Ghev-0UWp;
	Fri, 10 Oct 2025 19:34:44 -0300
Date: Fri, 10 Oct 2025 19:34:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20251010223444.GA3938986@ziepe.ca>
References: <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
 <20251010153046.GF3833649@ziepe.ca>
 <f6cf20f6-0f19-4814-b917-4f92dad39648@arm.com>
 <68e953f484464_1992810065@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e953f484464_1992810065@dwillia2-mobl4.notmuch>

On Fri, Oct 10, 2025 at 11:44:04AM -0700, dan.j.williams@intel.com wrote:
> Jeremy Linton wrote:
> > On 10/10/25 10:30 AM, Jason Gunthorpe wrote:
> > > On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:
> > > 
> > >>> So you could use auxiliary_device, you'd consider SMC itself to be the
> > >>> shared HW block and all the auxiliary drivers are per-subsystem
> > >>> aspects of that shared SMC interface. It is not a terrible fit for
> > >>> what it was intended for at least.
> > >>
> > >> Turns out that changing any of this, will at the moment break systemd's
> > >> confidential vm detection, because they wanted the earliest indicator the
> > >> guest was capable and that turned out to be this platform device.
> > > 
> > > Having systemd detect a software created platform device sounds
> > > compltely crazy, don't do that. Make a proper sysfs uapi for such a
> > > general idea please.
> > 
> > Yes, I agree, its just at the time the statment was around what is the 
> > most reliable early indicator, and since there isn't a hwcap or anything 
> > that ended up being the choice, as disgusting as it is.
> > 
> > Presumably once all this works out the sysfs/api surface will be more 
> > 'defined'
> 
> It has definition today.
> 
> All guest-side TSM drivers currently call tsm_report_register(), that
> establishes /sys/kernel/config/tsm/report which is the common cross-arch
> transport for retrieving CVM launch attestation reports.

I suspect this ins't a TSM question but an existing question if any of
the underlying CC frameworks are enabled. 

It is this stuff:

https://github.com/systemd/systemd/blob/main/src/basic/confidential-virt.c
https://github.com/systemd/systemd/commit/2572bf6a39b6c548acef07fd25f461c5a88560af

  Like the s390 detection logic, the sysfs path being checked is not labeled
  as ABI, and may change in the future. It was chosen because its
  directly tied to the kernel's detection of the realm service interface
  rather to the Trusted Security Module (TSM) which is what is being
  triggered by the device entry.

Maybe a /sys/firmware/smc/rsi file might be appropriate?

Given how small a deployed fooprint ARM CCA has right now (ie none) it
would be good to fix this ASAP so it doesn't become entrenched.

Jason

