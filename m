Return-Path: <linux-pci+bounces-37532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4EBB668E
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 781E3344E57
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0A2C21DF;
	Fri,  3 Oct 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdDiHLvt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245E1E5213
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485374; cv=none; b=FxdLnagUp8PZ4alWcmoqIp5Rs4tAmPDYMMSRSsNTUuwd1x6wBS9KX+iP/dYWpE7UVB54MLiA/asvZAVhehA9RfXu0U4jtbJMwswsnvnZvHUfyv2J0q+PrU+YKd3cQXtd1PwnKlVLelqBlx3mkdd7bVEyp4jEF4lTL8mh+xn28D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485374; c=relaxed/simple;
	bh=QqW0rxC7Vf1nAEG6EJAGWXwKs5VrONY7vi4gfK9d5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PShflgXz6OjJwZXNX2a9I+adknVZY164gHAQFyUYye+66ZfZRT/jGEJ1FH2AunbqPq8vKDJs9S2B4jFH/Pfm5kB8ZRJBW7fLJes/+VUgxqbVyBcF6bCGQJSA0P75r3zQzcXWW+sUTc8n+vVBLTKJS3ycXwj8TUg3yz6U/yw2TTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdDiHLvt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811fa91774so1712268b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759485372; x=1760090172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjkSzcHQCRHxGjAdHJ76YWjL7H9j4QRw11Hc/S45qjM=;
        b=hdDiHLvt9Ie6e2LmmmZsmnnx7Rm1fw4L1xxtN0gw90sXWu64AHsKLXJ+6Im3iHJ4qV
         O7Utg51WQBaijUL8DuLd/8XmI1WYZHHk8fk/V/w4rf8Dyd8pJv3rsDaIqfeGs7sH3dbB
         sqDivGxO7HiARQkQtRiBqDw2iC4tjJ4A3x7acEBge09U45/nSB7hRfqYKxy3AwqPHIwZ
         IKjF7ZjRnAg7mpbUCY64n0l5iwSoK0Lpz47n3sCgesKKl6YA/Rm2/avpwwoMdg0WsULK
         ILblMyXZEkAOnN4meWaFi2nsR7RDLiC33GXPzj9oydJzwY5UEnjiR9voLSn19fj5lMCj
         6GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759485372; x=1760090172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjkSzcHQCRHxGjAdHJ76YWjL7H9j4QRw11Hc/S45qjM=;
        b=BIqZpVdEZIQj3l3XAUPRcLR3pAxAcPn/lC6QIjpYzayNxO6tNPQPD/RGAvJEcLkZ2Z
         L7x5LAAarNBt/O+yElovP2XY68MRTHw9uTsrWajdWSfRwoqG26KVm+1FKLpUwlLeD3sR
         0VzscKXz1Wy9nmr0qaC9n7ActxUnQp2Py/uXgtlN6NxPGam2q+Sb8T7wLZ8pBFadGvHF
         Jz7NpAKBfnsHzmhKTHZ8yQYWDDwYTOWTq6n+Zz9U0+MpYXVP0R6l1Yuzg/rom7YYhy90
         qkXJjTo16p1Fs/eYMpZyfHv9hupX1bVobhKhZGdse8xMRmr7ycOI6qm7yM3t2RwN0wOV
         ZA9A==
X-Forwarded-Encrypted: i=1; AJvYcCVv7M2BTHs0WeKFFII/eskJ2fRzt8R5SgYCuzwIxbnycqSLp2rLBh1oVOGYYDVyhlCxTojc4HlMXMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+Uv9h31HejKWKRLAoxlDmKns225BU3d/DrlI/N27IJySvVwr
	kr8NwjTb+1+dUkRT5uCDcD6NGzXIoVjRXnMyalBvAWsf724ZHxE48rau
X-Gm-Gg: ASbGnct6Pq5D/sbHwLMFVPqO1O22E+fcLh/92d7gMJ4aIwumYB809htHvDP8NZ6yLBz
	0GaBoLYmkcM/5wyFapxenzlOz7if0Rp8YU0AW8tP8b6mkB5dRg2KzJ3E1wHK9Q3O0LwgjR282wu
	vPaJpIav1vYhTRRX8gSREPlKAD0hjdoc4k4vscJW8zfTbAjpTxU1uKpEDnuX1I1r+iqb6jECmBX
	dLmIZ+MogaNV3VSSwoUE8gDu37xmIHB8GLKjyvp/Kg4+/ZTicE2aJqG8pK8HaXkpMsdn4idp6ax
	z0YQyNinKtnvHW5YjJHRY5zvEXLCNhzn4cvjmemqAtddE6REb/hvccF0AGxr0t8dtOElhZS5u71
	FtWeUq8Ndmjw+TOQf8fDNgknUPj9AOlsl5A==
X-Google-Smtp-Source: AGHT+IFgG1sDmJWIInobrT6MYZozHk7ObDc757Ax6SKK+T4qAyB9z8lgZO3RUGk1fZnpjVO1SGBv+Q==
X-Received: by 2002:a05:6a20:6a1a:b0:250:429b:9e6d with SMTP id adf61e73a8af0-32b620db8bcmr3216562637.44.1759485372467;
        Fri, 03 Oct 2025 02:56:12 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2c45::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1a9fsm4407283b3a.20.2025.10.03.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:56:11 -0700 (PDT)
Date: Fri, 3 Oct 2025 06:56:04 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aN-dtHxYTspw3rvQ@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
 <aHnAcbXuFqcMXy_5@geday>
 <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>

On Fri, Jul 18, 2025 at 11:46:33AM +0800, Shawn Lin wrote:
> 在 2025/07/18 星期五 11:33, Geraldo Nascimento 写道:
> > 
> > Also, since you're asking me to test some code, I think it is only fair
> > if I ask you to test my code, too. It shouldn't be too hard for you to
> > find a otherwise working NVMe SSD that refuses to complete link training
> > with current code. Connect this SSD please to a RK3399 board and let us
> > know if my proposed code change does anything to ameliorate the
> > long-standing issue of SSD that refuses to cooperate.
> 
> Sure, I don't have Samsung PM981a SSD now, but I could try to test all
> my SSDs to find if I could pick up one that won't work.
>

Hi Shawn,

Haven't heard back from you so I assume you tested with SSD that should
work but does not and that the test failed?

Thanks,
Geraldo Nascimento

