Return-Path: <linux-pci+bounces-27765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DBBAB7955
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3519F17DEA7
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1B224892;
	Wed, 14 May 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="e5pJzhcV"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host10-snip4-4.eps.apple.com [57.103.64.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EE204F99
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264380; cv=none; b=j9LX75iUd7w3cQLz/m+JszmBpCkiXtMbpye9n4GxFHZ2ZFT+O7ciJSofFodTEC27DshKAY89bLXZKsqPGR7kG52v4LQp04kM6Q1gjDFiMc7n+CzKz3d++nxxn/aXdI2wgyjO8a6xFqn4z30cpBGjX0frzs7KOVp7YMdEEdmzLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264380; c=relaxed/simple;
	bh=5mT+RQkMC8J5+wPg+K0XzcqnqF5PVE9oDpIqPmC9zvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q76tZeYSTUw+OXq/iPZd4RDaXRQsBsNKjE8N25NQRiBeR189dZgYLKU7nlfcC+IYfdXUoAtZEtq7+tvnwe5CMN+jAKXW/p/LuW6k1SSmu0KYXfbLdoBB1VoIQv3PxLPqGUWZr7tbeG5FZba6upowfeO32/ve3V3xXDnqF51+3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=e5pJzhcV; arc=none smtp.client-ip=57.103.64.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=ccwJU/LTdnXEs9iAVCu4zSGeS8J9jkqJWbyKvJzQ6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=e5pJzhcVeETD5S8VCgumVLW/shAHu+rlzp6wqHDJe49W0viMmf80Y0haG1Ei2Gv1I
	 zgsWyq5b/PH9Sy80F5TDF6JP3IL9Ztf/ctZLhUzwQQfR543DjMI6IHZpFX/+xkzP8Q
	 z8FKDdwamLFM9bQ0j6jqGY0qFcyMIy6FzPe84VoXkF4G6e2slyy46MZZjIsD2bLwyw
	 BPut8wr7B7zPxmo7m77RoeQN9wWDvDSXryHBmetXa1wO5dJH3S31w5AY7SCjZrQKjQ
	 ypd7fhQkMAR276OdLXlGOvyCStw1ARh0jc9SY4mihYPN9yE3S2IITCmiUyKVubtq+b
	 wqpvpzjAjMRUw==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 1B4A41800EA2;
	Wed, 14 May 2025 23:12:55 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id AACED1800453;
	Wed, 14 May 2025 23:12:53 +0000 (UTC)
Message-ID: <9302bf79-dd42-4c4f-a521-b25fc94569d4@icloud.com>
Date: Thu, 15 May 2025 07:12:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: of: Fix OF device node refcount leakages
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
References: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JDlOn7mvHZ_8tPmSTVyMKBnbbdILqJtJ
X-Proofpoint-ORIG-GUID: JDlOn7mvHZ_8tPmSTVyMKBnbbdILqJtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505140215

On 2025/4/7 22:14, Zijun Hu wrote:
> This patch series is to fix OF device node refcount leakage for
>  - of_irq_parse_and_map_pci()
>  - of_pci_prop_intr_map()
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (2):
>       PCI: of: Fix OF device node refcount leakage in API of_irq_parse_and_map_pci()
>       PCI: of: Fix OF device node refcount leakages in of_pci_prop_intr_map()

Hi Bjorn,

Not sure if this patch series is still in your review queue.

Also show below mainline fixes for your reference.

962a2805e47b ("of/irq: Fix device node refcount leakage in API
irq_of_parse_and_map()")
ff93e7213d6c ("of/irq: Fix device node refcount leakage in API
of_irq_parse_raw()")


