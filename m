Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7926E302
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIQRzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIQRzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 13:55:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DAC061756
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2020 10:55:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so1604830pjr.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ubb5DTI+VStVNf7vCLZGfulNZTbgJJzRYzc72+9jK9E=;
        b=ON4H+9Y8h3o8YE3iPqyfPP/sKdjVU6pm9VPHxQEHYlrLmEpE5niP6zABuP3bXIpcje
         Cc+Uk0/IX+bqEQZ2gGRi6yeo/50W0pBd8s44bnh6gbFvk0PoZYrt57DlExVTrGxS08lP
         vjVlih7n178dALzI4v2/bKVM6UfVWFxIe6G8YQO9eY5BeYSeXAkHnYwQupZ2aqpa2mwK
         QWdsnmMBEY1GC2kp5f1Iwu0H6p6swbAY6WKwldbmX9jl8gC+KJ9KHiVq/XYZZupBG2wv
         8u8Zmi8Tor3pcZyLTUc2y7cUWALrMCzBPQXtJm261sUqA7Miofw4BpwEYcCeHdeW3Mbh
         K76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ubb5DTI+VStVNf7vCLZGfulNZTbgJJzRYzc72+9jK9E=;
        b=sMHNGaUAHRJnik3DUeh0i4UUoOAOKxfu9iGaurnt/cnTB6/sYJmLSBsWyO/QRF9uwf
         UOMCPD7LVirBvEz9WsAHihGcIXVQlY3qBBBOWCBOyTaMaeUbtTUZecp+RYmVxxJInOi3
         +3arm5gF8ollXgEavTJSs6m0rG8WHEmEs/vzOzuYlUKSxgJME0giNeX0EyLDo2yX6iWT
         r05BJDL2mipp11oBnH0GHVi5VE7N7crkIYakiLAYQ9dO1w9ThMiqc7EQHAWvbTHh/BFP
         nLRr6OcCg/2XwTY5Lb1H6Fu48N4kEgFtmQ5/KxzEXU18PdoO/7q/ElQXu+e5ap0c2jSI
         O57Q==
X-Gm-Message-State: AOAM531rWLrRzJJ995UN8JyH6JLCJ9zOH+Rdsd9O2b05sj9vp4EqOL/f
        DDCyDCNRUNVBzQ2W6yr0w16rVA==
X-Google-Smtp-Source: ABdhPJwsnHCwj1aJ+RtYHAqNUbG0c69lhV8xw3LT+lpTYldpRMG+j90Pd5X/FjCD+qYceDAAgFQaHA==
X-Received: by 2002:a17:90a:d514:: with SMTP id t20mr8857755pju.134.1600365320606;
        Thu, 17 Sep 2020 10:55:20 -0700 (PDT)
Received: from [10.209.126.152] ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id b29sm229896pgb.71.2020.09.17.10.55.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:55:19 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/10] Add RCEC handling to PCI/AER
Date:   Thu, 17 Sep 2020 10:55:16 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <39F1C577-2486-43DC-BB65-1F6EDE02B217@intel.com>
In-Reply-To: <20200917173600.GA1706067@bjorn-Precision-5520>
References: <20200917173600.GA1706067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17 Sep 2020, at 10:36, Bjorn Helgaas wrote:

> On Thu, Sep 17, 2020 at 09:25:38AM -0700, Sean V Kelley wrote:
>> Changes since v3 [1]:
>
> This series claims "V4 00/10", i.e., there should be this cover letter
> plus 10 patches, but I only got 3 patches.  I don't know if some got
> lost, or if only those 3 patches were updated, or what?  If it's the
> latter, it's too hard for me to collect the right versions of
> everything into a single series.
>
> Either way, can you resend the entire series as a V5?
>
> Bjorn

That's weird.  I can see all 10 got sent. There's something awry with 
the mailer as I got the copies.  You are right.  Lore only shows 3.  I 
will see if something happened with the smtp access.  Will resend as V5.

Thanks,

Sean
