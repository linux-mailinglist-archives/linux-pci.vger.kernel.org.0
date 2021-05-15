Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C363A38163B
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhEOGAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 02:00:42 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:34811 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhEOGAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 02:00:42 -0400
Received: by mail-ej1-f49.google.com with SMTP id p24so394985ejb.1
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxU+SMLsQzcRdf8JW3f+lBwp7dAmZ2RclEuJzkIt4jg=;
        b=bPhFpom939Yjc1zG/aglaGBm4glH5CuZn4pIEyE61ZkR0wBvAkLfX8hpJOp3Ac89Qt
         sOzcaIB71YMcFbBZlcltlyYxPH35dH9fFAtXuFlLwaETnldIDTus2meYj50Gird7Fhb/
         tDzPPQBW8pqHuLQQBYf715xpvmI+dH/iuN4FTs3+oQH2mEt12I2IUA1cAZsjlQmUbznT
         KfSh6h42WCq3sE5V59ShDaqbGa1gdQHr8nZ/hQlGRh5gEB+bPVhQrTF/ZQ4Fe6QTvM1o
         X6Iu7kaaVPLG7xQBTebYAPAmYMa/2TnrYREW5VKjVcMukTtAmyaIqajIBX/A+GEgYMhZ
         KH1g==
X-Gm-Message-State: AOAM530yji0rdDwx7JEfd80WNkx/QUNQiA+XEU2e1IJHd0Su6bNnYklf
        GR3IZPEqJ0wY6By5JEjulvY=
X-Google-Smtp-Source: ABdhPJyqXWDNaPpiTdS/BVFGCZr4ufv48fdcgnBwFabbOiHJAvq8/l70JH1/M9vbwnAfYahZo6lewQ==
X-Received: by 2002:a17:906:e08c:: with SMTP id gh12mr53261236ejb.115.1621058369429;
        Fri, 14 May 2021 22:59:29 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm4926927ejg.43.2021.05.14.22.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:59:29 -0700 (PDT)
Date:   Sat, 15 May 2021 07:59:28 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210515055928.GA73551@rocinante.localdomain>
References: <20210515052434.1413236-1-kw@linux.com>
 <985813cafbbe58cd899737ee49b44798210a69f6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <985813cafbbe58cd899737ee49b44798210a69f6.camel@perches.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joe,

[...]
> Ideally, the additional newline check below this would use sysfs_emit_at
> 
> drivers/pci/pci.c-      /*
> drivers/pci/pci.c:       * When set by the command line, resource_alignment_param will not
> drivers/pci/pci.c-       * have a trailing line feed, which is ugly. So conditionally add
> drivers/pci/pci.c-       * it here.
> drivers/pci/pci.c-       */
> drivers/pci/pci.c-      if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
> drivers/pci/pci.c-              buf[count - 1] = '\n';
> drivers/pci/pci.c-              buf[count++] = 0;
> drivers/pci/pci.c-      }
> drivers/pci/pci.c-
> drivers/pci/pci.c-      return count;

I found some inconsistencies with adding newline this way, and decided
to change the code slightly, see:

  https://lore.kernel.org/linux-pci/20210515052434.1413236-12-kw@linux.com/

Krzysztof
