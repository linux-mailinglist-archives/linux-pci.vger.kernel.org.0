Return-Path: <linux-pci+bounces-1530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239AF81FC62
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7691C21460
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6BFECC;
	Fri, 29 Dec 2023 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JZIN6RQL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF117D8
	for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb7344a0e1so5468834b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2023 17:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703814004; x=1704418804; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X83wfcIZjdEzwkgoaoOF5TgcwBhLow4MMDfeVCMjkfI=;
        b=JZIN6RQLPwWPrNYejknxjeb3NsRvRn5EOS6CM4zI6ZQ0XqQneJr6Fi0UENAed7XG6I
         YwcBno33XYUt1huylG1ibVDWNSQwuwWR8qycMDQOikLeHCM0yqUiqpZWthLGymoRc9L0
         werbAd1WSrGY1C7RHyU6vh0y28I1L7l52d/5E2n7Temu1EMFF/xFt/gLHzgpuSlsp3Dj
         mMHOBYCkKTAFAhaQFSprsR+DWVIJJc5mM8Goq9/1IAzgMdIZh2z7PmOgWYPtfwn1537F
         ZFIe0dXG3y7wULB1TKVqj8GzuNpBhSZNEe4A9LbtvoiejZJPWCtz2McRomeM5DsqeUI3
         i4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703814004; x=1704418804;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X83wfcIZjdEzwkgoaoOF5TgcwBhLow4MMDfeVCMjkfI=;
        b=t61+bf91euvXeYFkC6bw+psmVOe3xiSvs7/oUj9psKG+CtC2zK9GF2KLFm/O6OAc0o
         2mk6yMQ5yuQOQOJk99nOieR7xxtGGkzrfySo7yZ9D/HXhpGmWE0ctnFta4fEUgsRDZ1c
         m0WZ9TzbZtf8YATyFdDML6AGX4gl8UREr66UxYkGz55CqcJWc6mkDIQKeGeE8tDwv7ef
         nc8MRXP3X+7xr/mGkpFlLRWHQhqUkkfwHIMMRbuBY/aJsfOx/tICiNa/biZqeWU2smTP
         Bg4LsJneFJFzh8VEU7qr1iSarYzJdTJvtdISYsvJ7t0sSF44PQNvlFKzt8fQGaECk7zU
         m6lw==
X-Gm-Message-State: AOJu0YxgIHivbJ7cm7c8d9VDartT/wL7gWy6Gm/P/SRVFBzbMUaBzF4G
	zXOot6sKBxzhSxTWeYzsWivsomFvhrakyvhj2WqbRpkLdjlC
X-Google-Smtp-Source: AGHT+IGF60wU+mSoalWd6UHlhEo308YpqtgcdbGQB135dpTj1IDi5N7qX5FYXhcD2SQ93Jv2z2NSnQ==
X-Received: by 2002:a05:6808:318d:b0:3bb:a777:e891 with SMTP id cd13-20020a056808318d00b003bba777e891mr10630353oib.104.1703814004373;
        Thu, 28 Dec 2023 17:40:04 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id p2-20020a056a0026c200b006d99170ab87sm11391939pfw.182.2023.12.28.17.40.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2023 17:40:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] PCI: switchtec: Fix an error handling path in
 switchtec_pci_probe()
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <20231228235626.GA1559849@bhelgaas>
Date: Thu, 28 Dec 2023 17:39:50 -0800
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A483D7C9-07FD-40E8-93F5-5688AB6C9040@arista.com>
References: <20231228235626.GA1559849@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)




> On Dec 28, 2023, at 3:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> [+to Daniel, can you take a look?  If you like this, I'd like to
> squash it into df25461119d9 and credit Christophe since that's not
> upstream yet]

Thanks very much for fixing this, Christophe.

The fix looks correct to me. If it can still fold into the previous =
change, all the better.

Best,
Daniel

PS: without trying to complicate this thread, does one know idr.[ch] =
well enough to state
whether ida_free() could have gone into stdev_release()? The way the two =
idr_free calls have
been placed looks intentional. But stdev_release would look more obvious =
+ cleaner to me.
Was only starting to wonder while reviewing the err_put side of this =
patch.=

