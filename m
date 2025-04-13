Return-Path: <linux-pci+bounces-25720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87132A87074
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 05:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D41A178A95
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218F5D738;
	Sun, 13 Apr 2025 03:07:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE412A1B2;
	Sun, 13 Apr 2025 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744513637; cv=none; b=Ll6fu4l/JyVi2mQnUFYrKikJUF68Y11aEv2lS/cL892TdG/ZdI1dcPtGrTLva4DCYUjnM6e3uYkf8Ogi3GRJla7O0W9LCKpoAD1beccltxnUxgmxRebgzeAfbl0ZWZQxK+JjWlEt7Mn/zDf13HKzU3pzjMiAkGjnPHnOiOweD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744513637; c=relaxed/simple;
	bh=1vQaQxxmCYPStklzvG4W7yaQ5/KOesKvwxt8vNcdF54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2ibLa+djAkoccvAvRCCHQq/3KPafBQSdiwsURpl29K5/hJijlMi+GDyWgJZm8Kz8N8a1PCnTu4BNKFHf+7bIPFMmg5YsQM7kXB4tAAnhOluPeXml43kLbXrxZm3FkeAr5NppxYFVm2OGzFm0RZJrsyu274/t9fWJZpocvxj220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-226185948ffso34839075ad.0;
        Sat, 12 Apr 2025 20:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744513634; x=1745118434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L90lsaUg/HkOf+fo8wL0zN20AfKMJYZV0UX9Ae0Auxo=;
        b=giKt8ND4lLtdNZYvieuyYjWDuO+6gMfgCP1LUdmdp50BUIbkMVCsSlK2++4T73KTRP
         vEfGU0bxEblIoLrDBUYXKxTgD88uYljRTFHd72giTDq5fRjXis1CO/WnM++NOCw9ggNh
         TGpfs0d9z1m0Qgt7dRaRroYNUVQuHDB91uPbIS4F9p9Z/b8lQLtVUMw5bblg8JnCX3S0
         KzGmLrEdwiVUK8Yid5mbwRGhzHVo+XsOBk/kKvWvqyn2weBXmSNNyeByvJbH+YxQVWVG
         JraBvX/NMfpGoulX6sTTrapP21iiThCF8KP/EPiRzm40udZQCoBR3DdFdhF+7iW64scF
         vNww==
X-Forwarded-Encrypted: i=1; AJvYcCVKFx1OI7tJtB0z0pMNTZdCTnOPQiaVjw88SFhXBHQu0fO96nFiWhj65xgXAgiBDjmkwAMdkNmK3j6VaYZSkdM=@vger.kernel.org, AJvYcCWRerlaL/ajQRqWPSWHBZl28qqeFENf0Gv+FN0mureF8gy0foPzpRcy4QHc4C0J3qlM1gbYkCOs+0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOkErhkldNFcZQ16AIwOfNiVPZ3HVMfHcBL7JnaAXmTMO+AgB
	5tCZHD4G7kbUGT52ZWwQv7FQcGB96tEeXjhYChurkhlWj6nr++ky
X-Gm-Gg: ASbGncurCGqmPJbUfrzqqk2z0n+9cbWdoMb2TeR/LTCAVmBOGGWorhlmBgqZX17tTRi
	SFTjFB6fEn4XVyG+M8bHahx9XbvF+f72Xc5IUvUDvfVKG0SU7Queu9U9AaxgvRtnJK0SgY3zpZy
	4hF0cVbJLwDSKgU1ozLqxwneXqROUpd+DIUHG+QzFazibWAkRmZCohgTpfnvUvLkMToE8qM7Uu1
	RxtwUzAdcJ7V9H1Cyd+v5Wcf0EiExCdpUc4sipQnVH3jAiODeQdc5NgUG5d4l8n7XvfrQVTAwD0
	uKolZN7mPLSuQvkgHpClrbPShDrn+Pxrzh7FncTsmBgCEbT5oTAgkXQXYT1BzL3jNBr+1X54fVs
	=
X-Google-Smtp-Source: AGHT+IFAXFWB8N+GpLovhG7+5h5ck/ogyWkJnI92fQm7L8/xzJGcaeDPCCKpORhymPUNuCIWNglkmQ==
X-Received: by 2002:a17:902:d585:b0:223:4d7e:e52c with SMTP id d9443c01a7336-22bea49583amr124753575ad.5.1744513633595;
        Sat, 12 Apr 2025 20:07:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7cb59a6sm75151585ad.203.2025.04.12.20.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 20:07:12 -0700 (PDT)
Date: Sun, 13 Apr 2025 12:07:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: pci: add entry for Rust PCI code
Message-ID: <20250413030711.GA2664531@rocinante>
References: <20250407133059.164042-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407133059.164042-1-dakr@kernel.org>

Hello,

> Bjorn, Krzysztof and I agreed that I will maintain the Rust PCI code.
> Therefore, create a new entry in the MAINTAINERS file.

Yes we did, indeed.  Thank you for a productive conversation about this!
Much appreciated.  Nice to see Rust thrive within the kernel. :)

> +PCI SUBSYSTEM [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Bjorn Helgaas <bhelgaas@google.com>
> +R:	Krzysztof Wilczyński <kw@linux.com>

A small favour to ask: after you merge this patch, can you alter my e-mail
address to the following: kwilczynski@kernel.org; I will be moving to this
one as a primary contact for all things kernel going forward.

If you don't mind, that is.

With that said...

Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof

