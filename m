Return-Path: <linux-pci+bounces-31678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C5AFC917
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C4E7A92F1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F5F2C1596;
	Tue,  8 Jul 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2OgfI9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D9221D87;
	Tue,  8 Jul 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972369; cv=none; b=ixKXE1dnWy/g62BSTGHNi2oqucKNyh3jor6Wnhuc9i7HBB+4O4oPVPZMI20hDivz2XazbrAyNikAz49L/jzChKsdkzsBPrlsFlRsa3wq3u5K/xk+MS2bm4CBuILq27SEUU3JwWAv/USAJrHzM2ZpAkdM/B2M3T6KU14wYg3UufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972369; c=relaxed/simple;
	bh=0/UNW9wheUfOWipBWnE9bEKfNH0w9NzGiUbVbmxjEVo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hxyCV1L7x/4U1z7l/sEAW8WmcTtsSkU4tGS7MBdWadA+0nFaYAvc51fYNy9A337+z51EI70bFaBMMXERgZBk+MlsuAKfXim4qBomBD3zIfJviPgBRiq0T8njHZ6x4d8+7NBb3WEszNjHpDwwcTPSJZpyURXSkMQPJCx9bWuWS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2OgfI9+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c8a5053c2so30215705ad.1;
        Tue, 08 Jul 2025 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751972367; x=1752577167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/UNW9wheUfOWipBWnE9bEKfNH0w9NzGiUbVbmxjEVo=;
        b=U2OgfI9+e7fisbhfc5nimWqu7bWqoIAr7/J1GD3RsFeOIYkdKRAJ1K+D5FcgvIvvOr
         0BqZrWVYB2rmVipQ+0M0m+PK2mR3J62U59NBgVMtu3S9gRM0g/lzTIeL6Qtr2AUyrrbI
         EL+O48DAOL1XL4SS6gLZmM6Eee6NsHinW7D2GfDmsVL5+f7eyEWTtV7bkl5425+jv/P3
         SSlc4JSBA1tWceroTnUZy4saekVx3aMY2dlPU7KtXgD0Da+GTZpVyzoV8zd57mVBvkPE
         x3S2f+vT8cA8mW5vIgJglmriNCaoep+QHNdKzJOQb+5ehQX29GXO/z9q4VXSj1l4Dzor
         aOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972367; x=1752577167;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/UNW9wheUfOWipBWnE9bEKfNH0w9NzGiUbVbmxjEVo=;
        b=cKQfTMekZwCeLcP4Dv6luduAZHFCdd2fcxtqMf6GFM0QRK/dmZHqaYXcEO/uswcVA3
         VdtSqDWnlK6qVW7MD6HX/z1WjXM8PEqaD537JQdbFLI/eEK35ZTQR3u+09M+0CWJLh6k
         RQEEtAtcTL3vEYdFWbsaduR9kzbCUqaofkDx24BeZbgXOX/aAWNwg6XgF4tlpLGk8IYk
         8Bb00/3eOOq3Lfrb/8CbemwFjc9aUr2SWb2LLZuM6M9fYvGi8BbbBwUjdt/mbT/B408m
         yLuCu5p7Ybe4dA5HF9xBMW/4dYlslPnRBYxKAWCqv4LjgB1Aem0LqQcYxW7WaAFS7NCU
         fbAA==
