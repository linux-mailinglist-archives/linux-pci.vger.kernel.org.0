Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68472271A40
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUE6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 00:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIUE6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 00:58:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255EC061755;
        Sun, 20 Sep 2020 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HQ/UY9FTcQifDZrg/8Ivhz0s2Q2BGUsiN0dGMhFdZV4=; b=RvfoFYsqhoGiy/me9DxKoQcWpc
        7o5uO2ngHb7ubGtZV0aF/+Roa5HZo3l0iuLowdvanKGFTfaNvvBuBG415GvShueyUT19RbjQdfye7
        Zbx2RH/tiaYM+QfzwHoMhRKcqay1A8jpJA6eCSZO5ShDBNz8dFkH+BGbQ0t7ldAV72tTE7Za41w8Y
        TC0vjwZ1o3j6cCge6yeQHJ5ZR010S/zw/pP9J0fuNLD15aukcf9U6UOWSIY+ZmdoyhzULhBpL0F1R
        W639KUdeB1IqnbwrMZyJFr5+G0r8SSvq7fFSED27XFtjPBu4uPkRQiqJBbWDOBQahs84wh5/EH5h5
        o5E1ZqFA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKDuC-0000QV-EL; Mon, 21 Sep 2020 04:58:24 +0000
Subject: Re: [PATCH v5 14/17] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-15-kishon@ti.com>
 <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
 <c8b7fa2b-5586-3929-1e00-8473106935f9@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <afa7a7c9-a954-d82c-3b67-7c98bac164de@infradead.org>
Date:   Sun, 20 Sep 2020 21:58:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c8b7fa2b-5586-3929-1e00-8473106935f9@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/20 9:52 PM, Kishon Vijay Abraham I wrote:
> Hi Randy,
> 
> On 18/09/20 9:45 pm, Randy Dunlap wrote:
>> On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
>>> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
>>> new file mode 100644
>>> index 000000000000..6197d1aab344
>>> --- /dev/null
>>> +++ b/drivers/ntb/hw/epf/Kconfig
>>> @@ -0,0 +1,6 @@
>>> +config NTB_EPF
>>> +	tristate "Generic EPF Non-Transparent Bridge support"
>>> +	depends on m
>>> +	help
>>> +	  This driver supports EPF NTB on configurable endpoint.
>>> +	  If unsure, say N.
>>
>> Hi,
>> Why is this driver restricted to 'm' (loadable module)?
>> I.e., it cannot be builtin.
> 
> I'm trying to keep all the host side PCI drivers corresponding to the
> devices configured using endpoint function drivers as modules and also
> not populate MODULE_DEVICE_TABLE() to prevent auto-loading.
> 
> The different endpoint function drivers (right now only pci-epf-test.c
> and pci-epf-ntb.c) can use the same device ID and vendorID for
> configuring the endpoint devices. So on the host side, it's possible an
> un-intended PCI driver can be bound to the device. So in-order to give
> users the flexibility of deciding the driver to be bound, I'm trying to
> keep it as modules. (Some driver like NTB also uses class code
> PCI_CLASS_MEMORY_RAM for binding a driver in addition to deviceID and
> vendorID but it need not be the case for all the drivers.)

Thanks for the explanation.

-- 
~Randy

