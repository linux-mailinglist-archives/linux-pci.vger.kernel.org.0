Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8842727F124
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3SPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 14:15:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42770 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:15:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id x14so2705224oic.9
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 11:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1h/fs1Q+ZkuMmkgbLP/kqlyFUolj2Q8y0C5A1dnqqZk=;
        b=GrsknfahlS9qXZy6nwi84AC4KEe8ZSOt9WdqAnWy90r2P98ZVrjh+M34K+UJkc853s
         +YlwlL7v/QaCom7c4SAkqtI4rXlvkpCg8tgIZ/5kdB40a1nkaScWnBhtQGUP3lsQxfVt
         FPpiS/hWfOhYzObNwkznmabEzt9uxIaMpFklWhyv7Iy48xghNpKFR9e05U882LQP1gMV
         /1D6k56sFmk9fmVOL5iTfSwrIzYLZD2mKUaWmxE7HCrCBrp2A0TJ2yotEcWOZYiSp3ze
         lAkY3UkaWqiziRSCLz4DJsFgB80w5+yQhJThzjaVBRoPh08lFBnUDpfSK0F6sxQeOWfk
         OxUA==
X-Gm-Message-State: AOAM533X6Djbet+XrsArm7XmqwzyH6O1qsLGyvXODdBLo4yfxTFV4puf
        y96dJSrWsH/hBVrErXTPPrVBeQXQfZI2
X-Google-Smtp-Source: ABdhPJy+34pzjpWJJ6KOtw5hnHzXYQw1gWprXYgMrNqyBN05I7ip4e3lZfjRo0CtDaIKEqaMVXnmzg==
X-Received: by 2002:aca:5d8a:: with SMTP id r132mr2209025oib.129.1601489701835;
        Wed, 30 Sep 2020 11:15:01 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 92sm34378otl.1.2020.09.30.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:15:01 -0700 (PDT)
Received: (nullmailer pid 3165772 invoked by uid 1000);
        Wed, 30 Sep 2020 18:15:00 -0000
Date:   Wed, 30 Sep 2020 13:15:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add missing documentation references to
 PCI Endpoint Subsystem
Message-ID: <20200930181500.GA3165690@bogus>
References: <4fa78c7a24e8f8ec3206e1e8960dc18f505c9e29.1597695880.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa78c7a24e8f8ec3206e1e8960dc18f505c9e29.1597695880.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 Aug 2020 22:27:34 +0200, Gustavo Pimentel wrote:
> Adds documentation reference created by Kishon Abraham to the
> MAINTAINERS list relative with the PCI endpoint subsystem section.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes V2:
> 	Replace file extestion from txt to rst
> 
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
