Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D2617103
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKBWyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBWyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 18:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD455DED9;
        Wed,  2 Nov 2022 15:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7590061C63;
        Wed,  2 Nov 2022 22:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9370BC433C1;
        Wed,  2 Nov 2022 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667429647;
        bh=szbfqZa0C5YWU/D4uudQpUJ6fj3QVdxllMIIA78eON8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lkNj5+hEJDf00QkTXN+DBNDh7TmU5jfOLeok5fAbOqwLKGigs6IKnvUL+PJRPKDf9
         PDbiTtTL2nak0UwFZ7ENPKw9oYvOCKJpowuvNMVaAMBN1OKAagRvr895wDmV0MWWDt
         XaVFRHLFaNzKL+bXBp6fG2q/bNDq+W142o8DfuitPUqjf50wmf9YqkQvP1yoIlGYts
         3N91VWuMA0SW+BpNcSs8CpsIzzZdi1cYp1PWVUf5+S1boFCXmCNymLFIAuHaZf8j/7
         HOhmrNb3Mn9twFdjXcYy6A5+1tBF9X4wwppm63fzoC6Vuo3UkiYGRthngB1a9L9uEw
         WFs8FGmKnGD4A==
Date:   Wed, 2 Nov 2022 17:54:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221102225406.GA5803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102171524.thsz2kwtirhxn7ee@offworld>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 10:15:24AM -0700, Davidlohr Bueso wrote:
> On Tue, 25 Oct 2022, Bjorn Helgaas wrote:
> ...

> > The MSI case is ugly because the Interrupt Message Number can change
> > when we set Multiple Message Enable.  Maybe we can separate it out and
> > have a less than optimal solution for this case, like allocating one
> > or two vectors and polling if that's not enough.  I expect most
> > devices will support MSI-X.
> 
> Would only supporting MSI-X be so terrible?

My gut feeling is that polling when MSI-X isn't supported wouldn't be
terrible, but I have no data on how common devices that only support
MSI are.

Bjorn
