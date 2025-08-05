Return-Path: <linux-pci+bounces-33436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461ADB1B7FD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FEB3ADC4E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701D291C24;
	Tue,  5 Aug 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jlZcSp/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B3291C0E
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410137; cv=none; b=V1tmqjjR7/7wcdvkIy7CgJp0q1721Id60+XyK7uK/7WUIVr5tviwXdKB3c1tCPMeGcY8VkOqZV8HBfHL5n0//hp7syjpdH2TTJwrseqXmYbTECTdp61K7K/bf2aXyyH7HKpeUJBnHyZJ6C3IiOMyG3Sroio6YF5XF4OTVMVnuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410137; c=relaxed/simple;
	bh=kTcaW0q5ivmzGd4QOSXd/nHt7wH8yPYPEOgv2LKOSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZASaPhS3oRmEW4/vFvNN7JgcNtnkRcSpWQnb0fWdbSiDW1MbTGRImDUk1tcA+FtLaMLJhwAR9Io+Ou4AmH9Uw6LwvkMRhl841E5Nfcaw29DK/r168QBrx19C7q6m2XtJBCBs6gKc7iavs1m1zmogj9KPo6PadUvcQ5Y8SbiLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jlZcSp/0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7072ed7094aso41554696d6.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2025 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754410134; x=1755014934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3h4Juy631wFFbv9pOrZ90ugfOmUc0F+qy1FlObvh3I4=;
        b=jlZcSp/0DB0BLBDSof6DaXxjFAzb/iwwHDvApe8DXducC+eFBhToPGHfd7IKlYhJdh
         kEXnDKr/uuXO6nqTe92BkjqZAguYGvSCMd+XgvBl3eUo0xWdHXIwumrCVITG2pM+qU0v
         ttpPLJZACl6xvwvcJKvSCsPLLTEuNisFksLBGbONMttsJzWxBVqYslzOIW0YJCUIxvDG
         2+BOnqqlFdNLN1lQVNySU2vY3uD7qNgzbY17RVTwt+IFN+B/7duojNEjzuwTr5fRbMzA
         1CqfQwNACas3JeTuRB4zZ0vwxQhAferusCHh0p0vGbK21hrgqNiNz7DXIxDgTdzGVqoT
         pOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410134; x=1755014934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h4Juy631wFFbv9pOrZ90ugfOmUc0F+qy1FlObvh3I4=;
        b=O/f9JtoljKAFrQzS/QCVUnUQoYw+iCtelJI6H1jZH1gU7LYSowhZnX5wHVcwqbkmsM
         5ENHKVA9g/tc3GvlcIY41A4OdeL7YrkybHr8kkyC1SQhrjbjCaVApE5oMazYIHfO6ojz
         ZuYpZ48v26hvWBKHZpMQ8W7ZbOAxzSyrNsaKpkQl73FMp1DsJddYgXkUOG2KTev+n1z4
         YEBVkVEQaHGjSYIrF58CBQ2GU+WxgQVstJVoAssxsGXOIfPEbrE1F/wEIfetsh15GbLQ
         eaPZDAzUF/dg0DGTRKqgb0hDESMHsoAEygU8cndMLC7sw3dLmrMqSc67naBf4FD3zgcY
         LX1A==
X-Forwarded-Encrypted: i=1; AJvYcCVyF15KGGEXrw8Sk0vbkdr7tN16hDhILMVv1htJRrLXkiWS9HzSa/8f+bjzHnndh3Zrve5zbxOrKpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKvxaHVG8Rr1UsysO6tXVCtmB5GZSMyD+6gmpw6+nKMnViIEf
	XwWotEwDs2ImPY92wbJ/4WxHBlb0X3NyNbZ2bG2gTO2iEVAuwdwk7epWoh6s1x9wMkQ=
X-Gm-Gg: ASbGncsr/8rgLK6ybbInHk7fZwH/oq386SjRW4dq52JaFolUR5bGrxHS4k9UBoW69t0
	IUYXP8Iz3ecQrzJIuFuUNxC39CrjqomrttWZKK/8pAEsd84uOCm3f1HDkcm02qJ8T2SIj4AH/se
	JxNLcz+DO/cwo0LTflqcLn7b+u99ogn/Ki+yNSLJsAY979T+kjV/9mmAYoZnqTKiIz8VshKkUI/
	1ADRNzepaDn7XOBM1cFgcCJd6ihFCF/+rQhA6OubKjFPvc3ZuFQztEPhSxyKDHKznTI3LVXF8Tk
	/ezyKhk9DpYDvpprfWMP0W8cGTE7wiQ9SHaLY+KG+cMziHdQY48+AX44B8TG45OhWFb7yzS9KTA
	BefkdFPjevpgmktpY8JTeqvPkirghh0ix780k0bvJgZ1eaG40xiOhbO1uK1cPeAE3Z8B8
X-Google-Smtp-Source: AGHT+IHZ3PopPeTcQC5Nnc3xOLSRL4WyZRPVraWd7MpQSpA1ulubjE2uvQ7HveFIT+qKiSlQ1vJvtQ==
X-Received: by 2002:ad4:5fc5:0:b0:707:228e:40b9 with SMTP id 6a1803df08f44-70936287ad8mr236610866d6.23.1754410134379;
        Tue, 05 Aug 2025 09:08:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde8d56sm73667086d6.73.2025.08.05.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:08:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujKDd-00000001YvV-1cIz;
	Tue, 05 Aug 2025 13:08:53 -0300
Date: Tue, 5 Aug 2025 13:08:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250805160853.GV26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <a22a1ab7-95c1-41be-b33b-a4009b55631c@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22a1ab7-95c1-41be-b33b-a4009b55631c@amd.com>

On Tue, Aug 05, 2025 at 08:22:10PM +1000, Alexey Kardashevskiy wrote:

>> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>>               phys_addr_t phys)
>> {
>>       if (force_dma_unencrypted(dev))
>>               return phys_to_dma_unencrypted(dev, phys);
>>       return phys_to_dma(dev, phys);

On AMD what is the force_dma_unencrypted() for?

I thought AMD had only one IOMMU and effectively one S2 mapping. Why
does it need to change the phys depending on it being shared or private?

> On AMD, T=1 only encrypts the PCIe trafic, when a DMA request hits
> the IOMMU, the IOMMU decrypts it and then decides whether to encrypt
> it with a memory key: if there is secure vIOMMU - it will do what
> Cbit says in the guest IOMMU table (this is in the works) oooor just
> always set Cbit without guest vIOMMU (which is a big knob per a
> device and this is what my patches do now).

AMD doesn't have the split IOMMU design that something like ARM has,
so it is bit different..

On ARM the T=1 IOMMU should map the entire CPU address space, so any
IOVA with any address should just work. So I'd expect AMD and ARM to
be the same here.

For the T=0 iommu ARM (I think) will only map the shared pages to the
shared IPA alias, so the guest VM has to ensure the shared physical
alias is used. Then it sounds like the CPU will sometimes accept the
private physical alias, and linus will sometimes prefer the physical
alias, for the shared memory too so Linux gets things muddled.

IMHO ARM probably should fix this much higher up the stack when it has
more information to tell if the phys_addr is actualy the private alias
a shared page.

> > > +	bool			tdi_enabled:1;
> > >   };
> > 
> > I would give the dev->tdi_enabled a clearer name, maybe
> > dev->encrypted_dma_supported ?
> 
> 
> May be but "_enabled", not "_supported". And, ideally, with vIOMMU, at least AMD won't be needing it.

Yes

Jason

