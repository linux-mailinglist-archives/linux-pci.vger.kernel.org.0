Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9988826CC27
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgIPUjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgIPRGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 13:06:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F8C0611BC;
        Wed, 16 Sep 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PKWr6P6N/QvHgzN9Xr6p5YvfrLnhJZhCYTZt2ESdvQg=; b=FjA3jDsdaleXkbpXiv8ZZ4gEG8
        42Luzslojh4iE42ezrc4nnWSBJY1cvbqdCn0be3m2PrY+/qV+xeM3FPIc5i/hS4bKQhb2FYlnn6lp
        KIINRq35vdlKp2bbEulH4S14v7QzXM6Kq7rKcxamEObgWIoT+/B8pVff3CBkfTyazyGjoj6asPgfs
        /1X0AQlg2Hr3rfCe1AaJ+amPlnH8cSbdVuFle+0vQvqWDxZgmgt8o3Vj1gnLLGgHOpwgxndrQFoeK
        hdvrSrtX5RR4OTcunOK8GJEAH0tkrfLM7feW+tGeZ3IMaJ09mZT4Dtd8NozktXqdrn2X5v4fy0epv
        kAxltcxw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIasZ-0005LY-SK; Wed, 16 Sep 2020 17:06:00 +0000
Subject: Re: [PATCH v4 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
References: <20200915042110.3015-1-kishon@ti.com>
 <20200915042110.3015-18-kishon@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17b7c073-d358-e274-c783-1a17590a83a3@infradead.org>
Date:   Wed, 16 Sep 2020 10:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915042110.3015-18-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/14/20 9:21 PM, Kishon Vijay Abraham I wrote:
> Add documentation to help users use pci-epf-ntb function driver and
> existing host side NTB infrastructure for NTB functionality.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/PCI/endpoint/index.rst         |   1 +
>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
> 

LGTM. Thanks for the update.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy
