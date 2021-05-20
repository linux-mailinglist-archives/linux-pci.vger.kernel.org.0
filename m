Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2664C38B45E
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhETQjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 12:39:03 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37517 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhETQjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 12:39:03 -0400
Received: by mail-ed1-f43.google.com with SMTP id g7so7993358edm.4;
        Thu, 20 May 2021 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhFIRCkOs81fMaxAYpodGS2wjOUuiCI5qY37aZo8prk=;
        b=paJHBuC02DD1NaG4qLKCqcv72RyFINn1psRzIrhztJX0jZgRc9221S4KXC8B8gePS8
         XSW0wESRC8WD+j+gN9ICCoeDbssF8gJ+pn7wHLXHWmPicYT0JDp7xoECB7dsLc9BiZAn
         KQutSv7Gf2HpBjrxLrNGlFZ5DXxSzgiNKoXdE9OGkKYKJXZcI0FeJqrJGoTiTBrL7GO1
         mUAd/ncKU1ZZRCyTSHvNGQKdMId2l/xJnhfms7bQgSxKsNol9WWOPXL2ET3xNay8udxo
         MXszzUwiks9a0dx0XlmREBp1Ca3MznegDYj5Fy0mWT3YiBDvZegRsmFFNf2WXGk9vhyw
         yhUg==
X-Gm-Message-State: AOAM533bGLFPdGwZCsHe0q7RsHURQW2yIKShSQlv3WAfN1n/yJVrcBW8
        vmJTs42BC22ZqtJcBcRPtcQ=
X-Google-Smtp-Source: ABdhPJySjueqwJ0nBVt1XTqdBV3okGQINyLQJzKQhWyXJq0b4JIe47S0Tagq+MjF1Mg8c2q1nBmycA==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr5935263edt.247.1621528659444;
        Thu, 20 May 2021 09:37:39 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e12sm1675053ejk.99.2021.05.20.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:37:38 -0700 (PDT)
Date:   Thu, 20 May 2021 18:37:37 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 5/7] PCI/sysfs: Allow userspace to query and
 set device reset mechanism
Message-ID: <20210520163737.GD641812@rocinante.localdomain>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-6-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519235426.99728-6-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

[...]
> +	if (sysfs_streq(buf, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		goto set_reset_methods;
> +	}

The sysfs_streq() is nice, indeed.

> +	while ((name = strsep((char **)&buf, ",")) != NULL) {

I believe we could make this parsing a little bit more resilient,
especially since we are handling user input and this cannot ever be
really fully trusted, so for example:

  while ((name = strsep((char **)&buf, ","))) {
	if !(strlen(name))  <--- sysfs_streq() could be used here too.
		continue;

	name = strim(name); <--- remove leading and trailing whitespaces, if any.
	(...)

[...]
> +	if (reset_methods[0] &&
> +	    reset_methods[0] != PCI_RESET_FN_METHODS)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");

What would be difference between disabling and de-prioritizing, is there
be a way for us to distinguish between the two?  I was wondering if we
could, notify the user when the device specific reset is disable or when
it has been de-prioritized?

Krzysztof
