Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD454ED37A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiCaFwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 01:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiCaFwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 01:52:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5582D8E;
        Wed, 30 Mar 2022 22:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ru0LipQtsJl9AfHI2E8ja3nugdvZ7bA5mRsG8tmW7dg=; b=Ft6o+7xJsRLe1NW/RBHGWJCtQZ
        UoX8wy0H4Yg8xnqsLHENlrzhPK4i+2NXFkeRDWtYasXZQtnFMMyG8efX6hYOz/s2xOj2P1W51BYu3
        kFv2PKCOHg2kEOvHnoo/oClWvMuyyl5fSML7EkZuMm1Poy8baW+zUK02UuX8P/YToGwXFJ3DVlcvW
        j1lf8sfp96CvZbvfA8cQgcFhHs4ehgIxvay7tjWkr1ln/Juh4rWejOy+/dW72UXZXT6QhHCDVI2yP
        aDztlR6nsWhDRe+7iwGassRXsWxWLLNcfwXn7zpk08FYvpq84ytJnxO0SD9LUi2wBtRzQ1/tGNfOd
        FK8IfyXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZnhX-000kZo-SM; Thu, 31 Mar 2022 05:50:31 +0000
Date:   Wed, 30 Mar 2022 22:50:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YkVBJ+nRA2g/WDxa@infradead.org>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
 <20220330235920.2800929-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330235920.2800929-4-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> with standard protocol discovery.  Each mailbox is accessed through a
> DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCI functionality to manage a single PCI DOE mailbox at a
> defined config space offset.  Functionality includes creating, supported
> protocol queries, submit tasks to, and destroying the new state objects.
> 
> If interrupts are desired, interrupts vectors should be allocated prior
> to asking for irq's when creating a mailbox object.

I really don't think this should be built unconditionally and bloat
every single kernel built with PCI support.
