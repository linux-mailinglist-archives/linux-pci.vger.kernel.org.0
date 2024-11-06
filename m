Return-Path: <linux-pci+bounces-16149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601E9BF2BA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E37F1F20F7D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40E20606F;
	Wed,  6 Nov 2024 16:05:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B5204F67;
	Wed,  6 Nov 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909125; cv=none; b=NhyghzubQs1UsETt5S5VwKfXtHoEdi3/ld4wcHQLle3X4bz6vEEAzk+7D4BgWxy+eXjKhDGC+JzJnIoiuoLGmY/JhVQUaFL2tBNH6eai5ajPoerYoq1Ee4sxnYATQbjNW0/hA9XcfnFo3Vh53BoScz6RrNoHiwG9mcf9qLMLwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909125; c=relaxed/simple;
	bh=z++ZeuO7paBJ8+X4KHMkuG1v9kfVmEFqNfHktlRa89Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmiIEYBWYtRteS9LhRNN/Ij9idDPE4zaZDxJdDZn3dn7U08OjQ788Yhtgt0cvvTYJdgOBoKUhfCeN94evHkZSUxb69yprSTYhxrv6rmCkh0u3CsfWYIbDiJN7ZJLMizu/H40R37iKCMfF81s6pvEBrT8KFLA/s9xY8M+gMJAhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so74719785ad.1;
        Wed, 06 Nov 2024 08:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909123; x=1731513923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Luvxj0VLfiOJMq44JnritBWkaYJg5kfsvYj2fMawU0k=;
        b=BqeF/up7fdapWO5t2YwsMtnrVL+I4Kz9JIINxD2ZEbcUhNedQuV0PggJKEh05XXkek
         4UQJRH8qorsNqw99cfmhl1cApxL/B3Q/SLcfULwezWPUvbobKCH8LPMDs0R/SzB5AZA1
         JXqfTQlGr4DZPDWv55E4+XCsP/DjVILtQjUZPnKxCIvejlPkrYrsNx7g8FpbncHncCc3
         KkZnyhr4J8Ys8iFpAp1zVFrbE/asN3ybHXowzDp6S+n4EXAwSgzRTKUmpqTq9y8KHLnN
         UwX3a0roLrxMnvxq5nQX/E1CH9Ocs3aCNIaEzNMS6T04/lOnOt5L3wz/B3Kl20aZsS1h
         sgqw==
X-Forwarded-Encrypted: i=1; AJvYcCVAB4LwixlLBuAg4pStmn+As8Cn1bn7DOvvkHFiY/x1Ur8TIg2bsMYRPZHVKVzHWNkxEylJs8tesmS4Dis=@vger.kernel.org, AJvYcCX2xqAQqhXtKSHdibMc+la6BraZhDwTC0SVnB51mMJxY1XswHAlzbBbA8Sa408dBPbYw6Yt/H3rFDTw@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4lsA5pJRvCQ11UIS5jafPfqkJv5NIwK42xeDqGuI/nzajxyX
	zqsuDLfCob98HaX532/6Q53C0259W/fpmXRELT9iQWs5P/vRhqcS
X-Google-Smtp-Source: AGHT+IGqN+w4IPky+TA68avq1xcHDWrLnXLWGcNEqb+lHzUgWoLGrwx5sr9SnQ1ogPHGuRxHeFbnmg==
X-Received: by 2002:a17:902:f68f:b0:20c:8839:c515 with SMTP id d9443c01a7336-21103ca485bmr325423375ad.56.1730909123048;
        Wed, 06 Nov 2024 08:05:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c7560sm97276685ad.237.2024.11.06.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:05:22 -0800 (PST)
Date: Thu, 7 Nov 2024 01:05:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	u.kleine-koenig@pengutronix.de, cassel@kernel.org,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <20241106160520.GD2745640@rocinante>
References: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>
 <20241106154945.GA1526156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106154945.GA1526156@bhelgaas>

Hello,

[...]
> > I suppose that "data->mode" will default to zero for v3.65a prior to
> > this commit, corresponding to "DW_PCIE_UNKNOWN_TYPE" rather than the
> > correct value of "DW_PCIE_RC_TYPE". Since I don't have an SoC with the
> > v3.65a version of the controller, I cannot test it out, but I presume
> > that the "INVALID device type 0" error will be displayed. Though the probe
> > will not fail since the "default" case doesn't return an error code, the
> > controller probably will not be functional as the configuration associated
> > with the "DW_PCIE_RC_TYPE" case has been skipped. Hence, I believe that
> > this fix should be backported.
> 
> I guess nobody really cares too much since it's been broken for almost
> four years.
> 
> But indeed, sounds like it should have a stable tag and maybe a commit
> log hint about what the failure looks like.

Added Cc for stable releases.  Siddharth, let me know how to update the
commit log per Bjorn feedback, so I can do it directly on the branch.

Thank you!

	Krzysztof

