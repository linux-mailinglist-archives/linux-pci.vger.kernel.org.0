Return-Path: <linux-pci+bounces-22829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C7A4D759
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CA176256
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584E20124F;
	Tue,  4 Mar 2025 08:57:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727B201246
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078647; cv=none; b=KEfjn09Pg+7zs8GUl0l7lZCYRUKZjsHHeSYd6tvw04oXNIlaNgw7Ei95K4He9ZOoafY1gRgV0DDH2FUG4k3Dte1M74jZ8279x0RhtOxcBrzef5NsMF9xndBpyOun/giXUIdi3vqdt0UL0zpYOS6G1WY2nHlFQRQfjb580yQoK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078647; c=relaxed/simple;
	bh=jMa2Y1R14rEvmRUqRiPwIVnR/jzI+Efy2yitogoVX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITCiY0SLEGmwlzUO92T7Kd0M4PoELDmFYYzrVD30ig2nt3uHEbrxAWfxjxUMDluJyJCG2Fb/h4eQ2Ck81E+1PgQp5dR7UxWkpQAbnpEQuv8UZSVALud2Lyce10ObObM5T1w2BpvAGJ7e+BEbo1HrhJ7ph3ElSzNoz11GL8pACnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso9007705a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 00:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078645; x=1741683445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WMhTAxjtvPIA+ttlArpcx35l9qLwJmkNIN+6/oiOWw=;
        b=moM4Ndc2FpN3jT5DViGTWqui8CNObZ1+QFy6Ya8NP8mTZlhus1xVXVSAabEwOsPikW
         Vbke7Z3G/E78ANjRF87ukrT948eS1ZqrGb1TryeeWVCDGk7eqCb+p4pux5onO/tUg1oi
         QQrVt7PtctRCKVe1/9ptsIyCjTootbfgty9yZzBUoFcNpMfLGTLfcHbJlQVVX2XHXQ6n
         PM0iwcnJpCc57K7DVQN7d9UqILXp4J5VWGrdjmB5upLCouY4Bc7dVi0LndtENK3NQtsT
         FidHHgIts0cDYG6rD3+Gc4P1InoAu8w7MfcPSQYUzSUwkJaEBU3jn87e4hMguf5zjWH3
         YYcA==
X-Gm-Message-State: AOJu0YxPih5jfaMl+4FqFm0Lk5DDZ1uIVve82MC9PvmcNW9nEHXdi6oV
	bRcyH752MIJ24npBFst+ReaSp56zrwmTGkp4z8LdUdkxd9hFVIU4
X-Gm-Gg: ASbGncvXljTuoFmDvjal06UHXXhqsDo8m7I440YnyBOL1fU53jZTpdXrC+13ZAwv3ZV
	TiiSGzUWpxvfdWIq8Y4a53+SwbyCMjZKTsVNxO2EswiPqDSUGAIEiKRaSDBG2R2bZ/5wFcZRwij
	74h3A0VzTyptTe9gXqGsKhUORLdRusx4U9ZYJcXLRXMbp+bAzN/ufPW/Nag/TD/MT91zmj7lX+f
	W4ssgwCtC6/JP+vsDTaaBQhWEiTjhZm1T2Kf/qLa2mqnqoIvB2LAX/MaA8EkeBAknYpZudTWqEc
	yc04bCIaaMEh/QloPMpC2J4fYKqxWJncIDieu6rrhVPh74TuvCOiRsxF3ZcjIfeiaPbwxDlnODE
	lT8Y=
X-Google-Smtp-Source: AGHT+IFI+XhaMdeLpmiNdTzfBfKc1YvxzAt3Ii9d1pnxIVADMTQrfr8ituENp3Ft0fDkn9WuDCcosw==
X-Received: by 2002:a17:90b:4c05:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2febab5e155mr31272343a91.12.1741078644979;
        Tue, 04 Mar 2025 00:57:24 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff3ce26959sm374775a91.46.2025.03.04.00.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:57:24 -0800 (PST)
Date: Tue, 4 Mar 2025 17:57:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
Message-ID: <20250304085722.GC2615015@rocinante>
References: <20250303211119.200365-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303211119.200365-1-helgaas@kernel.org>

Hello,

> Fix typos and whitespace errors.

Oh nice!  Thank you for doing this!

While we are at this...  I wonder if we could also see about some things
that I often see in the code, too.  For example:

  - "pci" or "pcie" instead of "PCI" and "PCIe"
  - "PCIE", PCI-E" or "PCI-Express" over "PCIe" and "PCI Express", etc.
  - "aer" over "AER"
  - "translateable" over "translatable"
  - "SPCIFIC" over "SPECIFIC"
  - "OVERIDE" over "OVERRIDE"
  - "Root port" or "Root complex" over "Root Port", etc.
  - "dbi" over "DBI"
  - "requestor" vs "requester"
  - "fom" over "from"
  - "reserv" over "reserved"

Would be nice to get these also fixed up nicely since we are already
cleaning things up.

Thank you!

	Krzysztof

