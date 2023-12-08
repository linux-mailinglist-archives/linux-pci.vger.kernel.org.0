Return-Path: <linux-pci+bounces-696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520E80AAC9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF051F211DA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F733984B;
	Fri,  8 Dec 2023 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Ko1soBAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA18AD
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:30:03 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id F36F128C097; Fri,  8 Dec 2023 18:30:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702056601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luB/kE9ER8qvW08ThSbn6abbN6Hl4ViZUp73OSMNiHI=;
	b=Ko1soBASTSs/4hRmdKWfa9R0IVK36NmuJbxaXrGlH0Dn18nNsJPeAUvfSAD4nltgSHjzA0
	qz+AVVyEnigw5NFEbgo/oYVFIiEEbDAgbTb9Foy8eCUNZcx09w8VSOb10NtaXIJpawtBma
	U4a3L1Av8fgCDzfC369fBRmUXlHSG0E=
Date: Fri, 8 Dec 2023 18:30:01 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 04/15] pciutils-pcilmr: Add functions for device checking
 and preparations before main margining processes
Message-ID: <mj+md-20231208.172608.28110.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-5-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-5-n.proshkin@yadro.com>

Hello!

> -all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS)
> +all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a

Is there any advantage with building LMR as a library instead of linking all
the object files with the margining utility?

> --- /dev/null
> +++ b/lmr_lib/margin_hw.c
> @@ -0,0 +1,85 @@
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>

Generally: Please add a comment to every source file, which explains the
purpose of the file and contains a copyright notice. See existing files
for the recommeneded format.

> +  uint8_t down_type = pci_read_byte(down_port, PCI_HEADER_TYPE) & 0x7F;
> +  uint8_t down_sec = pci_read_byte(down_port, PCI_SECONDARY_BUS);
> +  uint8_t down_dir = (pci_read_word(down_port, cap->addr + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_TYPE) >> 4;

I would prefer using libpci types (u8, u32 etc.).

> +  if (!(down_sec == up_port->bus && down_type == 1 

Please avoid whitespace at the end of line.

> +bool margin_prep_dev(struct margin_dev *dev)
> +{
> +  struct pci_cap *pcie = pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);

What if it doesn't exist?

> diff --git a/lmr_lib/margin_hw.h b/lmr_lib/margin_hw.h
> new file mode 100644
> index 0000000..a436d4b
> --- /dev/null
> +++ b/lmr_lib/margin_hw.h
> @@ -0,0 +1,39 @@
> +#ifndef _MARGIN_HW_H
> +#define _MARGIN_HW_H
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "../lib/pci.h"

Please do not use relative paths to libpci header files.
Instead, supply proper include path to CC in the Makefile.

> +/*PCI Device wrapper for margining functions*/

Please surround "/*" and "*/" by spaces as in existing source files.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

