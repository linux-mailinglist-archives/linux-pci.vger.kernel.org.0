Return-Path: <linux-pci+bounces-11468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC694B4E4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 04:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1176728418F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 02:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624F9460;
	Thu,  8 Aug 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k5o5+I7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB7DF78;
	Thu,  8 Aug 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083196; cv=none; b=L4TvW+ZTJN1ZX9SYPGq/9twYpE0mU7r7oOAowzh8u2vaHOMbJDv65H2VZLzDscrc2idr7Z658gYPNOKArv1zQQ/0zz/WSHu5u07Mmit8axQ8gLM9Zkbf5X7gI+zSs/lIfZUxKmMfa+xk+SPqlctgqzAkj35Ucy6jJNrO1lB1vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083196; c=relaxed/simple;
	bh=tyD5vs3mOIkUVXbSmuXmJ+XPJxiVZS225LbV3CxUg8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ao90IcocohzVnrqyu9x4+BhQBIJLfL0MM/rP77cI9913zS/SAslHntpMrXBlf7JMvWXseC5Fo+J/hMCxip/IRAfXouZeYsLLyiCAZXknNNcWV8xiJi/oWlM/Z7V6B7i688q/kGTWSpRG1ZPVeW/Ic9qT5nkM4a6iYzNPOKOguuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k5o5+I7a; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=0uUS1mbrT0GFBr5kKfwam9cXdDE28lHd2w/B3ulUFSM=;
	b=k5o5+I7a6LKDXhG9LDIY2L51oItGEvTvbKQ6qc2QODQa9jj3acA/cW7Wgvj2M9
	qJQNFhFd2FEwSAS4P+jQWG0TkdGZjcDDIlCxT1MvDVuu6/TpGRhvslRGE1zdZMfq
	TfMrB1tf5MPMke5mEnwLVcIVezIJ2Nxkxar2pqnRXq5w4=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wD3XzOXKbRmg4gKGQ--.53944S2;
	Thu, 08 Aug 2024 10:12:40 +0800 (CST)
From: 412574090@163.com
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	xiongxin@kylinos.cn
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Date: Thu,  8 Aug 2024 10:12:39 +0800
Message-Id: <20240808021239.24428-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806175905.GA70868@bhelgaas>
References: <20240806175905.GA70868@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzOXKbRmg4gKGQ--.53944S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4kCF1xArWrKrykWF18AFb_yoW8ZFWxpr
	s8ZF1jyr4UJanF93Z3Awn8KryjqwnayFnag3yagrnIyFy3Gw1xK3Z29rZIka4SqrZ7tF1a
	qrn2qryrCayjvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRg18QUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbivh01AGV4Kc49GwAAsK

> On Tue, Aug 06, 2024 at 10:27:46AM +0800, 412574090@163.com wrote:
> > From: weiyufeng <weiyufeng@kylinos.cn>
> > 
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
>
> It probably makes sense to add this (with the corrections noted by
> Ilpo), but I *would* like to see where it's used.
>
> I asked a similar question at
> https://lore.kernel.org/all/20230531095713.293229-1-ben.dooks@codethink.co.uk/
> when we added PCI_EXT_CAP_ID_PL_32GT, but never got a specific
> response.  I don't really want to end up with drivers doing their own
> thing if it's something that could be done in the PCI core and shared.
>
PCI_EXT_CAP_ID_PL_32GT and PCI_EXT_CAP_ID_PL_64GT have not used now,but 
PCI_EXT_CAP_ID_PL_16GT have usage example,in drivers/pci/controller/dwc/pcie-tegra194.c
function config_gen3_gen4_eq_presets():

offset = dw_pcie_find_ext_capability(pci,
				     PCI_EXT_CAP_ID_PL_16GT) +
		PCI_PL_16GT_LE_CTRL;

PCI_EXT_CAP_ID_PL_32GT and PCI_EXT_CAP_ID_PL_64GT could be used while need to
get this similar attribute。

> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> >  
> > -- 
> > 2.25.1
> > 
--
Thanks,

weiyufeng


