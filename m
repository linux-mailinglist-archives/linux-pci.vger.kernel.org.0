Return-Path: <linux-pci+bounces-1008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909A813A96
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D901F216D1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE1692B4;
	Thu, 14 Dec 2023 19:19:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A1692A0;
	Thu, 14 Dec 2023 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d26eef7438so350653b3a.0;
        Thu, 14 Dec 2023 11:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581543; x=1703186343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmaPv5ednXxlApkIzwmu5V1HXdcr5X0Tt25BMAujWYA=;
        b=nh/s3ZgpE85slgefhZJqFxhwS+1R0d7TqFy5UvnC3XNQfd/JdUP+2mdDZ+tMCrE7wJ
         bl2vuE3yWUL+xwyWOyB5pGJC1By5JLNlWaQCif9EDcU2Xwsm6m1kLG6bCcc6uYqahSSq
         GqpKw30xoGowRUXPhXomLnNvCXVcLPTS9YrjTVABg8gBwPVeVuoALDO6g1h1WoMwYIs9
         VU+8e1+3Ux0Kr34HJcluViME9P3vuGUs5w/+j8a05YwpcrRK7dRh5RUhJgdUqfW9cGwJ
         WEgwv4kxfIgEIHAGPylHu6a/0v4SAqQcxiwqwwierXwyQzCCanXEH3a+jqaFtQ1MHpWH
         DdMw==
X-Gm-Message-State: AOJu0Yx3xxxISHklKA40hamtNzHt5X2s7Cwpg5GieZQVnMTag+Hyt6VK
	Ctxq/zN95VGhJz6l8FU3mx/I7XBenVlBMfrI
X-Google-Smtp-Source: AGHT+IGHCCE+L7JDS8FZbZpAIGvsdL6+lgQ1l80vl7spaWGOGjl5OMSavZxWNoQGKdgEH7IQ4IdN2w==
X-Received: by 2002:a05:6a20:7f9b:b0:190:1b16:3558 with SMTP id d27-20020a056a207f9b00b001901b163558mr15185325pzj.2.1702581542739;
        Thu, 14 Dec 2023 11:19:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b006a77343b0ccsm12189368pff.89.2023.12.14.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:19:02 -0800 (PST)
Date: Fri, 15 Dec 2023 04:19:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 RESEND 0/2] PCI: rcar: support regulators for PCIe
Message-ID: <20231214191900.GB2079458@rocinante>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
 <ZXske3k8CkMcGjr5@shikoro>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXske3k8CkMcGjr5@shikoro>

Hello,

> > Here are the patches to make PCIe cards work in slot CN15 on a Renesas
> > KingFisher board. Please apply.
[...]
> Can we have this series in 6.8, pretty please?

Applied, so it should make it to 6.8.  Apologies for the delay.

	Krzysztof

