Return-Path: <linux-pci+bounces-35517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79CB4511A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF38E7ADCDF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549813E898;
	Fri,  5 Sep 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqH1H+KC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64B26E717
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060208; cv=none; b=FLO7O8rDPciUKHzlGXDLpy1THBXlEYceiJ5xqp0EB9ua4ILmTFve25FA7J38gRyolbks1TUvPCIAbK3skKceyGNyEGcaRb5cK2tMUqOw8QW0Z5RWv4QwMbaFLcUdO1YKFyJamIUtnj6EGvGZycYbBmCOnUWrUgF9BNtw72iN7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060208; c=relaxed/simple;
	bh=r34BaPjjnAxEk0pYZF1gJK7z2l/adNB3vzB+6aApLLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CABf7Ongzlz6YI7NsVehajKrxkoZu6upriwCpzRIc/n/odnuymEpP6RpFO0Q1z7Ybi0XjA/eufxWlo0gY/tMlTIW1t5Knykg9zFNkEsLHV0aFNqspA6wnx/QMrfJm0W5u8KAsI4ruCx0ii/y1AME+/tyPzbIi/AzqxrdOgSQOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VqH1H+KC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70fa1287cffso707406d6.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2025 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060205; x=1757665005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=VqH1H+KCUWU4657PsFvLhiEzB1qE8Kz5Dc0tHJuwxVRlG3AKc1tco7REkHb2AllmsU
         GDaOX8YedV7ETQmapML4qR5fmjrv5FkeodrmTA5FLt7PGQArdFI+howebmZIuatxcZQt
         4IoRmgG0D8pubpRF69bml6Rs6kyk8KDREK9GerWjncrSWLJwfm6RHvXpdNLeFQoMJWUL
         nKqOwQoaBII1A0r2HBlr6MwrIfZnxs+jtTXz+x/HLdnTA2GvAo25Ucao+iDqA0XDTYtH
         FHU/8A9qbWGX2nWFUNeBeeYYk3FAMaaRQbmfF+D5pQbsYq5BkN7bAQV66orOPlVadfSF
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060205; x=1757665005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=p4arpEpbnP5xH8nmYjCIlZAe+qpdICX8kqXIXAs359Fcs2hBHqCW/0vdeIOGfeHldp
         RxIofCM5WxswVD8BVo7mUGgHOufBK8IqpO7soQBtw/ECr56fW3+I5WoQmKUwhx+AY1Xw
         U4vcN3/qeSogcKbvl53/aY/rk+Bag+AShfBuCRv9Yjz/40zb4sYJl/3oHgy/shWHmfsu
         XW+zZpdakPU/xWgC9NSb8jPBcaV3QcM2NYSF1Dblm0m4b1AR5ADOwyQVOGQAZew+TII9
         EOCnLEtWZ1j7NqGwF3nwnqKyUguGxcyDe6u0/OXqk/IMsMtpc+G7zkF2ctWLV+yRtROe
         DR3A==
X-Forwarded-Encrypted: i=1; AJvYcCXXRfuB6CayY4Z3xbC5MNdp6PWbobJ7DcpTKM0QmQ4j0LHRUEdW8L2wciJwW/CK2uOSijVX/3i/SXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdFTEzB1acqhyf3+l96PkdsWpB5IsbYqodKM2MXAPsefJJmBxE
	GSH+mtwZZv8TJvFp3Q+go/LYW5GRpcXTkfLBVLTMJxFm9BUOwffeYoZz3ONl12ucSex+MDkbA33
	n+UhsITYNLHZKZh0shx2EAHmXETVbONxZwy9kyh6CgQ==
X-Gm-Gg: ASbGncsedwSArAcJN68X3TxVBAf7NKxgXKky4TasQ/VBYbdWSjJtIYJUPmmvWSqrWl6
	CGxmPcb7w8pxt6p2tewSxdO/OpDOG0ZNsuw24SvaFnnY1eBvcFE2I9hNpe0SNUqwjn+ylkbrHni
	/7CCimTv3eJPPSFFjPsdfgj9arOlRUMDmNZtPi6HGmJnYVuxd+/vBfRMhr7qcexmNpfzcvQFCLg
	82wFfBVjgX9ZySzH6Vp2gNA41NL3bT19ICnJw==
X-Google-Smtp-Source: AGHT+IG1/H0XgF1Z0mVwgA+Hm/3Z8WnWU7aR5gwqaxhSAw9EmueUjpEcG/rJ6rBmj73ByYwqulnJNifibNyClBj0MK0=
X-Received: by 2002:a05:6214:4405:b0:72f:27de:9443 with SMTP id
 6a1803df08f44-72f27deb20bmr6495506d6.0.1757060205056; Fri, 05 Sep 2025
 01:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905052836.work.425-kees@kernel.org>
In-Reply-To: <20250905052836.work.425-kees@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 5 Sep 2025 10:16:33 +0200
X-Gm-Features: Ac12FXxXBCiJZ6j6Q-_OR5jc0zqm4NYxAPnOlmCg3M0Qu-SVhJpAaiy5I8LGFng
Message-ID: <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
To: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 07:28, Kees Cook <kees@kernel.org> wrote:
>
> After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations"), which allows GCC's value range tracker
> to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> "ffs(rq) - 8" used here:
>
>         v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>
> could wrap below 0, leading to a very large value, which would be out of
> range for the FIELD_PREP() usage:
>
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> ...
> drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>       ^~~~~~~~~~
>
> If the result of the ffs() is bounds checked before being used in
> FIELD_PREP(), the value tracker seems happy again. :)
>
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: lkft-triage@lists.linaro.org
> Cc: Linux Regressions <regressions@lists.linux.dev>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ben Copeland <benjamin.copeland@linaro.org>
> Cc: <lkft-triage@lists.linaro.org>
> Cc: <linux-pci@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..005b92e6585e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>         u16 v;
>         int ret;
> +       unsigned int firstbit;
>         struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>
>         if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>                         rq = mps;
>         }
>
> -       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +       firstbit = ffs(rq);
> +       if (firstbit < 8)
> +               return -EINVAL;
> +       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);

Hi Kees,

Thank you for looking into this.

These warnings are not a one time thing.  the later versions of gcc
can figure it
out that firstbit is at least 8 based on the "rq < 128" (i guess), so
we're adding
bogus code.  maybe we should just disable the check for gcc-8.

Maybe something like this:

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 5355f8f806a9..4716025c98c7 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -65,9 +65,20 @@
                BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
                                 _pfx "mask is not constant");          \
                BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
-               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
-                                ~((_mask) >> __bf_shf(_mask)) &        \
-                                       (0 + (_val)) : 0,               \
+               /* Value validation disabled for gcc < 9 due to
__attribute_const__ issues.
+                */ \
+               BUILD_BUG_ON_MSG(__GNUC__ >= 9 &&
__builtin_constant_p(_val) ?  \
+                                ~((_mask) >> __bf_shf(_mask)) &
         \
+                                       (0 + (_val)) : 0,
         \
                                 _pfx "value too large for the field"); \
                BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                                 __bf_cast_unsigned(_reg, ~0ull),       \

I found similar patterns with ffs and FIELD_PREP here
drivers/dma/uniphier-xdmac.c row 156 and 165
drivers/gpu/drm/i915/display/intel_cursor_regs.h row 17

Cheers,
Anders

