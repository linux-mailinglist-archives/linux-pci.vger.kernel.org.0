Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35DF222681
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGPPIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGPPIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 11:08:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D2C061755;
        Thu, 16 Jul 2020 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1bJOTpyq8vHLitPae/7o/ebaPgbG/UCSEh62yEag0So=; b=OR2Oza7PfYUqqvt2pp2A85nLit
        DnsmYH9hP9ewqgYWIjuhjhNEUpRaqLAol0yMxQt+Kb6DSmk2pIsMeaW0ImKifpGr2DOkEmqO1vNtc
        XOR5rZbxbCisa6hFLWmQQVlXgR6iteaQ1c0Bea5Hj9dCJoWwO+MkhSV/Kq+O0jZnVdSN1GSemCOwh
        yVHpDm4aPJPqjW98ghmYn4yj3XRPMM8pfJ38OdYWkvRWbtmDG5fD5dgzNw1Qs8qB+RI661X9qbPpZ
        RJDiCAqyMBx+FzCFsI1apYR0D6kzZhmW1WYZCIev95XHJzlkAL5g+8OgB9zkvgT0Ib+wXCnfk6jqx
        ps14ZHPg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw5UP-0004op-Gj; Thu, 16 Jul 2020 15:08:01 +0000
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific
 Capability
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200716150706.GA628795@bjorn-Precision-5520>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <960e7d50-7c6c-45fa-c57e-5c52b5c1e192@infradead.org>
Date:   Thu, 16 Jul 2020 08:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716150706.GA628795@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/16/20 8:07 AM, Bjorn Helgaas wrote:
> On Wed, Jul 15, 2020 at 07:55:11PM -0700, Randy Dunlap wrote:
>> On 7/13/20 11:23 PM, David E. Box wrote:
>>> Add PCIe DVSEC extended capability ID and defines for the header offsets.
>>> Defined in PCIe r5.0, sec 7.9.6.
>>>
>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  include/uapi/linux/pci_regs.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index f9701410d3b5..09daa9f07b6b 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -720,6 +720,7 @@
>>> +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>>> @@ -1062,6 +1063,10 @@
>>> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>>> +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
>>> +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */
>>
>> Just a little comment: It would make more sense to me to
>> s/DVSEC/DVSPEC/g.
> 
> Yeah, that is confusing, but "DVSEC" is the term used in the spec.  I
> think it stands for "Designated Vendor-Specific Extended Capability".

Right. I noticed that after I sent the email.

thanks.
-- 
~Randy

