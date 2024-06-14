Return-Path: <linux-pci+bounces-8824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98414908A42
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198D21F2B2E3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF320481D0;
	Fri, 14 Jun 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy6GrrbM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2428193099
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361609; cv=none; b=ocw29OE02KgZU07Kf2t+ZysF/ALV1fqdw9LS+AMQLYt8dQEtFIlqmJEWqyylSH2yX4jMlnSS3RD6worHeJMcxkdfQEPD3zihH+R8R9j5hj8upW0jzgXE+zB4mvE6ew4DVmqRg+wwUO33zFhmGgCkuZaIuKU122aRbUT8IhwKLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361609; c=relaxed/simple;
	bh=XiTuSSodj9pg9QTYkdEQtNHlW8N9RbfNXH96xUOQUUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AowBYQr+hk4SrUOYoT+MACuysPAt6Sgxp3AEWjp/CV+KmnAXtvkl7YHs0il17JPiEqXjYIbPJ+PpUeCOn+9c2jE5qIcRtYtyFyirLFQu/ehn4UEwoqVWIS7vXnF4OWhO/kyulhC9TrjqjFbr2PTOO/aZ9haP4mOasHX9Kcp/Up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy6GrrbM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so2394311e87.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718361606; x=1718966406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxrmcAmqwcrP+grfxMIpOgcKO6VGHmZZq9PuD254UVM=;
        b=Vy6GrrbMvcYz848ssIYAhILIkePX/NqdII6RwP33KSWozBDtT30u++5xLiVUl9lndj
         NmkuuDBnTN1ROWzWt3N22sz/jFitmtSUjE9cUh2xBRduUI5dxlcvBR2IdTFTrNFNYuLM
         9FYNsIy9L/Y4FBdzlRJu+dx43zpEAU5mQCu5DBFnjR7UdOmuu8bSMfQ6aYcGci9hi9Yt
         FxlHMuzMrfcxKM1LZG4E95fQ3F+kve/+kwLyxqbmLH5NSLqtFzR+oCpVloTGzMztEz9Y
         gPMk1tkDmzJE8d/MqPMXCWEzaeAgWRp9MNtpimAnnA4KakUjhyVPe+r8aeuDIJ65Vr3F
         eA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718361606; x=1718966406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxrmcAmqwcrP+grfxMIpOgcKO6VGHmZZq9PuD254UVM=;
        b=DKKv0vk9P+eTd+lons1tyS3VI/ppRElQdycq+brYA2zZNykuBI4zF2U2SgxYXeyVAe
         eLUhFJjOWbRsa2TzSHHceH3Q1V7PLKXF6T7kvpjsGzmS1ygk6v4NSalKJ7UfVbgWEKFQ
         iFp+5gehOb1pU4yC11Pl0sNkfh94GnXBrG8j9NrtaiCjhA1LfXMfNOGzN/1HvUKiNqxj
         jQH9Lw7iZtZw2Z4XGcEVogs5z8HRKdUgL7gS8jzo/RaaT24aA3i8g72sl7TK027gur+f
         aSW38VZnfqvufYx2dTTiCBkEPavKm+4Y0/JEJx1CBfTh3RKo6fJ5DNs5WuypSy7fT4j0
         Ng/A==
X-Forwarded-Encrypted: i=1; AJvYcCVb8eefaz5KH9tBAKf68uhZAAFabeVPYJiPxNuCDoaH/dbvTaO0LY4wyuRmO9Y0gtIpjg3T6+Vs3/qAy2JRqwjLjUCUZDD/j62g
X-Gm-Message-State: AOJu0YyOm6Tt4o4E5WZcj5StnlhZYOn7RVnUwUg9rnV4F1MQGG5JleK3
	c+6lW7E7xQhatHwrVTdzSeJGSWvFhEo0QepkAGaINdUAQbs+kc/O
X-Google-Smtp-Source: AGHT+IHvYv8Pwhx6F2EbHrCEAJGd4ShvTE68z9v8eZMZG7bB60LmflDk9peTT5ifq7BYWP7/m9acWg==
X-Received: by 2002:a19:ca06:0:b0:52c:891f:d732 with SMTP id 2adb3069b0e04-52ca6e97b18mr1250561e87.56.1718361605538;
        Fri, 14 Jun 2024 03:40:05 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282593esm468933e87.44.2024.06.14.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:40:05 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:40:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>, 
	manivannan.sadhasivam@linaro.org
Cc: Sergey.Semin@baikalelectronics.ru, apais@linux.microsoft.com, 
	bboscaccy@linux.microsoft.com, code@tyhicks.com, jingoohan1@gmail.com, 
	linux-pci@vger.kernel.org, okaya@kernel.org, robh@kernel.org, srivatsa@csail.mit.edu, 
	tballasi@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Message-ID: <vw2dla7vlovnuaxqxeslpfqwg3oqvi3673ps4uaj7pvadlyazy@sfbfpb7z2wba>
