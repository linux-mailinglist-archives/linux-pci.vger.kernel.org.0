Return-Path: <linux-pci+bounces-39581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B49C16E9E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFF33B19F0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA301350D45;
	Tue, 28 Oct 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LST+zhKD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415634CFC8
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686271; cv=none; b=sNQzqynORq1IgPkUZ7xQSw/G1UPUaO6ytdlcGGW9C/b3KmDC/U3nBw5gsX6d+z3j+vyQNI/CRS6JziWa7H/7pEtjr0aTojiKjea3Nz5yVLomCc77Gnt4aUb/cp/J69wJGfCNW5l6WEP4beq15i8PvAxqVRNMqy/q304zRGTJu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686271; c=relaxed/simple;
	bh=lZwSDGROIVTqo2bm1AXzeX4XCaD3hXAjqJD/pP/lHz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0neUVTTVFbLH20Jbv8zcRAhuKHF7tMoQsOldBwYFh7gkyF7D4a+UjEoSpa6qkuIrHeppJTlCOhJSCYDHmRgSsLT8TVSBiJYyKDedn4xs0kZwW2YK+8cUILtfrdMFn+WwTiQp3/CyGbTnFZ5BJ4hqgBucaxlaSQCCE6YRx3T74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LST+zhKD; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-79599d65f75so56885966d6.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686269; x=1762291069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1m/7bLUgobA+XAZb7xbS3K49RqLbTSFG/4DEm26jWM=;
        b=SJ+8ugccM57mvBVjmQpvWxvqckp0mLOAgftpWgObckeIXjWoGIoy7fePfyKejvbutP
         0mHophqevjFBFgD5JeLXjh/oRBGKVdX81kKrbryKYQherzaeBJWxc6pwfjai8N/u1Nzu
         yECbWu1O1biaxCv5PaYKsonwTs7Q2FR4XaJeg2SqMi1xS5TZ7pnJRvVgY0RYerRc+vb9
         dJOzzJ8ws43y+3WkxqEaMjVbBwK4HkjTmTuVGK15B0l45BMQb/g32SKX/ndbKw101PZP
         TwbTkhqxlq4kUK/xEAXYSjDQeCHvB39fhjiloEJkH4lVtwBwM2RxJRDChTZ0xFoUiV0M
         d6wQ==
X-Gm-Message-State: AOJu0YwmJwT+dfejQKQSQM/c7V/eEyWWXSGHzj+JjJ1HZ8XQwdYlLTDg
	ne/k5WmSDfaBrYgfW1R3eH7aplGz3Ys+TiLFz/YWhfmN/tIm/IMcFuR2lASezgu2wXXU6Vg6oia
	crMKlTcOPYmGL72jpEG7NZQg+TaIjVVmI6Li2xlgaSrFi2vuGIpjzLvmfhKTXzMnMlzkigCmF1H
	U7NI3UG30vewvZBdGsGb4DUangZIEFGQV8nLOr6ngVpyKkMi0Y2CiAbndnjdnh1vIMoLRlUhK2X
	Sqsw0NQd9UNHHbj
X-Gm-Gg: ASbGncu7uVBuHI7yVkSOYgNQvHCiUyE24PUtje1trKQDSUPgqQJS8bqufAXyDE5VFoN
	uRpm3+NJMOSTaOalRyKA3pHcCBe1bH6OECM3IEOhKZSBSUJz2aaP+d+enFcEUJ5/dn7fMieaTu9
	fI8ML0o2qoQK/xjrGHTQThkj0r/AgT8ZNx8lG8Rren+L0WEEb6xCPERWf/rFKlIwhkT6Zc8AZtH
	kt8Ocp6jgNgMwan3ZJtSzJ0T0q3AxAsNeSJ5xieTQ4OrBe5CZXgd8eDsQ0zftMcCMJFo9TC1+95
	RE2FGQyj5hfUR25aEcPyKy1p8pGq3xfVohZKE1dxXGFYol7aZs6r2GoUhLa1NdfNq9Efq4C/wWE
	oNb784WTNskwJZlCPmeg43i++NpvHB1qGozEPX6FcCjoQPcRQnYWtjoJCaMpmVEy33oMuUAMzrH
	wvPZaqiBdez2VTRiNzJ4xNEdx9snXteb1AkugPqQ==
X-Google-Smtp-Source: AGHT+IGPCs4y56DQY1a23kfoUsRxvTdg8IK+oVgICQZ4x2vvfgJ5/LNoBK7JQcdoy0lOT88TDA5L8MjNeX+h
X-Received: by 2002:a05:6214:2023:b0:87b:b67d:1a with SMTP id 6a1803df08f44-88009b37842mr8850136d6.29.1761686268789;
        Tue, 28 Oct 2025 14:17:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87fc49c2772sm11436616d6.32.2025.10.28.14.17.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:17:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a89c9750so189220111cf.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761686268; x=1762291068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d1m/7bLUgobA+XAZb7xbS3K49RqLbTSFG/4DEm26jWM=;
        b=LST+zhKDNnEkBwwd4BRgt3myRSB+9zueRoS06zR7W5X730Lhfdmiwbx3GKh3Dm6hdp
         3AeCd+qEJPmwkABNz4gOfli6jUpv7F33f/5pJASseEtDIMa0frMz1OycZ1Zp3Z0QkY8l
         TPL4LXNhRZX99eFpjwkg18DJ4by6PLPtKn3Vc=
