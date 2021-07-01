Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CE3B9633
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhGASoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 14:44:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39879 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhGASoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 14:44:01 -0400
Received: by mail-wr1-f49.google.com with SMTP id f14so9086139wrs.6
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 11:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3A0WFDmPSkEnA9X/4ve6FTVtpahIWIf1L85Qsi8H7qs=;
        b=SMFMtrhdq7DmkaBLDHp+PCsUj7KQu4CAIsypqsvvcDLeIhdhty1AMVOqseAuiw5Z2N
         uTFFkctnZTqTo2pss3dtiU4CLxztD4QzRrBNRc0nGyHvol3PtEhPYeqhiyg1/Dcb7Ev1
         RN7EeqiGh8l0JXf/VaN/6om7hT7QDukultpg+Wk8SKCdiheqHtYh21upswmSycKIKQ5y
         NqUyDr0payeAT3kQz7KUzs19Vh0SjzZI5bIOcjb0gjj9OIBDQ+vBnSLc72hulyv1obVl
         tYWm5rl/tXt0LRg/RKyBzjDZMPy7qfrvdJAOrbWbFM9KBkkKUeS58czF/bNwWSlruz8r
         4Etg==
X-Gm-Message-State: AOAM533eBEhUoCjQXqCA6rQ49XRp5erxWb7MllwVhIFAoHh7NyhR6OVu
        irOQqRHBFLhfc61KDhK5ehI=
X-Google-Smtp-Source: ABdhPJwD91OWvD3s99/HLidGAYhcr2TNAObtdeVVAPw/mlpVQdYQT5Kr8USe6LFUimK56/wpzyhT9w==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr1237342wru.11.1625164888877;
        Thu, 01 Jul 2021 11:41:28 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s1sm10195488wmj.8.2021.07.01.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:41:28 -0700 (PDT)
Date:   Thu, 1 Jul 2021 20:41:27 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpcihp: Move declaration of cpci_debug to the
 header file
Message-ID: <20210701184127.GA297254@rocinante>
References: <20210510024529.3221347-1-kw@linux.com>
 <20210701175639.GA73684@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210701175639.GA73684@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> > +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> > @@ -44,7 +44,6 @@ static DECLARE_RWSEM(list_rwsem);
> >  static LIST_HEAD(slot_list);
> >  static int slots;
> >  static atomic_t extracting;
> > -int cpci_debug;
> 
> We can add a declaration, but we still need a *definition* somewhere,
> right?

This is my bad!  Sincere apologies.  I will send a v2 that drops this
hunk.  This should have never been removed.
 
	Krzysztof
