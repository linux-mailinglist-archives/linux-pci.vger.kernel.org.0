Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1D381637
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhEOFwk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:52:40 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:35258 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234371AbhEOFw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:52:29 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 01:52:29 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 2237118026C30
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 05:43:40 +0000 (UTC)
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 38C29182CED28;
        Sat, 15 May 2021 05:43:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 737E2C4171;
        Sat, 15 May 2021 05:43:36 +0000 (UTC)
Message-ID: <985813cafbbe58cd899737ee49b44798210a69f6.camel@perches.com>
Subject: Re: [PATCH v2 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
From:   Joe Perches <joe@perches.com>
To:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 May 2021 22:43:35 -0700
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Stat-Signature: sktyye3trus7rah3tcedpkwhqfm6xq1a
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 737E2C4171
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19iS+XLPvw0DQLZl4lLIJgMwROnMeU+SbY=
X-HE-Tag: 1621057416-840459
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2021-05-15 at 05:24 +0000, Krzysztof Wilczyński wrote:
> The sysfs_emit() and sysfs_emit_at() functions were introduced to make
> it less ambiguous which function is preferred when writing to the output
> buffer in a device attribute's "show" callback [1].
> 
> Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
> and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
> latter is aware of the PAGE_SIZE buffer and correctly returns the number
> of bytes written into the buffer.
[]
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
[]
> @@ -6439,7 +6439,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  
> 
>  	spin_lock(&resource_alignment_lock);
>  	if (resource_alignment_param)
> -		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
> +		count = sysfs_emit(buf, "%s", resource_alignment_param);
>  	spin_unlock(&resource_alignment_lock);

Ideally, the additional newline check below this would use sysfs_emit_at

drivers/pci/pci.c-      /*
drivers/pci/pci.c:       * When set by the command line, resource_alignment_param will not
drivers/pci/pci.c-       * have a trailing line feed, which is ugly. So conditionally add
drivers/pci/pci.c-       * it here.
drivers/pci/pci.c-       */
drivers/pci/pci.c-      if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
drivers/pci/pci.c-              buf[count - 1] = '\n';
drivers/pci/pci.c-              buf[count++] = 0;
drivers/pci/pci.c-      }
drivers/pci/pci.c-
drivers/pci/pci.c-      return count;
	

