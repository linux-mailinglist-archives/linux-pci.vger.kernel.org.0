Return-Path: <linux-pci+bounces-16282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BD9C0EB7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7879B20B6E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3914194AD6;
	Thu,  7 Nov 2024 19:16:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111E7E782;
	Thu,  7 Nov 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007011; cv=none; b=L5Ah4EFVfmqhDhI6AuqXTNvrdPTtO3htqhwn1sRh2DF2TqFUohwvCFLf/AArd1skxSpoAiDFD1lFspM5nq71BnP1q34yOUrQMsFJ3tB7T1j0kn6XNn100vfdkaVvkVqzEiK9fxMLhv6X/2sVC4szrLJs+hf9oGuJJFUo2erdBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007011; c=relaxed/simple;
	bh=y3gkMo4Cj0Srr0WYmUy9TiG4S7ye6PwjdqFvk7yAVeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKhyt3MzmTm/1Ee7DYyVjfrok65y4W47UuEt8Q6Jxk/XGZS8IU5vJ+L5zu7l4FLwQYdtzQUcyOfDR9J52w5R8ktPJwmQTl73PTRF7+du8XRKvqT0ViiMbwlP6EmeY4CW6CL5oF7N+qNqH2tQcTdEbAAa1AbZsjOTpSC/AuCdKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c70abba48so14265115ad.0;
        Thu, 07 Nov 2024 11:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007009; x=1731611809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shJRP66gOhT4DazMS1XuGuw7WkBdrSKa9fDvAIGOtx8=;
        b=XB2tSbvr0VDjNpUknJJDF2yzGgZimSGWfa8wWzP0XtamMz7R3F/fSBMqKtp+1auXHO
         r/zVXKXTgDS9HaUVtTwpfPMFY0sxw2HOlXOpds4rYjqlMHDbrgE1o5cL2g1pNpzt3yKI
         JkNuOzriOcRVcmrFj/5fkRFy8ugwTVVhjkSmfz+kG32ZNTdOfnDlqMwDZNBb5si6ViJr
         JxZCeW/a72Y1LlyiQgfPPs2bvdoa6DHxLvDYbi7btL1JWU5G7LGvxY+5cIMn8YCe/zeq
         ppEqDdJccjLEAb1D7i0dDmJ7e1gsmGWimmg5CWRuV9/bHJsRqyQzFyAwmQGSOLGdZ6gn
         flfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqjdb86sTwqUi/Nnu7/3z5ZPT4lm+mJKI3dCWAYNLWxCOQOG0azT5X9lFMH8KQMxnSIpWKTsRXOIy8@vger.kernel.org, AJvYcCXwTMZtJ9dAEz/buCnOrEYQkVrHTgXLMf74H1dvsRehVqeOFJNRhWG8J4mONBS/hnOUKRmbpUIhNxwLOAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDs3EkmQtE/1mgUV2O8eid6iabsQxPZjwnoWCt2txDd3FtnbTb
	rbq4ZGtgn98xm2l3LBv/PfznwZO9/sQhyxtgw76iTdaoGsqYHfnH
X-Google-Smtp-Source: AGHT+IHCwxuyvUx7QMGwsvCo5NxhXWDcduS3t5NeeWQsOyZnHRWMAi39zpy99fSjHtRjJzPSmc4iOQ==
X-Received: by 2002:a17:902:e747:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-211834e1040mr259375ad.11.1731007009332;
        Thu, 07 Nov 2024 11:16:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7e44sm15883785ad.6.2024.11.07.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:16:48 -0800 (PST)
Date: Fri, 8 Nov 2024 04:16:47 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kw@linux.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241107191647.GA1869604@rocinante>
References: <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241107072005.GA378841@rocinante>
 <AS8PR04MB8676F00E8F76B695772EB3B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB86765B904FEC1AA88F6F83468C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241107163058.GD1297107@rocinante>
 <ZyzxdnC4mm4GwoOx@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyzxdnC4mm4GwoOx@lizhi-Precision-Tower-5810>

Hello,

[...]
> > > > > If the changes aren't too involved, then I would rather fix it or drop
> > > > > the not needed code now, before we sent the Pull Request.
> > > > >
> > > > > So, feel free to sent a small patch against the current branch, or
> > > > > simply let me know how do you wish the current code to be changed, so
> > > > > I can do it against the current branch.
> > > > Thanks for your kindly reminder.
> > > > This clean up small patch is on the way.
> > > Here it is.
> > > https://lkml.org/lkml/2024/11/7/409
> >
> > Thank you!
> >
> > That said, there here have been some concerns raised following a review of
> > the new patch, see:
> >
> >   - https://lore.kernel.org/linux-pci/20241107084455.3623576-1-hongxing.zhu@nxp.com
> >
> > Hence, I wonder whether we should drop this patch and then focus on
> > refinements to the new version, and perhaps, once its ready, then we
> > will include it—this might have to be for the next release at this
> > point, sadly.
> 
> I think we can continue discussion at refine patch. Add kept this patch
> because it really fix some important problem. Refine patch is just make it
> better.

Sounds good!  Thank you!

	Krzysztof

