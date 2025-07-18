Return-Path: <linux-pci+bounces-32545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5FB0A90A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2824E02B9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BF22E5433;
	Fri, 18 Jul 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbIM/55y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4472E62DD;
	Fri, 18 Jul 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858380; cv=none; b=s0CrbXx34NaYfhlJ17E1hv5hSJDMhDN2Bmg9DDl493EAPcZY/bF9EpvaLbwRa4gcnmwOHphaWMc/up9i5IkUYVlBvYN2Anik1zOh1YLNg7zwKPqT1CigH2tUh4ucwaAV+gfFUy+gVpQrju9HWHjxiffvgifON2hVsM2m5XiDXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858380; c=relaxed/simple;
	bh=sAiFv8iquaHtGfljmiJ54krfMzwWV8IkDmxHe7iDwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVaYzVVSk8hYvcEzV6kexA3IkS2uIfq6KbycOQFiCkDTmuHHdVBAKkPe/MrNxWZSGpiitwEA1+6MdKO+FleEnOcvx7B2a2fA1L3odXH+k80r4rvbt8tjgVrxTV6Glrf9NTcZy/BFQVs7gpRG0WCBjv87TLtscsA5n+MfJA0MUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbIM/55y; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so1072727241.1;
        Fri, 18 Jul 2025 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752858378; x=1753463178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JODog4W99P7CS8ZRV6Zf5jfAFaFc/53al1khJwbmT8A=;
        b=GbIM/55yfNqI/39Tf3oudB1XNqudoSFE5Kiea3uZVk7WG6Zxe/FSDzYAzJcscxZ+qc
         akGCO0Q/Nghzh9qG15J08gfD2OtCep8jX02AyunDvsaNDyL/Ka7ymRY/ghFPotTdP651
         7eLAtKjOffnRl7C6u6STYG1uxXCA/WtrzI4jheariGIwGQNJlnPOA2ZKAVur3EyevtyN
         VpDBLX3rBf46rg1wasM/aWbksAU/QEk+eFGAYcVGStggPYUfLO4Rh4LC56PgbamIWcTM
         fLDFcdWU9dt8JS3leICZPDERtUgHhhMMW3MaPhJNgis1Z3uABKcRgoOxyONKHJ61dTcZ
         u51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752858378; x=1753463178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JODog4W99P7CS8ZRV6Zf5jfAFaFc/53al1khJwbmT8A=;
        b=PLONOjKZX+cA41nGfQvKy2Q1UfG/mb43iOONP1Xvpwo2ko5QeEqtSUDAGYI54BLZ2s
         Zi9bLm2zOGKEgn1wj91ky934e4G/ixEhQRMwxCukU4CSDeNIy1iJxpnrutDhHGzgm5KR
         QH8W6kmN1biAEG/EhHQsbFSzQ/Z+u5MqEWP5kYTJnq8T7K7/7t5sSeKcVncnK/gqJjAb
         Q2tI7xPy6lVS/Su2TGzxYD+cWq3iPkpnEl8iOMotyvz8YoxxJUw4071i/C7+UOf8/2+X
         4dO6Gi1tn+kxB/BOGEjKkXVVs6wul6bf6tUP6ow1YAVX4VNvzYiN4IefRJsHjnA0RHu1
         t2pw==
X-Forwarded-Encrypted: i=1; AJvYcCUKxtnqTC0E8VSM3DZpES1QwaYWP/HYuj6UEWLEncg3GXYuFIlU6r51mKU2Nwl2u9+Hn24bDJKbfAMkODI=@vger.kernel.org, AJvYcCV5zWNycBaL8PcziDHdv0uhHFqErCDybqK8GqU/XMd0VajGrbgLHcl9tM+/gMlWML5ABtzYuNpv45Qk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VMeWq76OechRHuDyOa3C+rYfnw42+Avh6KqLySiVucUo58am
	JkqCo82V5GB4un6T7L0b8XSQkCbaLpGKK7yeMGr1qt95FTqQxYcJ5JGJ
X-Gm-Gg: ASbGnculTtM5oJyGbH2N+J1cyoDgbB9KogTaLRbT1A1SagSYzCXtY8HJ7qZ7xMK9CJ5
	y6JlyrZHjybEgEbau9yqJ37kQ01vSD5Lz5Tdh5bxbktwWWeMPc5Ez8LXId0BSpFcYf3SHO7EJ6W
	z4dQjwNPWYSggNiQZaKzeavhQV3YZVcx4oU0eGWEsA3bz3kMliALSFFtF5u1CytpQsXGgx91vSO
	+Rx8VmwpXklLItnKkQzSwrRjDLqnqikO4bHgAhl403I51CqmS91ADGyY7skbtPVheUeSk8ogfTM
	+N8Mt+WUC3OCggYexVLzBgKjWn7K5uRL4JD1n8F13ZT23VtR4fvCXdHlZERXCBrcXVr1Q66Xzvd
	62ViGZSzJbA==
X-Google-Smtp-Source: AGHT+IHLlDQix1yjP8AWd2tUqC/hSHZ26YyE8eCcJfbFHbJgwOfqTSR7MAKzgkxm2sVR4SNzi9k28Q==
X-Received: by 2002:a05:6102:8027:b0:4e7:c14c:9e30 with SMTP id ada2fe7eead31-4f998126d21mr4372502137.21.1752858377696;
        Fri, 18 Jul 2025 10:06:17 -0700 (PDT)
Received: from geday ([2804:7f2:800b:45e8::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9acdbb99bsm608794137.2.2025.07.18.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:06:17 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:06:08 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aHp_APHDTFqc7wOL@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
 <aHnAcbXuFqcMXy_5@geday>
 <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>

On Fri, Jul 18, 2025 at 11:46:33AM +0800, Shawn Lin wrote:
> 在 2025/07/18 星期五 11:33, Geraldo Nascimento 写道:
> > On Fri, Jul 18, 2025 at 09:55:42AM +0800, Shawn Lin wrote:
> >> Could you help tried this?
> >> [1] apply your patch 3 first
> > 
> > Sure, I'm always open for testing, but could you clarify the patch 3
> > part? AFAIK this series of mine only has 2 patches, so I'm a little
> > confused about exactly which patch to apply as a preliminary step.
> 
> Patch 3 refers to "arm64: dts: rockchip: drop PCIe 3v3 always-on and
> boot-on" which let kernel fully controller the power in case firmware
> did it in advanced.

Hi Shawn,

I tested your patch but unfortunately it does not work, PM981a SSD "plays
dead" and 2.5 GT/s training never completes, even with the bigger
timeout.

I hope you get the chance to test my patch soon, because once you share
your results there could be two possible scenarios:

1) Patch does not alleviate problem for you:
   If this is the case, then there's little I can do further and this
   becomes a wild goose chase, so no chance of upstreaming anything and
   I'll just move on to more useful work and leave everybody else to do
   their useful work too.

2) Patch works and previously non-working SSD is now working:
   In this case there's something serious going on and it is our mission
   to find a way to correctly upstream a fix.

Thanks,
Geraldo Nascimento

