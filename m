Return-Path: <linux-pci+bounces-688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C480A71E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF33AB207C1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B815F23766;
	Fri,  8 Dec 2023 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="GeLM7WdO"
X-Original-To: linux-pci@vger.kernel.org
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 07:15:06 PST
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42F1706
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 07:15:06 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 4D93828C08C; Fri,  8 Dec 2023 16:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702048153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYSw++vtWb+xI37Ld5OEfkW4itY5r810Zg/FQXBr73g=;
	b=GeLM7WdO7BTfxSGm1xFVJ8/vbVqN+vJMwhqFgCi4/7JXcyaTLGVIQpdug9xfaQZ/b9MLlm
	uB8g5/JHGQ4PFk5loIAOZR6lF+yWPRwSxXNTsbQQIqNncOEVDbevRf5NRhGty90YOc2PjU
	66u2X0l3O6XIREZaaSU4l4BkiI5B3K4=
Date: Fri, 8 Dec 2023 16:09:13 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lspci: Add PCIe 6.0 data rate (64 GT/s) also to
 LnkCap2
Message-ID: <mj+md-20231208.150854.91276.nikam@ucw.cz>
References: <20231208101307.2566-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208101307.2566-1-ilpo.jarvinen@linux.intel.com>

Hello!

> While commit 5bdf63b6b1bc ("lspci: Add PCIe 6.0 data rate (64 GT/s)
> support") added 64 GT/s support to some registers, LnkCap2 Supported
> Link Speeds Vector was not included.
> 
> Add PCIe 6.0 data rate bit check also into
> cap_express_link2_speed_cap().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

