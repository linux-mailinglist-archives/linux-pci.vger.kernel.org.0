Return-Path: <linux-pci+bounces-22780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D63A4CBD4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417DF7A5995
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE9230BF4;
	Mon,  3 Mar 2025 19:13:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA49230BD9;
	Mon,  3 Mar 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029198; cv=none; b=Bvt1o6EbcauyjRnr5ftQ4JBbNljx5Y1fvARtCSBjAUT75AUcyludgLntuWsegLx2jvRw+kdo9nXAVS6X25eJR1HogoF3TVLDQbBuE+TEwfw/+WU9N4dTBlUurB+pNjue+bUYVFZ3RZ/8G1p13JdJW9FdPUcZYxWqw3KT9EQ3+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029198; c=relaxed/simple;
	bh=HLSBP1an8sf2KditkkL1r9FqF7V03KxDlrQ8RZsogPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwDtqUNy3fcFxfl+ysLZaInNUf7Gy7FHKz20B1YdNWEQk2EN11Fvr/MW3SwV8+9IAPL3Ko6VutoxG8QbRmdZibRTX09Yf2bj0qMSClJOXCX+HcfVqWvG+PSIcAQnBFaE7g/yPySnb2LUE65MN1DPX8KxxxezfNGAwaEbcQzld/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223785beedfso53439605ad.1;
        Mon, 03 Mar 2025 11:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029196; x=1741633996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMdhomqR4u6eFz7EL0HdhdFWnLeoGWNJPxOHYDhbRLs=;
        b=n8elDG0eRDc7t23tNoLGucodOJ/Thw7c+AAax7vJOMl8Xi9bdcu06nt+AxMJv1l9CJ
         oXLGTaG3JsMg7KaYBIUVieTK9cE3BwCeg58KLK+Na1QSJaTyLVt/Nbh2mnffOeLNIYvQ
         yXQlqdgUUot3F0BZQ3DiA4IU5CzHoTnWwhZ/Yca/rSSHKa16hFjqnUea7woo5TIvx7nG
         jixH51tiOl+6v3v8VfMOUC8WfFWSncRQ5SJ2N7hqb542fKJNHDBdvqd4Gj4lVXIEfJpT
         EcCPzPF354NAji5Kt8diJk58FKi6B0TL0FnXzI/hax3PLFOLktY/Ly+IrfrG/gntrhtj
         Tvgg==
X-Forwarded-Encrypted: i=1; AJvYcCVC+jIme0QD80nggSfPyF5dLWYW56OVruOG5RawF4jaDK0YKcx6XvwyQo7TZcOHywlAmPfw+S+a3tBC@vger.kernel.org, AJvYcCVHZP3KUl1Pl+UEPBv1lBPKZMkpHPER7hHPdIb5UowL6RBNMTAX/IDUfSzj4utBFcNoN3SKlPAM1GUh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SUBYF3wVXjuXFvyPCcZ1l0U6cgBgtym5FCB8S+kVbFz90onf
	5rTQrnAHtBsIL36/gy30lWJ2flGnHmdCslkVVGTlwVGCNcQlWKqI
X-Gm-Gg: ASbGncsnjZIaY5JyYRvUcQsleBfkQ3ON5F6J3GdrXP00bpaUHYgkdG7RhRDrNKKIHS5
	/HAqKqoU9Ep2fOim0QuMzbTj6KR0i0bvpl1+Lj3WyvzFHXCjgz7TmqaLeJcFWdvzOdmlbhaR0iL
	mtg3lbz1w9Ntjw/LQ9AKTgMlWAwcSJp6iyGxrCH0UUcznG4INEarpg4wuWBmv1/rQnaaYhTp3r4
	ZM9D28QFf7NCZpb93sCUAQlJ8qr5qjHDQBzikTm8hufm2d51hyPj839t3qB+erxG/raeEPkEhhD
	QP1dhypQhCyS/HA0hQgv9eDZp/rU9XTCNorXCMbUVBp+iCMPQJoTSySXZL9tpEaXjrLMnZvpiTY
	BAOU=
X-Google-Smtp-Source: AGHT+IFWuOdDCIbzb+NPKXQr/vDDylShl9+ZLJtMDPzgxZSjAC8yWUsr6ofw3AFRZJpI4pkui7tCgw==
X-Received: by 2002:a17:903:1c3:b0:223:33cb:335f with SMTP id d9443c01a7336-22368fa17fbmr210787435ad.3.1741029196546;
        Mon, 03 Mar 2025 11:13:16 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c7efcsm81587665ad.154.2025.03.03.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:16 -0800 (PST)
Date: Tue, 4 Mar 2025 04:13:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] PCI: mediatek-gen3: Set PBUS_CSR regs for Airoha
 EN7581 SoC.
Message-ID: <20250303191314.GA1552306@rocinante>
References: <20250225-en7581-pcie-pbus-csr-v4-0-24324382424a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-en7581-pcie-pbus-csr-v4-0-24324382424a@kernel.org>

Hello,

> Configure PBus base address and base address mask to allow the hw
> to detect if a given address is accessible on the PCIe controller.
> Introduce mediatek,pbus-csr phandle array property.

Applied to controller/mediatek, thank you!

	Krzysztof

