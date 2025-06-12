Return-Path: <linux-pci+bounces-29531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E8AD6DBF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BE11890742
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84B232369;
	Thu, 12 Jun 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAZH+8yC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D422F16C
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724188; cv=none; b=U6f/5p/NmLQSkNUfFn3wKYq4NyOOHUibPLyo7CWzOrvO3Phnh9+O49rusuPS+v481jawTWypilMLriXzfvM0Qzw4M92D05fuUatkX0VgPfUqtGn40Q7T4EreEPMBBI8XaFryuMrrnsxqom49uA/Oj1K6SPIU3nF7sirerDboIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724188; c=relaxed/simple;
	bh=LBiZjj1c04h2wKgu6SjWXxVcIMRnF5MvTTsJHW2Ksb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59pRKYtUQUhElM1orzboSBhKyjjcyiLAnVCNrdPkQQ2ZjM5bsTcBDAbFggKO01lqJIFrCxJzX1Al5+xhMIi+WgCJ8BLlEqCqtyYDEhIMxUb/cMyhPyiT0+wqG650s9ypnEYPxmwRHVHEzMLPRjiGYrHVdCV61nBmGYUTFV17XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAZH+8yC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso719927a91.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749724186; x=1750328986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=ZAZH+8yCPSa6m8A5OO5z0I+JsTAU0Y16O2nTUn0F+56+r4H3gZVnoAs43LeHeEbCeb
         UU1ENxbcN8vJW7HEkqhS377VhZC/Km7dSCLKUTzgmqpQ0KG/5J7pLYpGferDpDhSFNaZ
         cnDcxUrkg7pU8gF4FPVKPAtJpx0tWNY9mmXLaq1j+5gE6IHIBR84s5wB5IYhwBshbdr5
         i0KHpk8mZS2oginkAgTPBGveVcfmeNxyAg01OzNEOfwIAwv6arYqDiFpyCW+FvCXBkEw
         hFZRX+FKPwJpl1Ocp+Se7/g49JGvOL4Tf09aWrDf6rVJXIVu/pY0xVFJUa4CfQFZhq6/
         sGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724186; x=1750328986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=Ck9bv5lj8obgA2tH1sNre2EVCMAV2bixgLoJac1TcrZy5EAwFzwyo2B9dMZiTeR9Rn
         oyAa5mtNLStqHMZU3/BCOekcjnxN8qbToMGhM6jdWDU06o3fpbFYWu8YKlqCgK/fTSO5
         AcAWlWOyuI+3zn+I1O7cVSgIX9+XbzpImt726q4BYC2Ditboneifmr8hfFGDqmPpoz3V
         RZEAdoK5Ep5C1nBbY8N+KvCJrWOVcHnVXQpxUIdCJ4ELunUWgjvfgpDrn5J4xu5ZdZd9
         kMYWSCEhwyYtDz/QITDSmTlygCTEBGOlIkk4Gtkms5isff04tlvc0m3JDmlHP4ZMO6i+
         xS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVMdlqOklE3LUcYGk5jF/AAkrnGSyxtta3FJA+DnDDa89cN6lkyOwvmZmkkfHYNrD0Nj6FuWVnJ4sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMg4o+YqvTvbNBzN1IbHaKdelhb4sfLRvKrlI1pcWGxY+zzQM
	JHdKN0XuO/UqzZJZ5f2MBLm740Dl6VCQwD/Wci8Wv4y68zs40ZlmktFBb8eZLhcgPs4=
X-Gm-Gg: ASbGncuOWrTIxqpqZTpY5VcOjx1xIDW4q8aYUMCbDUJUI4DxRrAWKkQB9sdEGuL+nzB
	aURToznpTh+5GXmdOk9h8XLd0NzBp6fx99HhrnPFyNhxqdyovlrZtqwwRr8i3UZ/L5YeVJ5Ckdp
	4SmqY6Q2HUJEsm8RIPp2yo/eH/640Xo2Nk5y01UVPxYsF7+neRYo6P+vJ31ZMXdr1yWumGU2onE
	Dh6KL5AdwNR8/QH5PyfPvkbnO3DKh4yakHBlMcT6KjDH04RY50G/LAjaASmP73pivOoXYRtys37
	c0ySR/q4mJKkmtzqRaUb1WvWICsvYn0T0Rcf0Of1ZxdH3khUXRgRdtlJYphxsW18qKZIwfTUEA=
	=
X-Google-Smtp-Source: AGHT+IGj6zH2i6FSYnQuoWZbvieZJ82el41fbjoepfDccYSCZ6jY6ZrPdhwat+GRxvtW+AAp+Hs2QQ==
X-Received: by 2002:a17:90b:4986:b0:312:e618:bd53 with SMTP id 98e67ed59e1d1-313af1e44a0mr8462248a91.26.1749724185738;
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b4besm10717505ad.27.2025.06.12.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:59:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250612102942.iqdqmu3dolmgtmio@vireshk-i7>
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
 <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
 <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>

On 12-06-25, 12:22, Miguel Ojeda wrote:
> Do you need it there? It is trivial, so it probably does not matter,
> but mistakes are still possible (like it happened in v1). Since it
> touches files from a few maintainers, it would be best to put it
> across the "global" Rust tree (ideally with their Acked-by), and Cc
> everyone (e.g. Tejun added now).
> 
> I also have a fixes PR to send, but I was not planning to take this as
> a fix since it is not marked as such.
> 
> But I don't want to delay you. If you need the changes, then I would
> suggest just applying the parts that modify your files, and we clean
> up the rest later.

I don't need this for my request. You can pick it at a later time.

Thanks.

-- 
viresh

