Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9039A4F3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFCPqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 11:46:34 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4016 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFCPqd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 11:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1622735089; x=1654271089;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cQXeI1iupQ/U08vQCtzUC6FpXzaVzXNRxKeUoPflw3o=;
  b=dWLYgMOQk80dQ4/i8vhYiiav5CVQWMB213bBTFHl5P45Y0qTCII5Q86h
   lR69ue4BpGlXYyLl6g5pDVH/GiLPA9fdStZsn+46E0I5xqgLa/XQ2w/7T
   4IqsRtWQ8GcmJAB7wr6rvhNAOu1PU2fANmQxrzn50PpGLjxJdAcBJ40Mw
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Jun 2021 08:44:49 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jun 2021 08:44:48 -0700
Received: from [10.38.241.122] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Jun
 2021 08:44:47 -0700
Subject: Re: Arm64 double PCI ECAM reservations in acpi_resource_consumer()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <c82b61f5-00d4-182f-2bb7-3518adf2ca75@quicinc.com>
 <CAErSpo4=uspbvScDzfEw+NjsVJKYf6=DyrC=Gasw2Qdt1gwXYg@mail.gmail.com>
 <3a1165b6-033f-33af-fe1f-33a1be4b500a@quicinc.com>
 <20210603141641.GA17284@lpieralisi>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <d3f73fb9-af75-0fdb-fc29-44dc92422c01@quicinc.com>
Date:   Thu, 3 Jun 2021 11:44:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210603141641.GA17284@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2021 10:16 AM, Lorenzo Pieralisi wrote:
> This is not the "reservation". AFAICS acpi_resource_consumer() checks
> whether the ECAM region is part of _a_ given ACPI device _CRS in the
> namespace, it does not "reserve" anything.
> 
> IIUC the issue here is that we request the ECAM region in
> pci_ecam_create() and later the code in:

Okay, I was confused by the code. I thought once acpi_resource_consumer() returned something, it is "reserved".

	adev = acpi_resource_consumer(&cfgres);
	if (adev)
		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
			 dev_name(&adev->dev));
	else
		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
			 &cfgres);

> 
> drivers/pnp/system.c
> 
> tries to request the ECAM region (that lives in the PNP0C02 _CRS) and
> fails (see reserve_range() and request_mem_region()).
> 
> As the comment in reserve_range() goes, this is harmless, not sure
> whether there is anything to do about it.

Actually, the comment said it is "usually harmless", so it is a tricky for an average Joe to figure out if one case falls into the "usual" bracket or not at the first place.
