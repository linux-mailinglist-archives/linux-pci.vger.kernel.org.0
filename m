Return-Path: <linux-pci+bounces-24726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4EA71083
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70450188AD80
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FD17578;
	Wed, 26 Mar 2025 06:25:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2E17A58F
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970357; cv=none; b=W/Xk0KgWCzP+kotR62kAAS1LTfV2GEsHPveffcFgXzRC+xHJDJRFj1EUUJ56Ladjba6QtfWyl7QvEyR/YXspiD5ePM0L5S0CTzxTsf0dkMZ0ryEunixyQBidrfE9wd/+mBKIfoDm3J8I2f+EG4Vmeo6gei2XXf4+rbJKTxKKDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970357; c=relaxed/simple;
	bh=g8qhJPSnxnsDGk5K0MnGPyCQyHvILwdRDW07X+dQlqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Knmh3lyAKuQFJc9yqA//jyEENG8dd2criAhqTIYdSHz8LUSpMLUbmqvR7abNxjvuZ0EZS29wNbkYZiglxhlFJScoX3rdNwXmoYr1OFT8tMITGuuSYldEN+4kEE52LOWfxNS7fYbJFp9Ew0EeXYAvzgAsBsDnllJQwVOsr5JN5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso10600685ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 23:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742970356; x=1743575156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yULvBob6zYMGypAK9+U7tr5nSRrQZ19T8BGKuPRenQQ=;
        b=Vb3B1AFqXl0OboU3CJYwlUJ2s3bONvtZXm/pAg0re5usw8QuyVJf6w6KJXR+e1w7jT
         NjRPJZ7i2ZVgWfrWdv3CAAZMqto9YrIek4CnmmhjKxzV0Pb9RDMjfAcWCFhi/087OXH4
         GrOjbbhoxHM1NtMUXlHr995OoaA7xps+iIZUOYnGoSPDkS4w+RP7LmVavnyngiVU3i8h
         FOjaFBe7st3asvgJMaCCf7EwSvSXDRTuPyToA5ZH5p6cpfuz3Q626DQgVkqDKCGWLwNP
         gzct+s/IYdYF67XmqJp9AJRva7GxIu5PnvbVaB/+tPzY6T0DZSBFvJZYmYtlX2AXPo14
         ZEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlojuC2kiVWg84so1Xf2Lpbbw7GWbhX/XyZgsVaVAOVOdxZZJJnlCJ8gLMfAlg8j1LtDU8dxc39QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIf0jPkE7Qlkv1WfbbqHFNXiCywLe1zfRapYNAxedFk+yCywJ
	Z++1bBc+8uaCKKOXXZcCNSSvbp9jTKs0sLj+HrGpDdkYP9zH40P8
X-Gm-Gg: ASbGncsqy5J/LYcAJ/ZZF9fOa7wgwZhvDN/NKnN9K4IjEURkrAkzzsstr+cmLGuOO7U
	nNY5MHBgw0/5SxbuORAEuURW5iABzHS57gE3S0rl+/U1ICbHqw2SN/DobKsHLi8bPLjW2q1aPeV
	Ur1gC6mIwE3rJHVBwjLYuQd874QzpodVAq9gqwpkmfoefzlU2EudHjmHElYzrh6sIrrHiWa7V82
	aHKI25AeQ6vN5w4fKXIwNCoKf8P/N/KarEWfo3C3sjkGx3bsnwk5bvvX0BCO1NAK2nqwoSGlbAq
	ma4ZFMt9wHVkSz4miy/JRTQ8Ve9YUBpLjq+DRMHGBM5AI5V1wZJPqWJRJqGk5oFjuYXy+HxHdG7
	zvdg=
X-Google-Smtp-Source: AGHT+IH+2G7EL/sYZzjlLZQ5OeKWFOz9MCQZiZMJ9I1YkH/aFCZk9AFS9/9M2XGOwxYO9iiJ5rJf3A==
X-Received: by 2002:a05:6a00:3a08:b0:736:476b:fccc with SMTP id d2e1a72fcca58-73951563ca0mr3816251b3a.8.1742970355610;
        Tue, 25 Mar 2025 23:25:55 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fd6dabsm11739557b3a.69.2025.03.25.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 23:25:55 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:25:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/7] PCI: endpoint: Add intx_capable to epc_features
Message-ID: <20250326062553.GB2822343@rocinante>
References: <0B197218-4163-4344-8D99-0A90EA6B3CD0@kernel.org>
 <20250321224230.GA1172324@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321224230.GA1172324@bhelgaas>

Hello,

[...]
> > >>  	unsigned int	linkup_notifier : 1;
> > >>  	unsigned int	msi_capable : 1;
> > >>  	unsigned int	msix_capable : 1;
> > >> +	unsigned int	intx_capable : 1;
> > >
> > >Kernel-doc warning:
> > >
> > >  $ find include -name \*pci\* | xargs scripts/kernel-doc -none
> > >  include/linux/pci-epc.h:239: warning: Function parameter or struct member 'intx_capable' not described in 'pci_epc_features'
> > 
> > I will send a fix.
> 
> Thanks will watch for it.

The missing kernel-doc has been added, see:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint-test&id=4b313c69a38e28b2f002198c3909fb553e9b0176

Hopefully, there should be no more warnings.

Thank you both!

	Krzysztof

