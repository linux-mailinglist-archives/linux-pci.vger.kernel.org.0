Return-Path: <linux-pci+bounces-16266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40369C0BB0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8842E281FAD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C8E200B9A;
	Thu,  7 Nov 2024 16:31:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DF1BD007;
	Thu,  7 Nov 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997061; cv=none; b=jeZ23BAckbjRGsCOSkzRafJZsbVL2wq/wzoGRyAz5oZ976cF3Pt3XHCZGbYlQfGQIz42iwfNYT8W2sR2HV9ovy7Wzpi9d3Zbu7mdATd/lko7/xUosL0gk9ghghZ+HyStPzsVTEip6T+e1eZSeECnuapZ6mQk+VwsLZYelce0/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997061; c=relaxed/simple;
	bh=2Q34v2LsrY+KD0YJ9kCB8oYN0UDVVTFhGeqgJTPf5do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4HjAjSIEs2Bq6zkdUutGVHWQdndTFlz0HcxQefGVvRg+dCAsysVXzNPxjYRpkyqX3V2dS5ldmFs7NbcMgvFqu8XpBE8rapE6qQlNozdCs0LxRwfC9vHMYTI5uN/iQWH3vxTY4v7b6L0DOXSL9/VQ6DUUAKNUX2HylvyVuIWikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb47387ceso12533635ad.1;
        Thu, 07 Nov 2024 08:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997060; x=1731601860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3aIunwJJZwjkSc47JIdSCmw2c2ZlsEQ7RGvz1daEzI=;
        b=Ujo/R0cWrevmoOHO3E5OEEnJYyQrmTMZNA5dqWJ3VBRef4K84EG+8v+lKfDKLCzA6z
         nJEJPplzBZGgfYxp4G+TCvK7CnRxPu9vMmLzxQ63MErCQjA76Tm4yT5fbn0pM3BcfLh4
         sapI+14Zkh4Oo2F2wJOu8haqDZe+7T7baaTOD9VK8J5RadGjIPD7uHx4KqJO6G6aIz1M
         j5teCANvzB48S1Q9UwSctB70IfJiVhuW+9LSQwNPUBw35fXy0irgTQ5I4QHfV0Rb6aWe
         kiin2z/dQJ2e8YvAsn3uds9J+pEqWkHLOLzYn659hFSjv2tMKh0s+AMhtDf4q5CwuecX
         z7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVvrs4M3THrdJ5yEB31EpeQfwStMi/x97y7PYhZdqHHmikNaN6WcdZAo9P2SpZ0/yRFn5wedPwgeJiUSgY=@vger.kernel.org, AJvYcCXFDroJjCsIBSVJr7YZ4z6jieREOBBoUeYRt2AuNEYB9r1P6omBNHVZ4PPmLN4puSK+J9qzult+tr9h@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjdksUPakX2jVdofS9tCBsLp1eQ7zT7vNK4DH7eJkTARZbZ4g
	aGe3sOfXEaSCXZnVuz+pA/UGyuDmdPaQ3ZGDt8sBLnDT0CzTXCHX
X-Google-Smtp-Source: AGHT+IEGJto+1JijDqrubHaDC0FIg58jiL9pnEaSMfPJmuQ+AA54UQg+DzpAhfYNveKIfglNcXt2pw==
X-Received: by 2002:a17:903:2343:b0:20c:d18c:1704 with SMTP id d9443c01a7336-2118232bcfbmr352135ad.23.1730997059913;
        Thu, 07 Nov 2024 08:30:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde241sm14228755ad.81.2024.11.07.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:30:59 -0800 (PST)
Date: Fri, 8 Nov 2024 01:30:58 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kw@linux.com>
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
Message-ID: <20241107163058.GD1297107@rocinante>
References: <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241107072005.GA378841@rocinante>
 <AS8PR04MB8676F00E8F76B695772EB3B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB86765B904FEC1AA88F6F83468C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86765B904FEC1AA88F6F83468C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>

Hello,

[...]
> > > If the changes aren't too involved, then I would rather fix it or drop
> > > the not needed code now, before we sent the Pull Request.
> > >
> > > So, feel free to sent a small patch against the current branch, or
> > > simply let me know how do you wish the current code to be changed, so
> > > I can do it against the current branch.
> > Thanks for your kindly reminder.
> > This clean up small patch is on the way.
> Here it is.
> https://lkml.org/lkml/2024/11/7/409

Thank you!

That said, there here have been some concerns raised following a review of
the new patch, see:

  - https://lore.kernel.org/linux-pci/20241107084455.3623576-1-hongxing.zhu@nxp.com

Hence, I wonder whether we should drop this patch and then focus on
refinements to the new version, and perhaps, once its ready, then we
will include it—this might have to be for the next release at this
point, sadly.

Thoughts?

	Krzysztof

