Return-Path: <linux-pci+bounces-698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611880AADC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AA8281485
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A533984B;
	Fri,  8 Dec 2023 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="NvkN3NyB"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82911D
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:35:59 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 47DF428C099; Fri,  8 Dec 2023 18:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702056958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qh76SJbd3tGbAJL0ZLr8gcPnPaf3KSUICRLJyZMoM0=;
	b=NvkN3NyBkGKm/Vqjc2+z4GxPtioz19QgNK+yQ+3YDHDRIFtKw1McSqCPG81Jr5RzdSSJcj
	bQyRo1rbylBV8mke7ZML1S8tVKiXH37DAxlw1Zkrlhx3ZVxjwjfm+WVLjdmk83CXp8NTIv
	rMGOzLgMhhb2d/4AqRwfboZIndX2Skc=
Date: Fri, 8 Dec 2023 18:35:58 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 05/15] pciutils-pcilmr: Add margining process functions
Message-ID: <mj+md-20231208.173154.29528.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-6-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-6-n.proshkin@yadro.com>

> +  if (msec < 0)
> +  {
> +    errno = EINVAL;
> +    return -1;
> +  }
[...]

Please follow the indentation style of the rest of pciutils.

> +union margin_payload {
> +  unsigned int payload : 8;
> +
> +  struct caps {
> +    bool volt_support : 1;
> +    bool ind_up_down_volt : 1;
> +    bool ind_left_right_tim : 1;
> +    bool sample_report_method : 1;
> +    bool ind_error_sampler : 1;
> +  } caps;
> +
> +  unsigned int timing_steps : 6;
> +  unsigned int voltage_steps : 7;
> +  unsigned int offset : 7;
> +  unsigned int max_lanes : 5;
> +  unsigned int sample_rate : 6;
> +
> +  struct step_resp {
> +    unsigned int err_count : 6;
> +    unsigned int status : 2;
> +  } step_resp;
> +
> +  struct step_tim {
> +    unsigned int steps : 6;
> +    bool go_left : 1;
> +  } step_tim;
> +
> +  struct step_volt {
> +    unsigned int steps : 7;
> +    bool go_down : 1;
> +  } step_volt;
> +
> +} __attribute__((packed));

Please do not assume that every compiler used to compile the pciutils supports
GCC extensions. See lib/sysdep.h for how we handle such things.

Also, I am not sure that bit fields are good idea: they save a little data
space, but they expand code.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

