Return-Path: <linux-pci+bounces-23384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94199A5A61B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736C3189440A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007A1E0B66;
	Mon, 10 Mar 2025 21:21:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C71DE3BA;
	Mon, 10 Mar 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641689; cv=none; b=me+BG847rfpfBhbDV14bLBX9ZxnvGwNRXMIOPpaR8AR8BxkM7v33tVo6uEgIOWxCajoZXBHAJZ2pFkZvi2k4/MrXMAbsnhW/LTx4vU5Iin21dVYQuc/KECu2oQmmZVcrpqD3D9gtzv3N5/UdWtTKBZ/7dQR4AmDXj6p0EdbWjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641689; c=relaxed/simple;
	bh=55gYSMCeb2lNFNYGnplbiMul5XobGAuSXz2YriBA5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm4p6maahm36pvPruZlFSLVx54BbBoM2jW9MQQpDFwmMASVrsf/ujRwiZRFwMnw3v4vE3WELYN+1dNLOejGdG+raj/DlSYQiTOzXrNGxyj01fomdYsSYPxVJitGMM1iqD0QQI7sG9ZyRgo8bXW3vwwVn+jIOMM48MzqZMufDhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so82744765ad.2;
        Mon, 10 Mar 2025 14:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641687; x=1742246487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMtQuAslL24bZk7YWf+WGgK/9+eBDYJFSWGMHnXsle0=;
        b=TGy+E0WP/edFKpvLnYe+drcvoIZ4ewkgpMfHDhPaoARQijnI4G7gjfD5/cwCArzCNN
         xeift7UkqaBs5Y79wqUvsFXKaxzyyLW5N4qMbmojV20RJr978+edN4l1dDbZCaWCvsSK
         QRalE4HDniF+7QoSCL7JJG/2MP8ImgurNJ5UAQEJzxZ1EXZyTnmSY38+WxSS/6QNNl4h
         l+VOB7MVotq/6ED6d9ZVmORbFAxQDDfxR4J2eYX7HlYHhL/NqVly+GoR8f2IcX10wkda
         D+QB7LAKdxsHYHxBI+kTeNMi7JiPlTfZ0kIpwS5OcdR1caN8m/EDFFjq9Sou+2fazqB3
         HCPg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjC1+GoAl4KjDj5+0ig3Fjt5KnaDgABeC1JnuvyuyBruoYXR1RFVpHlCHBKVimKOVvDvPQ22adIIb@vger.kernel.org, AJvYcCVINCTYNil+6wyRGUiBIDundke3BWHEwHoY272RefAmDS6xGseLZ2dNZD9TPwaFEGnt+EJHCrDIdSYMTX7+@vger.kernel.org, AJvYcCWdklPMMjwD0a+waKBfqhdWZGsQ92BguRUvh9TCHXXi9pgaceA++gmLwPPM4+BpH+UVjfvG9byhen+P@vger.kernel.org, AJvYcCXIB/y0t/Ru65X7QMbue1fPMz3Qe7jEyDyf/pNPh4D6JUuqMuOCCT13fwlOcTGOoaPPt+YBF7HDgNXNxg==@vger.kernel.org, AJvYcCXKagc49jved4a/1qciS8ALIDmanDE92VmkujYamYjnYs4mfdxXhEWjGmNRBp3h4Cs84qtEs3K8gDwv@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXJtpUDYVNqFZ5OBxt1pqXTSaOCoLuYzQHZcTXGaYk8U2FkdF
	TqF/UY+qVF/g0Oo9yaqvWkmZ2emcBAX2GLX49CW2pw5KDpO03ZpRtZ+NeZcvz4Y=
X-Gm-Gg: ASbGncvpncpq3LbJYqEsgM5xd59xxSf0luw8GKouPKbtEaqee8p9o0+j8hbrH4Io1+Q
	vOPghoivtrkAj5go4/e4pjOxhxT/i2yvUVwjPrBRZ3wvOyvkoC4XwygSPeImBpHfhI0gNeDnE9+
	t4KwiqBoN21xl4uDEb4oZdToqVPqGvBzbvGp5EqDfvd+LQBBn9YyaZ4UJb9GJoDdYdeMyOX/mtR
	Z+q+arcMAFbjh1TwASjvggQAqQ2ozu3Hevj+L97rQMM2W9pBCvo/laqohKxrsVwhXSIRcBdKZrt
	KLQVG5oj6IJuNh+mCEVhjNCVAIRBGcswm5naac65+P7Xlgt0+SNZ5AD/1xd30prip6iLnCd5n6C
	i28o=
X-Google-Smtp-Source: AGHT+IHnwh7FGubECk4Ug2ue3ZTg7THVvARHNItmJN6zeeu4Ty1YJPgJTQfB1QWA0ZY2KF85fbkAsA==
X-Received: by 2002:a17:903:40cb:b0:224:c47:cb7 with SMTP id d9443c01a7336-22428505f24mr254867065ad.0.1741641687444;
        Mon, 10 Mar 2025 14:21:27 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109df232sm83277565ad.41.2025.03.10.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:21:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 06:21:25 +0900
From: Krzysztof Wilczynski <kw@linux.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 03/11] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <20250310212125.GB2377483@rocinante>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <c0acc51a7210fb30cae7b26f4ad1f0449beed95e.1738963156.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0acc51a7210fb30cae7b26f4ad1f0449beed95e.1738963156.git.andrea.porta@suse.com>

Hello,

[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d45c88955072..af2e4652bf3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19752,6 +19752,7 @@ RASPBERRY PI RP1 PCI DRIVER
>  M:	Andrea della Porta <andrea.porta@suse.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> +F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	include/dt-bindings/clock/rp1.h
>  F:	include/dt-bindings/misc/rp1.h

I would be happy to pick this via the PCI tree as per the standard
operating procedure.  However, the MAINTAINERS changes do not exist
for us yet, and are added in the first patch of the series, which is
not ideal.

I can add the missing dependency manually, but that would cause issues
for linux-next tree, which is also not ideal.

I saw some review feedback, as such, when you are going to be sending
another version, can you make MAINTAINERS changes to be the last patch,
perhaps.  Basically, something standalone that perhaps whoever will pick
the misc patch could also pick and apply at the same time.

Alternatively, someone else picking up the PCI dt-bindings would work, too.

Your thoughts?

Thank you!

	Krzysztof

