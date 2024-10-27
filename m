Return-Path: <linux-pci+bounces-15427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F389B211C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF9A1C2088D
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA0126BF1;
	Sun, 27 Oct 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba5hmnaJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90C17C61;
	Sun, 27 Oct 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730068967; cv=none; b=gli05NsbDT/zgQzjzl6zxbRMPT4ZF/DxC0ORbzd8vcAfsLX1fLxoLU4ANdQm3tpCbgiUBzK/oM2pSRrpz+1RNPfwaXxeKdaoRPqUQ5dnaWVcYiTf8/ETLfujwYOW8kv7qos8bSlC3O1zlzdeQTXwkqEtrgBje1TMvWfI7bu0chI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730068967; c=relaxed/simple;
	bh=uwcvHusTROomeBLvylyvcg7lb+WgLhouV6Wbzq3dRwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYfL4fVoPrEpcVmEqjuqbPet3PrbLEG9UK3anxW0XZYaqrbEkmZEgq/1yOvSkmrLkvCN9/zCY8Kc5zCPzlis1NQ93bd6ouwvkTdVGSIjRv+mBuE4s1aF7v1h+EQsMmZLz24yaPgtix7DQ9Suf/R7un1Nxd4AHFS8wrPbYEAwN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba5hmnaJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1467af9dbso306127185a.0;
        Sun, 27 Oct 2024 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730068964; x=1730673764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf88lwRLiw9XE+1YEpyETRw1RNFcdzsY3C5vLeR+o+I=;
        b=ba5hmnaJo1/34X8FDZgdV0PwdISmh72IrnzHBEkMJAsz/5CmTxurUccv7HCXNQDV0a
         msr0eSH+lWwtIhMRYkEYI5Hx5AF69ZHRI+PqBeZT8gOr4zFj+O/k3RUw3bujLgOh01Hd
         WLIWScG/6OvfcO8q0LBG38lC41p2C7Rgz/tug5V+GkivyGBW8/oEQrTAi1qZHpNDHFYX
         0luEb4px2JC9W1bhzdeU/uM6VcLaJS2wcSRg32oIDyJC/pZiViFBnoH7o12AlVq/dagZ
         QxV71EDpBmeGxlt5Pn5rxHSZ+am6LSCgwI6q2ya+m5i5twhxPOZ59YjW9+2kyp0N9QwQ
         d2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730068964; x=1730673764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf88lwRLiw9XE+1YEpyETRw1RNFcdzsY3C5vLeR+o+I=;
        b=aUOIamnKgJfZrvsaXLF6eANQTeJJ8PMXPlQ0pRpCnHvU93A41YCRDYQMaUr72b/br2
         rAU0BqpwCHv34fJ6uwS3emPcisqxJs4Eay7a5tyPU8OaRLan9cPaTeVIsuNBVFfX5W95
         psaaOpY9UsA94zDAewJXoXsCIO9qlfFGF8PXqzIpFqTRiuLIMdzxc6cNU5JeO7cyDjP9
         ibhXm6MdPH0mYx8o2F6QaXtgDryGvSx9/FoZ+YEMsScJERnT2vw3zAfbG9ooRTdDQ9Gy
         AT8EprVBu9NwW9VkXlLB7G28tgggT/OpkBOgvJi0vY3qVe63s0OZbfb7yn6gi9MIWmsi
         B+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU6MSpNJjiHQZaRfoxwcZ+cnVUWc+f83g9r2l0iCYtRafzydxFdqjVlNOLlDC7f82n+mmB5Fv3BQoG/y0ckiiQ=@vger.kernel.org, AJvYcCV8J60dAtb3T+LV/PDoLR00gid0/JQSNj+vOP5BhlIRv9si1nGaFxYcPtQzW/5Aa5k0DuIOUuPptctU8MBw@vger.kernel.org, AJvYcCVn09d1MI2Qsm0I85AZ9Wk+64M8pvdOE+xpe0ziWQRvZkDMwVCUmKJaboubbVMjEDEHP2MqphZFTGCK@vger.kernel.org, AJvYcCWolvtyvE0cE23Ts7ODiD9EAWf/XJBpy3q1LAd2yw7gMkBSbjiydcYL7uCTWnlaY1sRUnpeermhcx+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZTLJIv0neEXR1ocivduTtdtdmGHKWs7EidafaXuODecLX0gQ
	d9/o270OJS2TRtFuEBN/HF1cF3CJ7kE9Ro6eaXKMPv2bU+pDW/GI
