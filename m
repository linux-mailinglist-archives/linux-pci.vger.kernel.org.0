Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66838162E
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhEOFhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:37:22 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36545 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhEOFhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:37:22 -0400
Received: by mail-ej1-f48.google.com with SMTP id c20so1636644ejm.3
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDyLyYKMOMM01yAnQWwaEmsDx06DfWwmC9jVMwC267g=;
        b=jdAnJe+2CTFcblQHrJGmjN2vkzOS5lgueM8vFX6DGAXRrCcMj9Fr+BfU6vQ5XtM/FR
         482jkXNOPD0gMYl/lSuloEwpyl3r0giZqykpn/rnak7wUxu+yutDstI6c2+tlyKjwHgo
         RyTkOZo28xtanurn+Lh6TLDVzlJBLkLHXO5aA0JveffGOiIVrV2hgGYw1mh7EVkOcuSE
         J5AXtPMQBCwCwrnRM1RMlT9fV4UlJh8vmGAvOFpbBcFSvj0oHAAP9+v6MQWTC/Uu/MTL
         1s24OxMf4G2B8UzdcYniD5ru3h99K6NCRGg0ExJri4rQLYjY/75smUNNJyCQIwjBG34t
         wisg==
X-Gm-Message-State: AOAM533ggVZZtXDMT4UtnJ9zrU5HTq+Ji2GQIqnG/tGYTT8VLmUvgOEf
        YJxBZkBSRgifU/6tXtEnnZY=
X-Google-Smtp-Source: ABdhPJwbr3Y/1auLCBpHvfjMGdiIbyXL5GfmX9Da+zC0OU0n75U9zQufvL5vkiUJg6bJsXEvC0LMeA==
X-Received: by 2002:a17:906:27c3:: with SMTP id k3mr51691905ejc.519.1621056967989;
        Fri, 14 May 2021 22:36:07 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y10sm4730405ejh.105.2021.05.14.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:36:07 -0700 (PDT)
Date:   Sat, 15 May 2021 07:36:06 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
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
Message-ID: <20210515053606.GA72086@rocinante.localdomain>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Please disregard this "Reviewed-by" from Logan for this version, as I've
forgotten to remove it before sending v2 after pulling patches using b4.

Apologies.

Krzysztof
