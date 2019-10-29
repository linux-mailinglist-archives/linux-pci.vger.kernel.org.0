Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21EE82A9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 08:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJ2HqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 03:46:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:37689 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfJ2HqD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 03:46:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 00:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="198851286"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2019 00:46:02 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id C0779580372;
        Tue, 29 Oct 2019 00:45:58 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <20191022130905.GA133961@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <f74cdada-c58b-7238-9be1-8b001ca1fb84@linux.intel.com>
Date:   Tue, 29 Oct 2019 15:45:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022130905.GA133961@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/22/2019 9:09 PM, Bjorn Helgaas wrote:
> On Tue, Oct 22, 2019 at 05:07:47PM +0800, Dilip Kota wrote:
>> On 10/22/2019 1:17 AM, Bjorn Helgaas wrote:
>>> On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
>>>> Add support to PCIe RC controller on Intel Gateway SoCs.
>>>> PCIe controller is based of Synopsys DesignWare pci core.
>>>>
>>>> Intel PCIe driver requires Upconfig support, fast training
>>>> sequence configuration and link speed change. So adding the
>>>> respective helper functions in the pcie DesignWare framework.
>>>> It also programs hardware autonomous speed during speed
>>>> configuration so defining it in pci_regs.h.
>>>>
>>>> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>>>> +{
>>>> +	u32 val;
>>>> +
>>>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
>>>> +	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>>>> +	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
>>>> +
>>>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>>>> +
>>>> +	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
>>>> +	val |= (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
>>>> +	       PCI_EXP_LNKCTL_RCB;
>>> PCI_EXP_LNKCTL_CCC is RW.  But doesn't it depend on the components on
>>> both ends of the link?  Do you know what device is at the other end?
>>> I would have assumed that you'd have to start with CCC==0, which
>>> should be most conservative, then set CCC=1 only if you know both ends
>>> have a common clock.
>> PCIe RC and endpoint device are having the common clock so set the CCC=1.
> How do you know what the endpoint device is?  Is this driver only for
> a specific embedded configuration where the endpoint is always
> soldered down?  There's no possibility of this RC being used with a
> connector?
>
> Shouldn't this be either discoverable or configurable via DT or
> something?  pcie_aspm_configure_common_clock() seems to do something
> similar, but I can't really vouch for its correctness.

(sorry for the late reply, i am back today from sick leave)

I see pcie_aspm_configure_common_clock() is getting called during pcie 
root bus bridge scanning and programming the CCC.

So, CCC configuration can be removed here in intel_pcie_link_setup().

Regards,
Dilip

>
> Bjorn
