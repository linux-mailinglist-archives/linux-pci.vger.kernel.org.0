Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35363DE6BD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhHCGeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 02:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhHCGep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 02:34:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E16C0613D5;
        Mon,  2 Aug 2021 23:34:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2432510pja.5;
        Mon, 02 Aug 2021 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRwYfIMmqsxjBnnSXDo+aOgwj2et1AAa2hNgV9gFeYU=;
        b=vK1v22D+JBRGXG7Q00FuhVstwwDDjd6Gj1BHWhp/st/bsblY/un4WudZXFCPTPDZID
         k81+q2delU6pX+EfBuQuAPZfREnS0GtRE8l+sAdATbGeCXvlBO7qIVneLb0JQNhY8T0K
         RuG7itocLlrk/NfIVY/M/Q9bdRg604nzPzHkRkR7DbkAoqqsHtCTij988fehY6bQu++5
         H4Jja/EkO6hFNz4FrhoX+1VB4p1G9jZAZRfz7kFieAjz9GvEVmviQ3goermt1c4qyC1c
         KoUzPulIfTH6pugM+EUsTKugiqA6H6s2BoxWyWQJsMSJOwxMZw6nT2yHpVVKLvrph87g
         /V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRwYfIMmqsxjBnnSXDo+aOgwj2et1AAa2hNgV9gFeYU=;
        b=GV49kNiabzzsovWenYKASQ5T7VI7RWnsF+aI7u2KejUju+kMj22or3BD6alWPDWPOP
         9IwrUiQjhTNZGuIsHGmSeh8cTX80mk/MMF7jaNQTVMrkEkZ9N6R1FLM+6Kz5oJ4PQRLO
         UU7EfJEGyvLOqRW6E86Tq2Wk0SoFg7OUmkS73EuEUbGxeZkTr+pK505omrWE7UXUdTCL
         asEoaFoS+mUA7oJxBDrhxkdAbayzzZ195TpNfUE59RNq7xLDL6G08G6OcDQNfk37lXfP
         5ONJ4ubpymGDCtetd7D8SoeZknU3vMwA7MSIfA/mh3D7K/WkNcQTKwYBNd+gcrmf28uL
         IVkQ==
X-Gm-Message-State: AOAM533dDFJA7g9cA36FUjuZG5kzxn7CoIz3qUOFGVSXEgw52/vnjt9g
        lNn5s9JIgsmVyEN3cppSwMc=
X-Google-Smtp-Source: ABdhPJxy+cGjCgn9IXbnog8GeKn8D3W4gtzT1zah26FxsUyTxXauGklyXEvV0PkmOCxNin21lfqO3Q==
X-Received: by 2002:a17:902:ba90:b029:12c:acd:88f3 with SMTP id k16-20020a170902ba90b029012c0acd88f3mr17223871pls.3.1627972474000;
        Mon, 02 Aug 2021 23:34:34 -0700 (PDT)
Received: from localhost ([139.5.31.186])
        by smtp.gmail.com with ESMTPSA id w8sm12839194pja.24.2021.08.02.23.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 23:34:33 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:04:24 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v13 5/9] PCI: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210803063424.aybmwdxxj6bt2iax@archlinux>
References: <20210801142518.1224-6-ameynarkhede03@gmail.com>
 <20210802225559.GA1472320@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802225559.GA1472320@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/08/02 05:55PM, Bjorn Helgaas wrote:
> On Sun, Aug 01, 2021 at 07:55:14PM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to query and set user
> > preferred device reset methods and their ordering.
> >
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> > +
[...]
> > +static ssize_t reset_method_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int i = 0;
> > +	char *name, *options = NULL;
> > +
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	if (sysfs_streq(buf, "")) {
> > +		pdev->reset_methods[0] = 0;
> > +		pci_warn(pdev, "All device reset methods disabled by user");
> > +		return count;
> > +	}
>
> I think it's possible for the user to disable all reset methods by
> supplying only junk.  Maybe this check could be moved to the end of
> the function to catch both the "empty input" and the "input contains
> only junk" cases?
>
Supplying only junk doesn't disable the reset. It returns -EINVAL as it
will go in following while loop. The check m == PCI_NUM_RESET_METHODS
returns -EINVAL

> > +	if (sysfs_streq(buf, "default")) {
> > +		pci_init_reset_methods(pdev);
> > +		return count;
> > +	}
> > +
> > +	options = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!options)
> > +		return -ENOMEM;
> > +
>
>   i = 0;
>
> here so it's nearer the loop it controls.
>
> > +	while ((name = strsep(&options, " ")) != NULL) {
> > +		int m;
> > +
> > +		if (sysfs_streq(name, ""))
> > +			continue;
> > +
> > +		name = strim(name);
> > +
> > +		for (m = 1; m < PCI_NUM_RESET_METHODS && i < PCI_NUM_RESET_METHODS; m++) {
> > +			if (sysfs_streq(name, pci_reset_fn_methods[m].name) &&
> > +			    !pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
> > +				pdev->reset_methods[i++] = m;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (m == PCI_NUM_RESET_METHODS) {
> > +			kfree(options);
> > +			return -EINVAL;
>
> In this case, I think we have actually updated pdev->reset_methods[],
> but we still return -EINVAL, right?  If we decide to silently ignore
> unrecognized methods, we probably should return success here.
>
Is it okay to do that? I hope it won't cause any trouble for user
scripts

Thanks,
Amey

[...]
