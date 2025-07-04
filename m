Return-Path: <linux-pci+bounces-31494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A2AF85F7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9757B8E06
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A731EDA2B;
	Fri,  4 Jul 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXZ2Rxug"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0E18A6CF;
	Fri,  4 Jul 2025 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598747; cv=none; b=mmvjFNNkWuRChGacOl4hyLYEfrEtLkPAUl7A0hH5iQca5U+pk6p4eRt8W0isy6WW5rdwiV2Jmoog/iDA1k8d5dvXuZlNDgJsclk7EEQ6G+vCS5h5NM4t6LspaRUi24dGK4oJZTyPCv1xVUARy0jDdRHgRgQRN5pw/PhYxGF7dDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598747; c=relaxed/simple;
	bh=Fs5SxE9OYDU9RRGx9YYCJ+8P6J1CW9T/pjsOKtv2W/c=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WwgJFFeJFBBEChjQ56e1pyg1NEN10FTkL9jBCLik7RJdLuJp6pVbn4Sc/aE7cLpz+iBkMxkfdgq5H8nE+ZIDa2ZxO2jmN5jzB3CtIuIPMN06VCbsekjCB6eFkhbic4hRQdDj8ClVnFa7NV13GGnvbNMpC+ajBPw4KL0zujGE4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXZ2Rxug; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso647783b3a.0;
        Thu, 03 Jul 2025 20:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751598745; x=1752203545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDnxtWl5s/38sHw0j/zQjmRuBOsfROq4Q9JtcMPC9gI=;
        b=AXZ2RxugIR6Qb2n/vWLP43ZVDCRpuw6TKWbot5Xk9oM6rRtIZKYq+jnNCql7iGNXf4
         LEWiVnitHNk7HTD1s6c1aORcMgKa3Sl25u22nSBbWpX10iG3gEMAf9GFt+OXmZjh9xUA
         +TxfZRls3OO3TaoMHl9K2P9bPIIf4hLPbGgfTswNVuTXJ52VHOeEcyyyd0pWMEtkj+t6
         MRUbZWUJ0y8yfDikyrMMRluxVv2P+DEybJJtc9hCWurv8yzjjr8UoM/g5Y9QqhncGMYa
         BPG0Orege4XnVTJ3R6WXsKAAAYJOPUVwC24Ji39eccFzRM5E1LUL/GOVl7jfdjZrEFSr
         RiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751598745; x=1752203545;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDnxtWl5s/38sHw0j/zQjmRuBOsfROq4Q9JtcMPC9gI=;
        b=jX1VP56ROU2fwNIbdBc6X7pW9WL+ncWgoH6e2mdyO3md7a+MPHOuXvz5wvM3PQ0Go9
         e+hhvSB0M0PMvpXlD+2Fpx/H+CXmO01C1AzAEkVAldFbj7gMEKbKOuvfZSEGFuyLiLRF
         cHAxD7z1lAKjJ9kT5l5aF2XHkLYSCf3OzX0G3TDogH3sDHkA0HuyAG5l8FmM6w1LdCav
         9zWeh/r4/fMIX79vxVcNrewEgzR+hzXgHwDYuujCIY+KfzQiT0edphXJZNVVgaTzGDir
         5Lo1COmRZSJ4nq6ka6eoT2Rjo5yvS1+Md1jpuXxBmiUxA7c+SX559/THsW0O8dfU6WPP
         Io0A==
X-Forwarded-Encrypted: i=1; AJvYcCUi/EZ+vnnq9x4/3s2L4sS+x2wLtUTbQd60+61Y1lQAbd6BN6Hq2WWcBaT2mo6kGZ3yvRDZXpxMSpUT@vger.kernel.org, AJvYcCWGwuk12iA2mRF00hbjsqyoAB1CkEumz509eIfS2SjN6HSYrXTsWV+JtEirJxhBm1+69depvuVXHq8TIG6Eq4o=@vger.kernel.org, AJvYcCWHRms7T5rv4t9rYcKs1yhQotgOLnLl/OGS3YgLfjOuhGXqYSWlx0GPjUn5uSztqp4Z2ltaYniB5iUrzJGl@vger.kernel.org, AJvYcCWJyuvjC2KBG7KyrCThQSKaSylk27zUlJNrKKzFnWOC0a29Jmzl5aeGqP5JnV4eU4PD8tQFUQti@vger.kernel.org, AJvYcCWZ0OjewRwTtjDChJ2ubNtqRQNN7GJJPh6NV66QxXyoiWAwuFimGJQSRBaUVRhFBsk8WrrxFQ6BkkfF@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNdOOf5kSuKeRTRUEg9xlQLkW2tXHWE68jQBDND3G62WuRQuM
	VLhl+4mj2z7LHdrWJbXMrb2JVqRK3gOtG0vRVzhD7VuxyvB2itv1WZyB
