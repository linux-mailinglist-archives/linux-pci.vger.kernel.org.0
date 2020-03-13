Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0183018402D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 06:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMFIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 01:08:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42502 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCMFIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 01:08:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D58j6v021163;
        Fri, 13 Mar 2020 00:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584076125;
        bh=/E/5i1Fwav1LiWyY4fZfVtmR3tVhCXpYRpHqTBjFt/0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O9R+xPKtGJqdK87vuIDVqRSh3r/oXBoGFsl6A3KT60JfJNT1KmrFcyvvLnGdheHXs
         75sd+iJC/xkUPZpuztT+x8I4v/Ou+dZWYV1dPnZetfSJNe9DLp8n74k+0P/vfkcsM7
         NfGqVMJb0CSO4U+bHsHqEHKrDfU4vQ4W32wVPodk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D58jxl075424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 00:08:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 00:08:45 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 00:08:44 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D58fNS037401;
        Fri, 13 Mar 2020 00:08:42 -0500
Subject: Re: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
To:     Alan Mikhak <alan.mikhak@sifive.com>
CC:     <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <tjoseph@cadence.com>
References: <20200303103752.13076-1-kishon@ti.com>
 <1583342836-10088-1-git-send-email-alan.mikhak@sifive.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d6f19709-f48c-839a-1323-aaf85e9d56ce@ti.com>
Date:   Fri, 13 Mar 2020 10:43:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583342836-10088-1-git-send-email-alan.mikhak@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 04/03/20 10:57 pm, Alan Mikhak wrote:
> Hi Kishon,
> 
> I applied this v2 patch series to kernel.org linux 5.6-rc3 and
> built for x86_64 Debian and riscv. I verified that when I execute
> the pcitest command on the x86_64 host with -d flag, the riscv
> endpoint performs the transfer by using an available dma channel.

Stephen raised a build error issue [1] after including this series. Did
you also see a similar issue when you tried in x86_64?

[1] -> https://lkml.org/lkml/2020/3/12/1217

Thanks
Kishon

> 
> Regards,
> Alan
> 
> Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
> 
