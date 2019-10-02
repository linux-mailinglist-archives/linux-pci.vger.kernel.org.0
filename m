Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1365CC9443
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 00:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJBWXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 18:23:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40924 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBWXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 18:23:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so709505wru.7
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2019 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=keeGRcww+2ZjpVmZMtgTqHBqPPqJQfw6pQwl0zpofrA=;
        b=FJx7eWIwCVeOxfK1REGaB4RLeZEESll8KbIs8k05rktp+xk+OeGi4yTYhEjVQMwK/f
         fkcuVwWYKgPgVO0SLJsgv+6gQPy+Fp3CBglLCFMp0nnqgPG0TqiqtY49qGVDYqJMmjpr
         +iGvxbjPgZ5lKbL7IZbCHerinCw5JZGFG0tkes3EUk/qLVer7EZT54Ee8OqC0xEp7+4c
         CaNoBl36itEVi7u/vgpMiqdG6e5jyQDpsrlVDjC9i6fTsBj0BkILgVHKOhPtr/Mz95Qk
         1I2GxhIhvYuzldbQngxuy2lwfrPbb0/tR4X/c9WYfeoftuVb+GjauxQN6iaAncq+4kz5
         mLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=keeGRcww+2ZjpVmZMtgTqHBqPPqJQfw6pQwl0zpofrA=;
        b=F/F3r+5k2Sjh5XiyZN8Wofr7uSzWBQ6mZa54KIV+irFbgXkuW+KvAntFhDm/YwHzBR
         rQYaYHPMhRy57hD3kx/LAgwS7V2OKBsPgwE5ffjYAp+sNLX0ZR4jZOg3jwp+A2mf85zl
         2p8EqUoG8CkrMht9uoUo+yDqAgX4RqvQGxcxH9DMkgu9nA21NgPNIAfRjGsiOsL9WlHv
         usnXkMOxzY7CgDXL9LUAmhebtxvzB4M4Iklp3H0j/BA/RbNgwFuuD2a1XP71xFXHUlQo
         kMSP07G3p2/QOX8GQap7LavlYV0OmUyzMtTBTDYEs/HAFRhXo+mKpCfLsq+s4642tN0Q
         sGhA==
X-Gm-Message-State: APjAAAWLy6rtWdgq3fXer6SGkQsJrT2K1c0UlyxbIk/wgG/p4rlMTPio
        RV9SCDN8lkDUVMbkdo714yXWB44F
X-Google-Smtp-Source: APXvYqxfDtZFyBVyAtoTdWouKypRgcuCWfKP89gpw6xmj/ueTBg2jJVLkWXQogB+CizWP0FAYS3hbA==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr4510413wre.176.1570055013494;
        Wed, 02 Oct 2019 15:23:33 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:9cd0:52ca:b438:97d1? (p200300EA8F2664009CD052CAB43897D1.dip0.t-ipconnect.de. [2003:ea:8f26:6400:9cd0:52ca:b438:97d1])
        by smtp.googlemail.com with ESMTPSA id 90sm1065872wrr.1.2019.10.02.15.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 15:23:32 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20191002221054.GA71395@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0cb05387-54c9-d1af-eab5-41ee97a4627e@gmail.com>
