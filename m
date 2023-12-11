Return-Path: <linux-pci+bounces-752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054FB80CE70
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D81F215D9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C241C97;
	Mon, 11 Dec 2023 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hadUpPsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679DC3;
	Mon, 11 Dec 2023 06:32:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28aabe4a728so220606a91.3;
        Mon, 11 Dec 2023 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702305150; x=1702909950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4T42pMM+lOegJCe1HFIlB1ZP3arDImtXfzEjv6FDZc=;
        b=hadUpPsk75xdo1BdTPC6mh1dbht08J5g49dL0r71RVXc0p45dy+3/Kgf8ydTXsFXcC
         QXbml0a27k4/yc3wG1/14BxJp50XM/QrtNGJmd5MCNiqm/Ul/S2alFwk/455QTCfJ9NZ
         m0aTUgZt92Aa/odjWU+zENx6h47xku+lJypPLxoTr2BZa+fQFIWmase/Q3bzjbB4q1hU
         xGab5LJMmdReWkdS0plFkCkcb56ptH7h7/JVEgJx4uWDfzpqQk5kN7IKoBlXR80GC+Wh
         I31/JB0sgHDgR37mjFOBzXn7MSzq4gcdkBTqhKYTEac+oTSqcRZaqvfd+PWnrAQvsw6Y
         Iwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702305150; x=1702909950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4T42pMM+lOegJCe1HFIlB1ZP3arDImtXfzEjv6FDZc=;
        b=SZvUtZ7VmytkmJT8gjR/uCIZoMHBSQ2cSVtlGVoXxuV+1UQsn6tXO8cA0lMkgUD4rz
         bUw4oeMFS8idZFSvyO4YW0MB+w6qqgs4rFo4kOHPC8MwtroqhyQOlUZMvstb04rGKqY6
         uCHoFopNGMqnMvSnGmrx2qT/DNXDJDlEvogh6KmDLutwzFpa1sXdTbTCdTdluV54pqra
         Hy3S78r+BpSKXoc4/ZDVMStSurs9v/XTudq9fb3UyBwyREi6cwsImc9XKjoGQ+/skqZY
         spAupVkMiQebReWxgM+vTc2CTyTWZFaD0K8pQ5Y4tRXF/2SCrxAqjDi1vOvwNZEVozV1
         l/8Q==
X-Gm-Message-State: AOJu0YzbON625sXbFBiqMeVA7e6HpSBz7LNw3QwSzOOK2PeBaEbSiNbk
	mOAJkiSOHabuLYFirqr33xo=
X-Google-Smtp-Source: AGHT+IEQkYkTZC+r8SjpiBendOi3zHCvQ4uKeqztoZtzBJofctThTRrwnsZ9xq6Ag8OLvBeGRoQaUQ==
X-Received: by 2002:a17:90a:f487:b0:286:6cc0:884c with SMTP id bx7-20020a17090af48700b002866cc0884cmr1817096pjb.57.1702305150102;
        Mon, 11 Dec 2023 06:32:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id st8-20020a17090b1fc800b0028656e226efsm7051238pjb.1.2023.12.11.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:32:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Dec 2023 06:32:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon
 driver
Message-ID: <1ab63238-5411-4e31-9248-b494c29f2182@roeck-us.net>
References: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
 <20231122170506.27267-2-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170506.27267-2-Sergey.Semin@baikalelectronics.ru>

On Wed, Nov 22, 2023 at 08:04:50PM +0300, Serge Semin wrote:
> Add myself as a maintainer of the Baikal-T1 PVT sensors driver.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Applied.

Guenter

