Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689B37F834
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhEMMvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 08:51:06 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40818 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhEMMvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 08:51:00 -0400
Received: by mail-wr1-f48.google.com with SMTP id z17so7713082wrq.7
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 05:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kD6/mEPYNtoCsTFnZMkPkwGqL4Xhd2RhCwfu9Wi6A4Y=;
        b=tm4BBWUndWcIRH1L6RoxnHqLnmy+GVgET+I3lRNBMh8k5oh6blE3EDg0i1erX7MmMW
         JkHngg4/qPzh10Mm/fwBL49kHfUmrHVQrFsZaaqUv6/KbvpY7EOU4I4uM/yspy4sNG/J
         oKeuG7yBTSnczb6gH9tA5bCgdp9j+cK2+bujRMDEbZs30PmX52lj4L1s1wnUAOXv/3u6
         DMUrB4zQNYF7JD0rfLfZ3NjmLj8epOsCVcmnvjCzTsDIg+y2KOUvOZxVXWa5iXQZqtTi
         /hOF8rQm+lTzYug2G+NKZk8kuuHsBirx4sDa8B/HmDsRl2OXnH4Z2WbkVPHNOzlbE/42
         yrYQ==
X-Gm-Message-State: AOAM531p79mzaKpFh+CyCvaDf0l8X+2U2a2uTCZhAZdpC3o+mjcZITIF
        I2sAOI4t5a8Q5fNAuVIzNFo=
X-Google-Smtp-Source: ABdhPJztl07s7eoyRKlbHMNz4jt/365a5BLrJy6PIq1msAS7SC421+08CLZJr9QQMtzm68syg5Hc9A==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr48566689wrw.376.1620910188812;
        Thu, 13 May 2021 05:49:48 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d9sm959742wrx.11.2021.05.13.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:49:48 -0700 (PDT)
Date:   Thu, 13 May 2021 14:49:46 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210513124946.GB202784@rocinante.localdomain>
References: <20210510041424.233565-1-kw@linux.com>
 <4557364b-76ce-3555-e97d-14f39eda27b8@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4557364b-76ce-3555-e97d-14f39eda27b8@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Logan,

[...]
> Thanks, this is a great cleanup. I've reviewed the entire series.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thank you!  Appreciate it!

> I agree that the new lines that are missing should be added.

While working on the simple change to add the missing new lines, I've
found that we have slight inconsistency with handling these in one of
the attributes, as per:

  # uname -r
  5.13.0-rc1-00092-gc06a2ba62fc4
  
  # grep -oE 'pci=resource_alignment.+' /proc/cmdline 
  pci=resource_alignment=20@00:1f.2

  # cat /sys/bus/pci/resource_alignment
  20@00:1f.
  
  # echo 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.2

  # echo -n 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.

I adjusted the code so that we handle the input better in the upcoming
v2 - the change is simple, but since it adds more code, I'll drop your
"Reviewed-by", so that we can make sure that subsequent review will
cover this new change.  Sorry for troubles in advance!

Krzysztof
