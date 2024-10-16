Return-Path: <linux-pci+bounces-14612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D906B9A00C0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 07:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685371F216B2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788164CB5B;
	Wed, 16 Oct 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stc6EvRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54624879B;
	Wed, 16 Oct 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056794; cv=none; b=YodTedeD/KnDBv95+7+04IQ1Ajzs6kMXfee93/rbe3R4dls6jaBSU9a/IBuD5xTWoWoIC5+MFGvYSc5kHBTfk3eSoXPX9H7iQZiL64iGfrF7ex92Rk5a6B1zVx3J/SXtOsAolYXJpQx5Y6r8mmAinn9/lTyicmezOANbibU65wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056794; c=relaxed/simple;
	bh=AoSjNsfpPdnIXtUNgxQR+eI0bsnct7u6F++YsIzaBHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owq1U6KTm042guSpTmHIyI32O7DrktwgoKOEo29TDUumQwpozjpicvEa6EG72iQiZRc9L57NVvRkATMUYeZbwub0vtj0nt1b1nYvuHv+BaNw4oMu1vrvRe2vPNHmHHhJsI3hxoTCalP6BVbMdib/MdF89rIcNRzkTRxdnpgKGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stc6EvRy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e803a9f208so290502eaf.0;
        Tue, 15 Oct 2024 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729056792; x=1729661592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKu2Ceh01dypLNi8C+RFdakH7X0Vw/2sggeNZzBLIs0=;
        b=Stc6EvRydyOybRfUJ0t9NDp4W6TEnEPNAS7nJBXqfGxNsy4/QxjhSI/euwM9F7q+Fp
         cFp7VgO+bVs91FC4r6v0oGBui8iOrWIvpRd5mlwjZ05lTcwPKUN2DzPk1TlGWgE5dy5L
         EhKM6ptPMS318YhQntgRv+DfxsOnLHwFfphGPxceQMqxQvc6SeXFHH/j8B7J8yP7z8tG
         aDoacfU6jghNx1nUo99MxvMQb2t7BD2nLkrwcoKdgi8tgkH2c57W/MDAuDUWY7UAyAEm
         XRMTOtsh5n3U+ilcKoAfzf9NsnallX06iCskN8r3JpxwxYYrsa1PTtRX5lfIaRtgYlya
         UkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056792; x=1729661592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKu2Ceh01dypLNi8C+RFdakH7X0Vw/2sggeNZzBLIs0=;
        b=WWtX9srKQl8lab+tULzMkADXcG1xU2S5hOG79bomdLYv8MWWX8kUoCMKVovbabvlH7
         4TCbgYCuNFstoZp5kH0Y8wqXMUw3b2G/a5ASKTDYjQhcWDghCS1OrT8t3oYYLXZ59HmS
         3Ykokpkcd3Z14j4+8xuCHGwRjT8TnpzXCSQckzUYAUG0SbBVT6XtUY3I1gc/Yj/vmqst
         yDsRWvkpCRwAXhMa32UCgHthcz+5FKuNL0ZZOXbDoiZbcVQGhaLP13gZ/XsowEwgNOMo
         Mw2LRRSU1UGPuI6kJyOJRWWmSYogispVH1gbJQY73/fG3W82ReZruPc5Q4SLmj1UC6aj
         ofnw==
X-Forwarded-Encrypted: i=1; AJvYcCWs5bEQUfgTb+g4yBAjOslk/CW05MF9azQdSKLWOSURjb5HkuYmQacwsVeyj3CyUgH2tUrPU130RfU4@vger.kernel.org, AJvYcCX1P/jg6htICwK/hlBLuUgwgLqDn5G+tSD2un/mi8lY7Qr7Vbapdz4Np8BZKepnmsPKIAfMiErz9br0@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUbYkSiBgJGG0ad3RMya1IoKQPoVnMil5ycpU234cs7+wqwce
	lA3OF7vu5sG0dlcAnori133LTaQLK/zCGsaifhjQW/l2ghMP/PAFI+cxqNBOfZ8/D90qwDLrw06
	C+WSXeyT7cvUJzgNyhrggzNBA7/X+0A==
X-Google-Smtp-Source: AGHT+IEkQZzBHJtJxHZQGIJvL8lvgTVMwWVTuhLd+8QASyj6hAnhXQVhUnLzaKD51ziHx2eIZC/S2XUZWWBzWkxDaUQ=
X-Received: by 2002:a05:6870:1705:b0:259:8858:a330 with SMTP id
 586e51a60fabf-2886d88a53dmr9215880fac.22.1729056791853; Tue, 15 Oct 2024
 22:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121408.89890-1-dlemoal@kernel.org>
In-Reply-To: <20241011121408.89890-1-dlemoal@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 16 Oct 2024 11:02:55 +0530
Message-ID: <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
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

On Fri, 11 Oct 2024 at 17:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> This patch series fix the PCI address mapping handling of the Rockchip
> endpoint driver, refactor some of its code, improves link training and
> adds handling of the #PERST signal.
>
> This series is organized as follows:
>  - Patch 1 fixes the rockchip ATU programming
>  - Patch 2, 3 and 4 introduce small code improvments
>  - Patch 5 implements the .get_mem_map() operation to make the RK3399
>    endpoint controller driver fully functional with the new
>    pci_epc_mem_map() function
>  - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
>  - Patch 10 introduces the .stop() endpoint controller operation to
>    correctly disable the endpopint controller after use
>  - Patch 11 improves link training
>  - Patch 12 implements handling of the #PERST signal
>
> This patch series depends on the PCI endpoint core patches from the
> V5 series "Improve PCI memory mapping API". The patches were tested
> using a Pine Rockpro64 board used as an endpoint with the test endpoint
> function driver and a prototype nvme endpoint function driver.

Can we test this feature on Radxa Rock PI 4b hardware with an external
nvme card?

Thanks
-Anand

>
> Changes from v3:
>  - Addressed Mani's comments (see mailing list for details).
>  - Removed old patch 11 (dt-binding changes) and instead use in patch 12
>    the already defined reset_gpios property.
>  - Added patch 6
>  - Added review tags
>
> Changes from v2:
>  - Split the patch series
>  - Corrected patch 11 to add the missing "maxItem"
>
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
>
> Damien Le Moal (12):
>   PCI: rockchip-ep: Fix address translation unit programming
>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>   PCI: rockchip-ep: Implement the pci_epc_ops::get_mem_map() operation
>   PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>   PCI: rockchip-ep: Refactor endpoint link training enable
>   PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
>   PCI: rockchip-ep: Improve link training
>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
>
>  drivers/pci/controller/pcie-rockchip-ep.c   | 408 ++++++++++++++++----
>  drivers/pci/controller/pcie-rockchip-host.c |   4 +-
>  drivers/pci/controller/pcie-rockchip.c      |  21 +-
>  drivers/pci/controller/pcie-rockchip.h      |  24 +-
>  4 files changed, 370 insertions(+), 87 deletions(-)
>
> --
> 2.47.0
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

