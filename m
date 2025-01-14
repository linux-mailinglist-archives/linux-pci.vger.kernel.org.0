Return-Path: <linux-pci+bounces-19718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75BA104F7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F1F1881C97
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF71ADC9B;
	Tue, 14 Jan 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YtGFyGJs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8722DC44
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852630; cv=none; b=EUToyBEp1QXM8JBvRdXJMhDDtcyGtuPlYTSMpRruApizu/bJoeR6L4fJ+R+OtslyJcbbUj94tdXAxH1UcIB7VNi3gZc7nisy8xy3FfDsVaYm7pfzRtbdg3JdYhrjwgXjmspxWNY1fWoR+ePH15D0Ha8Bs+98AeiEOie/PZmuDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852630; c=relaxed/simple;
	bh=aSmMng9eKf26wg1r0aBPpvYHaZZwRH/rGIiKvyzJ/Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=navO0nvEH7s3H21nP1prXr9l3AfEsROVNtWYspO9wRmbsyAAxZRWQSLVSCpNP3qxfxQgocyUSFzuiXPkLB+hud9NIp/Z5aO+ORz6JKTHh5uEYIW5EUN2fHB8wMQnBkzFIPKmU03Ro8Nd0LPUuRfs6WOGALF1Fid6DRWO6tumt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=YtGFyGJs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so10312937a12.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736852627; x=1737457427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=35mB+QjxPdevR8046RphJsKVW0nB2adhW14D5bTUKJg=;
        b=YtGFyGJsjnPHz6MMsJLiS/r2KPd6LGWylHGYVFGc9FICGaj6bB3CpWlQVEQ8B4fHry
         zgcKbxIKC3Eyc9b9PGxfONxzSpMtvEid0vtZ57K4P/RBb/E5XY2xC7FqV8bdirQ8JcSH
         MYutwfjdStDVdLG7k1O6hiAvQPl3exMq4rYTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852627; x=1737457427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35mB+QjxPdevR8046RphJsKVW0nB2adhW14D5bTUKJg=;
        b=vHlGacXC2pSj6nVnUMzO56HKTy8HdblOf9E0b1CVSTjx9hWQztVoNTFo6tVY0/99Eo
         jQjhpNu7UluwwPZ/jKqIFRDxdNV3dcxETn7hrmUo9uJ4+k5aCk18HCyTZ+RdvYgB3p4f
         ecKzU2goqzUm//YDiDqjGEpaVWkY6ZDupL1nQ5UEdZAA9Kci9YW+guLgz18ILSBxAkcO
         yP3c4xMzrSe3tlPesoPmv+SRJKe1r+3LWIlL7oVLz56mn/rRuGmOdG+nFSW6/OAc53ob
         5JL0tBrECQ1JERKanojrwpU8SdnLXvgIO0MFpKRMgpKt3xS/Sezm2WqABnsK3ZkwcmsK
         h+9A==
X-Forwarded-Encrypted: i=1; AJvYcCUoZuw5H8H/Qy9df0E17EzpQOAR5qMBwS5f9CIdfTXZYwtAtppqnDhD2n1r5T8AI//YkXZMtd1NbNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWwbh9tRR4NPTS9K8RBVQ+qOAc1g3qfoea/jpVVgE7TKBFtia
	GDs1+5Vft5FBLNiGRatSXYh3020c9eMzf5k6ZCZ2pT09lCPIosQQKNMNDDw6w/g=
X-Gm-Gg: ASbGnctnZJQDjqHXp2hSRkRVBsC6t/xq0xPy8533JWt4t+Y5unOnjzRxmYP+WH0Lq7z
	cWzNZzbufiya6nv4Awh5qhnwQebe4T601AP5hBBzu7T9Ap6vIoHGRN+4F9HfABBBOj07quEFTXv
	j46VFEbHDX9G6/35Hq/vBSJC5flWnbW06/V94smdTVM2Bn+XN4XL6UE2lkC7OK7lku9LcxPrSxu
	zEFdeSG4cNsyuW+F7Wah1h2vzvAz3n1tJeZWubJEhYGLCyNPPWBGraFsnEQxJqWY5E=
X-Google-Smtp-Source: AGHT+IGJNe0LSVA3nGJ258TjPthdYloWMFdub4oksN9mfoT80xGa7EGoGjJP2iGpXQ9PWDACteVGUg==
X-Received: by 2002:a17:907:d89:b0:ab3:3aa6:7d69 with SMTP id a640c23a62f3a-ab33aa681a2mr240126566b.41.1736852625094;
        Tue, 14 Jan 2025 03:03:45 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9646bf9sm619310866b.175.2025.01.14.03.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:03:44 -0800 (PST)
Date: Tue, 14 Jan 2025 12:03:43 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4ZEj3i71TTPkuwc@macbook.local>
References: <20250110140152.27624-3-roger.pau@citrix.com>
 <20250110222525.GA318386@bhelgaas>
 <Z4TlDhBNn8TMipdB@macbook.local>
 <Z4UtF737b3QFGnY0@kbusch-mbp>
 <Z4VDIPorOWD-FY-9@macbook.local>
 <Z4VFAZnQ_09cdexm@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4VFAZnQ_09cdexm@kbusch-mbp>

On Mon, Jan 13, 2025 at 09:53:21AM -0700, Keith Busch wrote:
> On Mon, Jan 13, 2025 at 05:45:20PM +0100, Roger Pau Monné wrote:
> > On Mon, Jan 13, 2025 at 08:11:19AM -0700, Keith Busch wrote:
> > > On Mon, Jan 13, 2025 at 11:03:58AM +0100, Roger Pau Monné wrote:
> > > > 
> > > > Hm, OK, but isn't the limit 80 columns according to the kernel coding
> > > > style (Documentation/process/coding-style.rst)?
> > > 
> > > That's the coding style. The commit message style is described in a
> > > different doc:
> > > 
> > >   https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
> > 
> > It's quite confusing to have different line length for code vs commit
> > messages, but my fault for not reading those. Will adjust to 75
> > columns them.
> 
> The output of 'git log' prepends spaces to the subject and body of the
> listed commits. The lower limit for commit messages vs. code makes the
> change log look readable in an 80-char terminal.

Oh, I see, thanks for explaining.

The 80 column limit for code mean the resulting diff (and `git log`
output) could have a maximum width of 81 characters (because of the
prepended +,-, ), but since Linux uses hard tabs for indentation this
is not really an issue as it would be if using spaces.

Regards, Roger.

