Return-Path: <linux-pci+bounces-29220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC9AD1E1C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C90B188B204
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A68255F24;
	Mon,  9 Jun 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsZa0xET"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855213635C;
	Mon,  9 Jun 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473473; cv=none; b=kReqVIS/IvDoqhywl1lh3jA48p+wyhAT/hehayidAYrwGX4l6WF27eUEL6unbsM9UVcPPtMUMy/Ry9NXlrNq4+fCJ1za1fz5WEnzcyGGhnLmJLuUfh7w73sa6CEBKwqyrM5/uGNKsZJots1zjjNHZq1XUc4OAkqOVxaI+d7DkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473473; c=relaxed/simple;
	bh=c+WUIqhx9QJ8zbedXY9buZNn58HoDSjcAIN2lXOt8jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uocZ6s+FUSOR7+Zoer+73+rLZTsOUtnl8Y/QYxYI/LGKP4ziRM1h+ZtN6VqxxYEQO79UEKCYLHIVUJbndBeT2KQhY9vWI+1UcxNC7TIOVKdQgYMI1oyVgSOWUrIJnq4whyn7HxstzdXE8dPjtVmgHIRuYd9D1WqngfabQ5RVVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsZa0xET; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c384b2945so3182405a12.0;
        Mon, 09 Jun 2025 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749473471; x=1750078271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9C90v3ImIZv7UydPyW7LEI+N3US6KQ8k6AgX1ptSNqo=;
        b=KsZa0xETqj2GnskXpkYNGHWAyHmtMIcd4rwKI/fQeokbzAkMLbgjlIIBUftZHBbxrs
         HcW3VqZccaVuGjfOcSeX5R0Rz2dV/TrwJQNF+gPnrjahTqXC1zesuTQ0N/ScYD7abrH3
         NAPkVq5YTJd1PLL9p5LXlZAD8iZyQTvvPMrxrrkRGO5+5GjpwWPNiGuFQJO9eQQGmcJ1
         vNTP11di7g1pxL5TkGlI9mn+B+VzOYT3RGw/bIPhd75NfNNfhguorjcKr1xYd3q4ghIt
         LycLdb1+Y5H1XCqkfwZyEIYdi3jIJ+laCLrZQvF1ZDgwIOkW6z6Wb5/Y/fJdPaleD4uy
         T8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749473471; x=1750078271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C90v3ImIZv7UydPyW7LEI+N3US6KQ8k6AgX1ptSNqo=;
        b=c0G7Ak3houfz+YBat//NJBvsUXRiXuSuzyEzizEv8Sz1DL0qA59rZUMp3nLz3sUeTy
         cxZ5TsFpVVLC/nM0TyoqBqnAShgd0efg0gx/NI+AsdM9X6QHUgQ83s7zcuHmLwJ25uC5
         SglgU/yioCC1TVLn22QLqid7EnHWXInAz1FPpnoawdrayUz+OVTqrkDBKhvqeIRNAymX
         p5D7olvCWdqwGUEdZ5umhV40WUSx+tSMyYPH63LSdIad04ZbXvO5k6EK5mjJFFTbZNT+
         LD9IkTfBMKBydLptPZU/M7gndux/wpUNOcr49brdaL+AKnmQ8dUizwotkC5KBIbJDoyf
         KNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV21N/j/SXioJ6uOt0Z3KBz49m2R/PMZozGyuemLukCWKLBnEBtYtKfd+G2b1/cQx3I5+nDuJjHPyyEsPA=@vger.kernel.org, AJvYcCVKN73Vrd0j3wxFbhJS9lIJMlrlIay7AaOO21GrMr7P4EZT13NtlvDWtGOqw2lKchDYfeSooykeJydV@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoknMq/egX0zbgfFO+WNWQKXwlsehp/vFOX+kNrOcMzkrMqVE
	1F90nfABbbueJMHc8AL/mcLty4LQ8o7rDggNcduH3NFc8hm2DzCNbiCu
X-Gm-Gg: ASbGncvTYHOjFLq1SXubphXSIBdglC2ca3oq8FbGYaAPqD6TgSSL3uId+rqNNFqEM2n
	1pTjL1OSFyKlH3u55sJf5UMCH49nBlYPd0mnl4ePR74m0duPgClbdWTyjHqoihnelHabTDGYchp
	yN+cvbqA0Y91Q9TIRs6Px2Zrjd+gMTiLbo10BHzIVtaMvRAzYaGtVRdwtpC0GFgcdfKJqrK3A2D
	gtDGDs3HDJWU2MUWO7W+iqVXVMjMsA4A1TSJ+0SlKHYHilsgj9UI2LJd7J+DWFABNkRm0W6H/F+
	ovbM24QT+jPvrJ14f9W+NqmMQsOcR/uLdSqJdWhdcBubzNb6A5TDBPx4y3bW
X-Google-Smtp-Source: AGHT+IGdd8dmqbyUaRhK5fCGOxSgFpjbYr8iwfVIm0WyVUzmcQ1qKNpUKaJ/KyU1XDsl+cxD311bOQ==
X-Received: by 2002:a17:90b:224c:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-313472c0115mr19004864a91.2.1749473471147;
        Mon, 09 Jun 2025 05:51:11 -0700 (PDT)
Received: from geday ([2804:7f2:800b:40ac::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fdf554sm5708242a91.35.2025.06.09.05.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 05:51:10 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:51:04 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Quality Improvements for Rockchip-IP PCIe
Message-ID: <aEbYuMSE5hsClaB0@geday>
References: <aEQbx0Qu-2UKhV1y@geday>
 <2266650.atdPhlSkOF@phil>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2266650.atdPhlSkOF@phil>

On Mon, Jun 09, 2025 at 10:50:45AM +0200, Heiko Stuebner wrote:
> Hi Geraldo,
> 
> could you check your settings for sending patches please?
> 
> The individual patches of this series did not get "in-reply-to" headers
> that would point to this cover-letter. Instead each mail of this
> series stands on its own, preventing mail clients from creating a
> threaded display of the series.
> 
> git-send-email normally does create these needed headers on its own,
> so could you check if you have some option enabled that prevents this?
> 
> Thanks a lot
> Heiko
>

Hi Heiko,

I had noticed the same, I'll fix this for next submissions, and
thanks for calling me out on this!

Regards,
Geraldo Nascimento

