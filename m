Return-Path: <linux-pci+bounces-22871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6424A4E7BB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B0E8C2CDB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CAA25F976;
	Tue,  4 Mar 2025 16:10:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C1255223;
	Tue,  4 Mar 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104611; cv=none; b=aUFhVZ6y48Cc7mV0AjP/nZ+Rd8+pFtV+gQgrGNkgzUHl18nvmeTEn61uivKLoE+cQt+IG35mo2eMH1CDkT2Vt+3Jy7wFGjWWG90CfVQrbQ9TppNC/AKEA8Zg4ddh+jhaGX79dboDRApmGn3EDqEV3rvhE4rADeYMqGxDzhqN6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104611; c=relaxed/simple;
	bh=sIJl2otL4QOgSWadn2LBrZMBZejA5F90omrjYZpwNrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN/3s2CO4AtbB+WSvX+B8idzi47vYd9bMKwBta68AqGMgqAapg90ofAnB3pnsTYOyCNtD8wKrsBKLIvXZBJDC/zfkfwmUPimn1XGB7pg/taHcfbNB35OZPFD8se8+EtVgdj8o2ctRs/sEik+IwGSiyxywuRrlXKjQzs+AMy+A6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223a3c035c9so39801715ad.1;
        Tue, 04 Mar 2025 08:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104609; x=1741709409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoMZ/LXD0n6wHUQnbeanWfL4wspkznf22EfqsCZFOOo=;
        b=b2VlvRj+j+RPL6n/Hp8D4Ri6wYRLyu3IiNoWPcqHcVtniVeKZyLDc6ycpB6kIscPsn
         aNQdHgPzP94VpTx/QJrGGnA7pPUky39is8h75zofBNTNqndrk4yUb1773Fkfh7rrGkmL
         0QRvyNQBfYcmptAQcDwZrYejw2wZQYE2uikfqj52DAab3FIDZhyixL3Nee2AYNq86gLE
         NsGLw28CyHN74HJBdrnmxroZ7RYVu8LFgZrd+6XzrwEjpVQ2DRRZNh+tUJTTh9hS+MYc
         h05CJPDNsF7GyxD9xOnDJ6YZF2FxeI70Zo/J02a8sKqWgaZtVc+2HNcR0OwKjf50if4J
         cc2w==
X-Forwarded-Encrypted: i=1; AJvYcCXZfmPRLL9PFjEPQnirIWDcsft7u8BDhx7sGUJFlk22ScAaOeW7Sov6RfDBcu6J2zwC1GUk+5nY4RlJPVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmY8FfFc0MUrpKOFqG4KBnUgMA9UK5FLmjJ+AZUbSTXtnBFw6g
	uLdSgJtuOb6eatzqcKneJTALclyaVUgq+nRZ9UsuAPBN8Q1F26at
X-Gm-Gg: ASbGncvcqSyhzEH/rrmoyZdx4KAjTShwSnsrY5dvW6vKgpiRiymrRX/VNiN0CyIL7zN
	EpJnNZFdk2uhlYNQWJ+idcmSweeoM6ylKLLPl0rhUo8pWBj6UlulG68esYxcYGLqbxs6pyx+GFp
	naVH25AupnS02npC7DtGl/XcwLZfz1W4ooUgC0f90HzokFrpLNTmsaaN5XCEmDu22qnakuJowyL
	g6t2k+zCjfpSenq1uQ4m8RkuGcp5xjjENbUS/6OD1bVqsJc3HwyRmC5TpRkvlTbTgTWELt9fEY6
	PT/+IKhLDHOHN8vZaI/TKgc+uMYzDRuhw/eYjLxciWcnVNtrPNhW/i8LFZ9/pJteMY6khqRbPLo
	/USQ=
X-Google-Smtp-Source: AGHT+IEg9fODno7y7kdKi9IiU5DrBqwcBYe3/nmHU0aecwM9g2wT01bptCub2WDnULreykf0DHrF6w==
X-Received: by 2002:a17:902:8303:b0:215:758c:52e8 with SMTP id d9443c01a7336-223d9154390mr46974825ad.12.1741104608622;
        Tue, 04 Mar 2025 08:10:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350514239sm97095005ad.219.2025.03.04.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:10:08 -0800 (PST)
Date: Wed, 5 Mar 2025 01:10:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/8] PCI: brcmstb: Misc small tweaks and fixes
Message-ID: <20250304161006.GC2310180@rocinante>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250301144831.GA846783@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301144831.GA846783@rocinante>

Hello,

> >   Six small fixes and improvements for the driver.  This may be applied
> >   before or after Stan's V5 [1] on pci-next (they should not conflict).
> 
> Applied to controller/brcmstb, thank you!

Updated with missing "Reviewed-by" tags that Mani recently offered.

Thank you!

	Krzysztof

