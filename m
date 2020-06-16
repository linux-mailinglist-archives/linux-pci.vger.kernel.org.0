Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8A1FA9F2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPHdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 03:33:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F38C05BD43;
        Tue, 16 Jun 2020 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TCESyuutW94Yi9hrCxtJaxfygdsqJ+GfwqDZdSbMGZ0=; b=tCpmXscqbiULhnYZLCtyvgelRm
        F0q+HF25wSHigEGiq9ojEMmws7IWh/6fv0QX91lkaVOvsCuJaF/mUojzH80LU60cu7s1oYVocJLy5
        V8cqeWNrj0eHquJ4CRB9Yei9Zk/IQT/dmYwQXS55kK2CGyFV3/DPed7ZwltilqznodPTb2EJ+190q
        M0ak5iWUzj7LJtLe0fnWMSJM7PMSOW8JN6uRCIX6PEOLkHYGmnORq9E0MasgO4qL3TpU8OU52qV3F
        ZJSYyNx+z5OqATcbti4fbIUMZnfp1NxnZnAXHdW6dT3aickDAcfMQ9E9zNu/Fef5tNXgZnckCkDAd
        0ozQ/Yrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl65R-0002Dk-Ek; Tue, 16 Jun 2020 07:32:49 +0000
Date:   Tue, 16 Jun 2020 00:32:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200616073249.GB30385@infradead.org>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616011742.138975-4-rajatja@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 06:17:42PM -0700, Rajat Jain via iommu wrote:
> This is needed to allow the userspace to determine when an untrusted
> device has been added, and thus allowing it to bind the driver manually
> to it, if it so wishes. This is being done as part of the approach
> discussed at https://lkml.org/lkml/2020/6/9/1331

Please move the attribute to struct device instead of further
entrenching it in PCIe.  I'm starting to grow tired of saying this
every other week while you guys are all moving into the entirely
wrong direction.
