Return-Path: <linux-pci+bounces-7286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD198C0CEB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D746E1C20D70
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46F14A0B5;
	Thu,  9 May 2024 08:56:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28E14A09B
	for <linux-pci@vger.kernel.org>; Thu,  9 May 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244968; cv=none; b=NlDxq2xqOLIwIG/xMwKtWMAOQakGHPMCiUTtX2ABbGwsyKYBnBdIGwL/ITUAZPit33VIuiUTns4IGFgDpyKe2U8oMivYIvyOM3Zn3MStqhr7Nc9tPZUf6IhEW9El76roqjWuh3NlIuJj1uvH3F8Ri2S7Ty+ATNtUAAnoD7iTVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244968; c=relaxed/simple;
	bh=c36C+k9q9dNBLdBPfFzSAMYp3ZZ9Qs7guFDfKKB5zck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cuecs5ilTn+ggR8euRBR+WXMiPYaVVxxqlkLXNcXJkRSoq7BGD2DdumZ+ZVuM3P7eQpxWTFDpnKZn2rBpNYV/TeOZ583SWAlvt3YQ7k36ctee7MUl93gXHjYo2yb6dh++uWo/xGUMbRWUUHSmjfLDndDcMIigC+cLbUIV9g76vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1715244164-1eb14e507e0caa0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 5dTMgisTdkf08vuz (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 09 May 2024 16:42:44 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 16:42:44 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 16:42:42 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <1258b765-111c-4538-83e5-8e6aa3cb0936@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Thu, 9 May 2024 16:42:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: Add AER bits #defines for PCIe to PCI/PCI-X
 Bridge
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 2/3] PCI: Add AER bits #defines for PCIe to PCI/PCI-X
 Bridge
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>
References: <20240508221009.GA1791183@bhelgaas>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20240508221009.GA1791183@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1715244164
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1723
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.124624
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2024/5/9 6:10, Bjorn Helgaas 写道:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On Mon, Dec 18, 2023 at 11:04:29AM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> Define secondary uncorrectable error mask register, secondary
>> uncorrectable error severity register and secondary error capabilities and
>> control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
>> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
>> 5.2.3.3 and 5.2.3.4.
> 
> Please include the spec revision.  The only one I'm aware of is r1.0.
> 
Yes，the PCIe to PCI/PCI-X Bridge Specification version is r1.0.
I will supplement the protocol version in the next edition.

Yours sincerely
Leoliu-oc

>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   include/uapi/linux/pci_regs.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a39193213ff2..987c513192e8 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -802,6 +802,9 @@
>>   #define  PCI_ERR_ROOT_FATAL_RCV              0x00000040 /* Fatal Received */
>>   #define  PCI_ERR_ROOT_AER_IRQ                0xf8000000 /* Advanced Error Interrupt Message Number */
>>   #define PCI_ERR_ROOT_ERR_SRC 0x34    /* Error Source Identification */
>> +#define PCI_ERR_UNCOR_MASK2  0x30    /* PCIe to PCI/PCI-X Bridge */
>> +#define PCI_ERR_UNCOR_SEVER2 0x34    /* PCIe to PCI/PCI-X Bridge */
>> +#define PCI_ERR_CAP2 0x38    /* PCIe to PCI/PCI-X Bridge */
>>
>>   /* Virtual Channel */
>>   #define PCI_VC_PORT_CAP1     0x04
>> --
>> 2.34.1
>>

