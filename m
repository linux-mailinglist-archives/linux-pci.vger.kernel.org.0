Return-Path: <linux-pci+bounces-20337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BFA1B6AB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 14:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED13ADED3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 13:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C681BC4E;
	Fri, 24 Jan 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="akL7thqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5544360;
	Fri, 24 Jan 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724408; cv=none; b=EWhG0hbxnFn84JAoanpFSxp/PCPlOLmWpp9uywLijDntUvLTBPZK6nmlEm9sCQi9j+Yiux32naWXVqcQy64sRpWKhNdnmJpp9ZrK3VG7hOnW3T4fcQUNdKFKZjmTChq0w52+lja5BTjr2k3u0TigIB5nxXM+Bvh0UT2/7GEPHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724408; c=relaxed/simple;
	bh=jrj5PupWIyrkrHe98fBSBGYFpRqxofDNG0tCqSMDXXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umjb4eK4jk/DG2aw90EAyEqAPNPHrUOix5++s3wbKoqaQqFhRUPIfhf/ugWxECbTOrmo3jnVaXGiCMdbRQ2ms/3+MB1ZiEo4XeHbMdnlPTvyibzgNQPDAa/YVO9g7Rayh26fmJDZAc9utDidfEY8gduNmdruPtRuWYwT3jAaoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=akL7thqL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wzzwLLCEHHI+i1O7CxJizo8RxcqgB8u+ySyrx51GTkk=;
	b=akL7thqL+BijPNnn2jQYmFEZ7bhfYyN4Z56rUhfSlw/Xa862qniaaKSg2yZPRz
	YO6cWN9pKvE2+3pgl7Y5s2JjyyLQZAKPWCnZcI5+g+chdZixaqlirSifUBQGUDPX
	A4TmLQOqgHR9GOcFOlRNstQa5P4LxAOq8dX2/FmOSsDB4=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3QizPkZNnBWFgHw--.41190S2;
	Fri, 24 Jan 2025 21:12:48 +0800 (CST)
Message-ID: <54428aa3-2178-45d0-83d3-0b6254347bb5@163.com>
Date: Fri, 24 Jan 2025 21:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250123071326.1810751-1-18255117159@163.com>
 <Z5JrXsDDM2IManp+@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z5JrXsDDM2IManp+@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wA3QizPkZNnBWFgHw--.41190S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1UXr18Cr4kWr4rKF1xZrb_yoW8Zw17pa
	y8AayFyF47Zr10v3W5XF4DXry5tFn3CF4DKrW5tFWSga4vvr9rKFWrJ3y8tr95JrsrGry3
	Aw15Arn5GryrGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UY0PhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxLeo2eTgkO3tQABsW



On 2025/1/24 00:16, Frank Li wrote:
>> +static char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
>> +{
>> +	char *str;
>> +
>> +	switch (ltssm) {
>> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
>> +	...
>> +	default:
>> +		str = "DW_PCIE_LTSSM_UNKNOWN";
>> +		break;
> 
> I prefer
> const char * str[] =
> {
> 	"detect_quitet",
> 	"detect_act",
> 	...
> }
> 
> 	return str[ltssm];
> 
> Or
> 	#define DW_PCIE_LTSSM_NAME(n) case n: return #n;
> 	...
> 	default:
> 		return "DW_PCIE_LTSSM_UNKNOWN";
Hi Frank,

I considered the two methods you mentioned before I submitted this patch.

The first, I think, will increase the memory overhead.

+static const char * const dw_pcie_ltssm_str[] = {
+	[DW_PCIE_LTSSM_DETECT_QUIET] = "DETECT_QUIET",
+	[DW_PCIE_LTSSM_DETECT_ACT] = "DETECT_ACT",
+	[DW_PCIE_LTSSM_POLL_ACTIVE] = "POLL_ACTIVE",
+	[DW_PCIE_LTSSM_POLL_COMPLIANCE] = "POLL_COMPLIANCE",
	...


The second, ./scripts/checkpatch.pl checks will have a warning

WARNING: Macros with flow control statements should be avoided
#121: FILE: drivers/pci/controller/dwc/pcie-designware.h:329:
+#define DW_PCIE_LTSSM_NAME(n) case n: return #n


>> +static ssize_t ltssm_status_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>> +	struct dw_pcie_rp *pp = bridge->sysdata;
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +
>> +	return sysfs_emit(buf, "%s\n",
>> +			  dw_ltssm_sts_string(dw_pcie_get_ltssm(pci)));
> 
> Suggest dump raw value also
> 
> val = dw_pcie_get_ltssm(pci);
> return sysfs_emit(buf, "%s (0x%02x)\n",
> 		  dw_ltssm_sts_string(val), val);

Thanks, i think it's a good idea.

Best regards
Hans


