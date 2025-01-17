Return-Path: <linux-pci+bounces-20033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80446A14B70
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E377318885A5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0D1F8929;
	Fri, 17 Jan 2025 08:49:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50241F754C;
	Fri, 17 Jan 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103763; cv=none; b=hwBUWgfvcgaoMPqfd3JajpaagZWOZ4omG4fxXjpmeknX0h4wEECzrKeGBPd6+QbBiCyOSVejrHQmapAWtWuFBbtcqeAw/rIqe+wSW15Ua9If5shkDKgWv++AQ2NHW60bxnvpgKu/TRDDeRbFAaVdb8VMb2RTypQznTGT15EIMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103763; c=relaxed/simple;
	bh=s7G/qPNiNIZCio7a0paecCg+GfNDiRDAxjizD8U2HgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTytyYnvd7QBj+waZRdQ4Rj17Xuqjx37Eli8DHFgFoIZRubwMqN2bNeIJ6iao+s1jttzQuehsCt0qVg+bAnF8k/6pO1OnE+1+xGZO/TKMatEFOKNo5wSv5Y3VDgmXoeUIeXECFyojVPO70fV96dSW7XSBz81ZH28DIhJA2IMG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21661be2c2dso34393605ad.1;
        Fri, 17 Jan 2025 00:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737103761; x=1737708561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNe2Mfr29R/zYf3qwVvobOjMU1dExp8rH5mTUwQWtzU=;
        b=UB7WQS6HCCrdy+sg35/3AaLRnlqSZD8GzmUQxgpFmvawPEUPVcAoHTH1DM5G25fnSB
         pR1KA9k+rndimrw53H8wwc2qvTaR9+OxoPxQRLdfBz2T9xyXJsaWBU6NTaa3lbUufBiB
         pI4yxLH46nUGGlkHY60ZQSmgNPsb+s7a6PQU/wiqxMbZX9HLjLqMoI0HDUtYNpbk/6ho
         r7IH2u58vPCl6bKLuZkW9ESaeg5JvZxR4wiYsF7ZAQZczcUim38UtU7yUWsrViTYlqfQ
         UxQKhtBtP1P/y7iL0ykQ302w1O+HlreTdZiuLhrCwxZzAAADIDAw1qB4g98z5n02rx/q
         8hHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53IhhrLKciYY/Nk+QOM0eChAUMXCSGA3CWWgnFMmpZ+UAu8QR3Q3YIcXhCayuBpywsaBXTg0dY87c@vger.kernel.org, AJvYcCWcaNG381m6I1rgnT5ajjI5fFGOWAPONLL2vIhQGkCvtsZzDce9iXlzKzBrY5SbI8KBayx6s4feGxCTKig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZRwRMj5ZEbRkbTyW2SpzAZtaxFj0TpWiJKRbyaF7OiFJBSsW
	dvg4Q7TYsag5jpKadgfh7mpL33LeqPYXUZCpvMK0jOvFD3mpAXB6
X-Gm-Gg: ASbGncvUkvdIv2Li2wGXSSv0HkW0g+nVbk5dtYnS5cb8zXTmJt8EEtF1xUACn0yujZE
	/ziVgKPvu1lJs3jQnOHzLsXr/GDvTYrvLPBmbHzDog/t7c8aKSwojeCNXR1C/3J7surAr1Piurw
	yUWLnwSkGi0NpUV9DQQ/FnCINxvCAPR0odZTlxd/jn+MxMtzCbGSeKIlnTL9qUIWfW5cBVkDpLr
	ohL467nSjuCDeN2xdSfJxcxJU2koWuYGTZigqylRc+Ymd2iDoeZtp0sybYi1TVTBVVJL6ZWgaBE
	Ea+y5HwUNAa8mJM=
X-Google-Smtp-Source: AGHT+IHqX3NznBtXRpmnickrBgahYA318cY6l4oSXzjs71zkhtdWA1ivRpyOlkUrRPDMFBqVdt87Gw==
X-Received: by 2002:a17:903:947:b0:216:5b64:90f6 with SMTP id d9443c01a7336-21c355fa2eamr29723975ad.45.1737103760869;
        Fri, 17 Jan 2025 00:49:20 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea073csm11518305ad.48.2025.01.17.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 00:49:20 -0800 (PST)
Date: Fri, 17 Jan 2025 17:49:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hans Zhang <18255117159@163.com>, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250117084918.GA1752843@rocinante>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <20250115165842.p7vo24zwjvej2tbc@thinkpad>
 <Z4fq6XU650iOsFZe@ryzen>
 <20250116020300.GE2111792@rocinante>
 <Z4jTEkznMUcApzbe@ryzen>
 <Z4jTeNjl7ddfcQl1@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4jTeNjl7ddfcQl1@ryzen>

Hello,

> > Since you have already applied this series, with my comment fixed up,
> > could your perhaps add the following (or similar) to the commit message
> > in patch 2/2:
> > 
> > 
> > "
> > By changing the type to resource_size_t, which is a typedef to phys_addr_t,
> > which can be 64-bit in certain configurations (e.g. X86_PAE selects
> > PHYS_ADDR_T_64BIT), even when the compiler is 32-bit. Thus, we also need to
> > change the division to do_div(), to properly perform a 64-bit division when
> > the compiler is 32-bit.
> > "
> 
> s/do_div()/div_u64()/

Will do.  Sounds good!

Thank you!

	Krzysztof

