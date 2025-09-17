Return-Path: <linux-pci+bounces-36328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E88B7F460
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37EF7AEC5F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1F19F40A;
	Wed, 17 Sep 2025 08:36:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585333016F6
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098175; cv=none; b=BSKcoTWpFE5vYJ1dSRPiIrXE8DIV0fYT/rhNv9s7/GKLFtUutQ27WmuAvlBOL6SEd67PQho2I2vGHIucsl5NAcweRBH67MyNQbmbayHQ836FxJXQ1ECt4H1L3pTGnNZmCIFoyaeQei4yZ6pA9iT0B0fuXm4sTzmmm7e6pw/4j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098175; c=relaxed/simple;
	bh=sXFkn3fuD3qapzhmeLtcjyz5+yB2lVkMKUy/xANyteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBdc+Ro6MduLmr0us0l3V6B95b/0eAYGF4YUn89n3e7PHQ+bV43mnKiXGiSTW3/vtaWtS3EVA7o1z3PA2cpF9/BRYXW2sPQ7x6Jof1RNMY7kNkVUSsMV9WPz6qR+Zk6+ZGhr0mVWj3mTpLb4WgpZ39tUON911dZV9Mkfc/+mdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so5325949a91.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 01:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098173; x=1758702973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5C6ubQVztzzRmQnjXOEGDILcUWZK/yh+JDrJ9NOH2l8=;
        b=WPZ1Xm/iedkjeazi6uMEzr0lNFT7+kN91ooCgcOINFX4Ehdq+up7lJGt2FFxImqtKG
         8M+gonHakuKfHg/dRDyRp/tSqxSKFx3u1tLoyGLXNtuLjSo8ISD+PIF6uZrJIF2tucY4
         lEzQXv+f/oY4FZv3hp/A2siUBzfjLXbCTHOwVWeioW57LHUPXDcUknYjxnSX2BNZR9bv
         ei1yKT352+sv0vkWjBfMgH3l5e0+RprvgxwAEYKy6CriIS2wwwlgUl+SazwIyo9QDD4u
         ATvPcnscdFaT2xHWM5fTYyF+OIwEnnpexLfYT4DBdbdN+1fiThhTyWemakEU0hbHVx7S
         NF6g==
X-Forwarded-Encrypted: i=1; AJvYcCUGMAE9T5jm+Cz6qmCjLdZU8ru17d0WFoi1g5PSEAgjGmCHAAL0zK+Y1ktK7F1ti1t/KI/vIjKIFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkoPTWn8GnWsmLnFvhfxQkNl0CWDuRfhtW3mY90iO7EZkED8t7
	6yqcPb4w2VBOAJuSUK0gVehyc/vdiWknhPw2EMIsMt46Qz9z0RGLuFDL
X-Gm-Gg: ASbGnctwoGoiinyM8+wwHiV50W4D8y47uouPWSr+0Kqq0G8AWE4sO/KH/3PYpStSUNA
	0H1ao3BHeKbKtDNL/FuNtZcoPratCagyanpPC63ZDP5ZTX1g/jgDkI5TFYVrLg7D93CEMcgVCCy
	6vmY/1BxfD/42Yiijw3av/89pGPaDFQssMYFIcUt0+ScDShv6nVaUg9hiqJUNwVPS7pzSoYpfNc
	NDtniYmvAHyt+aPjSinUdf0lbgEntqywIjhAMxx1fo7RRcopDh+iR4Ud+udMTgRv/zzRbjuw5NE
	1hROqb2bfckAT3eNdaKnt6kBRBO+0/VeSPWF61ay9rZJh5tpCLxhpiB9LDAbyKaICGyx5coZOcV
	cyT5j0VnsApGtG2A/zv/W8KB8EHfTSIzkNgMq9kJz/Lv9VJH31k/9/YJzhg==
X-Google-Smtp-Source: AGHT+IHADwAA9JCqd2quqoOP3FocyxM/8owwIIVqvZ9oow3gcrEgcb/6VhdirEK4z8X/BFS9knXdhA==
X-Received: by 2002:a17:90a:d88b:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-32ee3f7b4c2mr1574450a91.26.1758098173401;
        Wed, 17 Sep 2025 01:36:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed27612b3sm1764647a91.22.2025.09.17.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:36:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:36:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917083611.GB1467593@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915193904.GA1756590@bhelgaas>

> > Add a single sysfs read-only interface for reading PCIe device serial
> > numbers from userspace in a programmatic way. This device attribute
> > uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> > capability output. If a device doesn't support the serial number
> > capability, the serial_number sysfs attribute will not be visible.
> > 
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > Reviewed-by: Mario Limonciello <superm1@kernel.org>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Sorry for the delay, I have no excuse.

I also didn't noticed it has been a while... This series has fallen through
the cracks completely, indeed.  Sorry about this.

Thank you,

	Krzysztof

