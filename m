Return-Path: <linux-pci+bounces-1270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DC981BDE4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABA128C441
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63920634EC;
	Thu, 21 Dec 2023 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjQsszUc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADB63501
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d5c4cb8a4cso581414b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703181926; x=1703786726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=YjQsszUcfWYf5/iE4VJOyXzPZh3AVg74zlyJAQAo1PAoVhDWdg9J7iaPYnddysmHRC
         Kr7xXE8dP+zxMNrEGiSz0+wDByH8llOw7BwdqYJLKxBZ1o9jXBPv7daYYAEqJ0gRzh40
         6ym4vwQSlOiRsLCIXLD1xecyL9lr3luBVhjlYv408ZVAUKwrKKgB6rCbEGfzLbKn0j2C
         B+ie5ZHx/KrT0Jzc9WKL16nn9+fIIcoGfSth5XP1q/TdUjrG5hn3SPPzi87fXbTXsbsw
         GaXTDbV9eL+ElMVyTqRTaBVZbZOFud4YW/bLFizrlXi8KpAepYPlLoMl/FQJpRiLEsZs
         TTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181926; x=1703786726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=v5qAC3wCMXUQL246G1Nm1wNnpAtbiqOEPJsTyUqxbwLOhrEPWM1YRCX/0jfyhovW2S
         yTrcmZQhxq/KiHdC6V+ElKr0RZTYeD/tXF8K61XMRgwAGyKt54BrmPyeECpKgNoLdAoV
         dXIsRhRZB3yrn3lLLowcsxMj7svCa/bFNQzxXK7BIxJyC74AksPBy6edI8UWimBPGdH6
         6y6n71Aw79eNrfxZk/F0s3CLAcFR5cI2qMF9QSpjiWy3aI65D3dZ4tttvN4xB89tEhK1
         aEVqsOq0+OQEo93tWoTGgLNbK2kBhAg1o7dI71DqkwGrHR7z6FjbTBkODKGy45mdtbxH
         NAyQ==
X-Gm-Message-State: AOJu0YzYlZSWHnoNiHeoHY0eOvNhM9hl1faxKXAEKEwJqKf3YjP0kRlt
	gkQQiZ8iwf46iZ6JYZ1MEE8zLO4lhQXy
X-Google-Smtp-Source: AGHT+IGSA4EkmuQlRwLKHDDygV3QXu6nFtZDmLOZubrn0x0jL2yWod1dUEYMXOmoO644lg3SLmTVTQ==
X-Received: by 2002:a05:6a00:3993:b0:6d9:6081:6005 with SMTP id fi19-20020a056a00399300b006d960816005mr63543pfb.35.1703181926153;
        Thu, 21 Dec 2023 10:05:26 -0800 (PST)
Received: from google.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id a1-20020a624d01000000b006d974d47a8csm1557141pfb.115.2023.12.21.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:05:25 -0800 (PST)
Date: Thu, 21 Dec 2023 23:35:17 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>
Cc: linux-pci@vger.kernel.org, 'Robin Murphy <robin.murphy@arm.com>,
	'@google.com, 'Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <ZYR-XeE8X0CpWiUW@google.com>
References: <20231221174051.35420-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221174051.35420-1-ajayagarwal@google.com>

Adding Robin and Serge.

