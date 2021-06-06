Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5239CF32
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFFM7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 08:59:53 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:41787 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFFM7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 08:59:52 -0400
Received: by mail-wm1-f43.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so8363463wmq.0;
        Sun, 06 Jun 2021 05:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyBks3ibzIGEf1wCbfUSf4kop+pK33FGqskQ8K5nako=;
        b=qxSBIlvzZiJrl7HORKjj3tocaxGVcIkegXWkzELw351LG+67jotWuCrWL5Y/LyXcs/
         9Z7fRCOjW5BhlBiC/U+hBVJoewoO50zCtatwebE92oo/pgzxSVsC1zzYxw5roSwYKQTX
         2u9wbyCliADmvrc02bHEewmi3pUz9I4Q4cPSX5aeT+CndMxuf6vK+pAITGzhzR9lhGkV
         p+1jsfSBY11lfFXP8dt1ZJFM5gPTYSjAOC3nlR0B19lgI/t72JXS20CMuLIx/lOnJSpq
         66376c9VhE6xYB00xHNlIc0hWxz7d/PdIObJ/GtFp57AJ+tKMJA18qwideunjEf7/QgI
         +/yQ==
X-Gm-Message-State: AOAM531LRVHMuyPUHgsEqSq2KXvyUm47vXu9OTTjeTNeIbQU2VTw7IHr
        mvRYmkZ2ru+PnX0vCXBBEU0=
X-Google-Smtp-Source: ABdhPJzLyi0CIqf0ZHMTMOqqEeKrg1/vB1z/iHQZZH84Q43HZczWAW23ui8BUhGuUGPId1JNM6o4Iw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2616904wmg.152.1622984282331;
        Sun, 06 Jun 2021 05:58:02 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n13sm13952224wrg.75.2021.06.06.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:58:01 -0700 (PDT)
Date:   Sun, 6 Jun 2021 14:58:00 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v5 4/7] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210606125800.GA76573@rocinante.localdomain>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-5-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210529192527.2708-5-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey and Shanker,

[...]
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i, prio;
> +
> +	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (prio == pdev->reset_methods[i]) {
> +				len += sysfs_emit_at(buf, len, "%s%s",
> +						     len ? "," : "",
> +						     pci_reset_fn_methods[i].name);
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_RESET_METHODS_NUM)
> +			break;
> +	}
> +
> +	return len;
> +}

Make sure to include trailing newline when exposing values through the
sysfs object to the userspace in the above show() function.

[...]
> +static ssize_t reset_method_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
[...]
> +
> +	while ((name = strsep((char **)&buf, ",")) != NULL) {
[...]

This is something that I wonder could benefit from the following:

  char *options, *end;

  if (count >= (PAGE_SIZE - 1))
	return -EINVAL;
  
  options = kstrndup(buf, count, GFP_KERNEL);
  if (!options)
  	return -ENOMEM;
  
  while ((name = strsep(&options, ",")) != NULL) {
  	...
  }
  
  ...
  
  kfree(options);

Why?  To avoid changing the string buffer that has been passed to
reset_method_store() as strsep() while parsing will update the content
of the buffer.  The cast to (char **), aside of most definitely allowing
to suppress the probable compiler warning, will also allow for what
should be a technically a constant string (to which we got a pointer to)
to be modified.  I am not sure how much could this be of a problem, but
I would try not to do it, if possible.

[...]
> +set_reset_methods:
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(reset_method);

A small nitpikc: customary there is no space (a newline) between the
function and the macro, the macro follows immediately after.

	Krzysztof
