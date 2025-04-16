Return-Path: <linux-pci+bounces-26006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A7A9077F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B05D44638F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B75207E13;
	Wed, 16 Apr 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyQ5rcNy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EA205AA3;
	Wed, 16 Apr 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816642; cv=none; b=SSc8XuzBEJiNe3JQcqnHWOleKRvqclyBgUd53eOdabW97Z4XRjX4m1pi11MkaKe8S+YW52gQnc0tkL0zRISopq+buhTw15o9IYwTMF1Bs8oV7PBGt3UArtIzkTLkPqkaB3RlWscOAoBkxMqlChDteGeXbiVfMKE8q77H3+gyGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816642; c=relaxed/simple;
	bh=9/GhjcJ47P8IZH0HYzjQb3qFn9G+CKEAeeyF1Wch56A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgqeNGKW5XZT+SMN3wJhx1wzzAabD3EQp0gZd+CUJA15Mz1siBscur84GJ0KEZ1COSDLQEJD0r9lh+nrJGuWtrIY81knd4E4g1NBgpgIim4/cR4qZyEUPSswSYTJFUixbpT+9pwFeUA7TevfrA0YQ3vXCai09GAoel5SSPIZVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyQ5rcNy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2aeada833so180631066b.0;
        Wed, 16 Apr 2025 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744816639; x=1745421439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQdIJCojQUHqrAA0lstb7hyDkWmPJd2wW5H3nOMZxn0=;
        b=SyQ5rcNyqOKoUm9ekQliIIqtu61FWxU+oZfKw9GWCaMZ4wF7ydKUEvhNuTpiaClYq+
         e2ahEQLRN4Gc+oVvPyeahsI3uNqO5PHmF9ZW29BIpDUB6BZVgWQ/ohm+1zf4I2afIH9l
         RMnc4JInD0lMJaCe4O3L726BflcAO3AOlhv+m3f/jrM9n8ENQk7Xf8cE2dLeBBnimfn9
         IjaJJZtA/ul1tPPuKPGRPRLdD1/SC/JsrWjBolHzYe5gYD6n9jXjJrIr5/GS2OUSL9o7
         DfpClCBhRY5IRoEFvJePgdviku4yKGs20kH9CGXHQtaP13vvfcUmPB4FvABSwy/y5k6h
         lCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816639; x=1745421439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQdIJCojQUHqrAA0lstb7hyDkWmPJd2wW5H3nOMZxn0=;
        b=fWyVviGl6Wju9ZSjVc0M4HhIMVrmK8MpzxqXEPhtbzkTEaIxuZcPA6SK4991NMz26j
         sij3o5Y0xTCQU9KW0eHAX6ZKxX0WbK7kS6N5hfz9w1ZNnfUDX7ffpqwqrI6h/FP3+5/D
         nez/Oo/qjnpWiEUg2gLt9ngayqBw1V3b0iUNeONUkCDsjtIvm+qIpWmUGsfe1qBarvFh
         l0fADrsqAvVFReW/4zaeYe6byXiiOrniRzGgMDtK3q394eeuOQekYr5RCbYG6oMYVhJi
         xDUmTUhEWuyyWPTdC+Zr9+2Xluwg14G4Dp9TPEyusJmt6qMnDxm2TVrwnlRvrmCMjZVR
         r7/A==
X-Forwarded-Encrypted: i=1; AJvYcCXCaQQ19hIF9kN3UoQ2EUmmgC3XCcRafw+QaTYoK8QEzL5Yiy4qtdPh8vbCzEgJVwrh6Ew/aoGPzjR3FHw=@vger.kernel.org, AJvYcCXtKfjX8eGEGxdWTMsQuVrWCKTHPsjRmgdSGB2+BrLM4RJyFuD0RJqh9Yv9Td7E/wAADmywjZK5N0b+@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDDfFe2ORksTXWvfZhnlQKnuVbXHN+5vYf2mVUqdIOt3UXNA8
	CI0d8YFi/t+UbGh4NFDPbgRPqcwh70CHTMuC60DrdWcTUytgxQou
X-Gm-Gg: ASbGncvTOkWO3ywoipXqNnRyK8Tsnjh2mGIOAySGJ4fFoJPZoAnBvhze8c5yGaTlhs8
	rtcHXVWYafJHercXppfCG4rgty7zFqClFdY1BXmEt0Q/cZkQO6+gMNxhzry+8KC1VRJSIMLCABl
	o0uUSYqxt8w3D1g39uZ0kEGM4LSXED88gBnG1Msm9PSEge5v2ZR1iqOuA0LAyqvmvt5Vs/DEv1E
	iKheqpde2XeT6Ia4b2LY0FbrzkXGrFcbhudRAZ6CgAch6r9QTKmRxKsm5lgE/ddEDm56i9sNwFl
	nES2hGsNmxon3rvGDUmiPFoW/y1cjPnmDJKauUvln01WpPuaouKb7w==
X-Google-Smtp-Source: AGHT+IE1VY+Y5KZabSexHn7PP+IiCesKmvJlMHRfxBn5atZjZ3H5Jr3O/t0n5jt2JZ0a1wYjwJhlFg==
X-Received: by 2002:a17:907:720c:b0:ac6:f5b5:36e0 with SMTP id a640c23a62f3a-acb428a108dmr225373766b.19.1744816638767;
        Wed, 16 Apr 2025 08:17:18 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d1cea1fsm141884966b.139.2025.04.16.08.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:17:18 -0700 (PDT)
Message-ID: <9539168c-2ca0-4b74-9a70-24bb84babafe@gmail.com>
Date: Wed, 16 Apr 2025 17:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rust: list: simplify macro capture
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
 <20250409-list-no-offset-v2-1-0bab7e3c9fd8@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-1-0bab7e3c9fd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.04.25 4:51 PM, Tamir Duberstein wrote:
> Avoid manually capturing generics; use `ty` to capture the whole type
> instead.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

