Return-Path: <linux-pci+bounces-24218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B0A6A197
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DFC19C1887
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71163211710;
	Thu, 20 Mar 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU/AGhG4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556D20B7F9
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460060; cv=none; b=Qglv/zwb4XDR8TrJLLERn6+0s9DL3EAM1NAAivm7MK4Pfc5Rm/pPEvkKQ8wiHLnqh9HyL1rlQwoL/foI4YHh1e6yMAbVWUHYP9FFmrEc4ugR75fpVy5fhLsHvajZJNb87hQltAnhnp1hbkBYj6ikvrviAx802VTFYdmtrxsIXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460060; c=relaxed/simple;
	bh=+JphUaWBHj8e5Dy/goJmtvqb5JUUBJCl4r3rVDM3IPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHusMJ13MYXSs0OUEVom44bBb+zbjOz+OGCT5bpCAmna26L/ZHoXJXdI9ju4nmAqsZpXmgU6G76w6Pn1MNM199F0fvfleT1vxBoSAQt50UPbuD1ARdj0j7QemPZtXjYm5DMoTiYpzp2mmtdluucmCAKOQga3EsTFsSeF4Cpgyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU/AGhG4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso2287375e9.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742460057; x=1743064857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joq+AsBCw/cRk0tuewc3GK3q7weyXB1E25fHZd+BIYo=;
        b=hU/AGhG4T8sfg+24Pousp30rYI0FbaMiskQArGxpHf+g1TudUs/L8024Un1VEGseHw
         bJqrycXf7yb+lPA/TDFGLkn/E1SD5oK+yn4vzh717+bHJNi78VrXbFbqZLK3rtetlKaP
         UPsbFgruL6ZNQMIAx1yV4A98ckzuU56F2aUNVlO1asxz9jPqCwAQzLn54T94eGjh3sJf
         vV8m3TpHwfQsP9m2150Sv8zrD7ezOxV1/gwBnHp0L9sLG0RysSXKbpsaAfX5xrPlm6iP
         SHEqtIl9ZEzMUH2cXqmoaDXKViEEAODiYT28czcC9Hrl0vKMx1nB1leA3FKQ9FaD0TQ/
         rJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460057; x=1743064857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joq+AsBCw/cRk0tuewc3GK3q7weyXB1E25fHZd+BIYo=;
        b=LmV4AYGiL+ay1QfPKIPaFOMtkfoEAMmfBXA6ryQFVl0J0RbF3vRr3Rn8UOQQpsrKly
         Wjje6HafN8GooIOSTPmlXnYAGfDaxiBKaIk+mS2jZjDNFlyA0pLm0SQgkqd3C+SaA41a
         wHBZViIJDxvDxvDA2boOX4yazFmoegqsxV6bVnbY74dPYHl8cezb5KAB23mwXzK5dHGH
         TwBt8Xr8TAZAVzVdlyJbDEWpuEIjhDmRNyrEsvePL7nSWaRa9pWEej7GWyJN9o2WHMu7
         CQkR80sv9c8++yLf0QpmuE4ShVy55sLW6095YYQKLNbmsni4jHWTIVEW/yFdb3Hr5cGq
         h2bA==
X-Forwarded-Encrypted: i=1; AJvYcCXcBXkg8pJcK1aUFs++zPDfiP8djZKeVntsClBdDVkQOgHHtR7BGBwrkG2MW1/pk0Mg5CxaqynC8gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4AqxxyfeVDLUhleqA9V9lU6QLetwwmO3K3pFTmdU8UQ3XaJUO
	JI/i86qkEUnFPt6HZvQosj6qOnwkDCdaQKFG935g1IheTXakjhu53iwChOpEp9HC+GhUnv14mmQ
	pXMoeg9PkMxDrncDN1T3wGx1spZiSA3E4nk2/
X-Gm-Gg: ASbGncsAP/goQYncaTCbwpsjKw6L1BnRdW0nM4pO77I/WzVHuzXpyHwMerUCurUYa9R
	K2D8h9qwnWI5hPjjql5DS6m9H3xih1Mui1AQ0GlRPsGxqFGLKZQeU2vKQd7PiUfB0idivw4GKU4
	UuUt9YVQ+kxP/n41o2Lz/8DoE0W2E=
X-Google-Smtp-Source: AGHT+IGYRoX+7Vs588yGWmq8/C3g+/34z1UTJnjq4uAIISiLs6lNMbMTr8uEmsIxn9Cs0JCzmBgJuVwG12+9/NJjvT0=
X-Received: by 2002:a05:600c:3b20:b0:43c:fd1b:d6d6 with SMTP id
 5b1f17b1804b1-43d43842e8bmr48239855e9.31.1742460056723; Thu, 20 Mar 2025
 01:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-2-dakr@kernel.org>
 <Z9vTDUnr-G4vmUqS@google.com>
In-Reply-To: <Z9vTDUnr-G4vmUqS@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 20 Mar 2025 09:40:45 +0100
X-Gm-Features: AQ5f1JoNNdmHyOEpMkchf2aXocskZ-uhSkAZrFXKySPwesw-HUObFmlhnFttP6w
Message-ID: <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> > Device::parent() returns a reference to the device' parent device, if
> > any.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 21b343a1dc4d..76b341441f3f 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device=
 {
> >          self.0.get()
> >      }
> >
> > +    /// Returns a reference to the parent device, if any.
> > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > +        // SAFETY: By the type invariant `self.as_raw()` is always val=
id.
> > +        let parent =3D unsafe { *self.as_raw() }.parent;
>
> This means:
> 1. Copy the entire `struct device` onto the stack.
> 2. Read the `parent` field of the copy.
>
> Please write this instead to only read the `parent` field:
> let parent =3D unsafe { *self.as_raw().parent };

Sorry I meant (*self.as_raw()).parent

