Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF2379338
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhEJP7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:59:03 -0400
Received: from ale.deltatee.com ([204.191.154.188]:34532 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhEJP7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 11:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=PJ2TGMvunRgbLOMNaLpECMSQ7u+Yoj2zFlT7elV+KXg=; b=iF95FesFen2c6YLjciyAoIBsi5
        J7XzAI4MZig/8h2TwJXt0gy3lQhhWVfjR28C4e5crYdi9FcxISSMCGWbl5L8wXf3Fn0UHJ77IVaTu
        tUtVsHZlHpGL2HlrpG3ucLy4CeMXt73BP+DV3oPeUxEyN0dxckYtGN54nvTn0Jl4unXTe5lMvMGhd
        lzFGNzUnRlDk89iujq2AosZ6G6pJMNPR655ee9POyI/IJnRDrT80+RuhtdIZXhwWmtuwt3Spg1Ej4
        34cacB/8bgwuc7M5wCmk4QxoCe/yB40DFMWSl0ig5TowVG+B6rvWWD9nXSDlaBP6GbV7DZZ5H3faF
        GqnPNBkA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lg8I5-0001nE-Ql; Mon, 10 May 2021 09:57:54 -0600
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20210510041424.233565-1-kw@linux.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4557364b-76ce-3555-e97d-14f39eda27b8@deltatee.com>
Date:   Mon, 10 May 2021 09:57:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, ruscur@russell.cc, tyreld@linux.ibm.com, paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au, oohall@gmail.com, bhelgaas@google.com, kw@linux.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 01/11] PCI: Use sysfs_emit() and sysfs_emit_at() in "show"
 functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-09 10:14 p.m., Krzysztof Wilczyński wrote:
> The sysfs_emit() and sysfs_emit_at() functions were introduced to make
> it less ambiguous which function is preferred when writing to the output
> buffer in a device attribute's "show" callback [1].
> 
> Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
> and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
> latter is aware of the PAGE_SIZE buffer and correctly returns the number
> of bytes written into the buffer.
> 
> No functional change intended.
> 
> [1] Documentation/filesystems/sysfs.rst
> 
> Related to:
>   commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Thanks, this is a great cleanup. I've reviewed the entire series.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

I agree that the new lines that are missing should be added.

Logan
