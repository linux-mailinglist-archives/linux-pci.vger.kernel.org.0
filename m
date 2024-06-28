Return-Path: <linux-pci+bounces-9423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B2F91C807
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059241C22E04
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E9C7D3F4;
	Fri, 28 Jun 2024 21:20:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34051C4A;
	Fri, 28 Jun 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609602; cv=none; b=rSmhm9vdDYONpS78yBIP+LU4AbzCJu8+OBv3I6dmr+4Oz+sUekCTwLtXCamzkdwnd647pQ/ZR2fIELdNwczDjjDEkBz/QRQrwh77ooMAUGywVlL5pCaUzcjfLCM4dUzXRLY6uAafMZsBNSTMlFTPWeaMI8O7dMiprtshwxzXijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609602; c=relaxed/simple;
	bh=YYHEVY/PQM5h9Nab3dkjg/1Wy4dcSZawSulq6PRHrYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIGM1zpZDLYUiUKI5GTIhTyk5sa7H0uAKKiWd5iRaKeWqTHgpwGgX1AFtmn/t3NaQAUP2zdGTnE+lpq1ziB62cvsSvYSHEcqfj6Gm/kcfZEM+ZJ/DZPbsMTxLpzuVyzcghDdCRhKlBkJQSeAVNU0JDba8muMzQcDr7/O4kQWkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7182a634815so718992a12.3;
        Fri, 28 Jun 2024 14:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609600; x=1720214400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mjbw+wYvgBhsc9x/A9PPo2uA567jvKEpkLcWndxaX8=;
        b=LP/iYi4cb9gHM1YQ7Ljo7ahccWAincVZZ7oE7BrtUqIH1rqMIbdMM+LUui4uNByTkj
         ncyY5B5CxvgHotFclmUTQHtustTB4+nR1oclqZqtgEBEcjdpwTBzFipeNUr3Pr5COChB
         U+oQe5uC5YOxnjqFwtKURYZDzRvuQ6qR+q72NnFRrFiZGojFrYzMerQTtzrYllJ4Zk0s
         KYIv0avEUNg1Q1E8JIybxLGxDlF2Ak101cl34yi07XqujpwREh88xAQoouszMyt5VWYj
         J1r/n2moiUStHqCw20iPOfpEZlvb7Yvg1nmEgPPw8oRYjiEW9Kh6puLnh3g8RnLufN9b
         0HiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0TpMbvOfbBjhgqGZCe2D/a7+OFzhsNwAhuLUUR1BsFtRScmHHqYluqvVe3aXBdzTJgt23/0JzaLVX8Mt9xd45SWvQp1i6lzfEe07pqeec+PPxeam+rWlnRa7K5S6ccQ/iKmLaCGlF
X-Gm-Message-State: AOJu0Yz0rdKTB4KK4DyeGFPg5nisxS1Kzbr6Mil9JrkUgM6zwnLnbh6L
	hmIBDuXESkAWlSYdQPxNkDvaW0f3fCPXW7SrZ4BzMbi9q2c/YzsGhqC1t9ABufJhEA==
X-Google-Smtp-Source: AGHT+IHk7W3eBsVgTPh+wI3EeKuxmYXiX29cu+Bn/zPnNDcrFdjSo7vy2U8HhFhz/ojtjJhcVspVBQ==
X-Received: by 2002:a17:90a:d084:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2c86127e140mr16251372a91.6.1719609600505;
        Fri, 28 Jun 2024 14:20:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc540sm2087779a91.44.2024.06.28.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:20:00 -0700 (PDT)
Date: Sat, 29 Jun 2024 06:19:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5] PCI: keystone: Add workaround for Errata #i2037
 (AM65x SR 1.0)
Message-ID: <20240628211958.GA2213719@rocinante>
References: <16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com>

Hello,

> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
> (SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
> the bus may corrupt the packet payload and the corrupt data may
> cause associated applications or the processor to hang.
> 
> The workaround for Errata #i2037 is to limit the maximum read
> request size and maximum payload size to 128 bytes. Add workaround
> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.
> 
> [1] -> https://www.ti.com/lit/er/sprz452i/sprz452i.pdf

Jan, thank you for picking up this patch.  Siddharth, thank you for being
very thorough, chasing after old review comments to be addressed.

Much appreciated on both accounts!

	Krzysztof

