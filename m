Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4176E31F21F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 23:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBRWMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 17:12:19 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36004 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBRWMS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2021 17:12:18 -0500
Received: by mail-wm1-f46.google.com with SMTP id a207so5277009wmd.1;
        Thu, 18 Feb 2021 14:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XldSWzdpAGbaW+QKxGIWAFGcXaBUSbZYr+d14VI3Oes=;
        b=eU1dUhmGR8grA1XIlhMpuot4J6cxkP7+/VK/8/zGHy2T2RQvakick2cefkezlgfFNC
         IrZEnftVmiOy+QmXjbzR/NhqQJwK22i70NYX36K5SfjBFkuoWkolqgql7hiWbO1/URSD
         MS4eB4+LDRC443LLnrNCKGZxcxbR+q2Ad1xAUrY+a/amoj1LSEqgTkKlO4hJTq+svE72
         Td3lFIU1kF4LQJaTI/tsC1/tyxHntcOi74aDmx3u88hgnnIyWoxcb7lXHNi4HJvhLjSM
         CyP4aLO3VHcDgqJa0IVnBH/93jkVmbr/WehhgV5RVS/z2EDMh1/VKgxRV21OJyTagsHY
         p4Mg==
X-Gm-Message-State: AOAM530YUNtiRu5djKcwEQkBlkxurLy3CAKYGXmWCHUL046QRuLxBrSX
        tP64QTUvQjZoNaI8tfJ3vYti1v2XnMIQUP32
X-Google-Smtp-Source: ABdhPJz8jrJhzfPxWhjk8Zf9caa4g6fsazQeYxjRBj1mESjLBNuQoIaAPPIu0ONAOH0R10mW+3+Jaw==
X-Received: by 2002:a1c:5686:: with SMTP id k128mr5369333wmb.189.1613686296290;
        Thu, 18 Feb 2021 14:11:36 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s5sm9379050wmh.45.2021.02.18.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:11:35 -0800 (PST)
Date:   Thu, 18 Feb 2021 23:11:34 +0100
From:   'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Message-ID: <YC7mFsfTlVsW9Uo1@rocinante>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
 <YCQT90mK1kacZ7ZA@rocinante>
 <a5b1aa8ef91a4c71982ad77234932349@intel.com>
 <YC7lE2Ph/MHxNKs+@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC7lE2Ph/MHxNKs+@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qiuxu,

[...]
> > Agree to simplify the commit message. How about the following subject and commit message?
> > 
> > Subject:  
> > Use device number to check RCiEPBitmap of RCEC
> > 
> > Commit message: 
> > rcec_assoc_rciep() used the combination of device number and function
> > number 'devfn' to check whether the corresponding bit in the
> > RCiEPBimap of RCEC was set. According to [1], it only needs to use the
> > device number to check the corresponding bit in the RCiEPBitmap was
> > set. So fix it by using PCI_SLOT() to convert 'devfn' to device number
> > for rcec_assoc_rciep(). [1] PCIe r5.0, sec "7.9.10.2 Association
> > Bitmap for RCiEPs"
> 
> I took your suggestion and came up with the following:
> 
>   Function rcec_assoc_rciep() incorrectly used "rciep->devfn" (a single
>   byte encoding the device and function number) as the device number to
>   check whether the corresponding bit was set in the RCiEPBitmap of the
>   RCEC (Root Complex Event Collector) while enumerating over each bit of
>   the RCiEPBitmap.
> 
>   As per the PCI Express Base Specification, Revision 5.0, Version 1.0,
>   Section 7.9.10.2, "Association Bitmap for RCiEPs", p. 935, only needs to
>   use a device number to check whether the corresponding bit was set in
>   the RCiEPBitmap.
> 
>   Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value
>   of "rciep->devfn" to a device number to ensure that the RCiEP devices
>   are associated with the RCEC are linked when the RCEC is enumerated.
> 
> Using either of the following as the subject:
> 
>   PCI/RCEC: Use device number to check RCiEPBitmap of RCEC
>   PCI/RCEC: Fix RCiEP capable devices RCEC association
> 
> What do you think?  Also, feel free to change whatever you see fit, of
> course, as tis is only a suggestion.

We could probably add the following:

  Fixes: 507b460f8144 ("PCI/ERR: Add pcie_link_rcec() to associate RCiEPs")

Since this would where the issue was originally introduced.  I forgot to
mention this in the previous message, apologies.

Krzysztof
