Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89840ED7B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhIPWpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 18:45:13 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45766 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbhIPWpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 18:45:12 -0400
Received: by mail-wr1-f50.google.com with SMTP id d21so11891492wra.12;
        Thu, 16 Sep 2021 15:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Emc/waGaqZBzEYTGo5aYk3frZSwuJXjHG2aoRVgz318=;
        b=3tvYg5A2e9ig0pgkyx3g06lMOnt4OhUVyo7sOeT8Y8LRYhOob5Jg4PKnklqUV18M0a
         WJLJZ62PPWxBXSx5B+DVt9pGa/CamKdGr4+DUE4H5bisRATGm/NGKlFz+Nz66ROjKnEm
         2wKBfQWQG972sSLluV0UwgLRujvtxxVr0ptdi0dzZ3j+AbXyYR94TxZ7v9RBb3Wq66zs
         J0TGncT1XDI/YRTpBqkBbnis+66OzwXjgSi1/fgIBLQss+8YEVtCFcuLPBMDD9b6aJCf
         UYF9igJ4d4KblDF91owb0NgmqpswpkVGZqqQXiUP+Pb6roll3tfKfRQ7gXHP0FVfbnDw
         QZ+w==
X-Gm-Message-State: AOAM532WCImy/m6xJcXbcar1sStGkYsGACCNd9gR7ChZyvUh3LZ78Rsk
        flfeRbnrRaxqBV++Z4/oo/E=
X-Google-Smtp-Source: ABdhPJyX4J8jGmgFDVzZVKRsjoLwjGHvn6PMfyvFhuEwzDk/9sVeeST9al0KB3n/P3PMx0kXEREsfQ==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr8766029wrb.307.1631832230712;
        Thu, 16 Sep 2021 15:43:50 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g1sm4799781wrr.2.2021.09.16.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:43:49 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:43:48 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Use sysfs_emit() in "show" functions
Message-ID: <20210916224348.GA1510593@rocinante>
References: <1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com>
 <b9eb71b0-8328-fb05-3b8c-112cb8dbbda2@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9eb71b0-8328-fb05-3b8c-112cb8dbbda2@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hayashi-san,

Thank you for sending this as separate patch.

> Gentle ping, are there any comments?

I am sure Bjorn or Lorenzo will get to this patch soon, it's still marked
as "New" in patchwork, as per:
  https://patchwork.kernel.org/project/linux-pci/patch/1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com/

My "Reviewed-by" still applies, of course.

[...]
> > Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
> > check for buffer overruns in sysfs outputs.

As Bjorn, or someone else might ask, you could add a short note about this
being configfs, rather than sysfs, and that sysfs_emit() will still work.

Something as per what I said while commenting on the previous patch:
  https://lore.kernel.org/all/20210719034313.GA274232@rocinante/

	Krzysztof
