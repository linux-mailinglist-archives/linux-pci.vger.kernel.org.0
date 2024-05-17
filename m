Return-Path: <linux-pci+bounces-7629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C48C8A9A
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F059285BCE
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AE13D8BE;
	Fri, 17 May 2024 17:11:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A613D8BA;
	Fri, 17 May 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965879; cv=none; b=sBUomsiLGgV4E1iv64hNTR4Tp/ojyLd82x/o51+S5ZoqbuWUdbQj37pfz50jsgVfSto4y4u+smeOqbQTmLjkaH+5EwwABvsCMUbtYJa18e8C8EyXrUEYSaezBC0Lh5p81QJscExeSJESNMrGj5NgxPgjxjmbj64kUf3KyxMDBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965879; c=relaxed/simple;
	bh=1CqyftBDEXOVDyFcVDmBaxAf8kOdv29ex2A8LD6/HxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQK2WBN4+60UUZnrj767U069kuXU6eloK7/m5c9yoPDq+Zx8qsnIzm66Wzj3YgQPINnlh7TQjFRqZ2GvtJ5SY9Wb12Z3WHTzObfmrMxiWRzH9Bcnlo8pXDn0EVWWgiCDLoTT7v4vTD2yVNs0GnCnOl9xZV1BpVRZRRQu9FUQUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso39886a12.3;
        Fri, 17 May 2024 10:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965877; x=1716570677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAZTH/iu4eZz205ntNPvFyQUPrKNBzAPt6a2aDm0hxg=;
        b=PHki8uFAcN25fzeEw1mcFE3Tn0qUcrW3M94A5rCRkWqgCy8RqM19IuXnuJ1A9N+vJk
         u1hfdnC1gP9sTrKLZRzt5pXfHbww43sVWmKeHZ0yECwV+tq28XdFOGoaIeCy+TEcJUWl
         d0DslSxbGrG9s+mp56YS5EQONFzp+PZRhhxJ3cVSQqQYLzT5xdomq+ovUk9Vocy/Tunh
         WvOJWNgUYr2tn3tQ6UZLkqbWIUvxMKTawGIeCyoCn29e4YAXLQkNxU9gu4hbJmYtta1U
         xUgwbADjwRN4mMrgTZJMpT8lCNALgiMvx34Adzxm+bhUk0rmPnj69GNCXSNRmXnsTnW9
         I61A==
X-Forwarded-Encrypted: i=1; AJvYcCWxyPeaTffarM3cLhXpy2HYJixtd27Vj7Blc6q8kuhLWX/XEWbzWJbtbSfHtBW8u05Me10NEXyiW0gRAVXUypt3IlebktNQhVPK+SxbxIRTJaK8Bu3D7fryfP74McfC3FDCsEY7tA==
X-Gm-Message-State: AOJu0Yx3G3ULFZuDWYL3ZpXcGvXtyVFXwkBAS7bIu48R/qHK80H9ghdH
	O9vB3rkidblp6QnmEMtwMjVfutmQXpPxHF2nWSAB17gIJXcrigDtdsgNGw18
X-Google-Smtp-Source: AGHT+IFcSAAYldjjbYYJRzeFZa6mo5x4UR+GU2KewOECy4lRpBfuRxn7bVxXMN/UwIeUKdZYdBrweA==
X-Received: by 2002:a05:6a00:21c6:b0:6f4:9fc7:daf2 with SMTP id d2e1a72fcca58-6f4e02a5f45mr26547851b3a.7.1715965877535;
        Fri, 17 May 2024 10:11:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fcb6e14asm10121620b3a.185.2024.05.17.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:11:16 -0700 (PDT)
Date: Sat, 18 May 2024 02:11:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix cpu_addr_fixup parameter name
Message-ID: <20240517171114.GD1947919@rocinante>
References: <20240430071054.248008-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430071054.248008-3-cassel@kernel.org>

Hello,

> The function pointer declaration for the cpu_addr_fixup() callback uses
> "cpu_addr" as parameter name.
> 
> Likewise, the argument that is supplied to the function pointer when the
> function is actually called is "cpu_addr".
> 
> Rename the cpu_addr_fixup parameter name to match reality.

Applied to controller/dwc, thank you!

[01/02] PCI: dra7xx: Fix dra7xx_pcie_cpu_addr_fixup() parameter name
        https://git.kernel.org/pci/pci/c/6f4c62fd8a32
[02/02] PCI: artpec6: Fix artpec6_pcie_cpu_addr_fixup() parameter name
        https://git.kernel.org/pci/pci/c/49993453e079

	Krzysztof

