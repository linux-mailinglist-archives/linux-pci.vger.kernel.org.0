Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9342E767
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 05:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhJODuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 23:50:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59138 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhJODuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 23:50:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19F3mdAA008260;
        Thu, 14 Oct 2021 22:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634269719;
        bh=H3I1bD6xoXI477wmQLpoUbNtYwPE9iQ4wnhQmT5KXnw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CGnbgEX/A4rbkXQYDoMXUgPwxI/GuGDkN/ysmkKKG8ad57xL5ZjzG/Q9PbpCEewht
         pPKT5tJNzIFc96mATmSxjPssC779iH8oALXGBG9Bx53jZY80ZDWmZh3uCdcrDPSiv5
         8n8DqC5reT4tguR6yeq4uOrBxX2CqtoqzBrBnqRw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19F3md50034446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Oct 2021 22:48:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Oct 2021 22:48:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Oct 2021 22:48:39 -0500
Received: from [10.250.232.218] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19F3ma0J052861;
        Thu, 14 Oct 2021 22:48:37 -0500
Subject: Re: [PATCH] MAINTAINERS: Update information related to the PCI
 sub-system
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
References: <20211015010742.1236057-1-kw@linux.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bca28eab-569b-b657-691b-cba023f99f33@ti.com>
Date:   Fri, 15 Oct 2021 09:18:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211015010742.1236057-1-kw@linux.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 15/10/21 6:37 am, Krzysztof Wilczyński wrote:
> Update the following information related to the PCI sub-system which
> includes the PCI drivers, PCI native host bridge and end-point drivers,
> and the PCI end-point sub-system.
> 
>  - Sort fields as per preferred order
>  - Sort files in the alphabetical order
>  - Update old Patchwork URLs
>  - Add Bugzilla link
>  - Add link to the official IRC channel
>  - Add file "drivers/pci/pci-bridge-emul.c" to the right section
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  MAINTAINERS | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 703aa3150a15..454303f95132 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14446,9 +14446,12 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git

This repo is not actually used for PCI endpoint. Lorenzo's tree should be
included here.

Thanks,
Kishon

>  F:	Documentation/PCI/endpoint/*
>  F:	Documentation/misc-devices/pci-endpoint-test.rst
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	drivers/pci/endpoint/
>  F:	tools/pci/
> @@ -14494,15 +14497,20 @@ R:	Rob Herring <robh@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>  F:	drivers/pci/controller/
> +F:	drivers/pci/pci-bridge-emul.c
>  
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  F:	Documentation/PCI/
>  F:	Documentation/devicetree/bindings/pci/
> 
