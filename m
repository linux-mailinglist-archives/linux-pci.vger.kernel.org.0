Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B56407079
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhIJRW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 13:22:26 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40590 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhIJRWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 13:22:15 -0400
Received: by mail-lf1-f54.google.com with SMTP id k4so5477257lfj.7
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cqj7QL3Ud6tis7/wtb4CY9kC4CwM/wWtObr+fFS51ic=;
        b=nFKOwi7z5FKLi6SEk1pkvP0ynqU3PMhuhUSMboCSyayNRe4rrw5j3m4B1hcGuFPaxo
         hyhjZy2fgUI0wN/4GucPQlyYTUVYHdUMY5mex4Q1hD2/Y8BQdo5ZTqcJCuV+FYBzY4/i
         zhVqdhn+NLy9L78bq1kMpIehLcFF23hksHAwD3jf2cCbarNQpK2nZdNG3jav/xJ67Zqd
         spa68ubq76wksIuL1Q8YusUovDHHqbrjMCMWp9KEnOL/9th5x4IDfmXm9S/o2Od+rn6Z
         rIhUey7zvRX/yWKrogTuNlQucup0Jp9wNjOck0DoV9mR1HdcZNTzTOzEFqz4mYaSZaSC
         bKRg==
X-Gm-Message-State: AOAM532uI1dkjI53lSneh42yArAytC02q09UnubOAnM7Geum+SGSbXtK
        CM564eEhjmQz0yiiEEZsSSQ=
X-Google-Smtp-Source: ABdhPJwA8cDi53DBG+97oQlGGL0emL8Aishx1srGjWsAp7G6E/PAJZU9v1gCZjAWeS19HVTHKiHfyA==
X-Received: by 2002:ac2:5458:: with SMTP id d24mr599366lfn.385.1631294463297;
        Fri, 10 Sep 2021 10:21:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o21sm608013lfu.6.2021.09.10.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:21:02 -0700 (PDT)
Date:   Fri, 10 Sep 2021 19:21:01 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <20210910172101.GA1314672@rocinante>
References: <YSjWWWVC6ImWA5Qe@kroah.com>
 <20210827222331.GA3896976@bjorn-Precision-5520>
 <YTtm4e9a/gS5Swga@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtm4e9a/gS5Swga@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

[...]
> >   pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
> >   {
> >     a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
> >     ...
> >   }
> > 
> >   static struct bin_attribute *pci_dev_config_attrs[] = {
> >     &bin_attr_config, NULL,
> >   };
> >   static const struct attribute_group pci_dev_config_attr_group = {
> >     .bin_attrs = pci_dev_config_attrs,
> >     .is_bin_visible = pci_dev_config_attr_is_visible,
> >   };
> > 
> >   pci_device_add
> >     device_add
> >       device_add_attrs
> >         device_add_groups
> >           sysfs_create_groups
> >             internal_create_groups
> >               internal_create_group
> >                 create_files
> >                   grp->is_bin_visible()
> >                   sysfs_add_file_mode_ns
> >                     size = battr->size      # <-- copy size from attr
> >                     __kernfs_create_file(..., size, ...)
> >                       kernfs_new_node
> >                         __kernfs_new_node
> > 
> 
> You can create a dynamic attribute and register that.  I think some
> drivers/busses do that today to handle this type of thing.

Some static attributes users don't set size today or simply set it to 0, so
then we report 0 bytes in userspace for each such attribute via the backing
i-node.

Would you be open to the idea of adding a .size() callback so that static
attributes users could set size using more proper channels, or do you think
leaving it being set to 0 is fine?

	Krzysztof
