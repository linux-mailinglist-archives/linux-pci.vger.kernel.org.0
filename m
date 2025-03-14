Return-Path: <linux-pci+bounces-23751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D2A611BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AED01B61FE6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FB1FF1D4;
	Fri, 14 Mar 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krU0OQSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87631FE44E;
	Fri, 14 Mar 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956595; cv=none; b=VCVCvDorHX6jxc/BXD7fnOD8yh6FIHOqM1phtGZo9UO/udkc98W1//B99Tl+JzCzj9gMx1Pr00X63nERqrZAfzmi4K+knpTPjW+YVTRK9I97IQDYYc/gBLfBPOY4rfEa4kTFoz7uG6bQt1uioruGflp34bG2ejsqa9otqDj6NvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956595; c=relaxed/simple;
	bh=X5zqCLpGyDYLA9j9uyKQAE8GZpKSHtYrqhwWQuvKGsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQv9bLcP2QznTRbH8eHFGhGBSkoJC1hE7pB5Ojre1B+hIZuM5CijEsImCt1T2rE1bW6AkT9h5+JhJhMCdojxQP27mt+Ba91EqsEjQ7JzCX7tIXbqnPMQYfkjgHVrmimC1RUVHLZ66ji763ixPEgCT4eMYgkma+AnsxoYUKLHluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krU0OQSN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso3636225a12.2;
        Fri, 14 Mar 2025 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741956592; x=1742561392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5zqCLpGyDYLA9j9uyKQAE8GZpKSHtYrqhwWQuvKGsw=;
        b=krU0OQSNTusC9ehThKm0UwB5X3ehnSGjeHaMNpqcFb9XQqldkb88Dc+k1yuI0/KTOs
         QF+Lt79ltY6LREPKzwMpA5SejcFBthqY+xzuw1r6khIJM3y0hAdL1p9MrF3uiyC99aoV
         HIFaFjZ/am1RAjry31jg+oy7LO+xPunFxSHqWoZOFWNNnz7BVRTKOyJmIgH1VPTV5ZH9
         OpCZ1AwmCtgDLpZGlPhdnzLguHfb1rfAkjj/HK14KK50tNo6pjfZpPu+/kw+dzqHuFHX
         vQLyVTaEXTrdEbQVTznlLQ4zr4YeXoQP1A8WBpaXoU8PAFuyolVZzPzs9IITj9fr46Fv
         Qn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956592; x=1742561392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5zqCLpGyDYLA9j9uyKQAE8GZpKSHtYrqhwWQuvKGsw=;
        b=WWmF/HELDoza/u7/TpRIW/arl6UFhmkWcBKM+h9FuFtUNAGqQKk1jlxR2vAgFK0Zor
         Gf6mTKEpZ/iGlv2MB2qbfmMEk4e8kX/UKBmzI6LXKNL/AzGUi/pFBtkLKFUv5gxLSiHH
         hw5QKsrK6/ISUZ0EAtch15hOySHNPQv/XLBahWKn+m5q3HvsOOKOlkhbxYJII0rx7uTV
         ycHZIWBjwtInMC7HYF61N98uakmxTBIXo++jvh5UT3y4/IwCguUlzKtLGggKynnGzSL/
         vyuKPO6IyY740UgpC/fnpYIzuxJcIqtEYisGwZP1kqN4UBGQ+LacpZ6G5y3G5QiHpiOn
         FHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa0lRf320MpiF19NpYZw/DL1v+M/4ZMmZhr27VUAZ4KIuftIzDAp8/1tMO913EeHlm49WTzq7ZUkkwQGA=@vger.kernel.org, AJvYcCXMN1LXDmcb03H2By4hhdFHSkyx2c8endE9u9NuGK0lZQB7Rn/XvYk6Qq+5zLUUxskDq5lpTT4vP12h@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoNu4Dc1x4dO/0Qh5E05QFYQfAw6ZRyl9ThRJla3TPkbzGibE
	ymmKSNaBLUy80TrvJF1LzIxbru1VPQeo+WpNoSFZ24eeoxgUZqeKBmFJQjqy23Yk+dq0Z3M6lir
	H8GYH1GtO5Y0x2AOLJeKWgOgZshc=
X-Gm-Gg: ASbGncsRCK1YRhSLSqQeBFs9VcXLH3suZAb69OyGQxe08J/eVAuoXIjVBPqcSxgiTY9
	AAPHERMJKM9J7w4foaQjye/sbdzzCietEnd6/tdCTPnlEtap1b+VQeQjHyV5wzYjTadgiD5REy7
	sYMI5cCv/pubnUwUIc5HvLSFt1KmJtq6yPK3xjDWK64pc7Z1U6jJZEgpEA56n1
X-Google-Smtp-Source: AGHT+IEGjdkdr1fGzpz3lMEfZQVZH8C0WzNs9jmVqKwfp5G6gM62ZAjOAOpCk1J9jsxltITKchYxgMvNxAl9HVGZLPc=
X-Received: by 2002:a05:6402:34c3:b0:5e5:bfab:524 with SMTP id
 4fb4d7f45d1cf-5e89f24ef49mr2591094a12.3.1741956591938; Fri, 14 Mar 2025
 05:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
In-Reply-To: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:49:15 -0400
X-Gm-Features: AQ5f1JodQ1cMn9jAHSmh5rXhI1uUOHZC-6K9hXSSgoYaQ-kS0BzkUlTCSiWngGw
Message-ID: <CAJ-ks9kUUtg5BiTztCckbaU2F74uxhso5mT4Yi_p3n9LmhYZYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: workqueue: remove HasWork::OFFSET
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gentle ping on this.

