Return-Path: <linux-pci+bounces-17891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285119E8508
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B9428155E
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B31474B8;
	Sun,  8 Dec 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xduNRb/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10634146D55
	for <linux-pci@vger.kernel.org>; Sun,  8 Dec 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661734; cv=none; b=V7768rsBME0G07VmUnU5uRSUoVPsSJHbS5E4x0cuVrj1mZxNtBRKs8VplhivpWbCoQnqO8ygK8+m9FqSUWz7Q+AxTC2KzQ4/yg2ecuzUlJI49I9Fs9ksaa4T2xjH+xemBcb6WuB6m7MpbnvizCWDS5SWA0McwNfk59IJzpxY4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661734; c=relaxed/simple;
	bh=Gfu8nGtihnEAkkq483UCUnm9YBXFm+dsU4L7IJ34Lwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miMVMKU98UzV/Q8jBgeIvLHmNGYAJLDG5gkygIOsBEYW/aUz67i/DLqWgmuKxoza5uyM8+lz1eyYpw6No8mCGqX9/ZAPeTSgCXdAOvY1YNxxPuvypwuqFMQRI8VCtsB0XfKT/B6ApcgHOrH61MRzIUs26YTmbjufXD2Xp7YVO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xduNRb/m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so26579695ad.2
        for <linux-pci@vger.kernel.org>; Sun, 08 Dec 2024 04:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733661732; x=1734266532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFVhzMU+SUgNQeWkzZgfL+AdQugIW0qrMZIwYWmqJtY=;
        b=xduNRb/mnfhBIsLkWm2ac40uSRnpg1uwr7WIk2adHmV1IKHbF5pxG93bmjWimaumqH
         UdSYFJiv8BPyVZeFfGljPrv1yGgCN+NyHxgRhpTJLaZrf99Qfc5tDlC0eNje74NwCGCL
         OGdG93lwBCYH+GQ0T2BrTIMrmWAg2bTbOI7t5j07Hj48tEK8Ny0/D/k3eTj/2E/omjvc
         pR2pTzzvCQZcWiDOu0UNUaQ5Zn8MG5fb9neAP0p32o92RLn2LK/Jg5trMttoJomtEF+A
         uABlhK2EWyj7tjIgIyYjYewbLlI4Rvyv5jeAFT1JBsEJV7Gor/5fTcgFPfCIrhvf8Dlz
         2cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733661732; x=1734266532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFVhzMU+SUgNQeWkzZgfL+AdQugIW0qrMZIwYWmqJtY=;
        b=UKDfGnXaTyq+ZZS2Bpq4BFyIzb75W3el3WfbgwS42AfXYhX3PKqGcZK2YQH68qUooQ
         xz0NTCLyayj/FariZ0WPmw7Cx/dZRFUSTkTGCKrS48Z6kSKdkXO8Md0Lq3UQquL7rLaX
         3Lrow0QyJIm+vZJqHlsek9yUiqb7h3yBJUkmwA/XFag35vxSPFxyLFOHhlBMmWqwGhAz
         JoI4/nD7NLNBGxxWKXeKDXFcxJ6j0OeFa3YkbujpUs/UjQ2KjPCeznt34yMkKREMSZCR
         u42F1+rVrPHF2Jb+L40bsXJUcKqgANa/ow0SrrT8tlqZJA37KBH6FvXdvXIxDgIdN7+c
         MqAw==
X-Forwarded-Encrypted: i=1; AJvYcCXO1gfTbr412s53NppU6J2keyx234iZnYJCJV2Zu/DGvpoRtXxq7QShQJMqD558koUa1T4W8FPaa2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8ayfVwlQzV48ciqn7JQu6K5qUkQ8bWlhWk112At+SbzSfADG
	zjiXFcPuZlwuL0uCQkXlBdchzheI7SLk3HW7nrfYGiB9bm+GmTUzg/Pofv9jCA==
X-Gm-Gg: ASbGncu2z5+QJZBDJD0l/YO7DyyYTg50sO16arV/6W3fKR8WRiYxMechbk0sYGJDm33
	EqMD1anYcEdzgCFaMXYe4afXIPN332HF8ThsYbbSRLGT0NKsTg6msrtPBeAeM5ufvdMz38M/dCc
	10VT91LTKJjfyy7LwRgtQvOC4lSCob4EQef2w9fmnNP4+WODDh7OenSrGZmbrpD8LJ7rvNErOYP
	VrLkTlTaqpue4eHGCib6atFqyWw99/T2jy4FfbGi+LTrui6qhIIVXcMKLo=
X-Google-Smtp-Source: AGHT+IHF+lnTRz9IHyAZeNJFMOo33dU1zB/UfTNx9cmcEx4wR035g0DE36+FdiB0aQ7YF8XleldZAQ==
X-Received: by 2002:a17:903:41c5:b0:216:2abc:194f with SMTP id d9443c01a7336-2162abc22bbmr78787245ad.40.1733661732308;
        Sun, 08 Dec 2024 04:42:12 -0800 (PST)
Received: from thinkpad ([36.255.19.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163724c42bsm14610905ad.174.2024.12.08.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:42:11 -0800 (PST)
Date: Sun, 8 Dec 2024 18:12:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <20241208124208.wopm6jprp4cjs4ob@thinkpad>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-5-cassel@kernel.org>
 <20241130081245.2gjrw26d5cbbsde5@thinkpad>
 <Z06MXj2K4dcWMZff@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z06MXj2K4dcWMZff@x1-carbon>

On Tue, Dec 03, 2024 at 05:43:10AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Sat, Nov 30, 2024 at 01:42:45PM +0530, Manivannan Sadhasivam wrote:
> > >  
> > >  struct pci_epf_test {
> > > @@ -74,6 +76,7 @@ struct pci_epf_test_reg {
> > >  	u32	irq_type;
> > >  	u32	irq_number;
> > >  	u32	flags;
> > > +	u32	caps;
> > 
> > Can we rename the 'magic' register? It is not used since the beginning and I
> > don't know if we will ever have a usecase for it.
> 
> It is actually used!
> 
> When doing PCITEST_BAR (pci_endpoint_test_bar()),
> and barno == test->test_reg_bar, we are only filling the first 4 bytes,
> rather than filling the whole BAR:
> https://github.com/torvalds/linux/blob/v6.13-rc1/drivers/misc/pci_endpoint_test.c#L293-L294
> 
> These first 4 bytes are stored in the magic register.
> 

heh, not so evident... thanks anyway.

> I do agree that the magic register name is slightly misleading, but that
> seems completely unrelated to this patch.
> 
> If you can come up with a better name, send a patch and you shall have
> my Reviewed-by tag :)
> 

How about 'scratchpad'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

