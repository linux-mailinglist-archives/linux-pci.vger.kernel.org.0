Return-Path: <linux-pci+bounces-44072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3DCF63D2
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E073023D59
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6233BB4A;
	Tue,  6 Jan 2026 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TqrDTOwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425532B9BA
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662559; cv=none; b=KoAXUJUHkuDvU6nvJ/oirBl2Zmm/eviLNF4JEDGewjSHzMbcJ5RFnzfYXy739IdGwJGWlyLRD+twgEH4t3Y5Ddwg0teHv2TyVGbEoGjZ115/wANRrK96TNXA2lT2NJkUh0CL04PbnP//maDXIqatAah7gaxQD0Pr2JUobqKqC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662559; c=relaxed/simple;
	bh=mf215Bsa4OZ4GFhTmkkQox24BB3kx7SzucOQ9uwqDKg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7pGU4YF6CkDTOGCqZYoyN9qDLWjn+B08YHvuwM9uV6aWVT1tqD3HvRq5Mawds8UIg54TLGuh3VJYYrbI/mBdPHJm74Yp5G8HDPNC30d3Aa2lK1YaOt0MiL9tWW+44XG1Q/Hu4Z/sXgOR8IU7kRvWSLwbabPdfUv05oI3sibvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TqrDTOwj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so4522206d6.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767662557; x=1768267357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf215Bsa4OZ4GFhTmkkQox24BB3kx7SzucOQ9uwqDKg=;
        b=TqrDTOwjz6fSGo0ZF+XuLdJSbjBY0eDt55jeHuKkXmR4vuDZDnYVhGY4h69TPzKdBn
         79uYHQeKTp2jdebNIoLyC6JXZLOWBhhLqVCML7Bs1SusmdmL5WhkCSYvUj8RtCF0mBZX
         TXae6VzxuDteAlGeIP+IPok+OffPS09rb3UfUZRwKnanQA4Iwf1AckEo+Ow+3ebL9oLs
         Hg7PSFJFNMDeF2qyLYb08X9jSNnGRmrNeedow1HiTqtrJx2oZjK2XG3r0ZyqbDRua5ci
         tJuehSuFoN18SbREgFVFEZnjg88PS7s/+YTXXy0p13sFNazpAakbWRtEtQlIInu+h5rX
         q87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767662557; x=1768267357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mf215Bsa4OZ4GFhTmkkQox24BB3kx7SzucOQ9uwqDKg=;
        b=GKsqz4yl6J4ikQw9MEyJHvsFlH2TcVgCwgDpqc3zHS2XFo8GtkEToT8hknF5KhzE8+
         cbqQYKSfdb38xGDtLyfee27odMhjfm7mq3LN0MafbHcRBTGV2940WgAmjclTmZTJa2rT
         ENnuyQ5OGfHkiz5VzYw799/kilGuLgf8/9SpCRt3qQXDUjvHN1yV6b+Pf6yFt2gwQIYn
         2bP3Wc+U/RQrD7emfAMWyorlmogAcZ/Fp3nd4xwOrua548r32KrVwrr5lkkxqxVep70o
         uVovn52ymg3/BytOT++wwF8w4H7MdCBi5BPhdu4zyjW/ZUUJT0DMZDz+nDieRhNuVJ9M
         wQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVPbrO4uH3EcSXTEpIU3SU2aFX7WLLlouJYcnKCH/hGVwq3yrYWur4P6XMrI8ma3ZWawonw/bqNIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFL/PHHN5wIGmIF1FwcTJ4qxkt7yGoch7gY7B3gG4AYVmtrsGj
	PkmuX1T18kXXSHWLDWAbCMiUUysXhstlzWYOx4NVcgST09yDN41UrFZMkkzjzrlHa98=
X-Gm-Gg: AY/fxX6GcCblO5301qO2mOXqSZiFpxS1RP7Bd1Kb9rSngHvCcYHET96WZbLcZbk428k
	d50fbIDDobn6bCWYEMAdQjLsVvUdMDVl6XpbV9J/++qBPWLwZ2OBg2pTDWVlM7H4ynEiWpk8i25
	4Q/1o5Cxm2eJqhRah0BgBJ26udxuc+KGIztgAdxbek3a+XkMej9Pb2BTZ7LPT6pzgkezbiuNiP2
	AO/wqJLmFHmdTyEfdvKaNayNoAfkAdWmBw+AaxEBD2HeRTpohAboNkF3ZPowg5hp5wavwEvYN0D
	W47IZWM+jlUGXHLu8vFFho6PeleYGz9S3CBkfwvhh9/waPVmGRh6k6BtaexzvkcW+I4yhHJ1urQ
	gmekRHK92t9g60qFyJQh64IsEhm526O7b4G6/lBGnO7FH7er8jVeJKvmUq0T2cBi4yXNafG9lSf
	yFmFaIIg2DFk0uX7hKisoDLeBDSguVY4bKj4p8GwhpTVGjXpteDHvcKz3HB3XNYQffcDw=
X-Google-Smtp-Source: AGHT+IEM15GR/5Y9ogD77tynVPoOaSnflk3CNBwLM7mh9tKkkP1Pq//+VzH0PJSrypNvdcoLpzXtUw==
X-Received: by 2002:a05:6214:f07:b0:880:54ac:79f8 with SMTP id 6a1803df08f44-89075ecfd7dmr24591926d6.48.1767662557174;
        Mon, 05 Jan 2026 17:22:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724f06asm4814886d6.40.2026.01.05.17.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:22:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvmO-00000001EhY-0HWP;
	Mon, 05 Jan 2026 21:22:36 -0400
Date: Mon, 5 Jan 2026 21:22:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <20260106012236.GR125261@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
 <20251121232833.GH233636@ziepe.ca>
 <aUrquI3X68Ilmebh@earendel>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUrquI3X68Ilmebh@earendel>

On Tue, Dec 23, 2025 at 02:17:12PM -0500, Peter Colberg wrote:
> Further, enable_sriov() is prevented during remove() using a new
> flag inhibit_enable in the pci_sriov structure that is set before
> and cleared after the PF driver is unbound from the device.

Doesn't this need something concurrent safe like a revocable?

Jason

