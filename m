Return-Path: <linux-pci+bounces-7594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E88C849C
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2949B23787
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8A2E40F;
	Fri, 17 May 2024 10:13:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2722E62C;
	Fri, 17 May 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940836; cv=none; b=ZZp6LfbiAVJ3FTR29PKyAlvjSoYQluc/ehFY8g6KD9xbTinyh1D1pBRYT2WuffFD5dh0GpUrSXxbtDZOoZLx63taUUNFvKV8TqbOoByvVonstOWVplo60QCb5tXwmodnvW2TSrP/5XAQqZhuZHpGs80b64UEc01YaMB5C+okjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940836; c=relaxed/simple;
	bh=3eS4A6sBBete3+3nwqBVB9lVdGi0DqXxA3+ObVoYmKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5FGhScNUHsc77NcYvBO7eGCM4tOiEKS3S9h6fdE4UpHrI+t66XG+Ayuncmza/UPGS2am35/vsVaq27lk0hLpI5AhGgIGkLUgRZV9e2m15KWKfLZy9n3WDJNGRi0ReXIIbUZ3Jeq+1LhdSKWHNKUUek1ncfKdSWNtwxIhqviw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so1139970b3a.2;
        Fri, 17 May 2024 03:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715940834; x=1716545634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6winQhTaiaX3qtpQtT67k6lYj7ciZqa7ndc5/SwCEuA=;
        b=i9+4OoW2a1P/roslGyb5ilZrreyRvb2zySHKzCrnrIDS65Wzro41DauLTZr715duCU
         5bsAETIMTEI+pQqvvV7+iV9cjqrh/yTZRAio8r17I14VFPWdpl2+aWTgyWmfIA4/9E/8
         mOw3fFnddTBlDpffijelFbudMI4g4kuXizkBPg4XWRQjliuWHromDMn2Zl14aPD6vx8o
         pvd6YN4dji2CeGWz853LNGrkokhg7mZlJM1S97Y+BR8Dj/rBhzOjremqHCgGPSTOmlZI
         xLT0+vC25Gymx1pgDE4SwA9nwj+V1QOu7YVdQUgmgzkkO0se6+jy2oUnSKu0U0i8YUip
         w4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtSaMpR0dkPdQxYBafewAV+Yfpqu++w4GxR141Pa0TaC31CuQSaeEBNUsiyeVqKaDMGy/W+YJFs704HYMI9bI4DFgkUdFOUWCCYyy8n6qed0wQr9q073P5Qva5lR1hv6GyplU7W/mh2RKRfUVEsyNNCyW/MwhAJ9Zes/1yWj6Z
X-Gm-Message-State: AOJu0Yw4kI43o2wVs8Ex4ZwLPvhBa6gwfJWFzK1Q8+UqlqBZen5NbkKK
	tkiPQCXOwyKBjW5eFohPI7vwBDb4msjn4+GKcdZdvT3qBKfjxZfm
X-Google-Smtp-Source: AGHT+IG9P8DIxQ8nLaNW5D9C+GvuVUP0c3EKFA8sgKAW6lF1YQHb78ZqQuJdMoV41TSUncZYR6YNVA==
X-Received: by 2002:a05:6a00:845:b0:6f3:368d:6f64 with SMTP id d2e1a72fcca58-6f4e026b863mr28976797b3a.2.1715940833974;
        Fri, 17 May 2024 03:13:53 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6688ed547sm6734600b3a.165.2024.05.17.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:13:53 -0700 (PDT)
Date: Fri, 17 May 2024 19:13:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com, michael.chan@broadcom.com,
	kuba@kernel.org, davem@davemloft.net,
	Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH] pci: Add ACS quirk for Broadcom BCM5760X NIC
Message-ID: <20240517101352.GD202520@rocinante>
References: <20240510204228.73435-1-ajit.khaparde@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510204228.73435-1-ajit.khaparde@broadcom.com>

Hello,

> The Broadcom BCM5760X NIC may be a multi-function device.
> While it does not advertise an ACS capability, peer-to-peer
> transactions are not possible between the individual functions.
> So it is ok to treat them as fully isolated.
> 
> Add an ACS quirk for this device so the functions can be in independent
> IOMMU groups and attached individually to userspace applications using
> VFIO.

Applied to acs, thank you!

[1/1] PCI: Add ACS quirk for Broadcom BCM5760X NIC
      https://git.kernel.org/pci/pci/c/694b705cdbf7

	Krzysztof

