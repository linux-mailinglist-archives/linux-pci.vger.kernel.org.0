Return-Path: <linux-pci+bounces-31443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A99AF8083
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C063AEE5B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529401A073F;
	Thu,  3 Jul 2025 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1BH5q6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709716F841;
	Thu,  3 Jul 2025 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568553; cv=none; b=EWt/L2hHAfNBpHd7qrEK5pLjSwwa31I4eeNyEybDEGzbc059sesUbH66Nh8EaBc6Ot2H1Fwz0OBCpAZrJbMcHUcNbiQiLbNybcnZVIETH0DYNw3GEFUCFr5R8XmUxcVbB5GVVHd+pQzyXdLCIw2+00dIW7jAye/jQGBRl2REctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568553; c=relaxed/simple;
	bh=jn3wxtS88ko9VuMGoaNRGohaM/J76C7T2/Cdnu6qOq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIOXxiRyAIYbj9nlZVmeRDP7+spV0RSxwjSmEj6kmKJrxWBbMwFsEZCwQAaSyPo2bCNEFBNKOlKBWiIdJ/St+nhU7sfL1pci7I32Nu9CEMRF2+rrjukd+SaQeBtuaX0JURrjK9g0NVTGVpYCbKfSLGvCe3J+YVPElEK6XLIqvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1BH5q6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A870C4CEE3;
	Thu,  3 Jul 2025 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751568552;
	bh=jn3wxtS88ko9VuMGoaNRGohaM/J76C7T2/Cdnu6qOq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R1BH5q6KrZ/BkDJPw0tGvTzBQ6y1VIhmM2mk86JquLsEvfLh0frn6KymDBootVPin
	 AJBHGobb4KPBD8MUh6uXB5OmfxmCZIY8ePUHRlI8bcp/uVWjnb+wkLXrueSrwLNB3L
	 QDQjkKKDHzKevJcvED/xP5W82QPbMsgrPIWh/50nPySl2gqP+sZGzOkGBrRR1KtoJc
	 nn2NV4qrdeOVYJ0bdMyX1LJVlQeYWOtKhQM/xB9aQl+rbokwFRgDBwiQ/kAyyDxXzz
	 rgFpiZY5IX/5YtI2lzB9KMmt4FuGT7mMzQeQokKGtEW7aXctKCO/PDI8BpP+zzvRJM
	 k1VmuSV8MrhSw==
Message-ID: <92c347d7-4b59-436e-b4ce-5941bdc42cd8@kernel.org>
Date: Thu, 3 Jul 2025 20:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>
 <022A0919-37A5-4FF0-B834-333E512EC0C6@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <022A0919-37A5-4FF0-B834-333E512EC0C6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/25 7:12 PM, Daniel Almeida wrote:
>> +/// Callbacks for an IRQ handler.
>> +pub trait Handler: Sync {
> 
> I wonder if we should require ’static here too?
> 
> Same for the Threaded trait.

You already have

	impl<T: Handler + 'static> Registration<T>

which I think this is good enough.

