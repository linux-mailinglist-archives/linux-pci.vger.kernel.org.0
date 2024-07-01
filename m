Return-Path: <linux-pci+bounces-9540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A891E9C5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005B21F23FD5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67730170855;
	Mon,  1 Jul 2024 20:43:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA916F8F7;
	Mon,  1 Jul 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866617; cv=none; b=PIclast/+qw3QB+5I9ZAJg6eTLdMaJYfwUtPYQgPkal2dPc+0hWgE0FWp/DatQ1/vlJy2YxQbgTEc7ZRxx/60P+x30JVVNxZlCmKABbJ7QzvicY9ZZj+elVjlMEzELb7+UDx9LZPH73miw+Uq5FLMM5EbCtysT5fOIH8XEX+P8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866617; c=relaxed/simple;
	bh=KQ8iKMUDTVWnqMvaPexQRbMGh1aapEm5a4Yyu8U3WRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWxmnX0vMZqgt+As4DXV+b7uTvZ32CpJxrFazIULINeTkhdR99j0XPoiSnNAHdh6jAa6QiQrVcBovFcDEXNo9w4soVF/mzIKHeqdR3ITaKuU5l8VlxqxcnitHHbzalagfmFDJxodYspJfUowrauKga8Qdww/oK5ZmPlGet+4/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so2082241a91.2;
        Mon, 01 Jul 2024 13:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866615; x=1720471415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+S1ENGlyrWI5NCbTqbEjQQy4l/4W45V9tUYOPRacYs=;
        b=WlaSZU2AL5nqcUzwanf+3HLjCra8dK7DgCAzjRUmQXazLFwFCOgfkkubCuqVs7mnKE
         +tgaKFC6dMEk0cyQwM4EA23uBoTVtLmcNEvMqTynFabaQOhWw3bhqv2X0bI7UO6oSYDU
         bWqSsxgq4yWFE7GbptjDr7EIfj4hrx19SCzM2Xm+4xcEQvIDJHKS6cWEo3S0B6+3KsQo
         rfZy1jn3/qVrrCM6wh59/fdXGKa2lI21qHnqjBCP7Yu67hdc0g0du8c1qNvmQQPN1UQL
         KZ9tvQ4VOyLImWsxg+U8M291E59Vaqi1hr1KdfhmxfxJvks6PuhM7L00d5WWgLvpbmr5
         zu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQaEqOv6TujzC1KgLFfjUnNhA8HhVNhsfj3S8PnfbiO+DAF6bVyQzFiVGTreDxqRAaSC8w0cpGtI2hpJ7pxz45C3TywOLWdJ43t30PldL1ZciuzBK4Ljy7zq4LQiSZDMrwC+pBLmNnSgMIN0E=
X-Gm-Message-State: AOJu0YzLVb95vcld5auwyxBtg1P7dCn9ZLY6fYBrbNWZzxca5knXlkC0
	IZvkiL7vhR9O0fx8wTQRGqxzhS9q6zeqWIjOVP5rXJ5omYIkpgDL
X-Google-Smtp-Source: AGHT+IGPo1ImM1VFVlpGWTs4WjpqxL7BrcWCEUQxeGf6K+gEOBzUFxpaPccGrrosnXb6yRING22egg==
X-Received: by 2002:a17:90a:1b8a:b0:2c8:647:1600 with SMTP id 98e67ed59e1d1-2c93d6d4a32mr3822229a91.9.1719866615308;
        Mon, 01 Jul 2024 13:43:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9270c0037sm6950299a91.31.2024.07.01.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:43:34 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:43:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240701204333.GB412915@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240629195615.GC2249818@rocinante>
 <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>

> > > +/*
> > > + * The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" in
> > > + * the datasheet is a text file. But, Renesas is not able to distribute
> > > + * the firmware freely. So, we require converting the text file
> > > + * to a binary before the driver runs by using the following script:
> > > + *
> > > + * $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
> > > + *      { print substr($2,5,2) substr($2,3,2) }' \
> > > + *      104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
> > > + *      rcar_gen4_pcie.bin
> > > + *    $ sha1sum rcar_gen4_pcie.bin
> > > + *      1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
> > > + */
> > 
> > I moved this comment to the top of the file, since it serves as more of
> > a documentation bit for the controller itself, and is not specific to the
> > function it was attached to, strictly speaking.
> 
> I got it. Thank you.

I decided to drop this comment.  See below.

> > That said, I wonder if we should include this at all?  The file name might
> > and most likely will eventually change, as the datasheet gets updated to
> > include new revisions and erratas, etc.
> > 
> > So, I wonder if this is simply better to be included in the datasheet
> > itself, or some product guide and such, where Renesas can keep this up to
> > date and the users appraised of what they need to do to convert the
> > firmware correctly.
> 
> I understood it. I'll consider it somehow...

After thinking about this a little more, I believe that it might be better
to follow what some other drivers have done, and simply add this guide as
a text file under a dedicated ../Documentation/admin-guide directory.

We can then mention, or not, at the top of the file that there is a guide
available at this location for people to read on how to obtain and prepare
the firmware.

Thoughts?

	Krzysztof

