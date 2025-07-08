Return-Path: <linux-pci+bounces-31722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B610AFD6AA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D95A483A0C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C81221F13;
	Tue,  8 Jul 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6FADIep"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F426221FA0;
	Tue,  8 Jul 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000448; cv=none; b=TI25Jk1Cjgkzb0gd1cd72yaP1qLZYmi8h7iCWt9yctuHDWA8PAHZmo8FL5O5mh9Otkg/JkFYp2BefWYOXQ2HaMog5d7bqv37cd4irzG9WYeNFJB1j352hOva/r4ySPVrQHURClDvE7i35QTBQpDs3uPJthR/oRd+0D2SEJ5zGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000448; c=relaxed/simple;
	bh=/mqj7Ed3H8Bkoymh26BH44kgyey94FHD1a9v525/9xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irwxGY+xR9rVgRHYWQx4UC+wjLg+GhriWxXhf/4nYsvVxm7x2HRwK0hzySzinePNSaoQwE9bwMRf+sy56dDvZLavBhkbGFCTr4gGHUiW6tBt0InB9Zb1iWxgdjyCuK8tP1vrh4LaKl4irTtwpMQcedzhWuVj0mo2ziXhJIEqGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6FADIep; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-312a806f002so816772a91.3;
        Tue, 08 Jul 2025 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000446; x=1752605246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mqj7Ed3H8Bkoymh26BH44kgyey94FHD1a9v525/9xs=;
        b=T6FADIepPPVjbB6Tn/P7qAnlrEy050vGGpIqYfasriBg/TF/639JGn6Ck37jklPvPS
         I4Gf1d+fxa7dz3387t5W6RNuNMY4RbZ1tVWVJLvQHdRn3sl2/rt6Uf8BExpgza2a6dpW
         gs4n/3l81zt3+NngARC2rpIeMT6ZloCVojYFg2eVEm1m0nJ0bMjbz5v9uwdwAme55JFJ
         3b6vg/qRS43bQL//2ojjGD5wdKBA9AWdIy+U1pS0ND8UHpUHQ6qNUCu+mtA01+aMPIqA
         p/RAWlulRtD6dLkUJ3cTCqtR3Av7jKJc2kEPCRPPxvkBK1LmeibAoP7BL0VcF1E6Orer
         cM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000446; x=1752605246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mqj7Ed3H8Bkoymh26BH44kgyey94FHD1a9v525/9xs=;
        b=sItmjYtEhtKVfPtWwdMvYvFLfxzK0FF2Rn0WFN+1tlMe5htvB+eywe83hsnbzVoNdh
         MU1TjhaeYhhYrSHpTAbIo7szL9uMHBn7NKKAjnUwrJHKEQBYaAsuq1nJbtfAPd2+WY/x
         fhTll4C/8FuBC541pfBNTA4xe+BIU/fxgbzxXixCEXaTV7G+gaG3fimbVIxavG9lg+aR
         2U4RRx1sffX+g6Srk+yj8NeFW3BJLe71GnTG8c7XA7C87igB5Twp6mjFCdu2c185EX/h
         6vkJMvN0tAPFhGxcHInszzVYo+wnz1TLRvJ1RupF+2sJkAt8tRtO8kuh2lzrzOngiwQm
         ymfw==
X-Forwarded-Encrypted: i=1; AJvYcCUBHLUjWzBQDcjJZr0rBHMGftfmkHVKILzdJ+JleV5Kbdhg91ASilikzgABeIw4WiKwYYEp9OpdSgvM+Xr59C4=@vger.kernel.org, AJvYcCUI+8KASJJUckt1BDqKPxjA1DuoOEL140+O7z2eKaioAsugbmA6ktHqrSVXFV0AiJUmmS4H4OEC@vger.kernel.org, AJvYcCUYoCpQAluLFyMz6efkaP1sZPGBrfR2RvLQchw8g/z8Xb3AD45V1Fed6uTv3jmpGHshHxVkNe2ldQ22@vger.kernel.org, AJvYcCVjD/vROJwnoXJ6EKQWPpSFfMiQSSM2NUEcgzrT/tA9CLjaOjLik0hvOG0qN3a/3xske6rWLye2G9Qc@vger.kernel.org, AJvYcCWGfZlv8ZoUyPrJ8j7KRFKiSYuWXg6ceEgBqXvJuwNeWSKMEE4F6LhJGpZbqPB8eR4KiHspcSjx4WumDjGm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ee982syI/gmejhjKunPtVvdQualBSsGBSJq5ORx1occmiyLI
	BhnhvnXX/rhaTLlNNIDPFGrriqzYI8t4mzMdK9ns9NK6jxr6E78nxcGsA4a6rnf5mEvwZ+dfy5F
	Iu62YMp9PC0LsblvlXXsjo1HgQQ4JNnw=
X-Gm-Gg: ASbGnct724EsgEXVlN1/BTRhtKj6prRk0bvMz63MnEMcJP2BaRP13otRA9AKA/oPujw
	FzVKahQ0YmlCPw9vLXMuLO5eEE0pmfuqhkdGlmiCtasJtjg6KCk1x/WyGZOoSvondNK5YNCO+HE
	cqdGX3z2CchCFqgtn3x+S5KfVSWqdXMdoIBcK5sReRJWGt
X-Google-Smtp-Source: AGHT+IGUVcR05B57Q2PyTCBv4j3P2juR85r1CT0ZhYq7HOZlRPbkeuFO/S7LGG5xpRMh/FmIYfXyYHyAkMtPuSrUpyE=
X-Received: by 2002:a17:90b:3e44:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31aaccd7e36mr9090114a91.7.1752000446452; Tue, 08 Jul 2025
 11:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250707175350.1333bd59@kernel.org> <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
 <20250708.195908.2135845665984133268.fujita.tomonori@gmail.com> <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
In-Reply-To: <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Jul 2025 20:47:13 +0200
X-Gm-Features: Ac12FXyuqXTkap0XT6noQoywOzfC2SM2sN6p2wIUc2hHZAxerMZXVAG3UPPF_Sg
Message-ID: <CANiq72=Cbvrcwqt6PQHwwDVTx1vnVnQ7JBzzXk+K-7Va_OVHEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org, gregkh@linuxfoundation.org, 
	robh@kernel.org, saravanak@google.com, alex.gaynor@gmail.com, 
	ojeda@kernel.org, rafael@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, david.m.ertman@intel.com, devicetree@vger.kernel.org, 
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:48=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Had a brief look.
>
> There will be two trivial conflicts with the driver-core tree, which fixe=
d up
> some of the safety comments you modify in this series as well.
>
> The other way around, there is one trivial conflict with Tamir patch in t=
he rust
> tree fixing up an `as _` cast.
>
> So, either way works fine.

Thanks Danilo -- ditto. Even netdev could make sense as you said.

Since it touched several subsystems and it is based on rust-next, I am
happy to do so, but driver-core makes sense given that is the main
change after all.

So if I don't see you picking it, I will eventually do it.

Cheers,
Miguel

