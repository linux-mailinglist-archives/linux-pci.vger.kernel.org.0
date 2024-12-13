Return-Path: <linux-pci+bounces-18357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302069F0529
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 08:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E201886B48
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A0187325;
	Fri, 13 Dec 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWHuvmh1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275C1372;
	Fri, 13 Dec 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073580; cv=none; b=BthLqh2yXwYO/yehbwAAen7XrVjEMzTntbzMM/uazQk2WYnuR+ubsSp5DeHDSdiKFjleXgVJITI2kD+d86CFBCeTBUfy4UxO8pOXVOv7rl1sbZl/LsVBlc9xYGiV8R1e8zYPrT/CVC7sH2vITGAA2mOBgZ61lVjB4we4d3f6iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073580; c=relaxed/simple;
	bh=9XnvVYl+YZ24uJZB1nNo0oLCc3tEoJXLzFdrQlqruV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1gIoYbqhR7Ii+Fb0jt/pGLZOvnXJwSFgjd5rGDT2xESSeM3mNc1ygaVEcBkY2X7U/ovUyvfTmS/uLNzWhPo7BwdHp0zyw6NWqSqEXMjuAhmAVFNY2Sh55U05k4VdTIZNAnNBnEGlJhHVXND120NHH2CVo/br+sRN13yXmzWkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWHuvmh1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso263244766b.3;
        Thu, 12 Dec 2024 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734073575; x=1734678375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxrQwrMDRX39hUvqMvsuz8UTw88tsq0nhYKLS4FpEXc=;
        b=GWHuvmh1RUdZHF1XGUijnMqCz0CupU/mH/bHmbUSdXx3plUIShWnIvtKIhWg06l/3p
         4jjOE8QkB12IDLY5IFrMiWnN36r1r2VCHm0dMJJooKKk8rFW+VSmln8RB4nipD07US+k
         KxZjBjbSgH9RBlvrn6ZNiP2yDBrqOaSzKpy47mYpKqs7o2+g3mNBrw6kVU36WrZe61ww
         rCuiZ2qGJGP4tHRMJn3HYPys4lXbPlfX8SzW8pREYSxvE4Gp7270dfgOQ9H3xHz5/fpS
         BPIUGa9vbAjnvnEuBUuJndRqUOraPN9JJeAAeCIDf6QfVJFFvErYmCqARyY0g8VUyy3C
         QOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734073575; x=1734678375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxrQwrMDRX39hUvqMvsuz8UTw88tsq0nhYKLS4FpEXc=;
        b=Vhp3PLeRzJYTB0YVutNkRAjYV/FDaMBN4P3gTmyPBDj5BGxxADO10PBSQT/BH+X5XE
         123mJpl6T5sNV4RJmFXH17zaeiUqYUnvQvmJHB+XEoSypha9FbQfmXkwqSvG1xMwqZv3
         yVeY47UsFA4wLnstMS7s3+PIGvmVV4QfacA14tZJDuI9oYl6JWSt3IhJdz4JHtn/3wJs
         Tb+avWJ9sjPP3D7jpUIQE4gDx7GG98cz+N9ji7orU1QuLU+F8ZIj3MqR76FgAzPWUKsJ
         5Hyq8/PnBuc0zRBeevXChLEau6sc0BZYk5Ucwe4otjPwVfrWxtRdVBCsoXpTLcQdsz19
         wg6w==
X-Forwarded-Encrypted: i=1; AJvYcCU0NSTGBUksVKxgtaBZLvl+S9PiOD1x9HFvu/nlw5y/OsO6frEV4EDrXOs2uueDXDOpLUf+@vger.kernel.org, AJvYcCVQAiUBT6xkDcPdDhXEph+6bbZ6+uwsSn2fp2MJKSKgPkrLwG0wvzbjTBeV5duFIM7680P8Eid+ffNs@vger.kernel.org, AJvYcCVo60E2Lj8oD73OwEZkIhYSOWbbC0B/Hx7mF/t9j0an8eJgwML2k6s2baI8PdYG9DPB4bEEuq2QnqNNGlMQ@vger.kernel.org, AJvYcCXtctm6F//BoL9A04NE5tK+poqKLpwzZIDfinqerYprNH3Yu7zRwW0mEqtdjpuvTKrWzvsuCUQEpfD0@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjrNwzos72EJfJDSe4ZWEx0te7g1fYQBX81f0WFLp53SCA0WI
	LtQBaGyz115I7Pmo/tieU+B6J8N33rcqPcZAFpL5UKWXk6N7yzuH
X-Gm-Gg: ASbGnctXwUdW2VnoaBtTfUCyeZMcNgnV5myvBQu2jKbyuKHRW4KmDyMEKVX3/aZ20LC
	uZ78bG/v8SIMwBS2H45C36S0cw8H80fCzIGIn4NrPDyNSl3vbKusdPxY29Of973qZWUJhdICeJC
	9fhXBHtkUdH2gxoT5X7asI699niF0dFLlYhvHtBcVkXKCDkhIwyVuZrPQA42JkpWyFRM0vGFV81
	7CTJMj1cEkmhtj/+B9QUzrBNbq4J0mcXaNvUXXj/cLpdoy/SHahEdnbTsPGyNQWroVj4umueAXr
	iBc0IKsdu5k228FC2ena68r0p9wKK2OExQsV0AY0m06vYF8EMotpOTzajqdFZr+FMnMs6Em/Csi
	BawChY2cuTIAE
X-Google-Smtp-Source: AGHT+IHFJ+kRGpSorLtHc8TbJrTe4EAI6jr1TsoG5rRi6v2qDv0r5gf2yVynewdjhGrIVYCgXoTJJg==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:1295 with SMTP id a640c23a62f3a-aab778d9d9cmr155786966b.5.1734073575257;
        Thu, 12 Dec 2024 23:06:15 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:9583:b351:67da:b15e? (p200300dfbf0db4009583b35167dab15e.dip0.t-ipconnect.de. [2003:df:bf0d:b400:9583:b351:67da:b15e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa685b6cf77sm687526266b.83.2024.12.12.23.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 23:06:14 -0800 (PST)
Message-ID: <00dd07c9-21a6-4515-9b62-351c6aff2d1b@gmail.com>
Date: Fri, 13 Dec 2024 08:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] Device / Driver PCI / Platform Rust abstractions
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
References: <20241212163357.35934-1-dakr@kernel.org>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.12.24 17:33, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platform bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> The patches of this series can also be [7], [8] and [9].

With v6.13-rc2 and Fabien's regmap/regulator/I2C on top I gave it a
try on x86 with qemu. Additionally cross compiled for arm64 and will
try it on real hardware once I have it available. But previous
versions of this series have been fine on that, already. No issues
observed for running the samples and for the examples/KUnit. So:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Many thanks!

Dirk

