Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1A393715
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhE0UZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 16:25:15 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:45658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235808AbhE0UZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 16:25:07 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0C676180A55F9;
        Thu, 27 May 2021 20:23:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id B9DE4D1516;
        Thu, 27 May 2021 20:23:30 +0000 (UTC)
Message-ID: <b6f3d949ca5c1723001494a371d1a74ef0ff72ed.camel@perches.com>
Subject: Re: [PATCH v5 2/5] PCI/sysfs: Use return value from
 dsm_label_utf16s_to_utf8s() directly
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
        linux-pci@vger.kernel.org
Date:   Thu, 27 May 2021 13:23:29 -0700
In-Reply-To: <20210527201650.221944-2-kw@linux.com>
References: <20210527201650.221944-1-kw@linux.com>
         <20210527201650.221944-2-kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.65
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B9DE4D1516
X-Stat-Signature: gzcomztjwrahh9m8xbyr99tej9jqq4e3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KZGQWYSjdwbFqSkWdoUgNyJGFrAYE+8o=
X-HE-Tag: 1622147010-31965
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-05-27 at 20:16 +0000, Krzysztof Wilczyński wrote:
> Modify the function dsm_label_utf16s_to_utf8s() to directly return the
> number of bytes written into the buffer so that the strlen() used later
> to calculate the length of the buffer can be removed as it would no
> longer be needed.
[]
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
[]
> @@ -139,14 +139,17 @@ enum acpi_attr_enum {
>  	ACPI_ATTR_INDEX_SHOW,
>  };
>  
> 
> -static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
> +static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
>  {
>  	int len;
> +
>  	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
>  			      obj->buffer.length,
>  			      UTF16_LITTLE_ENDIAN,
>  			      buf, PAGE_SIZE);

This should be PAGE_SIZE - 1 no?

>  	buf[len] = '\n';
> +
> +	return len;

return len + 1 ?


