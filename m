Return-Path: <linux-pci+bounces-30379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DEFAE3F1A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B671884282
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BEB24887C;
	Mon, 23 Jun 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuElYsEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD724887D
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680079; cv=none; b=ue+sUhsLtV0WCbo1Nts5DP38Bc2z8dVtmc1P3SqascsfYyeIr3YFxv+tV3zua2Iic50DSaP93xhDj/KAE0HD0eF111kiSGCAItaUzvR9qGppEhFhywREx7QJz3lHfDVW8rZZzRyV8QAxdn6ROFwtc1LyNoLDEfmxZM6kaBMTUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680079; c=relaxed/simple;
	bh=d7SILEwcYtEPyRVpUElTwTKFQ3ODmdUrdA4ue3lYQpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PRNMmlD0Lvtem1NvFSmslukHfwezE+BUrMBUDaM9YEfTrTS1oZd3qDNPzn2rT4DaHIOPfkn+90eHiz1Qz3UY1yDwWG3OF4zQtLkfJeWpYHTl9OzdYDQekSz9BP4Br92Kci/pKIzPVRw/T5I+53WyvP07iyNhCimHKU86Rm7cgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuElYsEC; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1938256f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750680076; x=1751284876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXBjAJSsgTF5DF8QdVVpRmguTMa8mFGOZ6NYbvvI8cM=;
        b=BuElYsECiHv3KjWTCDz39+25w1lDQjSfPqDE+6mlZhorin1Nfcl1r774c1+9GLk7NZ
         tRswrwYj4EQSI+1UMJ+VbgltW9mvnM+DERfPCjy43KKZkMHDXEEp7r6mDG+flVcVO5fu
         apznNqnY+v8UT8EQQJM0WsUp9Yyuh1O9npAJUv04AWfYAFOdIi3j7R63z4FkHRzo8lkv
         yxjRmVW3JFp3UAUTOGXnkPg+WK7648vrRJtcYodd456eUlbeAfPMHtZ1oBON0014APeL
         Q25SOKn0zkSDGSLXmTl5+i4Nvcspt4MUaaAS1DmP7pruX91eomjGf5tohS6dqmP0OqNF
         EDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750680076; x=1751284876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXBjAJSsgTF5DF8QdVVpRmguTMa8mFGOZ6NYbvvI8cM=;
        b=Yv4qkmezBKytBgQ91MIl6NdseOoZXQJStdVSBaU4J3VzQfksSotMGIiuekGLF2B4J5
         XaHVwE68EPF9/n6YIbi6SBrH958eD/F+VrmLrMzG3boVB7911kP3HjLOnmS6Fof3h7Ve
         PpvEcx/ysNrD0p7RJ8iyxAzWNldZrlkawhuJoUlAXMgR6s+aC191EtXznEssIW/ayYnn
         bzt0ghmToO/kr28uJCWiXw10SZ7lrrV3AXNMpwgyyre1Px85MHOE1nFp9CaxUu0fM+OK
         tdEp05It6/Bqw8luao6PbEy3tbjNttI3JH77JUrNp3z8lYUdUHpWW+e5qjggaiHCJE3T
         rNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQoQK/ZXH91g02PbQOK1VsMwCFpm9HqWoBmx4prqINF1yuJCa9nDK4z6eUaNiy8pUC6SorRcnAcoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJv7mDqVcFHht00RQ/xm2IZutyc8skTQv2OYpAV3hPT7U5ZRpF
	wVhwDSPylHogisPNYOLqVkHvN16VF9z0iOBhklbsPUgBYUm2+mJ3hv2I6tcdZiOaulB0ZTtF0kN
	yGmHYkljMriRur/kx7g==
X-Google-Smtp-Source: AGHT+IHs0W4TxDLErHp60mYQCQGaYXzhOpZPwSd1MKl0ZCrLAjSy6eHDXtUk3W8HjaouPiHhipd0Yguq4kOC1w4=
X-Received: from wmbdq13.prod.google.com ([2002:a05:600c:64cd:b0:43d:1873:dbaf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:5c4:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3a6d12a722dmr10276774f8f.21.1750680076403;
 Mon, 23 Jun 2025 05:01:16 -0700 (PDT)
Date: Mon, 23 Jun 2025 12:01:14 +0000
In-Reply-To: <20250622164050.20358-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250622164050.20358-1-dakr@kernel.org> <20250622164050.20358-5-dakr@kernel.org>
Message-ID: <aFlCCsvXCSJeYaFQ@google.com>
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Jun 22, 2025 at 06:40:41PM +0200, Danilo Krummrich wrote:
> +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
> +where
> +    P: ForeignOwnable,
> +    for<'a> P::Borrowed<'a>: Release,

I think we need where P: ForeignOwnable + 'static too.

otherwise I can pass something with a reference that expires before the
device is unbound and access it in the devm callback as a UAF.

