Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9EA30775E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhA1NpT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 08:45:19 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45540 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhA1NpS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 08:45:18 -0500
Received: by mail-wr1-f44.google.com with SMTP id m13so5434924wro.12;
        Thu, 28 Jan 2021 05:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5L/q64E5zQnOnsRdaZ3AFP3jIIvq5gFQ6Mm7DceN5AY=;
        b=n3FIVIg+hxpFYFKsblUZ+k9XwfNjfc0WAoSDl1okNHTVxY767LT2Bp6OvPiDU+wnKj
         oO7oviHDzHMGK0JszXNuSD8UvjQm9CeWdLnj5BBsmanoA7nrgLcpjN906DGzIroNVULu
         JBCFIfMBzVkRyRWBRXkUt8TbUnvlFUpCB/0LYA33fXZ+S/VPw/W3l1hRLfAUS1/PahxB
         olR2zwu5j1y3x7OccbH1FPa4wv1edHTWGlEVH1901ooRYVuimHKzbV+bPNQs+zuuc0lG
         vJfizNCi+kGxUqFrnzPd5ELuoBZL8QEqLfw1p+MevGUIqeuJD4jaQtzI6Whwp3kINghI
         Nf3Q==
X-Gm-Message-State: AOAM532hBjVvdNcrq68YiEGC0z6jh6V2Ux+SCQjlgWNLGxQ/EDljevas
        Guc5hZIw+W8YStFiuqeM/kdPYdDPkkVz6kxH
X-Google-Smtp-Source: ABdhPJygC+zgGvU4QWQf1g9gsoO94MvNzy2kjnFGMjaMUF7o2rgDxP+DYC8yhFb41oSjUkzbWCzAaw==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr16493158wrl.249.1611841475365;
        Thu, 28 Jan 2021 05:44:35 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b3sm6959838wme.32.2021.01.28.05.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:44:34 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:44:33 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Victor Ding <victording@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH] PCI/ASPM: Disable ASPM when save/restore PCI state
Message-ID: <YBK/wa2AuwYJ/zTp@rocinante>
References: <20210128122311.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128122311.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Victor,

Thank you for working on this!

[...]
>  	i = pci_save_pcie_state(dev);
>  	if (i != 0)
> -		return i;
> +		goto Exit;
>  
>  	i = pci_save_pcix_state(dev);
>  	if (i != 0)
> -		return i;
> +		goto Exit;
[...]
> +Exit:
> +	pcie_restore_aspm_control(dev);
> +	return i;
>  }
[...]

A silly thing, but the goto labels are customary lower-case.

Nonetheless, this is probably something that can be corrected when
applying, so that you don't need to unnecessarily send a new version
(unless you will eventually following other reviews, then don't forget
about it).

Krzysztof
