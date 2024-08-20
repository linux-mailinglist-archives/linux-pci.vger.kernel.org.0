Return-Path: <linux-pci+bounces-11854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E7957F00
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461BFB21512
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4C17B4ED;
	Tue, 20 Aug 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+rXyAAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA51662E2;
	Tue, 20 Aug 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137608; cv=none; b=b5B0AT9VX/3xU6nHUBQCFaOmPNxY1TZ3TwlmeyukZwu1Xuo96p6zUc4fhsAb0Ntj991SRHTnVuMxSMmXv9hxONl7ltjvmBtNQVbgdSo72GS85mQZDl6OKqLL8KmL+zoHSO9ot/VKo655WPllQi4MVXokJrCJI0pVGhUEMuuChzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137608; c=relaxed/simple;
	bh=RBmBgqN1/2wimlwuDiZGTR/Ixgo1CtMYbgT6F6Br6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACP/6g9vjZXxmxzFtYLgMoFatwBGdgLx50EreJ6A2OpU3zCrl0bNojDabZfOAR7eocGam+I9KRvMloA4ai6JasKn36VhjowrpIULPX8FJ3J8yTqurRKM+fxpD3nPDEFGTzNK6gau8gYuoPfTnzB2jMO/Yx+xlX0PXob0d4Z8qTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+rXyAAa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so551306166b.1;
        Tue, 20 Aug 2024 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137605; x=1724742405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5XzteqfPZidWAoDfu8CD574QN5U/gDbKmwzV72JOdA=;
        b=U+rXyAAadMKrJYEPUIc3+hdWNh/2v208OnwcjI5o2Zes3wdfL10m4uH8zpjSZmGe8j
         AbvrLD32iTPtm5H1UVv0dhjlA4svHevdT507Sq+ivO8a2sn8JcHGnLePyqDt06T+hguQ
         NzYyrdFEoStdI2F6LzKdVGVwc3mgl1tT89StdcE52HihY/1dnF+NZ8vfuqdyokZFGQJj
         I365FL6Rb0QnowATwGghmy5PibwDYbFlcYApc+JGdnLtsRLzOZeBhtwEzVZH51htUtPq
         KfTDI6HNE/L4tZIn7Sq5vQOCve93B4m/w2p+coZLMOM53nwSSnsJVlZ/9PAR3LeIxc4/
         BPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137605; x=1724742405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5XzteqfPZidWAoDfu8CD574QN5U/gDbKmwzV72JOdA=;
        b=HvcdcloC+SuOcEhl0ybWglEgso8HxSJPYVvdWMOSUyk5fYC2L/3LzBUQknEx6ceudQ
         iScNqzUlBkgODnuzRYoOWWNWCLK6lWt2TDhX9ZhGBlqtTvy/qJwonxiRHBA9rKpMMoKy
         JSuzcg26cQ3gmt3bezjHtoZ/wI69CBWkxTpdE4cJFujDu8hb8zS1EEpbQ6Az2x+/ACIB
         PGRk5Uolc8bubtWw1JcyLqLgSsbN6KZN5aMNiYL5hOsjjcZEkQY2XL7+zCEQy4eLPdyd
         ir9FSkFGM7fVC6XcPw4BOT0KbDySwqpJ+CiRiEHXD7WNlxACYJWn3v2erp8/guujTLHE
         yRew==
X-Forwarded-Encrypted: i=1; AJvYcCWGHaHHmytk3YCcYMrDvRC9U/W6JUaozv9+RRsuGj4/87hYPuRK0Ie26zh6x0GBlqfCRxYYoCHLg4SiqZc6+hSi6a1nUSzRRFXXu4kLnld2Kwg4PT69hM4w3iQZNk91c0Awdx5kdni3
X-Gm-Message-State: AOJu0YwdHwEPO2U/7R91k3tppA4smZMOqEl+xyvBZJ6FgwrjwiRJAFpY
	qQeCHXgWxmILpou7+UBDxn5fY0T0XVbOCYRxne1crqEI99nkm6kj
X-Google-Smtp-Source: AGHT+IEstC0d2nHwmzLD9xJbJgCd+PEu3VEWl7DX2uj2D5dGQCq0bpbLjR9G9F10l7LskAcu5QNBOg==
X-Received: by 2002:a17:907:d3ea:b0:a7a:97a9:ba28 with SMTP id a640c23a62f3a-a83928d7a91mr936572066b.26.1724137604359;
        Tue, 20 Aug 2024 00:06:44 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394669esm734318766b.143.2024.08.20.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:06:43 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:06:41 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/3] PCI: imx6: move the wait for clock stabilization
 to enable ref clk
Message-ID: <ZsRAgfKJ5VZ98AZM@eichest-laptop>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-3-eichest@gmail.com>
 <ZsNaeV29s913HU6E@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsNaeV29s913HU6E@lizhi-Precision-Tower-5810>

On Mon, Aug 19, 2024 at 10:45:13AM -0400, Frank Li wrote:
> On Mon, Aug 19, 2024 at 11:03:18AM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > After enabling the ref clock, we should wait for the clock to stabilize.
> > To eliminate the need for code duplication in the future, move the
> > usleep to the enable_ref_clk function.
> 
> Logically, it's better wait in imx6_pcie_clk_enable(). But not sure why
> it can reduce duplication.

I'm using the imx6_pcie_clk_enable in the if statement on resume for the
i.MX6Q. If the sleep is not in there I have to add it there as well. I
will check if this is still necessary with your changes and if so would
update the commit message.

