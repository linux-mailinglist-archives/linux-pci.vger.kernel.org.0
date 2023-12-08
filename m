Return-Path: <linux-pci+bounces-704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2A80AB07
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBAB20C1F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5BD1DFDB;
	Fri,  8 Dec 2023 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="B93aBegn"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D48F4
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:44:24 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 3E3B128C09B; Fri,  8 Dec 2023 18:44:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702057463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSNAzXN3XYUcl9pUN+r0/frZXidnnzk8NBBId9SxCRw=;
	b=B93aBegnKBSK3DXE1PyXdKpNYT4Hpfy/VhpqSKoFvkYTIwnbDfBF0wnT1zZVNHeeHv8Asw
	/9BS6rjGOX4fBKok4U62NmkF69ISMFSFw2oI6GSpFJ2V9+lUGOwlqydqht8SV5DLqQD//q
	O7x86iu8lBwcy1Mb5icDYkuE62UUgrI=
Date: Fri, 8 Dec 2023 18:44:23 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 13/15] pciutils-pcilmr: Add option to save margining
 results in csv form
Message-ID: <mj+md-20231208.174204.32403.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-14-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-14-n.proshkin@yadro.com>

> +  char timestamp[64];
> +  time_t tim = time(NULL);
> +  strftime(timestamp, 64, "%FT%H.%M.%S", gmtime(&tim));

Please use sizeof(timestamp) to make the code more robust.

> +  char *path = (char *)malloc((strlen(dir) + 128) * sizeof(*path));

Please use xmalloc().

> +    sprintf(path, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,

Please avoid plain sprintf() everywhere and use snprintf() instead.

> +    if (!csv)
> +    {
> +      printf("Error while saving %s\n", path);
> +      free(path);
> +      return;
> +    }

We have die(...) for that.

> +    for (uint8_t j = 0; j < recv->lanes_n; j++)

It's better to use plain integer types ("int" or "unsigned int") for
loop control variables.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

