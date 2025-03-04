Return-Path: <linux-pci+bounces-22874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0124A4E754
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C817F428
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE3251788;
	Tue,  4 Mar 2025 16:31:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BF20ADEC
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105870; cv=none; b=Wfq8qMPZp1hky7MXzxp8AuAIV1yVIm/Rw6d4N266LcDKTqHyKxMpMkfqX3dqYsyqehXQRJD2mhSsHYV6FImGfBmn2Z4dQEUxgHge8VurAMLNONfHx8Ds1U3wC//ApQ+uigaXkghfumZmcZG8V760+E9XcBvi1XDElsii/+IYXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105870; c=relaxed/simple;
	bh=YcAdt1NHj7o560j8EqlYKZ7frHQO0F0eZEd1mTK/2dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIJP3CKkailSO01FSeOtSu96SWziTGDSfRI8/PEvlezUcagCMSeBcnaQqRVXmlZAtHRXIFdG2XC1jJP6FyDWvigqPzB7lPICxI3xY//Odytd9ooZ6IRWVnjztr4CtQZgmyi0QaVuUuhcQmS+gvPZykrl1v2JdTkMbGvk8qjPWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22374f56453so105448115ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 08:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105868; x=1741710668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuFJDstYebzEq1bKhmnjrbSv5V6zLbd65aWTNbpS2Ec=;
        b=PAOugvTqvNjMYO+4QsuQZ+UMW+IrtOHErwzhrLoD5m8b1jzWPzdeOW1KwpXyppcOHa
         YQLw5LSR3fVjPc+qCUBIs87FjXRlFefuMD9hFVIf0Zl+uJ06yB/q1mhSXPt2qn2vGe9M
         VXJLscIz3zeFGCcJyPECnZ/e5ELDexmovqdFZM0xdKbUJDFY38y2xRMllns/bQymqnJq
         MK7v+FgF3+j85/0GoVe0Asm2ni0sZRBCVdcNHQCoyK9tlDbOao8d0uu7hotTxe29hQH9
         Ln+GcMdNxydHJIUARq7q6gl+REHAP6/lq8tqrXwN/5yx3qiLVp5lTmbeON2vEzGzQ3eb
         gcGQ==
X-Gm-Message-State: AOJu0YwO+6daE4FAnm1K5u8iz33MnA3LzjHLj//dAmH+lqxSHM5vOCRj
	iJTwiEjN/IfdnVgwhYgQOB6lKl5D3MxJ1xMZEJk9GGRacLO3hWc+xzA9G6G0iXM=
X-Gm-Gg: ASbGncubNqAgcBkyw2hjVl1L0r92rDrkHZZVo7lFrrDXu4ATv9CLgf50INP6esOl+Jl
	z4Gct9pG5bf1aLr4nHDy58TDarfrecMb5IdFnv1Op1uh0sLFORib+0RNSdmkGfWfih3Znnmjaay
	dApkIEzDRuCl+wxYJPFnmqgbvxs5DauvI38tfkzSUZU7AJYv0ZWJJYSa0IwXPWo1HO6CEF2pTJ4
	We8hd5508WR7lx4CV4eHBURQI0j+m8vAxTgEQzEZhsc46d6G+RwzN04xcqtr5PInxiSMu8aJsnp
	YFmY3xccRYYO6j3qm+kJhmbDmUM+ANUmDvjNmt9vm97AT5LZooGmwxX1eT/nm/ZJAxw7w4GNgBg
	YZtQ=
X-Google-Smtp-Source: AGHT+IHPgtyskoDGdiFUwnYDDPBI7UW2GX7VrXZ7GgaGfCD0gNPig+PjBzNGAbOy/iHOpOQBQUmWLg==
X-Received: by 2002:aa7:9e04:0:b0:736:34ff:bf1 with SMTP id d2e1a72fcca58-73634ff0cc2mr13360776b3a.1.1741105867990;
        Tue, 04 Mar 2025 08:31:07 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7363f62117asm6106329b3a.57.2025.03.04.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:31:07 -0800 (PST)
Date: Wed, 5 Mar 2025 01:31:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
Message-ID: <20250304163105.GD2310180@rocinante>
References: <20250304085722.GC2615015@rocinante>
 <20250304162014.GA227956@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304162014.GA227956@bhelgaas>

Hello,

[...]
> > > Fix typos and whitespace errors.
> > 
> > Oh nice!  Thank you for doing this!
> > 
> > While we are at this...  I wonder if we could also see about some things
> > that I often see in the code, too.  For example:
> > 
> >   - "pci" or "pcie" instead of "PCI" and "PCIe"
> >   - "PCIE", PCI-E" or "PCI-Express" over "PCIe" and "PCI Express", etc.
> >   - "aer" over "AER"
> >   - "translateable" over "translatable"
> >   - "SPCIFIC" over "SPECIFIC"
> >   - "OVERIDE" over "OVERRIDE"
> >   - "Root port" or "Root complex" over "Root Port", etc.
> >   - "dbi" over "DBI"
> >   - "requestor" vs "requester"
> >   - "fom" over "from"
> >   - "reserv" over "reserved"
> > 
> > Would be nice to get these also fixed up nicely since we are already
> > cleaning things up.
> 
> Locally fixed these:
> 
>   translateable -> translatable
>   SPCIFIC -> SPECIFIC
>   OVERIDE -> OVERRIDE
>   fom -> from

Thank you!

There are also some potentially awkward and/or not correctly formatted
comments in few places, per:

  drivers/pci/xen-pcifront.c
  641:	/*in case of we lost an aer request in four lines time_window*/
  642-	smp_mb__before_atomic();
  --
  702:	/*Flag for registering PV AER handler*/
  703-	set_bit(_XEN_PCIB_AERHANDLER, (void *)&pdev->sh_info->flags);
  
  drivers/pci/quirks.c
  3388:#endif /*CONFIG_MMC_RICOH_MMC*/
  3389-
  
  drivers/pci/hotplug/cpqphp_ctrl.c
  279:					/*FIXME
  280-					panic(msg_power_fault); */
  
  drivers/pci/hotplug/ibmphp_pci.c
  467:				/*_______________This is for debugging purposes only______________________________*/
  468-				debug("b4 writing, start address is %x\n", func->pfmem[count]->start);
  --
  471:				/*_________________________________________________________________________________*/
  472-
  --
  1053:	int howmany = 0;	/*this is to see if there are any devices behind the bridge */
  1054-
  
  drivers/pci/hotplug/cpqphp_core.c
  622:		/*FIXME: these capabilities aren't used but if they are
  623-		 *	 they need to be correctly implemented

This is something that always stands out to me when I am looking at this
code.  Not sure if we want to adjust these at some point or not.  Perhaps
now would also be a good time.

Thank you again!

	Krzysztof

