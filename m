Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512BC29BFB
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbfEXQSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 12:18:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:56422 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfEXQSr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 12:18:47 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hUCu5-0007Vc-Jm; Fri, 24 May 2019 10:18:46 -0600
To:     Christoph Hellwig <hch@lst.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
 <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
 <20190523155922.GA21552@lst.de>
 <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
 <20190524141215.GB23514@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8aedfd92-a5a4-485a-42c3-8e26ac87c3ba@deltatee.com>
Date:   Fri, 24 May 2019 10:18:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524141215.GB23514@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, Christian.Koenig@amd.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-24 8:12 a.m., Christoph Hellwig wrote:
> I think we've got two escalation levels here:
> 
>  (1) fix the NVMe/RDMA p2p breakage for 5.2-rc - for that we just need
>      the above fix in the p2p map_sg routine (and add an unmap_sg
>      routine there)

Yes, fixing the p2p_map_sg routine or add the check if the iommu is
present (as I did in the patch that started this discussion) until we
can get the map stuff sorted out.

Logan
