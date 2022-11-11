Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72656263CC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiKKVuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 16:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiKKVuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 16:50:01 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86602742F0;
        Fri, 11 Nov 2022 13:50:00 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D1023760FC6;
        Fri, 11 Nov 2022 21:41:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D0D0C76117C;
        Fri, 11 Nov 2022 21:41:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668202870; a=rsa-sha256;
        cv=none;
        b=o48QMUiqb1hAZ9RFIdjbkZYwN4IDIW4yAw5o9zTW3KiTSHw2GFnXCBS7jBqkk/T+VGZitq
        ij/ov4dvq3QLixvis3Q0lkKwDXxR7m8yn9OWAS46QmIxiFqMP63S3/3EkTIwoBb6HmLjGK
        MBQSDeWAOwbZIX9ht+PvD1P+N3BhCRF7rUEBVHeG7p9qHP9Ch5bG+qFSRzhWaxfo5DKT4x
        ROGyZtHednHLlL6Y0hIQbBfaY1DWeyxJOh7mrCDJ8b6JYAFVsEr/l56u+mPQtxjZ2fK9xV
        iDFQU08ceSgTecHeNhv9WykwxrtfiectkDdZsdGgPCv4BC+uPc4Nv3ms3p5jxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668202870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Hq9dKS4i1VQNcbbZP+QPp8DOjflWFMb+umRCLNBhTJQ=;
        b=TT+ZF1jRP1iNBZ+mWgzf0CfSRNI7biyKCcq6lYv2QCiwzhCwjv5hPG4QYcmXQhUJLH6NkZ
        bSRqlKqMJ8bVL2r81DJ2+5l/xDVveGk8QyidWZqtrWyv5/aIf5+wPtgoDa9MC7njA4H+3x
        /yN9RYm9QyZXo7OMhxozmyo2PGE8VzPqSUAtBLQE69+bFrryM2yt2J/GxkBLYqLh1Y7gzv
        +Gb1oAyiHmR5oB5hH9G8QEAxVhadE/Y80vlZ2xwZvFMClhKQPgVB8WvDNqWaxKndO3DJkK
        Hoo3Jr/Q5597Kpl9WF9Nta3TCmyNyXaTLwnE5y72WwLb6cfbrMcVRDL40Bhs6A==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-sqctg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Desert: 32bc850f4a43a6a6_1668202870359_4085239864
X-MC-Loop-Signature: 1668202870359:4015605638
X-MC-Ingress-Time: 1668202870359
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.119 (trex/6.7.1);
        Fri, 11 Nov 2022 21:41:10 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4N8BwN5M7TzFQ;
        Fri, 11 Nov 2022 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1668202869;
        bh=Hq9dKS4i1VQNcbbZP+QPp8DOjflWFMb+umRCLNBhTJQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=W637b59BaCXan9XMrzVbb0qQLR1CzH9rpBLEwRhCmbDFz+Bcj5vqLZzM+MGv78Vav
         If2HzmdV/D9Ae9b/PzKCq41xi+0r1lWSNtA82/47irTXHBqCFPCqxXVHp07J+g/VA7
         3HyJCPVARGpd1UoZjwH+6ztE+aYJfIEmTn1zaB4Om1acmuwe42GWlwaPNG+Ri9GJLn
         MxfbhOxHczVKeqtXtrE/0olRev3Y/D1cfgxkNOSsEcYfXPVMKisfoE2KV02CWfBiBQ
         rNAB8XwAGwjnNoYJfs8+EIsAAJXBaMbMkjvzFx0EPme7zfYzsgRQUGpYQDT5G805RJ
         nLkd4YPNtXbSA==
Date:   Fri, 11 Nov 2022 13:18:32 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221111211832.zfjtehrk4fhjcjea@offworld>
References: <20221024133633.00000467@huawei.com>
 <20221025232535.GA579167@bhelgaas>
 <20221102171524.thsz2kwtirhxn7ee@offworld>
 <Y2MAdaCES+aUc2QH@iweiny-desk3>
 <20221103001833.n2gsoflnji3pcsfr@offworld>
 <20221103180916.00000bae@Huawei.com>
 <Y2xwbYEKKc9KXUDy@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2xwbYEKKc9KXUDy@iweiny-desk3>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 09 Nov 2022, Ira Weiny wrote:

>Unfortunately the following does not work with the current Qemu.
>
>/*
> * NOTE: Currently all the functions which are enabled for CXL require their
> * vectors to be in the first 16.  Allocate this number as the min/max.
> */
>#define CXL_PCI_REQUIRED_VECTORS 16
>
>...
>
>        rc = pci_alloc_irq_vectors(pdev, CXL_PCI_REQUIRED_VECTORS,
>                                   CXL_PCI_REQUIRED_VECTORS,
>                                   PCI_IRQ_MSIX | PCI_IRQ_MSI);
>
>This is because Qemu CXL devices only support (with the event changes I have
>made) 8 msg numbers.  So the code fails to allocate any vectors.
>
>I guess I should have known better.  But allocating something less than 16 I
>guess needs to be allowed.
>
>But that also means that beyond knowing _if_ irq's have been enabled I think
>each CXL feature needs to know the number of vectors allocated so they can
>ensure their msg numbers are going to work.
>
>So how about the following as a diff to this patch?
>
>In the event code I have then used the nr_irq_vecs field to determine if I
>should enable the irq for each log.
>
>If you are ok with it I'm going to squash it into your patch and send out a new
>version of the event log series.

LGTM, thanks.
