Return-Path: <linux-pci+bounces-19938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C5A13105
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 03:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9268F18888FC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5A28E0F;
	Thu, 16 Jan 2025 02:03:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0E70809;
	Thu, 16 Jan 2025 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992985; cv=none; b=o9TAFrESX9bRtZVfNUDDoidON1Ujafv2S2qFX4skcu3a0PxiCA1gPPCvwWY1Q376qiKfcLVItRtzwEtDofneHOhZfVmFZQmjrQRSP9yaWAAc5gp8LJ2UKoDNGUEyaTYcl9hfAcXCBiunBg3KURHEGj9hcBsh83+SRXsdgGLJxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992985; c=relaxed/simple;
	bh=TRokhHhCa3PJ7I0orQ+XTQM86OH3bmU5yc7R7VyYXWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfmguvZ5/2XvkFAGOIpbZcrMjpFU5HpoqYQKNqesa6UIBtAfrC7weMMzavjRaZHvQGQL8YN9Z3yfSh8JxHJmIRqoHcyIptoBEGs0DTV2+/0WK3nptxRYg3oPnw9lOjcQJV4Zi2rfXJe1uCVNKtZfnj38Cr5CSQEkHWms0t30jG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so5648715ad.0;
        Wed, 15 Jan 2025 18:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992983; x=1737597783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyQSotZ9l/SbnEiWrWMzfZWVUrme3vuxV3iYwGxbVCI=;
        b=rjZv3RhGrASAo9a8dGGpwvKlHG8LgvlDxncNGFF9q5BukfZQbCam4cDM0F8funrLvb
         rSSRQs4turILlIqxc1tObAtIVqLslNanmRI0Xq8VuRrbs7Tcyil88PtuGLXbF9TkpZXW
         Dmtxa63GJSu38zY4U/QjooVjS1pCdoXnY/+X8wQUlGjKtnT+IAL68y4WDn6hDdddcQom
         2QCAuRhdMhO4RbkJXkl9gOE0W/wX9+rDsz1dykFzGZp+hqPe2RtiJa8EJur88hTcQLyG
         5BerJnBBshC2dS87+YG30AYg1zboHHCk+ODymgrUx2gVZHXH/XvrSNduqJD7Gx5DOYo5
         NpDg==
X-Forwarded-Encrypted: i=1; AJvYcCWmZWz3NNgF8iAize+OUknSiBxd7aZMzwjzrXa62AFKZoYUaLJuCqn73Sa8lVHMmc+Uoyho8vJhsxrBGG8=@vger.kernel.org, AJvYcCWvbVdBMw4j2RuqEeJNoJP8re0fF2DMMWXcbK43T1Bs1NkbFsRspTn6FsepeHS6Lft5CSPG/JyLG0x6@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYxSfprQfSwFqrbptUzHpTSpk9EnBArRwOeREPuzz4PQ4KKJs
	Y56BLxhbyQs0O53skwNHmGs4+XARF71WWhSzAH0Cq8ZD6J58y+BgnkCL3Zci
X-Gm-Gg: ASbGncsXOIl8jT7mt9drKOlgQJL/lkw15cWkBjT31OkuZ+RXsaqiYJuIXfUIYK0g1sK
	xbC7ivDuxsq/8yuxpWhBaleH8Z3hx0izY+GmpG9jqVhnXLeReiSIk2B1D8HTpSODcS8vxm6L6RW
	mdk6uRq45FQPNz4VTRuA8Bq6XyBiDh4xrXgaFQKwJcinOjkbRiHpZvAA7wG5NEHtK5GNPHisnTa
	k+BvKepIOqTAkQv7MWzJ3OY7v4VnIvVSROMoHG14NYfPLfAYila5bJnMDamC0Z/7FX6+deFUk7/
	uOzNiktEa4Hv0Cw=
X-Google-Smtp-Source: AGHT+IFrcD5yPWTME2WiFbWeZzgMFXlACWSjfp7Pi9j+px9nBEGGOtA1bU9oHp4z0a6DFIXPKJ9txw==
X-Received: by 2002:a17:903:2b10:b0:216:325f:6f2b with SMTP id d9443c01a7336-21a83f54ef1mr526797225ad.21.1736992983431;
        Wed, 15 Jan 2025 18:03:03 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm87657355ad.224.2025.01.15.18.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 18:03:02 -0800 (PST)
Date: Thu, 16 Jan 2025 11:03:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hans Zhang <18255117159@163.com>, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250116020300.GE2111792@rocinante>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <20250115165842.p7vo24zwjvej2tbc@thinkpad>
 <Z4fq6XU650iOsFZe@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fq6XU650iOsFZe@ryzen>

Hello,

> I intended to stay silent, but considering that Mani gave additional
> feedback:

I am glad you didn't as feedback is always appreciated. :)

> - The Suggested-by tag should be in patch 1/2, not 2/2 :)
>   (Patch 2/2 was 100% you.)

I moved the Suggested-by tag around the correct patch.

Thank you!

	Krzysztof

