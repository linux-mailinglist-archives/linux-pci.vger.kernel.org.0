Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10827A9ACB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 08:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfIEGnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 02:43:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44893 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIEGnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 02:43:10 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so2176222iog.11;
        Wed, 04 Sep 2019 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3TOlpt4AzwL4vJMcx058iXMi4F3NzrLOUOTA0ioeGM=;
        b=CxoEBriKvDfuHEA4jDWxEwMLbYr1YI0oDkRYE6SsvlE8dat8oRh7j6bCESWtq36vMP
         CXhtlVpSrQAIyfXYGUqPMvk9GIZ/BpJAIYx6zzPkW0yEwap5l/KX7U43uX/JC+DRegRU
         oE6WlH0O1Lfy5dy/NjjwmPKesbQgXCBt2LCxFSN77PCRJXU2i0Kcx3ZCiLOTLf2Jetqm
         Gy3cco5AfHGO2Lw0WbEldzbBo8veKVVDw/QjZ2abwwuJS0O3GhmSmcW2gssz3auDclgq
         /xdlI6y0eHW5YTxU29ee0W4aQpyc7SzA+6Ua9X3mwyF43CtvNHhIvRBQH5dSEdiQKz3L
         s9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3TOlpt4AzwL4vJMcx058iXMi4F3NzrLOUOTA0ioeGM=;
        b=i6dA/2YBQi8k/YReZ2tQcKKvgEFY/a6wl0+5sOV72aEJAm4klmgOfl5o87OMhaYbcz
         kWeAt/yoZtB75bPzNnlcNsdYl6WIReBA5jvxqBCikE0lkS2FtJ54BI4x5mH+P+KN04Rx
         0t5qvg5yKtuRFiAhoUp7sfvnkncs62paI2asDwp4j6KFXptsqNTbMzJgfkY4VH4iLM4X
         9po2vjHeGYQZFFkc+IczegS9ZUUslsR905jWWJj1AVN2Rb33xueN33LgBmEn/K/VeMTT
         /VtbyooZyLn0Zzdc0t06lVQSpGKv6N9aYj5IvvBQewQv8stlyqK6tavYJml36lzNghA2
         df2w==
X-Gm-Message-State: APjAAAXmZwudzyH7VY8Iiws1crmU6vWwc3eTkxFmkb3zc6DXC0hLbNEQ
        edu+zPauNQEjY9NDBq7CT6Q=
X-Google-Smtp-Source: APXvYqy0aVdZmAANyHWj3sNWe6nogZumcPdiovz36LuXEAB8Zx/uV4furW6cIHuxt9rKEV1aRmwCwg==
X-Received: by 2002:a6b:7503:: with SMTP id l3mr2134170ioh.244.1567665789932;
        Wed, 04 Sep 2019 23:43:09 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id w14sm970531ioa.46.2019.09.04.23.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 23:43:09 -0700 (PDT)
Date:   Thu, 5 Sep 2019 00:43:07 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, rafael.j.wysocki@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH 2/2] PCI: Unify pci_dev_is_disconnected() and
 pci_dev_is_inaccessible()
Message-ID: <20190905064307.GA43579@JATN>
References: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
 <20190904043633.65026-3-skunberg.kelsey@gmail.com>
 <20190904053523.7lmuoo5zempxtsdq@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904053523.7lmuoo5zempxtsdq@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 07:35:23AM +0200, Lukas Wunner wrote:
> On Tue, Sep 03, 2019 at 10:36:35PM -0600, Kelsey Skunberg wrote:
> > Change pci_dev_is_disconnected() call inside pci_dev_is_inaccessible() to:
> > 
> > 	pdev->error_state == pci_channel_io_perm_failure
> > 
> > Change remaining pci_dev_is_disconnected() calls to
> > pci_dev_is_inaccessible() calls.
> 
> I don't think that's a good idea because it introduces a config space read
> (for the vendor ID) in places where we don't want that.  E.g., after the
> check of pdev->error_state, a regular config space read may take place and
> if that returns all ones, we may already be able to determine that the
> device is inaccessible, obviating the need for a vendor ID check.
> Config space reads aren't for free.
> 
> Thanks,
> 
> Lukas

Good note. I definitely see why that would be undesirable. Thanks for
taking the time to point this out, Lukas. I'll look this over again to see
if a better solution can be done, or as Bjorn suggested, at least see if
clarification on when to use one vs. the other can be included.

Thanks again!

-Kelsey
