Return-Path: <linux-pci+bounces-13167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F997804B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5E2844E7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065081DA0FB;
	Fri, 13 Sep 2024 12:42:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAE1D88B9;
	Fri, 13 Sep 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231376; cv=none; b=QyaPacB5goP4w5lfMTPEO2ohLfZXE0XS7UqWXW2kmuVeQVO5Q1VI88t9in0aeAqZLqEQSzRTo8WVrIWS0kTz26p7LR0Axf1xpWu/9GS+jgBMg1KU2HFp5iQwcregMCM/32fQ6NZvWnOaCPvy7m3IivyYjL+bgIsz81qyGCGhn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231376; c=relaxed/simple;
	bh=ZLR2PjW7m1ADrbYtcPhyMcsVoZwWkk7Lh2eCswBViFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPi3BqSaxxo+2TkGFy78nbZXnOiiVe05XGtTKw7orvfG7crHbjeF3LonjsT5iJoGDELKxSSdFI406PfnuTTe1CcYRZLeVx4E3kXodIMs9o6MeE8ltx7sl6S2EPdkiaV1PUEjBn9nFLQxaPDnQR9W4+ZteSbsafh6ktao8jYiR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068bee21d8so23148225ad.2;
        Fri, 13 Sep 2024 05:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231375; x=1726836175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykGzWLNv5qaQEHMVqWPKDZiAF/ETLElge+fBXotmj5A=;
        b=Pe/j4rnPt8wB0j0eUKlluyMiiiWZHnDKT1Vu42MDW/yywDUJix6UCdzjOuYGGl6YTc
         fv00IA+EZLgr6mCXTErwpcTUAeRN4Hf1G4KYoNNSr1nua1L2nibRfC0ZgDYmDBGMR1ej
         g8eClSxO2cBf3h93tvEH9419RZ6ALTkih8t7vtwkqJIcRZuxClV57tBCBjetFY3UYO1r
         nt6HRSd93qNIdXtRTf2bzNPHy6akYMFvdrmkQXm2J4Gdu8NtN7aUjzNWgwPiI4Uhoe4N
         Md6lpk6f5ytCs807w8Is1OnLUPlgBD+ExbSfyDpwmV4dRQMaMH9I/gb+QYoPuyKOS/zh
         VF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFnQPTWRzt83pNwkmj/WkbW1B3Q7l13xwXj3dnvPlS56xB7cwQ5w3mK6s4qLeTJZBHWsfEXoNzVYKUXcnS@vger.kernel.org, AJvYcCW4//4JJEL+eOW8q77Ab9J01clmsv9V5FxeooWeUuU4Csvm/XGS3j7X5oOHI3fdRYMswz5gPx+Utbl2@vger.kernel.org, AJvYcCXK7Y0hS3VBkEe8r9UuyncAvtpmjr/9C+VJ7sqhFz0+AaHyY98/6Q58fo7FA9WkU7yxB/4S/6IERP0N@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmzGHq7Vc0aUdgxsk3LrH6swVTY2TUD+ofhbHw41cRFKUToUO
	ImPm9g2tiisbK0/YDto6XljeVcM5BKajd0XqmzLGK/9OjMv5a7bO
X-Google-Smtp-Source: AGHT+IGMU2a/lAg2ahtMLpWZlBrDFLJ3PxUV7+dvQN4nWLtu/Im5axPFSktP0bZvvxlWiTxdamCOdw==
X-Received: by 2002:a17:902:e546:b0:1fc:4940:d3ad with SMTP id d9443c01a7336-2076e4659a9mr79859685ad.59.1726231374656;
        Fri, 13 Sep 2024 05:42:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af49af0sm27754915ad.107.2024.09.13.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:42:54 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:42:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: matthew.gerlach@linux.intel.com
Cc: Conor Dooley <conor@kernel.org>, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
Message-ID: <20240913124252.GA909129@rocinante>
References: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>
 <20240718-pounce-ferocity-d397d43e3a3f@spud>
 <20240904161053.GH3032973@rocinante>
 <e8a5522-de9b-68e8-a24-e07fc06d4944@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a5522-de9b-68e8-a24-e07fc06d4944@linux.intel.com>

Hello,

> > > nit: label is not used and should be dropped.
> > 
> > Which bit specifically do you want amended?  I will do it on the branch so
> > we merge the final version.
> > 
> > 	Krzysztof
> > 
> The label, "msi0: " should be removed.

Done.  Updated the branch directly.  Thank you!

	Krzysztof

