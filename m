Return-Path: <linux-pci+bounces-26825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD2A9DC79
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F44A1D64
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21625C827;
	Sat, 26 Apr 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0X7r01J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BC12E7F;
	Sat, 26 Apr 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687922; cv=none; b=kWjvJ2YO5Lb2f2X/EodvDoIC8EOR6WcbaBPBj5KtEwFal9a7TBqQzMpDfkV1Xaa5f/YhGCY+2rLSQSgGT2ZeHb9sDGTTGk9K+3RkEwee50/dliBABFWDR4VHyc0M7YaN8VsAkc4+I6TvxmZngW8gJcbvhPC97s3xVGcAeNsXkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687922; c=relaxed/simple;
	bh=l0FTPLLZSYbU4Vippcp2K1GUr2PByQrS8bEbSei9hDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2wTO/iseBVLB7rPlozdU0LPuy4wj+nmSwq3tI80NxIoVTqjmxc56j2cby4iKvY2PdCY2ykFgCg9MBSpJTFuvujUPkRi4YDmZZll9o5Froqt1eASjxJbfz/G3h7O6LfwMDRR98ep3PKQE2KjhL0h1UBZb+HWv5dq7VFQNa85LtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0X7r01J; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c0dfba946so2381725f8f.3;
        Sat, 26 Apr 2025 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745687919; x=1746292719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yNeen9I0oxXgts9VxQEHXzGWP3A4D9qnojdBg1mq7o=;
        b=G0X7r01JhRG3yPBiML+ECma017OO0YcY87drhs1rge+0v9HH5rnP4ISDD1Hm7NUD/o
         nRsQiz6yXHPVEHhXbYpDHQCjGZKC2RYL183ADcl1NhJdYJCndJBEnWLBfE/iEjCnG99r
         SasofEiU1Y8bkIsC/h+Aoh0PeZ2xk+8VMmaPFjDEMX7MKoGxs5cQV8sxuLHzSeyOp5W8
         XcHjtA8Fb09j66PrWA430qJHowVN5h3Ipnd2kwH52W6N+/QlYZpXUxVQ7pIFcB52tmC1
         On6CoET+K22Ec6BQ6onaRItVf5i49se7j0LV/t86P5COaRjG3ubJyWQj0+FkIheLkO9X
         oxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745687919; x=1746292719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yNeen9I0oxXgts9VxQEHXzGWP3A4D9qnojdBg1mq7o=;
        b=VBXX45sECPQdxeqqJCa02A5xcZTkCRQyKW0bmz9pfSA8WwExPqTxX7Ako2uG7SYfad
         mOZy6NXgo7Zwww6PydYABsAuA2JpanpBztyJoQTm/HagnofD5zl2DFpd/vdl8kUnFmfp
         9DoXN9L91j4rn6kU226c0hoav5yFgcMdavBUoJJbrVAtT/crYEnwzRYr5CrnPd4IT4NB
         tDhPJUxU1QNaKQgU7BGM8Amuy6ZlhWHUaoSAZDysL9B83RjSHitIJf6TbWSZphg16SLd
         uwCXvz4wE6DgPMqPaj5v1k2VoD9jteozPhBsSeKFwJozmm5QQF8DqGM9sYzImb890vf/
         z0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUdN2m9Kxf9LxIXw1SYqttMsjjATPxKBChWSvcvHJvq4jVJatqCO6lcf1uHA7QXroGe45Ot30qb1IEf@vger.kernel.org, AJvYcCUe/924d52LWZ4qcEB1qlYmjb9NvGRxX+jE/S6uRpkXO3UrcQR8DLazG8xV7gwB6vnsRqra8atrp6q1SItHjn0=@vger.kernel.org, AJvYcCV3VBhla2KXFOvm5bT4ShydZMSdt2yw/N6IU/QwZeL85mkkku58JZXmm5O0gis8y4SESJc1xi3BRUwAW5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNtdcBMFHaR0rp0kMRjcpsPf3gTNIp8ZiY6lIADH2ETX6o0BA
	Yj73HRSohc6tqyE2cVo6vRakRu7oqAnCwPobKHxyCqJiwzIyN8kC
