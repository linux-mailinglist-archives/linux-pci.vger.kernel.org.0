Return-Path: <linux-pci+bounces-24727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B6A710C6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C86174081
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB318CBFC;
	Wed, 26 Mar 2025 06:54:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7834A29;
	Wed, 26 Mar 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972092; cv=none; b=U2kKkiVjNHhrpSk9yREk2/thIDZ3UcpI7ED0Aps/rJ90Z08wDbjau2q/YaSzIiCZWwyzYTeiyfmpoShHEEwwVw+01KE1G8btISNW5GYircuEVkE+WfOQaqnB8P/pQzf0FLL1+HRa+oLSv0qcoaGHp3Ot+2nb1rqNoNGZCCT9fH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972092; c=relaxed/simple;
	bh=VjofAGvmROzV0yThEO+wRTmQS9z4hiCq3OXJpkxvNlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNuErk6lB/vY6jDFXXu8v2EGYC+ZhIgmTc6Vh6/QQYDAh78S9SILWdb99oV8UotiH8pibPbTWuWKASSQjGN3f3tDhir+o09Zo6O38EQ3vEbeki4myqIJbkRJOtpwDAulF/N42z1+7iDU6aNC19/ihmsGmbllFkv6YqPCQUnD338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22622ddcc35so11187935ad.2;
        Tue, 25 Mar 2025 23:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972090; x=1743576890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5r6oCeJ4EMAeiLeoG532L2JW9nTuYagBmQstVPI3p0=;
        b=vvUU3sFJVbY6SM6u00cxkgOYx/GErMAYuFxkxuk4EEnkeXSACleKwedsSgzmHG/18n
         7zti8AXCxXLCQETtC8DERC9PoyBnaYv8xv9IGK/46N7uM/5XI+OU8OGK2BDK1LJI0F7p
         06+MzQMGYI+tDDvFRn/rnDWPUDAojD/hTT8lrfYqhnLuxCizFmOeS1RrC4ONv6To+xCY
         YD0lh9PKi/volghgMkybVBg7CbUjGySP3aRctoz0bFiWoR4T9aPxkou/jefxkbNQxDki
         KpDm0aRbACyLfMbvz5Gh0rio4Za2JrmH/Q5IJ60CfHhZHYmFFas8eUN1CxWrB+3sY7uQ
         DR6g==
X-Forwarded-Encrypted: i=1; AJvYcCUse5sPrxeBvgCx7Tj+ZOBJlgXDbhqxXYw3gEkoQg7P6VnWOfLSgVbxUeFM8N3MkuW9NppVofwmc+oz1ho=@vger.kernel.org, AJvYcCUzX0RHvKnS250Jb7i94WFt0nIyB5MOfRlmeO0B5V8uwZO6s98snyNR8xLqGFbwoXDTMmhHyTTlwpIT@vger.kernel.org, AJvYcCVbl4/648Mqc5stW4uFJkm8+8z3rltZ3R55OvB5rhgr7c356dKnOrh0aL2SKnbqJwlE8wwIEXcY@vger.kernel.org, AJvYcCWjs9ULm9fKjjHSnUbZGGVqYdU5ijz6+HtfK8n+BHL/QM1TPj8hL3AuYhDrhVq8H6uxIQKuNRhNOl1RXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6iC1apOBaNdpctc3/OcBvajfNvLX70WZp0wB8YTWdT7hurco
	MwOyL5M4H3fosqu3MtGYL8iW+maDE1s8If/gchxqGosK9W/Rf3TxO+xvHg/x
X-Gm-Gg: ASbGncu/G6+OGCZys5OEkmqn5uK8DpSoSC+GO9BGNMsdXR8ls98FoGzk9FMPNUObKXz
	UD6BJ4KEA9cOiNxSEacmgkxj3L1b/TLyOULqh60vM8E9oyyP0KyCxy6zfV+dPnQ4Je74k74Rx++
	0lOE2gjYbd8gPRSJfMbowjsa1rDYBQpmybDqY+TbBxeJgY6owWfXFrGeA4vC9y0yHAtQxwLpUIM
	+5HoHc4od/D7V5F7NhdRH5qNdNFnQgicXE5KSiwHKCnfqmriUrdTJBU1QywQnOQu/1iC7+Jpd8Q
	uhBS9Q4nuo++GRsXnIjiYWmMFNYMgP6GB1GiuL3flIRuDs2OnJ4AavK40wvjpv0agaTJXccell9
	n7NM=
X-Google-Smtp-Source: AGHT+IE6BS0dWx+A4CO2d0RKHQRRpGuVDJdQisEl5b1NHCFZIRGeaNjz7ChH04Mj+QdFzRg0J2Qpzw==
X-Received: by 2002:a05:6a00:e13:b0:736:fff2:99b with SMTP id d2e1a72fcca58-73905a530b6mr30978159b3a.23.1742972090093;
        Tue, 25 Mar 2025 23:54:50 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390611d573sm11744324b3a.100.2025.03.25.23.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 23:54:49 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:54:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
	vigneshr@ti.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250326065447.GC2822343@rocinante>
References: <20250313055519.j3bpvsm6govd5ytk@uda0492258>
 <20250313160215.GA736346@bhelgaas>
 <20250314041705.v5j2fjulol5ywvyq@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314041705.v5j2fjulol5ywvyq@uda0492258>

Hello,

[...]
> > So I guess without this patch, we incorrectly ignore link-down
> > interrupts on J784S4.  It's good to have a one-sentence motivation
> > like that somewhere in the commit log that we can pull out and include
> > in the merge commit log and the pull request.
> 
> Yes, we can prepend the following to the existing commit message:
> "Link down interrupts on J784S4 SoC are missed because..."
> 
> resulting in the following updated paragraph in the commit message:
> Link down interrupts on J784S4 SoC are missed because commit under Fixes
> assigned the value of 'linkdown_irq_regfield' for the....

How does this look like?

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=b97b5b8cb603a4ba6b3f7f1b6065fa76e69bdb56

Let me know if you want any changes.

Thank you!

	Krzysztof

