Return-Path: <linux-pci+bounces-29356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68254AD422D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC623A4D12
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B892472A8;
	Tue, 10 Jun 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCBRTcB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F81242D90;
	Tue, 10 Jun 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581292; cv=none; b=iuzg2BNzKoxFD+A+bHThP/CynT7/vQjqTTOXiAtKYZAS1PjlC2Vju0VLs0BZRbzlUPwRn/24lZ0UA1MPNckMx0gxHV0v+8TbD5sylTC0PEvkOGgVmueWa8BGafZ4IzrCQNEIqPE8B/W2pS7032YMvhXuNnrS1/XANd/kJ1T7hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581292; c=relaxed/simple;
	bh=JX4mrNACU5QqiYMm/oWkTJ9YOn7pmJRNtKmkF02gE2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih6ln+VxQqVgijvH0k92EUopnXEaRElE7Mc07jK/1HIL2ZAWVHwnIRklm9ccNQZwseZfFtK9NFodQH/wheYcQ2mDoSWPi4elQMyq55PbL0XYBMpWxI0J/mogYF0NVD84s1BVuv/3salgxp/qNaYSFim6CvbHTJglDFPN/xK4TNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCBRTcB8; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-530807a856fso78909e0c.0;
        Tue, 10 Jun 2025 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749581289; x=1750186089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JX4mrNACU5QqiYMm/oWkTJ9YOn7pmJRNtKmkF02gE2o=;
        b=XCBRTcB8+aan9m2kfZIbbYM6I/NQpx0ui1c7NPkczX6Qd75030T0GZKaWxkEO0qUUR
         gJLlmYIwQuy2ibQ99pljBgSBlIj7W9CjEDOX/Jyr6vIfokaT+HOvWF+Xm9GviawYot05
         59wfsOl8RLUno1xNYEaQFX8vFtgeK57ZD7lx6IJ/zSWiV84UKCh38zshud3g3yuOwSnF
         PZxHNRFutrexyorZ8JNrxoUdfpMH86KLOatKbZcdKjuqctBWtVCXHcfF+1BlJl96e5pl
         zm70zpueyRwmfA2yJCNyhD8OcnhDNEWTjj7tp49maCaSEDuumDzSBGRnoOirelTO7cst
         d0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749581289; x=1750186089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX4mrNACU5QqiYMm/oWkTJ9YOn7pmJRNtKmkF02gE2o=;
        b=V/8jzxufuUKL+lBN2QLzmUYj56iPy5EaWa0V0GeeKdf0KFl0Py3pZF72LAk85v6CHf
         gJRmKAlmmcCyt+C8k07ul9phBjm7pxSWg6TH0da0hwQ9ciORXFb15bdGP4lYYaEM2nRI
         LIkiJFJLyOCGMDPKN0CzQDTC1OgU8B9Dl1Fqoeo+x8uVH/7khOq1beTcSgKPzpEJezS5
         APwNCEqyiq7VBOvzb9fSJpUp6xyBXYngOqht8bXcTBBZAQj/DwAkhAXQKcNqNOTAliH0
         vk9GJJbY2fP37qs54YMmgRLpd4lJuwG4tvSThrugTcb4w+tg4f1bmrWRlcXdfS882AxJ
         XUnw==
X-Forwarded-Encrypted: i=1; AJvYcCXa/7xJWq2EGrJr/QIA7cV/7AsV8VCnGKxUqXFW4MgkRvTT3D4Q8gAZZBfl54jT3rhzbJObqNx3JgT6IuE=@vger.kernel.org, AJvYcCXqT3l9pM++G5qWKyJN7vNXoB0Y7CqeKZWxTgyYgda5oGH6weCl+0Ekha84tfUEE8hFRAXlI/kPKOyT@vger.kernel.org
X-Gm-Message-State: AOJu0YyohmHwVMrgoQ/kdltiOTwhoki2GNLl4S1djobLOJfBbrXxtCs8
	o0TWSyx9prn42e9ofIbmblui05u8eEZn7qG3kI2GoH0KCDwovCx6UquB
X-Gm-Gg: ASbGncsoAxeTCTiizB2mjn1f/t7HhXGAM5v4xH10SSuhZ32lp5Xg5M2lE0dk/XeGxg7
	6AlwWdirujdtx2VR2ma/RZJFUJqkQYYm13tH+YpjouJwbSuNe28fgDi/1cQiIi9JzcGtXOV95M4
	RrNOq1R6hHX8tNSapplQljwhVJV4fwhj+WvQ3PaZgahwvm7ewFp59fuQhgpFMYnjm5LnjX0+fpb
	JuwLEzwZIvwxhiNT1BzKzTk7f3L/l4b1ied2tB1HCuo6oLiUHoMu+fyQc+ItPO8UxXAcAq5LiwB
	7WVLXawEs5IimPr+BAFYK5zk36oRHWbFIPPTDYRCsa8oUZhaNg==
X-Google-Smtp-Source: AGHT+IGmT7wJcDq68+XcDGJVWcLx9IDfGN4qKAUL1yE3GxYgT8Php+JzMKRe6suO938HurboJxs2ZQ==
X-Received: by 2002:a05:6122:4598:b0:530:2c65:5bb8 with SMTP id 71dfb90a1353d-53121d524f0mr973900e0c.1.1749581289454;
        Tue, 10 Jun 2025 11:48:09 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-531224b91aesm162867e0c.8.2025.06.10.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:48:09 -0700 (PDT)
Date: Tue, 10 Jun 2025 15:48:03 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aEh949r9mwY-R0XD@geday>
References: <810f533e9e8f6844df2f9f2eda28fdbeb11db05e.1749572238.git.geraldogabriel@gmail.com>
 <20250610184449.GA819185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610184449.GA819185@bhelgaas>

On Tue, Jun 10, 2025 at 01:44:49PM -0500, Bjorn Helgaas wrote:
> This *looks* like it could be strictly a move of
> rockchip_pcie_set_vpcie(), without changing it at all.

Hi Bjorn,

yes, a move of rockchip_pcie_set_vpcie() is needed for re-enabling
power rails, considering patch 2/2 was also applied and the regulator
is not always-on anymore.

> If that's the case, please make the move a separate patch so it's more
> obvious what the interesting changes that actually make a difference
> are.

Good idea, I'll send v3.

Thank you!
Geraldo Nascimento