Date:   Thu, 3 Oct 2019 00:23:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002221054.GA71395@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.10.2019 00:10, Bjorn Helgaas wrote:
> On Wed, Oct 02, 2019 at 11:10:55PM +0200, Heiner Kallweit wrote:
>> On 02.10.2019 21:55, Bjorn Helgaas wrote:
>>> On Sun, Sep 29, 2019 at 07:15:05PM +0200, Heiner Kallweit wrote:
>>>> On 07.09.2019 22:32, Bjorn Helgaas wrote:
>>>>> On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:
> 
>>>>>> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
>>>>>
>>>>> I know the ASPM code is pretty confused, but I don't think "parent
>>>>> link" really makes sense.  "Parent" implies a parent/child
>>>>> relationship, but a link doesn't have a parent or a child; it only has
>>>>> an upstream end and a downstream end.
>>>>>
>>>> I basically copied this "parent" stuff from __pci_disable_link_state.
>>>> Fine with me to change the naming.
>>>> What confuses me a little is that we have different versions of getting
>>>> the pcie_link_state for a pci_dev in:
>>>>
>>>> - this new function of mine
>>>> - __pci_disable_link_state
>>>> - pcie_aspm_enabled
>>>>
>>>> The latter uses pci_upstream_bridge instead of accessing pdev->bus->self
>>>> directly and doesn't include the call to pcie_downstream_port.
>>>> I wonder whether the functionality could be factored out to a generic
>>>> helper that works in all these places.
>>>
>>> Definitely.  I think your pcie_aspm_get_link() (from the v6 patch)
>>> could be used directly in those places.  You could add a new patch
>>> that just adds pcie_aspm_get_link() and uses it.
>>>
>>
>> OK
>>
>>>>>> +{
>>>>>> +	struct pci_dev *parent = pdev->bus->self;
>>>>>> +
>>>>>> +	if (pcie_downstream_port(pdev))
>>>>>> +		parent = pdev;
>>>>>> +
>>>>>> +	return parent ? parent->link_state : NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +	struct pcie_link_state *link;
>>>>>> +
>>>>>> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>>>>>
>>>>> Do you intend to exclude other Upstream Ports like Legacy Endpoints,
>>>>> Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
>>>>> a link leading to them, so we might want them to have knobs as well.
>>>>> Or if we don't want the knobs, a comment about why not would be
>>>>> useful.
>>>>>
>>>> My use case is about endpoints only and I'm not really a PCI expert.
>>>> Based on your list in addition to PCI_EXP_TYPE_ENDPOINT we'd enable
>>>> the ASPM sysfs fils for:
>>>> - PCI_EXP_TYPE_LEG_END
>>>> - PCI_EXP_TYPE_UPSTREAM
>>>> - PCI_EXP_TYPE_PCI_BRIDGE
>>>> - PCI_EXP_TYPE_PCIE_BRIDGE
>>>> If you can confirm the list I'd extend my patch accordingly.
>>>
>>> Yes, I think the list would be right, but looking at this again, I
>>> don't think you need this function at all -- you can just use
>>> pcie_aspm_get_link().  Then aspm_ctrl_attrs_are_visible() uses exactly
>>> the same test as the show/store functions.  Actually, I think then you
>>> could omit the "if (!link)" tests from the show/store functions
>>> because those functions can never be called unless
>>> aspm_ctrl_attrs_are_visible() found a link.
>>>
>> Right, the !link checks can be removed from the show/store functions.
>> In pcie_is_aspm_dev() I think we need to check at least whether
>> device is PCIe and whether link is ASPM-capable. Making the sysfs
>> attributes visible for a non-PCIe device doesn't make sense,
>> the same applies to PCIe devices with a link that is not ASPM-capable.
> 
> I agree we don't want these attributes visible for non-PCIe or
> non-ASPM-capable situations, but I think you can do this:
> 
>   static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
>   {
>     struct pci_dev *bridge = pci_upstream_bridge(pdev);
> 
>     if (bridge)
>       return bridge->link_state;
> 
>     return NULL;
>   }
> 
>   static umode_t aspm_ctrl_attrs_are_visible(...)
>   {
>     ...
>     if (pcie_aspm_get_link(pdev))
>       return a->mode;
> 
>     return 0;
>   }
> 
> We can rely on pcie_aspm_init_link_state() to only set
> bridge->link_state if the devices on both ends of the link are PCIe
> and support ASPM.
> 
With the first one I agree. However there may be links where e.g. the
bridge doesn't support ASPM. One example is my small Zotac test system:

Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port
 LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM not supported
