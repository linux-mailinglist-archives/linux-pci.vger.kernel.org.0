Return-Path: <linux-pci+bounces-8768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E74907EC9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A14B20E4B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36C1411C9;
	Thu, 13 Jun 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRspgFZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141881AB5;
	Thu, 13 Jun 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317346; cv=none; b=eIP9RIUMhWtaY+MdNzZWUXTVR5k1Gkba8cRNim+N10UXogS9X3K+NwNOIEJCm/wbbklR7LuoARUJGQQqAVoRY6YwR27HKRCmh1v8JA5heLnBRR2ohy8F1Z14GYQWlLLnbH+lDDN7nxXqGbIJ0OkH7nB14fOC7/xGaw6r4RDFkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317346; c=relaxed/simple;
	bh=yrsTBDdZ0M2Q9CblPLzObLHpud+W9IGBEd20aWUS/1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hYHWUCY+O5VS2i3P/UTDv2lQeaIh+GXcV4f2td4gmMo7u3lDvHlaxCwENXgOdrsBuqVvMuUybgbYvDdW+YelPbu5BtaiOSoC3JvrTwWSj+3sRTS6l7V4KFwE86bdZDzcRBEnJ+Jv0mDpF9aDReQoXS4NKRzE3+Yi8+UJparvHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GRspgFZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGTPT003256;
	Thu, 13 Jun 2024 22:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dY8ZF0i0W0qR2TSW6SzCbIRLSn7l8fK0lhX2BKNSKOo=; b=GRspgFZGqPVWiodC
	AAmie/Ai/S3rFjZY6svBjxOgrHD/8xaGm+GjGHjUZ2JrC1FjPwszoSnru5LVMPRY
	WRSRpfl1yjJdUb+jov0MJiBc0Twun0lvr0Xc5eshuoSnvqbZ2TcjQ7ieiE+xu/tH
	axPsllc1lstKEXu655JxlAlxscPU3OtvDZJdw1xPU6HxTx6xHOMOb5hciuojpZOf
	SZEmq75QLsgxpDd6CEIBKYw/BuXNQTIROv/Vt5WJux+CHSA/tVCZeiXlM4Y2+JJz
	t6+hRdY//wjW8U7aQHNn8Afwd1ma/o+jnDQxva7G51Mh9ZExcaNHqbNiQupBxwOe
	KqXCjQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q4gdv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 22:22:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DMMIa6031947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 22:22:18 GMT
Received: from [10.48.243.167] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 15:22:11 -0700
Message-ID: <2e88d9df-f786-4405-af8f-02123d8a3119@quicinc.com>
Date: Thu, 13 Jun 2024 15:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240613222032.GA1087213@bhelgaas>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240613222032.GA1087213@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S84kOPCh9aRJHY1G5saZqaTsUX_6dNqO
X-Proofpoint-GUID: S84kOPCh9aRJHY1G5saZqaTsUX_6dNqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130160

On 6/13/2024 3:20 PM, Bjorn Helgaas wrote:
> On Mon, Jun 10, 2024 at 06:21:16PM -0700, Jeff Johnson wrote:
>> When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-stub.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-pf-stub.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Applied to pci/misc for v6.11, with updates to the text:

thanks for the cleanups!

/jeff


