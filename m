Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607E58779F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiHBHOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBHOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 03:14:55 -0400
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 00:14:53 PDT
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0297C48EA2
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 00:14:52 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id ADB6EE0BCD
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 09:08:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de ADB6EE0BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1659424106; bh=9YqpmsjcwJpikvYLgaXPc7bbeSAIsVszCEI64TpqLe4=;
        h=Date:From:To:Subject:From;
        b=v9aDUdn3jHnwa5AEYBFqh2Z+ac5q/T1Ds5O+/5Pk7pV85oDyOvI5Ex7zxrV5jK1n7
         IeOdYh5HtWdj0ub4w3gK16DVMRUQ7s5GxroZqlbOrpraHVn7nMxgtEK+Vk8QYtII1G
         k+lnHCgEJ9T8r7wkBWag6qkFjxQpEXLHYvOXm0Pw=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id A5E6B1202CC;
        Tue,  2 Aug 2022 09:08:26 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 988EC1022BA;
        Tue,  2 Aug 2022 09:08:26 +0200 (CEST)
Date:   Tue, 2 Aug 2022 09:08:26 +0200 (CEST)
From:   "Petrosyan, Ludwig" <ludwig.petrosyan@desy.de>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Message-ID: <246771217.25641247.1659424106574.JavaMail.zimbra@desy.de>
Subject: interesting effect of the get_user_pages and copy_to_user
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4303)
Thread-Index: unYvjquHdkJyUs11qpARW7Z/wxD2JQ==
Thread-Topic: interesting effect of the get_user_pages and copy_to_user
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux kernel team

I am working on PCIe device driver and need to transfer up to 20MB data,
unfortunately the device has no scatter/gather controller, so I have to do in usual way.

in the code it done in the following way (shortlty):

long    ioctl_dma(struct file *filp, unsigned int *cmd_p, unsigned long *arg_p){
 unsigned long  arg;
 arg                              = *arg_p;
 #define SG_MAX_ORDER    10
 max_order_length = (2<<(SG_MAX_ORDER-1))*PAGE_SIZE;
 ppWriteBuf = (void *)__get_free_pages(GFP_KERNEL , SG_MAX_ORDER);
 pTmpDmaHandle      = pci_map_single(pdev, pWriteBuf, max_order_length, PCI_DMA_FROMDEVICE);
 
 1. copy_from_user(&dma_data, (device_ioctrl_dma*)arg, (size_t)io_dma_size)) // get user buffer and data
 2. tmp_dma_size          = dma_data.dma_size;                               // get DMA size from user buffer 
 3. nr_entries = tmp_dma_size/max_order_length;                              // how many DMAs has to be done
 4. for(int i=0; i < nr_entries; ++i){
      Make DMA;
      pci_dma_sync_single_for_cpu(pdev, pTmpDmaHandle, max_order_length, PCI_DMA_FROMDEVICE);
      copy_to_user ((void *)(arg + tmp_user_offset), pWriteBuf, max_order_length)
      pci_dma_sync_single_for_device(pdev,pTmpDmaHandle, max_order_length, PCI_DMA_FROMDEVICE);
      tmp_user_offset += max_order_length;
    }
}
this work fine and gives in user application around 87ms for 20MB.
Than I just do:
get_user_pages( (unsigned long)arg,    // start 
		pDmaUnit->nr_pages,                   // length in pages 
		1,                                 // >0 --> write to user space 
		0,                                  // force. drivers should set 0 
		pDmaUnit->pages,
		NULL);

The DMA time goes to ~50ms (was 87ms)

regards

Ludwig
