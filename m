Return-Path: <linux-pci+bounces-32840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD88B0FAE0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337121C827DF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0220B812;
	Wed, 23 Jul 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TLZp0oXt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CA1A23A0
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298328; cv=none; b=rrd+9YCrL5BDkoByzDIVa/LATFACFaw3zCa/Bdp9JN7ff0U5vXfOyAdOUqQQW0zZeGwsQMPy70oTWPXU3bAo5T824uQ+71LsrqjzUXuwnHh+nHTsx9DeUS4f9N9RElikQ2Bk65XB6gfW+EoL6JW2QI8XK408UuVEwL44j/yZ17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298328; c=relaxed/simple;
	bh=HXeTumecT9Y4xDZwhVeWS5M2tBgT8ll13xFM3KvQXpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CruIHshkRzJmNUSlCFCu54/B6fuEyt6qtOMmmfer/S88v5hMa0xE2H7Kv86mBTGFnhVUDtra8MgDValETMyrd/Y6hwKh3PK6PUts/sTjBT/+qa51P37R6Zk3N7RCnDWZv6EvrCSUSVdYHo0x2y1YNhrKk7Ylxg1oRot4M3bEDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TLZp0oXt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so306556b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753298326; x=1753903126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko+FgGvTqrDZuxqb1L+X3/XCA6dF7Bxu8HfyGhU/Wno=;
        b=TLZp0oXt9OlpcpvlZwDVHOpYbbOybd7/0cUbGVII8YTn3e9d8rjlWe6qlQw04Maiqp
         7EbtdKkNAybZDDBPRgiMFrgg0R7jB1cETdvdYjMEr+XbdrSDpdl5nz/w1L2KCG9HqWKi
         xvFcDGYUamHkYzcMZDVh0/OxTt9Ny1oLbp508bd6K/ZZO+YooAAlbE124mJn+WnOaKSP
         E+DOGE/paIgS5R431TeKcM5zeTSm+6St27rj9hEXVVfNGk+r/HTiX2s/FjT+ri228jL9
         UjIM9NHsQfvEcS7grlrPevYkZprJZS8zcsNk0THJ84IDVv1yojRbvTSN1l6ssqx1F6wC
         rEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753298326; x=1753903126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko+FgGvTqrDZuxqb1L+X3/XCA6dF7Bxu8HfyGhU/Wno=;
        b=OygCcVjqTcFD2e/5pHGXzilmf/M1r6GZipiuhmn8leeRw35jyEbWbpjruuH3phJrq6
         nQJBo6HmZqiZ10rC7bQJhXAwU+w2hMVzTs42cZHJGIdiEkFpSoi2RAbF8Y3o4ysB/JNy
         Fm2CmlvcnViEtXOarPe+Y6sbpayEPsRkP4UQ3MXdTw3unA/JazUxkiF0sGX6141GC+89
         0Gz2/kcAEP9k5oaQ0yiwdlCchyAy5APdLXdfYA0z0UB3bV6nvNOLS7rmzDWSB0SdGr4O
         TyM8U66ZMkJC8IIJ4dPGFAL6cPvFtAzhutoBzpCFBHL5tHidTZk6CDzupBSrCO1lZFnx
         RuTA==
X-Forwarded-Encrypted: i=1; AJvYcCUe2dyFZusbgaJuChQvcEXj0UTOhexImTJQeQgBS6Cf+wuyagbQtQh8ry1RHjlOh3iYniS+nk06x9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqmPdLHci/K8ko7hQqZzzxBOFQLyWv+Pu2JpZr+2GhXtAkWiG
	XSHvQ7852YoMuqPjcofn+snnvXF1ehourjAEVcBMJ0Tar0nLoBr6bhbPHD04gRNX/hE=
X-Gm-Gg: ASbGncvxV2H2Hl3mTh58pQqfr3IhwT0ZPWdAMZwubePbl1JRv4MeufeJ2lii+8fZDXY
	0zz+ozv05Z1OOW56nWidE6M1EzwabXpLsp8XiVr0Unxk7l4Lq7cHBpzKqEcJ9IyFZWUwszSk1iy
	WhDdIYRX+pluS6We0t17Ok7pQmY8im5UJF7HYnysj1hk5ai+Ud5V06RQWhIMYL4uiqUrBgQ8Kx/
	rcRBtoaPJng8Fx+x/JrojfE7f9j1Lr9aZGv72dpTn2zTJ2M9ZDbHzSczRUZH+y7QCBOfGA2etxy
	Xjp/D3FawBT/2HePKU9qKvq6Vgko8HDBjtYW4xFjXfJOFUYErb0sLz/ZbhocyKKfBBxg1AC+oPl
	ALz5VpazhVNvRbKpMy1jeBShw3d1YIBTUvrhHJOqHyTw1EZdh
X-Google-Smtp-Source: AGHT+IGqb48RSKV4NsWrJCeTpeqWG9rhX/R3cUFMSd+n+mER81YauZdAHnQSkjAFIk4Xshh2Zn4JXQ==
X-Received: by 2002:a05:6a20:7343:b0:220:63bd:2bdb with SMTP id adf61e73a8af0-23d49167303mr6800750637.40.1753298325922;
        Wed, 23 Jul 2025 12:18:45 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm9302709a12.32.2025.07.23.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:18:45 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: Re: [PATCH 0/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain
Date: Wed, 23 Jul 2025 13:18:37 -0600
Message-ID: <20250723191837.35503-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2507181435110.21783@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2507181435110.21783@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025, Maciej W. Rozycki wrote:
>  Bjorn, unfortunately sometimes you have to live with what you've got, in 
> particular there's (I believe still) no good choice available to replace 
> the HiFive Unmatched board and the PCIe splitter adapter chosen was the 
> only one I could chase that is fully mechanically compatible with *ATX 
> case slot space (i.e. you can actually properly mount it there next to the 
> mainboard and no connector will clash with another part of the system).
>
>  Matthew, please correct me if I'm wrong, but from discussion so far here 
> and previously I infer the problematic part is not the essential part of 
> the quirk, that is retraining at 2.5GT/s.  It is leaving the speed clamp 
> behind that is.

I'm just not sure what the benefit of the quirk is generally. It seems like
there are several problems with it in "well behaved" systems. I think for
people who build & sell servers they would go out and qualify a list of
devices which they will tell their customers "have been seen to work" &
therefore would be unlikely to see your specific issue. Another problem in my
mind with the quirk is that you're left trying to figure out if it should
have invoked the quirk before looking at the device interaction & so I think it
makes things a bit harder to debug.

In a way we're basically enabling future bad hardware by allowing the quirk to
run broadly on PCIe devices... Once its been around for a while will anyone ever
be able to confidently say its not necessary? In addition it sounds like both Ilpo
and I have observed LBMS to behave differently on different devices.

