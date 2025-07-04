Return-Path: <linux-pci+bounces-31504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DDAF8986
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9D41CA0EEB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71928000B;
	Fri,  4 Jul 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbY34r+O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430F27EFEF
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614155; cv=none; b=M0Z45xoOdUmt/mPwH/B4KXD8G3MCsnLjSxL/MQCETTwIZXRCF5tC8x4FJZ4rvYQkTMFIQx6stVDtK3Q0ie/SFu0GMrHxP+Oqm1IRrOlFJiCh6LYiHAnsCSQ+/977KZLWRcxePMCInwV/hkfzjLYktX02t9NHsHAAwBA+9kDjRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614155; c=relaxed/simple;
	bh=aE9AaBY5AmaIc/TSlJk8xYSEDgun6T2UHI+HfGjj9Ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhIYOjhm3OgdRS52sniBaQyzw21z0scpYKi0Hjn2psIYGnQd4QirtGiA9nWOXgdTdX/uJQDdUzyn/ce4M2jZOJycodmwpwCBh9AmLbUuMGxCJV5vCR4EPNxysaOybYcdIsFKjKH1Nq3jtxFZp8OBrBpQpd5GUW1qsHyX5SKtdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbY34r+O; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so50341466b.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751614152; x=1752218952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf6uaybgVMOXPAt0XHGcRybgeX6DJY7grDqhABQTmPs=;
        b=MbY34r+OZ4sSh2m2SdOrH33bUI6tfxNnlQubN9dK0Z8TO1bCEu9V9P8Gbcg4U7TrLF
         fpebk7icnlqoKqu0FsV8YPQkif98qheH+IidJZ1syjSa63QOv0RQj17oxRMCwWrZc7UY
         4VLapkR1iVJmFnvKyE7EFrrRf+2nggk9SLDBRUI2CKPlIYiaRWncKK+gEaI9cdXBlCMo
         CI0Q2WQX1HWGlW9gmSdzyeTpvgvbZMUw0z1ROMfPEPcsNpEzb5fDU/W8qu/gnX3KIWwH
         9c4qVStkumlKZMos0xXikmU8XoxUKCuBUjNAHASbHn0DWNS6Rry5Q1+d9ojSFfLSSAet
         x6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751614152; x=1752218952;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gf6uaybgVMOXPAt0XHGcRybgeX6DJY7grDqhABQTmPs=;
        b=WOJzl/MuICjIfcbuuUmawuFWaZwrABm7B8RSJOSN1wBJxIcIx52DTCzK1U0Zir3MqW
         9GxSWAlOAMKNytjmSW1jCC6cZzq+OeGCbwbPlDMeFOOjRBiqqGoHnPdjq5FtU6KSXyWw
         610ivgUVqBRC4vVy2rqlDJiVNl9TeBWvto9YWXPznfguaJmOJkPAFDnPQS+HExTHoPx4
         VjOqQN2LKrrOanNlfyPv5GROtO5cggwSS6boW60oUcHmUMWNOVK0abm08g8g3u4UCB2/
         05/r0+7w7lfl+Ignq8rKQXrAGVnE5qiQ84zsUwaXCe3UyAGoJVFGCTqRlaCzvap8KmH1
         tTVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9oRSFqPTUbtK592W5M7HOaMnGl9VylhPsaMDEncOmKOBccmDLBRDp5W96rlpSWUWoArmoFOWUd0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoV1LPHAdLUFPe0eNDapHYUh5+okPv9henLzJLtX8kNH2la7VZ
	o66xhkLCNlRj6W4GQzUTFv2Fr01iujGEmHVD+7Kr1Mx6yEJSVl73ssbuMAY3tKttm0O3BI0D34f
	/3c9VI2GGmJ/PJpLXyA==
X-Google-Smtp-Source: AGHT+IGp9FJse3ErpiN0ssWTw95ljLS5jOUthXxjTSM3lcoarrJg2X6yKdGrmZzth00G3ncOAWatSsk1f4c1EMU=
X-Received: from edbcy3.prod.google.com ([2002:a05:6402:1c83:b0:60c:7d86:df07])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9805:b0:ade:35fc:1a73 with SMTP id a640c23a62f3a-ae3fbe45f37mr140704966b.55.1751614152193;
 Fri, 04 Jul 2025 00:29:12 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:29:11 +0000
In-Reply-To: <92c347d7-4b59-436e-b4ce-5941bdc42cd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>
 <022A0919-37A5-4FF0-B834-333E512EC0C6@collabora.com> <92c347d7-4b59-436e-b4ce-5941bdc42cd8@kernel.org>
Message-ID: <aGeCx5zHUPKtaryg@google.com>
Subject: Re: [PATCH v5 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 08:49:07PM +0200, Danilo Krummrich wrote:
> On 7/3/25 7:12 PM, Daniel Almeida wrote:
> > > +/// Callbacks for an IRQ handler.
> > > +pub trait Handler: Sync {
> >=20
> > I wonder if we should require =E2=80=99static here too?
> >=20
> > Same for the Threaded trait.
>=20
> You already have
>=20
> 	impl<T: Handler + 'static> Registration<T>
>=20
> which I think this is good enough.

If we're not going to support non-static handlers, then I think it's
simpler to place the 'static bound on the trait.

Alice

