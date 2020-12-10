Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29512D516B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 04:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLJDdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 22:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgLJDdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 22:33:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FCDC061794;
        Wed,  9 Dec 2020 19:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CKPr5ETGh0oX0SSyAT6dUE8iQrUELXNO4VBll75Ml7Y=; b=i2MYcBir69LopxN+00abwoTCcM
        GNmEjZLTP+bV+8H/zlqsloRLM0Szh/wlda8pRkiHniDXIQhDpgZU8bZujvCeg+zjTjllWz15QkLuP
        BUo2d9/rtI3YDPw760gDZAvlbImoLbaKxhpRYN3DIBDmQcqvcADm8avNOAYVA54UcjioWkKhU9mDG
        S//wLXtcaBoKLiT9IGNPHjQSc3bu7wQ9ncx6ydeoj7cqCBqPFpLkPZDjCRYmlCcE/XSszo1h0Xddz
        lu37hKK1iEty7QCnhv2m5esXAF2vMQo4HZG7tEfdBrcV9aXA2tnIwzTQmk/j5hckpL5DiFgOtvzM1
        WA60VriQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knCgs-0003lL-Ec; Thu, 10 Dec 2020 03:32:26 +0000
Subject: Re: [RFC PATCH 09/14] cxl/mem: Add basic IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-10-ben.widawsky@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a252085-9dd9-6cf0-afad-a3ff63cf00d8@infradead.org>
Date:   Wed, 9 Dec 2020 19:32:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209002418.1976362-10-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/8/20 4:24 PM, Ben Widawsky wrote:
> +
> +#define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)

Hi,
I could have missed it, but IOCTL major "numbers" (like 'C') should be
listed in Documentation/userspace-api/ioctl/ioctl-number.rst.


thanks.
-- 
~Randy

