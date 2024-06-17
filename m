Return-Path: <linux-pci+bounces-8895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A690BD3A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 00:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3D31F22209
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971D18FC80;
	Mon, 17 Jun 2024 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo0UOPeP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C27492;
	Mon, 17 Jun 2024 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661893; cv=none; b=Jo+69YoQR3l3OPJVphHRFJPOz/B4b9RCf6WNue+0GZHrnGZ4ll3NPtrQtWLOOS9yKFNYHe3Llys+fIqwBj4ZB/Awg5smqy/88F5Bch7kzlbqKh4AIiDhk33/RMyhNx0cYFoCekBbb8a246xIEbypwE4l89bOBm222OKswaVBuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661893; c=relaxed/simple;
	bh=fNuQR14TLEf6OkX+R44Y/kLAAy0ruusxQYZKqCEaL5U=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FkZND3BdIzM59Mu1kMDEJw9+5WxjFT2/1IQnnTGyM6gs8lBIsXhtcZVkLDslPij3fpOnaESZ2Q6c7pOGqLQnajS0P8ys2CEvZeX53kNfMX5txKbk4Urq31+p+dPtbyLfhotHTX5phrTQALJWBwb/2kuQq4V5s/p6RuVmBqN9AOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo0UOPeP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6ea972a3544so402454a12.0;
        Mon, 17 Jun 2024 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661892; x=1719266692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNuQR14TLEf6OkX+R44Y/kLAAy0ruusxQYZKqCEaL5U=;
        b=Oo0UOPePhDlP8XIhIy+URjglUSkhuUT+C0MJ6H3UlqgCiiZgx+clFSMkRRgUQywKWp
         Jy5cZZyvRi5ggmDtnmbYtlHcV5A7tCcKjGEMWzG0tSdRfhWBqIXEz5lfjVO1ReArRDLr
         zjkuozsqUjr6zb9F9vOXUfPiIMztJbrzMqpDcrglZELiyIxD/WRwHrB8EI1v8eR5FYJo
         yvNPe3fgCIBzRlIJKcMxcicKmqllCLbXUe+eMvNS6i1T0EvcOFcbH02m+qlhC5GQnhhe
         08yKrw5p+NPdRTkjIFybmDMMy2KHvRBtsL8MftKvk/12E0XyuEkT9e0jOi6qCcnVUk20
         IaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661892; x=1719266692;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNuQR14TLEf6OkX+R44Y/kLAAy0ruusxQYZKqCEaL5U=;
        b=xTWn83EptGFTwB1e+TZCU27dOkjGGVju+uAftO+EdB6K0aK4Ig9Tomu2pdrGZ89aWs
         IhcLmWGmJtvtpEG6yy1tUotLTCnY/0+vIaZiQZ/DiUWS7Fm/6clXEAO7mPTZJ6xAwJLf
         IAfPr4KjceOrKew1VK0/ywkE9XKFNEk6OhgosDe7nbBF30q/VwAdP6xmSTQUFBcrHBKO
         D3U5l+92DZ758BbjXZ2fmH5MJ5UOth+kSu55oJ9M9R8AkbDLvXkJEssNZMTtyD4afeHk
         6D5IVk1PcITbi1pcIbq4MN4UnItQjGjU8CVrw1QWTcnO6AZjkpgp03ZFv6Bny2tvhooD
         wmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp6UtYcPuEWs8YMDTMyf1jYiooZ5Wf3+ORrP+xOfLH+QVnivXwPWWT0ib1yEettzh3z8tl6dVk7FS5UlNwdhr9NPlHjczN3Z/hmYkn/nwGA2Q4m5VudJkVqgG6WtEDpNGe
X-Gm-Message-State: AOJu0YzIEuVEVUzqP811fNRASHP9e7rPUJjfvnKsyffeta3mruOv+2DZ
	Kva8zMZ3GpgWUZdUz+EgdUJ+5v40Gc1qXikcfVBom+HX5XMfjzMAdX+Jg9K4
X-Google-Smtp-Source: AGHT+IGThYTFoBXhBW/yLulfGqirVKRWix44ihmkki60FC4FlgGHHxlTGhjZOiAtzaKLSYQDhL/+0A==
X-Received: by 2002:a17:902:f549:b0:1f7:2046:a8ae with SMTP id d9443c01a7336-1f862546f73mr130325495ad.0.1718661891801;
        Mon, 17 Jun 2024 15:04:51 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e704desm84159405ad.75.2024.06.17.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:04:51 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:04:45 +0900 (JST)
Message-Id: <20240618.070445.451443559035655420.fujita.tomonori@gmail.com>
To: jdamato@fastly.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 0/7] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zmsa7vMjQ67zKI1F@LQ3V64L9R2>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<Zmsa7vMjQ67zKI1F@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 09:14:38 -0700
Joe Damato <jdamato@fastly.com> wrote:

> Just a note for future feature support: it would be really great if
> you also included the new netdev-genl APIs. For most drivers, it is
> pretty easy to include and it allows userland to get more useful
> information about the RX and TX queues.

Understood. I'll take look after merged.

Thanks!

