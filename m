Return-Path: <linux-pci+bounces-23811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD259A625E7
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 05:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBA6880704
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8818B475;
	Sat, 15 Mar 2025 04:23:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FC13AD22
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742012580; cv=none; b=jvkIfqX963Vc3m54hD6Ka1e/INaQLp3+kEdo9DOIZGr0wf6cv3wyfAC2KmVzsjLqwC5yCLZX8BkH5Ozy0VA7LNVe/LoRWEFk6Lyz2goB6p77dpG+EkpHXrCCVVa6p2UqJzmsM9Dm2grovCIvtgsTaKfAmc9cKIFgi3Kp3BhT/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742012580; c=relaxed/simple;
	bh=62cAPYMM7McY+lfAzPASnTQs7MNpD7FPMLJg83ACISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn8fVP0tczBsXeRnP80/2eysFbNYg9L+AtmiYZGdjOk4uOmia5JOGVwZeun4RV00AIS5k9PwrsTtXmETXEZIOGM1S+6ClGwCQwM4mI3c5AIJAHn4+60b3IK1C7tEOp8Cfauhkm5jgJeF22W8lUtXYDj9dQLX0Z3FEAk9H24vjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso47974485ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 21:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742012578; x=1742617378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8U0K9FXB2qvtYU3gfOpe3vKzPjFe6pziSzCUKKq8Ck=;
        b=i83skrISdmBRXoUrPm7t3YI7GX3BtSUcveZjFpPo1uBT4cubGE/Zx4wRiAvqpIvULG
         B0wylnxzd/C6gUlduMRup7y/zOI8wjuCAhJLsZFJQ3xFgBlqytez0osNpOK/RnhVDtMZ
         IP15QAb7O85yfEZ4f96pkWd6yUwWD0n7Lefb1MYKw4z3BRAudetM/FoEHSE/ekfeWUsD
         MqOmPL5C3eg1RsGZF89c1D7xI772jrhJoi4s7STNS/mGtINnvAM8EyrauePU4qd0TeOq
         UBAu/mQLrEo+WzV1mBD9PqkMrTdxGCv5NZB8gPxNZxA1Ih3y3KjxkSdLZSxS055G8uBs
         5bFg==
X-Forwarded-Encrypted: i=1; AJvYcCUl0YZQQbTdjTWpN5r5FlUDklwOttIQgpe6Rj9/Xplz/rlcFTQ/TsHQXROXk4+xUZvJ4+SOWGq02xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsc9vrmHTsxMI2CoVjUeTu3mlDfDRq91q6AKj92eaygMlyesgI
	ywf+Dar995UV4dMIPNTUD1nH5whzPCeEuzmNe5ALzAdStC+ee2Hj
X-Gm-Gg: ASbGncu5zOuqCbdn9yCnHF7w2SbISBJT5q6VvW5i9Ey7KTK0Z5fFtHw+fsaIJutkQZW
	DiWKRWeh3h95f0ZVQrup+lCR4OLwVc5sRkX/i6NQdwEhyofp2yie1hHQMBkloFd4VngkMCvcMXZ
	gxdiQW9RiNVAJoVZuqSOgHnBRe55RhcEFOLlO2wk8oThb+OaP6oeo94e4fk2fWsQLAL82b4D0x8
	YhNjr7WiHtmFbz9Fy3ugjatoAz0InEhTXJwogem4GGYX8lA+M1Cc7s5VVEkjsrvRlDzIvDenjJ9
	4oOm8i0ZxTze423GDvBU48GTsdKJGZm02EQpI2CO4uTN3JHQwuqPm2JgoJPM5kYijIGm7q6s7Zk
	U7UQ=
X-Google-Smtp-Source: AGHT+IFtwnMOAfhZFXJUuPvRbPNil1y66u0LQojOfo9xwTKXhrNxUpg+Jt9bo+ursNMjjPZwyt/xsw==
X-Received: by 2002:a05:6a00:21d3:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-73722470508mr6460907b3a.21.1742012578020;
        Fri, 14 Mar 2025 21:22:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293desm3673106b3a.9.2025.03.14.21.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 21:22:57 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:22:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Message-ID: <20250315042256.GB167520@rocinante>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
 <20250314162838.GA781747@bhelgaas>
 <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>

Hello,

> > bcb81ac6ae3c is not a valid upstream commit.  It does appear in
> > next-20250314, incorporated via f5a5f66e2791 ("Merge branches
> > 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 's390', 'core',
> > 'intel/vt-d' and 'amd/amd-vi' into next") from
> > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git.
> >
> > I think there's some value in keeping fixes close to whatever needs to
> > be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
> > to merge the fix the same way.

I will drop this patch then.

Old commit from the PCI tree for reference:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=quirks&id=0cc24e705588325583f2b77662de61339548c39c

Thank you!

	Krzysztof

