Return-Path: <linux-pci+bounces-22825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BCA4D591
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5B43AC3B0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A841F8EFC;
	Tue,  4 Mar 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVkzUbZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2112AE8D;
	Tue,  4 Mar 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075227; cv=none; b=BXY5UsgrF980/BIEHwmkrMImbQ5G+EwMSpZNM5GCewlYc/l39Gui9Vv0TQ4zAee6kA9TOla8LFKTyzNyXQWNmxP+0MJKWucN5OfPBljJMJ/DYapbUHSi6SgDpNhPKi30YSx3sgxbR3lbyxInJ3iLvviOZbk1R1O/PylcofqZr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075227; c=relaxed/simple;
	bh=GM+XFwIWDrH57/HNKb2OKRSk1aCGLqQHfdjwtKYZf9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZBgX1ed2Ru8Pd9dTaOtRzBYJRQi3RlCJhKEZ214mVig+n7SI/7+XuVQR7IDwS6OmOSFMTlIIzvArKI3uMScUoiugZDFpCmVMAHYs35LIuSBYMKXMZHpq4RrqW+di4h3O2A/qtWVcYTDWBWARUNHPH9u3lReAPMIAV2kqhMHr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVkzUbZ2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0970e2e79so980549885a.3;
        Tue, 04 Mar 2025 00:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741075225; x=1741680025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1GaFj1uo9b1rPoRpPsJa9v8kqyTjyZ1mM2gRt9a58c=;
        b=IVkzUbZ2dHjVwqgkFBMjYabby4sdA5IwCJnVDRtdcA3OvotRGbbn8IyTaqiMKtHpfk
         n4S0Ijvp5KRLlvaTpE9JCyW/pvnK0uw60mUK2xr4K9QnbkfAUJ+qs3k01vBMS0lrfexQ
         iT67rF/UnCX70AjZ9GWIsIglnen1Yo+qnXigJqD2hD1DLGacMz1MjfnuLICUR9Kf3/NW
         1Cp0WNWD4/GZiNKJd5gjdQ2vel9FAD5MpqtBVHQGt2VNtw1tHyjy+Z5m2qc1ylkxpUFF
         IjVIWszw+rwGzuZmjJvNJDZ1bjT7EMLWVy6TS56P8gD2l2rfEmlrB4+iI2O/FnXKlKCU
         L9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075225; x=1741680025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1GaFj1uo9b1rPoRpPsJa9v8kqyTjyZ1mM2gRt9a58c=;
        b=YGNHJIpweSdOBa8KAgoALPWV1Tl0qhiwT2xSG/T7RhDdalrn0UqVJVN6VSoZe8L7Jk
         YpzdHr4jMZM13rkNahcxnyg2YEGI4Z4QQruxmVPekmP4sR+Vk2H/CjMdPePZJOY0TLsf
         oaVbP6z9+4CHQ9hmN7LvRcQ0azmgVBU9V1XOJUUQMhzXrLf/1rzcRLt+xNcY48iyxArp
         8iwhvdrnUcpXSkkmzWEUwrD4sRJ2lynMoCWbTGZxKQ9WoCb6MJiD1d+oG8ihCULc0D0H
         OI109F9SxH1xBezsOu/d2pDzRm+NYaz3BKl8oJiNMh3fyM/Y923uxJXVH7FrtJynwdjL
         bfzg==
X-Forwarded-Encrypted: i=1; AJvYcCUYhGw24ELwzhsLkjS57Jc7Rjcgt5Go3EXGpsAlq+ymfXFES8gbdL0ZaqkXI5284Yj9yCDQVFj84tR1q0Pd@vger.kernel.org, AJvYcCXed0zy9urMpujnlBtRk1WtDvJ4I8G0N5d7HOCWauAsFtDt5N2XCzMDsCrmwY6LVsNYJwEmd71k6JrH@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuJUBKYuP5IUqPxNvEdIIj2rvO7LVt0pRXNoqLQpEk0pm/XDl
	fC2yh6JDxvJg2tC87XM5CGp/m/FBkHoMpxfH5d0awpPHo5c6BfnI
X-Gm-Gg: ASbGncuEj4MyeAhvTXvIQRr3pyn5BrtEoRkcDilrLF3pc4P+b5EAkBuzc1fM2b8vyZ3
	YxScPhuunA6o5chLQPkTDvsrWBUzgzmi0YZ+UvLomvMso3c4PWjcWVSMei9NqiqqByzRpXb/aTT
	TRXgjajCHANbc28PPaP1uPg4maViAUHRPxtcZ5m9acmYunX3TqYaRTiuVScDtZBI7bkeIRvJlGy
	H5XtwsN8RgDwMwR29ZX6MlK8Taj8NVYE+BI/h4+4roq6H6mfGjNWaKPW2Lzfqo+5XcwI8SZEdZC
	AyK6D4/UnBzr6KAC9x+9
X-Google-Smtp-Source: AGHT+IFdkylbVxqjDte09eicMFW7LnS9CUylFe+DIP4qpzozVLfERjJXNp00RzgPd4cBPvEXx1CsRg==
X-Received: by 2002:a05:620a:199a:b0:7c0:ac2a:ed0 with SMTP id af79cd13be357-7c39c4c6b8amr2201869485a.30.1741075225155;
        Tue, 04 Mar 2025 00:00:25 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3c57684dasm161673585a.77.2025.03.04.00.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:00:24 -0800 (PST)
Date: Tue, 4 Mar 2025 15:59:57 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Johan Hovold <johan+linaro@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
Message-ID: <7un3pk7ukjay6ntbnlvif7mdpdfngtvbwrkcsresxmmtaxah3z@mrfezotyabsr>
References: <20250304071239.352486-1-inochiama@gmail.com>
 <PN0PR01MB103930AC8CABC36771EAE089CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB103930AC8CABC36771EAE089CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>

On Tue, Mar 04, 2025 at 03:53:57PM +0800, Chen Wang wrote:
> I think it should be v2, right? :)
> 

Yeah, I have made a mistake. This is v2, not v1.

> On 2025/3/4 15:12, Inochi Amaoto wrote:
> > Sophgo's SG2044 SoC uses Synopsys Designware PCIe core
> > to implement RC mode.
> > 
> > For legacy interrupt, the PCIe controller on SG2044 implement
> > its own legacy interrupt controller. For MSI/MSI-X, it use an
> > external interrupt controller to handle.
> > 
> > The external MSI interrupt controller patch can be found on [1].
> > As SG2044 needs a mirror change to support the way to send MSI
> > message and different irq number.
> > 
> > [1] https://lore.kernel.org/all/20250303111648.1337543-1-inochiama@gmail.com
> > 
> > Changed from v1:
> > - https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.comq
> > 1. patch 1: remove dma-coherent property
> > 2. patch 2: remove unused reset
> > 3. patch 2: fix Kconfig menu title and reorder the entry
> > 4. patch 2: use FIELD_GET/FIELD_PREP to simplify the code.
> > 5. patch 2: rename the irq handle function to match the irq_chip name
> > 
> > Inochi Amaoto (2):
> >    dt-bindings: pci: Add Sophgo SG2044 PCIe host
> >    PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
> > 
> >   .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++
> >   drivers/pci/controller/dwc/Kconfig            |  10 +
> >   drivers/pci/controller/dwc/Makefile           |   1 +
> >   drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 270 ++++++++++++++++++
> >   4 files changed, 403 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> >   create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
> > 
> > --
> > 2.48.1
> > 

