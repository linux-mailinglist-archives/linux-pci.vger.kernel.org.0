Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ADA27B1B7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1QUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1QUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 12:20:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A8C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 09:20:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id bw23so954055pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4V2KOSWz2Ynez7A9qc6gszCbitnG30+IEs3hUqTCfO4=;
        b=HVr1r1zMioW8B+bOUNuze9QYluvHCclRX8sQykdHld08TNmtZVr1mi1lUiRIg+XDRR
         H93HlVSgjhdhk4l8PAMh0X+HOiGQc+XaTGmsUMZmnCydLEl0+t+rjcqMuF7k/RaQr2FV
         4km2qPGp18hSsvioanvkO23m+RPeVaNr2OrTUTJs/yhw8YZvxly7pajPS/8Ysb78wZbR
         iX8F3gX6y63P7MP8rfJzar7nPzoaw3RwqEsYrIHWmk9inU1LxaI6t9X7Bc3fN1YHobKS
         3o0XPHXbVJZpMRtG0QtFAOANe+j3tQ066viVsuWi76t6PWiLDGXtF+IYJKc4BfA1AMRk
         /4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4V2KOSWz2Ynez7A9qc6gszCbitnG30+IEs3hUqTCfO4=;
        b=bRX8u6WPYoWfskxMToCFcYbAeVgokieERkQvcYpELzWUDdYTe2oC8lFw+qf/boAkFD
         DUUqHQqhEGxqNGIxigyOL5wNRQbieXVScTQat6v+K659i53Af2S0n8tpRHSQnLVFzm6N
         ne0a7WrFRcBsRVs3zAg26hO0YOnDvDeceJJYqRDuxl7NZjoIFMrbF+RQlCAenrk4B5Kh
         AfrsHNISQbl5kMQmi9WFPHnFPIryjLlZhVl4SSZ7n/Di6A8pZJ3yd5+z/CVT6912gyev
         /s416m58UdGFjGAK2YYG6zHcIbHmCTGJig4fN+nb2Sh+dHUiGgp1GNO8T6i5f5iqTZgK
         umFg==
X-Gm-Message-State: AOAM532WPggUwXqneiJ6ixGSv9squLhNa86HxcGK26Boivvycy+YZ8RD
        2WqkPI5rcunjTJJSSEoy1DYjow==
X-Google-Smtp-Source: ABdhPJxkjBTlYZ3nCaLlMOJp1FXAWAlJSinEhItUxBY+55Da/lxMYQRAr/PGO6ghJJ//Z0wDZb6Hlw==
X-Received: by 2002:a17:90a:ca17:: with SMTP id x23mr90679pjt.96.1601310031082;
        Mon, 28 Sep 2020 09:20:31 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id j14sm1819052pjz.21.2020.09.28.09.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 09:20:29 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/10] PCI/RCEC: Add pcie_link_rcec() to associate
 RCiEPs
Date:   Mon, 28 Sep 2020 09:20:28 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CCA7D16A-80A6-456B-BD0F-0DA4CCE8F054@intel.com>
In-Reply-To: <20200925221540.GA2460947@bjorn-Precision-5520>
References: <20200925221540.GA2460947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 Sep 2020, at 15:15, Bjorn Helgaas wrote:

> On Tue, Sep 22, 2020 at 02:38:55PM -0700, Sean V Kelley wrote:
>> From: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> A Root Complex Event Collector provides support for
>> terminating error and PME messages from associated RCiEPs.
>>
>> Make use of the RCEC Endpoint Association Extended Capability
>> to identify associated RCiEPs. Link the associated RCiEPs as
>> the RCECs are enumerated.
>>
>> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pci.h              |  2 +
>>  drivers/pci/pcie/portdrv_pci.c |  3 ++
>>  drivers/pci/pcie/rcec.c        | 96 
>> ++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h            |  1 +
>>  4 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 7b547fc3679a..ddb5872466fb 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -474,9 +474,11 @@ static inline void pci_dpc_init(struct pci_dev 
>> *pdev) {}
>>  #ifdef CONFIG_PCIEPORTBUS
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>> +void pcie_link_rcec(struct pci_dev *rcec);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
>> +static inline void pcie_link_rcec(struct pci_dev *rcec) {}
>>  #endif
>>
>>  #ifdef CONFIG_PCI_ATS
>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>> b/drivers/pci/pcie/portdrv_pci.c
>> index 4d880679b9b1..dbeb0155c2c3 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -110,6 +110,9 @@ static int pcie_portdrv_probe(struct pci_dev 
>> *dev,
>>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_link_rcec(dev);
>
> Nice solution.  One day we'll get rid of pcie_portdrv_probe() and
> integrate this stuff better into the PCI core, and we'll have to
> figure out a little different solution then.  But we'll be smarter
> then so it should be possible :)

Indeed!

