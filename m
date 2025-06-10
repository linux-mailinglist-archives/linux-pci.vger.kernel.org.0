Return-Path: <linux-pci+bounces-29286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270BAD30D3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7543B5A0E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653382820D3;
	Tue, 10 Jun 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF3C4YHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22A2820AF
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545340; cv=none; b=FxwrL3rx3vMlM+Er80iREjQKWiSbMYVVG6QjXA9RUNooauJ5iRzWOE9/iY/YaKWDocP8eC6NPgOFJhMfz9MY8IOiTFGU659JoyOv2jJ8VqYns0vH7rPhn4ImwUFm2LnWSVLR1d9QqqM9obhIhX3AYssyIHiQ8jp12QOGYIAL3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545340; c=relaxed/simple;
	bh=EuO+QvTzMIbD4nlEx22zLgg2q/soEO7BzVlioZGxJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctnl/KzvmlJTQtIdNm7LNo9omLT+12SA9sba4ca0uPllHFb29AEwgJV+GpOOGILz0qO2G8aaJTC45mS4O0dNgwhZu0bpPJJwWtX9Yy3seoaVPP/aW1oZfAjhbACRceg5/ptatZ2IV5iof4bdZQ73pblYd48buNGTuN93x3R6Pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CF3C4YHr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso4100405a91.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749545338; x=1750150138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss4LNvAJAPZOSbZItGbwVQM6kPBhRe2N8akCDyuKIIY=;
        b=CF3C4YHrIilEg1/vLZgBY8wMeXGTqgB1+OIiQNA7saiRzr3VdIDz+4JXGn/nrg6a7b
         e6YNhkp1cEaQy1zdMvj8KHretMFPGbZIt9JqHnbb38qOazY64TlWnChybJ45RUJ2MFR3
         p2uqCR7VkwBh/PQZub6J9i1zmQoynGuypVhkjoFK4uZpbF1z5vFxEUnX4S+xs1+EDg0e
         oJbd35CAsa3Ci5opC70qHMualml1K5EoNE3JCGyvyY+92bf4bynag/lCFNcwTymS4wti
         nRa8OdsvkBUavXWf1qPNFz5gw2YzwCt82+eBcCXlEJKQ4MECIUGVm+jify+6ti/Ltj9I
         /37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749545338; x=1750150138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss4LNvAJAPZOSbZItGbwVQM6kPBhRe2N8akCDyuKIIY=;
        b=RGy8CrmdkfQuAcBHX1nL9vVpZCPNyWSKge8V5oubUIJhPI8BxoJcbIAomZI5qGaHlI
         gimhnjc/94Tw0+wQ+0BmL0oHYUah4OK69MuyyJ0MeU8WVe8XOpv8eHoHi1gTMXNBbgz7
         ZJOdU7LdBcZ3ObzhQnMxCyNRO/6IC2Rqpr906EbU/XF2qObvIS9wdpGYx3D6FTV/3JWC
         am8v1nkf0sCnZO771emGNyXD01uMeX2TzuaHw1c2h5UmPHZi5wtAcCok37Gvcj31WXj/
         I9bPuBqSj3I7HBpwoAjKGv3G11ZcNhP7iB8PhKx5zzD3dtfrBQN5n/79aA3smLGNG2Jw
         DKKg==
X-Forwarded-Encrypted: i=1; AJvYcCVQxkcgSZsxEThFqDNgUTkvcoTk3eBkYkZA4HN0aiQ0wHHvoIBgh1AHIBLoOwvao0LYlIRYga9vWuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW85847Lv9PvcqucjIZVLpkN8Ri5g0IL1yAgiXhfJpKY4uS9YU
	9rD0btW+DrInTUhxd9op0FYw8mayQk4QP97MU869h1b7jOb9wZWcM6xoGoVUGOHOD9c=
X-Gm-Gg: ASbGnctnKMqipfJ6EDNkeAiswTqVdbUMgfKNkW3GV3goQXrbZQlciNxJH7kDQl+JKPf
	wgs6LUVWP7BtgDYovrufGT+VUkBRv16wIDg9zAoc9tfQiRqaKWbjw+NlZjhGn5fv5jYoMuEAtkP
	qCHCUvLVDO85cu5esqFspohEM+MOtDhR08fy3WJBRG4ILzQjlJlL2vBTHkSm38RWnYCMTI+fYcm
	u4+hi+xDnK/eZ/XSSzBpHXlqso5d5fLdioSXUdrTg7H0KZu04vbkfXVdeYiTN+F8aWo4jQtLwl3
	VswCglZ+BPVZSWAsQVmz09S/r7S9M3QUW2NuIFZKRG3LzqXStLSGx2Xcipr2hyg=
X-Google-Smtp-Source: AGHT+IEDPYsFbgp89aPfICx0Umrk6sbupHuAqIkEb+dotEFpfbA1SSwxKzTRtF7vXJvPanU3+ClKOQ==
X-Received: by 2002:a17:90b:2d4e:b0:311:afd1:745b with SMTP id 98e67ed59e1d1-313472e8c6dmr24276920a91.11.1749545337791;
        Tue, 10 Jun 2025 01:48:57 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc373esm6836882a91.32.2025.06.10.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:48:57 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:18:55 +0530
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
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250610084855.bofpldcq7d6kurim@vireshk-i7>
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
 <CANiq72mhyBOjzmvmUDfgFBoRqO_aaS-CL-ct3vmJ56HoJAsV4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mhyBOjzmvmUDfgFBoRqO_aaS-CL-ct3vmJ56HoJAsV4A@mail.gmail.com>

On 10-06-25, 10:34, Miguel Ojeda wrote:
> Note that `##` is not necessarily wrong, it depends on the intended
> header level. Top-level headers use `#`, second level is `##`, and so
> on.
> 
> (In particular, it shouldn't be used as a hack to get smaller font
> size in the rendered form).
> 
> So, for instance, in the `workqueue.rs` one in this patch, the example
> is likely intended to be a subsection of the "safe API" section, not
> an example of everything, so I don't think that one should change.

Thanks for catching that.

-- 
viresh

