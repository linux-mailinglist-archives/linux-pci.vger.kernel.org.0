Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1607797FB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjHKT5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKT5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 15:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160E30F9
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691783817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoHmIdlr9fzZZseKCmzbHqCopqIZszAlGorAU4t1RIw=;
        b=JLIY+JCI3E/CbNdQLUL6zYrozI3AIV1Xgnbazsx6uknHQ1LVkrWy6HcxXQmgiZYQ2KwQPQ
        37NJe84Zczb2ztyMaGeDd8xrLxgcB8wfvk23sPHkiwnOOiWlmHYOa/OMHbul0f4KM4rdMK
        kJJfKtVHPF+sbvgjfkt7SuS5QBhqtBY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-5g3bU9NrOFOY5ajuzvYwvA-1; Fri, 11 Aug 2023 15:56:56 -0400
X-MC-Unique: 5g3bU9NrOFOY5ajuzvYwvA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3497a190e16so18518285ab.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 12:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691783815; x=1692388615;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoHmIdlr9fzZZseKCmzbHqCopqIZszAlGorAU4t1RIw=;
        b=gNabz3wXkXa8X45vGFAiU9KDtQMdNYtpymsQZef8GD7QaQXzJWvFNfGq6lQzjsm6tX
         WTTb8n98Qxs1VF8xpicUajxmgeu3zflsbSX3f4cGIsblf4DNTVZzUUHO05UT0pVK1NTh
         JxiUfD2o35wxz/tRZkzu7MumHTlG9QmT5W+J/h5YWmtbUJMAhJ82BW5RAyxx34N9CQni
         2rVVmMjoLupd75hbMcS1xTdeBmieprnfJvehpi/oxt0j0g2owbYowV372aHQ0BaDubSC
         xJ7uMKyUFkck4O4uU63E6ERoDu4Xf2MRdkKnVT0G1NrnwjzXM5Z7b+OpczxcylIuuE2p
         qBCw==
X-Gm-Message-State: AOJu0YxgkW6DndPsis37EV+5ydHIMRWZMTj5U+LMZskAYR0Jl2C3t/uY
        42UxI0TrXlWEg0mbC7jXZnI4rRpm9KfUuXih4X/guP/Aul1AJRCrOEdioX6mdlIa+6jIL+SVlMB
        xdQHx6Gin5KxA/aGWM55mzlz7xhoI
X-Received: by 2002:a92:c5ab:0:b0:345:a319:ba83 with SMTP id r11-20020a92c5ab000000b00345a319ba83mr2888705ilt.29.1691783815048;
        Fri, 11 Aug 2023 12:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZaDCg/ZJLT8i8+9ALvrbX5oKiTQMUCtU9d+2d2CAviKOgtj6GM/xKffVaDi5v0X+V1YidNg==
X-Received: by 2002:a92:c5ab:0:b0:345:a319:ba83 with SMTP id r11-20020a92c5ab000000b00345a319ba83mr2888695ilt.29.1691783814825;
        Fri, 11 Aug 2023 12:56:54 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b0042b61a5087csm1208014jab.132.2023.08.11.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:56:54 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:56:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 1/2] PCI/VPD: Add runtime power management to sysfs
 interface
Message-ID: <20230811135652.716e42cd.alex.williamson@redhat.com>
In-Reply-To: <20230811192543.GA80176@bhelgaas>
References: <20230803171233.3810944-2-alex.williamson@redhat.com>
        <20230811192543.GA80176@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 11 Aug 2023 14:25:43 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Aug 03, 2023 at 11:12:32AM -0600, Alex Williamson wrote:
> > Unlike default access to config space through sysfs, the vpd read and
> > write function don't actively manage the runtime power management state
> > of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
> > the unused device into low power state with runtime PM"), the vfio-pci
> > driver will use runtime power management and release unused devices to
> > make use of low power states.  Attempting to access VPD information in
> > this low power state can result in incorrect information or kernel
> > crashes depending on the system behavior.  
> 
> I guess this specifically refers to D3cold, right?  VPD is accessed
> via config space, which should work in all D0-D3hot states, but not in
> D3cold.  I don't see anything in the spec about needing to be in D0 to
> access VPD.
> 
> I assume there's no public problem report we could cite here?  I
> suppose the behavior in D3cold is however the system handles a UR
> error.

Yes, Eric tested that pcie_port_pm=off is a viable workaround resolving
both the VPD and PME accesses, so I think the issue is actually that
the root port is in D3cold.  This aligns with commit 7ab5e10eda02
above, since prior to that we were only manipulating the endpoint power
state.

The oops indicates an "Internal error: synchronous external abort",
with a stack trace ending in pci_generic_config_read, so I suspect this
is a UR.

Unfortunately the bz is not currently public :-\  Thanks,

Alex
 
> > Wrap the vpd read/write bin attribute handlers in runtime PM and take
> > into account the potential quirk to select the correct device to wake.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a4fc4d0690fe..81217dd4789f 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> >  			size_t count)
> >  {
> >  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> > +	struct pci_dev *vpd_dev = dev;
> > +	ssize_t ret;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> > +		vpd_dev = pci_get_func0_dev(dev);
> > +		if (!vpd_dev)
> > +			return -ENODEV;
> > +	}
> > +
> > +	pci_config_pm_runtime_get(vpd_dev);
> > +	ret = pci_read_vpd(vpd_dev, off, count, buf);
> > +	pci_config_pm_runtime_put(vpd_dev);
> > +
> > +	if (dev != vpd_dev)
> > +		pci_dev_put(vpd_dev);
> >  
> > -	return pci_read_vpd(dev, off, count, buf);
> > +	return ret;
> >  }
> >  
> >  static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> > @@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> >  			 size_t count)
> >  {
> >  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> > +	struct pci_dev *vpd_dev = dev;
> > +	ssize_t ret;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> > +		vpd_dev = pci_get_func0_dev(dev);
> > +		if (!vpd_dev)
> > +			return -ENODEV;
> > +	}
> > +
> > +	pci_config_pm_runtime_get(vpd_dev);
> > +	ret = pci_write_vpd(vpd_dev, off, count, buf);
> > +	pci_config_pm_runtime_put(vpd_dev);
> > +
> > +	if (dev != vpd_dev)
> > +		pci_dev_put(vpd_dev);
> >  
> > -	return pci_write_vpd(dev, off, count, buf);
> > +	return ret;
> >  }
> >  static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> >  
> > -- 
> > 2.40.1
> >   
> 

