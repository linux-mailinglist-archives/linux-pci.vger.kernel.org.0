Return-Path: <linux-pci+bounces-1007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46B813A8A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E5F281F6F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92890692A0;
	Thu, 14 Dec 2023 19:16:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940569293;
	Thu, 14 Dec 2023 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d37a6926f7so3531205ad.3;
        Thu, 14 Dec 2023 11:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581412; x=1703186212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G++dpHvmGlbX2QGF7UY9vfMshjeGHz664YaJzgjIeak=;
        b=YNf202FqmgDUaTFVic6f7GBlKHtTKa6eRC/f+e/IDcBUpEL3PetklWLuyBp0q9DvBs
         90fb1tVOz3tjhc/eel22xnsiBuQoidZR3MBMqsguqg2t3OFFpkRjlsu0wYFhHEH9Bv66
         kXCmLriXnESWQulrBEHTwsutGp9s7JibghUmL4h2741zheUQzs2++buSpOQ9iR+l2n8J
         19+3etnOkJWfjkJCGi3lcUHX7LDNoR+PlVW6uUIkB7GVImy7Q/X6oatpUw+/TpuEfNfF
         5H1Tgb5W3SegV0U0ulwCvqJ4fQdjqwwdn95D8LgoJYwzD8XoO08UQAavCZDAQal10ngB
         UZHQ==
X-Gm-Message-State: AOJu0Yz6GRK90PSs7/esHGaw1kjlgFbKCxtlxdGEFCOIyhspGlT0hp9u
	dbodJZW6TKjJifFXilyMfXeTHYOhA0S0RVrh
X-Google-Smtp-Source: AGHT+IHq0HvFpEliB+p/cmB/KW5X1PiGRyCtY4Sga4M39n+mc5+m4fU8tpE6raMlkC3F4gRIU0haYw==
X-Received: by 2002:a17:902:780e:b0:1d0:ce26:7ea0 with SMTP id p14-20020a170902780e00b001d0ce267ea0mr5640473pll.57.1702581412173;
        Thu, 14 Dec 2023 11:16:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001cf684bf8d8sm1115574plf.107.2023.12.14.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:16:51 -0800 (PST)
Date: Fri, 15 Dec 2023 04:16:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 RESEND 0/2] PCI: rcar: support regulators for PCIe
Message-ID: <20231214191650.GA2079458@rocinante>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>

Hello,

> Here are the patches to make PCIe cards work in slot CN15 on a Renesas
> KingFisher board. Please apply.

Applied to controller/rcar, thank you!

[01/02] dt-bindings: PCI: rcar-pci-host: Add optional regulators
        https://git.kernel.org/pci/pci/c/b952f96a57e6
[02/02] PCI: rcar-host: Add support for optional regulators
        https://git.kernel.org/pci/pci/c/6797e4da2dd1

	Krzysztof

