Return-Path: <linux-pci+bounces-23438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7DA5C688
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7501888A96
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C825DD08;
	Tue, 11 Mar 2025 15:21:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F625BAAA;
	Tue, 11 Mar 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706498; cv=none; b=eJtqTau4uJ+dn/QD2DdOG0t8T1qCCIUrMcdhn/XDerq++58rVMOrBpCFhIXp3yChgGViz/rXsBF9jBCFOYxfvZT6+XOYcTpmdK/CM9elgegk2nWrTpAJebIN9qHG06hS7+dgvtfU7sOpTdyiEpPMPH8Hv8X5X0oK5v7g5UdFwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706498; c=relaxed/simple;
	bh=T319i0iTkEbGjZEaEiOULwpphTae3Q9TA08ZpzK+V6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZmHslFjkpLflqiJj6uCRP8z+oELNVFEamwc5YrGyEdf+GSY+wyMKaO+TFtBj2/6wet/ZnvCF8WIvo90IQRkMDUqAANtFGNQ77sBmbKdiY8Q+l98k05yu/WyK9JbSbTG2Cgsn7QOPsMNOfhkp/AuDfT8lQn+6CyY1f+o9yDiwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223f4c06e9fso94153335ad.1;
        Tue, 11 Mar 2025 08:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706495; x=1742311295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E1C9TLEjucQveUr2gSBnFJRTsayVaSmXuzEE+51s00=;
        b=t7r03qOAv719Vkh7diY7P11S5mGMLvFPqU//46f/t9sN45skxQpXQfEJSekhcq/cef
         0BZ4Y2Y73tC8oNmeFjqjiw8cj8uM23mHuQaSA9LZBykG7UnlJre4Qkrz+r78ERybQd6S
         f9SeXdSe1cf+vQfDBEfG1KC4XeDO6KB23TU1/MSP4rM7CH1Z3guIyeHg6JwM+OOcxQ3i
         Ea2uFSdNVTQeSvINVj3B4LCvkp6+MzIOqSFefG8PdzVo/3SqDcacfRlqGQ0IXBWdTq1p
         HLXoMrmJLZrw6NKhI82Q8ez7W9w9Z9rVB0pCqk1qHSlfZ/Qr/R5KWeL3RaKQ0KuZJvap
         Pksg==
X-Forwarded-Encrypted: i=1; AJvYcCUO0t2u2oGoyFjzuV3YkKnOw8KM8habPjeO7vS7D9eFCoyS7/xQv5ozLMDlX7gEAruJispy7VkD@vger.kernel.org, AJvYcCUaHENdZFIL+QxI/0GAG189hEPh1eamwNjaukgsJDSdsMWY+qXjMK1DF7BnvMQZiISsBaW5WhDH/41V@vger.kernel.org, AJvYcCVT0KDdbubNg6vn4X9OBJMMF0Sd3lxlSE/mnVyJJyGv8SwvVsD7Xu4x3+zMewAU7qDXsj9CesJ1gW1hyw==@vger.kernel.org, AJvYcCWDGMDlDFmSCr0aUSxU4MfyZwZsRr51UrumVAPXluUxVm5vgh9IqLfoHlpzKK2wOHoPsRKAbNlYExKKRXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGErIZahyuAFF2FPTOMBkd1tvuuPE4aBZ9AU1meHtHfQHNens6
	AtO9aPE1V4gZHS+4HV7rSYggi2yQEclvWbjpurs4qxR9RFO0X4Ye
X-Gm-Gg: ASbGncvA+zwOV1OJDMq3hn9BpBbcuGJGh/LI/qTx2rNvwpFxbDxi+o/rXXXKpp8dTg0
	AIa2Lh3sHq1O/FHawJLUpXPv0cAhqDAxDSgvdYrMyykD2jFY1zmoe7jZ0FFGfP9lXfXPr179hdo
	JdXfh1W9O7CevnOoMLuTdKsI9GRiXpXHny2XvDSm/d3rTNCAU59ToQHNIUODamxpjuDkcYEgrWO
	U3PEPrsvbVTLf4AqL/DBHU20Jlle0suBZMPe42Ps07iXXO4cx7Fh/gZXqnMDfBHSZBo1jQjiKGB
	4S0ji166iIVE8gw+uyZyGf0PJQFw0fkJuHxGMVz8Is9GeHEwu03ksob8Bivn8je/DCWHr4N7sM8
	N3i0=
X-Google-Smtp-Source: AGHT+IFGz3iPtgYgyVDkphxmllQ/7kN3j2BaMrz84yDHpAk+pc1wjYonA27kitB771cxOGozpwoJqQ==
X-Received: by 2002:a17:902:dacd:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22593df9927mr55406405ad.26.1741706494802;
        Tue, 11 Mar 2025 08:21:34 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109fda8esm99146375ad.101.2025.03.11.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:21:34 -0700 (PDT)
Date: Wed, 12 Mar 2025 00:21:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311152133.GC1381004@rocinante>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
 <20250311051806.smcu4o4dxpngimth@uda0492258>
 <20250311072546.GA277060@rocinante>
 <20250311073216.ynw7rzmu36dwywij@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311073216.ynw7rzmu36dwywij@uda0492258>

Hello,

[...]
> > No need to send a new version.
> > 
> > I will update the branch directly when I pull the patch.  Not to worry.
> 
> Thank you Krzysztof :)

Done.  Have a look at:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=01d04dcd6e80f63ca5e97324ec17c20553947e35

Let me know if there is anything else to update.

Thank you!

	Krzysztof

