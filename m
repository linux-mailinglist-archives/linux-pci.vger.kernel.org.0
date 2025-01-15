Return-Path: <linux-pci+bounces-19899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51782A12586
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62080167E13
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB6FC0A;
	Wed, 15 Jan 2025 14:02:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D624A7F4;
	Wed, 15 Jan 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949764; cv=none; b=JguuypCoKgTgxcMEEZ4m0E/oKxnW2+YPN5BlbDKMb2U86K7gWSIE3O9n8duJJk2uaQIHZcVwQ4YQiClEQJ32smNHGxlAsufy7GqMhxtSpzwJTbUwmywwdw4BWpCyTg8nc56Muf29o9HXLO5YwsGJJGyriaOCjenLHF64PgLLhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949764; c=relaxed/simple;
	bh=WuxMkrZ47yCUHHq/4ZOKXuTnlG/oYsKVy/e2x5ZkkDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL4hrhqPM9PNi/arF6PWQa+mYz4wcYqrhapXTzFOHm6ZPNdCQNBDJTUXG8CBw5eM2Zw1Jxt64dRadeYfCV1ah23otquri+Y+BBOUs7A3rSQXQIIe05dlUdUsYAmPV8QHBHhuzmD0qVur+PxBEZTGcvvTRNqCZuq7G1IEBJKcrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so119226345ad.1;
        Wed, 15 Jan 2025 06:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736949762; x=1737554562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6Abd61QTGWfNTGUT7qQjuILBQviFEk/X5pOA3ZgjdA=;
        b=bpQTmJqtpgQX8FRauYhaAwq335bmP5itYyh5+De9fs9ebZyx+EotzUqPOdKSILVuFi
         Y8//3VRJuYgsx1BR6/e0Ht+HAzv4U4GLXxmIGZDtDFvKgZ0M7VZZHe9CvCy2jxlKrnsj
         h6nXGjFxwTOx8gMl9YbVPF7+AG3Lo91ga7WjG8fenofXGxtRXv9jOykzWX9qT0Ok3kCC
         zP7fccL/dvBXmYvdHjwFMkMpZCIx13VzoYGXVZS/A0ZDdKXVGVY5D7SkvvfsfWGq6tym
         QwprcQ90zVM1J1+w887Bm4C87Vnf55gSxcWTi7t2P/WVlX0Oi8MzdVv8EBnCWWK60qpF
         W8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJx8mU/AIzPy8xTSf0hI+bVtDn13GqigYrHUxiFCgcZIykzaX3jBVtKbKvty4fiOW8PXOWk1hIlom@vger.kernel.org, AJvYcCXZSlVOyuKG4q7Exji9BV4XMdbho394sY1GoTsKiejH8egyUsCl2qvs+oJqaX/1wsFnsRUp6By+2Z2kark=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fjnbwbGYfREKQvUvP2/CheDBv2QO7DsoNkZBg/WClAIdm/e0
	tA6icvgXCHHUP4WsKJAi98uYIqQZa/qAqieffrfwIvXPJ5ppPvRe
X-Gm-Gg: ASbGncuU8bHE/90NpMZZvkGr2nzFd3CLA9C0u8NlWfzrEenidfzW0Cuxt39PWyWzIoc
	ga8NbyOf/xiytbt2vq+L4mJUUiSUCGQuxVxZxshGfBfHOa4A7fuGvy+cExp+q64WtjC+mfTe0yv
	WcfqM59EQC5QqhezoM/Npah+NLSL9vlSnX9i4vMc9Vr+iVkaWpRKb2Ap9pYfsLKlTPPH2p8UBmv
	luwtPMtax/567iThT15vGTiqXQoDVBi7b/KIOfPrxpOSST3Y3VDHk0YVfOiBurTyrIY5UawwH2h
	nErWXNIBKgOdfFc=
X-Google-Smtp-Source: AGHT+IHO8kXoaQqHHCB3ktl9U+rZsZzaaji5zMKv/IAG0+EE8t5n4wgAm7mvOmvFK6qk2Dojsv5hKg==
X-Received: by 2002:a17:902:e545:b0:219:e4b0:4286 with SMTP id d9443c01a7336-21a83f7293bmr494954315ad.29.1736949762370;
        Wed, 15 Jan 2025 06:02:42 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f86bsm82137995ad.36.2025.01.15.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:02:41 -0800 (PST)
Date: Wed, 15 Jan 2025 23:02:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v11 0/2] misc: pci_endpoint_test: Fix overflow of bar_size.
Message-ID: <20250115140240.GA1234819@rocinante>
References: <20250109094556.1724663-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109094556.1724663-1-18255117159@163.com>

Hello,

> 1. Remove the "remainder" code.
> 2. Fix overflow of bar_size.

Applied to misc for v6.14, thank you!

	Krzysztof

