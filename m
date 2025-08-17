Return-Path: <linux-pci+bounces-34141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F7B293B5
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0951B22359
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CA18C03F;
	Sun, 17 Aug 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UXOpQmVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0329B0;
	Sun, 17 Aug 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442966; cv=none; b=cxUY9+kbsamN/rlOVmVzVSLsMOahLEbKVV07XpKOhaPs3RI2jkQct6stVxB4u3aWI9OrvOaJQNkuTdQNk4qCblrbtGWtDlXn2bI7js+OGkpJg3K/nErt/3nUVFT4TK0y6FFXwsRR7/Mkdu0Dv2lc1N78PI0uxsuuGjdtrAQy8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442966; c=relaxed/simple;
	bh=/x22PnN6VcEYmobGC/HjAMH6O/8ttk8gbe6V+bV4NlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Psi92sFpMVaTF8bBH3sZ8NJWFLoZADv8I6BgF9gyfdP71F20aW9Pc3YvZSdmNqUKrxeXhalfRjR5Th/25wARcJfbmnk8GH149ajGMfUZAinHClgqwY/GgO6H504fpTtfDIEfYDStbzNHQiefz9XlYBl3nZ7amfllUx8Qdem+zNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UXOpQmVS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=B0MqJm2Ky6L9z79e5ZVV3av+cV1Oc6wGhL9Z06dZTEE=;
	b=UXOpQmVS4CuAJG7XedqD0+vH0Z7a4zC1LLWSPQqXYjvuVrn3r51L3D+uGl7pTU
	P/KmtpWvcDxwt2EGMIrTXYwtQw0X3CFLPRagcvwJ9cm7joECL5/cWfDNW8SLe79Q
	G/jVazGPbFB9Err1/8Tq/CMWAp7gcY1zd2ejLmcpWXIMs=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnb0Py7qFoqSyjCA--.973S2;
	Sun, 17 Aug 2025 23:02:11 +0800 (CST)
Message-ID: <35f6d6f3-b857-48cc-b3cb-11a27675adfd@163.com>
Date: Sun, 17 Aug 2025 23:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/bwctrl: Replace legacy speed conversion with
 shared macro
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250816154633.338653-1-18255117159@163.com>
 <20250816154633.338653-4-18255117159@163.com> <aKDmW6l6uxZGr1Wl@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aKDmW6l6uxZGr1Wl@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnb0Py7qFoqSyjCA--.973S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWrtF4DZF47KFy3XrW8JFb_yoW7Cw1rpa
	nxZF1jyF48CwnxCr95Ka4vqa48XFs3GF4Uur43Wrn8XFyfJ3s8GF10y3sFy34avr4jkryr
	Xw4DJF45G3W29aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxyso2ih7skDtgAAsL



On 2025/8/17 04:13, Lukas Wunner wrote:
> On Sat, Aug 16, 2025 at 11:46:33PM +0800, Hans Zhang wrote:
>> Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
>> PCIE_SPEED2LNKCTL2_TLS() macro instead.
> [...]
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -53,23 +53,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
>>   	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>   }
>>   
>> -static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>> -{
>> -	static const u8 speed_conv[] = {
>> -		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>> -		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>> -		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>> -		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>> -		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>> -		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>> -	};
>> -
>> -	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
>> -		return 0;
>> -
>> -	return speed_conv[speed];
>> -}
>> -
>>   static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
>>   {
>>   	return __fls(supported_speeds);
>> @@ -91,7 +74,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
>>   	u8 desired_speeds, supported_speeds;
>>   	struct pci_dev *dev;
>>   
>> -	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
>> +	desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS(speed_req),
>>   				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
> 
> No, that's not good.  The function you're removing above,
> pci_bus_speed2lnkctl2(), uses an array to look up the speed.
> That's an O(1) operation, it doesn't get any more efficient
> than that.  It was a deliberate design decision to do this
> when the bandwidth controller was created.
> 
> Whereas the function you're using instead uses a series
> of ternary operators.  That's no longer an O(1) operation,
> the compiler translates it into a series of conditional
> branches, so essentially an O(n) lookup (where n is the
> number of speeds).  So it's less efficient and less elegant.
> 
> Please come up with an approach that doesn't make this
> worse than before.


Dear Lukas,

Thank you very much for your reply.

I think the original static array will waste some memory space. 
Originally, we only needed a size of 6 bytes, but in reality, the size 
of this array is 26 bytes.

static const u8 speed_conv[] = {
	[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
	[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
	[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
	[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
	[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
	[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
};



What do you think if the first patch is modified as follows?


diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..d6c3333315a0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -422,6 +422,28 @@ void pci_bus_put(struct pci_bus *bus);
          PCI_SPEED_UNKNOWN);                                            \
  })

+static inline u16 pcie_speed_to_lnkctl2_tls(enum pci_bus_speed speed)
+{
+       /*
+        * Convert PCIe speed enum to LNKCTL2_TLS value using
+        * direct arithmetic:
+        *
+        * Speed enum:  0x14 (2.5GT) -> TLS = 0x1
+        *              0x15 (5.0GT) -> TLS = 0x2
+        *              0x16 (8.0GT) -> TLS = 0x3
+        *              0x17 (16.0GT)-> TLS = 0x4
+        *              0x18 (32.0GT)-> TLS = 0x5
+        *              0x19 (64.0GT)-> TLS = 0x6
+        *
+        * Formula: TLS = (speed - PCIE_SPEED_2_5GT) + 1
+        */
+       if (!WARN_ON_ONCE(speed >= PCIE_SPEED_2_5GT ||
+                         speed <= PCIE_SPEED_64_0GT))
+               return 0;
+
+       return (speed - PCIE_SPEED_2_5GT) + PCI_EXP_LNKCTL2_TLS_2_5GT;
+}
+
  /* PCIe speed to Mb/s reduced by encoding overhead */
  #define PCIE_SPEED2MBS_ENC(speed) \
         ((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \







If you think the above plan is feasible. Then, should all the following 
macro definitions be changed to inline functions?

drivers/pci/pci.h
#define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
({									\
	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
									\
	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
	 PCI_SPEED_UNKNOWN);						\
})

/* PCIe link information from Link Capabilities 2 */
#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
	 PCI_SPEED_UNKNOWN)

#define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
({									\
	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
									\
	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :	\
	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :	\
	 PCI_SPEED_UNKNOWN);						\
})




Best regards,
Hans


