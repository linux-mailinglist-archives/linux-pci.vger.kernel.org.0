Return-Path: <linux-pci+bounces-32067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DEB03F21
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047B77A7DAD
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D3A1F873B;
	Mon, 14 Jul 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN0Vtiif"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC121E0E1A;
	Mon, 14 Jul 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498054; cv=none; b=B7Tz+e04teDyIXYrdhCjM79iezdMy4GmuL5d9D19pdY17HAZhUEm3iUSiTHVoe5GkU1tafYGwMzh3iko/INgAHBCRfXSa/nNsnWi8lU7FYXL2DrUWKbfOGT5rt8IoDb3ZfgH7wutUFx4DCI3ReT9shXlvw/HVMFu8B1GcUfQO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498054; c=relaxed/simple;
	bh=FhLzUPV+IQhuUV+99nvb8u2NjykX+6qBCI/EG/1mVy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U92AwnCvrF1jerwpwkOoAvOOZS4JkU1fl0hnGCyBAka8/PeFC8wNZ3hdmCn1D2vHqWa6A03GU6Ik/PQgC/a5g33PZdZZrl9tN7wcwzQYMEk9iBIfkD4mlzo8XPj7zENiTKmRSiPjqYhRJv48X2AGDVPl5pS8BkJ3kyahicKA7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN0Vtiif; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so35295341fa.1;
        Mon, 14 Jul 2025 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752498050; x=1753102850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQiKdw9EJHBJEChtzsNJX2kS4onV5OIHRGBDY+aFSqQ=;
        b=UN0VtiifPrDrszPffu4fv2H4GKB4yVd4IZgvGZuPE06bCavLv2Dgf7IlSCxPG49WMs
         3P7RZ5oSeDCkomhaox+PAYMCtXi00ewRinjrVfZ0LABRLrjH02Q6P1J8zvIIC1flfu2r
         KWzgqfsP14OWmg4PUEpTJShwbb3E+nNbpOnxGSI4+v022B1Rlh+mQ7H4OiINXwSySEk8
         TnIl5at+OPX8pH23U3308C+tsWZowTMJ/ft/4jcBo7selX22/WJ665GevkbzldObMWHW
         JJepLfX5frB8J2SJj0oYFJ2neD9zoqNVZp+QHj7i18nGGF9nV+OoDVpxuSxkH6DPTH4F
         StKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752498050; x=1753102850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQiKdw9EJHBJEChtzsNJX2kS4onV5OIHRGBDY+aFSqQ=;
        b=ftmenAlKwTpNdqeCMXgISMe6jYjRrSSoxL6Wy8wdmLzbKExx5exj5uxrjmgVjusnUe
         4mAV+cPmGWrNOdfOKO0KFSH1/Elr11gs8s5kVdZTJMqbTpsHCD+NW/rzYo6ZKo64nEJu
         sTFe4QpsXLGPH6wmEcggyqoAnsYAXx0Wcr+lgkPUr9UDTnGDOXyi6mmgI0mee8w3htIf
         dzt6CEzEDOYZPuQyprn/aJabgGcs5kdA1TRkCwc2aQDewQ+yEZj5nq3170ova6vSTFbp
         l0UED9Rgf9MogDTCg42EMY2COkyX179pJ6jPzU9G/7hANqrMuFZqftUeejzvdb2Pc54R
         HkJg==
X-Forwarded-Encrypted: i=1; AJvYcCXUmjmtrp/bp1GIR0KC/8NgoAf9b6irUKmDJ62SYjFc01yvqxBQjt8OYBQv8vC1YeGdWoRdf2dT6MmA3gU=@vger.kernel.org, AJvYcCXyvuavvoiWqfyoTZG3iUKrp4xZy0qu9E55YgkHiCAXY3vMFa7cg2CkhVfVtSR8mbd0R3PwyV6qzrtf@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQnMrKwhJjzm/VLyXnen1zHexWWlK3xqq8ooa1cbitlqtzpFY
	g9XlqrHJzRPZLiA2dar4vQWlk37J9oP9dbCXNmt8HI5Ylj97FBpjH9oa