>
>>  	status = pcie_port_device_register(dev);
>>  	if (status)
>>  		return status;
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index 519ae086ff41..5630480a6659 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -17,6 +17,102 @@
>>
>>  #include "../pci.h"
>>
>> +struct walk_rcec_data {
>> +	struct pci_dev *rcec;
>> +	int (*user_callback)(struct pci_dev *dev, void *data);
>> +	void *user_data;
>> +};
>> +
>> +static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev 
>> *rciep)
>> +{
>> +	unsigned long bitmap = rcec->rcec_ext->bitmap;
>> +	unsigned int devn;
>> +
>> +	/* An RCiEP found on bus in range */
>> +	if (rcec->bus->number != rciep->bus->number)
>> +		return true;
>> +
>> +	/* Same bus, so check bitmap */
>> +	for_each_set_bit(devn, &bitmap, 32)
>> +		if (devn == rciep->devfn)
>> +			return true;
>> +
>> +	return false;
>> +}
>> +
>> +static int link_rcec_helper(struct pci_dev *dev, void *data)
>> +{
>> +	struct walk_rcec_data *rcec_data = data;
>> +	struct pci_dev *rcec = rcec_data->rcec;
>> +
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && 
>> rcec_assoc_rciep(rcec, dev)) {
>> +		dev->rcec = rcec;
>> +		pci_dbg(dev, "PME & error events reported via %s\n", 
>> pci_name(rcec));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void 
>> *userdata)
>> +{
>> +	struct walk_rcec_data *rcec_data = userdata;
>> +	struct pci_dev *rcec = rcec_data->rcec;
>> +	u8 nextbusn, lastbusn;
>> +	struct pci_bus *bus;
>> +	unsigned int bnr;
>> +
>> +	if (!rcec->rcec_cap)
>> +		return;
>> +
>> +	/* Walk own bus for bitmap based association */
>> +	pci_walk_bus(rcec->bus, cb, rcec_data);
>> +
>> +	/* Check whether RCEC BUSN register is present */
>> +	if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
>> +		return;
>> +
>> +	nextbusn = rcec->rcec_ext->nextbusn;
>> +	lastbusn = rcec->rcec_ext->lastbusn;
>> +
>> +	/* All RCiEP devices are on the same bus as the RCEC */
>> +	if (nextbusn == 0xff && lastbusn == 0x00)
>> +		return;
>> +
>> +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
>> +		/* No association indicated (PCIe 5.0-1, 7.9.10.3) */
>> +		if (bnr == rcec->bus->number)
>> +			continue;
>> +
>> +		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
>> +		if (!bus)
>> +			continue;
>> +
>> +		/* Find RCiEP devices on the given bus ranges */
>> +		pci_walk_bus(bus, cb, rcec_data);
>> +	}
>> +}
>> +
>> +/**
>> + * pcie_link_rcec - Link RCiEP devices associating with RCEC.
>> + * @rcec     RCEC whose RCiEP devices should be linked.
>> + *
>> + * Link the given RCEC to each RCiEP device found.
>> + *
>> + */
>> +void pcie_link_rcec(struct pci_dev *rcec)
>> +{
>> +	struct walk_rcec_data rcec_data;
>> +
>> +	if (!rcec->rcec_cap)
>> +		return;
>> +
>> +	rcec_data.rcec = rcec;
>> +	rcec_data.user_callback = NULL;
>> +	rcec_data.user_data = NULL;
>> +
>> +	walk_rcec(link_rcec_helper, &rcec_data);
>> +}
>> +
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>>  	u32 rcec, hdr, busn;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 5c5c4eb642b6..ad382a9484ea 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -330,6 +330,7 @@ struct pci_dev {
>>  #ifdef CONFIG_PCIEPORTBUS
>>  	u16		rcec_cap;	/* RCEC capability offset */
>>  	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended 
>> capabilities */
>> +	struct pci_dev  *rcec;          /* Associated RCEC device */
>
> Wondering if we can put this pointer inside the struct rcec_ext (or
> whatever we call it) so we don't have to pay *two* pointers for every
> PCI device?  Maybe it should be something like this:

It’s definitely unfortunate to need these two pointers. Here we have 
the spec implying an association, but leaving it to software to fill in 
the gaps! The spec provides a bitmap, but the reverse mapping is also 
needed from the RCiEPs to the RCEC.

>
>   struct rcec {
>     u8			ea_ver;
>     u8			ea_nextbusn;
>     u8			ea_lastbusn;
>     u32			ea_bitmap;
>     struct pci_dev	*rcec;
>   }
>
> I dunno.  Not sure if that would be better or worse, since we'd be
> mixing RCEC stuff (the EA capability info) with RCiEP stuff (the
> pointer to the related RCEC).  Could even be a union, since any given
> device only needs one of them, but I'm pretty sure that would be
> worse.

Well, I think the pointer savings would be offset by lack of clarity on 
what is going on here due to this nesting. Then again, *rcec_ea and 
*rcec are not themselves revealing in terms of the relationship with 
RCiEPs either.  I’ll think on it some more. I do like the ea_ prefix.

>
> BTW, 03/10 didn't add a forward declaration, e.g.,
>
>   struct rcec_ext;
>
> to include/linux/pci.h, and the actual definition is in
> drivers/pci/pci.h.  It seems like you should need that?

Yes, it should be added.  Will do.

Thanks,

Sean
>
>>  #endif
>>  	u8		pcie_cap;	/* PCIe capability offset */
>>  	u8		msi_cap;	/* MSI capability offset */
>> -- 
>> 2.28.0
>>
