Return-Path: <linux-pci+bounces-14618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9439A025D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C182A1F246B6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931281B218C;
	Wed, 16 Oct 2024 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e979JBF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162F1B0F3E;
	Wed, 16 Oct 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063390; cv=none; b=ZDlutT4mM3Ger3RViT33ip2fw3rQSptxwixZWHQgPDknvDCH9G30b7IHUN2Zf+lzng4yLU5vxc87QEqILQVhI6ErWhwg/xqv7C+oZVax/rHHGHzTquA59tRhtVTYTJLetNjnPTEF+nLVznToOic/ktIEH1wiLsj8nGWTvzoOFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063390; c=relaxed/simple;
	bh=CeRE3z3lZdS4M1bt+JJBEe/bsjNSxG/aOxLIGUjGu+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa1Ed0vXsUoA5YOQ9hIeXIPdtliK0tWBuDDKn7V5h1Vw4WjNAsfe/3woC3kcr6UT/QS4HbqIkp5lDpU3qC8LA01OCpOWvH84x0i72g5ZeHI88is7AzG/2GZQsZBff8cqLoLf0l/EWRG6pxUyrh+OEoC479MNd2SAueosFyEAXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e979JBF7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277e6002b7dso1770014fac.1;
        Wed, 16 Oct 2024 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729063388; x=1729668188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wd8Ym5tSSwsBLwbiURSvOdqd3ghlmcVdmxI2I4tPA/M=;
        b=e979JBF7XjKBERWC1N1Qxm84tKZFSKMCXIkKmIEtsmn5wVuUFE+75TLge/0d6bJccU
         XSvBLC400EVsyl6V7xDHZMXviGUvYIcMLLyHx53sFncqzZlodVHUCh2X0ubx4wMa62S2
         1b5MOiF3pfKdgxuRoHkZ+ifTrPyF7i3GVvfbJYQv6HGGn0wSs5nVZH6XhNfTMzxlAQJ9
         lOIhzIWjAcGsfCAZKIyEix0qNL09fJPuF/nSDnWQXMe0cl/Sy4wlD5tO+qa2L9ktvSoM
         B+xQ5wybLrfAgztKWJ4RevPzdJIcHixA+odPki+2Wt7CIQrEL79kLmgFTGa+3NY5u05l
         gh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063388; x=1729668188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd8Ym5tSSwsBLwbiURSvOdqd3ghlmcVdmxI2I4tPA/M=;
        b=D65LWHWTRhcXRl6z7JPn7BPiR9UXJJk+GCKTzOydWhtE0yMew7KrNq1JZDmIXHTDFv
         idN7n0Y6fl/cWnWKwH8aKquU/PcOyLAb2YGmB+28u6FjPaYJAGO1BVX+wr8MM0JwTm8x
         0d2wI6Z44sWFytyieqi+eeak/CEm260LZfRdUU/RYUgqcpVgOYtDx3WDUAKHhbuvqd/5
         pLJOJsyagB5At1wM7q8mWEy5O5nVq4Ri+8wJY2O/Jkqzk4rRpWTewjgOYmM6aSTUa9az
         36EdPefCDgdqCZ1U1DR97lXTUKxeP6f9zZWw7PTnl53246IlRbZCZXA/Wj7FsHMKpHbH
         en5g==
X-Forwarded-Encrypted: i=1; AJvYcCW8rpzho5Tc73rKvcu1nQEmkz0atfFV5q6gYltqsxCDrwqTqyxJ1sunUtaZMIHGciTRmuCVMowYtT+D@vger.kernel.org, AJvYcCXHGnegWERV9IWuvan4IyS2go2Bqix8paGnkFGuq1NGZpLwGTJw10fjJn4HQYPvzJHO/Mlyoc50f9cS@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeF3Fs3mDF08RdI03EZPyYl+FFu8E9HcSeBVawqOA8WeQKC2Y
	D7k6Ld/2rlWGd42fECTMuaI06YqCX4Q4ZSgX2gfZ3cTcltB5VE20doXgZUlR3Q4uqKU0RmySF7t
	UPUEOzvRJUjX9ostzKVrT2errbmM=
X-Google-Smtp-Source: AGHT+IFIhDVUzESiMhhE/TlY7ASxMyIeK5VV3R4UKMzydpDPcQNVh9fJvlWSotSf20vztJje3Bo92Hxhu9h8zoCR9Hw=
X-Received: by 2002:a05:6871:2504:b0:288:eff4:49e4 with SMTP id
 586e51a60fabf-288eff44b5amr1179295fac.4.1729063388169; Wed, 16 Oct 2024
 00:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121408.89890-1-dlemoal@kernel.org> <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
 <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org>
In-Reply-To: <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 16 Oct 2024 12:52:51 +0530
Message-ID: <CANAwSgRDbCCridYMciq=xSDPV0qGhs-OhCJ_uniXFbp-yM5CcQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	Rick Wertenbroek <rick.wertenbroek@gmail.com>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

On Wed, 16 Oct 2024 at 11:45, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 10/16/24 2:32 PM, Anand Moon wrote:
> > Hi Damien,
> >
> > On Fri, 11 Oct 2024 at 17:55, Damien Le Moal <dlemoal@kernel.org> wrote:
> >>
> >> This patch series fix the PCI address mapping handling of the Rockchip
> >> endpoint driver, refactor some of its code, improves link training and
> >> adds handling of the #PERST signal.
> >>
> >> This series is organized as follows:
> >>  - Patch 1 fixes the rockchip ATU programming
> >>  - Patch 2, 3 and 4 introduce small code improvments
> >>  - Patch 5 implements the .get_mem_map() operation to make the RK3399
> >>    endpoint controller driver fully functional with the new
> >>    pci_epc_mem_map() function
> >>  - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
> >>  - Patch 10 introduces the .stop() endpoint controller operation to
> >>    correctly disable the endpopint controller after use
> >>  - Patch 11 improves link training
> >>  - Patch 12 implements handling of the #PERST signal
> >>
> >> This patch series depends on the PCI endpoint core patches from the
> >> V5 series "Improve PCI memory mapping API". The patches were tested
> >> using a Pine Rockpro64 board used as an endpoint with the test endpoint
> >> function driver and a prototype nvme endpoint function driver.
> >
> > Can we test this feature on Radxa Rock PI 4b hardware with an external
> > nvme card?
>
> This patch series is to fix the PCI controller operation in endpoint (EP) mode.
> If you only want to use an NVMe device connected to the board M.2 M-Key slot,
> these patches are not needed. If that board PCI controller does not work as a
> PCI host (RC mode), then these patches will not help.
>

Thanks for your inputs, I don't think my board supports this feature.

> --
> Damien Le Moal
> Western Digital Research

Thanks
-Anand

