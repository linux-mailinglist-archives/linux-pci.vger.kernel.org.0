Return-Path: <linux-pci+bounces-11469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92194B515
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 04:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9A1F22905
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D9CA6F;
	Thu,  8 Aug 2024 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H6v6Glzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910E2A1C7;
	Thu,  8 Aug 2024 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084371; cv=none; b=DnKH4hGyEB2JgU32+sOOBGDQMeUwyL1qPZ2rmgYdp4+y+gTSbOrvFsoZ7jC8Nk+gn6GZ2ugE5ldhnx8fXMd807QIEm/Xz9C7g7Crd3uufvZwU23vFg0RBC6BncF9MuUaqSQS5UEO0OUkdRJTLoe/99MKdSdnCa9A52OFPeEbSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084371; c=relaxed/simple;
	bh=jdULBYPjo3z/xu+OPeGcPx0L0vn0k5DgGnj155pa/hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSNOQw49HbX7W4Vi5ffKw2T+qtjHOh3Em3AYzwDM7qga9McrkB1w7pLVTpVExX/FinaoWAoDvPDqh9sRheiYm/omArjOC8pDxHxMBRk163RpsocXxagOi3PgyeapqiOWNo4+M++pDMavoIFIJAon8coS42U071q9B1PO8mn80Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H6v6Glzx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=vgv2QECi/fHr16QDLzIQTR8lb9Mi+UvA/Ge68OotDjA=;
	b=H6v6GlzxXUgh6DDgyeN7AsjOdao8aAiwQ/UCBC6G+CNsoTO/XPRAjSVeuFTaRZ
	VcCz7yjs1/Fosf79t3nrCunDTmc0at0FKBqfqMLrqfhT53vfkQ4+oVXzKlkw1QOw
	edtIBT8xie7omh5GSgSiESyNAP0b704+5NpxdWRiaVY60=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnN+sxLrRmReqHAQ--.38948S2;
	Thu, 08 Aug 2024 10:32:18 +0800 (CST)
From: 412574090@163.com
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	xiongxin@kylinos.cn
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Date: Thu,  8 Aug 2024 10:32:17 +0800
Message-Id: <20240808023217.25673-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <04db5243-f522-00b4-ae12-991da3e67513@linux.intel.com>
References: <04db5243-f522-00b4-ae12-991da3e67513@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN+sxLrRmReqHAQ--.38948S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKr4UJr47Xr48ZF18Kw47XFb_yoW8JrWDpr
	n3Xa13Cr47XF1q93Z7AwnxKryUX3WIqF1I93y2g3s3JFy3Gw1xKF1q93yaya43XrWktFWY
	vr9Fqw1rCayqvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRSJmbUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbivh01AGV4Kc49GwABsL

> On Tue, 6 Aug 2024, 412574090@163.com wrote:
>
> > From: weiyufeng <weiyufeng@kylinos.cn>
> 
> > PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capability
> > ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will want
> > this whilst doing Gen6 accesses.
> > 
> > Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> > ---
> >  include/uapi/linux/pci_regs.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 94c00996e633..cc875534dae1 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -741,6 +741,7 @@
> >  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> >  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> > +#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */

> These should be in numerical order.
In PCIe r6.0, PCI_EXT_CAP_ID_PL_64GT value is 0x31.

> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE

> This was not adapted??
PCIe r6.0, sec 7.7.7.1 have this definition。
--
Thanks,

weiyufeng