X-Gm-Gg: ASbGncsBZHu5a8ze6sNuvdw971xOgKff7XJlfVYpNUPGoF8A39aPGxxknzOWYklz2ew
	1PYddKtYniG9ugej4+kFcCVG/tU3PDtZ8qzZErtfgnZxs2KvApGC9gIon70Adei3uMhCxtT9DK8
	0jWqPQs7zCucbpro6sNm0imDPvbTV7Kv1Mt7Xp+I3v0qYck3hrRUYugIKS5SW/JDKx7sPMab783
	i292eLsnuGsPtZZ+vVmGcEj4LwQS1dLvlmMsBiwr3eeRqqXKBsqDKDp2iOpdNojFoX+93T3N6Nq
	aAWuzLsEbjdkg7RFyFbomq6MAD3UPgPdFyX/tZ1Vc0MO0h4H1jFx56uojoJdoL2NzW6Z86BgYuN
	L+LViRKASHnVC6vRMNto9hdyQRGHiLUJ1R3sA/jtc
X-Google-Smtp-Source: AGHT+IGsyFjekenVPYCtS93mzSmCbDC/+mZ2vHpqBkN8bjtYSY2xjBOBoLm6ohoEPg7/g649OEgPBw==
X-Received: by 2002:a05:6a20:2583:b0:21f:54f0:3b84 with SMTP id adf61e73a8af0-2260b96873fmr609171637.35.1751598745078;
        Thu, 03 Jul 2025 20:12:25 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm863165b3a.136.2025.07.03.20.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 20:12:24 -0700 (PDT)
Date: Fri, 04 Jul 2025 12:12:08 +0900 (JST)
Message-Id: <20250704.121208.1554239479866226095.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com,
 gregkh@linuxfoundation.org, ojeda@kernel.org, rafael@kernel.org,
 robh@kernel.org, saravanak@google.com, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v2 1/3] rust: device_id: split out index support into a
 separate trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aGckCY3BiPRCPmS7@pollux>
References: <20250701141252.600113-1-fujita.tomonori@gmail.com>
	<20250701141252.600113-2-fujita.tomonori@gmail.com>
	<aGckCY3BiPRCPmS7@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 02:44:57 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On Tue, Jul 01, 2025 at 11:12:50PM +0900, FUJITA Tomonori wrote:
>> +// SAFETY:
>> +// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
> 
> Here and for a few other occurances, this doesn't need to be a list, since it's
> just a single item.

Indeed, fixed all the places.


>> +/// Extension trait for [`RawDeviceId`] for devices that embed an index or context value.
>> +///
>> +/// This is typically used when the device ID struct includes a field like `driver_data`
>> +/// that is used to store a pointer-sized value (e.g., an index or context pointer).
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers must ensure that:
>> +///   - `DRIVER_DATA_OFFSET` is the correct offset (in bytes) to the context/data field (e.g., the
>> +///     `driver_data` field) within the raw device ID structure. This field must be correctly sized
>> +///     to hold a `usize`.
>> +///
>> +///     Ideally, the data should ideally be added during `Self` to `RawType` conversion,
> 
> Remove one of the duplicate "ideally".

Oops, removed.


>> +///     but there's currently no way to do it when using traits in const.
>> +///
>> +///   - The `index` method must return the value stored at the location specified
>> +///     by `DRIVER_DATA_OFFSET`, assuming `self` is layout-compatible with `RawType`.
> 
> I think technically this safety requirement isn't needed.

Ah, you're right. I'll remove it.


> With this:
> 
> 	Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks a lot!


