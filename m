Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19FC5AB9E3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 23:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIBVLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiIBVLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 17:11:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BAD91C9;
        Fri,  2 Sep 2022 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662153074; x=1693689074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a5+GIGbZMIwgtbXiPqaRrpL5Or/gY8wT5w0Zi+nQRuE=;
  b=bX2Qw2YbGoDOzSSPoQRnNRnjNlWRIMIStVRKdAWSOE0mceCczc+jVKSA
   ppdtBgcooM/a7btXFO44u6aAM4xduqvQlB9HoJxQL16gIb1WkDigPU3xo
   sjBXy/0s6BFYvqCJIsb4uMyDlBdriXo9iO4H83YbOlRzkYK82gjHreIJI
   2ETWhRPWIjaSDDxvO0UCAV8EzjcFk0pnfQDfXXxz4VhdYBqhR9NKpEaOj
   nnGGBrdn7RLxowNbNM4lMGOljZRhaKCjK4zDv5Tvtqs34vEYlcGKCaU+v
   +vmiguVT5/yMD6tI5wkLEzJKpFqxcPOIkmq+nlCKk4wePfyUuTxOO3xC/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297380682"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="297380682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 14:11:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="674507798"
Received: from cthornbr-mobl.amr.corp.intel.com (HELO [10.251.3.254]) ([10.251.3.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 14:11:13 -0700
Message-ID: <44b33ce9-e0ed-976c-9a13-b154d32b200e@linux.intel.com>
Date:   Fri, 2 Sep 2022 14:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] PCI/PTM: Preserve PTM Root Select
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220902203848.GA370638@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902203848.GA370638@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 9/2/22 1:38 PM, Bjorn Helgaas wrote:
> On Fri, Sep 02, 2022 at 10:24:05AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 9/2/22 7:58 AM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> When disabling PTM, there's no need to clear the Root Select bit.  We
>>> disable PTM during suspend, and we want to re-enable it during resume.
>>> Clearing Root Select here makes re-enabling more complicated.
>>
>> Currently, it looks like we disable PCI_PTM_CTRL_ROOT in pci_disable_ptm(),
>> but not enable it in pci_enable_ptm(). Do you know this did not trigger an
>> issue?
> 
> For Root Ports and Switches, we enable PTM (and set Root Select when
> appropriate) during enumeration in pci_ptm_init().  This is based on
> the assumption that enabling PTM in Root Ports and Switches is a no-op
> unless there's an Endpoint that generates PTM Requests.  (It turns out
> that's not quite true, because Kai-Heng's bug report [1] shows the
> 08:00.0 Switch sending PTM Requests even though no Endpoint even has a
> PTM Capability.)
> 
> If we didn't enable PTM in Root Ports and Switches during enumeration,
> we'd have to walk the whole path and enable them when enabling PTM for
> an Endpoint.
> 
> pci_enable_ptm() currently only works for Endpoints, which cannot be
> PTM Roots, so it never has to set PCI_PTM_CTRL_ROOT.
> 
> If we clear PCI_PTM_CTRL_ROOT in pci_disable_ptm(), it will never get
> set again unless we re-enumerate the Root Port.

Thanks for clarifying.

> 
> Thanks for asking this, because it reminds me why I didn't add
> pci_enable_ptm() calls in the resume paths!  That would make them
> parallel with the suspend paths, which would definitely be nice.  But
> we would have to rework pci_enable_ptm() to work for Root Ports and
> Switch Ports as well.  I think we *could* do that.  What do you think?

IMO, the code will look better if we keep the suspend and resume paths in
sync. Since we are calling pci_disable_ptm() in suspend path, it makes
sense to call pci_enable_ptm() in resume path.

Making the pci_enable_ptm() handle root and upstream ports should not
be very complicated, right?

> 
> Regardless of that question, I think it's unnecessary to clear
> PCI_PTM_CTRL_ROOT in pci_disable_ptm(), so we should leave it alone.

I agree with you. We should not touch PCI_PTM_CTRL_ROOT in pci_disable_ptm().

> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215453
> 
>> Also, you mentioned that it is complicated to enable it, can you add some
>> details?
>>
>>> Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
>>> this Time Source is the PTM Root," so if PTM Enable is cleared, the value
>>> of Root Select should be irrelevant.
>>>
>>> Preserve Root Select to simplify re-enabling PTM.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: David E. Box <david.e.box@linux.intel.com>
>>> ---
>>>  drivers/pci/pcie/ptm.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
>>> index 368a254e3124..b6a417247ce3 100644
>>> --- a/drivers/pci/pcie/ptm.c
>>> +++ b/drivers/pci/pcie/ptm.c
>>> @@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>>>  		return;
>>>  
>>>  	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
>>> -	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
>>> +	ctrl &= ~PCI_PTM_CTRL_ENABLE;
>>>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
>>>  }
>>>  
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
