Return-Path: <linux-pci+bounces-4885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1B87F66A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 05:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E628249B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 04:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16333C8;
	Tue, 19 Mar 2024 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGLRCLij"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FC1FBA
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822666; cv=none; b=hgqKPG36SmV7ezypuI6VoLJ9tW1TeOYuzx9eLjkmUXzQA7vF5Ck8Q1zP59rRxho3qQiMyGKAdhtYzuL3xwoJa5C1qznF53a5eREN5DSXXPyfaelg6ywQzdkx5GW+cC0+ExoYoMSXQrs2ZUP2hL4ZNDLAwJ1AmvmV/gGD/bv90Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822666; c=relaxed/simple;
	bh=jBSoZmdAp35q4d8lzrYOvygjV8EjmrhHu3o/kCfTFfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgWuxs7AoJ6dFMJ69pKFxoWyqda5+C+MGHzQ8Dp6AXadWEabM+J2IkfTxTzoiyereH0LiEPX8MpEkJ0HqJOTCiOZJNsbsnIrez1ddpjvN0Oz+V6sGaDkFKWp4CzCKGEeCQDM2PIDraRC7AZiP4TY0/8DwuqD8MQtddyg9Hu0tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGLRCLij; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1de0f92e649so33358815ad.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710822664; x=1711427464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGDClbRGWvuYwEfae2SlYjMBRLr5tqoGg9oEPkULNOQ=;
        b=zGLRCLijoxn6hBAP1QWR1aHVfrqmIZ5IdfGL2PNkz2kXccE3PbP1X4RZRfEWorw4DP
         ID9DWdZKxVst2mBvQfn4xkGZ299vCXi5Vp3lh3Zw4wC4avaG22Kubn+hnD3egxe/dpFJ
         qAzNelb7RV3KUjWzUDsXZbgOZZU7H9FLhg2JE39nNRZosuYB41bODp0SSg9PPwQ5WKUu
         V1LSdSN1mtHXwOHy/ixMGHhhReVxkMXY+jJemhxBCNO3K4cbLx6u9noifVP9dBhL0dPV
         LqcHpdHGuI060rZn/yg5XjkghPmAhy7uOyCdplQHG6ucMuy7+DIUeCJuOkrK6uURCWvb
         9qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710822664; x=1711427464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGDClbRGWvuYwEfae2SlYjMBRLr5tqoGg9oEPkULNOQ=;
        b=GwHiTKJFtrfXqBFhXYquXPXRaeupaMtwxNRttpOfRLDx7Mf3K2M2Y2jT3w0pRPC9Mw
         oG4H8eegzgE7qs8oO7tbyQygA0WhYyl1r2wsXh7/1RaoH7KaUk645bc0b5gp6QUlgSwj
         esREPhVhtpfPjGqEE7GqhqbbmC+pjwZO10NacEHD2QWBm3NUXYZ7nMohVacMfAmOAuIL
         23b0rRnMaCWo5KqOa1zhEBUgLtjlogTkYp5CQbYoLyW5cPcPmfNy6kp27xi2jeDxg9W6
         us3d95bdUv3pq8dw/h6tqMY7sj0zR7dAz2F1Kzu23K9z1ryhUjMoKRX3GAJsn/dobvQL
         VvYg==
X-Forwarded-Encrypted: i=1; AJvYcCVz0u/uq6dwOt7hj2N4ZAkpuNiAXy2QKJw2C8+IsoXim5Wv1HRUN4N+jqCA/u8oH49OFjKyu8x6/czvQP8s6d+/WUaQIOf6Xr3K
X-Gm-Message-State: AOJu0Yx7/n7czANrkEh/+x3tuZ/bV0N0Pt+DWnyPuy8iXuTP0gjH4All
	qlIOrDxii+wujqC2/hKzt87WbF+kQ5OabFOLvpB3ZsWGNSufVLaGlZPKl3rXR7PX0Op1eZNXBzw
	=
X-Google-Smtp-Source: AGHT+IFlUJ0NB2Mndu4rBh8kf9CtvCtUnHR/+RdJqfhX5KPipUOrsGxSzu3JPCa5fSK0bhvVNm4XiA==
X-Received: by 2002:a17:902:f548:b0:1de:fe74:af6b with SMTP id h8-20020a170902f54800b001defe74af6bmr9385659plf.46.1710822663857;
        Mon, 18 Mar 2024 21:31:03 -0700 (PDT)
Received: from thinkpad ([120.138.12.142])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dc01efaec2sm5066227plf.168.2024.03.18.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:31:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:01:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240319043100.GB52500@thinkpad>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>

On Mon, Mar 18, 2024 at 09:02:21PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 18, 2024, at 20:30, Niklas Cassel wrote:
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 705029ad8eb5..cb6c9ccf3a5f 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
> >  	0xA5A5A5A5,
> >  };
> > 
> > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > +					enum pci_barno barno, int offset,
> > +					void *write_buf, void *read_buf,
> > +					int size)
> > +{
> > +	memset(write_buf, bar_test_pattern[barno], size);
> > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > +
> > +	/* Make sure that reads are performed after writes. */
> > +	mb();
> > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> 
> Did you see actual bugs without the barrier? On normal PCI
> semantics, a read will always force a write to be flushed first.
> 

Even for non-PCI cases, read/writes to the same region are not reordered, right?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

