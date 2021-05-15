Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68F381639
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhEOF5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:57:19 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:59234 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234371AbhEOF5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:57:19 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 9FC1118015997
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 05:46:52 +0000 (UTC)
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C506C837F24C;
        Sat, 15 May 2021 05:46:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 2F27CB2793;
        Sat, 15 May 2021 05:46:49 +0000 (UTC)
Message-ID: <d156a893bae41967e9fadddb3397cf47bcdde239.camel@perches.com>
Subject: Re: [PATCH v2 04/14] PCI/MSI: Use sysfs_emit() and sysfs_emit_at()
 in "show" functions
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
Date:   Fri, 14 May 2021 22:46:47 -0700
In-Reply-To: <20210515052434.1413236-4-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
         <20210515052434.1413236-4-kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2F27CB2793
X-Stat-Signature: rp3kod31ksbmrnhcfid5w6j7hpeaacru
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+UWlX7UgFeALlHHRIUps2+bN3E38NkPWQ=
X-HE-Tag: 1621057609-59859
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
> 
> No functional change intended.
[]
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
[]
> @@ -465,8 +465,8 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  
>  	entry = irq_get_msi_desc(irq);
>  	if (entry)
> -		return sprintf(buf, "%s\n",
> -				entry->msi_attrib.is_msix ? "msix" : "msi");
> +		return sysfs_emit(buf, "%s\n",
> +				  entry->msi_attrib.is_msix ? "msix" : "msi");
>  
> 
>  	return -ENODEV;
>  }

trivia: reversing the test would be more common style

	if (!entry)
		return -ENODEV;

	return sysfs_emit(...);
}


