Return-Path: <linux-pci+bounces-9227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79E9165A2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BF283E8F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDC14A61B;
	Tue, 25 Jun 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="ILQLJ/3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AD14A4FF
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313176; cv=none; b=KX/u8kRGj/bKMvRhgszz6fihsSDhZozoTv9I0rZOkqVES8LafrNmH263+GKX8qFwuf+EsRhCVkvRi3wLg8SCflDXHLBA8gE6iRq8ZRXuVoRfodtmwTqrifG5znLdcckWEY+APjnH087r00NO/FV9UvhDOAdlBtKuMbFeVwIdORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313176; c=relaxed/simple;
	bh=fVPF6QJF7rG/F5OUgasWuukloGcuPijewbPTH7NCyZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2XcEWt3F3XACNzCrk7UH1gEJQDoQ/5nKqrvDoVVxlnCVCkQ/0gUuumb6RLku1KroyPKMnxaEW0iTo1kYyGZmAmvLNG3QIirj3P2FRCbicnUJx5pwh0nLmuhBBDwOrzz1cCw6y6iLj/aJOe5BxfbLoPto6EO2lJ/1XRE2jEXHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=ILQLJ/3l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so60312491fa.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1719313172; x=1719917972; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HK8CBgC+NsQrNpK+KFLlGL2gTcxTEEhi40E3k/R3Wk=;
        b=ILQLJ/3lR1YkL/m7S7M7lLKD8EF+7VQkMHMXKO1OBpqJ5nw2M44saogXfx0XENEa8u
         Rt7W9cQ0PoEWnDwgwE7UYQRQnD2elF1Z6spLrBsaUFUoHbBM78wYmX9N1cvtpKpmdz5O
         sTkSq/a2sOXOjtIeN0P7WymgLpqhje3vnmq+eb76aLeM3KBvZ4PlFvnAsZWLhmhZO9SS
         mftTeJRFxmPo6A+MPjJ5uBf7aXr+wrrnEB7+8gpTPYQuHdf9UGl+WTnqazfBmE1dL/n+
         f+MsHN8BVw6zaZ1wlITCtCdjHPAsK4e5nA19UZECaCSTMHZY/w5HbG81Ue48Uf16j/Ys
         bM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313172; x=1719917972;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HK8CBgC+NsQrNpK+KFLlGL2gTcxTEEhi40E3k/R3Wk=;
        b=hRTBQ3kXQ1YoypIaJdposWobLrNvU25gGrxU7E5ESBOHaoQsN/eVUWW5m2DNFmfIRJ
         leJN1B9/PHp0R0CcVsm4HexBB+12aR14RGCyLSuSMszHR8X5OYWbpCLM9cMCzQOCdyqR
         i+xjS5+MqUB21Nes0E80ObVrHeFySMjMCfTwTuXhyVrZS+I4hMcXIdstLtDUNXc/dniU
         9cKbGjwAU65OKVgka1FXoCRiLMZiCl6bv+J4RnccktteR2ip1e8h0/Jk56PNIId2zQJx
         DFkUj2FYAFzu6H7jXFmCAk5O472uP/09QnT8i/ThlY9/PO7CC5Bp031aPMX60Vuwa6Al
         lyyA==
X-Forwarded-Encrypted: i=1; AJvYcCVTf5v5hrLNdE99r5VCj9zGKCtgNjegRjX24REUgOojYH3sU/Mcf9+YL7rQZRhIgaBUyoZScG0vqYiYXMYpsp4MJQyAzTFWuXi8
X-Gm-Message-State: AOJu0YwLOYnG8vK+aV95AQDa+dQBkUacsnxdWAErViHM2jeKbGu4bgvF
	oEzmqHKB2t7gEl1kPlLSWUq233S5WCMb8nzjFOysO6yc1Bzyx92MJEINLr3Pkrk=
X-Google-Smtp-Source: AGHT+IE53M3V8Uidqoa3yk8+4qXuwt/bTpN6kGnKnf/lTZX0PwppewDi+ZCmXMrjqzvhU+9ZupI4Sw==
X-Received: by 2002:a2e:9684:0:b0:2ec:403e:631a with SMTP id 38308e7fff4ca-2ec5b36b135mr44323041fa.8.1719313171978;
        Tue, 25 Jun 2024 03:59:31 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040ee6bsm5730751a12.28.2024.06.25.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:59:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org,  rafael@kernel.org,  bhelgaas@google.com,
  ojeda@kernel.org,  alex.gaynor@gmail.com,  wedsonaf@gmail.com,
  boqun.feng@gmail.com,  gary@garyguo.net,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,  aliceryhl@google.com,
  airlied@gmail.com,  fujita.tomonori@gmail.com,  lina@asahilina.net,
  pstanner@redhat.com,  ajanulgu@redhat.com,  lyude@redhat.com,
  robh@kernel.org,  daniel.almeida@collabora.com,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/10] rust: pci: add basic PCI device / driver
 abstractions
In-Reply-To: <20240618234025.15036-10-dakr@redhat.com> (Danilo Krummrich's
	message of "Wed, 19 Jun 2024 01:39:55 +0200")
References: <20240618234025.15036-1-dakr@redhat.com>
	<20240618234025.15036-10-dakr@redhat.com>
Date: Tue, 25 Jun 2024 12:53:48 +0200
Message-ID: <877cedi98j.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Danilo,

Thanks for working on this. I just finished rebasing the Rust NVMe
driver on these patches, and I have just one observation for now.

Danilo Krummrich <dakr@redhat.com> writes:

[...]

> +pub trait Driver {
> +    /// Data stored on device by driver.
> +    ///
> +    /// Corresponds to the data set or retrieved via the kernel's
> +    /// `pci_{set,get}_drvdata()` functions.
> +    ///
> +    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
> +    /// never move the underlying wrapped data structure.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// `type Data: ForeignOwnable = ();`
> +    type Data: ForeignOwnable;
> +
> +    /// The type holding information about each device id supported by the driver.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// type IdInfo: 'static = ();
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<'static, DeviceId, Self::IdInfo>;
> +
> +    /// PCI driver probe.
> +    ///
> +    /// Called when a new platform device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device, id: Option<&Self::IdInfo>) -> Result<Self::Data>;

Since you changed the `Device` representation to be basically an `ARef`,
the `&mut` makes no sense. I think we should either pass by value or
immutable reference.


Best regards,
Andreas


> +
> +    /// PCI driver remove.
> +    ///
> +    /// Called when a platform device is removed.
> +    /// Implementers should prepare the device for complete removal here.
> +    fn remove(data: &Self::Data);
> +}
> +
> +/// The PCI device representation.
> +///
> +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> +/// device, hence, also increments the base device' reference count.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +

