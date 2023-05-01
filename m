Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77A6F2E49
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 06:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjEAEBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAEBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 00:01:00 -0400
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B295B86;
        Sun, 30 Apr 2023 20:51:42 -0700 (PDT)
Received: from [IPV6:240e:3b7:327f:5c30:7d8b:c3e:1a47:99e8] (unknown [IPV6:240e:3b7:327f:5c30:7d8b:c3e:1a47:99e8])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id 5C3E83C0223;
        Mon,  1 May 2023 11:51:37 +0800 (CST)
Message-ID: <03b45702-d799-f299-1c24-4e5e2e2897d2@sangfor.com.cn>
Date:   Mon, 1 May 2023 11:50:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ding Hui <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] PCI/ASPM: fix UAF by removing cached downstream
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230501021051.GA543423@bhelgaas>
In-Reply-To: <20230501021051.GA543423@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx5MVhpDTRlMSkkdHhgaGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTB1BThhIS0FMH0MZQRhIHkFKGk9MQUJCHkNZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Tid: 0a87d56ff8062eb2kusn5c3e83c0223
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6Tjo6TT0PCkMUNBYSH0ge
        HiwwCjdVSlVKTUNJQkpIS0JDSk1KVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUwdQU4YSEtBTB9DGUEYSB5BShpPTEFCQh5DWVdZCAFZQU9LSU83Bg++
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/5/1 10:10, Bjorn Helgaas wrote:
> On Sat, Apr 29, 2023 at 09:26:04PM +0800, Ding Hui wrote:
>> If the function 0 of a multifunction device is removed, an freed
>> downstream pointer will be left in struct pcie_link_state, and then
>> when pcie_config_aspm_link() be invoked from any path, we will get a
>> KASAN use-after-free report.
> 
> Thanks for finding this problem, debugging it, and the patch!
> 
> In this case we're doing a "software remove" and the other functions
> are still present, right?  It's kind of annoying that there's only one
> link, but all the functions of a multifunction device have a Link
> Control register, and the spec "recommends" that software program the
> same ASPM control value for all the functions.
> 

Yes, that is the case.

> The hardware of course doesn't know anything about this software
> remove; all the functions are still physically present and powered up.
> 
> That makes me think that if software ignores the "removed" function
> and continues to operate ASPM on the N-1 remaining functions, we're
> outside the spec recommendations because the ASPM configuration is no
> longer the same across all the functions.
> 
> So my inclination would be disable ASPM completely when any function
> of a multi-function device is removed.  What are your thoughts on
> this?
> 

Agree with you.

Previously, I thought another fix that was if the function 0 is removed,
we can free the link state to disable ASPM for this link.

Now following you suggestion, it can be expanded to any child function.

How about fixing like this?

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..657e0647d19f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1011,12 +1011,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
  	down_read(&pci_bus_sem);
  	mutex_lock(&aspm_lock);
  	/*
-	 * All PCIe functions are in one slot, remove one function will remove
-	 * the whole slot, so just wait until we are the last function left.
+	 * All PCIe functions are in one slot.
+	 * The spec "recommends" that software program set the same ASPM control
+	 * value for all the functions.
+	 * Disable ASPM when any child function is removed.
  	 */
-	if (!list_empty(&parent->subordinate->devices))
-		goto out;
-
  	link = parent->link_state;
  	root = link->root;
  	parent_link = link->parent;


-- 
Thanks,
-dinghui

