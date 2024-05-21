Return-Path: <linux-pci+bounces-7716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86C8CAD49
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5057A280C54
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE961664;
	Tue, 21 May 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7JUWoy6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733256763
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290576; cv=none; b=FKqthic/z2R5AgQSbikd4Q1nhl6cei9Rjj+V0oSbklCslFjR2+CxGDmbFW80Khv78u9PMLDkNMRZZ0UdqcMi9SvvntILQV1Arcoe44YOCebX5eiOtjWxOwVq/BBOfxsslQRHxejgdY3Dzg18ggAeOtq1/HmaYXH16Q5jzZ/EGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290576; c=relaxed/simple;
	bh=k/JRGdMuDPu8HhJUTkcTAdkXQAVA5INw/irGgRh31Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sN1JJJp87/Tc2iT4UQ3FZIuTZ4HNNQOhz5lcnzW5buj3rjJyN0p+kT71k+JtZFWRxnhMP6eBpkWohvOX3jdnLaTtIfbBDpYWWYly/8gnLZ81msJY11ZNfxMbgAaqBynEng/xTQHfOTmJ87Pu8XT+pPB2bhVJ5W0sQ0JuEp8+k8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7JUWoy6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716290573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHk/Aed3i1ecXpAXSTOJ91mw0z8jVc514DVco1BYwS4=;
	b=H7JUWoy6BYRxyIEbe/mGhhtALCdP9w0oOOI3Ypq1GhLP28wH8m7q2HEd1meojyLOqWf8ip
	xQvPP9O3y1ZytWMGLgji6VExi7pT1mk0LmhHxb8+bjaLuwOUXvJrwwuZXbHrwNppDxwoGP
	7kizDua4z0/O8YHDa1d+ND/SOvp3g4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-PAJ0T7N-PnWbVnykjQkGUw-1; Tue, 21 May 2024 07:22:52 -0400
X-MC-Unique: PAJ0T7N-PnWbVnykjQkGUw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4206b3500f5so26800855e9.1
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 04:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716290571; x=1716895371;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHk/Aed3i1ecXpAXSTOJ91mw0z8jVc514DVco1BYwS4=;
        b=NZi9Nj7T5dWGuud0mhT+wab7uEi/3rTCFBoSBZEUhB+iW1no+mx6Cir4AmnzkaC0o2
         OM6M1+qxu2roJw71Kmpk7s+pE7UzJa3LmjIw0Hpqj7+9o7bnZrWEMtYLyiVpC8dc4uHq
         P6hqQ67xLkMwt/CFJPOYGGknkaPp7tGy2ldGRxF8N5Ofg8fIiXIuTQ9tPY0ZO6oGMsEf
         5OqN1+cdRWSf4ZBn9xEYqqROvJEpDrGTJJ5PLPsLDOUY5Mown7kG3MpPqB2rcLUI4IdF
         KtupjozuEPStkg1J248qJm6cFS7t9uWWg7+IVYKHZlu2O5tgBMxsLj2MHV7yXzfRU9iO
         OGBw==
X-Forwarded-Encrypted: i=1; AJvYcCWlezByw2mfsedFv1RpaWBLbRBqbOtqjNgUevqV8Fq/OME7GjP15wD3uemi4peCGHrhWHzR95UKSCg/uwgwicuPDZu/ll62ijz+
X-Gm-Message-State: AOJu0Yx3WELaPpq9qI52qgLQMY9rn+4OjSamR0gLsJ6f6GYc0je06EdM
	G/+ib3kSq4/1u7v43CVZlPvbWscIQFwBIql6fd1UgXWgAjXlrIVxf2CPpFJI3Jps2BiGPpihV38
	yb/JkXm0ZqUL7n2uCHroNEZolrVqt9bNzNa2HzrLxdGQHpSmxf6iJn/znvQ==
X-Received: by 2002:a1c:7910:0:b0:41b:bb90:4af with SMTP id 5b1f17b1804b1-41feaa44138mr310695005e9.20.1716290571312;
        Tue, 21 May 2024 04:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnDG2VXNjT+etdhjHBYITRzAAnJCTDKOcgyRnMS50oTbo2a8QHWU4X7fhBAgBVC3r+eIiCew==
X-Received: by 2002:a1c:7910:0:b0:41b:bb90:4af with SMTP id 5b1f17b1804b1-41feaa44138mr310694755e9.20.1716290570972;
        Tue, 21 May 2024 04:22:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm31724783f8f.81.2024.05.21.04.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 04:22:50 -0700 (PDT)
Message-ID: <8432d37c-c3fb-4404-ab74-fb0a9940f0de@redhat.com>
Date: Tue, 21 May 2024 13:22:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/11] rust: PCI: add BAR request and ioremap
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, pstanner@redhat.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
 ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-12-dakr@redhat.com>
 <CANiq72kObXP7-YtcXnWQXJpEQ=N+RtcSeM6A+scBK00VkFj5JA@mail.gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CANiq72kObXP7-YtcXnWQXJpEQ=N+RtcSeM6A+scBK00VkFj5JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/21/24 01:27, Miguel Ojeda wrote:
> On Mon, May 20, 2024 at 7:27 PM Danilo Krummrich <dakr@redhat.com> wrote:
>> +        let barlen = pdev.resource_len(num)?;
>> +        if barlen == 0 {
>> +            return Err(ENOMEM);
>> +        }
>> +
>> +        // SAFETY:
>> +        // `pdev` is always valid.
> 
> Please explain why it is always valid -- the point of a `SAFETY`
> comment is not to say something is OK, but why it is so.
> 
>> +        // `barnr` is checked for validity at the top of the function.

I added pci::Device::resource_len(), since I needed to get the VRAM bar size in Nova.

pci::Device::resource_len() also needs to check for a valid  bar index and is used
above, hence the check is implicit. I just forgot to change this comment accordingly.

>> +    /// Returns the size of the given PCI bar resource.
>> +    pub fn resource_len(&self, bar: u8) -> Result<bindings::resource_size_t> {
> 
> Sometimes `bindings::` in signatures of public methods may be
> justified -- is it the case here? Or should a newtype or similar be
> provided instead? I only see this function being called inside the
> module, anyway.

I agree, I just added this function real quick to let Nova report the VRAM bar size
and forgot to clean this up.

> 
>> +    /// Mapps an entire PCI-BAR after performing a region-request on it.
> 
> Typo.
> 
> Cheers,
> Miguel
> 


