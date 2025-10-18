Return-Path: <linux-pci+bounces-38591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD30BED502
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64E2B4ECA55
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672D257AEC;
	Sat, 18 Oct 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aau/TK8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84709257825
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808094; cv=none; b=bseysgYXtyx9mseVD1mHQIxrDG9m3rikLfXmcIyN4IJqG/cdAHfR3guHlmsUE2QlGqp8apHZsJZmRsTHWaKTUJ+dwNh9inNLa1bg8nhJDp07/Be7dPEwOZ/dgRmjlq8b16kvUoA7Igz530o9XC/ovGlvC5rPYiJkx33GOH2ub/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808094; c=relaxed/simple;
	bh=hZrk3e0opmcmsfCNG/ct5rR35QVye1I3kOj+BonLMs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGFHryN2KpDUT0E1lnW0FoC1jS6+aK+YWDIAMGkpu1r+r1rhPIG2FSYStNHa6Murx6GQE010TrzbmMyfHiuVUKyIbbiuCSBcqtJbrH3iGlJsZefvepoK52LFjFR6IZSSUIw12TxrbbhN33k6j55i3Hr9q/n4tDE+Lx7+SUHvih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Aau/TK8n; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8909f01bd00so278961785a.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760808091; x=1761412891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtwlgrrpxMnfWC2+fWrpswQ73U5MXdKBv2JvDR0km/8=;
        b=Aau/TK8nGWOeUX+MxJFZw9gtVtiHPNFci3SjM8Dik/35zy/eDhFQj+15OzrR2mIhN8
         dMMCgaJ0GBVcYe4ImLhqfFHtHXdnWxHnkNNTUtbeuBd8tITFsABVrHAS2AwrbcdDhNqq
         nAMK2J2R2FILaeH24kLsfd7zgSh1Bwv/lDAI7g254NB5oLKX6As7IIx9jlRS/6BobzMt
         AKnwnj3TSQg6ZeGcqtANqXos1GAkuLwbG9mFt++pKblTFWIlF4OierPVgcFqLhtpsbNo
         A0KOZYWvdg3Y5HORB5cdmLv6g9HL8nzLUBeO2P7+gr9Vg4sN7+bWVbQvwHTJIW1Pd3jc
         haXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760808091; x=1761412891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtwlgrrpxMnfWC2+fWrpswQ73U5MXdKBv2JvDR0km/8=;
        b=GNMwaARpdzvvDMCS3FwoNWxNM1xdmJyigoGFtUcoqxzIFlOU1fPNSHOqKXQ93INVE9
         gBK60EAP0Cy27xdGOxwOY+Rek+MVNCOXjBQmCh/zXEhbex7tbSs7J0r7ohlD7EoIaiKr
         8eMi/1J5uhtJzZ5G3GV5Bd2DtY2NLLSHsF/enbZ31K1paJHRqEb1qXxxoFQAXdU8sS9l
         nWQI8FlJ5QU/r0pGT0I5b6cStYYvfqaXG3if+ET3MpFWjKi2WL4bLJA1TN2RmW96iP0m
         IEOu+3vJXzhEryXznuhue8s/URvU6JWOMcRCT/D9YrGERj11zC5ptZG33jMMIzNEbUmh
         bctA==
X-Forwarded-Encrypted: i=1; AJvYcCVLR951HlTXUofKsrMFekOhWOjfaCk35VehfiAw3zzBMGHMJA4xgyyMpKIVWGdWkTz7Xwm+OiK/lr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpx8R6QTKguxlOMnJec5FwdiK8IadUMjJ0/zJ9OlIbrXZX/wl
	XDydMDijzivKlvPfJ754WCSWbu5TpcplhnSDjtpEpG+9Fic6jDET+g27BrZObIOtFIs=
X-Gm-Gg: ASbGncv2LwoSt/W64+2NMt2Ne45jiRFqkmmAcXgSySAQDexbi9Eu9m/RRL1b3DIxxop
	TBKt5fp2fFN247a3liXb+j/xu7Z1XUr95lG9tOB5wFErHWmJsvguQkXhBYC5jaOx65rKWbs/n7R
	EZtmj4VXH+8utYD8jNVSjiz8+MKG91q6L7xyD8o2iA/oAKim200C3b60aJFFc9vgMW4nsYUx0Gn
	F7dDQ9G5ScofvWbhTJYcSVVmY7OhicU0F5DQrB/267PGXAI1WmploUnU8cwMiMUQ/T7EVKTDBH1
	ECOZRMJI2Q8zBlLEdACKb4Sy+zbDwj4Dwgq7nMEounO5dY9quLFwJbjwAFPH58FCs0ivp71LKZq
	8jNNHndQSufB+C3bu0omLcU65RHx4gA5s35nqs+QZd+5cawAFCg==
X-Google-Smtp-Source: AGHT+IFQ4YhonL1Z5Tyw8LFX7yPB+Yhbxw1duCMQ0dgn9fIzCTYhm3XLOpH05ZT1col0ISYsgvgJDg==
X-Received: by 2002:a05:620a:2952:b0:851:cb50:c5d0 with SMTP id af79cd13be357-8906e2ce114mr1080860285a.12.1760808091392;
        Sat, 18 Oct 2025 10:21:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc9cacd0sm201601485a.3.2025.10.18.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:21:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAAcU-00000001Z3Y-0F1E;
	Sat, 18 Oct 2025 14:21:30 -0300
Date: Sat, 18 Oct 2025 14:21:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018172130.GQ3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>

On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> 2. Integration with IOMMUFD and PCI series for complete workflow where a
>    device continues a DMA while undergoing through live update.

It is a bit confusing, this series has PCI components so how does it
relate the PCI series? Is this self contained for at least limited PCI
topologies?

Jason

