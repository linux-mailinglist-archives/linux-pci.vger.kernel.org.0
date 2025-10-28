Return-Path: <linux-pci+bounces-39585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DFC1734F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1992D356602
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00B83557FF;
	Tue, 28 Oct 2025 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dl1QoEIi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73922FFFA3
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691067; cv=none; b=UpLWN3lB7Jxl9qEVKRCk4hYoSEyQ48nNmLvsaPLG1tv8XQftu/eNVi+UWDoRs9CLWxYIO3r3T3PrCjNdPB0Qmp+DPPMBS/tr9tMDTL00bYN4qjvkBrf3qUW66ArVDBts4SVRA/sw9+Q3G/T6wD2FOgfHBJr0vP4ZuTpNnk9SQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691067; c=relaxed/simple;
	bh=WDsDZgM6CNoQov59tLkJ+Cy+AOVyf1Uaj18NGsR/Q5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeJdBmN0uwrFSqwQHPAu9NeapkI4+hJ3fd2B+JTYf/LdWeFxHMxq+XvVwda/0kre/Z3X3I9ZVZPci84IkN2eCMZgESx0YBGTUwVqpbLewNPytdNYwGTHjpbctrIwiOvJ0iL/kbqFKX1cVY7Lm2X0n9fcxa3EOISc+6RJROCVO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dl1QoEIi; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso63186045ab.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691065; x=1762295865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8oyOvuuzJqHSTxbp2xqCPWdZ/DwPM98WiImXPn0Gv8=;
        b=r6rx1/B+z5RTMEkDkiuD93SF3wnuLm+AOeLgP9gdyGWpesV8pA8XXDROLhSxqTM7nT
         DNB9Gf3JWjFNYZaZTjPC0TcJiI8QTUtDLWiM54aMBdU6H6SdKpSu0EATFeERawt7aS1n
         hsvT7+4d7jTGEwZtLjs/R9YBc4BlmhHtzn8qXiuU13sTSY3CXjuYLAonYL9hxLLX14FE
         PUHYjdOs1tVMT/RKv9ZhmPLXf3++5FnfAqNcc+bHY3KVEpHODpLl/tbkgPPCnrOBCnhm
         KrleluOtrhbD9tdc9ezS0GmAwYMC93Ecokecmr0fHZq1tz0BY+OWFihXiyIrai33M/Jn
         GTcA==
X-Gm-Message-State: AOJu0Yx9EOREuiIh0dSVO/mKU8pPXVqL/WSDDEX1MhGhZkBJeioC9CAC
	KHC6MkA3Js66Ah/hAYv6UPq8CqPDDdZXpO4QWu2yRLhU342BwmHCY05aNuSav/DAE5k9kSuJSuf
	1d5gWzU5kefVFHlDNAzEST5xM0yIbdNGUPuWM3ea5rpmAzWXPYl+MohqwdmkB7t3MYCe2iBo8RI
	C9RYXikfnqZUvJPTVTBL+Q7hVFKL8X3TADUQbAJ4RJ73irt38zREPYA2MvXj031/8+C2gznVV0S
	KoIbFSg5IgtESrs
X-Gm-Gg: ASbGncshI1uw4fzlaScEB/3UlYoyWwFnEZ6vdq3LM1CXn/Ry67sM1t+byqeW4mpk1sB
	s1MsGOeUyES4T02Dw0YHAOFxT2POAAYCwUl/OzlXxPWA/sWZuiVcJ57K/DKOaYcZV6WoZfnOVqo
	naOc0vnpNYcIBkaC2a327gNHmvvvBOxrAb0ugimrZLHZqhGgDBAKkZ4S0t1cCsCgYCAEsXl46uY
	46G4QZ2RkyLqkTe4dftDxQbMBJcGAM5tyjDHxLj0u+fBBoYvb9fkZFyU4uQSfNC3uhWKVAKAXEs
	lxCMHdIRqpd5H5nE14fbqZHPXfxAevJ16Mq9ekjQhMs4CMV5wge9gH8d6emttvb5jCNILhfshmW
	1/etATDjW6XWQqoPBCXSdWGwDlRSxlOGOrNurhMoHxCebpGOCc3TPVU3q2EDogFwSNztOshrFUA
	+iUwEAoGx6hgSRCebaNORLqYiwXiFa0pg32IKijg==