References: <20240612060743.GE2645@thinkpad>
 <20240613224747.545908-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613224747.545908-1-shyamsaini@linux.microsoft.com>

Hi Shyam

On Thu, Jun 13, 2024 at 03:47:47PM -0700, Shyam Saini wrote:
> Hi Manivannan,
> 
> >> Before this change, the dwc PCIe driver configures only 1 ATU region,
> >> which is sufficient for the devices with PCIe memory <= 4GB. However,
> >> the driver probe fails when device uses more than 4GB of pcie memory.
> >> 
> > Something is not clear... This commit message implies that the driver used to
> > work on your hardware (you haven't mentioned which one it is) and broken by the
> > commit from Sergey.
> 
> sorry for any confusion, the driver use to work in v5.10 kernel, with v6.0 kernel it
> fails to probe with following messages:
> layerscape-pcie xx00000.pcie: Failed to set MEM range ...
> layerscape-pcie: probe of xx00000.pcie failed with error -22
> 
> By tracing code, I found that the probe was failing on [1] this check,
> which was added in [2] upstream commit from Serge and finally, the ATU upper bound limit was
> set to 4G in [3] commit
> 
> pci driver probe succeeds either when
>          1) I remove [1] check
>          2) or by setting the ATU limit to the size of Mem64 range (my original patch [4])
> 
> > As per Sergey's commit, we auto detect the dw_pcie::region_limit. If the IP is <
> > 4.60, then the limit is 4G, otherwise depends on CX_ATU_MAX_REGION_SIZE set in
> > hw.
> 

> I couldn't find any reference of CX_ATU_MAX_REGION_SIZE in my PCIe TRM, perhaps because it
> is older than v4.60

Please find the line containing "iATU: unroll " in the boot log and
copy it here. Also please provide a content of the dw_pcie::version
field _after_ the dw_pcie_version_detect() method is executed.

> 
> > So if your IP is < 4.60, you cannot map > 4GB of outbound memory anyway. But if
> > it is > 4.60, you shouldn't see the failure that you reported for > 4G space
> > (well you can see the failure if the limit is less than the region size). In the
> > previous thread you mentioned that dw_pcie::region_limit is set to 4G. So how
> > come your driver was working previously?
> 

> The PCIe IP is from Synopsys and is older than 4.60,

If you know what the actual IP-core version is and it's older than
4.70a, then it's better to pre-define the version in the
drivers/pci/controller/dwc/pci-layerscape.c probe procedure (like it's
done in drivers/pci/controller/dwc/pci-keystone.c,
drivers/pci/controller/dwc/pcie-bt1.c).

> the board is from Freescale LX2
> family.

I failed to find the LX2 PCIe controller support in the
drivers/pci/controller/dwc/pci-layerscape.c driver. AFAICS the
drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c driver is responsible
for working with the LX2 PCIe host. Am I missing something?

Anyway I've checked all the DT-nodes defined for the Freescale Layerscape
PCIe host controllers. None of them have the PCIe ranges defined with
the window size greater than 4G (actually all of them of the 1G size).
So the next question is: what DT source have you been using on your
platform and what is the DT-node defined for the PCIe host controller
in there?

> The board uses drivers/pci/controller/dwc/pci-layerscape.c driver
> Given PCIe IP is older than 4.60, I am not sure why it was working earlier for a memory range larger than 4G
> Highly appreciate your guidance and help on this.

It has been working earlier because the kernel 5.10 didn't have
PCI ranges check for not exceeding the iATU regions maximum limit.

But once again, the DW PCIe Root-port driver has been designed to 
allocate a _single_ iATU region for each PCIe memory ranges. Thus if the
ranges exceeds the maximum limit, the mapping won't work for the
addresses greater than the maximum limit. I've already explained it
here:
https://lore.kernel.org/linux-pci/hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv

Moreover the IP-core databook not only explicitly prohibits to define the iATU
ranges greater than 4GB on the DW PCIe device older than 4.60a (text
from v4.21a databook), but has more strict constraint of the regions
not crossing the 4GB boundary:
"The upper 32 bits of the Target Address register always forms the
upper 32 bits of the translated address because:
■ The maximum region size is 4 GB.
■ A region must not cross a 4 GB boundary."

(It's obvious though since the iATU Limit Address register is of the
32-bit size on the old controllers.)

So you either need to allocate several iATU regions to cover the
requested PCIe ranges, or fix the PCIe controller DT-node to having the
ranges not exceeding the maximum limit.

-Serge(y)

> 
> Best regards,
> Shyam
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware.c?h=v6.10-rc3#n480
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/controller/dwc?h=v6.10-rc3&id=edf408b946d37cc70fbf0db6ab85bbf67dae1894
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/controller/dwc?h=v6.10-rc3&id=89473aa9ab261948ed13b16effe841a675efed77
> [4] https://lore.kernel.org/linux-pci/20240523001046.1413579-1-shyamsaini@linux.microsoft.com/
> 
> 
> 
> 

