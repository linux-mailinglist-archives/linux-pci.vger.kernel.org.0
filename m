Return-Path: <linux-pci+bounces-7598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29278C84CF
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CA61F22CC1
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2C374F1;
	Fri, 17 May 2024 10:27:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054302375B;
	Fri, 17 May 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941675; cv=none; b=Xo6qfKIm4Q0zZT0181rHtwoPEd4+9GlXfj5p7yBRv3wWgDyDJBU4nKsXsGt15kb/auP6RaBqnvPodS49793YbcEsqFXUL7LgiYU9caxt33VXEKaHpOvt5aO607NCvP/+fsEeKTpCbOroCmZ97E/pDIsWQ35pGsUjx14FykeayDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941675; c=relaxed/simple;
	bh=FARz972b0QVFvGzkr1KzSWrdqOL9DPtFNtquR1rQo60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZZh+g1bW3OxB3KC2gLqXsHq5aEBIxHgT1IABAonXq/YQWY9PRv3iqLkVoNimIfUxDBdZvQq/LCGwS+bd+OV37B7ir04TS8dd10leHj5keZISi8IZfMc6byyEDb75Ud0h94AaTBBTyGNMWF680fbxML9dbPbz5c1Xf1Sn17Gi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-64e93d9b14bso964275a12.1;
        Fri, 17 May 2024 03:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941673; x=1716546473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Z+ls2zjHp40DuQuR8jg/VbA0GLSQbMZPujLsGEE6o=;
        b=DgH4peSrpdtCY2NjJSOAjfWLUggnmW+jL7r7vtFJgFmFiowuawlrFGJj2JQIhk0noo
         DbUdg6uaHE3xyiFVhoL9Hv+Iu+r72GqbC9+ptd7cC/kKSrpYxAj2aL1PDStTaUBnxwQe
         Rqdk4Ugxl3cVgeFgomRy1FFn3hI6zPTMadWEh8Ay1YNvYSSoLqk12hFQ5wzXYwr/b0zy
         pNt00dxzfBdq4iuISlDPDBzR6JtTkYDcak86YJ6Zg2K+8cgbY6EIZz7N9SkBcF9jYFMn
         v7krGfGWKO6IeUP+NXl6WgiGaypA8cic3z2/C98U6W8ij4lUKk8fRIoKJyw2d3PCdkUv
         jwWw==
X-Forwarded-Encrypted: i=1; AJvYcCXS41zb6OD9XJkSfiP/tHA/z2WBs18KkAP/vZXPgmauJoEvNzylBf1E3d+I8+TvqBqZMV8Z6/HF2QupMf88Se3OgmKw0EQdZqr9rI3YBP7ycCiv89wpt7oo364pYURAdpCH4hPKQb9jD/FdhkShXvBK/6PHK1JYpFz6QXVOQa4/oR88VcM1xxr1
X-Gm-Message-State: AOJu0Yy/il0D+3TcG1to4H6U1ALk+QGDAz3o0VwnfcfdUf6Ere7GBcL6
	rjcTYbQUwpVDiOOOUFdapb0dOEa+Fc0T4MfEkWxIHmIzfXs1xVFc
X-Google-Smtp-Source: AGHT+IGNs1D2m7fXpy3mPKRp/BRxOmK48etIJVd2nRgH5d4GIHKhNl9/4/Q2mncmGEXy23eFMTWe1g==
X-Received: by 2002:a05:6a20:1056:b0:1af:8ca1:8fec with SMTP id adf61e73a8af0-1afde0d3af2mr19951044637.16.1715941673253;
        Fri, 17 May 2024 03:27:53 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f80absm14637579a12.65.2024.05.17.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:27:52 -0700 (PDT)
Date: Fri, 17 May 2024 19:27:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar-pci-host: Add missing IOMMU
 properties
Message-ID: <20240517102751.GG202520@rocinante>
References: <babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be>

Hello,

> make dtbs_check:
> 
>     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: pcie@fe000000: Unevaluated properties are not allowed ('iommu-map', 'iommu-map-mask' were unexpected)
> 	    from schema $id: http://devicetree.org/schemas/pci/rcar-pci-host.yaml#
> 
> Fix this by adding the missing IOMMU-related properties.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties
      https://git.kernel.org/pci/pci/c/78d212851f0e

	Krzysztof

