Return-Path: <linux-pci+bounces-9700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC592556D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4801F23539
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119029D1C;
	Wed,  3 Jul 2024 08:32:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766522629C;
	Wed,  3 Jul 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995533; cv=none; b=afB+QYbg0hPeYQn1C4UUCqp1eK45Vmg+9O0rL909K2s/Vn74ib7utE8pJfooBtvGwZzF0oFuYPUIDTL2beWD04XlBnlPOn10WweAVYWTyEOVWnRwQbZVoGDLCLlTsU/mv8An/is7oDNH5H0w3irIVITEcLW2Ungil1Jp49wQoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995533; c=relaxed/simple;
	bh=2U1CY/bLflI0kpAhm0JWDPCi0dMKCt0WDQjZpcgMjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXsSyJFPV2iwwoJ7iMqsud7brMufZ5Wk0S7dTKg5EyRPCO+wIdT6E/K1pZFafpafBEvyCoZ94HxiCJo4WeExzpNAgv5zRNuraXxdek5nkN7zqZErMakkfsnjsvGZYBezfrMuV1Pd7U6LLJZaAcPSbKK9GTYuHPNvysH361e244k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so2927955ad.1;
        Wed, 03 Jul 2024 01:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995532; x=1720600332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TygAay9nnNPsyNpdRt/nYSA378218WVeB8L1m3BaRGE=;
        b=Uuep0TBb0zUL2BylwDR9bjymTJbsySRvYM5JxsQauX1Mu/tCD07E7bsJOTIEC594CI
         oN3SqtQtnakA+uddMHagESBfz3J1Wdt/UiiczM8N4Kz/PIxEreH648DyZqnrVpjGqgs7
         JN/2FvoVF3xFFkqKVrtZGTOz89nMNYzZA8aZC+68iPeo02yPIRIPD5RnMT4dn3SURZGw
         4HuNGS6hg4e3vS6YW1JJmgJpljk1ZRAgfizAqZuE+QuouhyygkymgnwviBklIxGPJBeR
         aE0QgD9JvHjygPbI16lk8yX9vwUnhIaMOd/W1xp+wHPYdwwO0Hzh1dnF99S5qoR9rLFD
         R9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+LqOvA6/DaR1uCIshG9Kr+AVXY65kZ0lbUBKCwX5URwicQvsZ4PSq0HkVHuGJZ835C4OvSUbVhcyZa0JGc+JJ794PMHjRdtuagXHb2AFoa37BWSHLLBxhPtr1uG6uY2DTF2j/KlEAMZUcRr4=
X-Gm-Message-State: AOJu0Yw93aqLI4ThEScveJPx0kKrIJG3MxI1giABZpJqTD4SMirHxYmQ
	wjbC1+90Z5lZBgJADO641n9vGGEBiw2s6ge/acJPoLpwktu0otII
X-Google-Smtp-Source: AGHT+IHGCMRPO8158qVwwQj7NsjUI51ZIP0hMW08Lc/cmyubzN1HAaOk75cee0h96z2SnYsqGeVM8A==
X-Received: by 2002:a17:902:e5d1:b0:1f9:f6a7:9330 with SMTP id d9443c01a7336-1fb1a03bb48mr13652635ad.9.1719995531528;
        Wed, 03 Jul 2024 01:32:11 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad067031fsm88783245ad.259.2024.07.03.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:32:11 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:32:09 +0900
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
Message-ID: <20240703083209.GB4117643@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240629195615.GC2249818@rocinante>
 <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240701204333.GB412915@rocinante>
 <TYCPR01MB1104021542E26342F961B1499D8DC2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1104021542E26342F961B1499D8DC2@TYCPR01MB11040.jpnprd01.prod.outlook.com>

[...]
> > After thinking about this a little more, I believe that it might be better
> > to follow what some other drivers have done, and simply add this guide as
> > a text file under a dedicated ../Documentation/admin-guide directory.
> > 
> > We can then mention, or not, at the top of the file that there is a guide
> > available at this location for people to read on how to obtain and prepare
> > the firmware.
> > 
> > Thoughts?
> 
> Thank you for your comments. I agreed. So, may I send such a patch? Or, should
> I send whole patches as v10?

No need to send a new series.  A small patch that I can pick would be fine.

Thank you!

	Krzysztof


