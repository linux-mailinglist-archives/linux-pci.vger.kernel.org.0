Return-Path: <linux-pci+bounces-42737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BA9CAB2BB
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 09:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 589633004450
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719832D3755;
	Sun,  7 Dec 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuKZP/hr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C123C4F4
	for <linux-pci@vger.kernel.org>; Sun,  7 Dec 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765096159; cv=none; b=F2BZ0dUO3wqP7fUrmY62qwd1e4YOSef9m1vKtsVfn5TY1i9ynohImH4askl+oQ/vM3FLZMxg7/ZVDvbOq7YGYoxqLt0Fcrzq8TFrK4/vkx4+RcCyUlYYIXBx+lNQyywCgVtFUzC4QcJ5erAewKaX/G+pCqXHe9gY7PezduG/FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765096159; c=relaxed/simple;
	bh=/LR1XGcTPw/8s4MqENvx9JIq/PEmCHmXFp+zwo/6N0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPEW/E4URGJyEU5UzVT+UXCugWm1XPhvVgq8bcwhG+y7laqQCP4xEy9snmT3cZRHXa+rHHAiWY44cpaoDwEQ/vZpfKM3QGNlvT3m8Ovu6jrfzeE71S8OV/sQ8O5pcYiY8ugUFm5T4Gdze9DJfJwhCAc4fHrCd3ELzN0f1gTpQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuKZP/hr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso5683954a12.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Dec 2025 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765096156; x=1765700956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUAqt5njeLVh6MrbdJefpUGQCUq+3iNdkFktE67ektk=;
        b=OuKZP/hrqZnW6AQzguFO8INBYhQyreRn5UVf07EYzhNVbc5cwYLO2dtBAS6Kj9KQ0z
         6FGx1Ul+/g0FuymIWM/+E6f4CfFNm99PX3yHfYXoJ2rdqSoRN/NLnLLL8IKIFm7aqGi6
         QIddfpd8kJe001tSBRix4Q/1iGPMWSoddmOLg15Na9p88xW+X7sR6UZpQVpq/SIgDU6V
         UvdGNriKwMmvyM2TpNDYzlh/EqFhgNCof0sKBUSTQaAUaVUBWzRU/y34tQBBHNUd9qt0
         vERAppWNh6IxD42IyTfATiVHJjXkI1BouANUQgKjnGDPLvPz/4JbvuGFiBxI3mxSlflT
         y16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765096156; x=1765700956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUAqt5njeLVh6MrbdJefpUGQCUq+3iNdkFktE67ektk=;
        b=BaR2CRv19rnFdFpN2U52sGl7ieuUxyjdfedIZETB8E48Giuebz2tMwjQoAIezq9FH/
         eyC3Y/3e2OEwrrslzLxGHLaLYqU2uJaIoRhp1CGpfNIqZe/87Ongf95bP7jPJg39QUI8
         eVHJhmLPySvdR6FZPNZYDSySY74zFzI8AKG05tQQJyiFxatGArjHJwPK/oeGUM13BLvf
         bX0UtxY19rmLgq4BqCOWYbl6fVMhp48OeFCv5dVPqgHy2QJCPpTEm/qzbM+JSlzw4oF+
         xghVxzwIg4ElT4CAMAOw+nuOmX4EO7IJtUIlCrQbWWn6vRqK4FubjM5Vdx3SQj+bt7Mt
         14WA==
X-Forwarded-Encrypted: i=1; AJvYcCVKwD5UVq9DeKBs6H6pKuYqqXxjvPX0ujf1GXPWfX6NvABpMWdT3jM95bzlIKfCI37DCjff97f9e/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6qTw9Aq8GU5AAOXfD2bKHm1zuROv1MJfnRi4LtwjbqvfxHBA
	CRo9maoim+ADEiAQp2hjLHCevvmy0nE68cVpXuqQvhe5EjHqjlC33RoHFUL68LAd
X-Gm-Gg: ASbGncuO4my+2+jkRCT6EaON6PKS7GAnJS1QWOTDl90ldoEYhHaN+m6GsyNunuYACoV
	bs7TZsMAW53iFSHvWYMS/3NsY4QUF5O67H5KblrhizDCe2P/A+qD1KihyQ1X1bspFc5AOmUzYG5
	39fBUJL7j9r20MRuQ/3Vd8PaR9xrrxKfwgoQ/qqnRCdnzjAu1Ogi+HK0BlniGPc4YcivOgIxPyQ
	QZH4vReAq1TkMzjOKcsCqB1eO+Kj57mOWc/c/GO2SmeCGWi5yr6tFYYoyluO44H0bt4qUtbh5As
	29/3R52B8UPiNSJBY1I76RpCFDWxE4/yjTvNQlJ1AGoEP2tpJTCl+2Xes5XDcZMq4qSi+xp9iWu
	KPr7wiWJyR3bNoID38taF2yfTmCJ/ZvKdeNodMCRSNLHN3h6uRpJb4eB7R8k+0apsEdqNXPFLhI
	dUOdjBwBJqj4UXIywDvYbCX+Q285wTDnQJZk4y+/qxS33HVeQwyFwA7II/fTQmVcTX66w5FLQfH
	I6JJiSFGvQ4DuHD7zFcHG+I5Y424+ZVHhDDsePwhsg=
