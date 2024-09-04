Return-Path: <linux-pci+bounces-12779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EC96C609
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1491F23EC1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F281E1332;
	Wed,  4 Sep 2024 18:10:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3E6E619;
	Wed,  4 Sep 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473459; cv=none; b=cKBsNaMhJTqQMVXEjinmZwbnekEkdD2uUJ8vUuXFcgDNdgsxp77lOT+rxC1H3KU9H6WAQoLoO9ENJnF26BPWHGPPQ/+IP145+kis9tlTKSbvMCI1yk/sDVcA7MhWrVpScnCtNAbTfSj8VK6GZIb00RUniWkPiVjk/vqt1sRThXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473459; c=relaxed/simple;
	bh=stbnkD7vK3FsSw5kEiD4v0BYUrwnhSQLTeVEeLGw+d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9654qnXCbBUBPb8VB5k4QBQj5q371OguPGYbOHU9tgILCNfy2KI6kuOhw2PShLBx/N4VBrDFsZgLAvvAKH0+mYIVMmh/aXJI/ZuiEmVz5vT3QPcRtcTnCp3thWxLLQ2eTMth+p/dldixo/4ETLlRZGue/J0UhMs8XBq1R/JxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so952814a12.0;
        Wed, 04 Sep 2024 11:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473458; x=1726078258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaZn7t1f9p2C+9KGgClJBqRBfNG/EZMLVSixIkNLNy0=;
        b=coUe9W/8fBOt/Iq+pwhlhS4aO+DaAgbw5VzWaCaebAV8BH9plfjCk4tiqtWp5VHoJd
         PBBTRAamHhUL3TbFpy6x17RO50+D+865d09DuUIseEJtAtoUHOoRkQCBdR5wDZeCDeXe
         w2CbLDrgLtFDvbwyD+gjeOR/ghVyb1zZFBUSld++UyGC7EV8qVhXZ920bspjxk/cFB9C
         SPiW0Bel3Oj/V5lf6bgwHVAd4V7LkieyYJMB0qLOhfy6KhO7TrreLQpX7i1CvJQUYxvg
         NkCccKADZ8shBaTvGMeGKniHQkTlTcSnvcLiwRJGyZPnmwz5WYz1lsyX6/V8TbXBBBvI
         fI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVjasPB9RFgK9YdWDQN1vJNDxRsoMzlgCh0cU1c1a9Onf9YBA5nGw/S6Klqi1zqDzO/7zHyL7hg+Ktufcw=@vger.kernel.org, AJvYcCWw71NJjhf0X/ywKrYri6yj+YH1pCpvp4XjW7LwEXIlko+/xdP2nzb8QkbjwHH7XkbcAG85WoAGsjuC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7A5FIBLO3A4Dyfc5xGN3l25JRzjWGohKvYHPFNYOQXVlhg9fF
	vnjSgGBXyL1lgGX65RPuFgXXSMl9otYPnBTATddLlC0ZMIzvlUBn
X-Google-Smtp-Source: AGHT+IEL1SR5b0viGbzwKw6Mdv/n35g8dS9bGsmDdRkVV7XHmzsSthsikksdSKV4HccdbFQcdAx89g==
X-Received: by 2002:a05:6a21:6b0c:b0:1c2:8d33:af69 with SMTP id adf61e73a8af0-1cece5d1678mr16248108637.41.1725473457520;
        Wed, 04 Sep 2024 11:10:57 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859a377sm1964498b3a.143.2024.09.04.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:10:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 03:10:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: florian.fainelli@broadcom.com
Cc: Riyan Dhiman <riyandhiman14@gmail.com>, jim2101024@gmail.com,
	nsaenz@kernel.org, lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins
 in brcm_pcie_setup()
Message-ID: <20240904181055.GA20073@rocinante>
References: <20240904161953.46790-2-riyandhiman14@gmail.com>
 <159c5fcf-709d-42ba-8d45-a70b109fe261@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159c5fcf-709d-42ba-8d45-a70b109fe261@broadcom.com>

Hello,

> > Change num_inbound_wins from u8 to int in brcm_pcie_setup() function to correctly
> > handle potential negative error codes returned by brcm_pcie_get_inbound_wins().
> > The u8 type was inappropriate for capturing the function's return value,
> > which can include error codes.
[...]
> This looks fine, however it seems like we could either:
> 
> - update brcm_pcie_get_inbound_wins() to take a reference to an u8 and
> assign num_inbound_wins directly plus return a negative error code
> 
> or
> 
> - update brcm_pcie_get_inbound_wins() to return 0 when encountering an error
> 
> We should have at least 1 inbound window to operate this PCIe controller, so
> if we get 0, nothing useful is going to happen.
> 
> Deferring to Jim as to whether he prefers to take your patch or fix it in a
> different way. Thanks!

The former would be my preference.

As such, I can make the change on the branch directly, if needed.  To avoid
reposting or sending a new patch.

	Krzysztof

