Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574BF3B934E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhGAO1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 10:27:49 -0400
Received: from verein.lst.de ([213.95.11.211]:47780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhGAO1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 10:27:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4572267357; Thu,  1 Jul 2021 16:25:13 +0200 (CEST)
Date:   Thu, 1 Jul 2021 16:25:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: finish RCU conversion of pdev->p2pdma
Message-ID: <20210701142512.GA23105@lst.de>
References: <20210701095621.3129283-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701095621.3129283-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