X-Google-Smtp-Source: AGHT+IEVqNfD63Og/iUd5redAtxSFIwiSLJ5eCxMwzhmCuXyLMf5his7H3QmVu2l6AnzMWhPzE8plg==
X-Received: by 2002:a05:600c:3b07:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47939e242f1mr45974225e9.17.1765089776787;
        Sat, 06 Dec 2025 22:42:56 -0800 (PST)
Received: from ?IPV6:2003:df:bf22:3c00:1c42:64e:ef2a:93cd? (p200300dfbf223c001c42064eef2a93cd.dip0.t-ipconnect.de. [2003:df:bf22:3c00:1c42:64e:ef2a:93cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930ca15adsm179162575e9.13.2025.12.06.22.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 22:42:56 -0800 (PST)
Message-ID: <7fe8b05d-cb49-48bd-ac0a-d993e173924c@gmail.com>
Date: Sun, 7 Dec 2025 07:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com,
 zhiwang@kernel.org
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-8-zhiw@nvidia.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20251206124208.305963-8-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.12.25 13:42, Zhi Wang wrote:
> To support the maximum vGPUs on the device that support vGPU, a larger
> WPR2 heap size is required. By setting the WPR2 heap size larger than 256MB
> the scrubber ucode image is required to scrub the FB memory before any
> other ucode image is executed.
> 
> If not, the GSP firmware hangs when booting.
> 
> When vGPU support is enabled, execute the scrubber ucode image to scrub the
> FB memory before executing any other ucode images.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/nova-core/firmware.rs        |  1 +
>  drivers/gpu/nova-core/firmware/booter.rs |  2 ++
>  drivers/gpu/nova-core/gsp/boot.rs        | 27 ++++++++++++++++++++++++
>  drivers/gpu/nova-core/regs.rs            | 11 ++++++++++
>  4 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
> index 2d2008b33fb4..5ae1ab262d57 100644
> --- a/drivers/gpu/nova-core/firmware.rs
> +++ b/drivers/gpu/nova-core/firmware.rs
> @@ -226,6 +226,7 @@ const fn make_entry_chipset(self, chipset: &str) -> Self {
>              .make_entry_file(chipset, "booter_unload")
>              .make_entry_file(chipset, "bootloader")
>              .make_entry_file(chipset, "gsp")
> +            .make_entry_file(chipset, "scrubber")
>      }
>  
>      pub(crate) const fn create(
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
> index f107f753214a..f622c9b960de 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -269,6 +269,7 @@ fn new_booter(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self>
>  
>  #[derive(Copy, Clone, Debug, PartialEq)]
>  pub(crate) enum BooterKind {
> +    Scrubber,
>      Loader,
>      #[expect(unused)]
>      Unloader,
> @@ -286,6 +287,7 @@ pub(crate) fn new(
>          bar: &Bar0,
>      ) -> Result<Self> {
>          let fw_name = match kind {
> +            BooterKind::Scrubber => "scrubber",
>              BooterKind::Loader => "booter_load",
>              BooterKind::Unloader => "booter_unload",
>          };
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
> index ec006c26f19f..8ef79433f017 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -151,6 +151,33 @@ pub(crate) fn boot(
>  
>          Self::run_fwsec_frts(dev, gsp_falcon, bar, &bios, &fb_layout)?;
>  
> +        if vgpu_support {
> +            let scrubber = BooterFirmware::new(
> +                dev,
> +                BooterKind::Scrubber,
> +                chipset,
> +                FIRMWARE_VERSION,
> +                sec2_falcon,
> +                bar,
> +            )?;
> +
> +            sec2_falcon.reset(bar)?;
> +            sec2_falcon.dma_load(bar, &scrubber)?;
> +
> +            let (mbox0, mbox1) = sec2_falcon.boot(bar, None, None)?;
> +
> +            dev_dbg!(
> +                pdev.as_ref(),


I think you can use `dev` here?

Dirk


> +                "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n",
> +                mbox0,
> +                mbox1
> +            );
> +
> +            if !regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed() {
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +
>          let booter_loader = BooterFirmware::new(
>              dev,
>              BooterKind::Loader,
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
> index 82cc6c0790e5..9f3a52ca014f 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -173,6 +173,17 @@ pub(crate) fn higher_bound(self) -> u64 {
>      26:26   boot_stage_3_handoff as bool;
>  });
>  
> +register!(NV_PGC6_BSI_SECURE_SCRATCH_15 @ 0x001180fc {
> +    31:29   scrubber_handoff as u8;
> +});
> +
> +impl NV_PGC6_BSI_SECURE_SCRATCH_15 {
> +    /// Returns `true` if scrubber is completed.
> +    pub(crate) fn scrubber_completed(self) -> bool {
> +        self.scrubber_handoff() >= 0x3
> +    }
> +}
> +
>  // Privilege level mask register. It dictates whether the host CPU has privilege to access the
>  // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
>  register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,