X-Gm-Gg: ASbGncvjWkJBy5kYQAbvoNRFaeMuUvsVRoroxZnWcztIa6yTfHXbnEqbPzqR7/T3pIF
	YQA5nJQ+ItrpL10vPUPI1PJdUKXi9tTZ7I//m0Z7a8WINXMJdTyy4QR0Tiet1Kidb4Tho2Dcby8
	kq+QS9TggCtQz0xIXSWWS634aPRtuL0igy4ytWrFjYfgNvxVG7dDj1w2e5GWStXKaIuJ9B/uVHi
	sXY2VBmuxvH+fTSj6J6r9OzdMitI4QrK0sd97vPED8ZsPC7FuYrHba2elIZPHgVke4DRv+/b/f4
	yCulsI3FsYIwmpNkcqcDSOfdu8pps4cuQ+W+fYIfDvRcIASp32rZkg==
X-Google-Smtp-Source: AGHT+IGMhzyR+os8CmvxFQFS8cmxO6gnXqAXR+4QtfFFPWjpjUsfjAA1gbBCSVkcUtJ9KmJGiKa0yg==
X-Received: by 2002:a5d:498d:0:b0:390:f6aa:4e72 with SMTP id ffacd0b85a97d-3a07aa6dcc5mr1908207f8f.18.1745687919205;
        Sat, 26 Apr 2025 10:18:39 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a02csm68676835e9.27.2025.04.26.10.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 10:18:38 -0700 (PDT)
Message-ID: <78853ac7-c9d2-4485-bbb3-859d2425e729@gmail.com>
Date: Sat, 26 Apr 2025 19:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
 joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-3-dakr@kernel.org>
 <ce224b78-5c26-46d9-9b69-6bceb1bda62d@gmail.com> <aA0TIWj50RYogLxj@pollux>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <aA0TIWj50RYogLxj@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.04.25 7:08 PM, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 06:53:10PM +0200, Christian Schrefl wrote:
>> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
>>> Implement a direct accessor for the data stored within the Devres for
>>> cases where we can proof that we own a reference to a Device<Bound>
>>> (i.e. a bound device) of the same device that was used to create the
>>> corresponding Devres container.
>>>
>>> Usually, when accessing the data stored within a Devres container, it is
>>> not clear whether the data has been revoked already due to the device
>>> being unbound and, hence, we have to try whether the access is possible
>>> and subsequently keep holding the RCU read lock for the duration of the
>>> access.
>>>
>>> However, when we can proof that we hold a reference to Device<Bound>
>>> matching the device the Devres container has been created with, we can
>>> guarantee that the device is not unbound for the duration of the
>>> lifetime of the Device<Bound> reference and, hence, it is not possible
>>> for the data within the Devres container to be revoked.
>>>
>>> Therefore, in this case, we can bypass the atomic check and the RCU read
>>> lock, which is a great optimization and simplification for drivers.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>
>>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>>> index 1e58f5d22044..ec2cd9cdda8b 100644
>>> --- a/rust/kernel/devres.rs
>>> +++ b/rust/kernel/devres.rs
>>> @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
>>>  
>>>          Ok(())
>>>      }
>>> +
>>> +    /// Obtain `&'a T`, bypassing the [`Revocable`].
>>> +    ///
>>> +    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
>>> +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
>>> +    ///
>>> +    /// An error is returned if `dev` does not match the same [`Device`] this [`Devres`] instance
>>> +    /// has been created with.
>>
>> I would prefer this as a `# Errors` section.
> 
> I can make this an # Errors section.
> 
>> Also are there any cases where this is actually wanted as an error?
>> I'm not very familiar with the `Revocable` infrastructure,
>> but I would assume a mismatch here to be a bug in almost every case,
>> so a panic here might be reasonable.
> 
> Passing in a device reference that doesn't match the device the Devres instance
> was created with would indeed be a bug, but a panic isn't the solution, since we
> can handle this error just fine.
> 
> We never panic the whole kernel unless things go so utterly wrong that we can't
> can't recover from it; e.g. if otherwise we'd likely corrupt memory, etc.
>> (I would be fine with a reason for using an error here in the 
>> commit message or documentation/comments)
> 
> I don't think we need this in this commit or the method's documentation, it's a
> general kernel rule not to panic unless there's really no other way.

Alright I'm fine with it then.

I just don't think that most users of the function would be able to
gracefully recover from that other than failing the probe
or whatever, but it makes sense to allow the caller to deal with this.

Cheers
Christian


