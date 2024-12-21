Return-Path: <linux-pci+bounces-18936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8E9FA250
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6F77A1A74
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369B187332;
	Sat, 21 Dec 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvYPW061"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76816088F;
	Sat, 21 Dec 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734811248; cv=none; b=moBxlHgEg6xhDt+6l2di9xkt1k2cN+v2UpZ3BnJfzzhk/6LYR7reuGA92s1xQuduh91g7fV3rwE6mGW7gJFNxL8qdNGgixv/Nvx3ZKM/nsXi83REr4/r6YBbNWfjz9Bpm3pPV2L3RS+oHzwa/xJ0xJe1pac+trN9ap06zrrAdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734811248; c=relaxed/simple;
	bh=nNVO0Goi9vCDCiq/Vip93USfQgjxsbmPJDr4SGMCXy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLoTobeowdhyuG28H7efKvUS9SyirWQZFsu24l2TSi+6zZyO/4wgVX12g0L4aiWD3iDawGCXdl1uVHjQ/68nlcH5XDgUZduNg9RHWizK5KiP2SCd+Xm3RyQ8MsWEebY6sgz4DCxCJ/vq+nll2Dn5Uepg7czuqugAG0HSF6eWNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvYPW061; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725dc290c00so3180628b3a.0;
        Sat, 21 Dec 2024 12:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734811247; x=1735416047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++sZud+ut9EJ9Ya7bERMx/AyZDHicCbhSrpkXNg/+qk=;
        b=UvYPW061knQuwifdiyAK5KvqVpisgxu5ViagmWK1d/WXC0JV8pBTTFVAW2NI0UE+EZ
         iQufzUGG06HaJkEUG1o9dVwsCNzkRZMllhYZHwPzJ3ZlZQ0cC1QA6AmHDzD7n6d+UC02
         6QnYQwnAsS2UgH+ogBIGGv0lElCUNd42cd5ZIxLxB5FzY7Kf5J4tYm8GdMMw5q0vz1qZ
         cSoTGpJdTMCbodjDpnW+4/CQ4GwGfXPdQ+qXR5fl8/bq6uD6GsYrtjkgBjS6DJMTv7/d
         vEYpkihZGaYh0g3IPS6Ikvmh5xkDBVZyA3QDZFkTIg+kDyt42lGAuVHJgru0WQjaQrwa
         q37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734811247; x=1735416047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++sZud+ut9EJ9Ya7bERMx/AyZDHicCbhSrpkXNg/+qk=;
        b=Wc4XMCasvSHgWjHyTwijwH8pvz8O20m6f5jJjKDGrlYBBJ2VHhwnPBeOnVV7HZ1tsz
         fTjUGGPNCDpkcNeZuyj6eJ8zdhAROFeMKotj8DAdY96007zCV/jPpzY5NzNe9IB2ErAs
         W8uav0zwGfYJgm9RCc65KB4RSFXiG7XpzLyo2M+LuOYNy+JQBM86I2CTbsSm+62x56Ha
         ItduWxi1sqb9cTpcfHDi1FMXKUEOdj0bRiTYvgdQyKhV0PMDi1NJZFzNP+EuaAVLXsp3
         ItK9HFvdfFbqgPDWoxGEqo9X0kgN6A44+lFiv5EVmzihrLODl5z/GS6Wxieb9u7OuQwQ
         8m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiUbDdUzjsu06IkqYIJaHf5dnFI5KxvQDswSIvDrfxfxG/F4+p26SkRY9lsaRsXxJ0rT5DZOlvn3ndMQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjk3YqODIJFZpVGUqm/BRbBfNYR7abCzQkhH/YoDcD+1UHWAx
	gR+bgxfLG++7atmqhpxB3wHGAc8vz5o9fCd2j/3TDylBm/c7QcTK
X-Gm-Gg: ASbGnctUuPyO+aM38dLr3f5r4zkd1YmIiyfKflmVcjyUyexTcT7mVKrHQ4rKFIiCXgb
	l9U5hnDVjZRvlqYe/XpdOKedzCPW/zHBlQLR+dYeMHibW//m4TeoSIHx79mtHifNfsCWUkXaIOc
	9ugHcmY0Z95k7+zi70kPwBjwLkQhscVmYB1W9lt8vrupsT1L5/AZxR2UAljT53SSE2c8IQB1fJv
	EQhSB4SCYO43vrLHn6yl6nS49YGqwOdjQ1AbO4OT89JM97Gb2olVg/JrxrRSAKZLf302RDGJWcE
	boTVGuGJ92x2hTJ7y70ThBCS
X-Google-Smtp-Source: AGHT+IHyafQBlJprLAJYqZ0bidwY7bJK6JBQ161KSnlphg53gNDPZb2CXOXaw+HLcF1mbqcafBAjww==
X-Received: by 2002:a05:6a20:3d89:b0:1e1:ad7:3282 with SMTP id adf61e73a8af0-1e5e1e26e2emr11650950637.7.1734811246679;
        Sat, 21 Dec 2024 12:00:46 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c244sm5088002b3a.195.2024.12.21.12.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 12:00:46 -0800 (PST)
Date: Sat, 21 Dec 2024 12:00:44 -0800
From: Mohamed Khalfella <khalfella@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: Set RX DMA channel to NULL aftre freeing
 it
Message-ID: <Z2cebDu0jlngBUr1@ceto>
References: <20241221030011.1360947-1-khalfella@gmail.com>
 <61237444-4c0e-40c6-b478-dc997e49cfa9@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61237444-4c0e-40c6-b478-dc997e49cfa9@web.de>

On 2024-12-21 20:18:24 +0100, Markus Elfring wrote:
> > Fixed a small bug in pci-epf-test driver. …
> 
> Please avoid a typo in the summary phrase for the final commit.

"Fixed" was changed to "Fix" in v2 of this patch. Does the typo still
exist in v2? If so, please point it out.

