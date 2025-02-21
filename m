Return-Path: <linux-pci+bounces-21999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDCA3FB1C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E0819C5D50
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3396204F8E;
	Fri, 21 Feb 2025 16:18:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB245009;
	Fri, 21 Feb 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154711; cv=none; b=OGZW5cAEGz/PCyrJO3dUvJep77urhp+dplcZzzkHdNhX3VyRdaxPJiHeWUf/Gw+CaJLmDPOc0rQCQXDF8jgNSylY0G1vSxBJ/LpKv2ywnXg8Ce2tNkHq/jKkDvDeAl2moxK6YxPNVgXu1mjuj0c9Tm8PdzcoWmSZJVMvv26qVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154711; c=relaxed/simple;
	bh=IFIcfKTvoI6Jpzz4dZXt6WZLSf3O3RLiC8GQng2fqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgDuv2r8FLfqfjgfXR3jaJzGU44FQtx3TRqqBoOcwarHZFJl4j4Odycmr/gO9jxF7lklraxXNcp8r6mR+TvrmEGcNJD/tk5gTNMQszs/r6D1979JIBYZGraYHiHvCNRkvVJHBEfDdYJ+vKeBRwRcC52tBnW2pdqtE6M1xQu+5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso47289575ad.2;
        Fri, 21 Feb 2025 08:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154709; x=1740759509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0inqpIltc360onMbVfotB+9G1BiiqcT6cFZ7024EJR0=;
        b=vPm3owcDE5Kg+oK3UTactCO56Jbc6BufnQMizvZD8c3mjeLWHyTtmb4ETfr0UlbBwo
         SGM6ZVdupPbvvX6Fm1FWcQDcWS8HR2PK5BkguCblPmvEkJg4yXXRquEzwKPjdit4c11Z
         dMJtDl6r++kpUHtjyhPAQRySzQtjgGjIKlS9CDIPTgrSYmK6uTbQneckrbCaTHQ6UMJr
         Cz4qyx+aN8P51TCOgfHi0uUBn0XIfbESUdX6gMQNy7qGdshj36duqsqsCITqMu909AUj
         DcdA7wmJnPpeOOjK+bSyCvkwTqzOLutrQMhAxrOd3ZHPNnRiUxWEX//EScFdYUu6nQU2
         5+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXbgvv+ZNXR7Gae7ImLHIVhhOoOBug2necPac1QTQ7zEr+fPzjz4sy0uzTXCBTbSvvLrcNPzA72mc@vger.kernel.org, AJvYcCW1cpq2wrwd0vZo0bp0IrOfjDojWwYJ9ciVAqdTGCb6AXVue2q0HftIEAiHfgBhRvrVzA/u+iyIfTps@vger.kernel.org, AJvYcCXt4N9ExIshiD7iR9E6IW2e81rlh4owKkwr3T7CUQ2MYmAWv2Rd4IE7l3/iwEP5FoCsVxvUOEJtsasx6j8a@vger.kernel.org
X-Gm-Message-State: AOJu0YxiENDkGrsjq8cNOqt9yE0f3GTLEWKkfgInv80iSX6+cw0ojXEc
	N8Y0OcoZvLhSbQsGYJ6+c+vmcMuidZGXhaRZeFQRd1OfT4KhHFnbrkcl8ay+
X-Gm-Gg: ASbGncv7McxQW6Hv1NLo6YPIW5RGmoKnqq9bI11cOYPe5fZz85IP+f9sYev1JSabyy8
	YMBsRRum7NMcRyjuOUQDNYZUeWiKpn2DzmQqz+cgmDJmdaCKier+PSnaTpIgUZCwJWchGQVjx5S
	ktkH1/LMVWXh5X7ld2N1S2zxdedQw1Mpdz9JtWodjJ1y2Xv+/uIKt2lmD9m50U7vxdAS5V/jq6m
	Gj1c/+MY/IT5m2s5ZAIRUiy+r4wD70vNyWcwhJTPH1P3jAIu1eOTondAXTKmgSRSHXiC5JXkUka
	8ngkgoIYOt9tRCKrpwgKW8SEejPyCj9Mt+fFO8StaNMfev7DzRsBHHHLdtVR
X-Google-Smtp-Source: AGHT+IFFC7TzkmeEvaeC5hCBX5n8UmyFJ/BAqfgtyU7o+6JEfRW/3+0dEFvOaLm8q97F1jekjmOYFg==
X-Received: by 2002:a05:6a00:92a2:b0:730:9946:5973 with SMTP id d2e1a72fcca58-73426c8e077mr4818381b3a.5.1740154709362;
        Fri, 21 Feb 2025 08:18:29 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7325b4d5609sm13149663b3a.87.2025.02.21.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:18:28 -0800 (PST)
Date: Sat, 22 Feb 2025 01:18:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 05/11] PCI: brcmstb: Expand inbound window size
 up to 64GB
Message-ID: <20250221161827.GB3753638@rocinante>
References: <20250120130119.671119-6-svarbanov@suse.de>
 <20250212180009.GA85559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212180009.GA85559@bhelgaas>

Hello,

> > BCM2712 memory map can support up to 64GB of system memory, thus expand
> > the inbound window size in calculation helper function.
> > 
> > The change is save for the currently supported SoCs that has smaller
> > inbound window sizes.
> 
> If you repost:
> 
> s/save/safe/
> s/that has/that have/
> 
> Otherwise we can fix these when merging.

Updated directly on the branch.  Thank you!

	Krzysztof