X-Forwarded-Encrypted: i=1; AJvYcCUFc0kb9pZwnMLarrxLJvulPiikhgd1Pp/NzMBCxvAZuo6BpYSRVJQD7AnCLf6SdxtKOjmJYNcBQDuh@vger.kernel.org, AJvYcCUoMVrIrxJSMRyKvwdRiwqfpLHHgUHWTOhQTBndlG/9bvtrjPM3JK6t+Kq59LM9JvJOLkSJmr10TRsN@vger.kernel.org, AJvYcCVhwzUf621Ze3/ngocIW3XBsk7z18Phg58r2uBy/x2sTDupLQQVdrVqjnjSSvanbLX7KbWLXFo1@vger.kernel.org, AJvYcCVk35H7CtCflfFVFfFGSxpOEtsrUe+eMeBIzwxJe1KNzFRq1roHKYwBCfPOTo4DePqjOuv9ck2eP9HqEeVG58k=@vger.kernel.org, AJvYcCWYSKy7Bnr3nVA/LRujmwUcfKFqMjZ8pCqAldRA4h10RaXwS20TIPwovbRol47CXhGIFBx6ehnoaU7T4iOQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzonG/KZXLvYg3RkHDQXuzd5E1bCu52TOitOt0G6SWJ35rM3c+b
	dfJDuQz3PQsFLeErdw1Tvd5FjirJr35O3HPhdA0ji4mLa8hFhgbj1J7V
X-Gm-Gg: ASbGncvG4/6eHF3iklPH4obJqUalz652hFUnPI/dZ4lvr9tqx1MdR7f4jJ2epVgSAL0
	kpuXEo0W/3tkE9ZTlGoYbDGWomWCb9SkYOgnokfWi3qsmaDDz8Ej5Ay7FKoLO9l/FnAvNRdNcs0
	tBXuReQaP0WrVPLM11M7TW2z1au0mGLF5C0A6QytlNwRRz1iaTAvUldnAdi0+eVQt8xN38nTG+B
	BCHgkUTnAg9YhTTzUvxCSlfj6KCgD6iKmrPRfr2us6Lyjs+8u2MTP1Ixs+B3zaVTtuZXP5gnPwI
	rHa4B/DYRAnEuqNFkVrAadLA09H5yQXIkHMBkh3EuLewo2YJ48J/kwXDHuD/Agjo8ULesaZsUvp
	GvOiXd08a/DB8bCRA1yuanJMDLnZkXoXdbB3RB3pa
X-Google-Smtp-Source: AGHT+IEjtoxx7Jmd2o3cc0PIJOXAP/15axQil3qlYOBXngZOSgGl0afSYQ0BfrpKWsYYD7pbrBr5HA==
X-Received: by 2002:a17:903:1987:b0:231:ea68:4e2a with SMTP id d9443c01a7336-23dd1d47317mr36460885ad.34.1751972367127;
        Tue, 08 Jul 2025 03:59:27 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d27asm116131995ad.129.2025.07.08.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:59:25 -0700 (PDT)
Date: Tue, 08 Jul 2025 19:59:08 +0900 (JST)
Message-Id: <20250708.195908.2135845665984133268.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: kuba@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 saravanak@google.com, fujita.tomonori@gmail.com, alex.gaynor@gmail.com,
 dakr@kernel.org, ojeda@kernel.org, rafael@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
	<20250707175350.1333bd59@kernel.org>
	<CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCA4IEp1bCAyMDI1IDEyOjQ1OjIwICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgSnVsIDgsIDIwMjUg
YXQgMjo1M+KAr0FNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4N
Cj4+IERvZXMgbm90IGFwcGx5IHRvIG5ldHdvcmtpbmcgdHJlZXMgc28gSSBzdXNwZWN0IHNvbWVv
bmUgZWxzZSB3aWxsIHRha2UNCj4+IHRoZXNlOg0KPj4NCj4+IEFja2VkLWJ5OiBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiANCj4gVGhhbmtzISBIYXBweSB0byB0YWtlIGl0IHRo
cm91Z2ggUnVzdCB0cmVlIGlmIHRoYXQgaXMgYmVzdC4NCg0KVGhpcyBpcyBiYXNlZCBvbiBSdXN0
IHRyZWUuIElmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCBpdCBjYW4ndCBiZQ0KYXBwbGllZCBjbGVh
bmx5IHRvIG90aGVyIHRyZWVzIGJlY2F1c2Ugb2YgVGFtaXIncyBwYXRjaCBpbiBSdXN0IHRyZWUu
DQoNCg0KVGhhbmtzIGV2ZXJ5b25lIQ0K

