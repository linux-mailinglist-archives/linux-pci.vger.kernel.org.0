Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22AF320EC6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBVA5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 19:57:21 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43434 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhBVA5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 19:57:20 -0500
Received: by mail-wr1-f49.google.com with SMTP id n8so17269007wrm.10;
        Sun, 21 Feb 2021 16:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6l08NbqWC+qu4nr8l+AW7qZL8N6MHomNkIxlydPqmjI=;
        b=gXR1WdYnH0EKzt3G+rc9KQuNoyoLxCKFNlD7gmW8wdshiQDHCwxfrlFeE8oMjBKfWF
         IhVT5B2g7W25Dbfo/lNuX5y3i3m7TCNvDf6FHSxIVazZaUFN8R0XAIGSEbMzQoCMx3CQ
         RH7xGsa2Btju7j1Iykzz9K/qUWsUN7+mM4L4uSMyjkVRHM1K/0NUH/49ui+7K6JAajHK
         U5wkRoarQC/ecELkC/U3ZjYZ6OE3J5hWkhwZUkp8zWLFFLCM/bERDNg7S/T0CJEGT6b5
         6dvhfQhLSJZ9Dw9Kx1BBkrdk1DNrrYQlPVDY5hqS79I5hCL1roHQ2MRmdTC80P+EqEUT
         B5EA==
X-Gm-Message-State: AOAM531b2qu16mpQhKXHMGfd6bA/iI/FFr09YDAFf0nwzTelRYr8shTl
        DXJXJ+jtosNEqsowEkWqSQgGjlYjgSxwrA==
X-Google-Smtp-Source: ABdhPJzZ91okcXKkPZMDgKc958eE8akWYsaXgx9jW/6p7m3jEtsKDSFMe3p7tK1Wuk6ZV6Y0w6K5VA==
X-Received: by 2002:adf:e510:: with SMTP id j16mr19005623wrm.153.1613955398517;
        Sun, 21 Feb 2021 16:56:38 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b2sm27818367wrn.2.2021.02.21.16.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 16:56:37 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:56:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Message-ID: <YDMBRFWTYKTrDyBI@rocinante>
References: <57a7bbc1ba294ce39c309e519fe45842@intel.com>
 <20210219022359.435-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219022359.435-1-qiuxu.zhuo@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo for visiblity]

Hi,

[...]
> Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value
> of "rciep->devfn" to a device number to ensure that the RCiEP devices
> associated with the RCEC are linked when the RCEC is enumerated.
> 
> [ Krzysztof: Update commit message. ]
[...]

Thank you!  I appreciate that.  However, we probably should drop this
from the commit message.  Perhaps either Bjorn or Lorenzo could do it
when applying changes.

Krzysztof
