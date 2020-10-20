Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62826293E20
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407793AbgJTOGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407726AbgJTOGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 10:06:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D886C061755;
        Tue, 20 Oct 2020 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JRvHlEJrGZFiOQKd1c2qmCNGUvUh3oAWJT1Un94riZY=; b=gvRL5jmqVlrSmqjtvh0XTnm3LD
        56PFyUXzXu+eC4lCU08E0kxKs8Q/QA/WRfHBOm00tJjhrRZXpO1qjQqsT5JzYwi6qvhCO37cF+3vJ
        H0jxwJjRpia5kUbKeSu3x5RbPTurkjqzcbJVRIgudqWxJzpcKVCafy2tR8NVho4grfwF5JXi9uZoQ
        T2cYSdOWENtQIW7gGGUveU0tgHXwoYGyzr/ujhAMB0KW8GgGr1q+LopITW5r6mGYAcUUo1W+gx6t5
        PkpXw7UABl4GafrQhHi37PsNqzJpSiX1DnfNZsHMbuYPZFM9E4p09sPMHp2G2NTw0D2Pam0ukZZoc
        FknIoJLw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUsHZ-0006kQ-VG; Tue, 20 Oct 2020 14:06:34 +0000
Subject: Re: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
References: <20201019061453.32295-1-rdunlap@infradead.org>
 <20201020080219.GA21011@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45b16450-320b-86fd-603e-4fb311c6f4bd@infradead.org>
Date:   Tue, 20 Oct 2020 07:06:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020080219.GA21011@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/20 1:02 AM, Christoph Hellwig wrote:
> On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
>> Fix a build error in drivers/mfd/ioc.o by exporting
>> pci_find_host_bridge().
>>
>> ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
> 
> I think the mfd code should be fixed to not depend on such an internal
> symbol instead.
> 

Thanks for commenting. and I am not surprised.

Adding Cc: for Thomas and Lee.

-- 
~Randy

