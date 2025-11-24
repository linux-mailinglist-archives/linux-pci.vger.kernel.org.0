Return-Path: <linux-pci+bounces-41947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C25C80E3D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987814E6326
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B730C635;
	Mon, 24 Nov 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MHY1K4Rj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CD30CDAA
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992804; cv=none; b=bKQpfrK1qqGMBJdJQ3uGEPOTlQnqAVOMY0N/gfqkikMjJO03eY260nCTc9AoNJEkQQ0IrkiGCmdPOaMgN99G4mqS7BY4pBBNwmA2NYgCFjWEPt11HzkfBwaYLqXecPi/q8wYnW/6zxYSvLUheEGACxe/gYtb9rVKZyyXirycm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992804; c=relaxed/simple;
	bh=fcMTHl1mrz6IyNafxhKxo/CWeJdMQM5MNO1ZxV94RM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTY9eJlrztYxvediaSG8MsFXy284XDqQKzioQaY6nWqJmenHXz0S+yC9wE5FmHAH+NPLfcbemsGjsQAuSDkJ2DLrHbNPbBWvEedual6uVbvWxHNNtKDN4PQZrrHppM9/4XBU0Y1PzkznvLmdFKmIbo10w0u7PXKsyxGJ43eiAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MHY1K4Rj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8826b83e405so63696786d6.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 06:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763992801; x=1764597601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmMAzBOpNN1o3idEKTqN7AV/9KSVRTF4wYZAXj4Hq+A=;
        b=MHY1K4Rjz499jYD5O0qWVpDxHvgJS9pHiaoig1KicjUMzJSWfNecHT08nFEmxlXnYU
         Xxhm9zLVmEE0TCwb8mi6tBeYUCqyrg/nIittWGULlbOLto6c+b89VPv4iT8h4w2HgTG6
         M877JMHqiSgyqKB4rFAiZF5SzcAqPrF+LYErerZ6Eeda2Ka3lOwHVqJwUSjHgsjRktfQ
         AswsT8ZVNfqyV8TPlBFmtel6wPOa9grRSWJ8j8FX8LJU1minkMKJ9DY4DxSJZDg1/5Ak
         4n2ExOwwlBkEnuFbbhnzg0Y3OYdFITo8y5uylj07WoMRGTlbSu49n8hrm5Mz6F2M1lq2
         zZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763992801; x=1764597601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmMAzBOpNN1o3idEKTqN7AV/9KSVRTF4wYZAXj4Hq+A=;
        b=Oy2p8zUdQSWQKxXNvGtWbidVzsWREl0iam/129Mq1t9GBcoHEMN7z7VlJPE//45ifp
         b0MZrLbpY0PzwtjuBJY1QrvBaRd0ZnJgRMW72Cqydk++zRdi14XZmMvTdOckDf5AlfDs
         s6A7H3G55P/78hxUwSQEMsCzBHXlB6Tl2y+yU1JovPfepMRmrJfhspBJe9OCF/7gZ26Z
         0o+RrQ7SWMrF7fRdN2FiQH7DwPW5io9pzkBNHjLcSRQvZNp6zQ1JB7YMIfdyOXf3TrlK
         mVzyl8FdmQwRM87kWxcdH4E3GSFjScryFGsq8KmVTM5egpQW3zNQyCbaR1iA2yDEC0FA
         NmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWow8DhMl+ic+It+IrKFNdwNk2OdQFZslGAHnbbpo8D7mRp1w3atEN1eeYj4q3EXJFEorcD4dyRlHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMTfHsNyuMUYQA6Y8/HcFWk58jlikeIlR7UvmsXGiGtI2IKWE
	Bv1GnYBUP1Z1Csq3dJogIAnR+oH8+kwpWwjRjIm7vkVugdbbc+sv/IGhZUTLK5gIcEk=
X-Gm-Gg: ASbGncu6f2SlAWCRXrkQ/+OKfSSkoeL2V/64sn4/IjAG85epc99zJuJZ6IAB3b0jvo/
	AxkbZ6yaSIeLEyblMGlF6vLIKrLiZknZTjdP0Q8V0urpBoSB5ngb29PTCRi58G2wkFvKQ4HjCx0
	0RgLhX2+NGsBTgdHdO3a5jvGvtEY9Dp6lUvJ93GxSt/IgMp2ZRvolX9UG7UAI9S+lXFMGDBK961
	+phq0L2uiN5eKnlS/5PhByQRffHJ9UK8Ii0cBOTTMEmeuAoE31pJWTaKBo636QqoZhOFGnujCE/
	BnQ76Bn99Ig7hjQS6VHtyxSGSSMpcngVCjnWNP0+zhEJAVyrEQoeQAVxkuNBjRLjrc/DfiqUmhw
	vGgtq/GB46HRUXdGu5orPTr53vm66N/CvHeVNrgQl6v/FnkKxo/DlNqeuQRFcmh9gykZ7ROcPyn
	mud3mCcUXZS+LAQB1e5yJT5eP5efUzFnNwhns6IQBeIP8P5QPD0XXFNcui
X-Google-Smtp-Source: AGHT+IGuSC371UbaFuuZi784x1t57RvcTn9R9Ct0e0xNogGjAo+hdKSQh/bz3HardhmkpnbaVEdoTw==
X-Received: by 2002:a05:6214:1bc5:b0:87d:f666:3bc8 with SMTP id 6a1803df08f44-8847c49c6e7mr166820156d6.10.1763992801080;
        Mon, 24 Nov 2025 06:00:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e3000a1sm100155626d6.0.2025.11.24.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:00:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vNX6l-00000001uZe-43Fj;
	Mon, 24 Nov 2025 09:59:59 -0400
Date: Mon, 24 Nov 2025 09:59:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <20251124135959.GP233636@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
 <20251122161615.GN233636@ziepe.ca>
 <DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org>

On Sun, Nov 23, 2025 at 11:43:08AM +1300, Danilo Krummrich wrote:
> On Sun Nov 23, 2025 at 5:16 AM NZDT, Jason Gunthorpe wrote:
> > I think to make progress along this line you need to still somehow
> > validate that the PF driver is working right, either by checking that
> > the driver is bound to a rust driver somehow or using the same
> > approach as the core helper.
> 
> Do you refer to the
> 
> 	if (pf_dev->driver != pf_driver)
> 
> check? If so, that's (in a slightly different form) already part of the generic
> Device::drvdata() accessor.

Yeah, but by that point it has already returned a bound device pointer
without proving it is safe to do so..

If you check the flag you are proposing below then it would be OK:

> > I'm not sure the idea to force all drivers to do disable sriov is
> > going to be easy, and I'd rather see rust bindings progress without
> > opening such a topic..
> 
> I'm sorry, I should have mentioned what I actually propose:
> 
> My idea would be to provide a bool in struct pci_driver, which, if set,
> guarantees that all VFs are unbound when the PF is unbound.
> 
> With this bool being set, the PCI bus can provide the guarantee that VF bound
> implies PF bound; the Rust accessor can then leverage this guarantee.
> 
> This can also be leveraged by the C code, where we could have a separate
> accessor that checks the bool rather than askes the driver to promise that the
> PF is bound, which pci_iov_get_pf_drvdata() does.
> 
> (Although I have to admit that without the additional type system capabilities
> we have in Rust, it is not that big of an improvement.)

This seems like it has a decent chance of succeeding..

Though as I said in my other email, you'd probably want a version
where there is WARN_ON if that common code is actually triggered as it
would be a driver bug to misorder its destruction.

Jason

