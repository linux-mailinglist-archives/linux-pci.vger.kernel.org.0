Return-Path: <linux-pci+bounces-15888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67B9BA7FF
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C8C1C20C4F
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D418B478;
	Sun,  3 Nov 2024 20:40:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD413CA81;
	Sun,  3 Nov 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666406; cv=none; b=iLPnPr6P9rWx1eehBiigMHoGyIIVSk3dggIsNJtIlK7Pn5qDhiZVaTdc3s1ykS0sukfv9dhRFYXLTTpn42nsbiwhl+kN4p1jc33qJwZAcIavCrqgRfB2v7Am2VQfiFeizSf29gdxE03sK+93ddlojbc/UF0MqABy7qZx5ldL35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666406; c=relaxed/simple;
	bh=GSarkLPmvDaBMltvi5Mhfo6hZhmOmxfUo6vNa4mMo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9Huc/y3bdYMXA4JRRUsKWFRKrfPtYILeGottTTjURV9JC5BXBpdcCH1lXqCOmaEvgyByUzw+uMkrYWaiAezeIpfJJtVboHy37e66IiWaVohTY4vWvyGo5Kd7I86ivgv7nUfb8CrkrfLSlo4w7QXdT2NSbw0TEv0C/BrRXxPuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so2582109b3a.1;
        Sun, 03 Nov 2024 12:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666404; x=1731271204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFXU6wo9Kd7zGBArigdoomzEjsk9nF09DhLxwhjB1Ww=;
        b=AmdBnwr9wIbhrGqrlhcUkeUES0aCuxnx0J1wZAAAP7CNiv2m8t+kVkUwQu9Pb4ZbS2
         nRxtzfil2ojItzS5eN7eI4r4kSkCuLp+WG2bq2ahsG+p7zE9DffQf/2hLjmyXXwqCI0E
         Ed7Ri0i00rarKpAG0v1keYf3R0ma/JopfPpwGTiPKJ2Yk8oLTwrgbbpwDPxtg1kDfIFq
         Yq4uxHi0S/Z1s+Hu9aeoXWO4hQvjF2LklAAgnzO3b1zOJ9ayyChqZNMxEcP7/fzcKWxR
         wwVQb7/oIqzS13PlJhvNTbFKtikg76A9WdSJlNKgvCkqMd9gBmWtqaXpGMGCXRYfzG0k
         oUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ+ORnJ8xLUobjgBy3sN9573aH3eM+v2iad/vNWA+Fksvgtt8BgDSL85RzvxPHsPVpyhojkNrbZKD0LU=@vger.kernel.org, AJvYcCWgyG10pjbvY++skV1r9HHIjcs3sHUDEMaDiJCBZ8NFTzMoyten07Xq1DaoUQ8s4DLozUHrnZkGDHyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhgj5CYgCPkZDtMm4u3C32Bf9BRByuPtRSbMQP34uaKWl68Tel
	sbVd5dgfU6qLZR5+MMgGaBhEB5GjZ9mqIOkm5+bUulEBOCmJUBFg
X-Google-Smtp-Source: AGHT+IGpLILXncZsOHNshkTXbKIftpldXVh89X9bH6aP6ZYQ7s1fzNCSCLTl/BKJFBvINnXCY33zxw==
X-Received: by 2002:a05:6a00:2e2a:b0:71e:755c:6dad with SMTP id d2e1a72fcca58-720ab39e7c4mr22967832b3a.5.1730666404150;
        Sun, 03 Nov 2024 12:40:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc315ac5sm5961164b3a.200.2024.11.03.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:40:03 -0800 (PST)
Date: Mon, 4 Nov 2024 05:40:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v12 1/3] PCI: vmd: Set PCI devices to D0 before enable
 PCI PM's L1 substates
Message-ID: <20241103204001.GD237624@rocinante>
References: <20241001083438.10070-2-jhp@endlessos.org>
 <20241001083438.10070-4-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001083438.10070-4-jhp@endlessos.org>

Hello,

> The remapped PCIe Root Port and the child device have PCI PM L1 substates
> capability, but they are disabled originally.
> 
> Here is a failed example on ASUS B1400CEAE:
> 
> Capabilities: [900 v1] L1 PM Substates
> 	L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> 		  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> 	L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> 		   T_CommonMode=0us LTR1.2_Threshold=101376ns
> 	L1SubCtl2: T_PwrOn=50us
> 
> Power on all of the VMD remapped PCI devices to D0 before enable PCI-PM L1
> PM Substates by following "PCIe r6.0, sec 5.5.4".

Applied to controller/vmd, thank you!

[01/01] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
        https://git.kernel.org/pci/pci/c/c8d39213cb70

	Krzysztof

