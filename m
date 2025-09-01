Return-Path: <linux-pci+bounces-35293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B41B3F0F1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074024853BE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DF2820D1;
	Mon,  1 Sep 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3il2hLb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE4223DF0;
	Mon,  1 Sep 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756765157; cv=none; b=d/vTGmD1imqOU1C2Or0sh7yCGPiQiGvd96Ygzz8QQdRa9iFgNBzByRdnQDtH/oh+EGMXB2qvMySaSmQhGdF4BNOkvd1FjRnbg3jEnnzMOi515PKcO9XZD5wVW3T3Hh96nYuLOx4bfpvUR2NuJWe26P/U4GSUlkw2eARyiqkOt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756765157; c=relaxed/simple;
	bh=nQ7mO5E7c8hbVdsDf/x9IXrKjmvv3jwdOV8cNDkfb4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odOf/HXZTigbQNhqwoZaSHtrD613mNY4dqtejfU4qg7XsXFwjadhkkJ4D2NAgSmLNQvXm1rrTOry/XHJKSsuzYDYtwEMeVxt5x5R2DRwCwgvz21mcgCTxb4r63Sc+ECcWZ5OBV3UqM70UwQIV/HCl2xAljv5raRJwGJ8XiZUGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3il2hLb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445805aa2eso47719155ad.1;
        Mon, 01 Sep 2025 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756765155; x=1757369955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9R6oxqys0ms7HK4n8n9276tCd/V/vMgZikh9AT++SdY=;
        b=c3il2hLbvMGJUjSxi6o2LTqkxYdV87du4QO3vRtsrlKqxo/F09CzRA1D1iy/ebcG/6
         RclzayJFuOP4yX+MEs6g16ruEvDL1g1dLtVcngxSNFV16XpeqltM/e90HeYRZhnT8gxh
         QkfoIBkLXj3+pHqzVqm7zmFOqy610eC6U7OTShTJkKazjitsSEL0vWqETJ2m0sTtBKEN
         ByfjmVVlMtR6eiJtw5j+dZFFjCu8e/RDP2st6xNIJwQ1NCUchPJZi0Vh1l+sXYYNxqIQ
         lrx1QTi3lkduo4C5mubOjRMe2THWN0CpXizxpRp8SriAAJbgPbsto4e647JYM4WTzZkF
         1spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756765155; x=1757369955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R6oxqys0ms7HK4n8n9276tCd/V/vMgZikh9AT++SdY=;
        b=epE2BlH0UOsiUD4UFoAOljMphOBdOSOvg9v98c4SuO3x2F9hjI9J3MR1gSJ2iWkUKU
         189CzWnM/tS7EPD0HzQaaeI78neQNXUfOLT8+bFCgRhc9pAXHYAW2d7jAIgyUxSTnrcG
         1fSwtZCTLDmGiT7boM/lPgAJU79dao/haUjK/SY77q/UP1P1MHU57NcEGHmk1fWJGuRG
         lqOAc0KcsCR6EeTlBSW/NXwQJtfIAWf++hnx4Cq/kbuWaS3GhrdOvxWj7S6a5krB10qI
         LKArnCoY3dPFuu4ywn7KHM9qhG4QOwpF+zosdvaJZ2C5Wj6ap0YEZVzG4Qa/b7SsRsbD
         KGTA==
X-Forwarded-Encrypted: i=1; AJvYcCV3/WTN3CkXnMCGyIHopaICbsqc9+10wh41zCRwWPVOUAcXjZJZ7Dw+j7kgNYsDs0fR22TOuHEzHa+LGkk=@vger.kernel.org, AJvYcCXTBZFIfk5ZJ5LImvCxL61CK/eSzEztAKmuQ+PP2yzsInRzcghmqaeYwNhHIaOOyV//1KXKS8F6B/j/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jUPnT7FMceCjU8P7zlVt6/XPyKi8+26Bc9VceUdJjwfL/1aB
	Y24l/do5OjMCI67Xy2KPIdKYafLjZtAJ7jtR2yKJPH3HJPggmHarSfNA
X-Gm-Gg: ASbGncvrgTii8T88SbfOZEZWejzApzAW4H2hRTW7c5gcOk7UnnScXVtJFbchXldF76p
	pvbW7b0AV15bod8zdvZBvHRKIc9SCoEqkKK6XnVekdX7AzDGefIKhIg6vcaEIuQQvStETclySFh
	COcdGwBZMaU6azHDzPRdMlmPjaU2zvr4IE3fwXm5xDWStbEj1eq34rk2CVxa+/XNqzPX+wBzRML
	WxduFhT254jS0BhaYFMhkr8Q3WwsQ7I+j5IcmVI5mGGIp1pcdhMoiCOcpkhI7t380uXmb98aJcm
	WgFq5XyXdcrS8x7fQEv5FCMQlGpU9hn1CXeCpPeilf7f7v7tJ5rLISuxjvCRZgI4uXC6S91DfqF
	fd6qPacQJnBQihHDiMxVtZwpvdbq7Ensv
X-Google-Smtp-Source: AGHT+IGUevVLHan5orWrgLADbjdtRVczCV+BXnOnV7mGOJM0RgU9y3dnreihOC4mZzOpWQO+v6QpgQ==
X-Received: by 2002:a17:902:d485:b0:240:9ff:d546 with SMTP id d9443c01a7336-2494488a080mr114983035ad.6.1756765155468;
        Mon, 01 Sep 2025 15:19:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24b15780a11sm712655ad.93.2025.09.01.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 15:19:15 -0700 (PDT)
Date: Tue, 2 Sep 2025 06:19:09 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Wei Fang <wei.fang@nxp.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <jrowmm4uh62bzxqtuc3bdtjkjxpwsu4zid5khxannuzw7vflum@6i4qzw473ozy>
References: <20250827230943.17829-1-inochiama@gmail.com>
 <CADYN=9K7317Pte=dp7Q7HOhfLMMDAfRGcmaWCfvOtCLZ00uC+g@mail.gmail.com>
 <07dea655-faac-4033-852c-91674c5f09e8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dea655-faac-4033-852c-91674c5f09e8@nvidia.com>

On Mon, Sep 01, 2025 at 03:56:04PM +0100, Jon Hunter wrote:
> 
> On 01/09/2025 14:30, Anders Roxell wrote:
> > On Thu, 28 Aug 2025 at 01:10, Inochi Amaoto <inochiama@gmail.com> wrote:
> > > 
> > > For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> > > the newly added callback irq_startup() and irq_shutdown() for
> > > pci_msi[x]_template will not unmask/mask the interrupt when startup/
> > > shutdown the interrupt. This will prevent the interrupt from being
> > > enabled/disabled normally.
> > > 
> > > Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> > > cond_[startup|shutdown]_parent(). So the interrupt can be normally
> > > unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> > > 
> > > Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
> > > Reported-by: Wei Fang <wei.fang@nxp.com>
> > > Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Any updates on this?  It pretty much breaks testing on linux-next for ARM.
> 
> Also does it make sense to squash this fix with the original patch? It
> caused boot failures on at least 3 of our boards and so could impact the
> ability to bisect other issues.
> 

As Thomas has taken the original series, I think it is hard to do a squash.
I will ping Thomas to see if he can take it.

Regards,
Inochi

