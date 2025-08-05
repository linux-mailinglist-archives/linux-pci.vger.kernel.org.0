Return-Path: <linux-pci+bounces-33432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14019B1B74C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4D23BAAB6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22CC27A10F;
	Tue,  5 Aug 2025 15:18:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4F279DC4;
	Tue,  5 Aug 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407139; cv=none; b=pm2N0ebH6/e94cf+ggj7aUJ/eSAbn/+S9LJS1SWCjPVoqJY2W5gYdOaMHySGw/MI0Td6abyrv3kDhRLlWS2YY6Q+LkB7+iRnpicFTLjBkwmRKfL89K9RJCLOzhl67c0jvv29won4PW+oBn9OUeYyuJKuhoeAAq3eXabjLKVyj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407139; c=relaxed/simple;
	bh=LR4ru3XD0+uuqxt+Jt1dRQVmlvl0v5+6x3n4ogolIhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onkgx9YKn6GBdG5YU/2guGK8GLfDJ0GAwkNa3NG61S7jUGPZkoYUggIka04rcGP28HuoQA7eTHsJr9Ck8ek/NyY+J7vX4BxdgvbNjQTIvqAELRIfHMJg8s7Em0Pif3loOZMpmmMHn3c2qSOQmC12Oe4qaB9iE9/f0dWXaObQNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10204825a12.2;
        Tue, 05 Aug 2025 08:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407136; x=1755011936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDMZUncdM1vNssKe3HR2+qx8a1juDqWyeBUF/Ix7mr4=;
        b=D+zO47/vAFft2d4fZeUtVLcyQxI+nPmK90hwoPwLWIHJCJOj88jviylyBAnJ3TYylQ
         bUA+uJsl7TcWkJ17da3TrVvR+1KKEpJdoGHM4PG7yDoS1JQMcmmoM9P5dhnNPG61MJNK
         baUREgImYCdhfMqkQK6+FGwMt6xclw8xJhxmtMCcf5zTVoUWQIdZPJNHohSh+Iz8a7XM
         fcbQbXUw7ZkncPVgYdAQmm+UMthp3UyXPD1fa6rVmHBrMC6wjHIwH0q1EEZ7PGQqlSkR
         p3SyPDGGsYg1ZItKZXAP4kYzDZCPbMWTbz+T6PTj7VBkfvs8EN9GviWytbMqj9VcIohs
         wcvw==
X-Forwarded-Encrypted: i=1; AJvYcCXY/3MAJDrwCL+dnNPQPgfna4A5+2ejPagDda4PfpngMUr/MGdPxU2rwLWJ+pbfkZERNbw4AKgKnJ8d@vger.kernel.org, AJvYcCXjf5z67drgXKERYfEyPG4IPdXLmscCKIYPydtc8FVuBWovba5qWGJj/yeGmR3ONuZQ2GKBAs+tcR+M4cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qdEr2+6Gm0imli23jKjOJ9kV/3kZI7XWVUnI753wFMyEScxN
	+BlabB8uuS7Xb2iW55oFqUM+zk0mCyULzCoa9Hl/+UQ5a7NJXg5MEP0vqmeSmw==
X-Gm-Gg: ASbGncthou1xSAnPYL531Blc/4Qf4tDeT1W9ElqueYVbXug5pXcTbUSwHRZJ982jdba
	yudaQSvR/0L6zgEFJUVCr8JEKbCIhDpHYyLl9A+DFkvkGkccDIablLZIWnH8F1uUtp8bHEfWd5d
	U5KFHLTiGsqDGEScDpJCHWW8RRIFti+VRcQ+L/AQKhdkudML7e0oIulp9hv5GbrvmKS18QTmRi4
	IkYCcs+/9LxWmV/q5oWwVD+CL/MfjuT+7yoxP7kYIedB13WjzDnNxAuDARshbJS74pbH0RTWZM8
	o4hWzcBC4NLKsAn2lAdMM8HXALjuwJuUW00OnwFyYbiHL4eNAz8BVxwmyuMprIrqjtz0x19myJy
	jy3wJB5e5XCjREg==
X-Google-Smtp-Source: AGHT+IEPMyV1onhl1ZeZO+a2aYTU/KXXp0AZflq53hn6fSnWDxi2Vx58KPSDa3Gug99gwikwpUkEew==
X-Received: by 2002:a05:6402:3593:b0:60e:404:a931 with SMTP id 4fb4d7f45d1cf-615e6f015fcmr12388042a12.15.1754407136247;
        Tue, 05 Aug 2025 08:18:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2d554sm8474940a12.27.2025.08.05.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:18:55 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:18:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
Message-ID: <kvh4pn3bemmrrxeeaydclvhsr6tnudc3hayr6up6oeuzfwzijx@f5corx6x3h6s>
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <1e332191-e1b0-49e9-afa9-09e76779f72f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e332191-e1b0-49e9-afa9-09e76779f72f@gmail.com>

On Tue, Aug 05, 2025 at 10:25:11PM +0800, Ethan Zhao wrote:
> 
> Seems you are using arm64 platform default config item
> arch/arm64/configs/defconfig:CONFIG_ACPI_APEI_PCIEAER=y
> So the issue wouldn't be triggered on X86_64 with default config.

Not really, I am running on x86 hosts. There are the AER part of my
.config.

	# cat .config | grep AER
	CONFIG_ACPI_APEI_PCIEAER=y
	CONFIG_PCIEAER=y
	# CONFIG_PCIEAER_INJECT is not set
	CONFIG_PCIEAER_CXL=y

