Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E102B32AC
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKOGIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 01:08:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgKOGI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 01:08:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id 10so20429135wml.2;
        Sat, 14 Nov 2020 22:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40+jqrpUK0SdtJrAhDUEaChrJidmD54kAPTtU1C47qo=;
        b=Cn/crLZ/86wlHl2pn47qsZ/dmPoq8PZ5bgDcODhsJV1LuM2/VMJgfgjBxVLI7v36hn
         5UviatLq3ASh6QmeI0emoayyl/nFtIw3+0vSBQVSTBXvLFs7wgZ6RSGL4cjUaxq55xDx
         kWtoObawTJgedQ+o34yBsX6Rmw6MUApy5HCYp+jagDD83nt+kjR2/If6re4zaCHOf1Nd
         7xDYoG7ct/zCSuuVe1SJTQ43y9LeSBdCpOZhwFIO8kDNY5vR0fLDD2gJEYh4ah3XLAnC
         FL1hlFgDBapXnBAE6IooaeghjnSFAxJQZx0kFDirwbXyC8iZ/9gJRotJnL4W09Ii87Xv
         BRCw==
X-Gm-Message-State: AOAM531ntoI4ce174+306+WQJdjBP3t1JPqqHcVmVAEn4peBygRrFt4H
        vCorRIkCNAUCwxg+CH6/fI0=
X-Google-Smtp-Source: ABdhPJzq7wZGr68QEkaHFWYnyTRaGZ6ymFeh8oRhcoAygQgSzThA1MOAPEm+0mJu/rYb+cPSt9X0Zw==
X-Received: by 2002:a1c:87:: with SMTP id 129mr9600178wma.34.1605420506956;
        Sat, 14 Nov 2020 22:08:26 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q5sm13801290wrf.41.2020.11.14.22.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 22:08:26 -0800 (PST)
Date:   Sun, 15 Nov 2020 07:08:25 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
Message-ID: <X7DF2ZyVnyIFjdC1@rocinante>
References: <20201102141520.831630-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102141520.831630-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Maximilian,

On 20-11-02 15:15:20, Maximilian Luz wrote:
> While most PCI power-states can be queried from user-space via lspci,
> this has some limits. Specifically, lspci fails to provide an accurate
> value when the device is in D3cold as it has to resume the device before
> it can access its power state via the configuration space, leading to it
> reporting D0 or another on-state. Thus lspci can, for example, not be
> used to diagnose power-consumption issues for devices that can enter
> D3cold or to ensure that devices properly enter D3cold at all.
> 
> To alleviate this issue, introduce a new sysfs device attribute for the
> PCI power state, showing the current power state as seen by the kernel.

Very nice!  Thank you for adding this.

[...]
> +/* PCI power state */
> +static ssize_t power_state_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	pci_power_t state = READ_ONCE(pci_dev->current_state);
> +
> +	return sprintf(buf, "%s\n", pci_power_name(state));
> +}
> +static DEVICE_ATTR_RO(power_state);
[...]

Curious, why did you decide to use the READ_ONCE() macro here?  Some
other drivers exposing data through sysfs use, but certainly not all.

Krzysztof
