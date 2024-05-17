Return-Path: <linux-pci+bounces-7610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE88C8572
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308021C20DBF
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDA3B78B;
	Fri, 17 May 2024 11:18:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91043D0A3
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944726; cv=none; b=YQtah/N6EjputkM2KzlKnKUdNJlIJ5KvygLvcX5LYAKJL1vTGLJn8qQk9BJx1kWIivetMK+8EAwji0E5NLZbctC7sZlKDB/TNFRAVopu+9HdHZsPXQRWMiT9bEn2iX3jbeHZe86ZSds/YrwZaho8Z9sl2U68PzMRL9JkPaIF+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944726; c=relaxed/simple;
	bh=hQRStG+f53sWZ1JB7R2BpQQv2z57aLAzblpt7nL9YaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzNspdqksQY266kgPk0rrbI5hPGLWBwwZprV0aDafqVcHEEbgau3nepspeVba6oLQJuYzzeSC52SscM7If9NzgZ2UeSC9QFipLqSE5Psv9lvQJaHsHTjk/KcYZPHEtJVP6HuM4gnwzeefVxc6y/YpuP9m3gw3x1mj4K+A8TLMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1edfc57ac0cso5100275ad.3
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944724; x=1716549524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+OAOc2DlBXOsFn/45TrqzX3VilnHDSuT5d3HGuQrhc=;
        b=ifn/uJx95/4F8wRIYefrceVND6pbk0IpFxhjKNo9faSvkbivV59skCDP6Dhugb6c0x
         V3T5kjoJUKRnXbZVZIVYiuTwzr0Pji829uFfoGIhCztUR/9Tu+d+BDBB4rmtsqtg+mO7
         4V+A/9fpl/3UvxGbva5cLWOeYf+nYTvcXcrJ+0schNTI1vRTazP95TulqGRjFJRf18/a
         nWBusBJXvr/4mXfAB4QnXfUMdohQB1iHp/4FLj8/sIF0UQGe9jygwWYEqxY/0T4l+ol0
         +lasmheN4k7p4qxS3ZRXMwNIRoFjeoUm13lUIK8DTeQaT0wmY+oh5WnOao/nGkR7lRFK
         yeRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4yaHJsd3+jEQ3h7IpOSj7tQcBXu86pGFUUDIaUxDKGP87XCgNhzS7ro7juP7/wZwDbviEVx7gYBlHDIUSAaAid6PcEVZknDpa
X-Gm-Message-State: AOJu0YxYNy2cufkPTD92097CYHicGKJ1sZ/fB8TN3PuYFrbMhZqBNfK3
	xQIa9r51Xt6sLBvjexzFQ7Vo4uXwb/3F0Nk4dBKDDJG3fnnwnoHy
X-Google-Smtp-Source: AGHT+IGiiihAOY94cy5pdg9g6VeEBNcWJUXDN/if/WPRNFY3fBjCmkXo+yKhC/+ULvBmwurJ3MA7UQ==
X-Received: by 2002:a17:902:ecc7:b0:1ee:fc5e:5cfb with SMTP id d9443c01a7336-1ef43d185f5mr269754115ad.19.1715944724198;
        Fri, 17 May 2024 04:18:44 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30cbasm154107065ad.126.2024.05.17.04.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:18:43 -0700 (PDT)
Date: Fri, 17 May 2024 20:18:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lei Chuanhua <lchuanhua@maxlinear.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add error messages in .probe()s
 error paths
Message-ID: <20240517111842.GR202520@rocinante>
References: <20240227141256.413055-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227141256.413055-2-ukleinek@debian.org>

> Drivers that silently fail to probe provide a bad user experience and
> make it unnecessarily hard to debug such a failure. Fix it by using
> dev_err_probe() instead of a plain return.

Applied to controller/rockchip, thank you!

[1/1] PCI: dw-rockchip: Add error messages in .probe()s error paths
      https://git.kernel.org/pci/pci/c/8ab425aa02ac

	Krzysztof

