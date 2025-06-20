Return-Path: <linux-pci+bounces-30270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD75AE1FC8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 18:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAB83A1CC3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA612C375E;
	Fri, 20 Jun 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PtNTfz7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453923ABA9;
	Fri, 20 Jun 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435589; cv=none; b=YySEZY5Rc2L3koVwmOq5/Cxdu/GGvorm0RzS27pP1GAqi6BL1afXoYZKRBrpYuN0peFg1dEpAaanNk36lDTpjPQR4P1oRstpHfFwMnTyHn+RCaKsYEkPSjufxrqZnWMIyuaJwjz1AvrxMHTvKwlmsiMH/0kVVLOuYlAlUlWvE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435589; c=relaxed/simple;
	bh=VDf8Tx4u2oZOok8QIpWYV6V11YnqavI7oZ0JSIwwPhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEv23z9599ncUiIRDP52z3U5jHbomsaP8uBV3pANOIjM6XbyqtAqfqf2LOxMGvSS3wZTCMD+XsfDiv+yJHG8ACCxRy5uXe+V9vRdnugD+rC4sG9YWy7wB48cZ7ycTCaRtKtgCkBYDFXQAW3lUyDsePKBdAXBZotivYpG6YMsV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PtNTfz7a; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=CBio1PPPpJVLzZUll1bxnb1TdvQipCHJF9EEAuawoOM=;
	b=PtNTfz7a6ceuzdIcvnaAMubBkFiQ2u9g5aqYZvwhQPvpte9cnGJUG2Pz52GtgB
	F3jFPwXAiyzEVbUeKQVIlPtExfcttXfJ/T/HKTmFvImpgC29ZL3sMV1NpmDCQPtM
	5DdEajKEoGL531e8baDlyvxpAJvlMHLl5rtp/qePJ/1a0=
Received: from [IPV6:240e:b8f:919b:3100:8440:da7c:be7e:927f] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnz_PXhlVoLljeAg--.60205S2;
	Sat, 21 Jun 2025 00:05:44 +0800 (CST)
Message-ID: <e9eeeeb4-77e6-48f1-bedc-15207f39d7b6@163.com>
Date: Sat, 21 Jun 2025 00:05:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250620155507.1022099-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250620155507.1022099-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz_PXhlVoLljeAg--.60205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4fCw13Kr45XFW3trWDArb_yoW5JF4fpF
	WfGws3Ar4xJF15GF9rWa1vkFyrZas7KrWUGrZrJ3sxZanxZFyUXF1xKw4rA347XrWxZ3WI
	gF1jqFy8uan8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7pnQUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxlyo2hVgqSAEAAAsY

Hi all，

I'm very sorry. I forgot the review label of Niklas. If it can be 
merged, please ask the maintainer to help add this tag. Thank you very much.

Reviewed-by: Niklas Cassel <cassel@kernel.org>

Best regards,
Hans

On 2025/6/20 23:55, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.
> 
> This patch series addresses this by:
> 
> 1.  Core PCI enhancement (Patch 1):
> - Proactively configures Root Port MPS during host controller probing
> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> - Preserves standard MPS negotiation during downstream enumeration
> 
> 2.  Driver cleanup (Patch 2):
> - Removes redundant MPS configuration from Meson PCIe controller driver
> - Functionality is now centralized in PCI core
> - Simplifies driver maintenance long-term
> 
> ---
> Changes for v5:
> - Use pcie_set_mps directly instead of pcie_write_mps.
> - The patch 1 commit message were modified.
> 
> Changes for v4:
> - The patch [v4 1/2] add a comment to explain why it was done this way.
> - The patch [v4 2/2] have not been modified.
> - Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
>    that this patch cannot be submitted. In addition, Mani also suggests
>    dropping this patch until this series of issues is resolved.
> 
> Changes for v3:
> - The new split is patch 2/3 and 3/3.
> - Modify the patch 1/3 according to Niklas' suggestion.
> 
> Changes for v2:
> - According to the Maintainer's suggestion, limit the setting of MPS
>    changes to platforms with controller drivers.
> - Delete the MPS code set by the SOC manufacturer.
> ---
> 
> Hans Zhang (2):
>    PCI: Configure root port MPS during host probing
>    PCI: dwc: Remove redundant MPS configuration
> 
>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>   drivers/pci/probe.c                    | 10 ++++++++++
>   2 files changed, 10 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494


