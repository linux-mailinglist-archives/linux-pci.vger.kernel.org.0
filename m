Return-Path: <linux-pci+bounces-24751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839DA713A1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 10:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BAC7A5227
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE81A707A;
	Wed, 26 Mar 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="E9DVlVR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9971A5B94
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981118; cv=none; b=dsMuICYoTy/aTxrE4sN+nGlIZuWIs10Qgcr6ay+Um+tMhNuJPkqOp3GchejnKwH3TXVVRYx8Dvbt5iCoKrfFjHvHjpm5l8sacQg6mwn5/s5345ZjnRXGF6DGHx+xU9QCEKKR+4OdL8uGHRx2j7um9QxGdBl/vokWu91CI1SnrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981118; c=relaxed/simple;
	bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIOsi70pvS2S3Y4gZQlKYdTaNWPHa+0bB7HlNEFbBfqLQDVD+5ux5Z0KIX+eZIl4cFWm/q60w5FOLH3Y2uXKR1nmGcKCg0iE1tik07ixErYZ1yLO7sj/RyTk9fxkW/zI6aJecsSC9/GCUxVCYhw046osDTPNQzTAQtnaxawUvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=E9DVlVR3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso992646066b.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742981115; x=1743585915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
        b=E9DVlVR30wc8A7MqtD6FdhmRKf5WG7HH+cM3IgMzFPkW11DdzCk/yZi5RCW0C3GnU2
         Anhxtw4wddppbTjNDDS94ZpA4c87IK7nroxIk/7oSom/fsWqbOu1ObZLMNL01RrKfuF2
         zZABryYNXVnegKsDzNI6ivgeBIWNlFwH1/n/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981115; x=1743585915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
        b=ESnE0yZHougsGhsvnB43JUv5o3CH37b5qOYr+wrKeVovmcygig8N9HWYnUGkvna5EO
         rsOyySifCGi5/xQ2x+Bp9WhtZRX1jiVUV2UTSFhvfntXJRGcA/MqHsn07VDGF6DQ/usJ
         6ZUTJF7bKVQ1hylZVZqfkI/i8VBu4GFAvHLYaIvQ3u5yx28fbQTLWfDIHptSxW6Cs0iT
         jc5RURfn/8KBFe5RXLsOvsmkMq4r8wER4VPzEs2a4S/2Ssty0S58KjWnTNcXmuIpSXMS
         4wCHQ8hm7AMw/phSHi/nvq4bVpTO77ojvsCB1FSq7EFwpSAKnlrnDpaP4dOh0UXa4Kpa
         qnfg==
X-Forwarded-Encrypted: i=1; AJvYcCU0XUtfQ2bOsIAF3CXT27uVNQH49KSwSeIQHEyAzZw2oo/oIROs1aZm3m0IKg6N3HDLczehX2sb6tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLSxW1Gdv9RgFF6DsmUq12+Q+PGPAZcS4HGOmv2yKZbhds4tX
	vkHRmzczHUJnbLzIOhugceHoEHqt7i0w/x+OPO8a9oYM6tgspjt3PKhO/tzMOV0=
X-Gm-Gg: ASbGncsVizL28mSADkk5ZxNzvWiR7ePwaCoR5QA4poTMDu9qa5mJoa7WzfgVur0+13e
	c466VLvvq3a9M9wejjeEks55wZalJs06S1ywspfHgjSDKl3iHGf+FA/pQQQXCdNzvIbIHWsA7Am
	zfwaCHXWnMd2frnRF8TR90TJVweMLyOCQ4Hmyx/OL0mVxrtWJ7tg8KPVkSDXmP9MMGwYxLv20kk
	cPrypIpYZa4Dfx8mkpCxg5TSIXyhe6nGp9Lhyi0mB0BqQ5Wdp/PyFZglHrWdBDZGu6dMp+W9TDJ
	nKeMjgAC7PFp7lhk8I5JlqDtcgY4maqKkHPbEPwcbxwEwl2fbQ==
X-Google-Smtp-Source: AGHT+IGe+y82L5+gj9QzxBEdZHdajohPp3RW6/DSFWXrlV5r8AaiNFRvvNJjTG5Ejwz4trhnQT/f8Q==
X-Received: by 2002:a17:907:d786:b0:ac2:7ec8:c31d with SMTP id a640c23a62f3a-ac3f210aa96mr1964769266b.17.1742981115065;
        Wed, 26 Mar 2025 02:25:15 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac3ef93e17asm1003921866b.78.2025.03.26.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:25:14 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:25:13 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: 423b87d8-2ae3-48af-b368-657f1fbab88d@amd.com
Cc: "Aithal, Srikanth" <sraithal@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
	linux-next@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [syzbot] [pci?] linux-next test error: general protection fault
 in msix_capability_init
Message-ID: <Z-PH-fYvtSF8v4Ae@macbook.local>
References: <20250325223752.f5tjazbpbblgppyz@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325223752.f5tjazbpbblgppyz@amd.com>

On Tue, Mar 25, 2025 at 05:37:52PM -0500, Michael Roth wrote:
> Also able to reproduce this trace on every boot with a basic KVM guest on an
> EPYC Milan system using next-20250325 for both host/guest.

Sorry for the breakage, there's a fix from Thomas at:

https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Regards, Roger.

