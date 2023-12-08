Return-Path: <linux-pci+bounces-699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE980AAE3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443D41F210E6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FBD39FE6;
	Fri,  8 Dec 2023 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="mK5U6FZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99610EF
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:37:15 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 6A59D28C099; Fri,  8 Dec 2023 18:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702057034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYA26H6TrPel9AyfsmtvJriBxNbsxXk713FTns0+jSA=;
	b=mK5U6FZeTrxxgrdSXZ2S20SjjTDtANGzW1iEiDO4m49QqPczJw+78KQDo1ZFoh1E+Gq/gu
	arNsRWYjyGTwT7hqZQniG8Rc1YgvDywEm+8i18ZrpVESq1HGiTsr+IVd5YTSpZoHF0gFH9
	PzhHAif3jK/ctRHGKface6ThjdjGp4E=
Date: Fri, 8 Dec 2023 18:37:14 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 06/15] pciutils-pcilmr: Add logging functions for
 margining
Message-ID: <mj+md-20231208.173606.30601.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-7-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-7-n.proshkin@yadro.com>

>  #include "margin.h"
> +#include "margin_log.h"

Is it useful to have multiple include files? It could be more readable to have
a single include file declaring functions from all modules (similar to lib/internal.h
for libpci).

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

