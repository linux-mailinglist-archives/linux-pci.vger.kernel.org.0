Return-Path: <linux-pci+bounces-12624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C9C968CC0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78E91F2334D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C4183CBB;
	Mon,  2 Sep 2024 17:18:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903361CB51A;
	Mon,  2 Sep 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297484; cv=none; b=tceLD+y4MK14P8lhyHgJ8F1BVJtzlwQjchac6XF/J6eLc/f1TuiRHyfbB7u2F+/rMsq0FeRIsk9VoLnLNLib9QkmcoqDlCBrtSr6luyPu0G0h2odNxMOQghMjYjNKTQtvW5gm0upj5hPSlvEsEGg2mYeLmoCfy7tDbVzlDm3hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297484; c=relaxed/simple;
	bh=XE7yixKCkfyUSqbW4Qd1sTX0RB2ADF2jUeRclm6OG54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbCAdWiLepVbHvt2bQC3oXA+jZJdqLAdqh7rxKt404AJO+05SvEDnRVWfH1MfPVDmaiywxMdEpp+WnvuDgKL6/QOB/SZZVCbLfimLEuI838dcNsvwownHWzHMtJbr8JXRs9QiOS0H2PYj1rsV6p6oN4EFTBcC5RyOo4hTOZ8Juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dc93fa5639so2705494eaf.1;
        Mon, 02 Sep 2024 10:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725297481; x=1725902281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O44tHfvvDbqByf3bZ+oGeKXM1Pxf7ZvWanM63x2ywV0=;
        b=dJY3VHCjB542BiQdqyVVqypF+Ilauq/XK5aWj0ZHp+sftbCiHNWg3ROtq+B9llVwJN
         Z6IyBLq9Jxe1AKlZqfjSx9Owe7eRnUFm+bHokfMiR21f7EhAnEvOBFz7nszi26My4920
         gbf40GPxPIcYPj5145F//SD8w4vAZurcs/yz7+oesMBV0MPXNFunfQ/LnYBVGozeLUe8
         5mm+n2qf6Jy5fpzd4l0Fz2TknkR4QzvAU2tAozi0DhObjGfcnYHABklNwAg+x/TMo8wg
         4d8yg77EeRC/T+Hw0M/ZNubEYJHlB7spRErQxVveC19ZUePoeUOhd1c5EW76JnOcVyNr
         NGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffVvdNAg+plnwii/2kCag/lEMS6dkQZ0fMvuA93k/lXKpoH63pffZVgp1LLKz4s4vAztyTJhivfPi@vger.kernel.org, AJvYcCWHJUMOJQrxp5alVvf6WTq7Gg7P+PXBT+F4Ep0i8vocWJos3jNkLdIQtUmoDc1Nys3VdNmKRipAF030fas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7F6sdl6U84ZV28D+CQ0NT/2kmD80JvuS2bTQSKhDPHCt6FLi
	hXmtTt9v5Esm+gf26yTP0/aV8Z9b+jse4QrOSc1HAWaeUFzzs/lk
X-Google-Smtp-Source: AGHT+IFn5454Nj+j0RdCBm04PC2F/m01Pi5LqGawjG35ttYPIYJf77n3EyDAIM7pTlnvJ7TCWz/orQ==
X-Received: by 2002:a05:6870:499b:b0:25e:24a0:4c96 with SMTP id 586e51a60fabf-277d03a51edmr9351907fac.11.1725297481639;
        Mon, 02 Sep 2024 10:18:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e4793sm7359445b3a.178.2024.09.02.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:18:00 -0700 (PDT)
Date: Tue, 3 Sep 2024 02:17:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: kirin: Fix buffer overflow
Message-ID: <20240902171758.GA1912681@rocinante>
References: <20240719122153.1987-1-adiupina@astralinux.ru>
 <1e9500de-3388-402d-84a3-cebca7bc24df@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9500de-3388-402d-84a3-cebca7bc24df@astralinux.ru>

Hello,

> just a friendly reminder

Would you mind sending a v2 as a standalone patch?  So that I can pick it
up via Patchwork and such.  I would be much obliged.

I wonder if Mauro would be willing to have another review of the new
iteration of the fix.  Just something that would be nice to have his
tag added.

	Krzysztof

