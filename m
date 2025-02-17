Return-Path: <linux-pci+bounces-21611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00634A38296
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD5E18885A2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C32185BB;
	Mon, 17 Feb 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iIAlto/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEA217722
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794014; cv=none; b=fFm4WBriU+AoHxr7aErNFvG8OpXtNjAilBi6KuUh48df7rMEnKoqmk0MDX+QVZfr3xb6PolfjKLJTmBmiJF9YIKPyiXXbxK3POSJUqZyIKLdesGml/Ypfu2aitHXXBMTLMop+LGM6rKSfty7Q3tfnwizOXtm1HZ4MeWNo/5xxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794014; c=relaxed/simple;
	bh=fOR6OeNYk6pjJz3p+ZkVYEPE8eoOb0VsJrdOWY6FW1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT3gzaRLGqIw6zhawBhsM6R87r6RQCWxD6wMw+DOXHraL6Dq6wPEtNJ8fbSRZijWkVUXAHU0RDMBLJPRorpi2Fou8HS06hh1BqUPx1nipvbm5kvcFbq2lMA2E3G4ZoqQs9RQlNZGM0JWaWcbVgHhwzozY+TvrAXPpFSvoUz4ZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iIAlto/c; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=gdHE72SWR74/9/CdrLgsgrLo5axD2Xp+SLBtwjszUJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=iIAlto/cOIj8qQFQUZHC1Tijnvfnu8T9Y3dXbe6M1h3JCoxNEVFMhFM+S0Me/sGWu
	 QsZ9TtzAfUc7dL0Iaya4TzEIX3Y/IXwLFQ2gAB0U/DP54THORaqZHUBzHsMEkVCn/l
	 M9/GwZIRSDg4+9OLqnG6gS/yLdTwo3SypoT4X/gXoK2uFAhP+kFkHizX77KzA3AKrS
	 KZ7OW+VCrJHL/qKFdGkbtLzeHSgQTtql+Tjr2irZcAJ/jdeuIxM4BYXrAk/pRO7m4P
	 aic7j+X6pVMM/+hmw0AS0qLvuWhTjfFiH4SV/8vlAe607qyBkMIDZKmu5i6IAktdzY
	 MKmiVdY5rKWxg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 01408CC699F;
	Mon, 17 Feb 2025 12:06:46 +0000 (UTC)
Message-ID: <a99e4576-ca9a-4b28-9a5b-242184de852c@icloud.com>
Date: Mon, 17 Feb 2025 20:06:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: Remove API devm_pci_epc_destroy()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250210-remove_api-v1-1-8ae6b36e3a5c@quicinc.com>
 <20250214154007.tg3bzi5berkk45wk@thinkpad>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250214154007.tg3bzi5berkk45wk@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _8OPX240B8Z1D5erMbyUxHevYUZatzB1
X-Proofpoint-GUID: _8OPX240B8Z1D5erMbyUxHevYUZatzB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=742
 clxscore=1011 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2502170106

On 2025/2/14 23:40, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 08:39:53PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Static devm_pci_epc_match() is only invoked by API devm_usb_put_phy(), and
> devm_usb_put_phy()? Did you mean to say 'devm_pci_epc_destroy()'?
> 

yes. it is devm_pci_epc_destroy().
my mistake, thank you for pointing out this.
will correct in v2. (^^)

>> the API has not had callers since 2017-04-10 when it was introduced.
>>
>> Remove both the API and the static function.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> With above fixup,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani


