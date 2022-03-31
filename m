Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF64ED952
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiCaMJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiCaMJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 08:09:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936E61FE56E;
        Thu, 31 Mar 2022 05:07:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 436B31F37D;
        Thu, 31 Mar 2022 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648728465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlVb8m4lD5nimCufr4J8BkEVVy0pSTB0wUKUXvGiKnQ=;
        b=VJejwbt3RxRmaYOVd1RAWzivrVwG65IbtZJVfYR1+mkdyXwez+30xwMANrUtS7Cotf+5sW
        Jqk9t8vopsgag21ZNwg+52bgnHGJi1nADVLq7av+aYNOUqC5vp8ZvvVc5IvdnFOtOXQycn
        t1+tFulT08XoAsEAzubY6hIku5GMdZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648728465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlVb8m4lD5nimCufr4J8BkEVVy0pSTB0wUKUXvGiKnQ=;
        b=WlFEo37T55t/2eFNOZqn1Cg6uLhpMs9esYODcnslYgTZ0+pqwKNkXxi511XeDBPpmO8PtI
        svK/iu/q08qfIsDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33B4E132DC;
        Thu, 31 Mar 2022 12:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cYOWDJGZRWLYCwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 31 Mar 2022 12:07:45 +0000
Date:   Thu, 31 Mar 2022 14:07:44 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     "Belanger, Martin" <Martin.Belanger@dell.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Tanjore Suresh <tansuresh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20220331120744.sb4ai6pa2ahtb3c5@carbon.lan>
References: <20220328230008.3587975-1-tansuresh@google.com>
 <20220328230008.3587975-2-tansuresh@google.com>
 <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
 <SJ0PR19MB4544C3854D2C68853A6E8EA8F21F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB4544C3854D2C68853A6E8EA8F21F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 02:12:18PM +0000, Belanger, Martin wrote:
> I know this patch is mainly for PCI devices, however, NVMe over Fabrics 
> devices can suffer even longer shutdowns. Last September, I reported 
> that shutting down an NVMe-oF TCP connection while the network is down 
> will result in a 1-minute deadlock. That's because the driver tries to perform 
> a proper shutdown by sending commands to the remote target and the 
> timeout for unanswered commands is 1-minute. If one needs to shut down 
> several NVMe-oF connections, each connection will be shut down sequentially 
> taking each 1 minute. Try running "nvme disconnect-all" while the network 
> is down and you'll see what I mean. Of course, the KATO is supposed to 
> detect when connectivity is lost, but if you have a long KATO (e.g. 2 minutes)
> you will most likely hit this condition.

I've debugging something similar:

[44888.710527] nvme nvme0: Removing ctrl: NQN "xxx"
[44898.981684] nvme nvme0: failed to send request -32
[44960.982977] nvme nvme0: queue 0: timeout request 0x18 type 4
[44960.983099] nvme nvme0: Property Set error: 881, offset 0x14

Currently testing this patch:

+++ b/drivers/nvme/host/tcp.c
@@ -1103,9 +1103,12 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
        if (ret == -EAGAIN) {
                ret = 0;
        } else if (ret < 0) {
+               struct request *rq = blk_mq_rq_from_pdu(queue->request);
+
                dev_err(queue->ctrl->ctrl.device,
                        "failed to send request %d\n", ret);
-               if (ret != -EPIPE && ret != -ECONNRESET)
+               if ((ret != -EPIPE && ret != -ECONNRESET) ||
+                   rq->cmd_flags & REQ_FAILFAST_DRIVER)
                        nvme_tcp_fail_request(queue->request);
                nvme_tcp_done_send_req(queue);
        }
