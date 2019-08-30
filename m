Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0090A3BF3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3Q0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 12:26:51 -0400
Received: from foss.arm.com ([217.140.110.172]:34696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfH3Q0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA47344;
        Fri, 30 Aug 2019 09:26:50 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5188D3F718;
        Fri, 30 Aug 2019 09:26:48 -0700 (PDT)
Subject: Re: [PATCH] PCI: Move ATS declarations to linux/pci.h
To:     Christoph Hellwig <hch@infradead.org>,
        Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190830150756.21305-1-kw@linux.com>
 <20190830161840.GA9733@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <26a81b41-515b-2ed8-98db-7ae164ee8dd8@arm.com>
Date:   Fri, 30 Aug 2019 17:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190830161840.GA9733@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/08/2019 17:18, Christoph Hellwig wrote:
> On Fri, Aug 30, 2019 at 05:07:56PM +0200, Krzysztof Wilczynski wrote:
>> Move ATS function prototypes from include/linux/pci-ats.h to
>> include/linux/pci.h so users only need to include <linux/pci.h>:
> 
> Why is that so important?  Very few PCI(e) device drivers use ATS,
> so keeping it out of everyones include hell doesn't seem all bad.

Although to be fair it seems that all the actual ATS stuff already moved 
out 4 years ago, so at the very least maybe it would warrant renaming to 
pci-pri-pasid.h :)

Robin.
