Return-Path: <linux-pci+bounces-1230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C0481A765
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60B61C22B48
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949E4878B;
	Wed, 20 Dec 2023 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Boam6K5k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9548788
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso15258a91.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703101592; x=1703706392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4QGjZ3Xml/O9jwtba7pT7aKCZcT1zSBhf7/NNKNxnk=;
        b=Boam6K5kob7RTq+5RRSeJE9m/txjm0yfseH4QtWxuG/kBtQvuZHsuCB6eUHbnM6rsl
         rInrH8xJnKVttSsXchYhMvVu9DxpII+3wzVZKAC+EEAZh/6o2QUSx1/KZQcSU9JmJHS4
         apLDL8FMYW54A4F6Cjtl6lhhllz2217aQBSwIcZ7o/5p+yoM3CSb3MtODwJx4/rwWhSt
         rTY6NWTSOz9fhfIEM1H+adWMfXfTNcPRFK0SCo2WjPWY6uVGM5Q9j12XucC1OT+JUvaC
         hSBCLGLjTihIsYAEQmNI4aVomtyqXKJh/JZTGi7pU/o7pV/pSMrUWfKnOmCKwIeClNCc
         nADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703101592; x=1703706392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4QGjZ3Xml/O9jwtba7pT7aKCZcT1zSBhf7/NNKNxnk=;
        b=PFnHQQd7FE3UxdPAAEzj+XxkZAB4OF8FjtkiuHkr/Ho/ZjqYNDaShZtuO1eo2TkkWz
         NlQRMw6VQRMsqCYRO8XHIfonNgHVz4tVZipjpLw/4ASfLJfTqP8CoQA9yruWaePnoglt
         zox41k6g32GH+Wi49sLzXi1Lu1bdfSHBTVY7Pi2K7IX6zGDfKkdRroevjmbKNN7ojH1x
         yw4Eh6QStzL4XkHT3ycWik8Hb+EJvnXeueevAzhMJjF/ttCnlqnd4UX5YqgtXu9uqmGI
         Cp08Pxj7NXQ5t65vUXkMhnCcNisKmywIACH2eIdgRTycYjkmhv72W+lkY8xn9uIMrNKv
         Nyjg==
X-Gm-Message-State: AOJu0YzTQhPmVS3tNs339LBUU7QBNkQu4FIrLk2KXlXikV5CObu/uOUI
	jgLcjHOAzm89NH1nuptqmb2zejVN2ZUz4QPKtqFnh/HAWhqq2YFu6kJz/7+N
X-Google-Smtp-Source: AGHT+IHtSIIccZTYDEubH9f3Tq4nZAi0RAlL6e0iTE227np10QivMMFNA91pJloJyHHKBlv6ru09s7ZfXX6JcU5qO0w=
X-Received: by 2002:a17:90a:630a:b0:285:b6cb:6ab1 with SMTP id
 e10-20020a17090a630a00b00285b6cb6ab1mr9573306pjj.28.1703101592164; Wed, 20
 Dec 2023 11:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
 <ZYIWHjr0U08tIHOk@google.com> <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>
 <ZYJFq6T3uGJVv0Nh@google.com>
In-Reply-To: <ZYJFq6T3uGJVv0Nh@google.com>
From: Esther Shimanovich <eshima@google.com>
Date: Wed, 20 Dec 2023 14:46:20 -0500
Message-ID: <CAK5fCsAAXLaXBCy_pBEaynog=xjuZNSP2b0edwrcZ_3Vo4xxCQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> Again, maybe PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE?

Question--- PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE is defined in
"drivers/thunderbolt/nhi.h" as opposed to "include/linux/pci_ids.h".
It seems like the ids in "drivers/thunderbolt/nhi.h" are specifically
for use within the thunderbolt driver only. Would you want me to move
it into pci_ids.h so that I could use it here? Or could I ignore this
suggestion? My personal inclination is that that would make more sense
to do in a separate refactoring patch.