X-Google-Smtp-Source: AGHT+IH/DnIHsrNFeoosI6U0HvC1ryY+8I/kcKQ4MFG0ylaAOjiTFMrkEDIL2uLoX48aq9scMo6UF0PidqWL
X-Received: by 2002:a05:6e02:32c6:b0:432:10f9:5e1a with SMTP id e9e14a558f8ab-432f902cf2cmr13100425ab.21.1761691064908;
        Tue, 28 Oct 2025 15:37:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431f67f7d9csm11339715ab.8.2025.10.28.15.37.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:37:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a65ae81248so598700185a.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761691063; x=1762295863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D8oyOvuuzJqHSTxbp2xqCPWdZ/DwPM98WiImXPn0Gv8=;
        b=Dl1QoEIiigSC2WMOWo8yDjD4tluBkyqMlABxTHRuSz3eDq10QBUWuTVAxDnqdmMOZu
         74VNxNpyqx2vXz3kj0OTSbCMCONpM+O/7poivh+ybnkrFnHGFNctD6YAbVl83slZ+106
         tOh1N+mM58tkEaf+/Uuahn5x59ikW91FD7ByQ=
X-Received: by 2002:a05:620a:31aa:b0:892:63c8:2861 with SMTP id af79cd13be357-8a8edcffa9bmr146843485a.40.1761691062867;
        Tue, 28 Oct 2025 15:37:42 -0700 (PDT)
X-Received: by 2002:a05:620a:31aa:b0:892:63c8:2861 with SMTP id af79cd13be357-8a8edcffa9bmr146839585a.40.1761691062406;
        Tue, 28 Oct 2025 15:37:42 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c8b849sm905765385a.46.2025.10.28.15.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:37:40 -0700 (PDT)
Message-ID: <f50465c8-d4c5-4e1c-b6d9-ebf7a14ad19d@broadcom.com>
Date: Tue, 28 Oct 2025 18:37:38 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler to driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251020184832.GA1144646@bhelgaas>
 <2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/21/25 07:02, Ilpo Järvinen wrote:
> On Mon, 20 Oct 2025, Bjorn Helgaas wrote:
>
>> On Fri, Oct 03, 2025 at 03:56:07PM -0400, Jim Quinlan wrote:
>>> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
>>> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
>>> 7216 and its descendants -- have new HW that identifies error details.
>>>
>>> This simple handler determines if the PCIe controller was the cause of the
>>> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
>>> occurs.
>>>
>>> Care is taken to read the error registers only when the PCIe bridge is
>>> active and the PCIe registers are acceptable.  Otherwise, a "die" event
>>> caused by something other than the PCIe could cause an abort if the PCIe
>>> "die" handler tried to access registers when the bridge is off.
>>>
>>> Example error output:
>>>    brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>>>    brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
>>> +/* Error report registers */
>>> +#define PCIE_OUTB_ERR_TREAT				0x6000
>>> +#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
>>> +#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
>>> +#define PCIE_OUTB_ERR_VALID				0x6004
>>> +#define PCIE_OUTB_ERR_CLEAR				0x6008
>>> +#define PCIE_OUTB_ERR_ACC_INFO				0x600c
>>> +#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
>>> +#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
>>> +#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
>>> +#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10
>>> +#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
>>> +#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
>>> +#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
>>> +#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
>>> +#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
>>> +#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
>>> +#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
>>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1
> Double __
ack
>
>>> +#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
>>> +#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
>>> +#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
>>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
>>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
>>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
>>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
>>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1
> Maybe use BIT() instead for single bits?
ack
>
>> IMO "_MASK" is not adding anything useful to these names.  But I see
>> there's a lot of precedent in this driver.
>>
>>>   #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
>>>   #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
> Please don't add unnecessary _SHIFT defines as FIELD_GET/PREP() for the
> field define should have most cases covered that require shifting.
>
> This define is also entirely unused in this patch.

I've removed PCIE_RGR1_SW_INIT_1_PERST_SHIFT as it is not used.

There is a reason we have _MASK and _SHIFT suffixes:  a script scans the 
driver code for such constants and compares/contrasts their values in 
our RDB include files across multiple SoCs (22+) we support with this 
driver.  This helps me keep things working as the HW group has a bad 
habit of moving registers and fields when a new SoC comes out.

