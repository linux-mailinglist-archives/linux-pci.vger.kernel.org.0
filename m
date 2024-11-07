Return-Path: <linux-pci+bounces-16197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21FA9BFEFD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A08B1F21DBD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCE195FE3;
	Thu,  7 Nov 2024 07:20:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E931822E5;
	Thu,  7 Nov 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964010; cv=none; b=cu8JR2IrSf7kUJOuyxxxqs93+pIp7udKZjYKHafTB76p9FsWxa7Zdogcmugu8qM2Da7GNjyyl17ojS6GlAWL0yGvRyExXDg5gvRLavFDr7IF40vq0ylJyMPHDgxJEsnSmACQzsw4Ibb/582u6KzDYVxEwXuqZzEaOOYXrfmSVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964010; c=relaxed/simple;
	bh=jzMCEh7dCrZM991y0x/C9WexSFPZ3+w2RZz+fYTmyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTGibLUKSlC+93Xur9iQOTsSJXMTHwheNWNv1b5UtGncTJmtlowAL089A6yHImEwtVuS/m9x6zdpRolVPfFZFX0UKnAqGHHgS5WVA9F2mPCsSK90PDpu0O53xMyojNkoTkfiERd5VagTOoBPnfDqgGeA7CczTkFzGZSuQs8AP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2114214c63eso5177565ad.3;
        Wed, 06 Nov 2024 23:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730964008; x=1731568808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f87EsgUx9jRfU6fOaKBBba12po3/P9HypMoaCZO0Ifc=;
        b=wJMlvis4P7ccJ2M9V0TAzFocBhxlwYmGADHJNpq8Z6JcAGoz2Y/hyqFkBkR2N5OGy7
         OwMBBbTRmUFlj9RBiqMyQDB1SnRyBZr6yfGK1modOlRz3aWBhZaVbLzobAKN9ve5zaux
         GUQhTu4UhVOCypeccX27c5PF15kcfGKdq3aDW/Uvd//fduW1FbJe8KSoB6sxy2PxbjuW
         UF9E3yhU/gU8+N3HnqJTSjKCmIxwnKkGfVporDFqrw6yts7G/GFUbX056csBJA33q5iZ
         31dqc43xlIeKxTfhh3KTCiM2MDXTfQjqUeYYTeFMvHn358VgL3dlF0jkGnv3TwqWoM12
         J2oA==
X-Forwarded-Encrypted: i=1; AJvYcCW00i0UxQLB6VOa8999GMft6f9oguZyb5lG2E8LGZKZ51LQpSMR1ikJ6UUuqhNcYOaUR8ReaWuHYzkJkew=@vger.kernel.org, AJvYcCWJh/bTXh4GGt/4vFKLt0jXKLAN5a9qBTRXZE2opQweUI4VleMQmgVJysk84Nq4+vuywvqjt/F4pesX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0wX7oYYbVV4ZPY2N1SCSt2OkCcrb2r0kukgbcnTx+4qnc/yj
	903YAMwUZfNGwqWFBw4XLa+jF1tG9/x/hKejPAkeb3RwijtMryecuEpMsGbG
X-Google-Smtp-Source: AGHT+IGgjRJm1tBjzyx6VNtbd57u2h7PQMgL45gBSJk4BeJmz+8g81AStqWX2H8l0t6FV1sYafgWiQ==
X-Received: by 2002:a17:902:f547:b0:20d:2848:2bee with SMTP id d9443c01a7336-210c6892da8mr604716545ad.16.1730964008443;
        Wed, 06 Nov 2024 23:20:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58e5bsm5833335ad.195.2024.11.06.23.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 23:20:07 -0800 (PST)
Date: Thu, 7 Nov 2024 16:20:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	Frank Li <frank.li@nxp.com>, "mani@kernel.org" <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241107072005.GA378841@rocinante>
References: <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>

Hello,

> > But I don't think you responded to the race question.  What happens here?
> > 
> >   if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> >     --> link goes down here <--
> >     pci->pp.ops->pme_turn_off(&pci->pp);
> > 
> > You decide the LTSSM is active and the link is up.  Then the link goes down.
> > Then you send PME_Turn_off.  Now what?
> > 
> > If it's safe to try to send PME_Turn_off regardless of whether the link is up or
> > down, there would be no need to test the LTSSM state.
> I made a local tests on i.MX95/i.MX8QM/i.MX8MP/i.MX8MM/i.MX8MQ, and
> confirm that it's safe to send PME_TURN_OFF although the link is down.
> You're right. It's no need to test LTSSM state here.
> So do the L2 poll listed above after PME_TURN_OFF is sent.
> 
> Since the 6.13 merge window is almost closed.
> How about I prepare another Fix patch to do the following items for incoming
> 6.14?
> - Before sending PME_TURN_OFF, don't test the LTSSM stat.
> - Remove the L2 stat poll, after sending PME_TURN_OFF.

If the changes aren't too involved, then I would rather fix it or drop the
not needed code now, before we sent the Pull Request.

So, feel free to sent a small patch against the current branch, or simply
let me know how do you wish the current code to be changed, so I can do it
against the current branch.

Thank you!

	Krzysztof

