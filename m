Return-Path: <linux-pci+bounces-23919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8EA64B2D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343873A606E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40E23717D;
	Mon, 17 Mar 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c78jfA78"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FA2356C5
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208737; cv=none; b=ltCTnszVaTYn/z8e6RyO14qAn9/uf4YZCrWXQQsm2rpjFGtskpDxNE7Gd9K1cPpTCqDQ4Cs4w/KB6GSPnzRN5XKOl84xCX+LYceOz32do8o16zjva2Huj4IeKCOiTyWEMSc63YLIn20Cc3aBjITa+8LVM6AVyktRSCWCvmAovbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208737; c=relaxed/simple;
	bh=eeuK4xT93WvjWp0Gg8f91YaCZEctTHOwolyCA3Zg9Ak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BoHw6mzIC19cW9u0pa6ZVAl3Yo6uqn3IgF8PeihX3BJ8261TAZWVKWiq5knFvsiMf1C3tlRgp+AvxavIFoWR56ibde65bqkwGkke57B6fC3dHS5P1Grk8FoCKmDcyDc6wT6YTB/O6NP4tJGWb7L3H9MrlX/KlEqsRwJy2ajfw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c78jfA78; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so15385645e9.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742208734; x=1742813534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tcva91qbc81FGn1vXLB54WTmevbL6p5VxkTw10IeAI0=;
        b=c78jfA78iTgjZbNr3HrLU/QKMsz6MBBES3vMgULWBhhEGY+LLsGPOfaB76dCAqJPS9
         4qtMQd4jhi2L2rFu5sB3xtIKh9Btbz6SxVKmH/oEIr33SxkPCJrHOD+I9HuDp98WejIF
         CL1wftCc+zJ1FtJsFVRWXzsAbqBOXUAKM5X+tq53t2ikNmwaXa8AutrvCNqTfY4KANzb
         reyw7SXK5EfVUrM4rl9APYt7DXz+q0vf+x80aMAQ+EOoaVhx5iZ0geJa2l0bCmdi14cn
         vOm4gUXx6NyAJZhqDusySAuFa9c5Z8/ns/uhgJQ7qJ7ovnbxoBWyTVB79eZn/dNtWDWq
         kZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208734; x=1742813534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tcva91qbc81FGn1vXLB54WTmevbL6p5VxkTw10IeAI0=;
        b=P90c1cgt+bks0HncT6gHKJrP3SF7E9L3c5wv4u5CMdSkEp3iR7poqGpq4pLqozmMRb
         oe3wBuGa5tPRdrflJQxIeaHlKlGIi+CbSJd8DfEeQ/xwW8pZoZXkgtsj5NFPnatkJs4x
         r7juRGFT+5irWJ87Di3zV23LTnhpN+DyMv6jxZEDoxW0fGDnszrTgzRkUjDXKXip8nHt
         gQa5VonUjEDEYlQaRkuaZEgxNxYe9FAHff7wM3n/axISTiy46f81bpVbNvGFVlMaaC4j
         R4n0Nh7ORzghlqHy6qzBn8UHYGSO3HlVhFwJsbq8rqAdaPmJR+IzOIyHA10/NsHPE/s9
         ET1g==
X-Forwarded-Encrypted: i=1; AJvYcCWcnD9NPUEhONK6RTMPfcauoRr465pJVQMPSP6p2wELxIwVBLx+9AAW8+Mh5wDGnaICS0eMfgtcn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauafZiVext4wJgPR1iMKViyD4ASAymDcMcsuFX+8S68y2od1e
	GUwwjZo7bNXBf2qycVKX535T9+Wh/S8DjpmynL4dNkolnFEW/8jBtsX1LjceQhJWZiyUn1ndsV5
	Al0f5gnPAoraCdQ==
X-Google-Smtp-Source: AGHT+IFQtLHmlkFGovhLbUUKxy0zWAm5TQqWXbx/kptXecEGH7yZZmlZwUeVlgdPVdE6B96JSpXhAC2rNrEEQ08=
X-Received: from wrbch14.prod.google.com ([2002:a5d:5d0e:0:b0:38f:40d1:8309])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f8f:0:b0:390:fe05:da85 with SMTP id ffacd0b85a97d-3971d23750dmr14173105f8f.16.1742208734052;
 Mon, 17 Mar 2025 03:52:14 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:52:12 +0000
In-Reply-To: <20250307-no-offset-v1-1-0c728f63b69c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-1-0c728f63b69c@gmail.com>
Message-ID: <Z9f-3Aj3_FWBZRrm@google.com>
Subject: Re: [PATCH 1/2] rust: retain pointer mut-ness in `container_of!`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 04:58:48PM -0500, Tamir Duberstein wrote:
> Avoid casting the input pointer to `*const _`, allowing the output
> pointer to be `*mut` if the input is `*mut`. This allows a number of
> `*const` to `*mut` conversions to be removed at the cost of slightly
> worse ergonomics when the macro is used with a reference rather than a
> pointer; the only example of this was in the macro's own doctest.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

