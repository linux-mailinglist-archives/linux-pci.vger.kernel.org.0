Return-Path: <linux-pci+bounces-42896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11BCB31E8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799A4300D4A3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C326E719;
	Wed, 10 Dec 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVrjGYSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08735225A5B
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375818; cv=none; b=RksEYKef8adpD/thFW12czLlp9vP6Mh3Kk9z8Np87jR9JOPIxL6vUu5Dqz0fDYrCu+0csidVmul3vdl1FvQGGE+YdkPuU0ns1RizpyZFuMBk05fx+XXwvbbOxyV7Ki3Xshn4haOUmqvMbpkYvNSrKw/YHk3rYF3OBehB//8ejgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375818; c=relaxed/simple;
	bh=vC7RWNazEQw8SHO84BYOhsU+Fq47hH70Yj2HGICY+tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ix4U8AV0Ht6jt2VX8zMvJpv5CYfLTW/IbQD9dR5I7Jlij6Kf+lQLJPvixHUa2p63zjc/fzaYLPOvpkxXEVTQMpmwuejKIGwsFGvTO8ZI9UKzsSMKKrHNTUEwNf9duJjAl8jrDHPvJfsSVznEwQe2bKxp/5Edz8G1gl5EWqXnOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVrjGYSu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47789cd2083so41299775e9.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765375815; x=1765980615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sH7JNMw89euFON+lTWkqyHT9U4TKnyHQz31vhEK550c=;
        b=XVrjGYSuajhwmcdKKPl6M34sjr8SAFBSPI7f1FdkOrk7dfYKaH8sZXpLfYHGZNcuF4
         KoJyK69U9m06gOXgoS8zcgCrPZ5Nf24osNa15GBCXgv0A7pUNY5YZaetpUrkSWx7x4O0
         DA6FGWAYIeO9ZsqufK/hgOc5525GhsVYs+33XM7SGq2UOBUGSv9mJPKhZTI8Tu9LUuZd
         XfrUM6OQ3Fd1ZuGXkLWKAOTENSgxIAi+Vvbi2nX2WROWrHEyPH+xPP6tXpu4EiRwn4uz
         oi5Guro/ynfTRPN6omo7LwnZrm4d36u7erG90GMCee0IempT2e/5THVkvXclq8K4UBYr
         bpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765375815; x=1765980615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH7JNMw89euFON+lTWkqyHT9U4TKnyHQz31vhEK550c=;
        b=L+Xb0/7E6jlQzZCy2WqVzsfsNHlEHgqQ+qO0GWzuNwFulC+zMMby97om4T9hIcrE81
         35Lt0+u3lsG4piddiBFLL61iTorHQDaUQzyxDUEbwtzknhVvSIgTkl+PakLsQrJkGTSF
         w5EPSd3VoIwMVrC9XC2dB32LHx2z/89g7cDqU4+I3prfqh55lvUOj7BFTCm9e3MI33Ed
         BSdKEQr3R0vdT0sL3AroD4OKtF2DtoTkyTU8gZ5+MPctjr4QfpZMFV7hY5ITvX1EjVPC
         WjjViGSUepkqSUcppTQyW8tW09cS0Py8C8fA7igLQAIfLGmVoAjWAfjsVdIqQXdAGkOb
         d8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmLYKfBGwWeTOFcg7Jn8V3vc/GYQnMK9r8+3fQboZnRWnbqM9Drg+UNJyASQ2SbIOPt2CLF+l9oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOekCMFI2VULpPzHZpSiIJckKCU1QNis/UYaK2z5sZ/2Etj9i
	BOtfqIuFStxMOK8MjeFtYSo7VXEbCjsoVj8+/uv47IskfkLhKWm3+vjT7gExyA==
X-Gm-Gg: ASbGncsA5QDpy0II5AJ8n4Q5LAInl2rjuFNBDn7T63b1wwved9zdZ2WjXrNTqJe2z7y
	vhFtxrsYOK7JfyIhh0381ZrQMSaunUWT4R1pqdHPol0u/1kuIU8RgwW8iFCzKFcjO5Z5NMhxDaa
	RsEmR/in2Qq2AOHwD9e6F4013m3Drb/pD2Jzab98ze5EFww7MqYFnmGq1LAW1DQYm9P1MIcHjBW
	Z7/6i2N1xpv80zWCM0SNof54tLZD2UzqZQCzdi3F9u9ngBL3q8BxYPEfSiEtF6fVCXuQln+Bl2O
	Nv+m7Hon1oj3XS5qXeytWyHYSY3PvgvWRPrKy2uI3FSIAICW+xE1nKaR+GyvWrqDLMtbqUHaqo1
	nDFhlatoukVDkKLr93pGxLmjKCUXZ52iOJXbnwqq7l/jJEDBET86hZFATAJMyP123ejDCWQxVdz
	5uoOG7NcBtRy5M4WcJbdqLe/EC1SG/42ZiX3Rjd+BUYPYim622FYQXTinKxuViI0itgklsteBv+
	HWvfurRa33xauzcku9IFiRyHvUY6r8Mf2j9KqBnDkl2ww==
X-Google-Smtp-Source: AGHT+IFL4Dce+iS2AP/9BKbMr5rmVqef9MiJuRV86rp31kh7Gm6lbR3JrPFyWk/6qAOeGdT18Qg/Vw==
X-Received: by 2002:a05:600c:46d2:b0:477:429b:3b93 with SMTP id 5b1f17b1804b1-47a83843246mr27645065e9.18.1765375815135;
        Wed, 10 Dec 2025 06:10:15 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:ddf9:5fd9:1909:eb2e? (p200300dfbf2de300ddf95fd91909eb2e.dip0.t-ipconnect.de. [2003:df:bf2d:e300:ddf9:5fd9:1909:eb2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3532e7sm48107705e9.1.2025.12.10.06.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 06:10:14 -0800 (PST)
Message-ID: <cac484ba-904b-447d-b802-3e324c843ffe@gmail.com>
Date: Wed, 10 Dec 2025 15:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] samples: rust: fix endianness issue in
 rust_driver_pci
To: Marko Turk <mt@markoturk.info>, dakr@kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, miguel.ojeda.sandonis@gmail.com,
 dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251210112503.62925-1-mt@markoturk.info>
 <20251210112503.62925-2-mt@markoturk.info>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20251210112503.62925-2-mt@markoturk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.12.25 12:25, Marko Turk wrote:
> MMIO backend of PCI Bar always assumes little-endian devices and
> will convert to CPU endianness automatically. Remove the u32::from_le
> conversion which would cause a bug on big-endian machines.
> 
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
> ---
>  samples/rust/rust_driver_pci.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> index 5823787bea8e..fa677991a5c4 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -48,7 +48,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
>          // Select the test.
>          bar.write8(index.0, Regs::TEST);
>  
> -        let offset = u32::from_le(bar.read32(Regs::OFFSET)) as usize;
> +        let offset = bar.read32(Regs::OFFSET) as usize;

Yes, dropping from_le() is what we talked about:

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk

P.S.: I'm not sure if the `Fixes` is required: As far as I understood
there are no big-endian machines supported by Rust, yet. On all other
supported little-endian machines this is a no-op. So I think it is at
least debatable if this is a "bug" which needs back porting.


