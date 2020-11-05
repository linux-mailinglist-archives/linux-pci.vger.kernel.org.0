Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407B2A8563
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 18:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgKER4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKER4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 12:56:35 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC0C0613D2
        for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2020 09:56:34 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m14so1692698qtc.12
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 09:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PkeuaecEHHScjy0gtmL00e+LrPcvo+4cdZQoihz0wZM=;
        b=MBcmsgnrs10gbIIyzWv4uOz9JUTEFxY9v/n9JzvL/W/ZuwJW/GY9YDzqQ6CT8Vc7Ex
         I39mTyNNLmG5UGOMjGKQtDOuUucT8RxUCHx/CIKKSmeUTdwWeHYgBPxrgBYIVq4ZHtjD
         jNw9oAuSYqJW+mTjaNGirHCmz5uBIZZwalyGFSeuQADSuTdIcK3Jxgy9QN2Hs/yNAqu4
         LJEfcxlchXsOTp5ObapYG//92CiXgRoR5TCzi1jlsHAxPl3LnNCSF9eBy0XUryNuVxg7
         HePsWXzXvuf97msTcYoxUEMzzKEkGu22jzfNyAp2VPZ3HYaQUNq2LR105U0VQ3eGj0HM
         hN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkeuaecEHHScjy0gtmL00e+LrPcvo+4cdZQoihz0wZM=;
        b=qXq7f1MZM6mKQtuyU4dACeICbPk3hz+CouHmHb8DxBI4r25A9Dtbt+QLSB5KKi+zy5
         YRd0qAGF0OJaPrqROWWDOPHVedXrj9EPE7ZtKQqpChH+hQNA8FLF10OmXKAZ4MjA+hyj
         B1nIub2T7X1vgpz5FVKn3ZoQico7TaarKIya4RGjIjJvlBL0bVcipyTy46iZgfhc2Vk+
         954plVOi7b94uuwNDL1bhpVwGrHsfZG9gsIRcDsUWL8XmcccRJnOtbnbyLrT6O7k7R+7
         C5Pov/SFRT3tFz4AoPPaSEA+8SakaJD2ZGJugg/uiMFbHf8UOBNcyDzmXf1H3C5HIMuZ
         lqNw==
X-Gm-Message-State: AOAM532vA3YBMScRbwZ9kSmHFAKQkaWTQOTunLU07kCTDfEbexyodHya
        jGA0TAtxmnHA5ZsiXhGpU+Ek8Q==
X-Google-Smtp-Source: ABdhPJyXnJXLghwsZVy8iD37UxR+fSCbD1DVIGylUU63uSdLwghrLTDFjtnDXTTQqgFL31+HeP4bng==
X-Received: by 2002:ac8:5745:: with SMTP id 5mr3150700qtx.226.1604598994165;
        Thu, 05 Nov 2020 09:56:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m26sm1460830qka.118.2020.11.05.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:56:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kajUu-0009Js-Tl; Thu, 05 Nov 2020 13:56:32 -0400
Date:   Thu, 5 Nov 2020 13:56:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105175632.GG36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
 <20201105143418.GA4142106@ziepe.ca>
 <20201105170816.GC7502@lst.de>
 <20201105172357.GE36674@ziepe.ca>
 <20201105172921.GA9537@lst.de>
 <20201105173930.GF36674@ziepe.ca>
 <20201105174306.GA10757@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105174306.GA10757@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 06:43:06PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 01:39:30PM -0400, Jason Gunthorpe wrote:
> > Hmm. This works for real devices like mlx5, but it means the three SW
> > devices will also resolve to a real PCI device that is not the DMA
> > device.
> 
> Does it?  When I followed the links on my system rxe was a virtual
> device without a physical parent.  Weird.

Yes, Bob also might have seen it oddly be virtual too.. No idea why.

This seems like the right thing to do, looks like virtual is only
possible if the netdev is virtual too..

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 575e1a4ec82121..2b4238cdeab953 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,18 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-struct device *rxe_dma_device(struct rxe_dev *rxe)
-{
-	struct net_device *ndev;
-
-	ndev = rxe->ndev;
-
-	if (is_vlan_dev(ndev))
-		ndev = vlan_dev_real_dev(ndev);
-
-	return ndev->dev.parent;
-}
-
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 209c7b3fab97a2..0cc4116d9a1fa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1134,7 +1134,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->num_comp_vectors = num_possible_cpus();
-	dev->dev.parent = rxe_dma_device(rxe);
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