X-Gm-Gg: ASbGncvYYi6kDx7Cy/kspDVfgbJ7/xzbEkTvlpwSqtpM0diH0XY+5Ru1wmrkLWBg5iC
	kgjQAbVeSCU3CtyIUQ1KEDPLzngfec2N3XsyQVCOknRxMf+6xf8zR3sXUCg2LN5yt8ZgyJHsn7g
	Mh3QvLZRj6khp+Ervhdro3l0isKBzGzk5/8Knxig7FiV35BwEjTwKC3hpfImnAEYsRq2ef1OiaU
	avIwd0bBUsz7m1pEXj9jtPZyvMqlhF9l1vNqZ7CgTCmmvol+a4irhcgxzIerIExDC1a8K6DIWE3
	JpVN0QdF9/Y7VzjbGVZQb5ZCPsrR7fzg+Kmvv2TjOuzHh19+hEJsOO47PmrRroTUTx1+tOFeiyL
	Foq4MjnRr7iTmEOXx1C+/C5tWXpJrG0BvWjqBpLbmY5s8raKwrL2eihj6saRcP/zXA4SjAdIeWH
	Hvts1s+m3EhqGDKlriGbmsYKF7JBlB7pppOi/qq4rjkTyglsMJUecbc/A=
X-Google-Smtp-Source: AGHT+IGRqXbDscGbqk1WtvSf+4EphHRV0CYH3BgplAP9nszGXadN2LS9nFQvxlFnZ0mP8NFTPKKZMQ==
X-Received: by 2002:a2e:a556:0:b0:32b:755e:6cc7 with SMTP id 38308e7fff4ca-330534992e0mr45910221fa.28.1752498049539;
        Mon, 14 Jul 2025 06:00:49 -0700 (PDT)
Received: from ?IPV6:2001:999:698:624f:40f1:7eae:1c43:b112? (n74gsrcc1ueyaetveoi-1.v6.elisa-mobile.fi. [2001:999:698:624f:40f1:7eae:1c43:b112])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8bf2d6sm14811461fa.52.2025.07.14.06.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:00:48 -0700 (PDT)
Message-ID: <85d071e3-d66c-4ed0-b9ae-fdeee1d43ce9@gmail.com>
Date: Mon, 14 Jul 2025 16:00:46 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] dma::Device trait and DMA mask
To: Danilo Krummrich <dakr@kernel.org>, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, bhelgaas@google.com, kwilczynski@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710194556.62605-1-dakr@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20250710194556.62605-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for completing this missing feature!

I've looked it into detail, and for patches 1, 2, and 5:

Reviewed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

On 7/10/25 22:45, Danilo Krummrich wrote:
> This patch series adds the dma::Device trait to be implemented by bus devices on
> DMA capable busses.
> 
> The dma::Device trait implements methods to set the DMA mask for for such
> devices.
> 
> The first two bus devices implementing the trait are PCI and platform.
> 
> Unfortunately, the DMA mask setters have to be unsafe for now, since, with
> reasonable effort, we can't prevent drivers from data races writing and reading
> the DMA mask fields concurrently (see also [1]).
> 
> Link: https://lore.kernel.org/lkml/DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org/ [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/dma-mask
> 
> Danilo Krummrich (5):
>    rust: dma: implement `dma::Device` trait
>    rust: dma: add DMA addressing capabilities
>    rust: pci: implement the `dma::Device` trait
>    rust: platform: implement the `dma::Device` trait
>    rust: samples: dma: set DMA mask
> 
>   rust/helpers/dma.c       |  5 +++
>   rust/kernel/dma.rs       | 95 +++++++++++++++++++++++++++++++++++++---
>   rust/kernel/pci.rs       |  2 +
>   rust/kernel/platform.rs  |  2 +
>   samples/rust/rust_dma.rs | 12 ++++-
>   5 files changed, 109 insertions(+), 7 deletions(-)
> 
> 
> base-commit: d49ac7744f578bcc8708a845cce24d3b91f86260

