Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6228C8F71E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfHOWl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 18:41:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38352 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbfHOWl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 18:41:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id m12so1610931plt.5
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2019 15:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O+L+kO8Gi9tJ+LbkhXI1V3NKCWdBDyo6Y2nqvRyx6z8=;
        b=SKXk0c2RdqWMCHEfBbel/YOlwewVflkaPqgbRdjDYr9qsRj3YpYARpr9hoAy996Aor
         H9k7wVlMyjQuZ9sm8e07/C1rQ2U6opsR8wLW0T9JC2TaFUd3G+OA2QduN1v0pWNFBE0W
         yWDxdFOinyBo+3ZrNw7ia4YLW1LEvCf5VuOYcG1FwJUVrUapsR3LwNTORuvgXk5m4Ict
         N0kBywe3D+JzcLyoHJcJlhmTKofwd1rKcTWx2PS1lMA9qdOT4Ncy8BVatOHrGekBu/wF
         Uce5AvI6NjcG3sycS48V+gmsrNBio7wYdu78sKe6dfnHx+e3Vc5SZN6s/zerBInNAia2
         3zKg==
X-Gm-Message-State: APjAAAUWR75wJuyGysN+yCHpxO35Rjs5+wSIVuuuKDWaRpBF6cIISpsK
        CYk7NEQVdND7NmKjQN4KKHIe4Lbj
X-Google-Smtp-Source: APXvYqyzFEyt3AHWI4zM4Ize9RZfXB8E3Y7KVfrNdXfI4xbUwhrpOmfSpCrJ+VlXjP3CbmsizgBVRg==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr5870979plb.342.1565908886815;
        Thu, 15 Aug 2019 15:41:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z28sm4444290pfj.74.2019.08.15.15.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 15:41:24 -0700 (PDT)
Subject: Re: [PATCH] PCI/P2PDMA: Fix a source code comment
To:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190815212821.120929-1-bvanassche@acm.org>
 <3dc57299-199f-4583-9b66-748a6aec059f@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bc743620-7943-ba18-263f-027e532a11bd@acm.org>
Date:   Thu, 15 Aug 2019 15:41:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3dc57299-199f-4583-9b66-748a6aec059f@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/15/19 2:32 PM, Logan Gunthorpe wrote:
> On 2019-08-15 3:28 p.m., Bart Van Assche wrote:
>> Commit 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory"; v4.20)
>> introduced the following text: "there's no way to determine whether the
>> root complex supports forwarding between them." A later commit added a
>> whitelist check in the function that comment applies to. Update the
>> comment to reflect the addition of the whitelist check.
> 
> Thanks for the vigilant patch, but I've already got a series[1] that
> cleans up most of these commits. It looks like this patch will conflict
> with that series.

Hi Logan,

Thanks for the pointer. I'm fine with dropping this patch.

Bart.

