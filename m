Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAEBB1BD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407328AbfIWJzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 05:55:53 -0400
Received: from foss.arm.com ([217.140.110.172]:39734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406222AbfIWJzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 05:55:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FFD1000;
        Mon, 23 Sep 2019 02:55:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B578E3F59C;
        Mon, 23 Sep 2019 02:55:51 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:55:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: pci: endpoint test BUG
Message-ID: <20190923095546.GA3719@e121166-lin.cambridge.arm.com>
References: <20190916020630.1584-1-hdanton@sina.com>
 <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
 <815ad936-8b98-0931-89f7-b97922a7c77d@ti.com>
 <20190920152026.GC10172@e121166-lin.cambridge.arm.com>
 <c1e7862c-d61d-6ecd-f70c-73870f343940@infradead.org>
 <c2cadd96-a6d5-45f9-9abc-4c89b4a8b056@VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2cadd96-a6d5-45f9-9abc-4c89b4a8b056@VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 21, 2019 at 10:04:55AM +0800, Hillf Danton wrote:
> >
> 
> >> It will be resent if no one saw the message.
> 
> > 
> 
> > I didn't see it and I can't find it on lore.kernel.org/linux-pci/.
> 
> > 
> 
> Respin, git send-email works/jj/pci-epf-uaf.txt
> 
> ...
> 
> From: Hillf Danton <hdanton@sina.com>
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cc: linux-pci <linux-pci@vger.kernel.org>,
> 
>         LKML <linux-kernel@vger.kernel.org>,
> 
>         Randy Dunlap <rdunlap@infradead.org>,
> 
>         Al Viro <viro@zeniv.linux.org.uk>,
> 
>         Dan Carpenter <dan.carpenter@oracle.com>,
> 
>         Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
> 
>         Kishon Vijay Abraham I <kishon@ti.com>,
> 
>         Andrey Konovalov <andreyknvl@google.com>,
> 
>         Hillf Danton <hdanton@sina.com>
> 
> Subject: [PATCH] PCI: endpoint: Fix uaf on unregistering driver
> 
> Date: Sat, 21 Sep 2019 09:58:28 +0800
> 
> Message-Id: <20190921015828.15644-1-hdanton@sina.com>
> 
> MIME-Version: 1.0
> 
> Content-Transfer-Encoding: 8bit
> 
>  
> 
> Result: 250
> 
>  
> 
> And let me know you see it.

I do not think any of your messages hit the vger mailing lists, avoid
html.

I have not received any patch and they are not in the mailing list
archives either.

Please check your email/SMTP set-up. I do not apply patches that
are not on linux-pci@vger, worst case you can attach the patch to your
reply and I can send it on your behalf but we must do this quickly.

Lorenzo

> Thanks
> 
> Hillf
> 
