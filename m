Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245992336C9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgG3Qae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:30:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37466 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG3Qad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 12:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596126631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YevQX1VHTFN4SBHMVbBI1dM77Ga4DJck4nyx6dAE2uU=;
        b=H5IBKmX4cTa3dZXHUQeCvliP+F971hYd4E0rbNV+zx6FXjhS9xjprw9iwoEX0cMyuTXvGk
        dShXsbWlZMh4E4IMVqcKkaZAOtWgSi7KNplJ1WUicC7/wHyqMdp/ymavILsCAzmQVX2iim
        wzrkJDQAjOjfNFb5/aKSi4f1M+XMb10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Ri2hXDitMBCG3-1ESokb_Q-1; Thu, 30 Jul 2020 12:30:28 -0400
X-MC-Unique: Ri2hXDitMBCG3-1ESokb_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC74980046A;
        Thu, 30 Jul 2020 16:30:26 +0000 (UTC)
Received: from [10.3.114.169] (ovpn-114-169.phx2.redhat.com [10.3.114.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3148E1002393;
        Thu, 30 Jul 2020 16:30:23 +0000 (UTC)
Subject: Re: [PATCH] PCI: Put the IVRS table in AMD ACS quirk handler
To:     Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200729230242.GA1974304@bjorn-Precision-5520>
 <74348feb-5646-6d33-1a84-532f9179df78@huawei.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <c482514b-7156-dc7a-94e1-df004fa9185d@redhat.com>
Date:   Thu, 30 Jul 2020 12:30:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <74348feb-5646-6d33-1a84-532f9179df78@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/30/20 2:14 AM, Hanjun Guo wrote:
> On 2020/7/30 7:02, Bjorn Helgaas wrote:
>> [+cc Alex, Don]
>>
>> On Wed, Jul 22, 2020 at 05:44:28PM +0800, Hanjun Guo wrote:
>>> The acpi_get_table() should be coupled with acpi_put_table() if
>>> the mapped table is not used at runtime to release the table
>>> mapping.
>>>
>>> In pci_quirk_amd_sb_acs(), IVRS table is just used for checking
>>> AMD IOMMU is supported, not used at runtime, put the table after
>>> using it.
>>>
>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Applied to pci/virtualization for v5.9, thanks!
>>
>> I added this:
>>
>>    Fixes: 15b100dfd1c9 ("PCI: Claim ACS support for AMD southbridge devices")
>>
>> but I didn't add a stable tag.  Does this cause any issue that would
>> warrant a stable tag?
>
For most of our (bug-fix & functional backport tooling) we focus on 'Fixes' and not
specific stable tagging, since our kernel becomes quite a mix of upstream once we venture much past the RHEL-X.0 GA.
I have seen others that use/reference the stable trees as another sanity check; or a way to
modify a RHEL kernel source into their own private use. Thus, RHEL doesn't have as strong a dependency on stable, as much as it does upstream-tip.

> We don't have one when I was sending same function patch for ACPI
> subsystem, so I think it's OK to without a stable tag for this
> patch as well.
>
> Thanks
> Hanjun
>