X-Google-Smtp-Source: AGHT+IGuEo27itZqVNbjuW74b9O6UzUFckGLYcwJUF47GVyp1zWayZUgYG0JcTltHutqwp9sOcXnmg==
X-Received: by 2002:a05:620a:280a:b0:7af:ce28:a10c with SMTP id af79cd13be357-7b193edacb6mr1010834485a.12.1730068963970;
        Sun, 27 Oct 2024 15:42:43 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27a9ffsm270684285a.23.2024.10.27.15.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:42:43 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D3C361200043;
	Sun, 27 Oct 2024 18:42:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 27 Oct 2024 18:42:42 -0400
X-ME-Sender: <xms:4sEeZ_VHJmyGg-FfIabIaaOtTjLSI20jkk0ilxUbc4p0oMXOOZhF_Q>
    <xme:4sEeZ3ndxIS0gIWBEnKtjq0KBv00ahm3NpMMEzHntnr-ty-sqypDa_m2clp-0W2Aa
    JFWrrVRONvH1D9b3Q>
X-ME-Received: <xmr:4sEeZ7ZauXdN0Hgvcnx5Ur37MMQ3MmC1dPLQfKynLkkk11La_KYsOZe-LUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:4sEeZ6WPFjovLxdtqrWq6_gxxTCmV0sZyHdw5a1OFAHCm4WPLY3c3w>
    <xmx:4sEeZ5krCb9DTpM9NnVd6I084dqSTDordDDA-BGg-eteG72MNpb4oQ>
    <xmx:4sEeZ3eiBfQWaHDdAZOqQB4AhIVUJUO8wpVzuHoyWiWRNHuqnCMC6Q>
    <xmx:4sEeZzGormCjIH0dhCPuMfw76sEaTZeVfvkeNYBuHIkuNAsdTkl65w>
    <xmx:4sEeZ7lvVqn9mWXbfvRZ8_kUgvFNGjPD1YhlxN6C5g_b1v4vXW5jGNkZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 18:42:42 -0400 (EDT)
Date: Sun, 27 Oct 2024 15:42:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/16] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <Zx7B4Y5iegKVXpC4@Boquns-Mac-mini.local>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-12-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-12-dakr@kernel.org>

Hi Danilo,

On Tue, Oct 22, 2024 at 11:31:48PM +0200, Danilo Krummrich wrote:
[...]
> +/// The PCI device representation.
> +///
> +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> +/// device, hence, also increments the base device' reference count.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +

Similar to https://lore.kernel.org/rust-for-linux/ZgG7TlybSa00cuoy@boqun-archlinux/

Could you also avoid wrapping a point to a PCI device? Instead, wrap the
object type:

    #[repr(transparent)]
    pub struct Device(Opaque<bindings::pci_dev>);

    impl AlwaysRefCounted for Device {
        <put_device() and get_device() on ->dev>
    }

Regards,
Boqun

> +impl Device {
> +    /// Create a PCI Device instance from an existing `device::Device`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
> +    /// a `bindings::pci_dev`.
> +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> +        Self(dev)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::pci_dev {
> +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
> +        // embedded in `struct pci_dev`.
> +        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
> +    }
> +
> +    /// Enable memory resources for this device.
> +    pub fn enable_device_mem(&self) -> Result {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> +        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Enable bus-mastering for this device.
> +    pub fn set_master(&self) {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> +        unsafe { bindings::pci_set_master(self.as_raw()) };
> +    }
> +}
> +
> +impl AsRef<device::Device> for Device {
> +    fn as_ref(&self) -> &device::Device {
> +        &self.0
> +    }
> +}
> -- 
> 2.46.2
> 
> 

