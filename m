Return-Path: <linux-pci+bounces-22528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F6A476E2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2D03AD821
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E1224895;
	Thu, 27 Feb 2025 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXOLHzql"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F01E521D
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642782; cv=none; b=DYaGL583iPJABvISepVfoHzlAkFrgmSvVUd1DCp3DB7psMqB23riME+BprP6X9E373RNdRRLqbLazgq11BQVIYHd8mV2sg11fvjZ0c/Fhx/oTmyckk6TbUw/k+3OSDd77wcY+bjVhScJiM3aqzrl7ruAdcwUHo8bCK5WKdckB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642782; c=relaxed/simple;
	bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbqTMFT7FA+RFxJvi5tfZNFBKUPD/fKzByLfIZARqFOvMGMQAHGO/sbfernivsqz2k7qPShi+ysZPQVoE44mWgAwuOvHazuj0LLc6uRCpw30P/p/paeY5NSZLxm/DoqOxx1XEGZsV99wuUOL5ariaUET3QAsLIh2wG4nXUZ5zQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXOLHzql; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so339827f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740642778; x=1741247578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=SXOLHzqlXhxb4jvoRIJJaRW67+Z98sGduAmYGrPWU3Nv3sqgsuWk5SGGYZOIJNweKv
         jZyVHAFgoG7SwGXnIhbPxSLO8GoxDQzEEEUp4EJJCnyj/xFWCRAA8DnqbvoKrFk1pEjY
         i+M5RNocw+yifwWy7D0XS6xCsYcA/p0TN5Jt0k0rhB1vGZyjwFHeyt7waolqBXl7wROH
         upGc4/G4Wyp/ObOZy54Hjwy5BSCKBUIbowxvSSQkUnxMnLOHEFp+604fLOCZouQxcnLf
         6nDfRxTb0sUkhHTbgpIBYFGd+tfACLBqmaZW8sM9rUe03FevcsAYOcAtVJeaOAmqUfcm
         u7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642778; x=1741247578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=bDlLGJ+IVynCZU9tvh8+YAA8INQzerRbFk56ctx1qKPLgv4xdpQSAAt6oITY2v+rKj
         8HbCC7TXmbzPMAKNQL9ZBxQ8zz1aq853v7ig4X62qQewxLfgrviDXn6xnJfYJu9PZ5XW
         fnzdImFhlvlBBdMISvHUIrnGpTdnaprgWCL4SaQ1+ykXI8IcEI8RaLGzGCEFffh1++vK
         HvVrHILdCyS9AMWSOe6vkFwofOXRNek6Ysv7TLAaG6v8UST+27InIiBzWjdiSOL+P6XO
         KrYm5WuugZYHKVgzwV6aj++GWF1bZLjnowlxCVH21pDqMw0IqeikunWQJ/TDuVzc4WFZ
         Co7w==
X-Forwarded-Encrypted: i=1; AJvYcCUOtCM8Zos7W0rQTIKKg5NIhyTSWGWQcm75j8Zg1Vr40CMFLwCBZexocnRf2qAR/gqr6M2SR4SxZ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nywrpm3KoiZMsirGGlYbvjqSyGguMDhZgO7tZHbXySCZQQrX
	3yNGGLxlOCB8feOPiEZzs1t/PFfTGP8OrRCq3EVy0o9LW8rWgc9TDTMYAd016w+dqTKZAfYBudy
	/2rszavc9eRPBIDXEbblXumDoJMAoCRyGP9PX
X-Gm-Gg: ASbGncvoiR7pry9j95LnANt0rnLzFHFrKoAZUqt99IiRN6jUv8Sb3tqp2R7yqdwuaCO
	jnWHZgb61658EYaVzwYZKzpX/ompguGmPH5VoK23is8OhajngDQlKD5TheOmUmHIJxCl7orPRWb
	ohURA5g9fI
X-Google-Smtp-Source: AGHT+IHq/W1ckseU42DFdamVj9VolCNCEVXVrOQeYw+6Bv1YqodQtI+E8O2KwTAXHPbfpoMMUid6060aOourekauJZE=
X-Received: by 2002:a5d:6d87:0:b0:38f:4251:5971 with SMTP id
 ffacd0b85a97d-390d4f367a0mr4807927f8f.6.1740642777735; Wed, 26 Feb 2025
 23:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me> <20250227030952.2319050-20-alistair@alistair23.me>
In-Reply-To: <20250227030952.2319050-20-alistair@alistair23.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 08:52:45 +0100
X-Gm-Features: AQ5f1Jqr2f3px356CRZa1JK9YL4d2jGf-uxwiU32ka-YgAtLTMIEvy1EGdGheLc
Message-ID: <CAH5fLgjFvm-+jVpBsgU-sgOOzHic9DvcUMMg_z0G+37z5DWbPg@mail.gmail.com>
Subject: Re: [RFC v2 19/20] rust: allow extracting the buffer from a CString
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:12=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> The kernel CString is a wrapper aroud a KVec. This patch allows
> retrieving the underlying buffer and consuming the CString. This allows
> users to create a CString from a string and then retrieve the underlying
> buffer.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I believe the idiomatic naming for a method like this is `into_vec`.

Alice

