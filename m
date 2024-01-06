Return-Path: <linux-pci+bounces-1729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7B825E4C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 06:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD99AB230D5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F371842;
	Sat,  6 Jan 2024 05:27:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FB1FAB;
	Sat,  6 Jan 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3606ecff40cso1502745ab.3;
        Fri, 05 Jan 2024 21:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704518845; x=1705123645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1Yih9/1xqqObUE2QeNTWjkGZxN66gZnCte6/yG2KZo=;
        b=gsx15ItSfNYM2RIJxpZIWBMXOFO7MvL6F4jzutBhwPgx+QeTJwIVFNPwGqjLVevUOm
         uIhS8AStygN8S5rGo4R1MAuGjiBIJgdJQUr18ZB8CJ5NtAxtu5IHOc+nXeaIIQepPCtT
         C6T2Xt2FLOmBEIO0gwieIhFbaDH1VoWR50Xn5SH3TjXF0IjNf9n89Gz1wRcSMzb4x91X
         pZqtMWlW6o/WEWEJrur/bZsXEagQtdu7RNnI9fXl9cPVEHLDdrALC/yGSvHiiRA9q0B2
         JKXomqdYnYlr1QthrJh7bp9vqcXTB1cM90qT6+ItDcPipKDK1fcCmkWb3WjRrcMcJ0qa
         4u5Q==
X-Gm-Message-State: AOJu0Yy7TAlopF+eMKyajKXs4DY7r5iuOBCP3El56QpTYHASFYpLjFAV
	xqnAkNMWkcyZe9ctrbyoEtA=
X-Google-Smtp-Source: AGHT+IFaIQFOfM0bMaeI4serud4b8KRDdS3OzEyy+zUfPPYj5Ngzs2hnRW6TwKdT1K1ctFhjTpPMuA==
X-Received: by 2002:a05:6e02:2205:b0:35f:f5c7:cce3 with SMTP id j5-20020a056e02220500b0035ff5c7cce3mr1026468ilf.33.1704518845399;
        Fri, 05 Jan 2024 21:27:25 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001d364210979sm2248398plb.224.2024.01.05.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:27:24 -0800 (PST)
Date: Sat, 6 Jan 2024 14:27:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] PCI: controllers: tidy code up
Message-ID: <20240106052723.GC1227754@rocinante>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
 <fgnz47aqndjyn2y4u7jhdbdagtarwaasiekajavmxolpmsdu74@plhasdd5z55b>
 <TYBPR01MB534178CDECD712FE68F8A446D8662@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB534178CDECD712FE68F8A446D8662@TYBPR01MB5341.jpnprd01.prod.outlook.com>

Hello,

[...]
> > > Changes from v3:
> > > https://lore.kernel.org/linux-pci/20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com/
> > >  - Based on the latest pci.git / next branch. So, I modified the patch 1/6
> > >    for pci-layerscape.c.

Shimoda-san, don't use next when working on patches.  I might have told you
this once before, per the following. Something that is easy to forget.

  https://lore.kernel.org/all/20230828160712.GA2127814@rocinante/

This is the HEAD branch you should be using:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/

You should seldom use our "next" or the upstream "linux-next" when working
on a series you want to send to us.  That is, unless someone explicitly asks
you to do so or the changes you wish to submit to be applied are simple.

> > >  - Add Reviewed-by tag in the patch 4/6.
> > >  - Fix locations of read/write accessors by grouped for readability in
> > >    the patch 4/6.
> > 
> > The series has got all the Mani's acks. The last nitpick was fixed in
> > v4. No more comments at least from my side. What about merging it in
> > (before merge window v6.8 is opened)?
> 
> Serge, thank you for your comment.
> 
> Hi Krzysztof, Lorenzo, Bjorn, Mani,

Hi. Happy New Year 2024!

> Would you apply this patch series into pci.git / next branch?

We don't apply specific series like that.  Bjorn will collect other
branches, and then eventually update our "next", which then will be
picked up and the upstream "linux-next" will eventually include it.

> I confirmed that the patch series could be applied on the latest pci.git / next branch
[...]

I appreciate that.  However, I now need to resolve some conflicts to
apply this series.  See my comment above. :)

	Krzysztof

