Return-Path: <linux-pci+bounces-29804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98009AD99AB
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 04:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACEC189DD71
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 02:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1053A7;
	Sat, 14 Jun 2025 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CePdE9ql"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4A3FE7;
	Sat, 14 Jun 2025 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749868296; cv=none; b=BgvLm9lQ5mGpXDeMzzH1v3EXV63w8ZTOSFGw1/ONGscH0fc8WdoNj4DebeEHi3Up6dEG/7qaHpE7nOY7wyxEdrfLknDXXx9s4COFIwsLCpFzhMwcGZWHgv8fB90zKufpoi7owHj6J4DyZ3vIHgv/8/LpZjfjSDlG6SGwAjJpssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749868296; c=relaxed/simple;
	bh=muvH186xbp1wZouT3DAGJVB1Ry12NAmcqUPQ49mvjxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnS2a2C5uFdoBQUjDDKa5/1hwV6iTxCqaxJNqkZmRzlkreHBd8sMDtBSbAT4XjyVpvtgyaOgbq0LeiUeqRHZ+J7cnDsvaFnkJ64xm4phCu2PVGVGxd5W1bG/IsQFM2DiKxOfvAq1BNSkCsEo524Giu7YFZmBqEH4AHpmGBF3S/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CePdE9ql; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so2235385a91.3;
        Fri, 13 Jun 2025 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749868293; x=1750473093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muvH186xbp1wZouT3DAGJVB1Ry12NAmcqUPQ49mvjxQ=;
        b=CePdE9qlE7gh4vNL3VeKp/XJ/A/SwAOBVUTrART1T+OjGTQDOypwSsCUf2FTDnrHxa
         8WO6SGDOL2hXWcvgXtWm7gZlixppoqRXD18lzrM731glQOK0Bv9XsijhBH+Sr4w4qHxz
         KbXzCzQtMclira4j07CwLoqXhu/CZu3PPELRlxHhrILKYthA7EQbEZFSoFFc/U/JvO8e
         0nIIa0By21MFEc0a/2sl5oNh7LSjl82q/LWHMsR6Fgh80C+R0nm/8pvAHPQ6mK3yQFyD
         JA9llysN+xiNpLWagMxXOhD+VNK5ktSQw2qUlmiD5AkWVDBa3+p6Om+9CHO9xJJ1cEKI
         zGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749868293; x=1750473093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muvH186xbp1wZouT3DAGJVB1Ry12NAmcqUPQ49mvjxQ=;
        b=I0Op8cDOw8prJyHNteejOu8fLzM3dRk4M3wQxvfPxB3NiT1hoQF2UcbRfmf4Rw0kyy
         eA4EueVI9vsjnZDnBBlmLJ9OIJBpYowP8PsnUhq7cWOG+BHw7314vjVQ0Mp6TLD/2Lst
         KHr1hvHNQ9T4LuqpOGFjvhTDqLPSu1hZTSzDUXU6yO5JqKqPwCvg7p2H73K5zC7m2Bsa
         Hb8pWE4DHukNZMriWs2pF/4rqLBZFfvI4FQcDOPBaM1yDsXsszlTMSslFZbLBoQuiOWh
         XhZaF/8bkk9IqjknIbX4FtzPJWICeixHJloLCKyLtIZRqT5L6NAGPmZ4W728TUQP6WDd
         CoLw==
X-Forwarded-Encrypted: i=1; AJvYcCWlOr8bZYMPpDvU2gYbd27enwa/kVDkW0S4rSbuD5NnMMtkvibkrPqRa9Xcnz2FZyMMxAVwl4pdUO0N@vger.kernel.org, AJvYcCXjAvBqIajSE28lHmoVqcOvMfZDFR0X7Le4PTaP4u8bfWA49YRjWspRjiEjY7potoyzaY75tXGlALRI6pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeue9q3FvmiUW+ud1iS6djbIYSt8m5uiynSpeFN6JQK0ruAp/p
	891xnElKGz6gg187774ZMNMYMltN+41uU9Mew37fVl0JHgPa+Nxo6pkX
X-Gm-Gg: ASbGncuvxZfstdoU3EJ4LCswyG3UWNLlLCsmWUOE6YzlmrbjfhnFfwoNbyLhKn8nTRj
	m6rrHR5rwehOoJrjWgRuk+go8raBVDLirguBPmApVQ2sv5If2uNDAilc0Fnjgq5TViX6cDxSZCe
	PHEdg9lt1FCG0lR3mT2yoJxeQoTv/p8LJ/4RuMgvbuI1hf98CXSnz2m3FIw89KO4nboF3eZDuNt
	23bb1fWXikVnMLmMGctFlOSnZZfofdkq1gMJwFzkESlu1Z1Wd5WIvy+oYy7z6dL5ocyGoO2FXvW
	NCXdZLo8T6XA76XB//9XBX0I/OuiYp9vmHao68n4lInNOFKU0Q==
X-Google-Smtp-Source: AGHT+IHCj4fIQmaD0smD64d+WdoNvxKcsF+LPm8LepKLk3m/wfu/XLkOZVHbtI+96XbJp9WpjbjE8Q==
X-Received: by 2002:a17:90b:1dc4:b0:311:fde5:e225 with SMTP id 98e67ed59e1d1-313f1c01641mr3118796a91.14.1749868293053;
        Fri, 13 Jun 2025 19:31:33 -0700 (PDT)
Received: from geday ([2804:7f2:800b:87ca::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19cd5a6sm4158494a91.12.2025.06.13.19.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 19:31:32 -0700 (PDT)
Date: Fri, 13 Jun 2025 23:31:16 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe
 defines
Message-ID: <aEze9A8jtNsZLxr7@geday>
References: <aEyJhoiPP0Ugm1t6@geday>
 <20250613205023.GA975137@bhelgaas>
 <aEyRrtMZ0LidhyOR@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEyRrtMZ0LidhyOR@geday>

On Fri, Jun 13, 2025 at 06:01:40PM -0300, Geraldo Nascimento wrote:
> They are not under NDA and can be obtained though Rockchip's
> official site:
> https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf

Hm, sorry about the confusion Bjorn, that is not an official website
at all it seems, so I assume these are leaked?

If so, it's a real pity, there's not particularly confidential about
these docs, and they are essential for working with Rockchip chips.

Sorry,
Geraldo Nascimento