X-Received: by 2002:a05:622a:4248:b0:4ec:f017:9e2c with SMTP id d75a77b69052e-4ed15b91ae8mr9427971cf.35.1761686267982;
        Tue, 28 Oct 2025 14:17:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4248:b0:4ec:f017:9e2c with SMTP id d75a77b69052e-4ed15b91ae8mr9427521cf.35.1761686267416;
        Tue, 28 Oct 2025 14:17:47 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f255a6ef6sm910978185a.34.2025.10.28.14.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:17:46 -0700 (PDT)
Message-ID: <21ca2154-a8ff-4f75-96c1-ded798901cc0@broadcom.com>
Date: Tue, 28 Oct 2025 17:17:45 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Bjorn Helgaas <helgaas@kernel.org>
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
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <20251020184832.GA1144646@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/20/25 14:48, Bjorn Helgaas wrote:
> On Fri, Oct 03, 2025 at 03:56:07PM -0400, Jim Quinlan wrote:
>> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
>> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
>> 7216 and its descendants -- have new HW that identifies error details.
>>
>> This simple handler determines if the PCIe controller was the cause of the
>> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
>> occurs.
>>
>> Care is taken to read the error registers only when the PCIe bridge is
>> active and the PCIe registers are acceptable.  Otherwise, a "die" event
>> caused by something other than the PCIe could cause an abort if the PCIe
>> "die" handler tried to access registers when the bridge is off.
>>
>> Example error output:
>>    brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>>    brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
>> +/* Error report registers */
>> +#define PCIE_OUTB_ERR_TREAT				0x6000
>> +#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
>> +#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
>> +#define PCIE_OUTB_ERR_VALID				0x6004
>> +#define PCIE_OUTB_ERR_CLEAR				0x6008
>> +#define PCIE_OUTB_ERR_ACC_INFO				0x600c
>> +#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
>> +#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
>> +#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
>> +#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10
>> +#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
>> +#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
>> +#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
>> +#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
>> +#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
>> +#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
>> +#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1
>> +#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
>> +#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
>> +#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1
> IMO "_MASK" is not adding anything useful to these names.  But I see
> there's a lot of precedent in this driver.
Removed.
>
>>   #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
>>   #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
>>   
>> @@ -306,6 +342,8 @@ struct brcm_pcie {
>>   	bool			ep_wakeup_capable;
>>   	const struct pcie_cfg_data	*cfg;
>>   	bool			bridge_in_reset;
>> +	struct notifier_block	die_notifier;
>> +	struct notifier_block	panic_notifier;
>>   	spinlock_t		bridge_lock;
>>   };
>>   
>> @@ -1731,6 +1769,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>>   	return ret;
>>   }
>>   
>> +/* Dump out PCIe errors on die or panic */
>> +static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
> What is the leading underscore telling me?  There's no
> brcm_pcie_dump_err() that we need to distinguish from.
Will be removed.
>
>> +			       const char *type)
>> +{
>> +	void __iomem *base = pcie->base;
>> +	int i, is_cfg_err, is_mem_err, lanes;
>> +	char *width_str, *direction_str, lanes_str[9];
>> +	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pcie->bridge_lock, flags);
>> +	/* Don't access registers when the bridge is off */
>> +	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
>> +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	/* Read all necessary registers so we can release the spinlock ASAP */
>> +	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
>> +	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
>> +	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
>> +	if (is_cfg_err) {
>> +		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
>> +		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
>> +	}
>> +	if (is_mem_err) {
>> +		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
>> +		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
>> +		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
>> +	}
>> +	/* We've got all of the info, clear the error */
>> +	writel(1, base + PCIE_OUTB_ERR_CLEAR);
>> +	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
>> +
>> +	dev_err(pcie->dev, "reporting data on PCIe %s error\n", type);
> Looks like this isn't included in the example error output.  Not a big
> deal in itself, but logging this:
>
>    brcm-pcie 8b20000.pcie: reporting data on PCIe Panic error
>
> suggests that we know this panic was directly *caused* by PCIe, and
> I'm not sure the fact that somebody called panic() and
> PCIE_OUTB_ERR_VALID was non-zero is convincing evidence of that.
>
> I think this relies on the assumptions that (a) the controller
> triggers an abort and (b) the abort handler calls panic().  So I think
> this logs useful information that *might* be related to the panic.
>
> I'd rather phrase this with a little less certainty, to convey the
> idea that "here's some PCIe error information that might be related to
> the panic/die".
Message changed.
>
>> +	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
>> +	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
>> +	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
>> +	for (i = 0, lanes_str[8] = 0; i < 8; i++)
>> +		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
>> +
>> +	if (is_cfg_err) {
>> +		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
>> +		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
>> +		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
>> +		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
>> +
>> +		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
> Why are we printing bus and dev with %d?  Can we use the usual format
> ("%04x:%02x:%02x.%d") so it matches other logging?
ack
>
>> +			width_str, direction_str, bus, dev, func, reg, lanes_str);
>> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
>> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
>> +	}
>> +
>> +	if (is_mem_err) {
>> +		u64 addr = ((u64)hi << 32) | (u64)lo;
>> +
>> +		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
>> +			width_str, direction_str, addr, lanes_str);
>> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
>> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
>> +	}
>> +
>> +	return NOTIFY_OK;
> What is the difference between NOTIFY_DONE and NOTIFY_OK?  Can the
> caller do anything useful based on the difference?
>
> This seems like opportunistic error information that isn't definitely
> definitely connected to anything, so I'm not sure returning different
> values is really reliable.

Will change to NOTIFY_DONE.

Regards,

Jim Quinlan

Broadcom STB/CM