I forget to mention this to Bjorn but I am not worried about our 
PCIE_OUTB_xxx constants.

>>> @@ -306,6 +342,8 @@ struct brcm_pcie {
>>>   	bool			ep_wakeup_capable;
>>>   	const struct pcie_cfg_data	*cfg;
>>>   	bool			bridge_in_reset;
>>> +	struct notifier_block	die_notifier;
>>> +	struct notifier_block	panic_notifier;
>>>   	spinlock_t		bridge_lock;
>>>   };
>>>   
>>> @@ -1731,6 +1769,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>>>   	return ret;
>>>   }
>>>   
>>> +/* Dump out PCIe errors on die or panic */
>>> +static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
>> What is the leading underscore telling me?  There's no
>> brcm_pcie_dump_err() that we need to distinguish from.
>>
>>> +			       const char *type)
>>> +{
>>> +	void __iomem *base = pcie->base;
>>> +	int i, is_cfg_err, is_mem_err, lanes;
>>> +	char *width_str, *direction_str, lanes_str[9];
>>> +	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&pcie->bridge_lock, flags);
>>> +	/* Don't access registers when the bridge is off */
>>> +	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
>>> +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
>>> +		return NOTIFY_DONE;
>>> +	}
>>> +
>>> +	/* Read all necessary registers so we can release the spinlock ASAP */
>>> +	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
>>> +	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
>>> +	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
>>> +	if (is_cfg_err) {
>>> +		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
>>> +		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
>>> +	}
>>> +	if (is_mem_err) {
>>> +		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
>>> +		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
>>> +		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
>>> +	}
>>> +	/* We've got all of the info, clear the error */
>>> +	writel(1, base + PCIE_OUTB_ERR_CLEAR);
>>> +	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
>>> +
>>> +	dev_err(pcie->dev, "reporting data on PCIe %s error\n", type);
>> Looks like this isn't included in the example error output.  Not a big
>> deal in itself, but logging this:
>>
>>    brcm-pcie 8b20000.pcie: reporting data on PCIe Panic error
>>
>> suggests that we know this panic was directly *caused* by PCIe, and
>> I'm not sure the fact that somebody called panic() and
>> PCIE_OUTB_ERR_VALID was non-zero is convincing evidence of that.
>>
>> I think this relies on the assumptions that (a) the controller
>> triggers an abort and (b) the abort handler calls panic().  So I think
>> this logs useful information that *might* be related to the panic.
>>
>> I'd rather phrase this with a little less certainty, to convey the
>> idea that "here's some PCIe error information that might be related to
>> the panic/die".
>>
>>> +	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
>>> +	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
> Please use str_read_write() + don't forget it's include.
Done.
>
> It might be also worth to add str_64bit_32bit() in the form with the
> dash ("64-bit") as there a couple of other drivers print the same choice.

Unfortunately, I'm a little pressed for time right now to add this in now...


Regards,

Jim Quinlan

Broadcom STB/CM

>
>
>>> +	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
>>> +	for (i = 0, lanes_str[8] = 0; i < 8; i++)
>>> +		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
>>> +
>>> +	if (is_cfg_err) {
>>> +		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
>>> +		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
>>> +		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
>>> +		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
>>> +
>>> +		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
>> Why are we printing bus and dev with %d?  Can we use the usual format
>> ("%04x:%02x:%02x.%d") so it matches other logging?
>>
>>> +			width_str, direction_str, bus, dev, func, reg, lanes_str);
>>> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
>>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
>>> +	}
>>> +
>>> +	if (is_mem_err) {
>>> +		u64 addr = ((u64)hi << 32) | (u64)lo;
>>> +
>>> +		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
>>> +			width_str, direction_str, addr, lanes_str);
>>> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
>>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
>>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
>>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
>>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
>>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
>>> +	}
>>> +
>>> +	return NOTIFY_OK;
>> What is the difference between NOTIFY_DONE and NOTIFY_OK?  Can the
>> caller do anything useful based on the difference?
>>
>> This seems like opportunistic error information that isn't definitely
>> definitely connected to anything, so I'm not sure returning different
>> values is really reliable.
>>


