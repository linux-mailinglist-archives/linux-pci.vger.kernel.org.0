Return-Path: <linux-pci+bounces-17767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BA19E57C0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46B028B07B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209921A448;
	Thu,  5 Dec 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xm90h+HI"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3FE56C
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406377; cv=none; b=rPxkiJk1CcwZdLwi0iguOnt9EM/efDOAu0W0pybkScbIbPrwcbiNCUSNlNChFh+s29f+qEXPg+QChydSjksfOfgv1w4USJQ5AtLZmqQaVWJ/bMl0zHo+yfxQUTvpna3LZjFpcEBll2p4g5vIBpy79Xjm9bB7iqIm91sVzDwtdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406377; c=relaxed/simple;
	bh=Erzunq/73jwoVQ/pOglQgLKLnOsPy+Bf0Oo/OLzmmW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI+92yXa1sB0mdZwY2YBWJvRewdUFmgSkeujS2skH+sLw1EitHAcGmX8t4CdbmeOTWiWiB3dLaDFIn8tN60RFCLa2RIBrKFqvqozZGih+9I7UwlK3nupoPoBhQs4ZZTl/YQcgogCCKaemvX9pb65ErG8bxOaWPJDz6VwGaF4J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xm90h+HI; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733406374;
	bh=MPWGXb1Ff78zotVn43S71hljPg5nRkzHxsZYtR2AbFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=xm90h+HIa7Ltu/hPCkDXDB3SCy7idLoBXJXop05pUvFfj+M1iJR07GJmhz99jjPri
	 PbhHVKbgXQKN3QGPe7ZsnzRj8gcwlR7SRrWW13tb5TmRSjd6fVrJfXN7DmfNm707JL
	 YvjiACbOPRDHkXGYQd7B27dDmQg1Gw55EHlD4zwvGJMSmQ5VyIY4eGyzoTIgQ/X/gF
	 DEfDh4PStfw8ipSqQ64CgJhKTbtp/ufoGW8oOkMyKMjeOSCuErU8J2FWZs0mLV0qvD
	 quz/aoVJWuBt3c2cqEWK4KGaeiho70qOl+eOVrb7WCMp6FkOMizFAULrgMhqlRFy4X
	 d0Myd7kgrFsgw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 18DBBA006A;
	Thu,  5 Dec 2024 13:46:08 +0000 (UTC)
Message-ID: <e5238f8d-853a-4822-a384-0a3c929ed591@icloud.com>
Date: Thu, 5 Dec 2024 21:46:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: endpoint: fix bug for an API and simplify
 another API
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>
References: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4dqKGGNDq6xcwg8KrtzYKbxFXSzgBzok
X-Proofpoint-ORIG-GUID: 4dqKGGNDq6xcwg8KrtzYKbxFXSzgBzok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_11,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=749 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412050099

On 2024/11/2 20:20, Zijun Hu wrote:
> This patch series is to fix bug for API devm_pci_epc_destroy()
> and simplify API pci_epc_get().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Correct tile and commit message for patch 1/2.
> - Add one more patch 2/2 to simplify API pci_epc_get().
> - Link to v1: https://lore.kernel.org/r/20241020-pci-epc-core_fix-v1-1-3899705e3537@quicinc.com
> 
> ---
> Zijun Hu (2):
>       PCI: endpoint: Fix that API devm_pci_epc_destroy() fails to destroy the EPC device
>       PCI: endpoint: Simplify API pci_epc_get() implementation
> 

Hi Krzysztof,

could you code review for this patch series ?

>  drivers/pci/endpoint/pci-epc-core.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> ---
> base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
> change-id: 20241020-pci-epc-core_fix-a92512fa9d19
> 
> Best regards,


