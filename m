Return-Path: <linux-pci+bounces-9407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0991C4D1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AC61F2464A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA7BA53;
	Fri, 28 Jun 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXM8kzYx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479091C230B
	for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595640; cv=none; b=UmS52gkR1eYaO1wplrrTndQwm/SYmGHmtcQTAwNiHM7IXEyLFVt1CGOvv+D5+KHXp8u24ZYAjH04MK45cBsXCHjYmgg4b+XZWA8VCh/yP9ydjb+5C7C7dk26qvxEsclXJuU0XCo4ILhL1gC7VjCYOgPvKCUEK112alwH9kwaO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595640; c=relaxed/simple;
	bh=SQXuwq97ZO59fZLiHkJDM7qvdRoXKHXTUyGbDbOq2H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT3i0aqzqY5IyDvgn2YsbVZ1jh4n86Ln6bzwI8t+ju7UkrdKwUyICFlPQ8H0CHMUBm5+HVvWU8rSqjZNEu1Oh+WUEoelfXAhcsl3YUCsl754MJh5iQ4hza+PBjR2u0p0wVvxxPa6JA4Nfv5G8WUtjaQZ8EBLlRAbqo3gzjAcLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXM8kzYx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso872084e87.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2024 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595636; x=1720200436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ma/sXk2cFj+hLiGVt8h/Rt2oXLFVCkBnrE9YKLXQuiU=;
        b=QXM8kzYxFm2Toi8ZmCiLg8vWr7LTY/cy953tfh+DjgMNtQ7EeMY8PPdLmCORbaDcwf
         V3W+cnuJiL42ZJ6dXBZrflS8cQ8oU0/7gMC/PQd/iXOi4O1Nb54ALXtkXd5nFhQQMMIC
         UWqlz58HXX7Hh6/ImOtrfsyuzORGD4xlqwaRutxO9hOnb0z9tuG/CQrVMi63uyR3St+G
         SzClQ9RIdFyDTtfL27YFer97ZxX2lxlaCoVAnK5FvisU+vgO64zWE/ZXaha59ebaGRep
         Itlo6GDn0KMAc2rl+bOmww1NVbVz26Rgp3NztivSj4t8iigiW/LWnhtRHc5rEVU+gJTR
         B/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595636; x=1720200436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma/sXk2cFj+hLiGVt8h/Rt2oXLFVCkBnrE9YKLXQuiU=;
        b=cQpPKd3CqToQv8eO7CeSH9rwP09UHJFADeEE5jycVw1hyKvCW//LhIMUWYtrRWtDvt
         ooJYEPKCWFNTpxyUEInny35gkFF/YvsT9YeKs3QijV7nxn9B/XIf6bFZWaUEVFjiNNGT
         B5mwIK1KnSYNZ5O9OfJkal9ieJGQIUvR4+C6XstDmUAJ471RiYx6hFm0+/DyXkDXqqcK
         +wuKSTNknmfwNYzCOI0JDlPUVMo6Wz5Y45mpf5omDezPA64PraNIZ2Tuik3t8i5xOKqP
         ulmanPGb4xKoovN8qI9lXE5FRPf3208pt6lg6/fNIDIp25qbMoAMOo7GXeFtezJYArtw
         L9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrlNJhj2apsqEL/iYcmni+aAM3Ks9v7zZ6Il9qAIH9Y4hOXX0qWGSJVnbWtAtX2mlpNAme3i6OS4ZvgxjuMOHauCQRSh+9RvZ+
X-Gm-Message-State: AOJu0YxyLGq3fhOwqN8JpUzGrhMPssV/ApWgyZq8E2dJ/P+m5d+Q7658
	1hSIhace3pPWFH5iJG9iCI2ZOy9lhGU4Y863UzmIJEaObqTgCZy/
X-Google-Smtp-Source: AGHT+IEJDirRd9Xde8qT++1JsUslPYfve5/QG+TpFhLPOg8gtIQB+azguuA9K+pKO2u/3nO0Sn1cqw==
X-Received: by 2002:ac2:53a8:0:b0:52c:c174:4bc3 with SMTP id 2adb3069b0e04-52ce064ecf0mr10210855e87.35.1719595636016;
        Fri, 28 Jun 2024 10:27:16 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b295sm331889e87.274.2024.06.28.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:27:15 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:27:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Sergey.Semin@baikalelectronics.ru, apais@linux.microsoft.com, 
	bboscaccy@linux.microsoft.com, code@tyhicks.com, jingoohan1@gmail.com, 
	linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org, okaya@kernel.org, 
	robh@kernel.org, srivatsa@csail.mit.edu, tballasi@linux.microsoft.com, 
	vijayb@linux.microsoft.com
Subject: Re: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Message-ID: <m6kg3pgxt3itx446kwznjlfuzbkuslcrbu3ie5af64iqwuhnkg@scabtzo3x2w2>
References: <vw2dla7vlovnuaxqxeslpfqwg3oqvi3673ps4uaj7pvadlyazy@sfbfpb7z2wba>
 <20240626082627.1460912-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626082627.1460912-1-shyamsaini@linux.microsoft.com>

On Wed, Jun 26, 2024 at 01:26:27AM -0700, Shyam Saini wrote:
> Hi Serge,
> 
> Apologies for delayed response.
> 
> > > Hi Manivannan,
> > > 
> > > >> Before this change, the dwc PCIe driver configures only 1 ATU region,
> > > >> which is sufficient for the devices with PCIe memory <= 4GB. However,
> > > >> the driver probe fails when device uses more than 4GB of pcie memory.
> > > >> 
> > > > Something is not clear... This commit message implies that the driver used to
> > > > work on your hardware (you haven't mentioned which one it is) and broken by the
> > > > commit from Sergey.
> > > 
> > > sorry for any confusion, the driver use to work in v5.10 kernel, with v6.0 kernel it
> > > fails to probe with following messages:
> > > layerscape-pcie xx00000.pcie: Failed to set MEM range ...
> > > layerscape-pcie: probe of xx00000.pcie failed with error -22
> > > 
> > > By tracing code, I found that the probe was failing on [1] this check,
> > > which was added in [2] upstream commit from Serge and finally, the ATU upper bound limit was
> > > set to 4G in [3] commit
> > > 
> > > pci driver probe succeeds either when
> > >          1) I remove [1] check
> > >          2) or by setting the ATU limit to the size of Mem64 range (my original patch [4])
> > > 
> > > > As per Sergey's commit, we auto detect the dw_pcie::region_limit. If the IP is <
> > > > 4.60, then the limit is 4G, otherwise depends on CX_ATU_MAX_REGION_SIZE set in
> > > > hw.
> > > 
> > 
> > > I couldn't find any reference of CX_ATU_MAX_REGION_SIZE in my PCIe TRM, perhaps because it
> > > is older than v4.60
> > 
> > Please find the line containing "iATU: unroll " in the boot log and
> 

> layerscape-pcie xx00000.pcie: iATU: unroll F, 256 ob, 24 ib, align 4K, limit 4G

Omg, 256 outbound iATU regions. It's at most _1TB_ PCIe memory
mapping. The hardware engineers much have thoroughly considered all
the possible controller use-cases.)

> 
> > copy it here. Also please provide a content of the dw_pcie::version
> > field _after_ the dw_pcie_version_detect() method is executed.

> version is set as 0
> 
> i see that my driver always has [1] max = 0
> While I am awaiting official info about CX_ATU_MAX_REGION_SIZE, but I think CX_ATU_MAX_REGION_SIZE may not exist

It's likely so. The parameter was introduced in IP-core v4.60a. Based
on that and not having the PCIE_VERSION_NUMBER_OFF register your
IP-core must be older than 4.60a.

> 
> > > 
> > > > So if your IP is < 4.60, you cannot map > 4GB of outbound memory anyway. But if
> > > > it is > 4.60, you shouldn't see the failure that you reported for > 4G space
> > > > (well you can see the failure if the limit is less than the region size). In the
> > > > previous thread you mentioned that dw_pcie::region_limit is set to 4G. So how
> > > > come your driver was working previously?
> > > 
> > 
> > > The PCIe IP is from Synopsys and is older than 4.60,
> > 
> > If you know what the actual IP-core version is and it's older than
> > 4.70a, then it's better to pre-define the version in the
> > drivers/pci/controller/dwc/pci-layerscape.c probe procedure (like it's
> > done in drivers/pci/controller/dwc/pci-keystone.c,
> > drivers/pci/controller/dwc/pcie-bt1.c).
> 

> sure, I will look into that

Great! Thanks.

> 
> > > the board is from Freescale LX2
> > > family.
> > 
> > I failed to find the LX2 PCIe controller support in the
> > drivers/pci/controller/dwc/pci-layerscape.c driver. AFAICS the
> > drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c driver is responsible
> > for working with the LX2 PCIe host. Am I missing something?
> 
> driver is drivers/pci/controller/dwc/pci-layerscape.c
> device-tree compatible string is "fsl,ls2088a-pcie"

Got it.

> 
> > Anyway I've checked all the DT-nodes defined for the Freescale Layerscape
> > PCIe host controllers. None of them have the PCIe ranges defined with
> > the window size greater than 4G (actually all of them of the 1G size).
> > So the next question is: what DT source have you been using on your
> > platform and what is the DT-node defined for the PCIe host controller
> > in there?
> 
> It is internal and custom pcie range. It is not present in any upstream boards dts files.
> 
> > > The board uses drivers/pci/controller/dwc/pci-layerscape.c driver
> > > Given PCIe IP is older than 4.60, I am not sure why it was working earlier for a memory range larger than 4G
> > > Highly appreciate your guidance and help on this.
> > 
> > It has been working earlier because the kernel 5.10 didn't have
> > PCI ranges check for not exceeding the iATU regions maximum limit.
> 
> true
> 
> > But once again, the DW PCIe Root-port driver has been designed to 
> > allocate a _single_ iATU region for each PCIe memory ranges. Thus if the
> > ranges exceeds the maximum limit, the mapping won't work for the
> > addresses greater than the maximum limit. I've already explained it
> > here:
> > https://lore.kernel.org/linux-pci/hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv
> > 
> > Moreover the IP-core databook not only explicitly prohibits to define the iATU
> > ranges greater than 4GB on the DW PCIe device older than 4.60a (text
> > from v4.21a databook), but has more strict constraint of the regions
> > not crossing the 4GB boundary:
> > "The upper 32 bits of the Target Address register always forms the
> > upper 32 bits of the translated address because:
> > ■ The maximum region size is 4 GB.
> > ■ A region must not cross a 4 GB boundary."
> > 
> > (It's obvious though since the iATU Limit Address register is of the
> > 32-bit size on the old controllers.)
> > 
> > So you either need to allocate several iATU regions to cover the
> > requested PCIe ranges, or fix the PCIe controller DT-node to having the
> > ranges not exceeding the maximum limit.
> 

> we have requirement for memory ranmge greater than 4G, so it seems range can't be changed.
> 
> I am looking into your other suggestions, highly appreciate your feedback

Ok. Thanks.

-Serge(y)

> 
> Thanks,
> Shyam
> 
> [1] https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/pci/controller/dwc/pcie-designware.c#L832
> 

